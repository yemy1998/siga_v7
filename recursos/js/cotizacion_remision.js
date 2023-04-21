var ruta = $('#base_url').val();
var lst_producto = [];
var lts_object_product = [];

$(document).ready(function() {

  $(document).off('keyup');
  $(document).off('keydown');



  //CONFIGURACIONES INICIALES
  App.sidebar('close-sidebar');

  $('.date-picker').datepicker({format: 'dd/mm/yyyy'});
  $('.date-picker').css('cursor', 'pointer');

  $('#producto_id, #local_id, #local_venta_id, #cliente_id, #moneda_id, #precio_id, #c_garante, #c_pago_periodo').
      chosen({
        search_contains: true,
      });
  $('.chosen-container').css('width', '100%');
  

  $(document).keyup(function(e) {
    if (e.keyCode == tecla_ctrl || e.which == 0) {
      $('.help-key, .help-key-side').hide();
      ctrlPressed = false;
    }

    if ($('.block_producto_unidades').css('display') != 'none')
      if (ctrlPressed && e.keyCode == tecla_enter) {
        e.stopImmediatePropagation();
        $('#add_producto').trigger('click');
        $('#loading').hide();
      }

    if ($('.chosen-container-active').length == 0 &&
        $('.chosen-with-drop').length == 0)
      if ($('.block_producto_unidades').css('display') != 'none')
        if (!ctrlPressed && (e.keyCode == tecla_espacio)) {
          e.preventDefault();
          e.stopImmediatePropagation();
          var max_index = parseInt($('.precio-input').length - 1);
          var index = $('#precio_unitario').attr('data-index');
          var next = 0;
          if (index < max_index)
            next = ++index;

          $('.precio-input[data-index="' + next + '"]').first().click();
        }

    if (e.keyCode == F6 && $('.modal').is(':visible') == false) {
      e.preventDefault();
      e.stopImmediatePropagation();
      $('#terminar_cotizar').click();
    }

    if (e.keyCode == F6 && $('#dialog_cotizar').is(':visible') == true) {
      e.preventDefault();
      e.stopImmediatePropagation();
      $('.save_venta_contado[data-imprimir="1"]').first().click();
    }
  });



  $('#precio_unitario').on('focus', function() {
    $(this).select();
  });


  $('#precio_unitario').on('keyup', function(e) {
    if (e.keyCode == tecla_enter) {
      $('#editar_pu').click();
      $('#add_producto').trigger('focus');
      $('#loading').hide();
    } else
      refresh_totals();
  });

  $('#moneda_id').on('change', function() {
    var tasa = $('#moneda_id option:selected').attr('data-tasa');
    var simbolo = $('#moneda_id option:selected').attr('data-simbolo');

    $('#tasa').val(tasa);
    $('.tipo_moneda').html(simbolo);

    if ($(this).val() != $('#MONEDA_DEFECTO_ID').val()) {
      $('#block_tasa').show();
      $('#tasa').trigger('focus');
    } else {
      $('#block_tasa').hide();
    }
    $('#moneda_text').html($('#moneda_id option:selected').text());
    refresh_right_panel();

  });

  $('#tasa').on('keyup', function() {
    refresh_right_panel();
  });

  $('#tasa').on('focus', function() {
    $(this).select();
  });

  $('#cliente_id').on('change', function() {

    if ($('#tipo_documento').val() == 1 &&
        $('#cliente_id option:selected').attr('data-ruc') != 2) {
      show_msg('warning',
          '<h4>Error. </h4><p>El Cliente no tiene ruc para realizar venta en factura.</p>');
      select_productos(55);
    }

  });


 


  $('#tipo_impuesto').on('change', function() {
    refresh_right_panel();
  });

  $('#p_gratis').on('change', function() {

    refresh_totals();
  });


  $('#reiniciar_cotizar').on('click', function() {
    $('#confirm_cotizar_text').
        html(
            'Si reinicias la cotizacion perderas todos los productos agregados. Estas seguro?');
    $('#confirm_cotizar_button').attr('onclick', 'reset_cotizar();');
    $('#dialog_cotizar_confirm').modal('show');
  });

  $('#cancelar_cotizar').on('click', function() {
    $('#confirm_cotizar_text').
        html(
            'Si cancelas la cotizacion perderas todos los cambios realizados. Estas seguro?');
    $('#confirm_cotizar_button').attr('onclick', 'cancel_cotizar();');
    $('#dialog_cotizar_confirm').modal('show');
  });

/*
  $('#cancelar_remision').on('click', function() {
    var id_local = "<?php echo $local_id ?>";
    var data_range = "<?php echo $data_range ?>";
    var moneda = "<?php echo $cotizacion->moneda_id ?>";
    console.log(id_local);
    console.log(data_range)
    console.log(moneda)
    /*
       $('#confirm_cotizar_text').
        html(
            'Si cancelas la cotizacion perderas todos los cambios realizados. Estas seguro?');
    $('#confirm_cotizar_button').attr('onclick', 'cancel_guia_remision( <?php echo ?> ,1 ,1)');
    $('#dialog_cotizar_confirm').modal('show');
      */   
      
//    });

  $('#delete_remision').on('click', function() {
    $('#confirm_cotizar_text').
        html(
            'Si cancelas la remision perderas todos los cambios realizados. Estas seguro?');
    $('#confirm_cotizar_button').attr('onclick', 'cancel_cotizar();');
    $('#dialog_cotizar_confirm').modal('show');
  });
  

  $('#stock_total').on('mousemove', function() {
    $('#stock_total').hide();
    $('#popover_stock').show();
  });

  $('#popover_stock').on('mouseleave', function() {
    $('#popover_stock').hide();
    $('#stock_total').show();
  });

  $('.add_nota').on('click', function() {
    $('#dialog_venta_nota').modal('show');
  });

  $('.textarea-editor').wysihtml5({
    'font-styles': true, //Font styling, e.g. h1, h2, etc. Default true
    'emphasis': true, //Italics, bold, etc. Default true
    'lists': true, //(Un)ordered lists, e.g. Bullets, Numbers. Default true
    'html': true, //Button which allows you to edit the generated HTML. Default false
    'link': false, //Button to insert a link. Default true
    'image': false, //Button to insert an image. Default true,
    'color': true //Button to change color of font
  });
});

//FUNCIONES DE MANEJO DE LAS VENTAS


function cancel_guia_remision(id_cotizacion,local_id_params, data_range, moneda_id){
  
  $('#dialog_cotizar_confirm').modal('hide');
  $('#loading_save_venta').modal('show');
  $.ajax({
    url: ruta + 'cotizar/historial',
    success: function(data) {
      $('#loading_save_venta').modal('hide');
      $('#page-content').html(data);
      $('#date_range').val(data_range);
      $('#local_id').val(local_id_params);
      $('#local_id').trigger("chosen:updated");
      
      setTimeout(function(){ 
        $("#historial_list").html('');
        review_info(id_cotizacion,local_id_params, data_range, moneda_id);
        $('.modal-backdrop').remove(); 
      
      },200);

     

 
     
    },
  });

}


function review_info(id_cotizacion,local_id, data_range, moneda_id){

  date_range = String(data_range);
  $("#historial_list").html($("#loading").html());
  $.ajax({
      url: ruta + 'cotizar/get_cotizaciones',
      data: { date_range, local_id, moneda_id },
      type: 'POST',
       success: function (data) {

          $("#historial_list").html(''); 
          $("#historial_list").html(data);   
           setTimeout(function(){ 
            cotizar_remision_volver(id_cotizacion , 'cotizacion');
          },500);
          $('#exportar_pdf').attr('href', $('#exportar_pdf').attr('data-href') + estado + '/' + mes + '/' + year + '/' + dia_min + '/' + dia_max);
          $('#exportar_excel').attr('href', $('#exportar_excel').attr('data-href') + estado + '/' + mes + '/' + year + '/' + dia_min + '/' + dia_max);
     
         
          
    },
    error: function () {

        $.bootstrapGrowl('<h4>Error.</h4> <p>Ha ocurrido un error en la operaci&oacute;n</p>', {
            type: 'danger',
            delay: 5000,
            allow_dismiss: true
        });
        $("#historial_list").html('');
    }
  });

}


//////////// remision venta 

function cancel_guia_remision_venta(id_venta,local_id_params, data_range, moneda_id ,document_id , condicion_pago_id){


  $('#dialog_cotizar_confirm').modal('hide');
  $('#loading_save_venta').modal('show');
  $.ajax({
    url: ruta + 'venta_new/historial',
    success: function(data) {
      $('#loading_save_venta').modal('hide');
      $('#page-content').html(data);

      $('#date_range').val(data_range);

      $('#local_id').val(local_id_params);
      $('#local_id').trigger("chosen:updated");

      $('#condicion_pago_id_chosen').val(local_id_params);
      $('#condicion_pago_id_chosen').trigger("chosen:updated");

      $('#documento_id').val(document_id);
      $('#documento_id').trigger("chosen:updated");

      $('#moneda_id_chosen').val(moneda_id);
      $('#moneda_id_chosen').trigger("chosen:updated");
      

      setTimeout(function(){ 
        $("#historial_list").html('');
        review_info_venta(local_id_params, data_range, moneda_id ,document_id,condicion_pago_id);
        $('.modal-backdrop').remove(); 
    
        
      },200);

      setTimeout(function(){ 
         venta_remision_volver(id_venta,'venta');
      },500)
     

 
     
    },
  });
  

}



function review_info_venta(local_id, data_range, moneda_id ,document_id,condicion_pago_id){
  

  var accion = '';
  
  $.ajax({
      url: ruta + 'venta_new/get_ventas/'+accion,
      data: { 
          'documento_id':document_id,
          'local_id': local_id,
          'fecha': data_range,
          'moneda_id': moneda_id,
          'condicion_pago_id': condicion_pago_id 
      },
      type: 'POST',
       success: function (data) {
        $("#historial_list").html(''); 
        $("#historial_list").html(data);   
    },
    error: function () {

        $.bootstrapGrowl('<h4>Error.</h4> <p>Ha ocurrido un error en la operaci&oacute;n</p>', {
            type: 'danger',
            delay: 5000,
            allow_dismiss: true
        });
        $("#historial_list").html('');
    }
  });
  

}

/// copy function in historial_list --> esto es el boton regresar de una guia remision de una venta
function venta_remision_volver(id, tipo){
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



/// copy function in historial_list --> Esto es para el boton de regresar en la guia de remision
function cotizar_remision_volver(id,tipo){
  $('#dialog_cotizar_remision').html($('#loading').html());
  $('#dialog_cotizar_remision').modal('show');
 
  $.ajax({
    url: ruta + 'cotizar/get_cotizar_remision_validar/',
    type: 'POST',
    data: { id ,tipo  },

    success: function(data) {
      $('#dialog_cotizar_remision').html(data);
    },
    error: function() {
      alert('Error inesperado');
    },
  });
}



