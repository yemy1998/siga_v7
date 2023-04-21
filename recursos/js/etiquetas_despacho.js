let ventasToPrint     = [];
const fontSize        = document.querySelector(`#fontSize`)
const fontSizeDefault = {
    'A4' : '40',
    '1/2': '23',
    '1/4': '20',
    '1/8': '20',
};

$(function() {

  $('[data-toggle="tooltip"]').tooltip();

  $('input[name="daterange"]').daterangepicker({
    'locale': {
      'format': 'DD/MM/YYYY',
      'separator': ' - ',
      'applyLabel': 'Aplicar',
      'cancelLabel': 'Cancelar',
      'fromLabel': 'De',
      'toLabel': 'A',
      'customRangeLabel': 'Personalizado',
      'daysOfWeek': [
        'Do',
        'Lu',
        'Ma',
        'Mi',
        'Ju',
        'Vi',
        'Sa'
      ],
      'monthNames': [
        'Enero',
        'Febrero',
        'Marzo',
        'Abril',
        'Mayo',
        'Junio',
        'Julio',
        'Agosto',
        'Septiembre',
        'Octubre',
        'Noviembre',
        'Diciembre'
      ],
      'firstDay': 1
    }
  })


   get_ventas()

  const tipos_formatos = document.querySelectorAll(`input[type="radio"][name="tipo_formato"]`);

  for (let tipo_formato of tipos_formatos) {
    tipo_formato.addEventListener('change', function(e){setFontSizeDefault(this.value)})
  }

});

$('#btn_buscar').on('click', function () {
    ventasToPrint = []
    get_ventas()
})

/**
 * @param domElement checkbox input checkbox
 * @param number idVenta
 */
function selectVenta(checkbox,idVenta){
  if (checkbox.checked)
    addVenta(idVenta)
  else
    removeVenta(idVenta);
}

/**
 * Cambiar cantidad del input de una fila de venta
 * 
 * @param domElement inputCantidad input
 * @param number idVenta
 */
function changeCantidad (inputCantidad,idVenta){

  let newCantidad = parseInt(inputCantidad.value, 10);

  if (newCantidad == 0)
      inputCantidad.value = 1;

  for (let venta of ventasToPrint) {
    if (venta.idVenta  == idVenta)
      venta.cantidad = newCantidad
  }

}

/**
 * Añadir datos de una venta las cuales serán impresas
 * 
 * @param number idVenta
 */
const addVenta = idVenta => {

   let cantidad = document.querySelector(`[data-id-cantidad="${idVenta}"]`).value;
   cantidad     = parseInt(cantidad, 10);

   ventasToPrint.push({idVenta:idVenta, cantidad: cantidad});
}

/**
 * Remover una venta que fue deseleccionada
 * 
 * @param number idVenta
 */
const removeVenta = idVenta => {
  ventasToPrint = ventasToPrint.filter((venta) => venta.idVenta != idVenta);
}


const isCantidadValida = ventasToPrint => {

  let noValidos = ventasToPrint.filter(venta => Number.isNaN(venta.cantidad) == true);

  if (noValidos.length > 0){
    for (let noValido of noValidos) {
      showNotification('danger',`Cantidad para impresión no es valida en ticket de Venta ID: ${noValido.idVenta}`)
    }
    return false;
  }

  return true;

}

const isFontSizeValida = fontSizeValor => {

  let fontSizeInt = parseInt(fontSizeValor, 10);

  if (Number.isNaN(fontSizeInt)){
    showNotification('danger',`El tamaño de letra colocado no es valido`)
    return false;
  }

  return true;
}

const showNotification = (tipo,msg) => {

    $.bootstrapGrowl(`<h4>${msg}</h4>`, {
      type: tipo,
      delay: 3000,
      allow_dismiss: true
    })
}

/**
 * @description Traer tabla de despachos manera asincornica
 */
function get_ventas() {

  let data = {
    'fecha': $('#date_range').val(),
    'local_id': $('#local_id').val(),
    'id_moneda': $('#id_moneda').val(),
    'id_vendedor': $('#id_vendedor').val()
  }
  
  $('#load_div').show()
  $.ajax({
    url: url + 'etiquetas_despacho/getDataTable',
    data: data,
    type: 'POST',
    success: function (datos) {
      $('#load_div').hide()
      $('#tabla_lista').html(datos)
    },
    error: function () {
      $.bootstrapGrowl('<h4>Error.</h4> <p>Ha ocurrido un error en la operaci&oacute;n</p>', {
        type: 'danger',
        delay: 5000,
        allow_dismiss: true
      })
      $('#load_div').hide()
      $('#tabla_lista').html('')
    }
  })
}

function printTicket() {

  if (ventasToPrint.length == 0){
    showNotification('warning',`Debe seleccionar los tickets a imprimir`)
    return;
  }

  if(!isCantidadValida(ventasToPrint))
    return;

  if(!isFontSizeValida(fontSize.value))
    return;

  if (fontSize.value == 0)
      inputCantidad.value = 1;


  const formato = {
    'tamano': document.querySelector(`[name="tipo_formato"]:checked`).value,
    'aling': document.querySelector(`#aling`).value,
    'fontSize': fontSize.value,
  }

  window.open(`${url}etiquetas_despacho/imprimirTickets?ventas=${JSON.stringify(ventasToPrint)}&formato=${JSON.stringify(formato)}`);
  
}

function setFontSizeDefault(formatoSelect){
  fontSize.value = fontSizeDefault[formatoSelect];
}