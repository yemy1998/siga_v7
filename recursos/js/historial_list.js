$(function() {
  TablesDatatables.init(1);
  $('#dialog_cotizar_detalle').on('hide.bs.modal', function() {
    get_cotizaciones();
  });
});

function cotizar(id) {
  $('#dialog_cotizar_detalle').html($('#loading').html());
  $('#dialog_cotizar_detalle').modal('show');
 
  
  $.ajax({
    url: ruta + 'cotizar/get_cotizar_validar/',
    type: 'POST',
    data: {'id': id},

    success: function(data) {
      $('#dialog_cotizar_detalle').html(data);
    },
    error: function() {
      alert('Error inesperado');
    },
  });
  
}

function ver(id) {
  $('#dialog_cotizar_detalle').html($('#loading').html());
  $('#dialog_cotizar_detalle').modal('show');

  $.ajax({
    url: ruta + 'cotizar/get_cotizar_detalle/',
    type: 'POST',
    data: {'id': id},

    success: function(data) {
      $('#dialog_cotizar_detalle').html(data);
    },
    error: function() {
      alert('Error inesperado');
    },
  });
}

function guia_remision_modal(id, tipo){
  $('#dialog_cotizar_remision').html($('#loading').html());
  $('#dialog_cotizar_remision').modal('show');

  $.ajax({
    url: ruta + 'guia_remision/get_cotizar_remision_validar/',
    type: 'POST',
    data: { id, tipo},

    success: function(data) {
      $('#dialog_cotizar_remision').html(data);
    },
    error: function() {
      alert('Error inesperado');
    },
  });
}



// Guia de remision
function guia_remision(id_remision) {
   var date_range = $("#date_range").val()
   var local_id = $("#local_id").val();

    $('#barloadermodal').modal('show');
        $.ajax({
            url: ruta + 'guia_remision/index/cotizacion/' + id_remision,
            data:{'data_range':date_range,
                  'local_id':local_id},
            method:'POST',
            success: function (data) {
              $('#page-content').html(data);
              $('#barloadermodal').modal('hide');
              $(".modal-backdrop").remove();
            } 
    });
}


function guia_remision_edit(cotizacion,id_remision) {

   var historial_list = $("#case_remision_list").val();
   var page_type  = $("#condicion_pago_id").val();
   var moneda_type = $("#moneda_id").val();
   var document_type = $("#documento_id").val();
   var date_range = $("#date_range").val();
   var local_id   = $("#venta_local").val();

    $('#barloadermodal').modal('show');
        $.ajax({
            url: ruta + 'guia_remision/index/cotizacion/'+ cotizacion +'/'+ id_remision,
            data:{
                  'historial_list':historial_list,
                  'data_range':date_range,
                  'page_type':page_type,
                  'document_type':document_type,
                  'moneda_id':moneda_type,
                  'local_id':local_id},
            method:'POST',
            success: function (data) {
              $('#page-content').html(data);
              $('#barloadermodal').modal('hide');
              $(".modal-backdrop").remove();
            } 
    });
}


function ver_remision(id,id_remision, tipo_operacion){
  $('#dialog_cotizar_remision').html($('#loading').html());
  $('#dialog_cotizar_remision').modal('show');
   $.ajax({
            url: ruta + 'guia_remision/info_guia_remision/',
            'type':'POST',
            data: {'id':id,'id_remision':id_remision,'tipo_operacion': tipo_operacion},
            success: function (data) {
              $('#dialog_cotizar_remision').html(data);
            } 
    });


}



function exportar_pdf(id, tp) {
  var win = window.open(ruta + 'cotizar/exportar_pdf/' + id + '/' + tp,
      '_blank');
  win.focus();
}

function exportar_remision(cotizacion_id, remision_id, tipo, status){
  if(status != 1 && status != 2 ){ // 1-> sellado ; 2 -> anulado
    mensaje('info', '<p>Solo las guías SELLADAS/ANULADAS pueden imprimirse.</p>');
    return;
  }

  let w = window.open(`${ruta}guia_remision/exportar/${cotizacion_id}/${remision_id}/${tipo}`, '_blank');
      w.focus();
}

function imprimir_ticket(id, tp) {
  $.bootstrapGrowl('<p>IMPRIMIENDO PEDIDO</p>', {
    type: 'success',
    delay: 2500,
    allow_dismiss: true,
  });

  var url = ruta + 'cotizar/imprimir_ticket/' + id + '/' + tp;
  $('#imprimir_frame').attr('src', url);
}

function anular(id) {
  if (!window.confirm('Estas seguro de eliminar esta cotizacion'))
    return false;

  $('#confirm_venta_text').html($('#loading').html());

  $.ajax({
    url: ruta + 'cotizar/eliminar',
    type: 'POST',
    data: {'id': id},

    success: function(data) {
      $.bootstrapGrowl(
          '<h4>Correcto.</h4> <p>Cotizacion anulada con exito.</p>', {
            type: 'success',
            delay: 5000,
            allow_dismiss: true,
          });
      get_cotizaciones();
    },
    error: function() {
      alert('Error inesperado');
    },
  });
}

function enviar_correo(idCotizacion, tipo_cliente) {
  $('#correoModal').html($('#loading').html());
  $('#correoModal').
      load(ruta + 'cotizar/modalEnviarCotizacion/' + idCotizacion + '/' +
          tipo_cliente);
  $('#correoModal').modal('show');
}

function whatsApp() {
  mensaje('warning',
      '<h4>Opci&oacute;n no disponible para esta versi&oacute;n</h4>');
}

function messenger() {
  mensaje('warning',
      '<h4>Opci&oacute;n no disponible para esta versi&oacute;n</h4>');
}


function sellar_remision_list(id){

  $('#confirm_remision_text').
      html(
          'Está por sellar esta guia de remision. Estas seguro?');
  $('#confirm_remision_button').attr('onclick', `aprobar_remision_list(${id});`);
  $('#dialog_remision_confirm').modal('show');
}

 function aprobar_remision_list(id){
    var local_id = null;
    $('#dialog_remision_confirm').html($('#loading').html());

    $.ajax({
      url: ruta + 'guia_remision/sellar',
      type: 'POST',
      data: { id, local_id },
      success: function(data) {
            if (data.success == 1) {
                $.bootstrapGrowl(`<h4>${data.msg}</h4>`, {
                  type: 'success',
                  delay: 2500,
                  allow_dismiss: true,
                });
             
            }else{
              $.bootstrapGrowl('<h4>' + data.msg + '</h4>', {
                type: 'warning',
                delay: 2500,
                allow_dismiss: true,
              });
            }
         $('#dialog_remision_confirm').modal('hide');
         setTimeout(() => { get_remision_lis() }, 1000);
        
      },
      error: function() {
        alert('Error inesperado');
      },
    });
    
  }


  function get_remision_lis(){
    var moneda_id = $('#moneda_id').val();
    $.ajax({
      url: ruta + 'guia_remision/get_guia_remision_list',
      type: 'POST',
      data: { 'moneda_id': moneda_id },
      success: function(data) {
          $("#historial_list").html('');
          $("#historial_list").html(data);
        
      },
      error: function() {
          $.bootstrapGrowl('<h4>Error.</h4> <p>Ha ocurrido un error en la operaci&oacute;n</p>', {
              type: 'danger',
              delay: 5000,
              allow_dismiss: true
          });
        $("#historial_list").html('');
      },
    });
  }
  //AQUI REENCIO DE GUIAS DE REMISION
  function emitir_by_id_guia(id) {

    $('#barloadermodal').modal('show')

      $.ajax({
        url: ruta+'facturacion/emitir_comprobante_guia',
        type: 'POST',
        data: {
          'id': id
        },
        success: function(data) {
          if (data.guia.sunat_estado == 3) {
            $.bootstrapGrowl(`<h4>${data.guia.sunat_nota}</h4>`, {
              type: 'success',
              delay: 2500,
              allow_dismiss: true,
            });
          } else {
            $.bootstrapGrowl('<h4>' + data.guia.sunat_nota + '</h4>', {
              type: 'danger',
              delay: 2500,
              allow_dismiss: true,
            });
          }

          $('#barloadermodal').modal('hide')
          get_guias_remision()
        },
        error: function() {
          alert('Error inesperado')
          $('#barloadermodal').modal('hide')
        }
      });
  }
