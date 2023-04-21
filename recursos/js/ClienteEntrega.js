
const btnSaveClienteEntrega  = document.querySelector("#btnSaveClienteEntrega");
const nombreClienteEntrega   = document.querySelector("#nombreClienteEntrega");
const doc_clienteEntrega     = document.querySelector("#doc_clienteEntrega");
const identificacion_cliente = document.querySelector("#identificacion_cliente");
const personaEntrega         = document.querySelector("#personaEntrega");

const clienteEntregaNombre    = document.querySelector("#clienteEntregaNombre");
const clienteEntregaNumero    = document.querySelector("#clienteEntregaNumero");
const clienteEntregaTipoDoc   = document.querySelector("#clienteEntregaTipoDoc");

$( document ).ready(function() {
     let tipo_doc_dni = new DocumentoPersona({
        tipo_doc_element: $('#doc_clienteEntrega'),
        nro_doc_element: $("#identificacion_cliente"),
        success_function: setDatosPersona,
        error_function: errorPetition,
        elemento_tipo_doc: "select",
        attr_data_api: "data-api",
    });

});


function validateLimitCharacter(obj) {
  let currentLimit = obj.maxLength;
  let strValue = obj.value.length;

  if (strValue > currentLimit) {
    $.bootstrapGrowl('Ha sobrepasado la longitud de caracteres del documento, se ha ajustado el valor.', {
      type: 'warning',
      delay: 5000,
      allow_dismiss: true,
    });
    obj.value = obj.value.substring(0, currentLimit);
  }
}

function setDatosPersona(tipo_doc, datos_pers){

    $("#identificacion_cliente").removeClass('errorAPI');

    if ( datos_pers.paterno != null && datos_pers.materno != null )
        $('#nombreClienteEntrega').val(`${datos_pers.nombre} ${datos_pers.paterno} ${datos_pers.materno}`);


    $('div.modaloader').removeClass('see');
}

function errorPetition(tipo_doc, response){

    $("#identificacion_cliente").addClass('errorAPI');
    $('#nombreClienteEntrega').val('');
    mensaje("warning", response.notification);
    $('div.modaloader').removeClass('see');
}


btnSaveClienteEntrega.addEventListener("click", function() {

    if (nombreClienteEntrega.value == ''){
         mensaje("warning", 'Debe ingresar los datos para poder guardar');
         return;
    }
    setDataClienteEntrega();
    limpiarFormClienteEntrega();
    
})

function limpiarFormClienteEntrega() {
    $('#personaEntrega_modal').modal('hide')
    doc_clienteEntrega.value     = 1;
    identificacion_cliente.value = '';
    nombreClienteEntrega.value   = '';
}


function setDataClienteEntrega() {
    personaEntrega.innerHTML     = `<option value="">${nombreClienteEntrega.value}</option>`;
    clienteEntregaNombre.value    = nombreClienteEntrega.value;
    clienteEntregaNumero.value    = identificacion_cliente.value;
    clienteEntregaTipoDoc.value = doc_clienteEntrega.value;
}