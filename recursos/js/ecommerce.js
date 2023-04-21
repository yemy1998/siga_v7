  var tabla;
  var Files = new Array();

  var mbForSeconds = 0.08655100549970354;

  var filesize = 0
  var suma = 0;
  var contador = 0;
  var limit = 0;
  var interval;

  var tableWithFile = false;
  var objConfig = {
      processing: true,
      serverSide: true,
      orderable: true,
      scrollX: true,
      order: [[ 0, 'desc' ]],
      ajax: {
        type: 'post',
        url: `${ruta}ecommerce/getPaginate`,
        data(d){
          d.filters = {
            marca: $('#marca').val(),
            grupo: $('#grupo').val(),
          }
        }
      },
      language: {
        emptyTable: "No se encontraron registros",
        info: "Mostrando _START_ a _END_ de _TOTAL_ resultados",
        infoEmpty: "Mostrando 0 a 0 de 0 resultados",
        infoFiltered: "(filtrado de _MAX_ total resultados)",
        infoPostFix: "",
        thousands: ",",
        lengthMenu: "Mostrar _MENU_ resultados",
        loadingRecords: "Cargando...",
        processing: "Procesando...",
        zeroRecords: "No se encontraron resultados",
        paginate: {
          first: "Primero",
          last: "Ultimo",
          next: "Siguiente",
          previous: "Anterior"
        },
        aria: {
          sortAscending: ": activar ordenar columnas ascendente",
          sortDescending: ": activar ordenar columnas descendente"
        }
      },
      columnDefs: [
            { 
                targets: 0,
                "class":          "details-control",
                "orderable":      false,
                "data":           null,
                "defaultContent": "",
                visible: false,
            },
            { 
              targets: 1,
              data: "producto_id",
              name: 'p.producto_id',
            },
            { 
              targets: 2,
              data: "producto_nombre",
              name: 'p.producto_nombre',
            },
            { 
              targets: 3,
              data: "nombre_grupo",
              name: 'g.nombre_grupo',
            },
            { 
              targets: 4,
              data: "nombre_marca" ,
              name: 'm.nombre_marca',
            },
            { 
              targets: 5,
              orderable: false,
              className: 'text-center',
              data: null, defaultContent: '<button onclick="openModalDescripcion(this)" class="btn btn-sm btn-default">Modificar</button>'
            },
            { 
              targets: 6,
              data: "producto_precio",
              name: 'pe.producto_precio',
              render: data =>  `<input onblur="setUpdate(this)" propiedad="producto_precio" type="text" class="form-control" value="${textMillares(data)}" style="width: 100%"/>`
            },
            { 
              targets: 7,
              data: "producto_precio_descuento",
              name: 'pe.producto_precio_descuento',
              render: data =>  `<input onblur="setUpdate(this)" propiedad="producto_precio_descuento" type="text" class="form-control" value="${textMillares(data)}" style="width: 100%"/>` 
            },
            { 
              targets: 8,
              data: null, 
              orderable: false,
              className: 'text-center',
              defaultContent: '<button class="btn btn-sm btn-default" onclick="openModalCaracteristicas(this)">Modificar</button>'
            },
            { 
              targets: 9,
              data: 'sku', 
              name: 'pe.sku',
              render: data =>  `<input onblur="setUpdate(this)" propiedad="sku" type="text" class="form-control" value="${data}" style="width: 100%"/>`
            },            
            { 
              targets: 10,
              data: 'imagen_principal', 
              orderable: false,
              className: 'text-center',
              render: (data, display, dataCompleta) => `
                <img 
                    field="producto_imagen_principal" 
                    width="80px" 
                    style="border: 1px solid #676a6a; border-radius: 5px; ${tableWithFile? 'cursor: pointer' : ''}" 
                    ${tableWithFile? `onclick="this.parentNode.querySelector('.file').click();"` : ''}
                    height="80px" 
                    src="${data}"></img>
                <br>

                ${ dataCompleta.producto_imagen_principal != null && tableWithFile? `
                  <i style="cursor: pointer; color: #e74c3c; position: absolute; top: 0; right: 0;" onclick="deleteImage(this)" class="fa fa-remove"></i>`
                  :
                  ''
                }

                <input type="file" class="file" onchange="pushArrayFiles(this)" name="producto_imagen_principal" style="display: none;" />
              `,
              createdCell(td){
                td.setAttribute('ondrop', "dropHandler(event)")
                td.setAttribute('ondragover', "dragOverHandler(event)")
                td.setAttribute('ondragenter', "dragEnter(event)")
                td.style = 'position: relative';

              }
            },            
            { 
              targets: 11,
              data: 'imagen_1', 
              orderable: false,
              className: 'text-center',
              render: (data, display, dataCompleta) => `
                <img 
                  field="producto_imagen_1" 
                  width="80px" 
                  style="border: 1px solid #676a6a; border-radius: 5px; ${tableWithFile? 'cursor: pointer' : ''}" 
                  ${tableWithFile? `onclick="this.parentNode.querySelector('.file').click();"` : ''}
                  height="80px" 
                  src="${data}"></img>
                <br>

                ${ dataCompleta.producto_imagen_1 != null && tableWithFile? `
                  <i style="cursor: pointer; color: #e74c3c; position: absolute; top: 0; right: 0;" onclick="deleteImage(this)" class="fa fa-remove"></i>`
                  :
                  ''
                }

                <input type="file" class="file" onchange="pushArrayFiles(this)" name="producto_imagen_1" style="display: none;" />
              `,
              createdCell(td){
                td.setAttribute('ondrop', "dropHandler(event)")
                td.setAttribute('ondragover', "dragOverHandler(event)")
                td.setAttribute('ondragenter', "dragEnter(event)")
                td.style = 'position: relative';

              }
            },            
            { 
              targets: 12,
              data: 'imagen_2', 
              orderable: false,
              className: 'text-center',
              render: (data, display, dataCompleta) => `
                <img 
                  field="producto_imagen_2" 
                  width="80px" 
                  style="border: 1px solid #676a6a; border-radius: 5px; ${tableWithFile? 'cursor: pointer' : ''}" 
                  ${tableWithFile? `onclick="this.parentNode.querySelector('.file').click();"` : ''}
                  height="80px" 
                  src="${data}"></img>
                <br>

                ${ dataCompleta.producto_imagen_2 != null && tableWithFile? `
                  <i style="cursor: pointer; color: #e74c3c; position: absolute; top: 0; right: 0;" onclick="deleteImage(this)" class="fa fa-remove"></i>`
                  :
                  ''
                }

                <input type="file" class="file" onchange="pushArrayFiles(this)" name="producto_imagen_2" style="display: none;" />
              `,
              createdCell(td){
                td.setAttribute('ondrop', "dropHandler(event)")
                td.setAttribute('ondragover', "dragOverHandler(event)")
                td.setAttribute('ondragenter', "dragEnter(event)")
                td.style = 'position: relative';

              }
            },            
            { 
              targets: 13,
              data: 'imagen_3', 
              orderable: false,
              className: 'text-center',
              render: (data, display, dataCompleta) => `
                <img 
                  field="producto_imagen_3" 
                  width="80px" 
                  style="border: 1px solid #676a6a; border-radius: 5px; ${tableWithFile? 'cursor: pointer' : ''}" 
                  ${tableWithFile? `onclick="this.parentNode.querySelector('.file').click();"` : ''}
                  height="80px" 
                  src="${data}"></img>
                <br>

                ${ dataCompleta.producto_imagen_3 != null && tableWithFile? `
                  <i style="cursor: pointer; color: #e74c3c; position: absolute; top: 0; right: 0;" onclick="deleteImage(this)" class="fa fa-remove"></i>`
                  :
                  ''
                }

                <input type="file" class="file" onchange="pushArrayFiles(this)" name="producto_imagen_3" style="display: none;" />
              `,
              createdCell(td){
                td.setAttribute('ondrop', "dropHandler(event)")
                td.setAttribute('ondragover', "dragOverHandler(event)")
                td.setAttribute('ondragenter', "dragEnter(event)")
                td.style = 'position: relative';

              }
            },            
            { 
              targets: 14,
              data: 'imagen_4', 
              orderable: false,
              className: 'text-center',
              render: (data, display, dataCompleta) => `
                <img 
                  field="producto_imagen_4" 
                  width="80px" 
                  style="border: 1px solid #676a6a; border-radius: 5px; ${tableWithFile? 'cursor: pointer' : ''}" 
                  ${tableWithFile? `onclick="this.parentNode.querySelector('.file').click();"` : ''}
                  height="80px" 
                  src="${data}"></img>
                <br>

                ${ dataCompleta.producto_imagen_4 != null && tableWithFile? `
                  <i style="cursor: pointer; color: #e74c3c; position: absolute; top: 0; right: 0;" onclick="deleteImage(this)" class="fa fa-remove"></i>`
                  :
                  ''
                }

                <input type="file" class="file" onchange="pushArrayFiles(this)" name="producto_imagen_4" style="display: none;" />
              `,
              createdCell(td){
                td.setAttribute('ondrop', "dropHandler(event)")
                td.setAttribute('ondragover', "dragOverHandler(event)")
                td.setAttribute('ondragenter', "dragEnter(event)")
                td.style = 'position: relative';

              }
            },            
            { 
              targets: 15,
              data: 'imagen_5', 
              orderable: false,
              className: 'text-center',
              render: (data, display, dataCompleta) => `
                <img 
                  field="producto_imagen_5" 
                  width="80px" 
                  style="border: 1px solid #676a6a; border-radius: 5px; ${tableWithFile? 'cursor: pointer' : ''}" 
                  ${tableWithFile? `onclick="this.parentNode.querySelector('.file').click();"` : ''}
                  height="80px" 
                  src="${data}"></img>
                <br>

                ${ dataCompleta.producto_imagen_5 != null && tableWithFile? `
                  <i style="cursor: pointer; color: #e74c3c; position: absolute; top: 0; right: 0;" onclick="deleteImage(this)" class="fa fa-remove"></i>`
                  :
                  ''
                }

                <input type="file" class="file" onchange="pushArrayFiles(this)" name="producto_imagen_5" style="display: none;" />
              `,
              createdCell(td){
                td.setAttribute('ondrop', "dropHandler(event)")
                td.setAttribute('ondragover', "dragOverHandler(event)")
                td.setAttribute('ondragenter', "dragEnter(event)")
                td.style = 'position: relative';
              }
            },            
            { 
              targets: 16,
              data: 'producto_is_show', 
              orderable: false,
              render: data =>  `   
                  <label class="switch">
                    <input type="checkbox" onchange="changeProductoIsShow(this)" id="producto_is_show" name="producto_is_show" value="producto_is_show" ${data == 1? 'checked' : ''}>
                    <span></span>
                  </label>
              `
            },            

      ]
  }

  var objCaracteristica = {
      processing: true,
      ordering: false,
      info: false,
      paging: false,
      searching: false,
      language: {
        emptyTable: "No se encontraron registros",
        info: "Mostrando _START_ a _END_ de _TOTAL_ resultados",
        infoEmpty: "Mostrando 0 a 0 de 0 resultados",
        infoFiltered: "(filtrado de _MAX_ total resultados)",
        infoPostFix: "",
        thousands: ",",
        lengthMenu: "Mostrar _MENU_ resultados",
        loadingRecords: "Cargando...",
        processing: "Procesando...",
        zeroRecords: "No tiene caracteristicas registradas",
        paginate: {
          first: "Primero",
          last: "Ultimo",
          next: "Siguiente",
          previous: "Anterior"
        },
        aria: {
          sortAscending: ": activar ordenar columnas ascendente",
          sortDescending: ": activar ordenar columnas descendente"
        }
      },
      columnDefs: [
            { 
              targets: 0,
              data: 'producto_caracteristica',
              render: data => `<input onblur="setDataRowCaracteristica(this)" propiedad="producto_caracteristica" class="form-control" value="${data}" style="width: 100%">`
            },
            { 
              targets: 1,
              data: 'producto_caracteristica_valor',
              render: data => `<input onblur="setDataRowCaracteristica(this)" propiedad="producto_caracteristica_valor" class="form-control" value="${data}" style="width: 100%">`,
            },
            { 
              targets: 2,
              width: '80px',
              data: null,
              className: 'text-center',
              defaultContent: `
                <a class="btn btn-default" href="javascript:void(0)" onclick="deleteCaracteristica(this)"><i class="fa fa-remove"></i></a>
                <a class="btn btn-default" href="javascript:void(0)" style="cursor: move" title="Mover" onclick="deleteCaracteristica(this)">
                  <i class="fa fa-arrows-v"></i>
                </a>
                `,
            },

      ]
  }

  $(document).ready(function(){
    App.datatables();

    $("#charm").tcharm({'position': 'right', 'display': false, 'top': '50px' });

    tabla = $('#tabla').DataTable(objConfig);
    tablacaract = $('#tablacaract').DataTable(objCaracteristica);

    initDraggable();

    App.sidebar('close-sidebar');  


  })

  window.addEventListener("keydown", function (event) {
      if(event.keyCode == 118){
        addCaracteristica();
      }

   },false);

  document.querySelector('.btn_buscar').addEventListener('click', _ => tabla.draw(false), false);
  document.querySelector('.btn_reset').addEventListener('click', () => document.getElementById('form_filter').reset());

   $('#info').on('click', function(){
    $('#modalinfo').modal('show');
   })

   $('#upload-img').on('click', function(){

    let data = new FormData();
    let nodeWithImgs = Files.map(item => item.file);
    let idsNodes = Files.map(item => item.producto_id);

    if(nodeWithImgs.length == 0){
      mensaje('danger', 'No se han cargado imagenes');
      return;
    }

    filesize = Array.from(nodeWithImgs).map(f => f.size).reduce((a, b) => a + b) / Math.pow(1024,2);
    suma = 0;
    contador = 0;
    limit = parseInt(filesize / mbForSeconds);

    data.append('id', idsNodes);
    data.append(`fields`, Files.map(item => item.columna));

    nodeWithImgs.forEach((item, i) => {
      data.append(`image_${i}`, item);
    });
    

    $.ajax({
        url: `${ruta}ecommerce/uploadImg`,
        type: 'POST',
        contentType:false,
        data: data,
        processData:false,
        cache:false,
        async: true,
        timeout: 400000,
        beforeSend(){
           $('#barloadermodal').modal('show');
           interval = window.setInterval(writePorcentaje, 1000);
        },
        success: function(resp){
          if(resp.status == false){
            mensaje('warning', resp.msg);
          }
          else{
            mensaje('success', resp.msg);
            $('#btn-imagen').click();
          }

          document.querySelector('#barloadermodal .progress-bar').style.width = '100%';
          clearInterval(interval);

          setTimeout(() => {
            $('#barloadermodal').modal('hide');
            $('#modal-confirm').modal('hide');
          }, 2000)
        },
        error:function(jqXHR, textStatus, errorThrown){
          if(textStatus == 'timeout'){
            mensaje('danger', 'El servidor tardó mucho en responder');
          }
          else{
            alert("Error interno");
          }
          document.querySelector('#barloadermodal .progress-bar').style.width = '100%';
          clearInterval(interval);
          $('#barloadermodal').modal('hide');
        }
    })

   })


 $('#btn-imagen').click(function(event){
    tableWithFile = !tableWithFile;

    if(tableWithFile){
        $('#upload-img').show();
        $('#info').show();
    }
    else{
        Files.length = 0;
        $('#upload-img').hide();
        $('#info').hide();
    }

    tabla.draw(false);
 });

  function writePorcentaje(){
    let progressBar = document.querySelector('#barloadermodal .progress-bar');

    suma = suma + mbForSeconds;
    let porcentaje = (suma / filesize) * 100;

    progressBar.style.width = `${parseInt(porcentaje)}%`;

    contador++;
    if(contador > limit) clearInterval(interval);
  }

function changeProductoIsShow(element){
  const row = element.closest('tr');
  const data = tabla.row(row).data();

  data.checked = element.checked;

  request(`${ruta}ecommerce/changeProductoIsShow`, { data }, resp => {

    if(!resp.status) return mensaje('danger', 'Error al cambiar el estatus');

    mensaje('success', 'Estatus del producto cambiado con éxito');

    tabla.draw(false);

  });

}

function setUpdate(element){
  const row = element.closest('tr');
  const data = tabla.row(row).data();
  const field = element.getAttribute('propiedad');

  request(`${ruta}ecommerce/setUpdate`, { field, value: element.value, data }, _ => tabla.draw(false) );

}

function openModalDescripcion(element) {
  const row = element.closest('tr');
  const data = tabla.row(row).data();

  $('#dialogdescripcion #producto_id').val(data.producto_id);
  $('#dialogdescripcion #descripcion_larga').val(data.producto_descripcion_larga);

  $('#dialogdescripcion .modal-title').html(data.producto_nombre);
  $('#dialogdescripcion').modal('show');

}

function saveFormDescripcion(){

  request(`${ruta}ecommerce/saveFormDescripcion`, $('#formdescripcion').serialize(), resp => {

    if(!resp.status) return mensaje('danger', 'Error al guardar');

    mensaje('success', 'Guardado con éxito');

    $('#dialogdescripcion').modal('hide');

    tabla.draw(false);

  });
  
}

/* Métodos para manejar las caracteristicas de los productos */

function openModalCaracteristicas(element) {
  const row = element.closest('tr');
  const data = tabla.row(row).data();

  $('#dialogcaracteristicas #producto_id').val(data.producto_id);

  tablacaract.rows().remove().draw(false);

  request(`${ruta}ecommerce/getCaracteristicasProductos`, { producto_id: $('#producto_id').val()  }, resp => {

     tablacaract.rows.add(resp.data).draw(false);

     $('#dialogcaracteristicas').modal('show');
  });

  

}

function saveCaracteristicas(){
  
  updateOrder();

  const data = tablacaract.data().toArray();

  request(`${ruta}ecommerce/saveCaracteristicas`, { data, producto_id: $('#producto_id').val() }, resp => {

    if(!resp.status) return mensaje('danger', 'Error al guardar');

    mensaje('success', 'Guardado con éxito');

    $('#dialogcaracteristicas').modal('hide');

    $('#producto_id').val(0);

    tablacaract.draw(false);

  });
  
}

function addCaracteristica(){
  let newCaract = {
        'producto_id': $('#producto_id').val(),
        'producto_orden': 0,
        'producto_caracteristica': '',
        'producto_caracteristica_valor': '',
  }

  updateOrder();

  tablacaract.row.add(newCaract).draw(false);

}

function deleteCaracteristica(element){
  const row = element.closest('tr');

  tablacaract.row(row).remove().draw(false);
}

function setDataRowCaracteristica(element){
    let row = element.closest('tr');

    let data = tablacaract.row(row).data();

    data[element.getAttribute('propiedad')] = element.value;

    tablacaract.row(row).data(data);
}


/* Request ajax más intuitivo */

function request(ruta, data, func, newConfig = {}){

  let defaultConfig = {
    url: ruta,
    data: data,
    type: 'post',
    dataType: 'json', 
    success(resp){
      func(resp);
    },
    error(){
     $('#barloadermodal').modal('hide');
      mensaje("danger", 'Error interno');
    }
  };

  let concat = Object.assign(defaultConfig, newConfig);

  $.ajax(concat);
}

function textMillares(num){
  return parseFloat(num).toFixed(2);
}

function initDraggable(){
      $('.draggable').sortable({
        tolerance: 'pointer',
        cancel: 'input',
        start: function (e, ui) {
          ui.placeholder.css('height', ui.item.outerHeight());
        },
        // handle: '.fa-arrows-v',
        update: function (event, ui) {
          $('#tablacaract tbody tr input').blur();
          updateOrder();

        }
      });
}

/* 
  El orden se realiza diferente que en productos puesto que así es mucho más limpio y rápido, además que tabla de 
  caracteristicas es asincronica con la base de datos.
*/

function updateOrder(){
    let rowsTr = Array.from(document.querySelectorAll('#tablacaract tbody tr'));

    rowsTr.forEach((tr, index) => {
      let rowDataTable = tablacaract.row(tr).data();

      if(typeof rowDataTable != 'undefined'){

        rowDataTable.producto_orden = index;

        tablacaract.row(tr).data(rowDataTable);

      } 

    })
}

/* 
  De modo que el template tiene prevenido eventos con enter. Se aplica el salto de linea en el textarea de forma manual
*/
function saltoLinea(e){
    if (e.which == 13){
        let element = e.target;

        element.value += '\n';
    }
}

/* 
  Eventos DnD 
*/

function dropHandler(ev) {
  ev.preventDefault();

  if(!tableWithFile) return;

  let td = ev.target.nodeName == 'IMG'? ev.target.parentNode : ev.target;

  let producto_id = tabla.row(td.parentNode).data().producto_id;

  if (ev.dataTransfer.items) {

      if (ev.dataTransfer.items[0].kind === 'file') {
        var file = ev.dataTransfer.items[0].getAsFile();

        pushFiles({file, producto_id, columna: td.querySelector('img').getAttribute('field')})

      }
    
  } else {

      var file = ev.dataTransfer.files[0].getAsFile();

      pushFiles({file, producto_id, columna: td.querySelector('img').getAttribute('field')})
    
  } 

  td.style = 'background-color: #39b147';
  
  // Pass event to removeDragData for cleanup
  removeDragData(ev)
}

function dragOverHandler(ev) {
  ev.preventDefault();
}

function pushFiles({file, producto_id, columna}){

  let exist = Files.filter(item => item.producto_id == producto_id && item.columna == columna).forEach((item, index) => {
    Files.splice(index, (index + 1))
  })

  Files.push({file, producto_id, columna});

}

function removeDragData(ev) {

  if (ev.dataTransfer.items) {
    // Use DataTransferItemList interface to remove the drag data
    ev.dataTransfer.items.clear();
  } else {
    // Use DataTransfer interface to remove the drag data
    ev.dataTransfer.clearData();
  }
}

function dragEnter(ev){
  let td = ev.target.nodeName == 'IMG'? ev.target.parentNode : ev.target;
}

function dragLeave(ev){
  let td = ev.target.nodeName == 'IMG'? ev.target.parentNode : ev.target;
}

function pushArrayFiles(element){
  let columna = element.name;
  let trRow = element.closest('tr');
  let file = element.files[0];
  let producto_id = tabla.row(trRow).data().producto_id;

  pushFiles({file, producto_id, columna});

  element.parentNode.style = 'background-color: #39b147';
}

function deleteImage(element){
  let columna = element.closest('td').querySelector('.file').name;
  let producto_id = tabla.row(element.closest('tr')).data().producto_id;

  request(`${ruta}ecommerce/deleteImage`, { columna, producto_id }, resp => tabla.draw(false) );
}