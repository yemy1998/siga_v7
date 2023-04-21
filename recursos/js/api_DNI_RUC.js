/* NUEVO LIBRERIA DE SERVICIO RUC&DNI*/

function DocumentoPersona(config) {
    // initializing numbers
    let self = this;

    self.error_status = 'error';

    self.DNI_VALUE = 1;
    self.CARNETEXT_VALUE = 2;
    self.RUC_VALUE = 3;
    self.PASSAPORTE_VALUE = 4;
    self.PASAPORTENAC_VALUE = 5;
    self.OTROS_VALUE = 6;

    self.maxLength = {};
    self.maxLength[self.DNI_VALUE] = 8;
    self.maxLength[self.CARNETEXT_VALUE] = 12;
    self.maxLength[self.RUC_VALUE] = 11;
    self.maxLength[self.PASSAPORTE_VALUE] = 12;
    self.maxLength[self.PASAPORTENAC_VALUE] = 15;
    self.maxLength[self.OTROS_VALUE] = 15;

    self.justNumbers = {};
    self.justNumbers[self.DNI_VALUE] = true;
    self.justNumbers[self.CARNETEXT_VALUE] = true;
    self.justNumbers[self.RUC_VALUE] = true;
    self.justNumbers[self.PASSAPORTE_VALUE] = true;
    self.justNumbers[self.PASAPORTENAC_VALUE] = true;
    self.justNumbers[self.OTROS_VALUE] = false;
    self.patternJustDigits = /^\d+$/;

    if (config.tipo_doc_element)
        self.tipo_doc_element = config.tipo_doc_element;
    else
        self.tipo_doc_value = config.tipo_doc_value;
    self.nro_doc_element = config.nro_doc_element;
    
    self.elemento_tipo_doc = config.elemento_tipo_doc;
    self.attr_data_api = config.attr_data_api ? config.attr_data_api : "data-api"; // por defecto

    self.success_function = config.success_function;
    self.error_function = config.error_function;
    self.firstTime = true;

    if (config.beforeSend) {
        self.beforeSend = config.beforeSend;
    }

    // initializing events
    if (self.tipo_doc_element)
        self.tipo_doc_element.change(function() {
            self.buscarDocumento();
        });
    self.nro_doc_element.keyup(function() {
        self.buscarDocumento();
    });
    self.nro_doc_element.bind("paste", function(e) {
        var pastedData = e.originalEvent.clipboardData.getData('text');
        self.nro_doc_element.val(pastedData);
        self.nro_doc_element.trigger("keyup");
    });
}

DocumentoPersona.prototype.get_state_api = function() {
    let self = this;
    let is_using_api = true;
    if( self.elemento_tipo_doc === "select" ){
        let option_selected = self.tipo_doc_element.find(`option[value=${self.tipo_doc_value}][${self.attr_data_api}]`);
        if( option_selected.length>0 ){
            is_using_api = $(option_selected[0]).attr(self.attr_data_api) != 0;
        }
    } else if( self.elemento_tipo_doc === "input" ){
        is_using_api = self.nro_doc_element.attr(self.attr_data_api) != 0;
    }
    return is_using_api;
}

DocumentoPersona.prototype.buscarDocumento = function() {
    let self = this;
    if (self.status !== self.error_status && self.nro_doc_value == self.nro_doc_element.val()) {
        return;
    }

    if (self.tipo_doc_element){
        self.tipo_doc_value = self.tipo_doc_element.val();
    }

    self.nro_doc_element.attr("maxlength", self.maxLength[self.tipo_doc_value]);
    // self.nro_doc_element.attr("type", ((self.justNumbers[self.tipo_doc_value]==true)?"number":"text") );
    if (self.maxLength[self.tipo_doc_value] != self.nro_doc_element.val().length) { // NUMERO DE CARACTERES DIFERENTE AL PERMITIDO
        return;
    }
    if (self.tipo_doc_value == self.DNI_VALUE || self.tipo_doc_value == self.RUC_VALUE) {
        if (!self.patternJustDigits.test(self.nro_doc_element.val())) {
            mensaje('warning', 'El valor solo debe contener dígitos del 0 al 9, si es DNI/RUC.');
            return;
        }
    }
    self.nro_doc_value = self.nro_doc_element.val();

    if( self.get_state_api() === false ){
        return;
    } else if (self.tipo_doc_value == self.DNI_VALUE) {
        self.buscarDNI();
    } else if (self.tipo_doc_value == self.RUC_VALUE) {
        self.buscarRUC();
    }
}

DocumentoPersona.prototype.buscarDNI = function() {
    let self = this;
    self.data_response = {};
    var formData = new FormData();
    formData.append('dni', self.nro_doc_value);
    $.ajax({
        url: `${ruta}cliente/getDNI_New`,
        type: 'POST',
        data: formData,
        cache: false,
        contentType: false,
        processData: false,
        beforeSend: function() {
            self.beforeSend();
        },
        success: function(data) {
            var obj = $.parseJSON(data);

            console.log(obj)
            if (obj == false) {
                self.error_function('dni', {
                    notification: "DNI no encontrado, verifique que esté escrito correctamente."
                });
                self.status = 'not_found';
            } else {
                self.data_response.nombre = obj['3'];
                self.data_response.paterno = obj['1'];
                self.data_response.materno = obj['2'];
                self.success_function('dni', self.data_response);
                self.status = 'success';
            }
            self.finaliza();
        },
        error: function(data) {
            if (status == 'timeout') {
                mensaje('warning', 'El proveedor de los datos SUNAT y RENIEC no estan disponibles, continue registrando los datos de manera manual');
            } else {
                mensaje('warning', 'No existe el RUC');
            }
            self.status = self.error_status;
            self.finaliza();
        }
    });
}

DocumentoPersona.prototype.buscarRUC = function() {
    let self = this;
    self.data_response = {};
    var formData = new FormData();
    formData.append('RUC', self.nro_doc_value);
    $.ajax({
        url: `${ruta}cliente/getDatosFromAPI_Sunac_new`,
        type: 'POST',
        data: formData,
        cache: false,
        contentType: false,
        processData: false,
        beforeSend: function() {
            self.beforeSend();
        },
        success: function(data) {
            self.data_response = $.parseJSON(data);
            if (self.data_response == false) {
                self.error_function('ruc');
                self.status = 'not_found';
            } else {
                self.success_function('ruc', self.data_response);
                self.status = 'success';
            }
            self.finaliza();
        },
        error: function(request, status, err) {
            if (status == 'timeout') {
                mensaje('warning', 'El proveedor de los datos SUNAT y RENIEC no estan disponibles, continue registrando los datos de manera manual');
            } else {
                mensaje('warning', 'No existe el RUC');
            }
            self.status = self.error_status;
            self.finaliza();
        }
    });
}

DocumentoPersona.prototype.beforeSend = function() {

    console.log(this)
    let parent_group = this.nro_doc_element.parent();
    if (parent_group.hasClass("input-loader")) {
        parent_group.find("div").addClass("loading");
    }
}

DocumentoPersona.prototype.finaliza = function() {
    let parent_group = this.nro_doc_element.parent();
    if (parent_group.hasClass("input-loader")) {
        parent_group.find("div").removeClass("loading");
    }
}