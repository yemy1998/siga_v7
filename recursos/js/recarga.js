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

  $('.ctrl').chosen();
  setTimeout(function() {

    $('#tipo_pago').trigger('chosen:open');
  }, 500);
  $('.chosen-container').css('width', '100%');

  $('#cliente_complete').autocomplete({
    autoFocus: true,
    source: function(request, response) {

      $.ajax({
        url: ruta + 'venta_new/get_clientes_json',
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

        $(this).val(ui.content[0].value);
        $(this).autocomplete('close');
        var prod = $('#cliente_id');
        var template = '<option value="' + ui.content[0].id + '"';
        template += ' data-ruc="' + ui.content[0].ruc + '"';
        template += ' data-identificacion="' + ui.content[0].identificacion +
            '"';
        template += '>' + ui.content[0].value + '</option>';

        prod.html(template);
        prod.trigger('change');
      }
    },
    select: function(event, ui) {
      var prod = $('#cliente_id');
      var template = '<option value="' + ui.item.id + '"';
      template += ' data-ruc="' + ui.item.ruc + '"';
      template += ' data-identificacion="' + ui.item.identificacion +
          '"';
      template += '>' + ui.item.value + '</option>';

      prod.html(template);
      prod.trigger('change');
    },
  });

  $('#cliente_complete').on('focus', function() {
    $(this).select();
  });

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
        url: ruta + 'venta_new/update_cliente/' + dni,
        success: function(data) {
          var selected = 1;
          var template = '';
          for (var i = 0; i < data.clientes.length; i++) {
            if (dni == data.clientes[i].id_cliente) {
              var value = (data.clientes[i].ruc == 2 ? 'RUC: ' : 'DNI: ');
              value += data.clientes[i].identificacion;
              value += ' - ' + data.clientes[i].razon_social;

              template += '<option value="' + data.clientes[i].id_cliente +
                  '" data-ruc="' + data.clientes[i].ruc + '">' +
                  value + '</option>';
              selected = data.clientes[i].id_cliente;
            }
          }

          $('#cliente_id').html(template);
          $('#cliente_complete').val(value);
          $('#cliente_id').val(selected);
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

  $('#cliente_id').on('change', function() {
    let id = $(this).val();
    $.ajax({
      url: ruta + 'venta_new/getCliente/',
      type: 'post',
      data: {id: id},
      headers: {
        Accept: 'application/json',
      },
      success: function(data) {
        var data = JSON.parse(data);
        $('#tienda').val(data.nota);
        $('#nro_recarga').val(data.telefono1);
        $('#poblado_id').val(data.id_grupos_cliente);
        $('#cod_tran').focus();
      },
    });
  });

  $('#dialog_venta_imprimir').on('hidden.bs.modal', function() {
    $('#loading_save_venta').modal('show');
    $.ajax({
      url: ruta + 'venta_new/recarga',
      success: function(data) {
        $('#loading_save_venta').modal('hide');
        $('.modal-backdrop').remove();
        $('#page-content').html(data);
      },
    });
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

  $.ajax({
    url: ruta + 'venta_new/save_recarga/',
    type: 'POST',
    dataType: 'json',
    data: $('#frmRecarga').serialize(),
    success: function(data) {
      if (data.success == '1') {
        show_msg('success', data.msg);
        if (imprimir == '1') {
          $('#dialog_venta_imprimir').html('');

          $.ajax({
            url: ruta + 'venta_new/get_venta_previa',
            type: 'POST',
            data: {'venta_id': data.venta.venta_id},

            success: function(data) {
              $('#loading_save_venta').modal('hide');
              $('.modal-backdrop').remove();
              $('#dialog_venta_imprimir').html(data);
              $('#dialog_venta_imprimir').modal('show');
            },
          });
        } else if (imprimir == '2') {
          var venta_id = data.venta.venta_id;
          $.ajax({
            url: ruta + 'venta_new/recarga',
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
              $('#imprimir_frame').attr('src', url);
            },
          });

        } else {
          $.ajax({
            url: ruta + 'venta_new/recarga',
            success: function(data) {
              $('.modal-backdrop').remove();
              $('#page-content').html(data);
              $('#loading_save_venta').modal('hide');
            },
          });
        }
      } else {
        if (data.msg) {
          show_msg('warning', data.msg);
        } else {
          show_msg('danger', 'Ha ocurrido un error insperado');
        }
        $('#loading_save_venta').modal('hide');
        $('.save_venta_contado').removeAttr('disabled');
      }
    },
    error: function(data) {
      show_msg('danger', 'Ha ocurrido un error insperado');
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
    url: ruta + 'venta_new/save_recarga/',
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
          $.ajax({
            url: ruta + 'venta_new/recarga',
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
  var nro_recarga = $('#nro_recarga').val();
  var cod_tran = $('#cod_tran').val();
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
  if ($.trim(nro_recarga) == '') {
    show_msg('warning',
        '<h4>Advertencia. </h4><p>El número de recarga es requerido</p>');
    setTimeout(function() {
      $('#nro_recarga').trigger('focus');
    }, 500);
    return false;
  }
  if ($.trim(cod_tran) == '') {
    show_msg('warning',
        '<h4>Advertencia. </h4><p>El codigo de transacción es requerido</p>');
    setTimeout(function() {
      $('#cod_tran').trigger('focus');
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