//funcion para mostrar las tabla de los productos agregados
var list_option;  /// opciones para cuando es una guia de remision independiente
function update_view_guia_remision(type) {

    $("#body_productos_remision").html('');
    if (lst_producto.length == 0)
      $("#head_productos_remision").html('');
    else {
      switch (type) {
        case 'detalle':
        {
          $("#head_productos_remision").html('<tr>' +
                    '<th>Active</th>' +
                    '<th>#</th>' +
                    '<th>Tipo</th>' +
                    '<th>Producto</th>' +
                    '<th>Detalles</th>' +
                    '<th>Acciones</th>' +
                    '</tr>');
  
          for (var i = 0; i < lst_producto.length; i++) {
            addTable_remision(lst_producto[i], type);
          }
          break;
        }
        case 'general':
        {
          $('#table_producto').css('white-space', 'nowrap');
          $("#head_productos_remision").html('<tr>' +
            '<th></th>' +
            '<th>#</th>' +
            '<th>Tipo</th>' +
            '<th>Producto</th>' +
            '<th>Stock</th>' +
            '<th>Cantidad</th>' +
            '<th>Precio de venta</th>' +
            '<th>Descuento (%)</th>' +
            '<th>Total</th>' +
            '<th>Nueva cantidad</th>' +
            '<th>Acciones</th>' +
                    '</tr>');
  
          for (var i = 0; i < lst_producto.length; i++) {
            addTable_remision(lst_producto[i], type);
          }
          break;
        }
      }
    }
  }
  
  //añade un elemento a la tabla, tiene sus variaciones dependiendo del tipo de vista
function addTable_remision(producto, type) {
  var template = '<tr id="tr_'+ producto.index +'">';
  template += '<td style="text-align:center"> <input type="checkbox" id="checkbox_'+index+'" name="item_check" onchange="update_total_price()"> </td>';
  template += '<td style="text-align:center">' + (producto.index + 1) + '</td>';
  template += '<td style="text-align:center"> Cotizacion </td>';
  template += '<td style="text-align:center">' + decodeURIComponent(producto.producto_nombre) + '</td>';
  
  if (type == 'general') {
    template += '<td style="text-align: center;">' + producto.total_minimo + ' (' + producto.um_min + ')</td>';
    template += '<td style="text-align:center">' + producto.precio_unitario + '</td>';
    template += '<td style="text-align:center">' + (producto.precio_unitario > producto.precio_descuento ? producto.precio_descuento : '-') + '</td>';
    template += '<td style="text-align:center">' + parseFloat(producto.subtotal).toFixed(2) + '</td>';
    template += '<td style="text-align:center">' + producto.stock_min +'</td>';
    template += '<td style="text-align:center"> <input type="text"> </td>';
  }
  if (type == 'detalle') {
    template += '<td style="text-align: center; width: 400px;">';

    template += '<div class="row" style="margin: 0;">';
    template += '<div class="col-sm-4" style="background-color: #ADADAD; color: #fff; padding: 0;">Cantidad</div>';
    template += '<div class="col-sm-4" style="background-color: #ADADAD; color: #fff;">UM</div>';
    template += '<div class="col-sm-4" style="background-color: #ADADAD; color: #fff;">Unidades</div>';
    template += '</div>';

    var det = detalles_sort(producto.detalles);
    for (var i = 0; i < det.length; i++) {
      template += '<div class="row" style="margin: 0;">';
      if (det[i].cantidad != 0) {
        template += '<div class="col-sm-4" style="border: solid 1px #e2e2e2;">' + det[i].cantidad + '</div>';
        template += '<div class="col-sm-4" style="border: solid 1px #e2e2e2;">' + det[i].unidad_abr + '</div>';
        template += '<div class="col-sm-4" style="border: solid 1px #e2e2e2;">' + det[i].unidades + ' ' + producto.um_min_abr + '</div>';
        template += '</div>';
      }
    }

    template += '</td>';
  }

  template += '<td style="text-align: center;">';

  template += '<div class="btn-group"><a class="btn btn-default" data-toggle="tooltip" title="Editar cantidad" data-original-title="Editar cantidad" onclick="edit_producto(' + producto.producto_id + ');">';
  template += '<i class="fa fa-edit"></i></a>';
  template += '</div>';

  template += '<div style="margin-left: 10px;" class="btn-group"><a class="btn btn-danger" data-toggle="tooltip" title="Eliminar" data-original-title="Eliminar" onclick="delete_producto(' + producto.index + ');">';
  template += '<i class="fa fa-trash-o"></i></a>';
  template += '</div>';
  template += '</td>';

  template += '</tr>';

  $("#body_productos_remision").append(template);
}



function on_update_view_traspaso_remision() {
    $("#body_productos_remision").html('');
    $('#table_producto').css('white-space', 'nowrap');
    $("#head_productos_remision").html('<tr>' +
      '<th style="width:10%;"><input type="checkbox" onchange="seleccionar_todo(this)" id="check_all"></th>' +
      '<th style="width:10%;">item</th>' +
      '<th style="width:10%;">Tipo</th>' +
      '<th style="width:10%;">Codigo Producto</th>' +
      '<th style="width:10%;">Producto</th>' +
      '<th style="width:10%;">C. Original</th>' +
      '<th style="width:10%;">C. en Unidades</th>' +
      '<th style="width:10%;">C. Disponible</th>' +
      '<th style="width:10%;">C. a despachar</th>' +
      '</tr>');
}


function init_table_product(){
    $("#body_productos_remision").html('');
    $('#table_producto').css('white-space', 'nowrap');
    $("#head_productos_remision").html('<tr>' +
      '<th style="width:20%;">Descripcion</th>' +
      '<th style="width:10%;">Cantidad</th</th>' +
      '<th style="width:10%;">Unidad</th>' +
      '<th style="width:10%;">Precio</th>' +
     // '<th style="width:10%;">Impuesto</th>' +
      '<th style="width:10%;">Subtotal</th>' +
     // '<th style="width:10%;">Total</th>' +
      '<th style="width:12%;"></th>' +
    '</tr>');
  
}


function on_update_view_entradas_salidas_remision() {
    $("#body_productos_remision").html('');
  
    $('#table_producto').css('white-space', 'nowrap');
    $("#head_productos_remision").html('<tr>' +
      '<th style="width:5%;"><input type="checkbox" onchange="seleccionar_todo(this)" id="check_all"></th>' +
      '<th style="width:10%;">item</th>' +
      '<th style="width:10%;">Tipo</th>' +
      '<th style="width:10%;">Codigo Producto</th>' +
      '<th style="width:15%;">Producto</th>' +
      '<th style="width:10%;">C. Original</th>' +
      '<th style="width:10%;">C. en Unidades</th>' +
      '<th style="width:10%;">C. Disponible</th>' +
      '<th style="width:10%;">C. a despachar</th>' +
      '<th style="width:10%;">Costo U</th>' +
      '<th style="width:10%;">Sub Total</th>' +
      '</tr>');
}



function on_update_view() {
    $("#body_productos_remision").html('');
  
    $('#table_producto').css('white-space', 'nowrap');
    $("#head_productos_remision").html('<tr>' +
      '<th style="width:5%;"><input type="checkbox" onchange="seleccionar_todo(this)" id="check_all"></th>' +
      '<th style="width:5%;">item</th>' +
      // '<th style="width:10%;">Tipo</th>' +
      '<th style="width:6%;">Codigo Producto</th>' +
      '<th style="width:14%;">Producto</th>' +
      '<th style="width:10%;">C. Original</th>' +
      '<th style="width:10%;">Precio de C. Original</th>' +
      '<th style="width:10%;">C. en Unidades</th>' +
      '<th style="width:10%;">C. Disponible</th>' +
      '<th style="width:10%;">'+
        '<input type="checkbox" onchange="despachar_todo(this)" id="despachar_all">'+
        'C. a despachar</th>' +
      '<th style="width:10%;">Precio Unit.</th>' +
      '<th style="width:10%;">Sub Total</th>' +
      '</tr>');
}
function update_table_body(product_list, tipo_operacion) {
    $.each(product_list, function (index, producto) {
        var template = '<tr id="tr_'+ index +'">';
        if(producto.cantidad_parcial<=0 && producto.cantidad_despachada===undefined){
          template += '<td style="text-align:center"> <input type="checkbox" disabled id="checkbox_'+index+'" name="item_check" onchange="update_total_price()"> </td>';
        }else if( producto.cantidad_despachada > 0 ){
          template += '<td style="text-align:center"> <input type="checkbox" id="checkbox_'+index+'" name="item_check" onchange="update_total_price()" checked> </td>';
        }else{
          template += '<td style="text-align:center"> <input type="checkbox" id="checkbox_'+index+'" name="item_check" onchange="update_total_price()"> </td>';
        }
        template += '<td style="text-align:center">' + (index + 1) + '</td>';
        // template += '<td style="text-align:center">' + tipo_operacion + '</td>';
        template += '<td style="text-align:center">' + producto.codigo_producto+ '</td>';
        template += '<td style="text-align:center" style ="text-align: center;min-width: 100%;"><p style="font-size: 11px;width: 100%;margin-bottom: 0px;white-space: normal;min-width: 110px;">'
         + decodeURIComponent(producto.producto_nombre) + 
         '</p></td>';
        
        template += '<td style="text-align: center;">' + producto.cantidad + ' (' + producto.unidad_nombre + ')</td>';
        template += '<td style="text-align: center;">' + producto.precio_base_presentacion.toFixed(2) + '</td>';
        template += '<td style="text-align: center;">' + producto.cantidad_unidades + ' (' + producto.um_min_abr + ')</td>';
        template += '<td class="q_disponible" style="text-align: center;">' + producto.cantidad_parcial + ' (' + producto.um_min_abr + ')</td>';
        if(producto.cantidad_despachada!==undefined){
         
          template+=`<td style='text-align:left'>  
                  <div  style="height: 100%;" class="input-group">
                    <input class="form-control align-number"  onkeypress="return solonumeros(event, true)" onchange="update_subtotal_price( ${index} )"  id="td_nueva_cantidad_${index}" style="height: 100%; width: 100%; margin-right:50px;" type="number" text-align: center; value="${producto.cantidad_despachada}">
                      <div style="font-size: 7pt; height: 80%; width: 10%;" class="input-group-addon">${producto.um_min_abr}</div>
                  </div> 
                </td>`
        }
        else {

          template+=`<td style='text-align:left'>  
                  <div  style="height: 100%;" class="input-group">
                    <input class="form-control align-number" readonly="true" onkeypress="return solonumeros(event, true)" onchange="update_subtotal_price( ${index} )"  id="td_nueva_cantidad_${index}" style="height: 100%; width: 100%; margin-right:50px;" type="number" text-align: center;>
                      <div style="font-size: 7pt; height: 80%; width: 10%;" class="input-group-addon">${producto.um_min_abr}</div>
                  </div> 
                </td>`
        }

        template += '<td style="text-align:center">' + parseFloat(producto.precio_unitario).toFixed(2) + '</td>';
        template += '<td style="text-align:center" id="td_sub_total_'+ index +'">' + parseFloat(producto.subtotal).toFixed(2) + '</td>';
        template += '</tr>';

        $("#body_productos_remision").append(template);
    })
}

function update_table_entradas_salidas_body(product_list, tipo_operacion) {
    $.each(product_list, function (index, producto) {
       
        var template = '<tr id="tr_'+ index +'">';
        if(producto.cantidad_parcial<=0 && producto.cantidad_despachada===undefined){
          template += '<td style="text-align:center"> <input type="checkbox" disabled id="checkbox_'+index+'" name="item_check" onchange="update_remision_entradas_salidas()"> </td>';
        }else{
          template += '<td style="text-align:center"> <input type="checkbox" id="checkbox_'+index+'" name="item_check" onchange="update_remision_entradas_salidas()"> </td>';
        }
        template += '<td style="text-align:center">' + (index + 1) + '</td>';
        template += '<td style="text-align:center">' + tipo_operacion.replace('_',' & ') + '</td>';
        template += '<td style="text-align:center">' + producto.codigo_producto+ '</td>';
        template += '<td style="text-align:center" style ="text-align: center;min-width: 100%;"><p style="font-size: 13px;width: 100%;margin-bottom: 0px;white-space: normal;min-width: 130px;">'
         + decodeURIComponent(producto.producto_nombre) + 
         '</p></td>';
        template += '<td style="text-align: center;">' + producto.precio_unitario + '</td>';
        template += '<td style="text-align: center;">' + producto.cantidad_unidades + ' (' + producto.unidad_minima + ')</td>';
        template += '<td style="text-align: center;">' + producto.cantidad_parcial + ' (' + producto.unidad_minima + ')</td>';
        if(producto.cantidad_despachada!==undefined){
         
          template+=`<td style='text-align:left'>  
                  <div  style="height: 100%;" class="input-group">
                    <input class="form-control"  onkeypress="return solonumeros(event)" onchange="update_subtotal_price( ${index} )"  id="td_nueva_cantidad_${index}" style="height: 100%; width: 100%; margin-right:50px;" type="number" text-align: center; value="${producto.cantidad_despachada}">
                      <div style="height: 80%; width: 10%;" class="input-group-addon">${producto.unidad_minima}/</div>
                  </div> 
                </td>`
        }
        else {

          template+=`<td style='text-align:left'>  
                  <div  style="height: 100%;" class="input-group">
                    <input class="form-control" readonly="true" onkeypress="return solonumeros(event)" onchange="update_subtotal_price( ${index} )"  id="td_nueva_cantidad_${index}" style="height: 100%; width: 100%; margin-right:50px;" type="number" text-align: center;>
                      <div style="height: 80%; width: 10%;" class="input-group-addon">${producto.unidad_minima}/</div>
                  </div> 
                </td>`
        }
        template += '<td style="text-align:center">' + parseFloat(producto.precio_unitario).toFixed(2) + '</td>';
        template += '<td style="text-align:center" id="td_sub_total_'+ index +'">' + parseFloat(producto.subtotal).toFixed(2) + '</td>';
        template += '</tr>';
/*
         template += '<td style="text-align:center"> <input type="number" id="td_nueva_cantidad_'+ index +'" onchange="update_subtotal_price('+index+')" value="'+ producto.cantidad +'"> </td>';
        template += '<td style="text-align:center" id="td_sub_total_'+ index +'">' + parseFloat(producto.subtotal).toFixed(2) + '</td>';
        template += '</tr>';

*/
        $("#body_productos_remision").append(template);
    })
}

function update_table_traspaso_body(product_list, tipo_operacion) {
    $.each(product_list, function (index, producto) {
       
        var template = '<tr id="tr_'+ index +'">';
        if(producto.cantidad_parcial<=0 && producto.cantidad_despachada===undefined){
          template += '<td style="text-align:center"> <input type="checkbox" disabled id="checkbox_'+index+'" name="item_check" onchange="update_total_price()"> </td>';
        }else{
          template += '<td style="text-align:center"> <input type="checkbox" id="checkbox_'+index+'" name="item_check" onchange="update_total_price()"> </td>';
        }
        template += '<td style="text-align:center">' + (index + 1) + '</td>';
        template += '<td style="text-align:center">' + tipo_operacion + '</td>';
        template += '<td style="text-align:center">' + producto.codigo_producto+ '</td>';
        template += '<td style="text-align:center">' + decodeURIComponent(producto.producto_nombre) + '</td>';
        template += '<td style="text-align: center;">' + producto.cantidad + ' (' + producto.unidad_abr + ')</td>';
        template += '<td style="text-align: center;">' + producto.cantidad_unidades + ' (' + producto.unidad_minima + ')</td>';
        template += '<td style="text-align: center;">' + producto.cantidad_parcial + ' (' + producto.unidad_abr + ')</td>';
        if(producto.cantidad_despachada!==undefined){
          template+=`<td style='text-align:left'>  
                  <div  style="height: 100%;" class="input-group">
                    <input class="form-control" onkeypress="return solonumeros(event)" onchange="update_subtotal_price( ${index} )"  id="td_nueva_cantidad_${index}" style="height: 100%; width: 100%; margin-right:50px;" type="number" text-align: center; value="${producto.cantidad_despachada}">
                      <div style="min-width:5px !important;" class="input-group-addon">${producto.unidad_minima}/</div>
                  </div> 
                </td>`
        }
        else {

          template+=`<td style='text-align:left'>  
                  <div  style="height: 100%;" class="input-group">
                    <input class="form-control" readonly="true"  onkeypress="return solonumeros(event)" onchange="update_subtotal_price( ${index} )"  id="td_nueva_cantidad_${index}" style="height: 100%; width: 100%; margin-right:50px;" type="number" text-align: center;>
                      <div style="min-width:5px !important;" class="input-group-addon">${producto.unidad_minima}/</div>
                  </div> 
                </td>`
        }
        template += '</tr>';
/*
         template += '<td style="text-align:center"> <input type="number" id="td_nueva_cantidad_'+ index +'" onchange="update_subtotal_price('+index+')" value="'+ producto.cantidad +'"> </td>';
        template += '<td style="text-align:center" id="td_sub_total_'+ index +'">' + parseFloat(producto.subtotal).toFixed(2) + '</td>';
        template += '</tr>';

*/
        $("#body_productos_remision").append(template);
        
    })
}

function verify_add_row_table(product_list){


  if(product_list.length == 0){

    add_fillable_product();

  }
  else{

    $.each(product_list, function (index, producto) {
      add_fillable_product(producto,index);
    })
    update_remision_indepent();

  }

}

function add_fillable_product(product_unique , index){
  index = (index !==undefined)? index : document.getElementById("body_productos_remision").childNodes.length;
  var value;
  var fillable = `<tr id="tr_${index}">`;

  ////// one td
  value = (product_unique !== undefined) ? product_unique.descripcion : '';
  fillable += `<td style='text-align:left'> <input class="form-control"  type="text" id="td_description_${index}"  style="width:80%" value="${value}"> </td>`;

  ////// two td
  value = (product_unique !== undefined) ? product_unique.cantidad : '';
  fillable += `<td style='text-align:left'> <input class="form-control"  onkeypress="return solonumeros(event)"  id="td_nueva_cantidad_${index}" onchange="update_product_guia( ${index} )" type="text"  style="width:50%" value="${value}"> </td>`;


 ////// three td
  value = (product_unique !== undefined) ? product_unique.id_unidad : '';
  var option;
  $.each(list_option.unidades, function(index, element) {
    let select = (value===element.id_unidad)?'selected':'';
    option+=`<option style=" text-align = 'center' " ${select} value="${element.id_unidad}"> ${element.abreviatura} </option>`;
    
  });
  fillable += `<td>
                <select style="text-align-last:center; text-align: center;" class="form-control" id="td_unidad_${index}">
                  ${option}
                </select>
              </td>`;


  ///// three rd 
  value = (product_unique !== undefined) ? product_unique.precio : '';
  fillable += `<td style='text-align:left'>  
                  <div  style="height: 100%;" class="input-group">
                    <div style="height: 80%; width: 10%;" class="input-group-addon">S/</div>
                    <input class="form-control"  onchange="update_product_guia( ${index} )"  id="td_precio_${index}" style="height: 100%; width: 100%; margin-right:50px;" type="text" text-align: center; value="${value}">
                  </div> 
                </td>`;

/*
    ////// three  td
  value = (product_unique !== undefined) ? product_unique.impuesto : '';
    fillable += `<td style='text-align:left'>  
                  <div  style="height: 100%;" class="input-group">
                    <input id="td_impuesto_${index}" onchange="update_product_guia( ${index} )"   style="height: 100%; width: 80%; margin-right:50px;" type="text" text-align: center;">
                    <div style="" class="input-group-addon">%</div>
                  </div> 
                </td>`;

*/

    ////// five td
  value = (product_unique !== undefined) ? product_unique.subtotal : '';
    fillable += `<td style='text-align:left'>  
                  <div  style="height: 100%;" class="input-group">
                    <div style="height: 100%; width: 10%;" class="input-group-addon">S/</div>
                    <input class="form-control"  id="td_subtotal_${index}" readonly="true"  style="background-color:#F0F0F0; height: 100%; width: 80%; margin-right:60px;" type="text" text-align: center;" value="${value}">
                  </div> 
                </td>`;

/*
    ////// six td
  value = (product_unique !== undefined) ? product_unique.Total: '';
  fillable += `<td style='text-align:left'>  
                  <div  style="height: 100%;" class="input-group">
                    <div style="height: 100%; width: 10%;" class="input-group-addon">S/</div>
                    <input id="td_total_${index}" readonly="true"  style="background-color:#F0F0F0; height: 100%; width: 80%; margin-right:60px;" type="text" text-align: center;">
                  </div> 
                </td>`;
*/

    ////// seven td Buttons
  fillable +=
  `<td style='text-align:center'> 
    <button type="button" style="width:45%" onclick="delete_fillable_product(this)" class="btn btn-danger">
      <i class="fa fa-trash-o" aria-hidden="true"></i>
    </button>
    <button type="button"  style="width:45%" onclick="add_fillable_product()" class="btn  btn-default">
      <i class="fa fa-plus" aria-hidden="true"></i>
    </button> 
  </td>`;


  fillable += `</tr>`;

  $("#body_productos_remision").append(fillable);
  
}

  function edit_table_body(lst_producto,operacion){
      $.each(lst_producto, function (index, product) {

        if(product.cantidad_despachada !== undefined){
          $.each($("#tr_"+product.index+" input[name='item_check']"), function(){
             this.checked=true;
          });
        }

      });

    if( operacion!='traspaso' && operacion != 'entradas_salidas' ){
      update_total_price();
    }else if( operacion=='entradas_salidas' || operacion=='traspaso' ){
      update_remision_entradas_salidas();
    }

  }

  function solonumeros(e, positivo=false){
      key=e.keyCode || e.which;
      teclado=String.fromCharCode(key);
      numeros="1234567890";
      especiales="8-9-17-37-38-46";//los numeros de esta linea son especiales y es para las flechas
      teclado_especial=false;
      for(var i in especiales)
          if (key==especiales[i])
              teclado_especial=true;
      if( positivo && parseFloat(e.target.value)<0 )
        return false
      if (numeros.indexOf(teclado)==-1 && !teclado_especial)
        return false;
  }



function update_subtotal_price(index_id) {

   
    var producto = lst_producto[index_id];
    
    var nueva_cantidad = parseFloat($("#td_nueva_cantidad_"+index_id).val()).toFixed(2);

    var cotizacion_stock = parseFloat(producto.cantidad_parcial);

    if( (cotizacion_stock == 0.00 || cotizacion_stock == 0) ){ // &&  producto.cantidad_despachada === undefined
        alert('No es posible mas cantidad del mismo producto');
        $("#td_nueva_cantidad_"+index_id).val('');
        $("#td_sub_total_"+index_id).html(parseFloat(producto.subtotal).toFixed(2));
        $("#checkbox_"+index_id).attr('checked', false);

        if(tipo_operacion!='traspaso' && tipo_operacion!='entradas_salidas' ){
          update_total_price();
        }else if(tipo_operacion=='entradas_salidas'){
          update_remision_entradas_salidas();
        }
        return false;

    }


    if (nueva_cantidad == 0.00 ) { // && producto.cantidad_despachada !== undefined
        alert('Si selecciona 0 el producto no sera despachado');
        $("#td_nueva_cantidad_"+index_id).val(producto.cantidad_despachada);
        $("#td_sub_total_"+index_id).html(parseFloat(producto.subtotal).toFixed(2));
        return false;
    }
    if (nueva_cantidad == 0.00 ) {
        alert('Si selecciona 0 el producto no sera despachado');
        $("#td_nueva_cantidad_"+index_id).val(producto.cantidad_parcial);
        $("#td_sub_total_"+index_id).html(parseFloat(producto.subtotal).toFixed(2));
        $("#checkbox_"+index_id).attr('checked', false);
        return false;
    }
    
    /* revisar
    if (producto.um_min !== 'UND') {
      console.log(producto.stock_min);
        cotizacion_stock = (parseFloat(producto.stock_min) / parseFloat(producto.cantidad_und).toFixed(2));
    }
    */
    if( nueva_cantidad<0 ){
      alert('El número de ítems debe ser igual o mayor a 0.');
      $("#td_nueva_cantidad_"+index_id).val('');
      $("#checkbox_"+index_id).attr('checked', false);

      if(tipo_operacion!='traspaso' && tipo_operacion!='entradas_salidas' ){
        update_total_price();
      }else if(tipo_operacion=='entradas_salidas'){
        // update_remision_entradas_salidas();
      }
      return false;
    }
    if (cotizacion_stock < nueva_cantidad ) { // && producto.cantidad_despachada === undefined
        alert('No hay stock suficiente');
        $("#td_nueva_cantidad_"+index_id).val('');
        $("#td_sub_total_"+index_id).html(parseFloat(producto.subtotal).toFixed(2));
        $("#checkbox_"+index_id).attr('checked', false);

        if(tipo_operacion!='traspaso' && tipo_operacion!='entradas_salidas' ){
          update_total_price();
        }else if(tipo_operacion=='entradas_salidas'){
          update_remision_entradas_salidas();
        }
        return false;
    }
    producto.cantidad_unidades = parseFloat(producto.cantidad_unidades);
    if (nueva_cantidad > producto.cantidad_unidades ) { // && producto.cantidad_despachada === undefined
        alert('Excede la cantidad de productos cotizados');
        $("#td_nueva_cantidad_"+index_id).val('');
        $("#td_sub_total_"+index_id).html(parseFloat(producto.subtotal).toFixed(2));
        $("#checkbox_"+index_id).attr('checked', false);

        if(tipo_operacion!='traspaso'){
          update_total_price();
        }else if(tipo_operacion=='entradas_salidas' && tipo_operacion!='entradas_salidas' ){
          update_remision_entradas_salidas();
        }
        return false;
    }


    if(producto.cantidad_validar!==undefined){
      if(producto.cantidad_validar < nueva_cantidad){
        alert('Este producto ya ha sido cotizado recuerde que esta cantidad supera al stock completo');
        $("#td_sub_total_"+index_id).html(parseFloat(producto.subtotal).toFixed(2));
        $("#td_nueva_cantidad_"+index_id).val(producto.cantidad_despachada);

        if(tipo_operacion!='traspaso' && tipo_operacion!='entradas_salidas' ){
          update_total_price();
        }else if(tipo_operacion=='entradas_salidas'){
          update_remision_entradas_salidas();
        }

        return false;
      }

    } 


     var muevo_subtotal;
    if(producto.precio_descuento!=0 && producto.precio_descuento !== undefined){
      muevo_subtotal = parseFloat(producto.precio_descuento * nueva_cantidad).toFixed(2);

    }else if(producto.precio_descuento==undefined){
        muevo_subtotal = parseFloat(producto.precio_unitario * nueva_cantidad).toFixed(2);
    }


    $("#td_nueva_cantidad_"+index_id).val(nueva_cantidad);
    $("#td_sub_total_"+index_id).html(muevo_subtotal);
    $("#checkbox_"+index_id).attr('checked', true);

    if(tipo_operacion!='traspaso' && tipo_operacion!='entradas_salidas' ){
      update_total_price();
    }else if(tipo_operacion=='entradas_salidas'){
      update_remision_entradas_salidas();
    }else {
      update_total_price();      
    }

}



function seleccionar_todo(elem) {
    // console.log(elem.checked);
    $(elem).attr('checked', elem.checked);
    if(elem.checked) {
        $('input[name="item_check"]').each(function() {
          if(!this.disabled){
            this.checked = true;
            if(tipo_operacion!='entradas_salidas'){
              update_total_price();
            }else if(tipo_operacion=='entradas_salidas'){
              update_remision_entradas_salidas();
            }
          }
        });
    } else {
        $('input[name="item_check"]').each(function() {
          this.checked = false;
          reset_total_inputs();
        });
    }
}

function despachar_todo(elem){
  seleccionar_todo(elem);
  $.each($("input[name='item_check']:checked"), function(){
    var index_id = $(this).attr('id').split("_").pop();        
    var producto = lst_producto[index_id];        
    if($(this).is(':checked')){
      $("#td_nueva_cantidad_"+index_id).val(producto.cantidad_parcial);
    }
  });
  update_total_price();
}

function reset_total_inputs() {
    const cero_value = 0;
    $.each($("input[name='item_check']"), function(){
      var index_id = $(this).attr('id').split("_").pop();
      $("#td_nueva_cantidad_"+index_id).val('');
      $("#td_nueva_cantidad_"+index_id).prop("readonly",true);
    });
          
    $("#subtotal").val(parseFloat(cero_value).toFixed(2));
    $("#total_descuento").val(parseFloat(cero_value).toFixed(2));
    $("#impuesto").val(parseFloat(cero_value).toFixed(2));
    $("#total_importe").val(parseFloat(cero_value).toFixed(2));
  
    $("#total_producto").val(cero_value);
}

function update_total_price() {
    var total_original = 0.00;
    var total_descuento = 0.00;
    
    var total_productos_seleccionados = 0;

    var impuesto_id = $("#tipo_impuesto").val();
    
    const impuesto = 18.00;
    
    var suma_impuestos = 0.00;
    
    var check_contador = 0;
    
    var total_input_checks = $("input[name='item_check']").length; 
    
    $.each($("input[name='item_check']:checked"), function(){
        check_contador++;
        var index_id = $(this).attr('id').split("_").pop();
        
        var producto = lst_producto[index_id];
        if($(this).is(':checked')){

          $("#td_nueva_cantidad_"+index_id).prop("readonly",false);

          if(producto.cantidad_despachada !==undefined && $("#td_nueva_cantidad_"+index_id).val()==''){  
            $("#td_nueva_cantidad_"+index_id).val( parseFloat(producto.cantidad_despachada));
          }else if( $("#td_nueva_cantidad_"+index_id).val()==''){
            $("#td_nueva_cantidad_"+index_id).val(0);
          }
          var nueva_cantidad = parseFloat($("#td_nueva_cantidad_"+index_id).val()).toFixed(2);
        }


        
        var precio_unitario_original = parseFloat(producto.precio_unitario).toFixed(2);

        var subtotal_original = parseFloat( nueva_cantidad * precio_unitario_original).toFixed(2);
        var subtotal_original = parseFloat( subtotal_original );
  
        var subtotal_descuento = 0.00;
        
        var subtotal = 0.00;

        if (parseFloat(producto.descuento).toFixed(2) > 0.00) {

            var precio_unitario_descuento = parseFloat(producto.precio_descuento).toFixed(2);
            subtotal_descuento = nueva_cantidad * precio_unitario_descuento;

            total_descuento = subtotal_original - subtotal_descuento;

            subtotal = subtotal_descuento;
            total_original += subtotal_descuento

        } else {
            subtotal = subtotal_original;
            total_original += subtotal_original;
        }
     
        

        if (impuesto_id == 1) {
            var factor = parseFloat((impuesto + 100) / 100);
            suma_impuestos = parseFloat(subtotal - (subtotal / factor));
        } else if (impuesto_id == 2) {
            var factor = parseFloat((impuesto + 100) / 100);
            suma_impuestos = parseFloat((subtotal * factor) - subtotal);
        } else {
  
        }

        total_productos_seleccionados++;
    });

    $.each($("input[name='item_check']:not(:checked)"), function(){
      
        var index_id = $(this).attr('id').split("_").pop();
        $("#td_nueva_cantidad_"+index_id).val('');
        $("#td_nueva_cantidad_"+index_id).prop("readonly",true);
    
        

    });

    if (total_input_checks - check_contador === 1) {
        $("#check_all").prop('checked', false);
    }
    
    if (total_input_checks === check_contador) {
        $("#check_all").prop('checked', true);
    }
    
    var subtotal_final = 0.00;
    var total = 0.00;
    if (impuesto_id == 1) {
        subtotal_final = total_original - suma_impuestos;
        total = total_original;
    } else if (impuesto_id == 2) {
        subtotal_final = total_original;
        total = total_original + suma_impuestos;
    } else {
        total = total_original;
    }

    $("#subtotal").val();
    $("#total_descuento").val(parseFloat(total_descuento).toFixed(2));
    $("#impuesto").val(parseFloat(suma_impuestos).toFixed(2));
    $("#total_importe").val(parseFloat(total).toFixed(2));
    
    $("#total_producto").val(total_productos_seleccionados);


}

function delete_fillable_product(object){
  var table_prodcut  = object.parentNode.parentNode.parentNode;
  var fillable  = object.parentNode.parentNode;

  /// Verifi quantity product in table
  if(table_prodcut.childNodes.length == 1){
        
      Array.from(table_prodcut.childNodes).map(elem => {
    
        Array.from(elem.childNodes).map(elem_child => {
   
            Array.from(elem_child.childNodes).map(elem_child_tochild=> {

                if(elem_child_tochild.nodeName=='INPUT'){

                  elem_child_tochild.value='';

                }else if(elem_child_tochild.nodeName=='DIV'){

                   Array.from(elem_child_tochild.childNodes).map(elem_in_div=> {

                    if(elem_in_div.nodeName=='INPUT'){
                      elem_in_div.value='';
                    }
    
                   })

                }
            })

         
        })

      })
  }else{
    table_prodcut.removeChild(fillable);
  }

}


//// Functions new table add products remisidon independent


function update_remision_indepent(){

   var total_original = 0.00;

    var total_descuento = 0.00;
    
    var total_productos_seleccionados = 0;

    var impuesto_id = $("#tipo_impuesto").val();
  
    
    var suma_impuestos = 0.00;
    
    var check_contador = 0;


    var subtotal_final = 0.00;

    $.each($("input[name='item_check']:checked"), function(){
   
      var index =  $(this).attr('id').split("_").pop();

     
      if( ($('#td_nueva_cantidad_'+index).val() !=='' && $('#td_nueva_cantidad_'+index).val() !==null)  && (($('#td_precio_'+index).val() !=='' && $('#td_precio_'+index).val() !==null) ) ) {
          
         // var impuesto = parseFloat($("#td_impuesto_"+index).val()).toFixed(2);
          var nueva_cantidad = parseFloat($("#td_nueva_cantidad_"+index).val()).toFixed(2);
          var precio_unitario_original = parseFloat($("#td_precio_"+index).val()).toFixed(2);
          var subtotal_original = nueva_cantidad * precio_unitario_original;
    
          subtotal = subtotal_original;
          total_original += subtotal_original;
          total_productos_seleccionados++;
      }
      
    });
      
      var subtotal_final = total_original;
      var total = total_original;
      
      $("#subtotal").val(parseFloat(subtotal_final).toFixed(2));
      $("#total_descuento").val(parseFloat(0).toFixed(2));
      $("#impuesto").val(parseFloat(0).toFixed(2));
      $("#total_importe").val(parseFloat(total).toFixed(2));    
      $("#total_producto").val(total_productos_seleccionados);
        
}

function update_remision_entradas_salidas(){

    var total_original = 0.00;

    var total_productos_seleccionados = 0;

    var total_nuevo = 0.00;

    var check_contador = 0;
    
    var total_input_checks = $("input[name='item_check']").length; 
    
    $.each($("input[name='item_check']:checked"), function(){
        check_contador++;
        var index_id = $(this).attr('id').split("_").pop();
        
        var producto = lst_producto[index_id];
       
        if($(this).is(':checked')){

          $("#td_nueva_cantidad_"+index_id).prop("readonly",false);

          if(producto.cantidad_despachada !==undefined && $("#td_nueva_cantidad_"+index_id).val()==''){  
            $("#td_nueva_cantidad_"+index_id).val( parseFloat(producto.cantidad_despachada));
          }else if( $("#td_nueva_cantidad_"+index_id).val()==''){
            $("#td_nueva_cantidad_"+index_id).val(0);
          }
          var nueva_cantidad = parseFloat($("#td_nueva_cantidad_"+index_id).val()).toFixed(2);
        }

        var precio_unitario_original = parseFloat(producto.precio_unitario).toFixed(2);

        var subtotal_original = parseFloat( nueva_cantidad * precio_unitario_original ).toFixed(2);
        var subtotal_original = parseFloat( subtotal_original );  

        total_nuevo += subtotal_original;
        total_productos_seleccionados++;
    });

    $.each($("input[name='item_check']:not(:checked)"), function(){
      
        var index_id = $(this).attr('id').split("_").pop();
        $("#td_nueva_cantidad_"+index_id).val('');
        $("#td_nueva_cantidad_"+index_id).val('');
        $("#td_sub_total"+index_id).val('');
  
    });

    if (total_input_checks - check_contador === 1) {
        $("#check_all").prop('checked', false);
    }
    
    if (total_input_checks === check_contador) {
        $("#check_all").prop('checked', true);
    }
    var total = total_nuevo
    $("#total_importe").val(parseFloat(total).toFixed(2));
    $("#total_producto").val(total_productos_seleccionados);
        
}



function update_product_guia(index_id) {

  if( ($('#td_nueva_cantidad_'+index_id).val() !=='' && $('#td_nueva_cantidad_'+index_id).val() !==null)  && ($('#td_precio_'+index_id).val() !=='' && $('#td_precio_'+index_id).val() !==null) ) {
      
      var nueva_cantidad = parseFloat($("#td_nueva_cantidad_"+index_id).val()).toFixed(2);

      var precio_unitario = parseFloat($("#td_precio_"+index_id).val()).toFixed(2);

      var impuesto_id = $("#tipo_impuesto").val();

      var total;

      var suma_impuestos;

       var impuesto = parseFloat($("#td_impuesto_"+index_id).val()).toFixed(2);


      var nuevo_subtotal = parseFloat(precio_unitario * nueva_cantidad).toFixed(2);

      total=nuevo_subtotal;
      var cantidad_disponible = lst_producto[index_id].cantidad_parcial;


      if (nueva_cantidad == 0.00 || nueva_cantidad < 0.00  ) {
          alert('Si selecciona una cantidad de  0 el producto no sera seleccionado');
          $("#td_nueva_cantidad_"+index_id).val(0);
          $("#td_sub_total_"+index_id).html(parseFloat(''));
          update_remision_indepent();
          return false;
      }else if (nueva_cantidad > cantidad_disponible ) {
          alert('Si selecciona una cantidad mayor a la cantidad disponible');
          $("#td_nueva_cantidad_"+index_id).val(0);
          $("#td_sub_total_"+index_id).html(parseFloat(''));
          update_remision_indepent();
          return false;
      }

      if (precio_unitario == 0.00 || precio_unitario < 0.00  ) {
          alert('El campo de precio no puede ser menor o igual a 0');
          $("#td_nueva_cantidad_"+index_id).val(0);
          $("#td_sub_total_"+index_id).html(parseFloat(''));
          update_remision_indepent();
          return false;
      }


      
/*
     if (impuesto_id == 1) {

              var factor = parseFloat(100)+parseFloat(impuesto);
              factor=factor/100;
              suma_impuestos = parseFloat(nuevo_subtotal - (nuevo_subtotal / factor));

          
      } else if (impuesto_id == 2) {

                var factor = parseFloat(100)+parseFloat(impuesto);
                factor=factor/100;
                suma_impuestos = parseFloat((nuevo_subtotal * factor) - nuevo_subtotal);

      } 


      
      if (impuesto_id == 1) {
          total = total - suma_impuestos;
        
      } else if (impuesto_id == 2) {

          subtotal_final = total;
          total = total + suma_impuestos;

      } 
   */
      $("#td_nueva_cantidad_"+index_id).val(nueva_cantidad);
      $("#td_subtotal_"+index_id).val(nuevo_subtotal);
    //  $("#td_total_"+index_id).val(total);
      update_remision_indepent();

    }else{
      update_remision_indepent();
    }
}


function no_empty_validate_product(){

   var table_prodcut  = document.querySelectorAll("#body_productos_remision tr td");
    var result=true;
      Array.from(table_prodcut).map(elem_child => {
        
        Array.from(elem_child.childNodes).filter(elem_child_tochild=> {
            
            if(elem_child_tochild.nodeName=='INPUT'){

                if( elem_child_tochild.value==''){

                  return result = false;
                }

            }else if(elem_child_tochild.nodeName=='DIV'){

                Array.from(elem_child_tochild.childNodes).filter(elem_in_div=> {

                  if(elem_in_div.nodeName=='INPUT'){

                    if( elem_in_div.value==''){

                      return result = false;
                     
                    }

                  }
  
                })

            }
        }) 
    
      })
    return result;


}