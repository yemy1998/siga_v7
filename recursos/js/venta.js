var ruta = $('#base_url').val();
var lst_producto = [];
var is_edit = false;

var auto_add = false;
var fx = $('#numero_decimales').val();


$(document).ready(function() {

  //Nuevo producto
  /*$("#agregarproveedor").load(ruta + 'proveedor/form');f
   $("#agregarmarca").load(ruta + 'marca/form');
   $("#agregargrupo").load(ruta + 'grupo/form');
   $("#agregarfamilia").load(ruta + 'familia/form');
   $("#agregarlinea").load(ruta + 'linea/form');*/

  $(document).off('keyup');
  $(document).off('keydown');

  //CONFIGURACIONES INICIALES
  App.sidebar('close-sidebar');

  if ($('#venta_estado').val() == 'CAJA') {
    $('.ocultar_caja').hide();
  } else if ($('#venta_estado').val() == 'COMPLETADO') {
    $('.ocultar_caja').show();
  }

  $('.date-picker').datepicker({format: 'dd/mm/yyyy'});
  $('.date-picker').css('cursor', 'pointer');

  $('#local_id, #local_venta_id, #moneda_id, #precio_id, #tipo_pago, #tipo_documento, #venta_estado, #c_garante, #c_pago_periodo').
      chosen({
        search_contains: true,
      });

  $('.chosen-container').css('width', '100%');

  //tecla_3 para mostrar los productos
  // select_productos(51);
  setTimeout(function() {
    $('#producto_complete').focus();
  }, 500);

  $('#producto_complete').autocomplete({
    autoFocus: true,
    source: function(request, response) {

      $.ajax({
        url: ruta + 'venta_new/get_productos_json',
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
        auto_add = ui.content[0].codigo_barra == $('#producto_complete').val();

        $(this).val(ui.content[0].value);
        $(this).autocomplete('close');
        var prod = $('#producto_id');
        prod.attr('data-costo', ui.content[0].costo);
        var template = '<option value="' + ui.content[0].id + '"';
        template += ' data-impuesto="' + ui.content[0].porcentaje_impuesto +
        '"';
        template += ' data-afectacion_impuesto="' +
        ui.content[0].producto_afectacion_impuesto + '"';
        template += ' data-cb="' + ui.content[0].codigo_barra + '"';
        template += ' data-stock="' + ui.content[0].stock + '"';
        template += ' data-is_bolsa="' + ui.content[0].is_bolsa + '"';
        template += '>' + ui.content[0].value + '</option>';
        
        prod.html(template);
        prod.trigger('change');
      }
    },
    select: function(event, ui) {
      var prod = $('#producto_id');
      prod.attr('data-costo', ui.item.costo);
      var template = '<option value="' + ui.item.id + '"';
      template += ' data-impuesto="' + ui.item.porcentaje_impuesto + '"';
      template += ' data-afectacion_impuesto="' +
          ui.item.producto_afectacion_impuesto + '"';
      template += ' data-cb="' + ui.item.codigo_barra + '"';
      template += ' data-stock="' + ui.item.stock + '"';
      template += ' data-is_bolsa="' + ui.item.is_bolsa + '"';
      template += '>' + ui.item.value + '</option>';

      prod.html(template);
      prod.trigger('change');
    },
  }).autocomplete('instance')._renderItem = function(ul, item) {
    return $('<li>').
        append('<div>' + item.label +
            '<br><span style=\'color: #888; font-size: 10px;\'>' + item.desc +
            '</span></div>').
        appendTo(ul);
  };

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
        template += ' data-codigo="' + ui.content[0].codigo + '"';
        template += ' data-identificacion="' + ui.content[0].identificacion +
            '"';
        template += '>' + ui.content[0].value + '</option>';

        prod.html(template);
        prod.trigger('change');
        getAnticiposClient(ui.content[0].id);
      }
    },
    select: function(event, ui) {
      var prod = $('#cliente_id');
      var template = '<option value="' + ui.item.id + '"';
      template += ' data-ruc="' + ui.item.ruc + '"';
      template += ' data-codigo="' + ui.item.codigo + '"';
      template += ' data-identificacion="' + ui.item.identificacion +
          '"';
      template += '>' + ui.item.value + '</option>';

      prod.html(template);
      prod.trigger('change');
      getAnticiposClient(ui.item.id);
    },
  }).autocomplete('instance')._renderItem = function(ul, item) {
    return $('<li>').
        append('<div>' + item.label +
            '<br><span style=\'font-size: 10px;\'>' + item.desc +
            '</span></div>').
        appendTo(ul);
  };


  function getAnticiposClient(cliente_id){

    let dataAnticipo = {
      'id_actor'             : cliente_id, // $("#cliente_id").val()
      'localId'              : $("#local_venta_id").val(),
      'naturalezaActor'      : 1,
      'idMoneda'             : document.querySelector("#moneda_id").value,
    }

    //getAnticipos(dataAnticipo);
  }

  /*
   * .autocomplete('instance')._renderItem = function(ul, item) {
   return $('<li>').
   append('<div>' + item.label +
   '<br><span style=\'color: #888; font-size: 10px;\'>' + item.desc +
   '</span></div>').
   appendTo(ul);
   };*/

  /*$('.textarea-editor').wysihtml5({
    'font-styles': true, //Font styling, e.g. h1, h2, etc. Default true
    'emphasis': true, //Italics, bold, etc. Default true
    'lists': true, //(Un)ordered lists, e.g. Bullets, Numbers. Default true
    'html': true, //Button which allows you to edit the generated HTML. Default false
    'link': false, //Button to insert a link. Default true
    'image': false, //Button to insert an image. Default true,
    'color': true //Button to change color of font
  });*/

  //EVENTOS DEL TECLADO
  //CNTRL + 0 al 9 = Para seleccionar los select los numero son de 0(48) - 9(57)
  var ctrlPressed = false;
  var tecla_ctrl = 17;
  var tecla_espacio = 32;
  var tecla_enter = 13;
  var letra_up = 38, letra_down = 40;
  var F6 = 117;

  var disabled_save = false;
  $(document).keydown(function(e) {
    if (e.keyCode == tecla_ctrl) {
      $('.help-key, .help-key-side').show();
      ctrlPressed = true;
    }

    if (ctrlPressed && (e.keyCode >= 48 || e.keyCode <= 57)) {
      e.preventDefault();
      select_productos(e.keyCode);
    }

    if (e.keyCode == F6) {
      e.preventDefault();
    }
  });

  $(document).keyup(function(e) {
    if (e.keyCode == tecla_ctrl || e.which == 0) {
      $('.help-key, .help-key-side').hide();
      ctrlPressed = false;
    }

    if ($('.block_producto_unidades').css('display') != 'none')
      if (ctrlPressed && e.keyCode == tecla_enter) {
        e.stopImmediatePropagation();
        if (!$('#add_producto').attr('disabled'))
          $('#add_producto').trigger('click');
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
      $('#terminar_venta').click();
    }

    if (e.keyCode == F6 && $('#dialog_venta_caja').is(':visible') == true) {
      e.preventDefault();
      e.stopImmediatePropagation();
      $('.save_venta_caja[data-imprimir="0"]').first().click();
    }

    if (e.keyCode == 117 && $('#dialog_venta_contado').is(':visible') == true &&
        ($('#venta_estado').val() == 'COMPLETADO' ||
        $('#caja_imprimir').val() == '1')) {
      e.preventDefault();
      e.stopImmediatePropagation();
      $('.save_venta_contado[data-imprimir="2"]').first().click();
    }

    var saldo_inicial_comp = isNaN(parseFloat($('#c_saldo_inicial').val())) ?
        0 :
        parseFloat($('#c_saldo_inicial').val());
    if (e.keyCode == 117 && $('#dialog_venta_credito').is(':visible') == true &&
        saldo_inicial_comp == 0) {
      e.preventDefault();
      e.stopImmediatePropagation();
      $('.save_venta_credito[data-imprimir="2"]').first().click();
    }
  });

  $('#producto_complete').on('focus', function() {
    $(this).select();
  });

  $('#cliente_complete').on('focus', function() {
    $(this).select();
  });

  $('#dialog_venta_caja').on('shown.bs.modal', function(e) {
    $('#caja_nombre').val('.');
    $('#caja_nombre').focus();
  });

  $('#caja_nombre').on('focus', function() {
    $(this).select();
  });

  // EVENTOS FUNCIONALES

  $('#new_dir_entrega_btn').on('click', function() {
    $('#new_dir_entrega').val('');
    $('#dir_entrega_modal').modal('show');
  });

  $('#save_dir_entrega').on('click', function() {

    var dir = $('#new_dir_entrega').val();
    var cliente_id = $('#cliente_id').val();

    if (dir == '') {
      show_msg('warning', 'Debe ingresar una direccion');
      return false;
    }

    if (cliente_id == '1') {
      show_msg('warning',
          'El cliente frecuente no puede tener direcciones de entrega');
      return false;
    }

    $('#dir_entrega_modal').modal('hide');

    $.ajax({
      url: ruta + 'cliente/save_dir_entrega',
      type: 'POST',
      data: {
        direccion: dir,
        cliente_id: cliente_id,
      },
      headers: {
        Accept: 'application/json',
      },
      success: function(data) {
        $('#dir_entrega').
            append('<option value="' + data.dir_entrega.id + '">' +
                data.dir_entrega.direccion + '</option>');
        $('#dir_entrega').val(data.dir_entrega.id);
      },
      error: function(data) {
        show_msg('danger', 'Ha ocurrido un erro inesperado');
      },
      complete: function() {
      },
    });
  });

  $('#refresh_productos').on('click', function() {

    $('#loading_save_venta').modal('show');
    $.ajax({
      url: ruta + 'venta_new/refresh_productos',
      type: 'GET',
      headers: {
        Accept: 'application/json',
      },
      success: function(data) {
        var select_producto = $('#producto_id');
        var productos = data.productos;

        select_producto.chosen('destroy');
        select_producto.html('<option value=""></option>');
        $('#close_add_producto').trigger('click');

        for (var i = 0; i < productos.length; i++) {
          var temp = '<option value="' + productos[i].producto_id +
              '" data-impuesto="' + productos[i].porcentaje_impuesto + '">';
          if ($('#producto_what_codigo').val() == 'AUTO')
            temp += productos[i].producto_id + ' - ' +
                productos[i].producto_nombre;
          else
            temp += productos[i].codigo + ' - ' + productos[i].producto_nombre;

          if ($('#barra_activa').val() == 1 && productos[i].barra != '')
            temp += ' CB: ' + productos[i].barra;

          temp += '</option>';

          select_producto.append(temp);
        }

        $('#producto_id').chosen({
          search_contains: true,
        });
        $('.chosen-container').css('width', '100%');
      },
      complete: function(data) {
        $('#loading_save_venta').modal('hide');
      },
      error: function(data) {
        alert('not');
      },
    });
  });

  $('.add_nota').on('click', function() {
    $('#dialog_venta_nota').modal('show');
  });

  $('#local_id').on('change', function() {
    $('#producto_id').change().trigger('chosen:update');
  });

  var tasa_dolar = getDolar();

  $('#producto_id').on('change', function(e) {

    e.preventDefault();

    $('.block_producto_unidades').hide();

    if ($('#producto_id').val() == '') {
      return false;
    }

    var producto_id = $(this).val();
    var precio_id = $('#precio_id').val();
    var local_id = $('#local_id').val();

    $('#loading').show();
    var price = 0;
    $.ajax({
      url: ruta + 'venta_new/get_productos_unidades',
      type: 'POST',
      headers: {
        Accept: 'application/json',
      },
      data: {'producto_id': producto_id, 'precio_id': precio_id},
      success: function(data) {
        var form = $('#producto_form');
        var form_precio = $('#producto_precio');
        form.html('');
        form_precio.html('');
        $('#descuento').val(0);

        var unidad_minima = data.unidades[data.unidades.length - 1];
        $('#um_minimo').html(unidad_minima.nombre_unidad);
        $('#um_minimo').attr('data-abr', unidad_minima.abr);
        var tasa = parseFloat($('#tasa').val());
        var index = 0;
        for (var i = 0; i < data.unidades.length; i++) {
          data.unidades[i].precio = parseFloat(data.unidades[i].precio);
          price = price ?
              price > data.unidades[i].precio ?
                  data.unidades[i].precio :
                  price :
              data.unidades[i].precio;
          //if (data.unidades[i].abr == 'UND')
          //  $('#unit_price').val(data.unidades[i].precio);

          if (data.unidades[i].presentacion == '1')
            form.append(create_unidades_template(index++, data.unidades[i],
                unidad_minima));

          if (data.unidades[i].precio_dolar == null)
            data.unidades[i]['precio_dolar'] = parseFloat(
                    data.unidades[i].precio) / tasa_dolar + '_';

          form_precio.append(create_precio_template(i, data.unidades[i]));

          var def_value = 0;
          if (unidad_minima.id_unidad == data.unidades[i].id_unidad) {
            if (data.unidades.length == 1)
              def_value = 1;
            else
              def_value = 0;
          }

          prepare_unidades_value(producto_id, local_id, data.unidades[i],
              def_value);

          if (auto_add && data.unidades.length == 1 && is_edit == false) {
            var cant = get_value_producto(producto_id, local_id,
                data.unidades[i].id_unidad, -1);
            if (cant != -1) {
              var cantidad_plus = $('#cantidad_' + data.unidades[i].id_unidad);
              cantidad_plus.attr('value', parseFloat(cant) + 1);
              cantidad_plus.attr('data-value', parseFloat(cant) + 1);
            }
          }
        }
        $('#unit_price').val(price);
        //Este ciclo es para los datos iniciales del total y el importe
        var total = 0;
        $('.cantidad-input').each(function() {
          var input = $(this);
          if (input.val() != 0) {
            total += parseFloat(input.val() * input.attr('data-unidades'));
          }
        });
        $('#total_minimo').val(total);
        set_stock_info(producto_id);

        prepare_unidades_events();

        prepare_precio_value(producto_id, unidad_minima);
        prepare_precio_events();

        refresh_totals();
        refresh_right_panel();

        if (get_precio_producto(producto_id) == -1) {
          $('.precio-input[data-index="' + ($('.precio-input').length - 1) +
              '"]').first().click();
        }

        $('#loading').hide();
        $('.block_producto_unidades').show();

        $('.cantidad-input[data-index="' + (--index) + '"]').
            first().
            trigger('focus');

        if (auto_add && data.unidades.length == 1 && is_edit == false) {
          $('#add_producto').click();
          is_edit = false;
        }

        var conStock = $('#producto_id option:selected').attr('data-stock');
        $('#conStock').prop('checked', (conStock == 1 ? true : false));

      },
      complete: function(data) {
      },
      error: function(data) {
        $('#loading').hide();
        $('.block_producto_unidades').show();
        alert('not');
      },
    });

  });

  $('#conStock').on('change', function() {
    var conStock = $('#conStock').prop('checked') ? 1 : 0;
    $.ajax({
      url: ruta + 'producto/change_stock',
      type: 'POST',
      headers: {
        Accept: 'application/json',
      },
      data: {
        'producto_id': $('#producto_id').val(),
        'stock': conStock,
      },
      success: function(data) {
        $('#producto_id option:selected').attr('data-stock', conStock);
      },
    });
  });

  //Esta funcion esta desabilitda por el momento
  $('#precio_id').on('change', function() {

    var producto_id = $('#producto_id').val();
    var precio_id = $(this).val();

    $('#producto_precio').hide();
    $('#loading_precio').show();
    $.ajax({
      url: ruta + 'venta_new/get_productos_precios',
      type: 'POST',
      headers: {
        Accept: 'application/json',
      },
      data: {'producto_id': producto_id, 'precio_id': precio_id},
      success: function(data) {
        var form_precio = $('#producto_precio');
        form_precio.html('');

        var unidad_minima = data.unidades[data.unidades.length - 1];
        for (var i = 0; i < data.unidades.length; i++) {
          if (data.unidades[i].precio_dolar == null)
            data.unidades[i]['precio_dolar'] = parseFloat(
                    data.unidades[i].precio) / tasa_dolar + '_';
          form_precio.append(create_precio_template(i, data.unidades[i]));
        }

        prepare_precio_value(producto_id, unidad_minima);

      },
      complete: function(data) {
        $('#loading_precio').hide();
        $('#producto_precio').show();
        $('.cantidad-input[data-index="0"]').first().trigger('focus');
      },
      error: function(data) {
        alert('not');
      },
    });
  });

  $('#editar_pu').on('click', function(e) {
    e.preventDefault();
    var edit_pu = $('#editar_pu');
    var pu = $('#precio_unitario');

    if (edit_pu.attr('data-estado') == '0') {
      pu.removeAttr('readonly');
      pu.trigger('focus');
      edit_pu.attr('data-estado', '1');
      edit_pu.html('<i class="fa fa-check"></i>');
    } else {
      if (pu.val() == '' || parseFloat(pu.val()) <= 0) {
        show_msg('warning', 'El precio tiene que ser mayor que 0');
        return false;
      }
      pu.attr('readonly', 'readonly');
      edit_pu.attr('data-estado', '0');
      edit_pu.html('<i class="fa fa-edit"></i>');
      var flag = false;
      $('.precio-input').removeClass('precio-selected');
      $('.precio-input').each(function() {
        var input = $(this);

        if (input.val() == $('#precio_unitario').val()) {
          flag = true;
          $('#precio_unitario').attr('data-index', input.attr('data-index'));
          $('#precio_unitario_um').html(input.attr('data-unidad_nombre'));
          input.addClass('precio-selected');
        }
      });

      if (flag == false) {
        $('#precio_unitario_um').
            html('<span style="color: #f39c12;">Personalizado</span>');
      }

      refresh_totals();
    }
  });

  $('#editar_su').on('click', function(e) {
    e.preventDefault();
    var edit_pu = $('#editar_su');
    var pu = $('#importe');
    $('.precio-input').removeClass('precio-selected');
    if (edit_pu.attr('data-estado') == '0') {
      pu.removeAttr('readonly');
      pu.trigger('focus');
      edit_pu.attr('data-estado', '1');
      edit_pu.html('<i class="fa fa-check"></i>');
    } else {
      pu.attr('readonly', 'readonly');
      edit_pu.attr('data-estado', '0');
      edit_pu.html('<i class="fa fa-edit"></i>');

      if (parseFloat($('#total_minimo').val()) > 0) {
        $('#precio_unitario').val(parseFloat(pu.val() / $('#total_minimo').val(), 4, 4));
      } else {
        $('#precio_unitario').val(0);
      }
      refresh_totals();

      var flag = false;
      $('.precio-input').each(function() {
        var input = $(this);

        if (input.val() == $('#precio_unitario').val()) {
          flag = true;
          $('#precio_unitario').attr('data-index', input.attr('data-index'));
          $('#precio_unitario_um').html(input.attr('data-unidad_nombre'));
          input.addClass('precio-selected');
        }
      });

      if (flag == false) {
        $('#precio_unitario_um').
            html('<span style="color: #f39c12;">Personalizado</span>');
      }
    }
  });

  $('#precio_unitario').on('focus', function() {
    $(this).select();
  });

  $('#importe').on('focus', function() {
    $(this).select();
  });

  $('#precio_unitario').on('keyup', function(e) {
    if (e.keyCode == tecla_enter) {
      $('#editar_pu').click();
    } else
      refresh_totals();
  });

  $('#precio_unitario').on('change', function(e) {
    refresh_totals();
  });

  $('#importe').on('keyup', function(e) {
    if (e.keyCode == tecla_enter) {
      $('#editar_su').click();
    } else {
      if ($('#total_minimo').val() == 0) {
        $('#precio_unitario').val(0);
      } else {
        $('#precio_unitario').val(parseFloat($('#importe').val() / $('#total_minimo').val()));
      }
    }
  });

  $('#moneda_id').on('change', function() {
    var tasa = $('#moneda_id option:selected').attr('data-tasa');
    var simbolo = $('#moneda_id option:selected').attr('data-simbolo');
    var nombre = $('#moneda_id option:selected').attr('data-nombre');

    $('#tasa').val(tasa);
    $('.tipo_moneda').html(simbolo);

    if ($(this).val() != $('#MONEDA_DEFECTO_ID').val()) {
      $('#block_tasa').show();
      $('#tasa').trigger('focus');
    } else {
      $('#block_tasa').hide();
    }
    $('#moneda_text').html(nombre);
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

    // Cargo las direcciones disponibles del cliente (direccion principal y direccion de sucursales)
    $.ajax({
      url: ruta + 'cliente/get_cliente_direcciones/' + $(this).val(),
      type: 'GET',
      success: function(data) {
        const cliente_direccion = $('#cliente_direccion');

        cliente_direccion.html('');

        for (var i = 0; i < data.direcciones.length; i++) {
          cliente_direccion.append(`
            <option value="${data.direcciones[i].direccion}">${data.direcciones[i].direccion}</option>
          `);
        }
      },
    });

    $.ajax({
      url: ruta + 'cliente/get_dir_entrega/' + $(this).val(),
      type: 'GET',
      success: function(data) {

        $('#dir_entrega').html('<option value="">Sin direccion</option>');
        $('#dir_entrega').
            append('<option value="0">Usar direccion por defecto</option>');

        for (var i = 0; i < data.dir_entregas.length; i++) {
          $('#dir_entrega').
              append('<option value="' + data.dir_entregas[i].id + '">' +
                  data.dir_entregas[i].direccion + '</option>');
        }
      },
    });
    refresh_totals();
  });

  // Llamo el evento para que se cargue cliente_direccion con el cliente seleccionado por defecto
  $('#cliente_id').trigger('change');

  $('#tipo_documento').on('change', function() {

    if ($(this).val() == '1') {

      if ($('#tipo_documento').val() == 1 &&
          $('#cliente_id option:selected').attr('data-ruc') != 2) {
        show_msg('warning',
            '<h4>Error. </h4><p>El Cliente no tiene ruc para realizar venta en factura.</p>');
        select_productos(49);
      }
    }

    if ($(this).val() == '6') {
      $('#tipo_impuesto').html(
          '<option value="1">Incluye impuesto</option>' +
          '<option value="2">Agregar impuesto</option>' +
          '<option value="3">No considerar impuesto</option>',
      );
      $("#prod_gratis").show();
    } else {
      $('#tipo_impuesto').html(
          '<option value="1">Incluye impuesto</option>' +
          '<option value="2">Agregar impuesto</option>',
      );
      $("#prod_gratis").hide();
    }

      refresh_right_panel();
  });

  $('#add_producto').on('click', function() {
    var canStock = $('#producto_id option:selected').attr('data-stock');
    var total = parseFloat($('#total_minimo').val());
    var stock = parseFloat($('#stock_actual').attr('data-stock'));

    if (total <= 0) {
      show_msg('warning',
          '<h4>Error. </h4><p>Inserte una cantidad para realizar la venta.</p>');
      $('.cantidad-input[data-index="0"]').first().trigger('focus');
      return false;
    } else if (total > stock && canStock == 1) {
      show_msg('warning', '<h4>Error. </h4><p>Stock Insuficiente.</p>');
      $('.cantidad-input[data-index="0"]').first().trigger('focus');
      return false;
    } else if ($('#editar_pu').attr('data-estado') == '1') {
      show_msg('warning',
          '<h4>Error. </h4><p>Por favor debe confirmar el Precio Unitario de Venta.</p>');
      $('#precio_unitario').trigger('focus');
      return false;
    } else if ($('#editar_su').attr('data-estado') == '1') {
      show_msg('warning',
          '<h4>Error. </h4><p>Por favor debe confirmar el Subtotal de Venta.</p>');
      $('#importe').trigger('focus');
      return false;
    }
    if ($('#descuento').val() != '' &&
        parseFloat($('#descuento').val()) >= 100) {
      show_msg('warning',
          '<h4>Error. </h4><p>El descuento no puede ser mayor que el 100%.</p>');
      $('#importe').trigger('focus');
      return false;
    }
    if (($('#descuento').val() != '' && $('#descuento').val() != 0) &&
        $('#p_gratis').prop('checked') == true) {
      show_msg('warning',
          '<h4>Error. </h4><p>Descuento y operacion gratuita no pueden estar configuradas al mismo tiempo.</p>');
      $('#importe').trigger('focus');
      return false;
    }

    if ($('#precio_unitario').val() == '' ||
        parseFloat($('#precio_unitario').val()) <= 0) {
      show_msg('warning', 'El precio tiene que ser mayor que 0');
      return false;
    }
    add_producto();
  });

  $('#close_add_producto').on('click', function() {
    $('#producto_id').html('<option></option>').change();
    $('#producto_complete').val('').focus();
  });

  $('#add_todos').on('click', function() {
    var index = $('.cantidad-input').length - 1;
    $('.cantidad-input').val('0');
    $('.cantidad-input[data-index="' + index + '"]').
        first().
        val($('#stock_actual').attr('data-stock'));
    refresh_totals();
  });

  $('#stock_actual').on('click', function() {
    var stock = $(this);
    var stock_total = $('#stock_total');

    var temp = stock.html();
    stock.html(stock.attr('data-template'));
    stock.attr('data-template', temp);

    var temp = stock_total.html();
    stock_total.html(stock_total.attr('data-template'));
    stock_total.attr('data-template', temp);

  });

  $('#tabla_vista').on('click', function() {
    update_view(get_active_view());
  });

  //EVENTOS DEL PANEL INFERIOR
  $('#terminar_venta').click('on', function(e) {

    let is_anticipos_activo = $("#is_anticipos_activo").val() == 1;

    if (false === is_anticipos_activo){

        if (validacionesFormularioVenta())
            end_venta();
      
    } else {
        let actorId = $("#cliente_id").val();
        let localId = $("#local_venta_id").val();
        let naturalezaActor = 1; /*cliente*/
        let idMoneda = document.querySelector("#moneda_id").value
        dataAnticipo = {
            'id_actor': actorId,
            'localId': localId,
            'naturalezaActor': naturalezaActor,
            'selectorSimboloMoneda': "#simbolo_moneda",
            'selectorTotal': "#total_importe",
            'idMoneda': idMoneda,
            'tipoPago': "#tipo_pago",
        }

        validacionesCreditoAnticipos(dataAnticipo)
            .then(res => { 

                if (res.status === "MAYOR")
                    return
              
                if (validacionesFormularioVenta())
                    end_venta();
              
            })
            .catch(error => {
              console.error(error)
            })
    }       

  });


  function validacionesFormularioVenta(){
    if ($('#fecha_venta').val() == '') {
      show_msg('warning', '<h4>Error. </h4><p>Ingrese la fecha de venta.</p>');
      return false;
    }

    var fecha_actual = new Date().getTime();
    var fecha = $('#fecha_venta').val().split('/');
    var fecha_venta = new Date(
        fecha[2] + '-' + fecha[1] + '-' + fecha[0]).getTime();
    if (fecha_actual - fecha_venta < 0) {
      show_msg('warning',
          '<h4>Error. </h4><p>No puede ingresar una fecha mayor a la actual.</p>');
      return false;
    }

    if (lst_producto.length == 0) {
      show_msg('warning',
          '<h4>Error. </h4><p>Debe agregar al menos un producto para realizar la venta.</p>');
      select_productos(51);
      return false;
    }

    if ($('#cliente_id').val() == 1 && $('#tipo_pago').val() == 2) {
      show_msg('warning',
          '<h4>Error. </h4><p>El Cliente frecuente no tiene credito.</p>');
      select_productos(49);
      return false;
    }

    if ($('#cliente_id').val() == 1 && $('#tipo_documento').val() == 1) {
      show_msg('warning',
          '<h4>Error. </h4><p>El Cliente frecuente puede realizar facturas.</p>');
      select_productos(49);
      return false;
    }

    $total_convertido = parseFloat($('#total_importe').val());
    if($('#moneda_id').val() != '1029') {
      $total_convertido = $total_convertido * parseFloat($('#tasa').val());
    }

    var clienteCodigo = $('#cliente_id option:selected').attr('data-codigo');
    var dni = $('#cliente_id option:selected').attr('data-identificacion');
    if (($('#cliente_id').val() == 1) && $('#tipo_documento').val() == 3 &&
    $total_convertido > 700) {
      show_msg('warning',
          '<h4>Error. </h4><p>El Cliente no puede realizar ventas mayores al monto actual. Es necesario una identificacion.</p>');
      select_productos(49);
      return false;
    }

    //Validar si es diferente a cliente frecuente, boleta de venta, el total de importe mayor a 700 y que sea un numero valido de dni
    if ($('#cliente_id').val() > 1 && clienteCodigo == '01' && $('#tipo_documento').val() == 3 &&
        (dni == '' || dni.length != 8)) {
      show_msg('warning',
          '<h4>Error. </h4><p>El n&uacute;mero de DNI del cliente no es v&aacute;lido</p>');
      return false;
    }

    if ($('#tipo_documento').val() == 1 &&
        $('#cliente_id option:selected').attr('data-ruc') != 2) {
      show_msg('warning',
          '<h4>Error. </h4><p>El Cliente no tiene ruc para realizar venta en factura.</p>');
      select_productos(49);
      return false;
    }

    if ($('#guia_id').val() != '') {
      if ($('#nro_guia').val() == '' || $('#dir_entrega').val() != '') {
        show_msg('warning', 'Debe completar todos los datos de remision');
        return false;
      }
    }

    return true;
  }


  $('#dialog_venta_imprimir').on('hidden.bs.modal', function() {
    $('#loading_save_venta').modal('show');
    $.ajax({
      url: ruta + 'venta_new',
      success: function(data) {
        $('#loading_save_venta').modal('hide');
        $('.modal-backdrop').remove();
        $('#page-content').html(data);
      },
    });
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
              var value = data.clientes[i].descripcioncorta + ': ';
              value += data.clientes[i].identificacion;
              value += ' - ' + data.clientes[i].razon_social;

              template += '<option value="' + data.clientes[i].id_cliente + 
                  '" data-identificacion="' + data.clientes[i].identificacion + '"' +
                  ' data-ruc="' + data.clientes[i].ruc + '">' +
                  value + '</option>';
              selected = data.clientes[i].id_cliente;
            }
          }

          $('#cliente_id').html(template);
          $('#cliente_complete').val(value);
          $('#cliente_id').val(selected).change()
        },
      });

      $.ajax({
        url: ruta + 'cliente/get_cliente_direcciones/' + dni,
        type: 'GET',
        success: function(data) {
          const cliente_direccion = $('#cliente_direccion');
  
          cliente_direccion.html('');
  
          for (var i = 0; i < data.direcciones.length; i++) {
            cliente_direccion.append(`
              <option value="${data.direcciones[i].direccion}">${data.direcciones[i].direccion}</option>
            `);
          }
        },
      });

      $.ajax({
        url: ruta + 'cliente/get_dir_entrega/' + dni,
        type: 'GET',
        success: function(data) {
  
          $('#dir_entrega').html('<option value="">Sin direccion</option>');
          $('#dir_entrega').
              append('<option value="0">Usar direccion por defecto</option>');
  
          for (var i = 0; i < data.dir_entregas.length; i++) {
            $('#dir_entrega').
                append('<option value="' + data.dir_entregas[i].id + '">' +
                    data.dir_entregas[i].direccion + '</option>');
          }
        },
      });
    }
  });

  $('#tipo_impuesto').on('change', function() {
    refresh_right_panel();
  });

  $('#p_gratis').on('change', function() {

    refresh_totals();
  });

  $('#descuento').on('keyup', function() {
    if (parseFloat($(this).val()) >= 100)
      $(this).val(0);

    refresh_totals();
  });

  $('#reiniciar_venta').on('click', function() {
    $('#confirm_venta_text').
        html(
            'Si reinicias la venta perderas todos los productos agregados. Estas seguro?');
    $('#confirm_venta_button').attr('onclick', 'reset_venta();');
    $('#dialog_venta_confirm').modal('show');
  });

  $('#cancelar_venta').on('click', function() {
    $('#confirm_venta_text').
        html(
            'Si cancelas la venta perderas todos los cambios realizados. Estas seguro?');
    $('#confirm_venta_button').attr('onclick', 'cancel_venta();');
    $('#dialog_venta_confirm').modal('show');
  });

  $('#stock_total').on('mousemove', function() {
    $('#stock_total').hide();
    $('#popover_stock').show();
  });

  $('#popover_stock').on('mouseleave', function() {
    $('#popover_stock').hide();
    $('#stock_total').show();
  });

  $('#precioUnitario').on('mouseleave', function() {
    $('#popover_precioUnitario').hide();
  });

  $('#precioUnitario').on('mousemove', function() {
    var data = {
      'id_producto': $('#producto_id').val(),
      'id_cliente': $('#cliente_id').val(),
    };
    $('#popover_precioUnitario').html('Cargando ...');
    $.ajax({
      url: ruta + 'venta_new/ultimasVentas',
      data: data,
      type: 'POST',
      success: function(data) {
        var obj = JSON.parse(data);
        var tabla = '<b>ULTIMOS PRECIOS UNITARIOS DE VENTAS</b>: <br><br>';
        tabla += '<table class="table table-condensed">';
        obj.map(function(data) {
          tabla += '<tr style="color:#fff; font-weight:bold">';
          var fecha = data.fecha.split('-');
          var nuevaFecha = fecha[2] + '/' + fecha[1] + '/' + fecha[0];
          tabla += '<td>' + nuevaFecha + '</td>';
          tabla += '<td>' + data.simbolo + ' ' + data.precio + '</td>';
          tabla += '<td>' + Math.round(data.cantidad) + '</td>';
          tabla += '<td>' + data.nombre_unidad + '</td>';
          tabla += '</tr>';
        });
        tabla += '</table>';
        $('#popover_precioUnitario').html(tabla);
      },
    });
    $('#popover_precioUnitario').show();
  });

  $('#costoUnitario').on('mouseleave', function() {
    $('#popover_costoUnitario').hide();
  });

  $('#costoUnitario').on('mousemove', function() {
    var data = {
      'id_producto': $('#producto_id').val(),
    };
    $('#popover_costoUnitario').html('Cargando ...');
    $.ajax({
      url: ruta + 'venta_new/ultimasCompras',
      data: data,
      type: 'POST',
      success: function(data) {
        var obj = JSON.parse(data);
        var tabla = '<b>ULTIMOS COSTOS UNITARIOS DE COMPRA</b>: <br><br>';
        tabla += '<table class="table table-condensed"> <thead> <tr> <th>Fecha</th>  <th>Cantidad</th>  <th>Costo</th>   <th>Costo Dolar</th>  <th>Tipo cambio</th>  <th>Total Cambio</th> </tr> </thead>';
        obj.map(function(data) {
          tabla += '<tr style="color:#fff; font-weight:bold">';
          var fecha = data.fecha.split('-');
          var nuevaFecha = fecha[2] + '/' + fecha[1] + '/' + fecha[0];
          tabla += '<td>' + nuevaFecha + '</td>';
          tabla += '<td>' + parseInt(data.cantidad) + ' ' + data.nombre_unidad +
              '</td>';

          if (data.simbolo != '$') {
            tabla += '<td>' + data.simbolo + ' ' + data.precio + '</td>';
          } else {
            tabla += '<td> </td>';
          }

          if (data.simbolo == '$') {
            tabla += '<td>' + data.simbolo + ' ' + data.precio + '</td>';
          } else {
            tabla += '<td> </td>';
          }
          // COSTO UNIT
          // tabla += '<td>' + (data.tasa_cambio != null ? data.tasa_cambio : '-') + '</td>';

          tabla += '<td>' +
              (data.tasa_cambio != null ? data.tasa_cambio : '-') + '</td>';
          tabla += '<td>' + (data.total != null ? 'S/. ' + data.total : '-') +
              '</td>';
          tabla += '</tr>';
        });
        tabla += '</table>';
        $('#popover_costoUnitario').html(tabla);
      },
    });
    $('#popover_costoUnitario').show();
  });
});

//FUNCIONES DE MANEJO DE LAS VENTAS

//dependiendo de la configuracion lanza el cuadro de dialogo para realizar la venta
function end_venta() {
  var estado = $('#venta_estado').val();
  var tipo_pago = $('#tipo_pago').val();
  var tipo_documento = $('#tipo_documento').val();
  var flag = false;
  let is_anticipos_activo = $("#is_anticipos_activo").val()==1; 

  if (estado == 'COMPLETADO') {
    //Contado
    if (tipo_pago == '1') {
      flag = true;

      var tp = $('#redondeo_total').val() == 1 ?
          formatPrice($('#total_importe').val()) :
          $('#total_importe').val();
      $('#vc_total_pagar').val(tp);

      $('#vc_importe').val($('#vc_total_pagar').val());
      $('#vc_vuelto').val(0);
      $('#vc_num_oper').val('');
      $('#contado_tipo_pago').val(tipo_pago);

      $('#dialog_venta_contado').modal('show');

      if (is_anticipos_activo) {
          $("#contentTablaAnticipos").show();
          let actorId = $("#cliente_id").val();
          let localId = $("#local_venta_id").val();
          let naturalezaActor = 1; /*cliente*/
          let idMoneda = document.querySelector("#moneda_id").value
          let dataAnticipo = {
              'id_actor': actorId,
              'localId': localId,
              'naturalezaActor': naturalezaActor,
              'selectorSimboloMoneda': "#simbolo_moneda",
              'selectorTotalPagar': "#vc_total_pagar",
              'idMoneda': idMoneda,
              'tipo_pago': "#tipo_pago",
          }

          setAnticipos(dataAnticipo);
      } else {
          $("#contentTablaAnticipos").hide();
      }


      setTimeout(function() {
        $('#vc_forma_pago').val('3').trigger('chosen:updated');
        $('#vc_forma_pago').change();
      }, 500);
    }
    //Credito
    else if (tipo_pago == '2') {
      flag = true;
      $('#c_cliente').val($('#cliente_id option:selected').text().trim());
      $('#c_fecha_giro').val($('#fecha_venta').val());
      credito_init($('#total_importe').val(), 'COMPLETADO');
      refresh_credito_window();

      $('#dialog_venta_credito').modal('show');
    }
  } else if (estado == 'CAJA') {
    //Contado
    if (tipo_pago == '1') {
      flag = true;
      caja_init($('#total_importe').val());
    }
    //Credito
    else if (tipo_pago == '2') {
      flag = true;
      $('#c_cliente').val($('#cliente_id option:selected').text().trim());
      $('#c_fecha_giro').val($('#fecha_venta').val());
      credito_init($('#total_importe').val(), 'CAJA');
      refresh_credito_window();
      $('#dialog_venta_credito').modal('show');
    }
  }

  if (flag == false) {
    show_msg('warning',
        '<h4>Error. </h4><p>Debe configurar los parametros correctamente. Por favor reviselos.</p>');
  }

}

function prepare_detalles_productos() {
  var productos = [];

  for (var i = 0; i < lst_producto.length; i++) {

    var cantidades = {};
    for (var j = 0; j < lst_producto[i].detalles.length; j++) {
      if (cantidades[lst_producto[i].detalles[j].unidad] == undefined)
        cantidades[lst_producto[i].detalles[j].unidad] = lst_producto[i].detalles[j].cantidad;
      else
        cantidades[lst_producto[i].detalles[j].unidad] += lst_producto[i].detalles[j].cantidad;
    }

    var precios = {};
    for (var j = 0; j < lst_producto[i].detalles.length; j++) {
      if (precios[lst_producto[i].detalles[j].unidad] == undefined)
        precios[lst_producto[i].detalles[j].unidad] = lst_producto[i].detalles[j].unidades;
    }

    for (var unidad in cantidades) {
      if (cantidades[unidad] != 0) {
        var producto = {};
        producto.id_producto = lst_producto[i].producto_id;
        producto.precio = precios[unidad] * lst_producto[i].precio_unitario;
        producto.precio_venta = precios[unidad] *
        lst_producto[i].precio_venta_unitario;
        producto.unidad_medida = unidad;
        producto.cantidad = cantidades[unidad];
        producto.cantidad_parcial =  lst_producto[i].total_minimo;;
        producto.detalle_importe = producto.cantidad * producto.precio;
        producto.p_gratis = lst_producto[i].p_gratis;
        producto.descuento = lst_producto[i].descuento;
        productos.push(producto);
      }
    }

  }

  return JSON.stringify(productos);

}

function prepare_traspasos() {
  var productos = [];
  var local_venta = $('#local_venta_id');

  for (var i = 0; i < lst_producto.length; i++) {

    var cantidades = {};
    for (var j = 0; j < lst_producto[i].detalles.length; j++) {
      if (lst_producto[i].detalles[j].local_id != local_venta.val()) {
        if (cantidades[lst_producto[i].detalles[j].local_id] == undefined)
          cantidades[lst_producto[i].detalles[j].local_id] = lst_producto[i].detalles[j].cantidad *
              lst_producto[i].detalles[j].unidades;
        else
          cantidades[lst_producto[i].detalles[j].local_id] = parseFloat(
              parseFloat(cantidades[lst_producto[i].detalles[j].local_id]) +
              parseFloat(lst_producto[i].detalles[j].cantidad *
                  lst_producto[i].detalles[j].unidades));
      }
    }

    for (var local_id in cantidades) {
      if (cantidades[local_id] != 0) {
        var producto = {};
        producto.id_producto = lst_producto[i].producto_id;
        producto.parent_local = local_venta.val(); //local de destino
        producto.cantidad = cantidades[local_id];
        producto.local_id = local_id; //local de origen
        productos.push(producto);
      }
    }
  }

  return JSON.stringify(productos);
}



function save_venta_contado(imprimir, remision_activate = 0) {

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

  //$("#save_venta_load").show();
  $('#loading_save_venta').modal('show');
  $('#dialog_venta_contado').modal('hide');
  $('.save_venta_contado').attr('disabled', 'disabled');

  var form = $('#form_venta').serialize();
  var detalles_productos = prepare_detalles_productos();
  var traspasos = prepare_traspasos();

  $.ajax({
    url: ruta + 'venta_new/save_venta',
    type: 'POST',
    dataType: 'json',
    data: form + '&detalles_productos=' + detalles_productos + '&traspasos=' +
    traspasos,
    success: function(data) {

      if (data.success == '1') {
        let id_venta = data.venta.venta_id;
        show_msg('success', data.msg);

        if ($("#is_anticipos_activo").val() == 1) 
          aplicarAnticipos(id_venta,1,"VENTA");

        if ($('#facturacion_electronica').val() == 1 &&
            data.venta.venta_status == 'COMPLETADO' &&
            (data.venta.id_documento == 1 || data.venta.id_documento == 3)) {
          if (data.facturacion.estado == 1 || data.facturacion.estado == 3) {
            show_msg('success',
                '<h4>Facturacion Electronica:</h4> ' + data.facturacion.nota);
          } else {
            show_msg('danger',
                '<h4>Facturacion Electronica:</h4> ' + data.facturacion.nota);
          }
        }
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
          var factId = data.facturacion ? data.facturacion.id : 0;
          if(remision_activate=="1"){ // si se ira a remision; 
            setCookie("venta_id", venta_id, 300);// 300 segundos
          }
          $.ajax({
            url: ruta + 'venta_new',
            success: function(data) {
              $('#loading_save_venta').modal('hide');
              $('.modal-backdrop').remove();
              $('#page-content').html(data);

              $.bootstrapGrowl('<p>IMPRIMIENDO VENTA</p>', {
                type: 'success',
                delay: 2500,
                allow_dismiss: true,
              });
              var url = ruta + 'venta_new/imprimir/' + venta_id + '/PEDIDO';

              if ($('#facturacion_electronica').val() == 1 && factId > 0) {
                url = ruta + 'facturacion/imprimir_ticket/' + factId;
              }
              $('#imprimir_frame_venta').attr('src', url);
            },
          });

        } else {
          $.ajax({
            url: ruta + 'venta_new',
            success: function(data) {
              $('#loading_save_venta').modal('hide');
              $('.modal-backdrop').remove();
              $('#page-content').html(data);
            },
          });
        }
      } else if (data.success == 3) {
        show_msg('warning', data.msg);
        var info = '';
        var sin_stock = JSON.parse(data.sin_stock);
        for (var i = 0; i < sin_stock.length; i++) {
          info += '<div class="row text-warning font-size: 1.3rem;">';
          info += '<div class="col-md-6">Local</div>';
          info += '<div class="col-md-6">' + sin_stock[i].local_nombre +
              '</div>';
          info += '</div>';
          info += '<div class="row text-warning font-size: 1.3rem;">';
          info += '<div class="col-md-6">Producto</div>';
          info += '<div class="col-md-6">' + sin_stock[i].producto_nombre +
              '</div>';
          info += '</div>';
          info += '<div class="row text-warning font-size: 1.3rem;">';
          info += '<div class="col-md-6">Cantidad Actual</div>';
          info += '<div class="col-md-6">' + sin_stock[i].cantidad_actual +
              '</div>';
          info += '</div>';
          info += '</div>';
          info += '<div class="row text-warning font-size: 1.3rem;">';
          info += '<div class="col-md-6">Cantidad a Vender</div>';
          info += '<div class="col-md-6">' + sin_stock[i].cantidad_vender +
              '</div>';
          info += '</div>';
          info += '<hr>';
        }
        $('#stock_modal_info').html(info);
        $('#loading_save_venta').modal('hide');
        $('#stock_modal').modal('show');
        $('.save_venta_contado').removeAttr('disabled');
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
    error: function() {
      $('#loading_save_venta').modal('hide');
      show_msg('danger', 'Ha ocurrido un error insperado, verifique su venta'); // aqui
      reset_venta();
    },
    complete: function() {
      $('.save_venta_contado').removeAttr('disabled');
    },
  });
}

// https://stackoverflow.com/questions/41012827/detect-print-events-from-iframe
// https://jsfiddle.net/anhhnt/nj851e52/
let printFrame = document.getElementById("imprimir_frame_venta");
let data_remision = { id_venta: "" };
printFrame.onload = function () {
  var mediaQueryList = printFrame.contentWindow.matchMedia('print');
  mediaQueryList.addListener(function (mql) {
    // var innerDoc = printFrame.contentDocument || printFrame.contentWindow.document;
    // let id_venta = $(innerDoc).find("#venta_id_x_remision").val();
    let id_venta = getCookie("venta_id");
    if( id_venta != "" && !isNaN(parseInt(id_venta)) )
      go_to_guia_remision(id_venta);
      eraseCookie("venta_id");
  });
};

function save_venta_credito(imprimir, remision_activate = 0) {

  //GARANTE OBLIGATORIO
  /*if ($("#c_garante").val() == '') {
   show_msg('warning', '<h4>Error. </h4><p>Por favor seleccione un Garante.</p>');
   setTimeout(function () {
   $("#c_garante").trigger('chosen:open');
   $('#c_garante_chosen .chosen-search input').trigger('focus');
   }, 500);
   return false;
   }*/

  if ($('#tipo_pago').val() == 2 &&
      parseFloat($('#c_saldo_inicial').val()) > 0) {
    if (isNaN(parseFloat($('#vc_importe').val()))) {
      show_msg('warning',
          '<h4>Error. </h4><p>El importe tiene que ser numerico.</p>');
      setTimeout(function() {
        $('#vc_importe').trigger('focus');
      }, 500);
      return false;
    }
  }

  if ($('#body_cuotas tr').length == 0) {
    show_msg('warning',
        '<h4>Error. </h4><p>Debe existir al menos una cuota.</p>');
    setTimeout(function() {
      $('#c_numero_cuotas').trigger('focus');
    }, 500);
    return false;
  }

  if (parseFloat($('#c_saldo_inicial').val()) ==
      parseFloat($('#c_precio_contado').val())) {
    show_msg('warning',
        '<h4>Error. </h4><p>El saldo inicial no puede ser igual al total de la deuda. Le recomendamos una venta al Contado</p>');
    setTimeout(function() {
      $('#c_saldo_inicial').trigger('focus');
    }, 500);
    return false;
  }

  if ($('#credito_respaldo').val() == '') {
    show_msg('warning',
        '<h4>Error. </h4><p>Debe seleccionar el credito resplado</p>');
    return false;
  }

  $('#loading_save_venta').modal('show');
  $('#dialog_venta_credito').modal('hide');
  $('.save_venta_credito').attr('disabled', 'disabled');
  $('#dialog_venta_contado').modal('hide');
  $('.save_venta_contado').attr('disabled', 'disabled');

  var form = $('#form_venta').serialize();
  var detalles_productos = prepare_detalles_productos();
  var traspasos = prepare_traspasos();
  var cuotas = prepare_cuotas();

  $.ajax({
    url: ruta + 'venta_new/save_venta',
    type: 'POST',
    dataType: 'json',
    data: form + '&detalles_productos=' + detalles_productos + '&traspasos=' +
    traspasos + '&cuotas=' + cuotas,
    success: function(data) {

      if (data.success == 1) {
        var id_venta = data.venta.venta_id;
        
        show_msg('success', data.msg);

        if ($("#is_anticipos_activo").val()==1) 
          aplicarAnticipos(id_venta,1,"VENTA");

        if (imprimir == '1') {
          $('#dialog_venta_imprimir').html('');

          setTimeout(function() {
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
          }, 500);
        } else if (imprimir == '2') {
          var venta_id = data.venta.venta_id;
          if(remision_activate=="1"){ // si se ira a remision; 
            setCookie("venta_id", venta_id, 300);// 300 segundos
          }
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
        } else {
          $.ajax({
            url: ruta + 'venta_new',
            success: function(data) {
              $('#loading_save_venta').modal('hide');
              $('.modal-backdrop').remove();
              $('#page-content').html(data);
            },
          });
        }
      } else if (data.success == 3) {
        show_msg('warning', data.msg);
        $('#loading_save_venta').modal('hide');
        $('.save_venta_credito').removeAttr('disabled');
      } else {
        if (data.msg) {
          show_msg('warning', data.msg);
        } else {
          show_msg('danger', 'Ha ocurrido un error insperado');
        }
        $('#loading_save_venta').modal('hide');
        $('.save_venta_credito').removeAttr('disabled');
      }
    },
    error: function() {
      $('#loading_save_venta').modal('hide');
      show_msg('danger', 'Ha ocurrido un error insperado, verifique su venta'); // aqui
      reset_venta();
    },
  });
}

function save_venta_caja(imprimir) {
  var tipo_pago = $('#tipo_pago').val();
  $('#dialog_venta_caja').modal('hide');

  if (tipo_pago == '1') {
    save_venta_contado(imprimir);
  } else if (tipo_pago == '2') {
    save_venta_credito(imprimir);
  }

}

//FUNCIONES INTERNAS

//funcion para agregar los productos de la venta
function add_producto() {

  is_edit = false;
  var producto_id = $('#producto_id').val();
  var local_id = $('#local_id').val();
  var precio_id = $('#precio_id').val();

  var index = get_index_producto(producto_id);

  if (index == -1) {
    //AGREGO EL PRODUCTO E INICIALIZO SUS VALORES
    var producto = {};
    producto.index = lst_producto.length;
    producto.producto_id = producto_id;
    producto.producto_impuesto = parseFloat(
        $('#producto_id option:selected').attr('data-impuesto'));
    producto.afectacion_impuesto = parseFloat(
        $('#producto_id option:selected').attr('data-afectacion_impuesto'));
    producto.producto_nombre = encodeURIComponent(
        $('#producto_id option:selected').text());
    producto.precio_id = precio_id;
    producto.precio_venta_unitario = parseFloat($('#precio_unitario').val());
    producto.precio_unitario = parseFloat($('#precio_unitario').val());
    producto.descuento = parseFloat($('#descuento').val());
    producto.descuento = isNaN(producto.descuento) ? 0 : producto.descuento;
    producto.p_gratis = $('#p_gratis').prop('checked') ? 1 : 0;
    producto.stock = $('#producto_id option:selected').attr('data-stock');
    producto.is_bolsa = $('#producto_id option:selected').attr('data-is_bolsa');

    producto.um_min = $('#um_minimo').html().trim();
    producto.um_min_abr = $('#um_minimo').attr('data-abr');

    producto.total_local = {};
    producto.detalles = [];

    if (producto.descuento > 0) {
      producto.p_gratis = 0;
      producto.precio_unitario -= parseFloat(
          producto.precio_unitario * producto.descuento / 100
      );
    }
    else if (producto.p_gratis == 1) {
      producto.precio_unitario = 0;
    }

    $('#local_id option').each(function() {
      var local = $(this);
      if (local.val() == local_id)
        producto.total_local['local' + local.val()] = parseFloat(
            $('#total_minimo').val());
      else
        producto.total_local['local' + local.val()] = 0;

      $('.cantidad-input').each(function() {
        var input = $(this);
        var detalle = {};

        detalle.local_id = local.val();
        detalle.local_nombre = encodeURIComponent(local.text());
        if (local.val() == local_id) {
          detalle.cantidad = isNaN(parseFloat(input.val())) ?
              0 :
              parseFloat(input.val());
        }
        else {
          detalle.cantidad = parseFloat(0);
        }
        detalle.unidad = input.attr('data-unidad_id');
        detalle.unidad_nombre = input.attr('data-unidad_nombre');
        detalle.unidad_abr = input.attr('data-unidad_abr');
        detalle.unidades = input.attr('data-unidades');
        detalle.orden = input.attr('data-orden');

        producto.detalles.push(detalle);

      });

    });

    producto.total_minimo = 0;
    for (var local_index in producto.total_local)
      producto.total_minimo += parseFloat(producto.total_local[local_index]);

    producto.subtotal = parseFloat(
        producto.total_minimo * producto.precio_unitario,
    );

    lst_producto.push(producto);
  } else {
    //EDITO LA INFORMACION DETALLADA DEL PRODUCTO
    lst_producto[index].precio_id = precio_id;
    lst_producto[index].precio_venta_unitario = parseFloat(
        $('#precio_unitario').val());
    lst_producto[index].precio_unitario = parseFloat(
        $('#precio_unitario').val());
    lst_producto[index].descuento = isNaN(parseFloat($('#descuento').val())) ?
        0 :
        parseFloat($('#descuento').val());
    lst_producto[index].p_gratis = $('#p_gratis').prop('checked') ? 1 : 0;

    lst_producto[index].total_local['local' + local_id] = parseFloat(
        $('#total_minimo').val());
    lst_producto[index].total_minimo = 0;
    for (var local_index in lst_producto[index].total_local)
      lst_producto[index].total_minimo += parseFloat(
          lst_producto[index].total_local[local_index]);

    if (lst_producto[index].descuento > 0) {
      lst_producto[index].p_gratis = 0;
      lst_producto[index].precio_unitario -= parseFloat(
          lst_producto[index].precio_unitario * lst_producto[index].descuento /
          100
      );
    }
    else if (lst_producto[index].p_gratis == 1) {
      lst_producto[index].precio_unitario = 0;
    }

    lst_producto[index].subtotal = parseFloat(
        lst_producto[index].total_minimo *
        lst_producto[index].precio_unitario);

    $('.cantidad-input').each(function() {
      var input = $(this);

      for (var i = 0; i < lst_producto[index].detalles.length; i++) {
        if (lst_producto[index].detalles[i].local_id == local_id &&
            lst_producto[index].detalles[i].unidad ==
            input.attr('data-unidad_id')) {
          lst_producto[index].detalles[i].cantidad = isNaN(
              parseFloat(input.val())) ?
              0 :
              parseFloat(input.val());
        }
      }

    });
  }

  $('#producto_id').html('<option></option>').change();
  $('#producto_complete').val('').focus();

  update_view(get_active_view());

  refresh_right_panel();

  setTimeout(function() {
    select_productos(51);
  }, 5);

}

//edita un producto en la tabla
function edit_producto(producto_id) {

  is_edit = true;
  var producto = {};
  for (var i = 0; i < lst_producto.length; i++) {
    if (lst_producto[i].producto_id == producto_id) {
      producto = lst_producto[i];
    }
  }
  var prod = $('#producto_id');
  var template = '<option value="' + producto.producto_id + '"';
  template += ' data-impuesto="' + producto.producto_impuesto + '"';
  template += ' data-afectacion_impuesto="' + producto.afectacion_impuesto +
      '"';
  template += '>' + decodeURIComponent(producto.producto_nombre) + '</option>';

  $('#producto_complete').val(decodeURIComponent(producto.producto_nombre));

  prod.html(template);
  prod.val(producto_id);
  prod.change();
}

//elimina un producto de la tabla
function delete_producto(item) {

  lst_producto.splice(item, 1);

  for (var i = 0; i < lst_producto.length; i++) {
    lst_producto[i].index = i;
  }
  update_view(get_active_view());
  refresh_right_panel();
  $('#producto_id').html('<option></option>').change();
}

//funcion para mostrar las tabla de los productos agregados
function update_view(type) {

  $('#body_productos').html('');
  if (lst_producto.length == 0)
    $('#head_productos').html('');
  else {
    switch (type) {
      case 'detalle': {
        $('#head_productos').html('<tr>' +
            '<th width="5%">#</th>' +
            '<th width="40%">Producto</th>' +
            '<th>Detalles</th>' +
            '<th>Acciones</th>' +
            '</tr>');

        for (var i = 0; i < lst_producto.length; i++) {
          addTable(lst_producto[i], type);
        }
        break;
      }
      case 'general': {
        $('#table_producto').css('white-space', 'nowrap');
        $('#head_productos').html('<tr>' +
            '<th width="5%">#</th>' +
            '<th width="40%">Producto</th>' +
            '<th>Total Minimo</th>' +
            '<th>Precio Lista</th>' +
            '<th>Precio Unitario</th>' +
            '<th>Subtotal</th>' +
            '<th>Acciones</th>' +
            '</tr>');

        for (var i = 0; i < lst_producto.length; i++) {
          addTable(lst_producto[i], type);
        }
        break;
      }
    }
  }
}

//añade un elemento a la tabla, tiene sus variaciones dependiendo del tipo de vista
function addTable(producto, type) {

  var template = '<tr>';
  template += '<td style="white-space: normal;">' + (producto.index + 1) +
      '</td>';
  template += '<td style="white-space: normal;">' +
      decodeURIComponent(producto.producto_nombre) +
      (producto.p_gratis == 1 ? ' (Transferencia Gratuita)' : '') + '</td>';
  if (type == 'general') {
    template += '<td style="text-align: center;">' + producto.total_minimo +
        ' (' + producto.um_min + ')</td>';
    template += '<td>' + producto.precio_venta_unitario.toFixed(fx) + '</td>';
    template += '<td>' + producto.precio_unitario.toFixed(fx) + '</td>';
    template += '<td>' + parseFloat(producto.subtotal).toFixed(2) + '</td>';
  }
  if (type == 'detalle') {
    template += '<td style="text-align: center; width: 400px;">';
    template += '<div class="row" style="margin: 0;">';
    template += '<div class="col-sm-3" style="background-color: #ADADAD; color: #fff;">Local</div>';
    template += '<div class="col-sm-3" style="background-color: #ADADAD; color: #fff; padding: 0;">Cantidad</div>';
    template += '<div class="col-sm-3" style="background-color: #ADADAD; color: #fff;">UM</div>';
    template += '<div class="col-sm-3" style="background-color: #ADADAD; color: #fff;">Unidades</div>';
    template += '</div>';

    var det = detalles_sort(producto.detalles);
    for (var i = 0; i < det.length; i++) {
      template += '<div class="row" style="margin: 0;">';
      if (det[i].cantidad != 0) {
        template += '<div class="col-sm-3" style="border: solid 1px #e2e2e2; padding: 0;">' +
            decodeURIComponent(det[i].local_nombre) + '</div>';
        template += '<div class="col-sm-3" style="border: solid 1px #e2e2e2;">' +
            det[i].cantidad + '</div>';
        template += '<div class="col-sm-3" style="border: solid 1px #e2e2e2;">' +
            det[i].unidad_abr + '</div>';
        template += '<div class="col-sm-3" style="border: solid 1px #e2e2e2;">' +
            det[i].unidades + ' ' + producto.um_min_abr + '</div>';
        template += '</div>';
      }
    }
    template += '</td>';
  }

  template += '<td style="text-align: center;">';
  template += '<div class="btn-group"><a class="btn btn-default" data-toggle="tooltip" title="Editar cantidad" data-original-title="Editar cantidad" onclick="edit_producto(' +
      producto.producto_id + ');">';
  template += '<i class="fa fa-edit"></i></a>';
  template += '</div>';
  template += '<div style="margin-left: 10px;" class="btn-group"><a class="btn btn-danger" data-toggle="tooltip" title="Eliminar" data-original-title="Eliminar" onclick="delete_producto(' +
      producto.index + ');">';
  template += '<i class="fa fa-trash-o"></i></a>';
  template += '</div>';
  template += '</td>';
  template += '</tr>';

  $('#body_productos').append(template);
}

//devuelve la vista activa
function get_active_view() {
  if ($('#tabla_vista').prop('checked'))
    return 'detalle';
  else
    return 'general';
}

//reinicio la venta, solo elimino los productos agregados pero mantengo el estado de la venta
function reset_venta() {
  lst_producto = [];
  update_view();
  refresh_right_panel();
  $('#dialog_venta_confirm').modal('hide');
}

//cancelo la venta, estado inicial y si la venta es en espera se elimina
function cancel_venta() {
  $('#dialog_venta_confirm').modal('hide');
  $('#loading_save_venta').modal('show');
  $.ajax({
    url: ruta + 'venta_new',
    success: function(data) {
      $('#page-content').html(data);
      $('#loading_save_venta').modal('hide');
      $('.modal-backdrop').remove();
    },
  });
}

//funcion dependiendo de la tecla muestra el select
function select_productos(tecla) {
  var id = '';
  switch (tecla) {
    case 49: {
      id = '#cliente_id';
      break;
    }
    case 50: {
      id = '#local_id';
      break;
    }
    case 51: {
      id = '#producto_id';
      break;
    }
      /*case 52:
       {
       if ($('.block_producto_unidades').css('display') != 'none')
       id = '#precio_id';
       break;
       }*/
    case 53: {
      id = '#moneda_id';
      break;
    }
    case 54: {
      id = '#tipo_pago';
      break;
    }
    case 55: {
      id = '#tipo_documento';
      break;
    }
    case 56: {
      id = '#venta_estado';
      break;
    }
  }

  if (id != '') {
    $(id).trigger('chosen:open');
    setTimeout(function() {
      $(id + '_chosen .chosen-search input').trigger('focus');
    }, 500);
  }
}

if (options.second_role) {
  $('#editar_pu, #editar_su').remove();
  $('#add_producto').removeAttr('disabled');
}

if (options.four_role) $('#add_producto').removeAttr('disabled');

//funcion para refrescar los totales cuando ocurren eventos
function refresh_totals() {
  var cantidad_input = $('.cantidad-input'),
      data_total = importe_total = total = 0,
      quantities = [];

  $('#producto_form').each(function(a, e) {
    $(e).find('div.col-md-3').each(function(e, o) {
      var input = $(o).find('.cantidad-input');
      quantities.push([parseInt(input.val()), input.data('unidades')]);
    });
  });

  var importe_total = 0;
  cantidad_input.each(function() {
    var defaultCost = parseFloat($('#producto_id').attr('data-costo')),
        input = $(this);
    if ($('#moneda_id').val() != $('#MONEDA_DEFECTO_ID').val()) {
      var tasa = parseFloat($('#tasa').val());
      defaultCost = defaultCost / tasa;
    }
    if (input.val()) {
      var descuento = isNaN(parseFloat($('#descuento').val())) ?
          0 :
          parseFloat($('#descuento').val());
      data_total += parseFloat(input.val() * input.attr('data-unidades'));
      var precio_unitario = $('#precio_unitario').val();
      var p_gratis = $('#p_gratis').prop('checked') ? 1 : 0;
      if (descuento > 0) {
        precio_unitario -= precio_unitario * descuento / 100;
      }
      else if (p_gratis == 1) {
        precio_unitario = 0;
      }

      if (options.third_role) {
        if (precio_unitario >= defaultCost) {
          var totalQuantities = 0;
          quantities.forEach(function(a, e) {
            totalQuantities += a[0] * a[1];
          });
          $('#add_producto').removeAttr('disabled');
        } else
          $('#add_producto').attr('disabled', 'disabled');
      }

      if (options.first_role) {
        if ($('.precio-selected').length) {
          var defaultSelected = parseFloat($('.precio-selected').val());
          if (precio_unitario >= defaultSelected) {
            $('#add_producto').removeAttr('disabled');
          }
        } else {
          var unitPrice = parseFloat($('#unit_price').val());
          if (precio_unitario >= unitPrice) {
            $('#add_producto').removeAttr('disabled');
          } else
            $('#add_producto').attr('disabled', 'disabled');
        }
      }

      importe_total += parseFloat(
          precio_unitario * input.val() * input.attr('data-unidades'));

      // if ($('#precio_id').val() == '3') {
      //   importe_total += parseFloat(
      //       precio_unitario * input.val() * input.attr('data-unidades'));
      // } else
      //   importe_total += parseFloat(
      //       $('#precio_' + input.attr('data-unidad_id')).val() * input.val());
    }
  });

  $('#total_minimo').val(data_total);
  // if (importe_total) {
  //   total = (importe_total).toString();
  //   total = total.substr(0, total.indexOf('.') + 5);
  // }
  $('#importe').val(importe_total.toFixed(fx)).attr('data-sub', total);
}

//function para refrescar el panel derecho
function refresh_right_panel() {

  if ($('#sc').val() == 1) {
    if ($('#tipo_documento').val() == 6)
      $('#stock_contable').hide();
    else
      $('#stock_contable').show();
  }

  if (lst_producto.length > 0) {
    $('#moneda_block_input').hide();
    $('#moneda_block_text').show();
    $('#tasa').attr('readonly', 'readonly');
  } else {
    $('#moneda_block_text').hide();
    $('#moneda_block_input').show();
    $('#tasa').removeAttr('readonly');
  }

  var total = 0;
  var tipo_moneda = $('#moneda_id option:selected').attr('data-tasa');
  var tasa = $('#tasa').val();
  var operacion = $('#moneda_id option:selected').attr('data-oper');

  var i_bolsa = parseFloat($('#IMP_BOLSA_VALOR').val());
  if ($('#moneda_id option:selected').val() != $('#MONEDA_DEFECTO_ID').val()) {
    i_bolsa = parseFloat(i_bolsa / tasa);
  }

  var total_bolsas = 0;
  for (var i = 0; i < lst_producto.length; i++) {
    total += lst_producto[i].subtotal;
    if (lst_producto[i].is_bolsa == 1) {
      total_bolsas += parseFloat(i_bolsa * lst_producto[i].total_minimo);
    }
  }

  if ($('#moneda_id option:selected').val() != $('#MONEDA_DEFECTO_ID').val()) {
    if ($('#have_dolar').length) {
      $('.precio-input').each(function() {
        // $(this).val(roundPrice(parseFloat($(this).attr('data-value') / tasa), fx, fx));
        $(this).val(parseFloat($(this).attr('data-value') / tasa));
      });
    } else {
      $('.precio-input').each(function() {
        var dolar = $(this).attr('data-value-dolar') > 0 ?  $(this).attr('data-value-dolar') : '_';
        if (dolar.search('_') != -1) {
          var value = $(this).attr('data-value');
          var tasa = $('#tasa').val();
          $(this).val(roundPrice(parseFloat(value) / parseFloat(tasa)), fx, fx);
          // $(this).val(parseFloat(value) / parseFloat(tasa));
          $('#pv_' + $(this).attr('data-unidad_id')).
              val(roundPrice(parseFloat(value) / parseFloat(tasa)), fx, fx);
        } else {
          // $(this).val(roundPrice(parseFloat(dolar != 'null' ? dolar : 0), fx, fx));
          $(this).val(parseFloat(dolar != 'null' ? dolar : 0));
          $('#pv_' + $(this).attr('data-unidad_id')).
              val(roundPrice(parseFloat(dolar != 'null' ? dolar : 0), fx, fx));
        }

        //
      });
    }
  } else {
    $('.precio-input').each(function() {
      // $(this).val(roundPrice(parseFloat($(this).attr('data-value')), fx, fx));
      $(this).val(parseFloat($(this).attr('data-value')));
    });
  }
  if ($('#moneda_block_input').css('display') != 'none') {
    var precio_unitario_minimo = $(
        '.precio-input[data-index="' + ($('.precio-input').length - 1) + '"]').
        first().
        val();
    $('#precio_unitario').val(precio_unitario_minimo);
    refresh_totals();
  }

  var subtotal = 0, impuesto = 0, total_importe = 0, total_descuento = 0;

  if ($('#tipo_impuesto').val() == 1) {
    total_importe = parseFloat(total);
    for (var i = 0; i < lst_producto.length; i++) {
      var afect_impuesto = lst_producto[i].afectacion_impuesto;

      if (afect_impuesto == 1) {
        var factor = parseFloat(
            (parseFloat(lst_producto[i].producto_impuesto) + 100) / 100);
        impuesto += parseFloat(
            lst_producto[i].subtotal - (lst_producto[i].subtotal / factor));
      }
    }
    subtotal = parseFloat(total_importe - impuesto);
  } else if ($('#tipo_impuesto').val() == 2) {
    subtotal = parseFloat(total);
    for (var i = 0; i < lst_producto.length; i++) {
      var afect_impuesto = lst_producto[i].afectacion_impuesto;

      if (afect_impuesto == 1) {
        var factor = parseFloat(
            (parseFloat(lst_producto[i].producto_impuesto) + 100) / 100);
        impuesto += parseFloat(
            (lst_producto[i].subtotal * factor) - lst_producto[i].subtotal);
      }
    }
    total_importe = parseFloat(subtotal + impuesto);
  } else if ($('#tipo_impuesto').val() == 3 &&
      $('#tipo_documento').val() == 6) {
    total_importe = parseFloat(total);
    subtotal = total;
    impuesto = parseFloat(0);
  }

  for (var i = 0; i < lst_producto.length; i++) {
    total_descuento += parseFloat(
        (lst_producto[i].total_minimo * lst_producto[i].precio_unitario) -
        (lst_producto[i].subtotal));
  }

  $('#total_importe').val(parseFloat(total_importe + total_bolsas).toFixed(2));
  $('#subtotal').val(parseFloat(subtotal).toFixed(2));
  $('#impuesto').val(parseFloat(impuesto).toFixed(2));
  $('#impuesto_bolsa').val(parseFloat(total_bolsas).toFixed(2));
  $('#total_descuento').val(parseFloat(total_descuento).toFixed(2));
  $('#total_producto').val(lst_producto.length);

}

//actualizo la informacion del stock
function set_stock_info() {

  $('#stock_actual').html('Calculando Stock...');
  $('#stock_total').html('Calculando Stock...');
  if ($('#sc').val() == 1) {
    $('#stock_contable').html('...');
  }

  var producto_id = $('#producto_id').val();
  var stock_total_minimo = 0;
  var total_minimo = 0;
  for (var i = 0; i < lst_producto.length; i++) {
    if (lst_producto[i].producto_id == producto_id) {

      stock_total_minimo += lst_producto[i].total_minimo;
      total_minimo = lst_producto[i].total_local['local' +
      $('#local_id').val()];
    }
  }

  $.ajax({
    url: ruta + 'venta_new/set_stock',
    type: 'POST',
    headers: {
      Accept: 'application/json',
    },
    data: {
      'stock_minimo': total_minimo,
      'stock_total_minimo': stock_total_minimo,
      'producto_id': producto_id,
      'local_id': $('#local_id').val(),
    },
    success: function(data) {
      if (data.stock_actual.max_um_id != data.stock_actual.min_um_id)
        $('#stock_actual').
            html(data.stock_actual.cantidad + ' ' +
                data.stock_actual.max_um_nombre + ' / ' +
                data.stock_actual.fraccion + ' ' +
                data.stock_actual.min_um_nombre);
      else
        $('#stock_actual').
            html(data.stock_actual.cantidad + ' ' +
                data.stock_actual.max_um_nombre);

      if (data.stock_total.max_um_id != data.stock_total.min_um_id)
        $('#stock_total').
            html(data.stock_total.cantidad + ' ' +
                data.stock_total.max_um_nombre + ' / ' +
                data.stock_total.fraccion + ' ' +
                data.stock_total.min_um_nombre);
      else
        $('#stock_total').
            html(data.stock_total.cantidad + ' ' +
                data.stock_total.max_um_nombre);

      if ($('#sc').val() == 1)
        if (data.shadow != undefined) {
          if (data.shadow.stock_min != undefined) {
            var stock = parseFloat(parseFloat(data.shadow.stock_min) -
                parseFloat(stock_total_minimo));
            if (stock > 0) {
              $('#stock_contable').addClass('label-success');
              $('#stock_contable').removeClass('label-danger');
            } else {
              $('#stock_contable').addClass('label-danger');
              $('#stock_contable').removeClass('label-success');
            }

            $('#stock_contable').
                html('SC: ' + stock + ' ' + data.shadow.unidad_abr);
          } else {
            $('#stock_contable').addClass('label-danger');
            $('#stock_contable').removeClass('label-success');
            $('#stock_contable').
                html(parseFloat('SC: -' + stock_total_minimo) +
                    data.shadow.unidad_nombre);
          }
        }

      $('#stock_actual').attr('data-stock', data.stock_minimo);
      $('#stock_total').attr('data-stock', data.stock_total_minimo);

      $('#stock_actual').
          attr('data-template',
              data.stock_minimo_left + ' ' + data.stock_actual.min_um_nombre);
      $('#stock_total').
          attr('data-template', data.stock_total_minimo_left + ' ' +
              data.stock_total.min_um_nombre);

      $.ajax({
        url: ruta + 'venta_new/set_stock_desglose',
        type: 'POST',
        headers: {
          Accept: 'application/json',
        },
        data: {
          'producto_id': producto_id,
        },
        success: function(data) {

          var popover_stock = $('#popover_stock');
          popover_stock.html('');
          for (var i = 0; i < data.stock_desgloses.length; i++) {
            var stock_text = '';
            if (data.stock_desgloses[i].max_um_id !=
                data.stock_desgloses[i].min_um_id)
              stock_text = data.stock_desgloses[i].cantidad + ' ' +
                  data.stock_desgloses[i].max_um_abrev + ' / ' +
                  data.stock_desgloses[i].fraccion + ' ' +
                  data.stock_desgloses[i].min_um_abrev;
            else
              stock_text = data.stock_desgloses[i].cantidad + ' ' +
                  data.stock_desgloses[i].max_um_abrev;

            var template = '<div class="row" style="margin-bottom: 3px;">';
            template += '<div class="col-md-6" style="text-align: left;">' +
                data.locales[i] + '</div>';
            template += '<div class="col-md-6" style="text-align: left;">' +
                stock_text + '</div>';
            template += '</div>';

            popover_stock.append(template);
          }
        },
      });

    },
  });

}

//creo el template de las unidades
function create_unidades_template(index, unidad, unidad_minima) {

  if (unidad_minima.id_unidad == unidad.id_unidad)
    unidad.unidades = 1;

  var template = '<div class="col-md-3">';
  template += '<div>';
  template += '<input type="number" class="input-square input-mini form-control text-center cantidad-input" ';
  template += 'id="cantidad_' + unidad.id_unidad + '" ';
  template += 'data-unidades="' + unidad.unidades + '" ';
  template += 'data-unidad_id="' + unidad.id_unidad + '" ';
  template += 'data-unidad_nombre="' + unidad.nombre_unidad + '" ';
  template += 'data-unidad_abr="' + unidad.abr + '" ';
  template += 'data-orden="' + unidad.orden + '" ';
  template += 'data-cualidad="' + unidad.producto_cualidad + '" ';
  template += 'data-index="' + index + '" ';
  template += 'onkeydown="return soloDecimal3(this, event);">';
  template += '</div>';

  template += '<h6>' + unidad.nombre_unidad + ' (' + unidad.unidades + ' ' +
      unidad_minima.abr + ')</h6>';

  template += '</div>';

  return template;
}

//preparo los valores de las unidades
function prepare_unidades_value(producto_id, local_id, unidad, def_value) {

  var cantidad = $('#cantidad_' + unidad.id_unidad);
  var cant = get_value_producto(producto_id, local_id, unidad.id_unidad, -1);
  if (cant == -1) {
    cantidad.attr('value', def_value);
    cantidad.attr('data-value', def_value);
  } else {
    cantidad.attr('value', cant);
    cantidad.attr('data-value', cant);
  }

  cantidad.attr('min', '0');
  cantidad.attr('step', '1');

  //if (unidad.producto_cualidad == 'MEDIBLE') {
  //   cantidad.attr('min', '0')
  //   cantidad.attr('step', '1')
  // } else {
  //   cantidad.attr('min', '0.0')
  //   cantidad.attr('step', '0.1')
  // }
}

function getDolar() {
  var tasa;
  $('#moneda_id option').each(function(e, a) {
    if ($(a).attr('data-simbolo') == '$')
      tasa_dolar = parseFloat($(a).attr('data-tasa'));
  });

  return tasa;
}

//suscribo eventos a las unidades
function prepare_unidades_events() {

  var cantidad_input = $('.cantidad-input');
  //selecciona la cantidad cuando haces focus
  cantidad_input.on('focus', function() {
    $(this).select();
  });

  //implementacion para poder navegar con las flechas
  var letra_left = 37, letra_right = 39;
  var max_index = cantidad_input.length - 1;

  cantidad_input.keydown(function(e) {
    var input = $(this);
    var index = input.attr('data-index');

    switch (e.keyCode) {
        //Moverse a travez de las unidades con la flecha de izquierda y derecha
      case letra_right: {
        e.preventDefault();
        var next = 0;
        if (index < max_index)
          next = ++index;
        $('.cantidad-input[data-index="' + next + '"]').
            first().
            trigger('focus');
        break;
      }
      case letra_left: {
        e.preventDefault();
        var prev = max_index;
        if (index > 0)
          prev = --index;
        $('.cantidad-input[data-index="' + prev + '"]').
            first().
            trigger('focus');
        break;
      }
    }

  });

  //calculo del total y el importe cuando hay cambios en las cantidades
  cantidad_input.on('input', function() {
    var item = $(this);
    if (item.val() != item.attr('data-value')) {
      item.attr('data-value', item.val());
      refresh_totals();
    }

  });
}

//creo el template para mostrar los precios
function create_precio_template(index, unidad) {
  var precio = $('#tipo_precio').val() == 'VENTA' ?
      unidad.precio * unidad.unidades :
      unidad.precio;
  var precio_dolar = $('#tipo_precio').val() == 'VENTA' ?
      unidad.precio_dolar * unidad.unidades :
      unidad.precio_dolar;
  var simbolo = $('#moneda_id option:selected').attr('data-simbolo');

  var input_pv = '<div style="display: none;" id="pv_block_' +
      unidad.id_unidad +
      '" class="input-group pv_block">';
  input_pv += '<div class="input-group-addon tipo_moneda" ';
  input_pv += 'style="padding: 0px; min-width: 25px;">' + simbolo + '</div>';
  input_pv += '<input type="text" style="text-align: center;" ';
  input_pv += 'class="form-control pv" ';
  input_pv += 'data-index="0" ';
  input_pv += 'id="pv_' + unidad.id_unidad + '" value="' + precio + '" ';
  input_pv += 'data-unidades="' + unidad.unidades + '" ';
  input_pv += 'onkeydown="return soloDecimal4(this, event);">';
  // input_pv += '<a data-estado="0" href="#" class="input-group-addon" ';
  // input_pv += 'style="padding: 0px; min-width: 25px;">';
  // input_pv += '<i class="fa fa-check"></i></a>';
  input_pv += '</div>';

  var template = '<div class="col-md-3">';
  template += '<div class="input-group">';
  template += '<div class="input-group-addon tipo_moneda">' + simbolo +
      '</div>';
  template += '<input type="button" class="form-control btn text-right precio-input" ';
  template += 'style="cursor: pointer" ';
  template += 'id="precio_' + unidad.id_unidad + '" ';
  template += 'value="' + precio + '" ';
  template += 'data-value="' + precio + '" ';
  template += 'data-value-dolar="' + precio_dolar + '" ';
  template += 'data-unidades="' + unidad.unidades + '" ';
  template += 'data-unidad_id="' + unidad.id_unidad + '" ';
  template += 'data-unidad_nombre="' + unidad.nombre_unidad + '" ';
  template += 'data-index="' + index + '" ';
  template += 'onkeydown="return soloDecimal(this, event);">';
  template += '<a href="#" class="input-group-addon add_precio" data-precio="precio_' +
      unidad.id_unidad + '"><i class="fa fa-check"></i></a>';
  template += '</div>';

  template += '<h6>' + unidad.nombre_unidad + ' <span id="per_' +
      unidad.id_unidad + '" class="per"></span></h6>';

  if ($('#tipo_precio').val() == 'VENTA') {
    template += input_pv;
  }

  template += '</div>';

  return template;
}

//preparo los valos iniciales de precio
function prepare_precio_value(producto_id, unidad_minima) {
  var precio = get_precio_producto(producto_id);
  var descuento = get_descuento_producto(producto_id);
  var gratis = get_gratis_producto(producto_id);

  $('#p_gratis').prop('checked', (gratis ? true : false));

  $('.precio-input').removeClass('precio-selected');
  $('#descuento').val(descuento > 0 ? descuento : 0);

  if (precio == -1) {
    $('#precio_unitario').val($('#precio_' + unidad_minima.id_unidad).val());
    $('#precio_unitario').
        attr('data-index', parseInt($('.precio-input').length - 1));
    $('#precio_unitario_um').html(unidad_minima.nombre_unidad);
    $('#precio_' + unidad_minima.id_unidad).addClass('precio-selected');
  } else {
    $('#precio_unitario').val(precio);
    $('.precio-input').each(function() {
      var input = $(this);

      if (input.val() == precio) {
        $('#precio_unitario').attr('data-index', input.attr('data-index'));
        $('#precio_unitario_um').html(input.attr('data-unidad_nombre'));
        input.addClass('precio-selected');
      }
    });
  }
}

//preparo los eventos de los precios
function prepare_precio_events() {

  var precio_input = $('.precio-input');

  precio_input.on('click', function(e) {
    var unidad_id = $(this).attr('data-unidad_id');
    e.preventDefault();
    $('.precio-input').removeClass('precio-selected');
    if ($('#tipo_precio').val() == 'VENTA') {
      $('#precio_unitario').val($(this).val() / $(this).attr('data-unidades'));
      $('.pv_block').hide();
      $('#pv_block_' + unidad_id).show();
      $('#pv_' + unidad_id).val($(this).val());
    }
    else {
      $('#precio_unitario').val($(this).val());
    }
    $('#precio_unitario').
        attr('data-index', parseInt($(this).attr('data-index')));
    $('#precio_unitario_um').html($(this).attr('data-unidad_nombre'));
    $(this).addClass('precio-selected');
    refresh_totals();
  });

  $('.pv').on('input', function() {
    $('#precio_unitario').val($(this).val() / $(this).attr('data-unidades'));
    refresh_totals();
  });

  $('.add_precio').on('click', function(e) {
    e.preventDefault();
    if ($('#tipo_precio').val() == 'VENTA') {
      $('#precio_unitario').
          val($('#' + $(this).attr('data-precio')).val() /
              $('#' + $(this).attr('data-unidades')).val());
    }
    else {
      $('#precio_unitario').val($('#' + $(this).attr('data-precio')).val());
    }
    $('#' + $(this).attr('data-precio')).click();
  });

}

//devuelve el indice del producto el el array lst_producto definido pro sus parametros
function get_index_producto(producto_id) {
  for (var i = 0; i < lst_producto.length; i++) {
    if (lst_producto[i].producto_id == producto_id) {
      return lst_producto[i].index;
    }
  }

  return -1;
}

//devuelve el valor del producto en el array lst_producto definido por sus parametros
function get_value_producto(producto_id, local_id, um_id, defecto) {
  for (var i = 0; i < lst_producto.length; i++) {
    if (lst_producto[i].producto_id == producto_id) {
      for (var j = 0; j < lst_producto[i].detalles.length; j++) {
        if (lst_producto[i].detalles[j].local_id == local_id &&
            lst_producto[i].detalles[j].unidad == um_id)
          return lst_producto[i].detalles[j].cantidad;
      }
    }
  }
  if (defecto != undefined)
    return defecto;
  else
    return 0;
}

function get_precio_producto(producto_id) {
  for (var i = 0; i < lst_producto.length; i++) {
    if (lst_producto[i].producto_id == producto_id) {
      return lst_producto[i].precio_venta_unitario;
    }
  }

  return -1;
}

function get_descuento_producto(producto_id) {
  for (var i = 0; i < lst_producto.length; i++) {
    if (lst_producto[i].producto_id == producto_id) {
      return lst_producto[i].descuento;
    }
  }

  return -1;
}

function get_gratis_producto(producto_id) {
  for (var i = 0; i < lst_producto.length; i++) {
    if (lst_producto[i].producto_id == producto_id) {
      return lst_producto[i].p_gratis;
    }
  }

  return 0;
}

//funcion para organizar la unidades de medida
function detalles_sort(detalles) {

  detalles.sort(function(a, b) {
    return parseInt(a.orden) - parseInt(b.orden);
  });

  return detalles;

}

function show_msg(type, msg) {
  $.bootstrapGrowl(msg, {
    type: type,
    delay: 5000,
    allow_dismiss: true,
  });
}
function getproductosbylocal() {
  $('#cargando_modal').modal({
    show: true,
    backdrop: 'static',
  });
  $.ajax({
    url: ruta+'producto/getbylocal',
    data: {'local': $('#locales').val()},
    type: 'post',
    success: function(data) {

      $('#productostable').html(data);
      $('#cargando_modal').modal('hide');
    },
  });
}
/*AGREGAR PRODUCTO NUEVO*/

function agregar_prod() {
  $('#productomodal').load(ruta+'producto/agregar', function() {
    $('#btnGuardar').removeAttr('onclick');
    $('#btnGuardar').attr('onclick', 'confirm_save(\'venta\')');
  });
  $('#productomodal').modal('show');
}


function update_producto(id, nombre, impuesto, producto_id) {

  $('#producto_complete').val(id+' - '+nombre);
  $('#producto_id').
      append('<option value="' + producto_id + '">' + id + ' - ' + nombre +
          '</option>');
  $('#producto_id').val(producto_id);
  $('#producto_id').trigger('change');
  $('.modal-backdrop').remove();
}


function agregarfamilia() {
  $('#formagregarfamilia').trigger('reset');
  $('#agregarfamilia').modal('show');
  setTimeout(function() {
    $('#confirmar_boton_familia').removeAttr('onclick');
    $('#confirmar_boton_familia').
        attr('onclick', 'guardar_familia(\'producto\')');

  }, 10);
}

function agregarmarca() {
  $('#formagregarmarca').trigger('reset');
  $('#agregarmarca').modal('show');
  setTimeout(function() {
    $('#confirmar_boton_marca').removeAttr('onclick');
    $('#confirmar_boton_marca').attr('onclick', 'guardar_marca(\'producto\')');

  }, 10);
}

function agregargrupo() {
  $('#formagregargrupo').trigger('reset');
  $('#agregargrupo').modal('show');
  setTimeout(function() {
    $('#confirmar_boton_grupo').removeAttr('onclick');
    $('#confirmar_boton_grupo').attr('onclick', 'guardar_grupo(\'producto\')');
  }, 10);
}

function agregarproveedor() {
  $('#formagregarproveedor').trigger('reset');
  $('#agregarproveedor').modal('show');
  setTimeout(function() {
    $('#confirmar_boton_proveedor').removeAttr('onclick');
    $('#confirmar_boton_proveedor').
        attr('onclick', 'guardar_proveedor(\'producto\')');
  }, 10);
}

function agregarlinea() {
  $('#formagregarlinea').trigger('reset');
  $('#agregarlinea').modal('show');
  setTimeout(function() {
    $('#confirmar_boton_linea').removeAttr('onclick');
    $('#confirmar_boton_linea').attr('onclick', 'guardar_linea(\'producto\')');
  }, 10);
}