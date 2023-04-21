  var statusPaso = 1;
  var previousText = '';
  var tableWithFile = false;
  var id_selected = 0;

  var mbForSeconds = 0.08655100549970354;

  var filesize = 0
  var suma = 0;
  var contador = 0;
  var limit = 0;
  var interval;

   $('#btn-confirmar').click(function(event,slibingId){
     let btnCurrent = document.querySelector('.current');
     let nextBtn;
   
     if(slibingId == undefined){
        nextBtn = btnCurrent.nextElementSibling;
    }else{
       nextBtn = $(btnCurrent).siblings(`#${slibingId}`).get(0);
    }

    if(nextBtn != null){ 

      btnCurrent.classList.remove('current')
      btnCurrent.classList.remove('btn-primary')
      btnCurrent.classList.add('btn-default')
      btnCurrent.disabled = true;

      nextBtn.classList.remove('btn-default');
      nextBtn.classList.add('btn-primary');
      nextBtn.classList.add('current');
      nextBtn.disabled = false;
      tableWithFile = !tableWithFile;
      $('#btn-imagen').click();
    }

   })  

   $('#btn-corregir').click(function(){
     statusPaso = 2;
   });
   
   $('#btn-imagen').click(function(event,callback_reset_edit){
      tableWithFile = !tableWithFile;
      $("#tabla").DataTable().destroy();

      if(tableWithFile == true){
        tableInitImage(objConfig);
        $('#upload-img').show();
        $('#btn-multiple').show();
      }
      else{
        tableInit(objConfig);
        $('#upload-img').hide();
        $('#btn-multiple').hide();
      }

      let btnCurrent = document.querySelector('.current');

      if(callback_reset_edit==undefined)
        statusPasoUpdate(btnCurrent.id);

   });

   $('#packing').on('change', function(){
        File = this.files;

        if(File.length == 0) return;

        let nameFile = File[0].name;

        let modal = document.querySelector('#modal-confirm');
            modal.querySelector('h4.modal-title').innerHTML = 'Cargar Paking List';
            modal.querySelector('div.modal-body').innerHTML = '<p>¿Está seguro de que desea cargar este archivo?</p>';
            modal.querySelector('div.modal-body').innerHTML += `<p>"${nameFile}"</p>`;
            modal.querySelector('#confirmar').setAttribute('onclick', 'uploadExcel(this)');

        $('#modal-confirm').modal('show');
    })

   $('#upload-masivo').on('change', function(){
        File = this.files;

        if(File.length == 0) return;
        
        let cantidadImagenes = File.length;
        let pesoImagenes = Array.from(File).map(f => f.size).reduce((a, b) => a + b) / Math.pow(1024,2);

        let modal = document.querySelector('#modal-confirm');
            modal.querySelector('h4.modal-title').innerHTML = 'Cargar imagenes';
            modal.querySelector('div.modal-body').innerHTML = `<p><strong>Nota:</strong> Recuerde que el nombre de las 
                                                               imágenes debe coincidir con el codigo de barras del producto para
                                                               que se logre cargar correctamente
                                                               <br>
                                                               Este proceso puede demorar unos minutos.
                                                               </p>`;

            modal.querySelector('div.modal-body').innerHTML += `<p>Imagenes por cargar: <strong>${cantidadImagenes}</strong></p>`;
            modal.querySelector('div.modal-body').innerHTML += `<p>Peso total: ${pesoImagenes.toFixed(2)} MB</p>`;
            modal.querySelector('#confirmar').setAttribute('onclick', 'uploadImagenes(this)');

        $('#modal-confirm').modal('show');
    })

   $('#btn-validar-codigos').on('click', function(){
        let modal = document.querySelector('#modal-confirm');
            modal.querySelector('h4.modal-title').innerHTML = 'Validar codigos';
            modal.querySelector('div.modal-body').innerHTML = '<p>¿Está seguro de que desea validar los codigos existentes?</p>';
            modal.querySelector('#confirmar').setAttribute('onclick', 'validarCodigos(this)');

        $('#modal-confirm').modal('show');
   })


   $('#btn-crear-productos').on('click', function(){
        let modal = document.querySelector('#modal-confirm');
            modal.querySelector('h4.modal-title').innerHTML = 'Confirmar carga de productos';
            modal.querySelector('div.modal-body').innerHTML = '<p>¿Está seguro de que desea cargar el inventario?</p>';
            modal.querySelector('div.modal-body').innerHTML += '<p>Esta acción no se puede revertir</p>';
            modal.querySelector('#confirmar').setAttribute('onclick', 'confirmarProductos(this)');

        $('#modal-confirm').modal('show');
   })

    $('#Finalizar').on('click', function(){

        let modal = document.querySelector('#modal-confirm');
            modal.querySelector('h4.modal-title').innerHTML = 'Finalizar Edicion';
            modal.querySelector('div.modal-body').innerHTML = '<p>¿Está seguro que desea terminar la Edicion de los productos?</p>';
            modal.querySelector('#confirmar').setAttribute('onclick', 'Finalizar()');

        $('#modal-confirm').modal('show');
   })

   $('#upload-img').on('click', function(){

    let nodeImg = Array.from(document.querySelectorAll('.input-img')); 

    let data = new FormData();
    let nodeWithImgs = nodeImg.filter(node => node.files.length > 0);
    let idsNodes = nodeWithImgs.map(node => node.parentNode.parentNode.querySelector('.register_id').value);

    if(nodeWithImgs == 0){
      mensaje('danger', 'No se han cargado imagenes');
      return;
    }

    filesize = Array.from(nodeWithImgs).map(f => f.files[0].size).reduce((a, b) => a + b) / Math.pow(1024,2);
    suma = 0;
    contador = 0;
    limit = parseInt(filesize / mbForSeconds);

    data.append('id', idsNodes);
    nodeWithImgs.forEach((node, i) => {
      data.append(`image_${i}`, node.files[0]);
    });

    $.ajax({
        url: `${ruta}packing/uploadImg`,
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


    $('.table-responsive').on('click', '#tabla tbody tr', function () {

        if(statusPaso != 2) return;

        let tds = this.querySelectorAll('.modified');
        let classComun = ['cantidad_item_real'];

        Array.from(tds).forEach((td, index) => {

          let existInput = td.querySelector('input#activ');

          if(existInput == null) {
            previousText = td.textContent;
            let input = document.createElement('input');
            input.style.width = '100%';
            input.value = previousText;
            input.id = 'activ';
            input.classList.add(classComun[index]);
            td.innerHTML = '';
            td.appendChild(input);
          }

        })
       
    });

    $('.table-responsive').on('blur', '#tabla tbody tr .modified #activ', function(){
      if(statusPaso != 2) return;

      let clase      = this.classList;
      let valor      = this.value;
      let td         = this.parentNode;
      let id         = this.parentNode.parentNode.querySelector('.register_id').value;
      let packing_id = document.getElementById('packing_id').value;


      Array.from(this.parentNode.parentNode.querySelectorAll('#activ')).forEach(act => {
        let val = act.value;
        act.parentNode.innerHTML = val;
      })

      if(this.value != previousText){
     
         $.ajax({
          url: `${ruta}packing/updateItem`,
          data: { id, campo: clase[0], valor ,packing_id },
          type: 'post',
          dataType: 'json',
          success(resp){

              tableWithFile = !tableWithFile;
              $('#btn-imagen').click();
              
              setTimeout(function(){  
              
                let td = document.querySelector(`.register_id[value="${id}"]`).parentNode.parentNode.querySelector('.modified');
                if(resp.status == false){
                  mensaje('danger', resp.msg)
                  td.style.color = 'red';
                }
                else{
                  td.style.color = 'green';
                }

              },500)
          },
          error(){
            td.style.color = 'red';
            alert("Error interno");
          }
         })
      }

    })

    // $(".table-responsive").on('keyup', '#tabla tbody tr .modified #activ', function (e) {
    //     if (e.keyCode == 13) {
    //         let nextRow = e.target.parentNode.parentNode.nextElementSibling;
    //         nextRow.click();
    //     }
    // });

    function writePorcentaje(){
      let progressBar = document.querySelector('#barloadermodal .progress-bar');

      suma = suma + mbForSeconds;
      let porcentaje = (suma / filesize) * 100;

      progressBar.style.width = `${parseInt(porcentaje)}%`;

      contador++;
      if(contador > limit) clearInterval(interval);
    }

    function openModalRefresh(){
        let modal = document.querySelector('#modal-confirm');
            modal.querySelector('h4.modal-title').innerHTML = 'Resetear Packing List';
            modal.querySelector('div.modal-body').innerHTML = '<p>¿Est&aacute; seguro que desea resetear el packing list?</p>';
            modal.querySelector('div.modal-body').innerHTML += `<p>Se eliminará toda la información almacenada</p>`;
            modal.querySelector('#confirmar').setAttribute('onclick', 'refrescar(this)');

        $('#modal-confirm').modal('show');
    }

  

   function statusPasoUpdate(elementId){

     reset_component();

     switch(elementId){
      case 'btn-cargar':
        statusPaso = 1;
      break;
      case 'btn-corregir':
        statusPaso = 2;
        returnSelect();
      break;
      case 'btn-validar-codigos':
        $('.table-responsive #activ').blur()
        statusPaso = 3;
      break;
      case 'btn-crear-productos':
        statusPaso = 4;
        update_estatus_prev('prev_Pendiente');
      break;
     }
   }

    function uploadPakingList(){
        document.querySelector('#packing').click();
    }

    function uploadImgMasivo(){
        document.querySelector('#upload-masivo').click();
    }

    function uploadExcel(element){

        if(element.id != 'confirmar') return;

        filesize = File[0].size / Math.pow(1024, 2);
        suma = 0;
        contador = 0;
        limit = parseInt(filesize / mbForSeconds);

        let data = new FormData();
            data.append('archivo', File[0]);
            data.append('packing_id', document.getElementById('packing_id').value);

         $.ajax({
              url: `${ruta}packing/uploadPakingList`,
              type: 'POST',
              contentType:false,
              data: data,
              processData:false,
              cache:false,
              async: true,
              dataType: 'json',
              beforeSend(){
                 $('#barloadermodal').modal('show');
                 interval = window.setInterval(writePorcentaje, 1000);
              },
              success(resp){
                  if(resp.status == false){
                    mensaje('warning', resp.msg);
                  }
                  else{
                    mensaje('success', resp.msg);
                    $("#tabla").DataTable().destroy();
                    tableInit(objConfig);
                    $('#btn-confirmar').click();
                  }

                  document.querySelector('#barloadermodal .progress-bar').style.width = '100%';
                  clearInterval(interval);

                  setTimeout(() => {
                    $('#barloadermodal').modal('hide');
                    $('#modal-confirm').modal('hide');
                  }, 2000)
              },
              error(jqXHR, textStatus, errorThrown){
                  document.querySelector('#barloadermodal .progress-bar').style.width = '100%';
                  clearInterval(interval);
                  $('#barloadermodal').modal('hide');

                  alert(errorThrown);
              }
          });

    }

    function uploadImagenes(element){

        if(element.id != 'confirmar') return;
        
        filesize = Array.from(File).map(f => f.size).reduce((a, b) => a + b) / Math.pow(1024,2);
        suma = 0;
        contador = 0;
        limit = parseInt(filesize / mbForSeconds);

        let data = new FormData();

        Array.from(document.querySelector('#upload-masivo').files).forEach((node, i) => {
          data.append(`image_${i}`, node);
        })

        data.append('packing_id', document.getElementById('packing_id').value);

         $.ajax({
              url: `${ruta}packing/uploadImagenes`,
              type: 'POST',
              contentType:false,
              data: data,
              processData:false,
              cache:false,
              async: true,
              dataType: 'json',
              beforeSend(){
                 $('#barloadermodal').modal('show');
                 interval = window.setInterval(writePorcentaje, 1000);
              },
              success(resp){
                  if(resp.status == false){
                    mensaje('warning', resp.msg);
                  }
                  else{
                    mensaje('success', resp.msg);
                    $("#tabla").DataTable().destroy();
                    tableInitImage(objConfig);
                  }

                  setTimeout(() => {
                    $('#barloadermodal').modal('hide');
                    $('#modal-confirm').modal('hide');
                  }, 2000)
              },
              error(jqXHR, textStatus, errorThrown){
                  document.querySelector('#barloadermodal .progress-bar').style.width = '100%';
                  clearInterval(interval);
                  $('#barloadermodal').modal('hide');

                  alert(errorThrown);
              }
          });

    }

    function reset_component(){
    //  $('#btn-imagen').click();
      $('div.toolbar').html('');
    }

    function reset_pasos(){
      $('#btn-confirmar').trigger('click',['btn-cargar']);
    }

    function refrescar(element){
      if(element.id != 'confirmar') return;

      let id = document.getElementById('packing_id').value;

      $('#barloadermodal').modal('show');

      $.ajax({
        url: `${ruta}packing/resetear`,
        data: { id },
        type: 'post',
        dataType: 'json',
        success(resp){
          if(resp.status == false){
            mensaje('warning', resp.msg)
          }
          else{
            mensaje('success', resp.msg);
            $("#tabla").DataTable().destroy();
            tableInit(objConfig);
          }

          reset_pasos()
          $('#barloadermodal').modal('hide');
          $('#modal-confirm').modal('hide');

        },
        error(){
          alert("Error interno");
        }
      })
    }

    function confirmarProductos(element){
      if(element.id != 'confirmar') return;

      let id = document.getElementById('packing_id').value;

      $('#barloadermodal').modal('show');

      $.ajax({
        url: `${ruta}packing/confirmarProductos`,
        data: { id },
        type: 'post',
        dataType: 'json',
        success(resp){

          mensaje('success', resp.msg);
      
          ///Table////
          $("#tabla").DataTable().destroy();
          tableInit(objConfig);

          ////callback
          display_in_case(resp.estado);

          ////load
          $('#barloadermodal').modal('hide');
          $('#modal-confirm').modal('hide');

        },
        error(){
          alert("Error interno");
        }
      })
    }

    function Finalizar(){

      let id = document.getElementById('packing_id').value;

      $('#barloadermodal').modal('show');

      $.ajax({
        url: `${ruta}packing/end_packing`,
        data: { id },
        type: 'post',
        dataType: 'json',
        success(resp){
          $('#modal-confirm').modal('hide');
          setTimeout(() => {
            regresar();
          }, 2000)
        },
        error(){
          alert("Error interno");
        }
      })

    }

    function serach_select(value){

      var tabla = $("#tabla").DataTable();
      var serach_element = tabla.search();
      tabla.search(serach_element,value).draw();
    }

    function validarCodigos(element){
      if(element.id != 'confirmar') return;

      let id = document.getElementById('packing_id').value;

      $('#barloadermodal').modal('show');

      $.ajax({
        url: `${ruta}packing/validarCodigos`,
        data: { id },
        type: 'post',
        dataType: 'json',
        success(resp){
          mensaje('success', resp.msg);
          $("#tabla").DataTable().destroy();
          tableInit(objConfig);
          
          $('#btn-confirmar').click();
          $('#barloadermodal').modal('hide');
          $('#modal-confirm').modal('hide');

        },
        error(){
          alert("Error interno");
        }
      })
    }

    function exportar_excel() {

        let  data = {};
        let case_search = document.getElementById('serach_select_value').value;

        data.search_value = (case_search!==undefined)?case_search:0;
        data.id = document.getElementById('packing_id').value;

        let win = window.open(`${ruta}packing/get_excel_product/?data=`+ JSON.stringify(data), '_blank');
        win.focus();

    }

    function tableInitImage(config){
      document.querySelector('.table-responsive').innerHTML = '';
      let tabla = tablaOriginal.cloneNode(true);
      $(tabla.querySelectorAll('thead tr .replace-d')).remove();

      let thImg = document.createElement('th');
          thImg.classList.add('replace-n');
          thImg.textContent = 'Cargar imagen';

      tabla.querySelector('thead tr').replaceChild(thImg, tabla.querySelector('.replace-n'));

      document.querySelector('.table-responsive').appendChild(tabla);
      let newConfig = JSON.parse(JSON.stringify(config));
      newConfig.columnDefs = columnDefs();
      newConfig.ajax.data.img = tableWithFile;

      $("#tabla").dataTable(newConfig);
    }

    function deleteImage(element){
      let id = element.parentNode.parentNode.querySelector('.register_id').value;
      $('#barloadermodal').modal('show');

      $.ajax({
        url: `${ruta}packing/deleteImageBd`,
        type: 'post',
        data: { id },
        dataType: 'json',
        timeout: 40000,
        success(resp){
          if(resp.status == true){
           $("#tabla").DataTable().destroy();
            tableInitImage(objConfig);
            mensaje('success', resp.msg);

          }
          else{
            mensaje('danger', resp.msg);
          }
          $('#barloadermodal').modal('hide');
        },
        error(request, status, err){
          if(status == 'timeout'){
            mensaje('danger', 'El servidor tardó mucho en responder');
           $('#barloadermodal').modal('hide');
          }
          else{
            alert("Error interno");
          }
        }

      })
    }

    function editarProducto() {
    
      if (id_selected!=0) {

        let id_product = product_get_detall(id_selected);

        if(id_product!=false){

          var packing_product = true;

          $('#productomodal').html($("#load_div").html());

          $("#productomodal").load(`${ruta}producto/agregar/` + id_product+`/`+id_selected, function() {
              $('#productomodal').modal({
                  show: true,
                  keyboard: false,
                  backdrop: 'static'
              });
          });

        }else{

           $.bootstrapGrowl('<h4>Error Interno</h4>', {
            type: 'warning',
            delay: 2500,
            allow_dismiss: true
           });
        }

      } else selectProductError();

    }

    function callback_reset_inEdit(){
        id_selected=0;
        tableWithFile = !tableWithFile;
        $('#btn-imagen').trigger('click',[true]);
        display_in_case();
    }

    function regresar(){
      $('#barloadermodal').modal('show');

      $.ajax({
          url: `${ruta}packing/index`,
          type: 'post',
          success(html){
            $('#barloadermodal').modal('hide');
            $('#page-content').html(html);
          },
          error(){
            $('#barloadermodal').modal('hide');
            alert("Error interno");
          }
        })
    }

    function map_element(query_select,change_style){

      Array.prototype.slice.call(document.querySelectorAll(query_select)).map(element=>{
        change_style.forEach((value,index)=>{
          element.style[index]=value;
        });
      })

    }
    
    function update_estatus_prev(estado){

      var id = $('#packing_id').val();

      $.ajax({
          url: `${ruta}packing/update_status`,
          type: 'post',
          async: false,
          data : {estado,id},
          dataType: 'json',
          success(resp){

            if(resp.status==true){
              display_in_case(resp.estado)
            }else{
               mensaje('error', resp.msg);
            }

          },
          error(){
              mensaje('error', resp.msg);
          }
      })
    }


    function product_get_detall(id){

      var id_product;

      $.ajax({
        url: `${ruta}packing/get_product_detall`,
        type: 'post',
        async: false,
        data : {id},
        dataType: 'json',
        success(resp){
          id_product =  resp.producto_id;
        },
        error(){
          id_product = false;
        }
      })

      return id_product;
    }

    function init_select_item_table(){

      var item_styles = new Map();
  
      if($(".edit_packing_list").css('display') == 'block'){
  
        $("#tbody").selectable({

            filter:' tr:has(>td .producto_new)',
            cancel: "tr ui-selected",

            start: function( event, ui ) {
              item_styles.set('color',"");
              let query_selector = '#tbody tr td span';
              map_element(query_selector,item_styles);
            },

            stop: function(event, ui ) {

              let element = $("#tbody tr.ui-selected td .register_id");

              if( element.length && element.val() != id_selected ){

                item_styles.set('color',"#ffff");
                id_selected = $(" tr.ui-selected .register_id").val();
                
                let query_selector = '#tbody tr.ui-selected td span';
                map_element(query_selector,item_styles);

              }else{
                $("#tbody tr.ui-selected").removeClass("ui-selected")
                id_selected=0;
              }

            }
        });
      }

    }

    function selectProductError() {
        $.bootstrapGrowl('<h4>Debe seleccionar un producto</h4>', {
            type: 'warning',
            delay: 2500,
            allow_dismiss: true
        });
    }

    function columnDefs(){

      if(tableWithFile == false){
        return [
          { 
            targets: [0], name: 'img_url',
            render: data => {
              return `<img width="50px" height="50px" src="${data.valor}"></img>`;
            }
          },
          {
            targets: [1], name: 'codigo_barras_carton',
            render: data => {
              return `<span class="${data.class}">${data.valor}</span>`;
            }
          },
          { 
            targets: [2], name: 'nro_carton',
            render: data => {
               return `<span class="${data.class}">${data.valor}</span> <input hidden class="register_id" value="${data.id}">`;
            }
          },
          {
            targets: [3], name: 'cantidad_carton',
            render: data => {
               return `<span class="${data.class}">${data.valor}</span>`;
            }
          },
          {
            targets: [4], name: 'volumen',
            render: data => {
               return `<span class="${data.class}">${data.valor}</span>`;
            }
          },
          {
            targets: [5], name: 'peso',
            render: data => {
               return `<span class="${data.class}">${data.valor}</span>`;
            }
          },
          {
            targets: [6], name: 'modelo',
            render: data => {
               return `<span class="${data.class}">${data.valor}</span>`;
            }
          },  
          {
            targets: [7], name: 'codigo_barra',
            render: data => {
               return `<span class="${data.class}">${data.valor}</span>`;
            }
          },      
          {
            targets: [8], name: 'bloque',
            render: data => {
               return `<span class="${data.class}">${data.valor}</span>`;
            }
          },      
          {
            targets: [9], name: 'nombre_producto',
            render: data => {
               return `<span class="${data.class}">${data.valor}</span>`;
            }
          },
          {
            targets: [10], name: 'unidad',
            render: data => {
               return `<span class="${data.class}">${data.valor}</span>`;
            }
          },
          {
            targets: [11], name: 'cantidad_por_item',
            render: data => {
               return `<span class="${data.class}">${data.valor}</span>`;
            }
          },
          {
            targets: [12], name: 'cantidad_item_real', className: "modified",
            render: data => {
               return `<span class="${data.class}">${data.valor}</span>`;
            }
          },
          {
            targets: [13], name: 'cantidad_total',
            render: data => {
               return `<span class="${data.class}">${data.valor}</span>`;
            }
          },
          {
            targets: [14], name: 'precio',
            render: data => {
               return `<span class="${data.class}">${data.valor}</span>`;
            }
          },
          {
            targets: [15], name: 'descripcion',
            render: data => {
               return `<span class="${data.class}">${data.valor}</span>`;
            }
          },
          {
            targets: [16], name: 'codigo_producto_interno',
            render: data => {
               return `<span class="${data.class}">${data.valor}</span>`;
            }
          },
          { "orderable": true }
        ]
      }
      else{
        return [
          { 
            targets: [0], name: 'img_url', className: 'relative',
            render: data => {
              if(data.default == false){
                return `
                  <div onclick="deleteImage(this)">
                    <img class="img-opacity" width="50px" height="50px" src="${data.valor}" title="Eliminar imagen"></img>
                    <a title="Eliminar imagen" href="javascript:void(0)" style="position: absolute; top: 33%; color: #e74b3b; left:39%; font-size: 20px; "><i class="fa fa-close"></i></span>
                  </div>
                  `;            
              }
              else{
                 return `<img width="50px" height="50px" src="${data.valor}"></img>`;  
              }
            }
          },
          {
            targets: [1], name: 'codigo_barras_carton',
            render: data => {
               return `<span class="${data.class}">${data.valor}</span>`;
            }
          },
          { 
            targets: [2], name: 'nro_carton',
            render: data => {
               return `<span class="${data.class}">${data.valor}</span> <input hidden class="register_id" value="${data.id}">`;
            }
          },
          {
            targets: [3], name: 'cantidad_carton',
            render: data => {
               return `<span class="${data.class}">${data.valor}</span>`;
            }
          },
          {
            targets: [4], name: 'img',
            data: null,
            defaultContent: `<input type="file" class="input-img" id="img" style="display: block !important;">`
          },
          {
            targets: [5], name: 'codigo_barra',
            render: data => {
               return `<span class="${data.class}">${data.valor}</span>`;
            }
          }, 
          {
            targets: [6], name: 'bloque',
            render: data => {
               return `<span class="${data.class}">${data.valor}</span>`;
            }
          },         
          {
            targets: [7], name: 'nombre_producto',
            render: data => {
               return `<span class="${data.class}">${data.valor}</span>`;
            }
          },
          {
            targets: [8], name: 'cantidad_total',
            render: data => {
               return `<span class="${data.class}">${data.valor}</span>`;
            }
          },
          {
            targets: [9], name: 'descripcion',
            render: data => {
               return `<span class="${data.class}">${data.valor}</span>`;
            }
          },
          {
            targets: [10], name: 'codigo_producto_interno',
            render: data => {
               return `<span class="${data.class}">${data.valor}</span>`;
            }
          },
          { "orderable": true }
        ]
      }
    }