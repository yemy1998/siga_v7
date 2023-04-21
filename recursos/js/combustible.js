var ruta = $('#base_url').val();

$(document).ready(function() {
  $(document).off('keyup');
  $(document).off('keydown');

  var F6 = 117;

  var disabled_save = false;
  $(document).keydown(function(e) {
    if (e.keyCode == F6) {
      e.preventDefault();
    }
  });

  $(document).keyup(function(e) {
    if (e.keyCode == F6 && $('#dialog_venta_contado').is(':visible') == false) {
      terminar_venta();
    }
    if (e.keyCode == F6 && $('#dialog_venta_contado').is(':visible') == true) {
      e.preventDefault();
      e.stopImmediatePropagation();
      save_venta_contado('1');
    }
  });

  $('.ctrl').chosen({
    search_contains: true,
  });
  $('.chosen-container').css('width', '100%');

  $('#cliente_new').on('click', function(e) {
    e.preventDefault();
    $('#dialog_new_cliente').attr('data-id', '');
    $('#dialog_new_cliente').html($('#loading').html());
    $('#dialog_new_cliente').modal('show');
    $('#dialog_new_cliente').load(ruta + 'cliente/form/' + '-1');
  });

  $('#dialog_new_cliente').on('hidden.bs.modal', function() {
    var dni = $('#dialog_new_cliente').attr('data-id');
    if (dni != '') {
      $.ajax({
        headers: {
          Accept: 'application/json',
        },
        url: ruta + 'venta_new/update_cliente',
        success: function(data) {
          var selected = 1;
          var template = '';
          for (var i = 0; i < data.clientes.length; i++) {
            if (dni == data.clientes[i].id_cliente)
              selected = data.clientes[i].id_cliente;

            template += '<option value="' + data.clientes[i].id_cliente +
                '" data-ruc="' + data.clientes[i].ruc + '">' +
                data.clientes[i].razon_social + '</option>';
          }
          $('#cliente_id').html(template);

          $('#cliente_id').val(selected).trigger('chosen:updated');
          $('#cliente_id').change();
        },
      });
    }
  });

  $('#reiniciar_venta').on('click', function() {
    document.frmRecarga.reset();
  });

  $('#terminar_venta').on('click', function(e) {
    e.preventDefault();
    terminar_venta();
  });

  $('.date-picker').datepicker({
    weekStart: 1,
    format: 'dd/mm/yyyy',
  });

  $('#producto_id').on('change', function() {
    var producto = $('#producto_id option:selected');
    $('#presentacion').val(
        producto.attr('data-unidades') + ' ' + producto.attr('data-unidad'),
    );
    $('#precio_unitario').val(producto.attr('data-precio'));

    $('#total_importe').trigger('keyup');
    $('#total_importe').focus();
  });

  $('#cliente_id').on('change', function() {

  });

  $('#total_importe').on('keyup', function() {
    var total_importe = isNaN(parseFloat($('#total_importe').val()))
        ? 0
        : parseFloat($('#total_importe').val());

    var precio_unitario = isNaN(parseFloat($('#precio_unitario').val()))
        ? 0
        : parseFloat($('#precio_unitario').val());

    var cantidad = precio_unitario != 0 ? total_importe / precio_unitario : 0;
    $('#cantidad').val(cantidad.toFixed(2));
  });

  $('#cantidad, #precio_unitario').on('keyup', function() {

    var precio_unitario = isNaN(parseFloat($('#precio_unitario').val()))
        ? 0
        : parseFloat($('#precio_unitario').val());

    var cantidad = isNaN(parseFloat($('#cantidad').val()))
        ? 0
        : parseFloat($('#cantidad').val());

    var total_importe = cantidad * precio_unitario;
    $('#total_importe').val(total_importe.toFixed(4));
  });
});

function save_venta_contado(imprimir) {
  if (isNaN(parseFloat($('#vc_importe').val()))) {
    show_msg('warning',
        '<h4>Error. </h4><p>El importe tiene que ser numerico.</p>');
    setTimeout(function() {
      $('#vc_importe').trigger('focus');
    }, 500);
    return false;
  }
  if ($('#vc_forma_pago').val() == '3' && $('#vc_vuelto').val() < 0) {
    show_msg('warning',
        '<h4>Error. </h4><p>El importe no puede ser menor que el total a pagar. Recomendamos una venta al Cr&eacute;dito.</p>');
    setTimeout(function() {
      $('#vc_importe').trigger('focus');
    }, 500);
    return false;
  }
  if ($('#vc_forma_pago').val() != '3' && $('#vc_num_oper').val() == '') {
    show_msg('warning',
        '<h4>Error. </h4><p>El campo Operaci&oacute;n # es obligatorio.</p>');
    setTimeout(function() {
      $('#vc_num_oper').trigger('focus');
    }, 500);
    return false;
  }
  if (($('#vc_forma_pago').val() == '4' || $('#vc_forma_pago').val() == '8' ||
      $('#vc_forma_pago').val() == '9' || $('#vc_forma_pago').val() == '7') &&
      $('#vc_banco_id').val() == '') {
    show_msg('warning', '<h4>Error. </h4><p>Debe seleccionar un Banco</p>');
    setTimeout(function() {
      $('#vc_banco_id').trigger('focus');
    }, 500);
    return false;
  }

  $('#loading_save_venta').modal('show');
  $('#dialog_venta_contado').modal('hide');
  $('.save_venta_contado').attr('disabled', 'disabled');

  $('#vc_num_oper2').attr('value', $('#vc_num_oper').val());
  $('#vc_forma_pago2').attr('value', $('#vc_forma_pago').val());
  $('#vc_banco_id2').attr('value', $('#vc_banco_id').val());

  var detalles_productos = prepare_detalles_productos();
  var traspasos = prepare_traspasos();

  $.ajax({
    url: ruta + 'venta_new/save_combustible/',
    type: 'POST',
    dataType: 'json',
    data: $('#frmRecarga').serialize() + '&detalles_productos=' +
    detalles_productos + '&traspasos=' +
    traspasos,
    success: function(data) {
      if (data.success == '1') {
        show_msg('success', data.msg);

        if (imprimir == '1') {
          var venta_id = data.venta.venta_id;
          $.ajax({
            url: ruta + 'venta_new',
            success: function(data) {
              $('#loading_save_venta').modal('hide');
              $('.modal-backdrop').remove();
              $('#page-content').html(data);

              $.bootstrapGrowl('<p>IMPRIMIENDO PEDIDO</p>', {
                type: 'success',
                delay: 2500,
                allow_dismiss: true,
              });

              var url = ruta + 'venta_new/imprimir/' + venta_id + '/PEDIDO';
              $('#imprimir_frame_venta').attr('src', url);
            },
          });
        }
        else {
          $.ajax({
            url: ruta + 'venta_new/combustible',
            success: function(data) {
              $('#loading_save_venta').modal('hide');
              $('.modal-backdrop').remove();
              $('#page-content').html(data);
            },
          });
        }

      } else {
        if (data.msg)
          show_msg('danger', '<h4>Error. </h4><p>' + data.msg + '</p>');
        else
          show_msg('danger',
              '<h4>Error. </h4><p>Ha ocurrido un error insperado al guardar la venta.</p>');
      }
    },
    error: function(data) {
      show_msg('danger',
          '<h4>Error. </h4><p>Ha ocurrido un error insperado al guardar la venta.</p>');
    },
    complete: function(data) {
      $('.save_venta_contado').removeAttr('disabled');
    },
  });
}

function save_venta_credito(imprimir) {
  $('#loading2').html($('#loading').html());
  $('#terminar_venta').attr('disabled', 'disabled');
  $.ajax({
    url: ruta + 'venta_new/save_combustible/',
    type: 'POST',
    dataType: 'json',
    data: $('#frmRecarga').serialize(),
    success: function(data) {
      if (data.success == '1') {
        show_msg('success',
            '<h4>Imprimiendo. </h4><p>La venta numero ' + data.venta.venta_id +
            ' se ha pagado con exito.</p>');
        if (imprimir == '1') {
          let url = ruta + 'venta_new/imprimir/' + data.venta.venta_id +
              '/PEDIDO';
          $('#imprimir_frame').attr('src', url);
          document.frmRecarga.reset();
        }
      } else {
        if (data.msg)
          show_msg('danger', '<h4>Error. </h4><p>' + data.msg + '</p>');
        else
          show_msg('danger',
              '<h4>Error. </h4><p>Ha ocurrido un error insperado al guardar la venta.</p>');
      }
      $('#loading2').html('');
    },
    error: function(data) {
      show_msg('danger',
          '<h4>Error. </h4><p>Ha ocurrido un error insperado al guardar la venta.</p>');
    },
    complete: function(data) {
      $('#terminar_venta').removeAttr('disabled');
    },
  });
}

function terminar_venta() {
  var importe = $('#total_importe').val();

  if ($('#producto_id').val() == '') {
    show_msg('warning',
        '<h4>Advertencia. </h4><p>Debe seleccionar el combustible</p>');
    return false;
  }

  if ($('#producto_id').val() == '') {
    show_msg('warning',
        '<h4>Advertencia. </h4><p>Debe seleccionar el combustible</p>');
    return false;
  }

  var cantidad = isNaN(parseFloat($('#cantidad').val()))
      ? 0
      : parseFloat($('#cantidad').val());

  if (cantidad <= 0 || cantidad == '') {
    show_msg('warning',
        '<h4>Advertencia. </h4><p>Cantidad invalida</p>');
    return false;
  }

  var precio_unitario = isNaN(parseFloat($('#precio_unitario').val()))
      ? 0
      : parseFloat($('#precio_unitario').val());

  if (precio_unitario <= 0 || precio_unitario == '') {
    show_msg('warning',
        '<h4>Advertencia. </h4><p>Precio unitario invalido</p>');
    return false;
  }

  if ($.trim(importe) == '') {
    show_msg('warning', '<h4>Advertencia. </h4><p>El importe es requerido</p>');
    setTimeout(function() {
      $('#total_importe').trigger('focus');
    }, 500);
    return false;
  }

  if (parseFloat(importe) <= 0) {
    show_msg('warning', '<h4>Advertencia. </h4><p>El importe es inválido</p>');
    setTimeout(function() {
      $('#total_importe').trigger('focus');
    }, 500);
    return false;
  }

  if (isNaN(parseFloat(importe))) {
    show_msg('warning',
        '<h4>Advertencia. </h4><p>El importe tiene que ser numérico</p>');
    setTimeout(function() {
      $('#total_importe').trigger('focus');
    }, 500);
    return false;
  }

  $('#dialog_venta_contado').html($('#loading').html());

  if ($('#tipo_pago').val() == 1) {
    $('#dialog_venta_contado').modal('show');

    $('#dialog_venta_contado').
        load(ruta + 'venta_new/dialog_venta_contado', function() {
          let num = parseFloat($('#total_importe').val());
          $('#vc_total_pagar').attr('value', num.toFixed(2));
          $('#vc_importe2').attr('value', $('#vc_importe').val());
          $('#vc_vuelto2').attr('value', $('#vc_vuelto').val());
          $('#contado_tipo_pago').attr('value', $('#tipo_pago').val());
          if ($('#tipo_pago').val() == 1) {
            $('#vc_importe').attr('value', num.toFixed(2));
          } else {
            $('#vc_importe').attr('value', 0);
          }
        });
  } else {
    save_venta_credito(1);
  }
}

function prepare_detalles_productos() {
  var productos = [];
  var producto = {};
  producto.id_producto = $('#producto_id').val();
  producto.precio = $('#precio_unitario').val();
  producto.precio_venta = $('#precio_unitario').val();
  producto.unidad_medida = $('#producto_id option:selected').
      attr('data-unidad_id');
  producto.cantidad = $('#cantidad').val();
  producto.detalle_importe = $('#total_importe').val();
  producto.p_gratis = 0;
  producto.descuento = 0;
  productos.push(producto);

  return JSON.stringify(productos);

}

function prepare_traspasos() {
  var productos = [];
  var local_venta = $('#local_venta_id');
  var local_id = $('#local_id');

  if (local_id.val() != local_venta.val()) {
    var producto = {};
    producto.id_producto = $('#producto_id').val();
    producto.parent_local = local_venta.val(); //local de destino
    producto.cantidad = $('#cantidad').val();
    producto.local_id = local_id; //local de origen
    productos.push(producto);
  }

  return JSON.stringify(productos);
}