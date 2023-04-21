const _uploadButton = document.querySelector('.upload-file button');
const _uploadInput = document.querySelector('.upload-file input[type="file"]');
const _uploadPreview = document.querySelector('.upload-file .upload-preview');
var _xml_selected = false;

$(function () {

  // $('select').chosen({
  //   search_contains: true,
  // });

  _uploadButton.addEventListener('click', function () {
    _uploadInput.click();
  });

  _uploadInput.addEventListener('change', updateUpload);


  $('#modal').on('shown.bs.modal', function (e) {
    if ($('#producto_complete')) {
      $('#producto_complete').focus();
    }
  });

  $('#moneda_id').on('change', function () {
    const moneda_defecto = $('#MONEDA_DEFECTO_ID').val();
    const moneda = $(this);
    const tasa = $('#tasa');
    if (moneda.val() != moneda_defecto) {
      tasa.val(moneda.find('option:selected').attr('data-tasa'));
      tasa.removeAttr('readonly');
    } else {
      tasa.val('');
      tasa.attr('readonly', 'readonly');
    }

    $('.tipo_moneda').html(moneda.find('option:selected').attr('data-simbolo'));
  });

  $('#save-compra-button').on('click', function () {

    validar_ingreso(false);
  });

});

function updateUpload() {

  _xml_selected = false;
  const file = _uploadInput.files.length > 0 ? _uploadInput.files[0] : null;

  const fecha = document.querySelector('#fecha_emision');
  const proveedor_ruc = document.querySelector('#proveedor_ruc');
  const proveedor_nombre = document.querySelector('#proveedor');
  const proveedor_msg = document.querySelector('#proveedor_msg');
  const documento = document.querySelector('#documento');
  const documento_numero = document.querySelector('#documento_numero');
  const moneda_proveedor = document.querySelector('#moneda');
  const productList = document.querySelector('#product-list');

  fecha.value = '';
  proveedor_ruc.value = '';
  proveedor_nombre.value = '';
  proveedor_msg.innerHTML = '';
  documento.value = '';
  documento_numero.value = '';
  moneda.value = '';

  productList.innerHTML = '';

  if (file) {
    _uploadPreview.innerHTML = file.name;

    $.ajax({
      url: $('#base_url').val() + 'ingresos/load_xml',
      type: 'POST',
      data: new FormData(document.querySelector('#upload-form')),
      cache: false,
      contentType: false,
      processData: false,
      success: function (data) {
        const compra = data.compra;
        const xmlResult = data.xmlResult;

        if (compra.proveedor) {
          const proveedor = compra.proveedor;
          proveedor_nombre.value = proveedor.proveedor_nombre;
          proveedor_ruc.value = proveedor.proveedor_ruc;
          if (proveedor.is_new == 1) {
            proveedor_msg.innerHTML = "El proveedor no esta registrado. Al guardar la compra se registrara el proveedor.";
          }
        }

        if (xmlResult) {
          fecha.value = xmlResult.date_formated;

          if (xmlResult.type == '01') {
            documento.value = 'FACTURA';
          } else if (xmlResult.type == '03') {
            documento.value = 'BOLETA VENTA';
          }

          documento_numero.value = xmlResult.number;

          var m = '';
          if (xmlResult['currency'] == 'PEN') {
            m = 'Soles';
          } else if (xmlResult['currency'] == 'USD') {
            m = 'Dolares';
          } else {
            m = xmlResult['currency'];
          }

          moneda_proveedor.value = m;

          document.querySelector('#date').value = xmlResult['date'];

        }

        if (data.producto_detalles) {
          productList.innerHTML = data.producto_detalles;
        }

        $('.tipo_moneda').html($('#moneda_id option:selected').attr('data-simbolo'));

        _xml_selected = true;
      },
      error: function (err) {
        console.log(err);
      },
    });
  } else {
    _uploadPreview.innerHTML = 'No tiene ningun comprobante seleccionado';
  }
}


function showSelectProduct(self, linked) {
  const button = $(self);

  $('#modal').load($('#base_url').val() + 'ingresos/get_link_modal', function () {
    var desc = '';
    if (linked == false) {
      desc = $('#row-' + button.attr('data-row') + ' td:nth-child(1)').html()
      desc += ' - ' + $('#row-' + button.attr('data-row') + ' td:nth-child(3)').html();

      $('#product-linked').html('-');
    } else {
      desc = $('#row-' + button.attr('data-row') + ' td:nth-child(1)').html()
      desc += ' - ' + $('#row-' + button.attr('data-row') + ' td:nth-child(3) .text-success').text().trim();

      var p = $('#row-' + button.attr('data-row') + ' td:nth-child(2)').text();
      p += ' - ' + $('#row-' + button.attr('data-row') + ' td:nth-child(3)').clone().children().remove().end().text().trim();
      $('#product-linked').html(p);

    }

    $('#proveedor_codigo').val($('#row-' + button.attr('data-row') + ' td:nth-child(1)').html().trim());

    $('#product-preview').html(desc);
    $('#modal').modal('show');
  });
}


function verificar_banco_cuota() {

  $('#banco_id').val('');
  $('#tipo_tarjeta').val('');
  $('#num_oper').val('');
  $('#cantidad_a_pagar').val($('#total_cuota').val());
  var tipo = $('#metodo option:selected').attr('data-tipo_metodo');
  var metodo = $('#metodo').val();

  $('#tipo_tarjeta_block').hide();
  $('#banco_block').hide();
  $('#operacion_block').show();
  $('.caja_block').hide();

  switch (tipo) {
    case 'CAJA': {
      $('.caja_block').show();
      if (metodo == '3') {
        $('#operacion_block').hide();
      }

      break;
    }
    case 'BANCO': {

      $('#banco_block').show();
      if (metodo == '7') {
        $('#tipo_tarjeta_block').show();
      }

      break;
    }
  }
}

function validar_ingreso(credito) {

  if (_xml_selected == false) {
    show_msg('warning', 'No tiene ningun comprobante seleccionado');
    return false;
  }

  if ($('#product-list tbody tr').length == 0) {
    show_msg('warning', 'El xml cargado no tiene detalles de productos');
    return false;
  }


  if ($('#product-list tbody td:nth-child(9) i.text-success').length != $('#product-list tbody tr').length) {
    show_msg('warning', 'Todos productos deben estar enlazados');
    return false;
  }

  if ($('#pago').val() == 'CONTADO' || credito == true) {
    if (credito == true) {
      $('#total_cuota').val(parseFloat($('#c_saldo_inicial').val()));
    } else {
      $('#total_cuota').val($('#total_pagar').val());
    }

    var moneda_id = $('#moneda_id').val();
    $.ajax({
      type: 'POST',
      data: { moneda_id: moneda_id },
      url: $('#base_url').val() + 'ingresos/get_cajas_bancos',
      dataType: 'json',
      success: function (data) {
        var caja_select = $('#caja_id');
        var metodo_select = $('#metodo');
        var banco_select = $('#banco_id');
        var tarjeta_select = $('#tipo_tarjeta');

        caja_select.html('<option value="">Seleccione</option>');
        metodo_select.html('<option value="">Seleccione</option>');
        banco_select.html('<option value="">Seleccione</option>');

        for (var i = 0; i < data.metodo_pago.length; i++) {
          metodo_select.append(
            '<option data-tipo_metodo="' + data.metodo_pago[i].tipo_metodo +
            '" value="' + data.metodo_pago[i].id_metodo + '" >' +
            data.metodo_pago[i].nombre_metodo + '</option>');
        }
        for (var j = 0; j < data.bancos.length; j++) {
          banco_select.append(
            '<option data-cuenta_c="' + data.bancos[j].cuenta_id +
            '" value="' + data.bancos[j].banco_id + '" >' +
            data.bancos[j].banco_nombre + ' | ' +
            data.bancos[j].local_nombre + '</option>');
        }
        for (var y = 0; y < data.cajas.length; y++) {
          caja_select.append(
            '<option data-moneda="' + data.cajas[y].moneda_id + '" value="' +
            data.cajas[y].cuenta_id + '" >' + data.cajas[y].descripcion +
            ' | ' + data.cajas[y].local_nombre + '</option>');
        }
        for (var z = 0; z < data.tarjetas.length; z++) {
          tarjeta_select.append(
            '<option  value="' + data.tarjetas[z].id + '" >' +
            data.tarjetas[z].nombre + '</option>');
        }

        $('#pago_modal').modal('show');

      },
    });
  } else {
    credito_init_xml($('#total_pagar').val(), 'COMPLETADO');
    refresh_credito_window();
    $('#dialog_compra_credito').modal('show');
  }

}

function guardaringreso() {
  if ($('#pago').val() == 'CONTADO' || ($('#pago').val() == 'CREDITO' &&
    parseFloat($('#c_saldo_inicial').val()) > 0)) {
    if ($('#metodo').val() == '') {
      show_msg('warning', 'Debe seleccionar un Metodo de Pago');
      return false;
    }

    if ($('#metodo').val() != '' &&
      ($('#caja_id').val() == '' && $('#banco_id').val() == '')) {
      show_msg('warning', 'Debe seleccionar una cuenta');
      return false;
    }
  }

  $('#barloadermodal').modal('show');
  $('.guardarPago').attr('disabled', 'disabled');
  $('.save_compra_credito').attr('disabled', 'disabled');


  var products = [];
  $('.unidades').each(function () {
    var element = $(this);

    products.push({
      producto_id: element.attr('data-id'),
      value: element.val(),
    });
  });

  const payload = {
    'xmlResult': $('#xmlResultJson').html(),
    'pago': $('#pago').val(),
    'local': $('#local').val(),
    'observacion': $('#observacion').val(),
    'moneda_id': $('#moneda_id').val(),
    'tasa_id': $('#tasa').val(),
    'metodo': $('#metodo').val(),
    'caja_id': $('#caja_id').val(),
    'banco_id': $('#banco_id').val(),
    'tipo_tarjeta': $('#tipo_tarjeta').val(),
    'num_oper': $('#num_oper').val(),
    'c_saldo_inicial': $('#c_saldo_inicial').val(),
    'c_precio_contado': $('#c_precio_contado').val(),
    'c_precio_credito': $('#c_precio_credito').val(),
    'c_tasa_interes': $('#c_tasa_interes').val(),
    'c_numero_cuotas': $('#c_numero_cuotas').val(),
    'c_fecha_giro': $('#c_fecha_giro').val(),
    'c_periodo_gracia': $('#c_periodo_gracia').val(),
    'cuotas': $('#pago').val() == 'CONTADO' ? '' : prepare_cuotas(),
    'productos': JSON.stringify(products),
  };


  $.ajax({
    type: 'POST',
    data: payload,
    url: $('#base_url').val() + 'ingresos/guardar_xml',
    dataType: 'json',
    success: function (data) {
      if (data.success == 1) {
        show_msg('success', data.msg);

        $.ajax({
          url: $('#base_url').val() + 'ingresos/xml',
          success: function (data2) {
            $('#barloadermodal').modal('hide');
            $('.modal-backdrop').remove();
            $('#page-content').html(data2);
          },

        });
      } else {
        $('#barloadermodal').modal('hide');
        show_msg('warning', data.msg);
      }
    },
    error: function () {
      $('#barloadermodal').modal('hide');
      show_msg('danger', 'Ha ocurrido un error inesperado');
    },
    complete: function () {
      $('.guardarPago').removeAttr('disabled');
      $('.save_compra_credito').removeAttr('disabled');
    }
  });
}