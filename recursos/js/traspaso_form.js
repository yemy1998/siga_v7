var lst_producto = [];
var datos_globales = [];

$(document).ready(function() {
  // este codigo es para que al abrir un modal encima de otro modal no se pierda el scroll
  $('.modal').on('hidden.bs.modal', function(e) {
    if ($('.modal:visible').length) {
      $('.modal-backdrop').
          first().
          css('z-index',
              parseInt($('.modal:visible').last().css('z-index')) - 10);
      $('body').addClass('modal-open');
    }
  }).on('show.bs.modal', function(e) {
    if ($('.modal:visible').length) {
      $('.modal-backdrop.in').
          first().
          css('z-index',
              parseInt($('.modal:visible').last().css('z-index')) + 10);
      $(this).
          css('z-index',
              parseInt($('.modal-backdrop.in').first().css('z-index')) + 10);
    }
  });
  //APLICANDO BUSQUEDA AL SELECT DEL PRODUCTO
  setTimeout(function() {
    jQuery('#select_prodc').chosen({search_contains: true});
    $('select').chosen();
  }, 500);

  $('#select_prodc').on('change', function(e) {
    $('#loading').show();
    if ($('#select_prodc').val() != '') {
      e.preventDefault();
      $.ajax({
        url: ruta + 'traspaso/form_buscar',
        type: 'POST',
        dataType: 'json',
        data: {
          'producto_id': $('#select_prodc').val(),
          'local_id': $('#localform1').val(),
        },
        success: function(data) {
          datos_globales = data;
          var cantidad_prod = data.cantidad_prod;
          var um = data.um;
          var prod_und = data.stock_actual_2;
          //MUESTRA EL STOCK ACTUAL DEL PRODUCTO
          $('#mostrar_nombres').html('');
          var cad = '';
          if (cantidad_prod['fraccion'] > 0) {
            cad = ' / ' + cantidad_prod['fraccion'] + ' ' +
                um['nombre_fraccion'];
          }
          $('#mostrar_nombres').
              append('<label>' + cantidad_prod['cantidad'] + ' ' +
                  um['nombre_unidad'] + cad + '</label>');
          //GENERA LA TABLA DEACUERDO A LAS UNIDADES
          var tabla = '<div class="col-md-2"></div>';
          for (let x = 0; x < prod_und.length; x++) {
            tabla += '<div class="col-md-2">';
            tabla += '<input type="number" name="cantidad" id="cantidad_' +
                (x + 1) +
                '" required="true" class="form-control" value="" autocomplete="off">';
            tabla += '<h6>' + prod_und[x]['nombre_unidad'] + '(' +
                prod_und[x]['unidades'] + ' ' + prod_und[x]['abreviatura'] +
                ')' + '</h6>';
            tabla += '</div>';
          }
          tabla += '<div class="col-md-2">';
          tabla += '<a class="btn btn-primary" data-placement="bottom" style="margin-top:-2.2%;cursor: pointer;" onclick="agregarProducto();">Agregar</a>';
          tabla += '</div>';
          $('#mostrar_input').html(tabla);

          setTimeout(function() {
            $('#loading').hide();
            $('#abrir_info').show();
          }, 1);
        },
        error: function(data) {
          $('#loading').hide();
          mensaje('warning', '<h4>Ocurrio un error al buscar el producto</p>');
        },
      });
    } else {
      mensaje('warning',
          '<h4>Datos incompletos</h4> <p>Debe seleccionar un producto</p>');
    }
  });

  $('#dialog').dialog({
    autoOpen: false,
    modal: true,
  });
});

function cancelarcerrar() {
  $('#confirmarcerrar').modal('show');
}

function preguntar() {
  if (lst_producto.length <= 0) {
    mensaje('warning',
        '<h4>Datos incompletos</h4> <p>Debe seleccionar un producto</p>');
  }
  if ($('#localform2').val() == '') {
    mensaje('warning',
        '<h4>Datos incompletos</h4> <p>Debe seleccionar una ubicación de destino</p>');
  }
  if ((lst_producto.length > 0) && ($('#localform2').val() != '')) {
    $('#MsjPreg').modal('show');
  }
}

function cambiarlocal() {
  $('#serie').val('');
  $('#correlativo').val('');
  $('#documento').val('');
  $('#documento').trigger('chosen:updated');
  if (lst_producto.length > 0) {
    mostrar_advertencia();
  } else {
    local_actual = $('#localform1').val();
    $('#abrir_info').hide();
    productos_porlocal_almacen(); //RELLENA EL SELECT DEL PRODUCTO
  }
}

//este metodo agrega y edita la tabla de los productos
function agregarProducto() {
  //VALIDACIONES
  var validar = true;
  if ($('#select_prodc').val() == '') {
    $('#cantidad_1').focus();
    validar = mensaje('warning',
        '<h4>Datos incompletos</h4> <p>Debe seleccionar un producto</p>');
  }

  var n = 0;
  var cantidad = suma_en_entrada = 0;
  for (let x = 0; x < datos_globales.stock_actual_2.length; x++) {
    cantidad = $('#cantidad_' + (x + 1)).val();
    if (cantidad == '' || cantidad < 1 || isNaN(cantidad)) {
      n++;
    } else {
      suma_en_entrada += parseInt(cantidad) *
          datos_globales.stock_actual_2[x]['unidades'];
    }
  }

  if (datos_globales.stock_actual_2.length == n) {
    validar = mensaje('warning', '<h4>Debe ingresar una cantidad válida.</h4>');
  }

  if (suma_en_entrada > datos_globales['stock_minimo']) {
    validar = mensaje('warning',
        '<h4>Ha ingresado una cantidad mayor a el stock actual</h4>');
  }
  //Convirtiendo a fraccion a partir de la segunda unidad
  var suma_en_entrada2 = cantidad2 = 0;
  for (let x = 1; x < datos_globales.stock_actual_2.length; x++) {
    if ($('#cantidad_' + (x + 1)).val() == '' ||
        parseInt($('#cantidad_' + (x + 1)).val()) < 0) {
      cantidad2 = 0;
    } else {
      cantidad2 = $('#cantidad_' + (x + 1)).val();
    }
    suma_en_entrada2 += parseInt(cantidad2) *
        datos_globales.stock_actual_2[x]['unidades'];
  }

  var cantidadMax = $('#cantidad_1').val();
  if ($('#cantidad_1').val() == '' || parseInt($('#cantidad_1').val()) < 0) {
    cantidadMax = 0;
  }

  //Llenando en el arreglo
  if (validar == true) {
    var index = get_index_producto($('#select_prodc').val(),
        $('#localform1').val());

    if (index == -1) {
      var producto = {};
      producto.local_id = $('#localform1').val();
      producto.local_nombre = $('#localform1 option:selected').text();
      producto.index = lst_producto.length;
      producto.producto_nombre = $('#select_prodc option:selected').text();
      producto.producto_id = $('#select_prodc').val();
      producto.cantidad = cantidadMax;
      producto.fraccion = suma_en_entrada2;
      producto.cantidad2 = suma_en_entrada;
      producto.unidad = datos_globales.stock_actual_2[datos_globales.stock_actual_2.length -
      1]['nombre_unidad'];
      lst_producto.push(producto);
    } else {
      lst_producto[index].cantidad = lst_producto[index].cantidad2 = cantidadMax;
      lst_producto[index].fraccion = suma_en_entrada2;
      //'.cant-x-').text(cantidadMax);
    }
    //Preparar para agregar otro producto
    $('#cantidad_1').focus();
    $('#abrir_info').hide();
    $('#select_prodc').val('').trigger('chosen:updated');
    updateView(index);
  }
}

//refresca la tabla con la vista seleccionada
function updateView() {
  $('#body_productos').html('');
  $('#head_productos').html('<tr>' +
      '<th style="text-align: center">#</th>' +
      '<th style="text-align: center">Producto</th>' +
      '<th style="text-align: center">Unidad</th>' +
      '<th style="text-align: center">Cantidad</th>' +
      '<th style="text-align: center">Acciones</th>' +
      '</tr>');
  for (var i = 0; i < lst_producto.length; i++) {
    addTable(lst_producto[i], i);
  }
}

//añade un elemento a la tabla, tiene sus variaciones dependiendo del tipo de vista
function addTable(producto, index) {
  var template = '<tr>';
  template += '<td>' + (parseInt(producto.index) + parseFloat(1)) + '</td>';
  template += '<td>' + decodeURIComponent(producto.producto_nombre) + '</td>';
  template += '<td style="text-align: center">' + producto.unidad + '</td>';
  template += '<td style="text-align: center" class="cant-x-' + index + '">' +
      producto.cantidad2 + ' </td>';
  template += '<td style="text-align: center">';
  template += '<div style="margin-left: 10px;" class="btn-group"><a class="btn btn-danger" data-toggle="tooltip" title="Eliminar" data-original-title="Eliminar" onclick="delete_producto(' +
      producto.index + ');">';
  template += '<i class="fa fa-trash-o"></i></a>';
  template += '</div>';
  template += '</td>';
  template += '</tr>';
  $('#body_productos').append(template);
}

//funcion interna para sacar el indice del listado dependiendo de sus parametros
function get_index_producto(producto_id, local_id) {
  for (var i = 0; i < lst_producto.length; i++) {
    if (lst_producto[i].producto_id == producto_id &&
        lst_producto[i].local_id == local_id) {
      return lst_producto[i].index;
    }
  }
  return -1;
}

//Eliminar item
function delete_producto(item) {
  lst_producto.splice(item, 1);

  for (var i = 0; i < lst_producto.length; i++) {
    lst_producto[i].index = i;
  }
  updateView();
  $('#abrir_info').hide();
  $('#select_prodc').val('').trigger('chosen:updated');
}

function IrGuardar() {
  $('#MsjPreg').modal('hide');
  guardar();
}

function cerrartransferir_mercancia() {
  $('#MsjPreg').modal('hide');
}

// ESTADOS

$('input[type=radio][name=radio_status]').change(function() {
  if ($('input[type=radio][name=\'radio_status\']:checked').val() !=
      $('#btn_confirmar_status').data('id-status'))
    $('#btn_confirmar_status').prop('disabled', false);
  else
    $('#btn_confirmar_status').prop('disabled', true);
});

function guardar_status() {
  if (($('input[type=radio][name=\'radio_status\']:checked').val() == '3') ||
      ($('input[type=radio][name=\'radio_status\']:checked').val() == '4')) {
    let status = $('input[type=radio][name=\'radio_status\']:checked + label').
        text();
    let SplitText = '¿Está seguro de que desea cambiar el estado a ' +
        status.toUpperCase() + ' de forma permanente?';
    let dialog = $('<div></div>').html(SplitText).dialog({
      modal: true,
      title: 'Confirmar',
      autoOpen: true,
      width: '600px',
      resizable: false,
      buttons: [
        {
          text: 'Sí, cambiar',
          open: function() {
            $(this).addClass('btn btn-primary');
          },
          click: function() {
            enviar_status();
            $('input[type=radio][name=radio_status]').attr('disabled', true);
            $(this).dialog('close');
          },
        },
        {
          text: 'Cancelar',
          open: function() {
            $(this).addClass('btn btn-default');
          },
          click: function() {
            $(this).dialog('close');
          },
        }],
    });
    dialog.dialog('open');
  }
  else {
    enviar_status();
  }
}
function enviar_status() {
  $('#btn_confirmar_status').attr('disabled', true);
  let status = $('input[type=radio][name=\'radio_status\']:checked').val();
  $.ajax({
    url: ruta + 'traspaso/guardarStatus',
    data: '&id_traspaso=' + $('#btn_confirmar_status').data('id-traspaso') +
    '&id_status=' + status + '&comentario=' + $('#status-comentario').val(),
    type: 'post',
    dataType: 'json',
    success: function(data) {
      if (data) {
        $('#btn_confirmar_status').data('id-status', status);
        $('.switch-container .alert-success').
            fadeTo(2000, 5000).
            slideUp(500, function() {
              $('.switch-container .alert-success').slideUp(500);
            });
        mensaje('success',
            '<h4>Bien hecho!</h4><p>El estado ha sido guardado satisfactoriamente.</p>');
        cerrar_status();
      }
    },
    error: function(){
      show_msg('danger', 'Ha ocurrido un error inesperado');
    }
  });
}
function cerrar_status() {
  $('#verModal').modal('hide');
  buscar();
}

$('#documento').change(function() {
  let documento = $(this).val();
  let local = $('#localform1').val();
  if ((local != '') && (documento != '')) {
    $.ajax({
      url: ruta + 'traspaso/correlativos',
      type: 'POST',
      dataType: 'json',
      data: {id_local: local, id_documento: documento},
      success: function(data) {
        $('#serie').val(data[0].serie);
        $('#form-correlativo').val(data[0].correlativo);
      },
    });
  }
});
