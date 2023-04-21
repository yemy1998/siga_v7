

    let tipoPersona = "";
    let naturalizaAnticipo = document.querySelector("#naturalizaAnticipo");
    let personaAutoComplete = document.querySelector("#actor_complete");
    let personaId = document.querySelector("#actor_id");
    let formAnticipo = document.querySelector("#form_anticipos");
    let btnGuardar = document.querySelector("#guardarAnticipos");


   $(document).ready(function () {

        $(".input-datepicker").datepicker({
         format: 'dd-mm-yyyy'
        });

        triggerFotoUploadEvent()

    });
 
    function verificarDeuda(){

        return new Promise((resolve, reject) => {

            let idAnticipo = document.querySelector("#id_anticipo").value;
            let actorId = document.querySelector("#actor_id").value;
            let naturalizaAnticipo = document.querySelector("#naturalizaAnticipo").value;

            if (idAnticipo == 0 && naturalizaAnticipo == 1) {

                $.ajax({
                    url: `${url}anticipos/verificarDuedas`,
                    data: {idCliente: actorId},
                    type: 'POST',
                    dataType:'JSON',
                    success: function(data) {

                      if(data.deuda != null && data.deuda > 0 ){

                         var growlType = 'danger'
                          $.bootstrapGrowl(`<h4> El cliente tiene deudas registradas por un monto de ${data.deuda}</h4>`, {
                            type: growlType,
                            delay: 2500,
                            allow_dismiss: true
                          })
                        
                        resolve(true)

                      }else {

                        resolve(false)

                      }

                    },
                    error: function() {
                      $.bootstrapGrowl('<h4>Error.</h4> <p>Ha ocurrido un error en la operaci&oacute;n</p>', {
                        type: 'danger',
                        delay: 5000,
                        allow_dismiss: true,
                      });
                     
                      reject()
                    },
                });

            }else {
                resolve(false)
            }

        
        })

       

         
    }

    personaAutoComplete.addEventListener("blur",() =>{

        verificarDeuda()

    })
    
    naturalizaAnticipo.addEventListener("change", (e)=>{
        /*Reset Values*/
        personaAutoComplete.value = "";
        personaId.options[0] = new Option;

        if ( $(e.target).val() == "2" ) {// proveedores
            $("#cuentaDestino").parent(".form-group").removeClass("hidden");
            $("#numeroOperacion").parent(".form-group").removeClass("hidden");
        } else {
            $("#cuentaDestino").parent(".form-group").addClass("hidden");
            $("#numeroOperacion").parent(".form-group").addClass("hidden");
        }
    }) 

    $('#actor_complete').autocomplete({
        autoFocus: true,
        source: function(request, response) {
            let metodo = "";
            switch (naturalizaAnticipo.value) {
                case "1":
                    metodo = 'venta_new/get_clientes_json'
                break;

                case "2":
                    metodo = 'proveedor/get_proveedor_json'
                break;
                default:
                    console.error('Metodo de persona no registrado')
                break;
            }

            $.ajax({
                url: url + metodo,
                dataType: 'json',
                data: {
                    term: request.term,
                },
                success: function(data) {
                    response(data);
                },
            });
        },
        minLength: 2,
        response: function(event, ui) {

            if (ui.content.length == 1) {

                let [content] = ui.content;

                $(this).val(content.value);
                $(this).autocomplete('close');
                content.email = content.email??"";
                var actor_id = $('#actor_id');
                var template = `<option 
                    value=${content.id}
                    data-identificacion=${content.identificacion} 
                    data-email=${content.email}>${content.value}</option>`;

                actor_id.html(template);
                actor_id.trigger('change');
            }

        },
        select: function(event, ui) {

            var actor_id = $('#actor_id');
            ui.item.email = ui.item.email??"";
            var template = `<option 
            value=${ui.item.id} 
            data-identificacion=${ui.item.identificacion} 
            data-email=${ui.item.email}>${ui.item.value}</option>`;

            actor_id.html(template);
            actor_id.trigger('change');

        },
    }).autocomplete('instance')._renderItem = function(ul, item) {
        return $('<li>').
        append(`<div>${item.label}<br><span style=font-size: 10px;>${item.desc}</span></div>`).
        appendTo(ul);
    };

      $('#actor_complete').on('focus', function() {
        
        $(this).select();
    });


    /*----------Metodo de Pago------------------*/
$(document).ready(function () {

    setTimeout(function () {
        $(".select_chosen").chosen();
        $('#filter_local_id').trigger('change');
        $('#tipo_moneda').trigger('change');
    }, 500);

    $('#filter_local_id').on('change', function () {
        show_cuentas_by_local($(this).val());
    });

    $('#cuenta_id').on('change', function () {
        show_medio_pago_by_cuenta($(this).find(':selected').attr('data-tipo'))
        $('#tipo_moneda').val($(this).find(':selected').attr('data-moneda-id'));
        $('#tipo_moneda').trigger("change");
    });

    function show_medio_pago_by_cuenta(tipo) {
        let metodo_pago = $('#metodo_pago');
        metodo_pago.html("");
        let medios_pago_template = $(".template-form #metodo_pago_template option");
        medios_pago_template.each( (i,e) => {
            let value = $(e).attr("value");
            let data_metodo = $(e).attr("data-metodo");
            if ( value=="" ||  data_metodo==tipo || data_metodo=="ALL") {
                metodo_pago.append($(e).clone());
            }
        })
        metodo_pago.chosen('destroy');
        metodo_pago.chosen();
    }

    function show_cuentas_by_local ( id_local ) {
        let template_options_cuentas = $(".template-form #cuentas_all_template");
        let select_cuentas = $('#cuenta_id');
        let curr_cuenta = $('#cuenta_id').val();
        all_options = template_options_cuentas.find("option");
        
        select_cuentas.html("");
        local_cuentas = all_options.each( (i,e) => {
            let value = $(e).attr("value");
            let local_id = $(e).attr("data-local-id");
            let banco_id = $(e).attr("data-banco-id");
            
            if ( value=="" || (local_id == id_local) || (banco_id != "") ) {
                select_cuentas.append($(e).clone());
            }
        })
        select_cuentas.chosen('destroy');
        select_cuentas.chosen();
    }

    $('#tipo_moneda').on('change', function () {
        $('#tipo_moneda').chosen('destroy');
        $('.simboloMoneda').text($(this).find(':selected').data('moneda'));
    });

});

/*---------- ENDMetodo de Pago------------------*/

btnGuardar.addEventListener("click", function guardar(e) {
    e.preventDefault();

    let formData = new FormData(formAnticipo);

    if(validateFormData(formData))
        return false;

    $('#loading_anticipo').modal('show');

    verificarDeuda()
    .then(res => {

        let imgToUpload  = getImgToUpload();

        formData.append(`${imgToUpload.name}`, imgToUpload.urlImg);

        formData.append("adjuntosName",getNameInputToUpload());

        let images_to_delete = getImagesToDelete();
        formData.append("images_to_delete", JSON.stringify(images_to_delete));
        
        $.ajax({
                url: `${url}anticipos/guardar`,
                data: formData,
                type: 'POST',
                dataType:'JSON',
                processData: false,
                contentType: false,
                cache: false,
                enctype: 'multipart/form-data',
                success: function(data) {

                 $('#loading_anticipo').modal('hide');

                  if(data.result == 1){

                      var growlType = 'success'
                      $.bootstrapGrowl('<h4>' + data.msg + '</h4>', {
                        type: growlType,
                        delay: 2500,
                        allow_dismiss: true
                      })

                      setTimeout(function() {
                        loadContent($("#base_url").val()+"anticipos");
                      },1000);
                    

                  }else {
                      var growlType = 'danger'
                      $.bootstrapGrowl('<h4>' + data.msg + '</h4>', {
                        type: growlType,
                        delay: 2500,
                        allow_dismiss: true
                      })
                  }
                 
                },
                error: function() {
                  $.bootstrapGrowl('<h4>Error.</h4> <p>Ha ocurrido un error en la operaci&oacute;n</p>', {
                    type: 'danger',
                    delay: 5000,
                    allow_dismiss: true,
                  });
                  $('#historial_list').html('');
                },
            });
       
    

    })
    .catch()


    
})

/*-----------Validate formData---------------*/

function validateFormData(formData){

    let alerta = false;

    for (var field of formData) {

        let name = field[0];
        let value = field[1];
        let input = "";

        input = document.querySelector(`#${name}`);

        let divCuenta = document.querySelector("#discuenta").style.display;
        let divMetodoPago = document.querySelector("#dispago").style.display;

        if(input.getAttribute("required") != null){

            if(value.trim() == "" || value == 0){

                if(name == "cuenta_id" && divCuenta != "none"){
                
                    alerta = true;

                    printIndicatorInputSelectFormData(input, name)
                }


                if(name == "metodo_pago" && divMetodoPago != "none"){
                    
                    alerta = true;
                    
                    printIndicatorInputSelectFormData(input, name)
                }


                if (name != "metodo_pago" && name != "cuenta_id" ) {

                     alerta = true;

                    /*Esto Varia según la vista, ya que es como se mostrara la adveretencia*/

                    if(input.id == "actor_id"){

                       let autoComplete = document.querySelector("#actor_complete")
                       autoComplete.style.cssText = 'border-color:red !important';
                       setTimeout(function(){ autoComplete.style.cssText = ''; }, 8000);


                    }

                    printIndicatorInputSelectFormData(input, name)

                }

            }
        }
    }

    if(alerta == true){
        $.bootstrapGrowl('<h4>Campos Requeridos.</h4><p>Debe Completar los campos indicados</p>', {
            type: 'warning',
            delay: 5000,
            allow_dismiss: true,
          });
    }

    return alerta;
}


function printIndicatorInputSelectFormData(input, name){

    let selectChosenFilter = input.className.search(/select_chosen/);

    if(selectChosenFilter != -1 || name == "tipo_moneda"){

        let selecChosenInput = document.querySelector(`#${name}_chosen > .chosen-single`);

        selecChosenInput.style.cssText = 'border-color:red !important';
        setTimeout(function(){ selecChosenInput.style.cssText = ''; }, 8000);

    } else {
        
        input.classList.add("required-input")
        setTimeout(function(){ input.classList.remove("required-input") }, 8000);

    }
}

/*-----------ENDValidate formData---------------*/


function setDataEdit(dataEdit) {

    $('#filter_local_id').val(dataEdit.idLocal);
    $('#filter_local_id').trigger("chosen:updated");


    document.querySelector('#id_anticipo').value = dataEdit.id;
    document.querySelector('#naturalizaAnticipo').value = dataEdit.naturalizaAnticipo;


    
    $('#actor_complete').val(`${dataEdit.actor.idNumber} ${dataEdit.actor.name}`)
    setTimeout(function() {
        $('#actor_complete').trigger( "keydown" )
    }, 1000);



    setTimeout(function() {
        $('#cuenta_id').val(dataEdit.idCuentaAfectada);
        $('#cuenta_id').trigger("change");
        $('#cuenta_id').trigger("chosen:updated");
        setTimeout(function() {
            $('#tipo_moneda').val(dataEdit.idMoneda);
            $('#tipo_moneda').trigger("chosen:updated");

            $('#metodo_pago').val(dataEdit.metodoPago);
            $('#metodo_pago').trigger("chosen:updated");
        }, 500);
    }, 500);
    


    let date = new Date(dataEdit.fechaEntregaAnticipo);
    let fechaEntregaAnticipo = date.toLocaleDateString('en-GB').replace(/[/]/g,"-");
    $('#fechaEntregaAnticipo').val(fechaEntregaAnticipo);

    document.querySelector('#numeroOperacion').value = dataEdit.numeroOperacion;
    document.querySelector('#cuentaDestino').value = dataEdit.cuentaDestino;


    $('#descripcion').val(dataEdit.descripcionMotivoAnticipo);
    $('#importe').val(dataEdit.importeAnticipo);


    let select = document.querySelector("#tipo_moneda");
    let monedaSimbolo = select.options[select.selectedIndex].getAttribute("data-moneda")

    let simboloMoneda = document.querySelectorAll(".simboloMoneda");

    for (let simbolo of simboloMoneda) {
   
        simbolo.innerText = monedaSimbolo;
    }
   
    // revisar cuando se vuelve a guardar s evuelve a borrar imagen

    setImgView(dataEdit)

}