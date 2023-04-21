App.sidebar('close-sidebar');

var cardSucursalGlobal;
var cardEmpresaGlobal;

// $('#numerodocumento_alias').on("blur", delegateDNI)
/*$('body table.formempresa input#doc_tipo_representante_value').on("keyup", delegateDNI)
$('body table.formempresa input#doc_tipo_empresa_value').bind("keyup", delegateRUC)
*/
$('body table.formempresa input#doc_tipo_representante_value').on("keypress", soloNumeros)
$('body table.formempresa input#doc_tipo_empresa_value').bind("keypress", soloNumeros)

function soloNumeros(e){
  if($('#doc_tipo_empresa').val() == 1 || $('#doc_tipo_empresa').val() == 3){
      var key = e.which;
      if (key < 48 || key > 57) {
        e.preventDefault();
      }
  }
}

const RUCVALUE = 3;
const DNIVALUE = 1;
function delegateRUC(e) {
  let row = $(e.target).parent().parent()
  let selector = row.parent().parent().find("#doc_tipo_empresa");
  let selector_value = selector.val();
  limitCharacter(selector[0]);
  let limite = row.find('.doc-limit')[0].maxLength

  if(selector_value==RUCVALUE){
    if( $(e.target).val().length==limite )
      getRUC(e.target);
    else
      mensaje('warning', 'El RUC debe tener '+limite+' caracteres de longitud.');
  }else if(selector_value==DNIVALUE){
    if( $(e.target).val().length==limite )
      getDNI(e.target);
    else
      mensaje('warning', 'El DNI deben tener '+limite+' caracteres de longitud.');
  }else{
    mensaje('warning', 'No es ninguno de lo 2');
    return;
  }
}

function delegateDNI(e) {
  getDNI(e.target);
}

$('.back-list').click(function (e) {
  $('#barloadermodal').modal('show');
  $.ajax({
    url: ruta + 'clientesopcion',
    type: 'POST',
    success: function (data) {
      $('#page-content').html(data);
      $('#barloadermodal').modal('hide');
      $(".modal-backdrop").remove();
    },
    error: function () {
      alert('Error inesperado');
    },
  });
});

$('#addEmpresa').click(function (e) {
  e.preventDefault();

  flexMensaje(false);
  appendEmpresa();

})

function enableEmpresa(e){
  if(e.target.checked){
    flexMensaje(false);
    appendEmpresa();
  }
  else{
    if(document.querySelectorAll('#contentEmpresas .input-seteado').length > 0){
      mensaje('warning', 'No puede deshabilitar esta opción sin antes eliminar las empresas asociadas');
      e.target.checked = true;
      return;
    }
    Array.from(document.querySelectorAll('#contentEmpresas .btn-delete-empresa')).forEach(btn => {
      btn.querySelector('i').click();
    });
  }
}

function appendEmpresa(){
  let tableEmpresa = document.querySelector('.table-empresa').cloneNode(true);
 // tableEmpresa.querySelector('.actions').appendChild(addButtonDeleteEmpresa());
  tableEmpresa.classList.remove('table-empresa');

  $(tableEmpresa).fadeIn(500);
/*  $(tableEmpresa.querySelector('input#doc_tipo_representante_value')).on('blur', delegateDNI)*/
  // $(tableEmpresa.querySelector('input#doc_tipo_empresa_value')).on('blur', delegateRUC)

  // if(document.querySelector('#cliente_id_desde_alias').value != '' && 
  //    document.getElementById('contentEmpresas').querySelectorAll('.formempresa').length == 0){

  //   let cliente_id = document.querySelector('#cliente_id_desde_alias').value;

  //   $.ajax({
  //     url: `${ruta}clientesopcion/getClienteId`,
  //     data: { cliente_id },
  //     type: 'post',
  //     dataType: 'json',
  //     success(resp){
  //       if(resp.status == false) return;
        
  //       let { data } = resp;

  //       let selectInd = Array.from(tableEmpresa.querySelector('#doc_tipo_empresa').options).find(option => option.value = data.tipo_cliente);
  //           if(selectInd != undefined) selectInd.selected;

  //       tableEmpresa.querySelector('#doc_tipo_empresa_value').value = data.identificacion;
  //       tableEmpresa.querySelector('#razon_social').value = data.razon_social;
  //       tableEmpresa.querySelector('#direccion_empresa').value = data.direccion;

  //       let selectIndEmpr = Array.from(tableEmpresa.querySelector('#doc_tipo_empresa').options).find(option => option.value = data.tipodocumento_represent);
  //           if(selectIndEmpr != undefined) selectIndEmpr.selected;

  //       tableEmpresa.querySelector('#doc_tipo_representante_value').value = data.representante_dni;
  //       tableEmpresa.querySelector('#representante_empresa').value = data.representante_nombre;
  //       tableEmpresa.querySelector('#estado_empresa').checked = data.cliente_status;
  //       tableEmpresa.querySelector('#estado_sunat').value = (data.status_sunat == true)? 'ACTIVO' : 'INACTIVO';
  //       tableEmpresa.querySelector('#pagina_web').value = data.pagina_web;
  //       tableEmpresa.querySelector('#telefono_empresa').value = data.telefono1;
  //       tableEmpresa.querySelector('#id_cliente').value = data.id_cliente;


  //       let selectIndGiro = Array.from(tableEmpresa.querySelector('#giro_negocio').options).find(option => option.value = data.tipo_id);
  //           if(selectIndGiro != undefined) selectIndGiro.selected;

  //       let selectIndGrupo = Array.from(tableEmpresa.querySelector('#grupo').options).find(option => option.value = data.grupo_id);
  //           if(selectIndGrupo != undefined) selectIndGrupo.selected;

  //        document.getElementById('contentEmpresas').appendChild(tableEmpresa); 
  //     }
  //   })
  // }
  // else{
    document.getElementById('contentEmpresas').appendChild(tableEmpresa); 
   $('#doc_tipo_empresa').change()
  // }
}

function flexMensaje(bool){
  if(!bool){ 
    document.getElementById('contentEmpresas').classList.remove('flex-mensaje');
    document.querySelector('#contentEmpresas .mensaje').style.display = 'none';
    document.querySelector('#habilitar_empresa_negocio').checked = !bool;

    $('.common-hide').fadeOut(500);  
  }
  else{
    document.getElementById('contentEmpresas').classList.add('flex-mensaje');
    document.querySelector('#contentEmpresas .mensaje').style.display = 'block';
    document.querySelector('#habilitar_empresa_negocio').checked = !bool;
    document.querySelector('#cliente_id_desde_alias').value = '';

    $('.common-hide').fadeIn(500);  
  }
}

function addButtonDeleteEmpresa() {
  let ancla = document.createElement('a');
  let icon = document.createElement('i');

  ancla.href = 'javascript:void(0)';
  ancla.style = 'color: #fff; font-size: 16px';
  ancla.className = 'btn-delete-empresa';
  ancla.onclick = (e) => deleteEmpresa(e.target.parentNode);

  icon.className = 'fa fa-times-circle fa-lg';

  ancla.appendChild(icon);

  return ancla;
}

function deleteEmpresa(obj) {

  let tableEmpresa = getNthParent(obj, 6);
  let content = tableEmpresa.parentNode;

  $(tableEmpresa).fadeOut(500, function () {
    tableEmpresa.remove();

    if(content.querySelectorAll('.formempresa').length == 0){
       flexMensaje(true);
    }
  })
}

function confirmDeleteEmpresa(obj) {
  let cardEmpresa = getNthParent(obj, 6);
  let id = cardEmpresa.querySelector('#id_cliente').value;

  cardEmpresaGlobal = obj;

  document.querySelector('#confirm_text').innerHTML = '¿Estás seguro de que deseas eliminar esta empresa?';
  document.querySelector('#confirm_button').setAttribute('onclick', `deleteEmpresaAjax("${id}")`);
  $('#dialog_confirm').modal('show');
}

function deleteEmpresaAjax(id) {
  let url = `${ruta}clientesopcion/eliminarEmpresa/${id}`;
  $.ajax({
    url: url,
    data: { id },
    type: 'post',
    success: function (resp) {
      if (resp.status == true) {
        mensaje('success', resp.msg)
        $('#dialog_confirm').modal('hide');
        deleteEmpresa(cardEmpresaGlobal);
        cardEmpresaGlobal = '';
      }
      else {
        mensaje('error', resp.msg);
        $('#dialog_confirm').modal('hide');
      }
    }
  })
}

function addSucursal(obj) {
  let cardCompleta = getNthParent(obj, 4);
  let contentSucursales = cardCompleta.querySelector('#contentSucursales');

  let rowSucursal = document.querySelector('#cardSucursalBase #cardSucursalBaseTr').cloneNode(true);
  rowSucursal.classList.add('card-sucursal');
  $(rowSucursal).fadeIn(500);
  contentSucursales.parentNode.insertBefore(rowSucursal, contentSucursales.nextSibling);

  let sucursalesActivas = cardCompleta.querySelectorAll('.card-sucursal').length;

  if (sucursalesActivas > 0) {
    let rowVendedor = cardCompleta.querySelector('.row-vendedor');
    rowVendedor.querySelectorAll('input').forEach((item) => { item.disabled = true });
    $(rowVendedor).hide(500);
  }

  activarAutocompleteUbigeoSucursal(rowSucursal.querySelector('#ubigeo_suc'), rowSucursal.querySelector('#ubigeo_suc_id'))

}

function editSucursalesUbigeo(){
  let sucursalescreadas = document.querySelectorAll('.card-sucursal');

  Array.from(sucursalescreadas).forEach(cardSucursal => {
      activarAutocompleteUbigeoSucursal(cardSucursal.querySelector('#ubigeo_suc'), cardSucursal.querySelector('#ubigeo_suc_id'), true);
  })

}

function activarAutocompleteUbigeoSucursal(ubigeo_suc,  ubigeo_suc_id, callbacksearch){
      $(ubigeo_suc).autocomplete({
        autoFocus: true,
        source: function(request, response) {
          $.ajax({
            url: ruta + 'clientesopcion/get_ubigeo_json',
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
            auto_add = ui.content[0].codigo_barra == $(ubigeo_suc).val();

            $(this).val(ui.content[0].value);
            $(this).autocomplete('close');
            var prod = $(ubigeo_suc_id);
            var template = `
                <option 
                value="${ui.content[0].id}"
                data-provincia="${ui.content[0].provincia}" 
                data-departamento="${ui.content[0].departamento}"
            data-distrito="${ui.content[0].distrito}">

                    ${ui.content[0].value}

              </option>
            `;

            prod.html(template);
            prod.trigger('change');
          }
        },
        select: function(event, ui) {
            var prod = $(ubigeo_suc_id);

            var template = `
                <option 
                value="${ui.item.id}"
                data-provincia="${ui.item.provincia}" 
                data-departamento="${ui.item.departamento}"
            data-distrito="${ui.item.distrito}">

                    ${ui.item.value}

              </option>
            `;

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

      if(typeof callbacksearch != 'undefined') $(ubigeo_suc).autocomplete('search');
}

function confirmDeleteSucursal(obj) {
  let cardSucursal = getNthParent(obj, 8);
  let cardCompleta = getNthParent(cardSucursal, 1);
  let id = cardSucursal.querySelector('#id_sucursal').value;

  cardSucursalGlobal = obj;

  document.querySelector('#confirm_text').innerHTML = '¿Estás seguro de que deseas eliminar esta sucursal?';
  document.querySelector('#confirm_button').setAttribute('onclick', `deleteSucursalAjax("${id}")`);
  $('#dialog_confirm').modal('show');
}


function deleteSucursalAjax(id) {
  let url = `${ruta}clientesopcion/eliminarSucursal/${id}`;
  $.ajax({
    url: url,
    data: { id },
    type: 'post',
    success: function (resp) {
      if (resp.status == true) {
        mensaje('success', resp.msg)
        $('#dialog_confirm').modal('hide');
        deleteSucursal(cardSucursalGlobal);
        cardSucursalGlobal = '';
      }
      else {
        mensaje('error', resp.msg)
        $('#dialog_confirm').modal('hide');
      }
    }
  })
}

function deleteSucursal(obj) {
  let cardSucursal = getNthParent(obj, 8);
  let cardCompleta = getNthParent(cardSucursal, 1);

  $(cardSucursal).fadeOut(500, function () {
    cardSucursal.remove();

    let sucursalesActivas = cardCompleta.querySelectorAll('.card-sucursal').length;
    if (sucursalesActivas == 0) {
      let rowVendedor = cardCompleta.querySelector('.row-vendedor');
      rowVendedor.querySelectorAll('input').forEach(item => item.disabled = false);
      $(rowVendedor).show(500);
    }
  });
}

// function addNegocio(obj) {
//   let detailDetalles = Boolean(parseInt(obj.getAttribute('data-detail')));

//   obj.textContent = (detailDetalles == false) ? 'Menos detalles' : 'Agregar más detalles';
//   obj.setAttribute('data-detail', (detailDetalles == false) ? 1 : 0);

//   let cardCompleta = getNthParent(obj, 6);
//   let hideField = cardCompleta.querySelectorAll('.hide-field');
//   let hideFieldRow = cardCompleta.querySelectorAll('.hide-field-row');

//   $(hideField).fadeToggle(500);
//   $(hideFieldRow).fadeToggle(500);
// }

function addVendedorZona(obj) {
  let row = getNthParent(obj, 2);
  let vendedorZona = row.querySelector('#vendedor-zona');
  $(vendedorZona).fadeToggle(500);
}


function limitCharacter(obj) {
  let rowTable = getNthParent(obj, 2);
  let optionSelected = obj.options[obj.options.selectedIndex];
  let limit = optionSelected.getAttribute('data-limit');
  rowTable.querySelector('.doc-limit').maxLength = limit;
  rowTable.querySelector('.doc-limit').onblur();
}

function validateLimitCharacter(obj) {
  let currentLimit = obj.maxLength;
  let strValue = obj.value.length;

  if (strValue > currentLimit) {
    $.bootstrapGrowl('Ha sobrepasado la longitud de caracteres del documento, se ha ajustado el valor.', {
      type: 'warning',
      delay: 5000,
      allow_dismiss: true,
    });
    obj.value = obj.value.substring(0, currentLimit);
  }
}

function checkCodigoInterno(obj) {
  document.querySelector('#codigointerno_alias').readOnly = obj.checked;
}

function checkEstado(obj) {
  let spanMsg = obj.parentNode.parentNode.querySelector('span');
  spanMsg.className = (obj.checked) ? 'label label-success' : 'label label-danger';
  spanMsg.textContent = (obj.checked) ? 'ACTIVO' : 'INACTIVO';
}

function getGlosaPersona(obj, isSelect) {
  if (isSelect == true) {
    limitCharacter(obj);
  }

  let rowTable = getNthParent(obj, 3);
  // let glosaPersona = {
  //   ruc20: 'PERSONA JURIDICA',
  //   ruc10: 'PERSONA NATURAL CON NEGOCIO',  
  //   noruc: ''  
  // }

  let docValue = rowTable.querySelector('#doc_tipo_empresa_value').value;
  let docTipoEmpresa = rowTable.querySelector('#doc_tipo_empresa');
  let isRuc = docTipoEmpresa.options[docTipoEmpresa.options.selectedIndex].textContent.trim();
  let docValue2Char = parseInt(docValue.substring(0, 2));
  // let glosa = rowTable.querySelector('#glosa_persona');

  // if (isRuc == 'RUC' && docValue2Char == 20) {
  //   glosa.innerHTML = glosaPersona.ruc20;
  // }
  // else if (isRuc == 'RUC' && docValue2Char == 10) {
  //   glosa.innerHTML = glosaPersona.ruc10;
  // }
  // else {
  //   glosa.innerHTML = glosaPersona.noruc;
  // }

  if(isRuc != 'RUC'){
    fadeRowRepresentante(true);
  }
  else{
    fadeRowRepresentante(false);
  }

}

function fadeRowRepresentante(bool){
  if(bool){
    $('#row-representante').fadeOut();
  }
  else{
    $('#row-representante').fadeIn();
  }
}

function elementDniSelected(cardCompleta, obj){
  
  let optionSelectedDoc;
  let loading;

  if(obj.id == 'doc_tipo_empresa_value'){
    optionSelectedDoc = cardCompleta.querySelector('.dnicliente');
    loading = cardCompleta.querySelector('.loadingline-ruc');
    
    callbackData = (name = '') => cardCompleta.querySelector('.razon_social_j').value = name;
    
  }
  else{
    optionSelectedDoc = cardCompleta.querySelector('.dni');
    loading = cardCompleta.querySelector('.loadingline');

    callbackData = (name = '') => cardCompleta.querySelector('.representante').value = name;

  }

  return { optionSelectedDoc, loading, callbackData };
}

function getDNI(obj) {
  let input = obj;
  let cardCompleta = getNthParent(obj, 4);

  let { optionSelectedDoc, loading, callbackData } = elementDniSelected(cardCompleta, obj);

  let isApiTrue = Boolean(parseInt(optionSelectedDoc.options[optionSelectedDoc.options.selectedIndex].getAttribute('data-api')));

  DNI = input.value;


  if (isApiTrue) {

    if (DNI.length == 8) {
      var dni = DNI;
      // $.ajax({
      //             url: 'http://consultas.dsdinformaticos.com/reniec.php?dni=74618292',
      //             type: 'get',
      //             // data: { id },
      //             success: function(data) {
      //               console.log(data)
      //             },
      //             error: function(e) {
      //               console.log(e)
      //             },
      //           });
      $.ajax({
        url: `${ruta}cliente/getDNI`,
        type: 'POST',
        data: { dni },
        dataType: 'json',
        timeout: 30000,
        beforeSend: function () {
          $('div.modaloader').addClass('see');
        },
        success: function (datos_dni) {
          var datos = eval(datos_dni);
          if (datos[3] == "") {
            //input.classList.add('errorAPI');

            callbackData('')

            mensaje("warning", datos.notification);
          }
          else {
            var nombrecompleto = datos[3] + ' ' + datos[1] + ' ' + datos[2];

            callbackData(nombrecompleto)

            //input.classList.remove('errorAPI');
          }

          view.validateDNI();
          $('div.modaloader').removeClass('see');
        },
        error: function (request, status, err) {
          if (status == 'timeout') {
            mensaje('warning', 'El proveedor de los datos SUNAT y RENIEC no estan disponibles, continue registrando los datos de manera manual');
          }
          else {
            mensaje('warning', 'No existe el DNI');
          }
          $('div.modaloader').removeClass('see');
        }
      });

    }
    else {
      //input.classList.add('errorAPI');
      cardCompleta.querySelector('.representante').value = '';
    }
  }
}

function getRUC(obj) {
  let input = obj;
  let cardCompleta = getNthParent(obj, 4);
  let optionSelectedDoc = cardCompleta.querySelector('.ruc');
  let isApiTrue = Boolean(parseInt(optionSelectedDoc.options[optionSelectedDoc.options.selectedIndex].getAttribute('data-api')));
  let loading = cardCompleta.querySelector('.loadingline-ruc');

  RUC = input.value;

  if (isApiTrue == true) {
    if (RUC.length == 11) {
      var formData = new FormData();
      formData.append('RUC', RUC);
      $.ajax({
        url: `${ruta}cliente/getDatosFromAPI_Sunac`,
        type: 'POST',
        data: formData,
        cache: false,
        contentType: false,
        processData: false,
        timeout: 30000,
        beforeSend: function () {
          $('div.modaloader').addClass('see');
        },
        success: function (data) {
          if (data == 'false') {
            // input.classList.add('errorAPI');
            cardCompleta.querySelector('.razon_social_j').value = '';
            cardCompleta.querySelector('.direccion_j').value = '';
            cardCompleta.querySelector('.e_sunat').value = '';
            mensaje("warning", "No Existe el RUC/RUS");
          }
          else {
            // input.classList.remove('errorAPI');
            var obj = $.parseJSON(data);
            // var obj = data;
            var RUC = obj.RUC;
            var RazonSocial = obj.RazonSocial;
            var Direccion = obj.Direccion;
            var Estado_sunat = obj.Estado;
            var tipo_ruc = Math.floor(RUC / 1000000000);
            var nombreRepresentante;
            var tipoDocRepresentante;
            
            if (tipo_ruc === 20) {

              var Dni_rep = '';
              cardCompleta.querySelector('.razon_social_j').value = RazonSocial;
              cardCompleta.querySelector('.direccion_j').value = Direccion;
              cardCompleta.querySelector('.e_sunat').value = Estado_sunat;
              cardCompleta.querySelector('.numdoc').value = Dni_rep;

              if (obj.representantes_legales.length > 0)  {
                if( (obj.representantes_legales[0].tipodoc=="DNI") ){
                  cardCompleta.querySelector('.dni').value = 1;
                }
                cardCompleta.querySelector('.numdoc').value = obj.representantes_legales[0].numdoc;
                cardCompleta.querySelector('.representante').value = obj.representantes_legales[0].nombre;  
              }
              // let dniSelect = cardCompleta.querySelector('.dni');
              // $('option:contains("' + tipoDocRepresentante + '")', dniSelect).prop('selected', true);
              // cardCompleta.querySelector('.numdoc').onblur();
            }
            else {
              // let dniSelect = cardCompleta.querySelector('.dni');
              // $('option:contains("DNI")', dniSelect).prop('selected', true);

              let lengthRuc = RUC.length;
              let docDni = RUC.substring(2, (lengthRuc - 1));

              cardCompleta.querySelector('.razon_social_j').value = RazonSocial;
              cardCompleta.querySelector('#representante_empresa').value = RazonSocial;
              cardCompleta.querySelector('.direccion_j').value = Direccion;
              cardCompleta.querySelector('.e_sunat').value = Estado_sunat;
              cardCompleta.querySelector('#doc_tipo_representante_value').value = docDni;
            }
          }

          getDNI(cardCompleta.querySelector('#doc_tipo_representante_value'));
          view.validateRUC(cardCompleta);
          $('div.modaloader').removeClass('see');
        },
        error: function (request, status, err) {
          if (status == 'timeout') {
            mensaje('warning', 'El proveedor de los datos SUNAT y RENIEC no estan disponibles, continue registrando los datos de manera manual');
          }
          else {
            mensaje('warning', 'Error de petición')
          }
          $('div.modaloader').removeClass('see');
        }
      });
    }
    else {
      // $(input).addClass('errorAPI');
      cardCompleta.querySelector('.razon_social_j').value = '';
      // cardCompleta.querySelector('.direccion_j').value = '';
      // cardCompleta.querySelector('.e_sunat').value = '';
      // cardCompleta.querySelector('.telefono').value = '';
      // cardCompleta.querySelector('.dni').value = '';
    }
    return;
  }
}

function execViewInfo() {
  $('#cards-content input').prop('disabled', true);
  $('#cards-content select').prop('disabled', true);
  $('#cards-content textarea').prop('disabled', true);
  $('#formcliente a').addClass('disabled-ancla');
  $('#btnGuardarAlias').remove();
  $('#addEmpresa').remove();
}

function getNthParent(el, n) {
  return n === 0 ? el : getNthParent(el.parentNode, n - 1);
}

function filterChecked(arr) {
  return Array.from(arr).filter(input => (input.checked == true) ? input : null).map(input => input.value);
}

function parseData() {

  let cardEmpresas = document.querySelectorAll('#contentEmpresas .formempresa');
  let formData = new Object;
  formData.empresas = new Array;

  formData.cliente_alias = {
    alias_id: document.querySelector('#alias_id').value.trim(),
    id_tipodocumento_alias: document.querySelector('#id_tipodocumento_alias').value.trim(),
    numerodocumento_alias: document.querySelector('#numerodocumento_alias').value.trim(),
    alias: document.querySelector('#alias').value.trim(),
    nombre_completo: document.querySelector('#nombre_completo').value.trim(),
    apellido_paterno: document.querySelector('#apellido_paterno').value.trim(),
    apellido_materno: document.querySelector('#apellido_materno').value.trim(),
    correo_alias: document.querySelector('#correo_alias').value.trim(),
    telefono_alias: document.querySelector('#telefono_alias').value.trim(),
    categoria_id_alias: document.querySelector('#categoria_id_alias').value.trim(),
    estado_alias_check: document.querySelector('#estado_alias').checked,
    codigointerno_alias: document.querySelector('#codigointerno_alias').value.trim(),
    codigointerno_check: document.querySelector('#codigointerno_check').checked,
    direccion_alias: document.querySelector('#direccion_alias').value.trim(),
    giro_negocio_alias: document.querySelector('#giro_negocio_alias').value.trim(),
    grupo_alias: document.querySelector('#grupo_alias').value.trim(),
    habilitar_empresa_negocio: document.querySelector('#habilitar_empresa_negocio').checked,
    cliente_id_desde_alias: document.querySelector('#cliente_id_desde_alias').value.trim()
  }

  if(cardEmpresas.length > 0 && document.querySelector('#habilitar_empresa_negocio').checked == true){
    cardEmpresas.forEach((card, i) => {
      let prepareDoc = new Object;

      prepareDoc.id_cliente = card.querySelector('#id_cliente').value.trim();
      prepareDoc.doc_tipo_empresa = card.querySelector('#doc_tipo_empresa').value.trim();
      prepareDoc.doc_tipo_empresa_value = card.querySelector('#doc_tipo_empresa_value').value.trim();
      prepareDoc.razon_social = card.querySelector('#razon_social').value.trim();
      prepareDoc.direccion_empresa = card.querySelector('#direccion_empresa').value.trim();
      prepareDoc.representante_empresa = card.querySelector('#representante_empresa').value.trim();
      prepareDoc.nombre_completo_repr = card.querySelector('#nombre_completo_empresa').value.trim();
      prepareDoc.apellido_paterno_repr = card.querySelector('#apellido_paterno_empresa').value.trim();
      prepareDoc.apellido_materno_repr = card.querySelector('#apellido_materno_empresa').value.trim();
      prepareDoc.doc_tipo_representante = card.querySelector('#doc_tipo_representante').value.trim();
      prepareDoc.doc_tipo_representante_value = card.querySelector('#doc_tipo_representante_value').value.trim();
      prepareDoc.estado_empresa = card.querySelector('#estado_empresa').checked;
      prepareDoc.estado_sunat = (card.querySelector('#estado_sunat').value.trim() == 'ACTIVO') ? true : false;
      prepareDoc.pagina_web = card.querySelector('#pagina_web').value.trim();
      prepareDoc.telefono_empresa = card.querySelector('#telefono_empresa').value.trim();
      prepareDoc.id_tipo = card.querySelector('#giro_negocio').value.trim();
      prepareDoc.grupo = card.querySelector('#grupo').value.trim();
      prepareDoc.ciudad_ubigeo = $(card.querySelector('#ubigeo_id')).val();
      prepareDoc.correo = $(card.querySelector('#correo')).val();
      prepareDoc.disabled_vendedor = $('input[name="vendedor[]"]', card).prop('disabled');

      prepareDoc.maxLength = card.querySelector('.doc-limit').maxLength;

      if (prepareDoc.disabled_vendedor == true) {
        let cardSucursales = card.querySelectorAll('.card-sucursal');
        let sucursales = new Array;

        cardSucursales.forEach((suc, y) => {
          let prepareSuc = new Object;

          prepareSuc.id_sucursal = suc.querySelector('#id_sucursal').value.trim();
          prepareSuc.tipo_suc = suc.querySelector('#tipo_suc').value.trim();
          prepareSuc.direccion_suc = suc.querySelector('#direccion_suc').value.trim();
          prepareSuc.referencia_suc = suc.querySelector('#referencia_suc').value.trim();
          prepareSuc.ubigeo_suc = suc.querySelector('#ubigeo_suc').value.trim();

          if (prepareSuc.disabled_vendedor != true) {
            prepareSuc.vendedores = filterChecked(suc.querySelectorAll('input[name="vendedor_suc[]"]'));
            prepareSuc.zonas = filterChecked(suc.querySelectorAll('input[name="zonas_suc[]"]'));
          }

          sucursales.push(prepareSuc);
        });

        prepareDoc.sucursales = sucursales;
      }
      else {
        prepareDoc.vendedores = filterChecked(card.querySelectorAll('input[name="vendedor[]"]'));
        prepareDoc.zonas = filterChecked(card.querySelectorAll('input[name="zonas[]"]'));
      }

      formData.empresas.push(prepareDoc);
    });
  }

  return formData;
}

function prepareDataValidation() {
  let findDuplicados = { dni: '', rucs: [] }

  let selectDoc = document.getElementById('id_tipodocumento_alias');
  let selectRuc = document.querySelectorAll('#doc_tipo_empresa');
  let ruc = document.querySelectorAll('#doc_tipo_empresa_value');

  let isDNI = selectDoc.options[selectDoc.selectedIndex].text;
  findDuplicados.dni = (isDNI == 'DNI') ? document.querySelector('#numerodocumento_alias').value : null;

  let isRUC = Array.from(selectRuc).map(item => {
    return item.options[item.selectedIndex].text;
  })

  findDuplicados.rucs = isRUC.filter((itemRuc, i) => (itemRuc == 'RUC') ? ruc[i] : null).map((itemRuc, i) => ruc[i].value);

  findDuplicados.nombre = document.getElementById('alias').value.trim();

  if (typeof edit !== "undefined") {
    findDuplicados.edit = edit;
  }
  else {
    findDuplicados.edit = false;
  }

  return JSON.stringify(findDuplicados);
}

 
function soloNumero(texto){

    let numeros="0123456789";

   for(i=0; i<texto.length; i++){
      if (numeros.indexOf(texto.charAt(i),0) == -1){
         return true;
      }
   }
   return false;
}
/*  Form actions  */

var view = {
  index() {
    let url = `${ruta}clientesopcion`;
    view.requestView(url);
  },
  create() {
    let url = `${ruta}clientesopcion/form_cliente`;
    view.requestView(url);
  },
  edit(id) {
    let url = `${ruta}clientesopcion/form_cliente/${id}`;
    view.requestView(url);
  },
  info(id) {
    let url = `${ruta}clientesopcion/form_cliente/${id}/info`;
    view.requestView(url);
  },
  confirmDelete(id) {
    document.querySelector('#confirm_text').innerHTML = '¿Estás seguro de que deseas eliminar este cliente?';
    document.querySelector('#confirm_button').setAttribute('onclick', `view.delete("${id}")`);
    $('#dialog_confirm').modal('show');
  },
  save(event) {
    event.preventDefault();

    let cliente = document.getElementById('alias').value;
    let dataToSave = parseData();
    let validation = false;

    for (var i = 0; i < dataToSave.empresas.length; i++) {
      let empresa = dataToSave.empresas[i];
      validation = (empresa["doc_tipo_empresa_value"] == "" && empresa["razon_social"] == "" &&  empresa["direccion_empresa"] == "");
        
      validationCharacters = empresa["maxLength"] == empresa["doc_tipo_empresa_value"].length;
      if( !validationCharacters ){
        mensaje('warning', 'El documento debe tener '+empresa["maxLength"]+' caracteres de longitud.');
        return;
      }
    }


    if(dataToSave.empresas[0].doc_tipo_empresa_value != ''){

      if (soloNumero(dataToSave.empresas[0].doc_tipo_empresa_value) && 
        ($('#doc_tipo_empresa option:selected').text().trim() == 'DNI' || $('#doc_tipo_empresa option:selected').text().trim() == 'RUC')) {

        mensaje('warning', 'La identificacion debe contener solo números');
        return;
      }

    }

    // if(dataToSave.empresas.length == 0){
    //   mensaje('warning', 'Debe agregar al menos una empresa');
    //   return; 
    // }

    if (validation && dataToSave.empresas[0].doc_tipo_empresa == 3){
      mensaje('warning', 'Debe completar al menos los campos: RUC, Razón Social y Dirección');
      return; 
    }

    let data = prepareDataValidation();

    $.ajax({
      url: `${ruta}clientesopcion/validateBeforeSave`,
      type: 'post',
      dataType: 'json',
      data: { data },
      success(resp) {
        if (resp.status == true) {
          mensaje('warning', resp.msg)
        }
        else {
          let url = `${ruta}clientesopcion/guardar`;
          let formData = JSON.stringify(parseData());
          view.requestAction(url, formData);
        }
      }
    })

  },
  delete(id) {
    let url = `${ruta}clientesopcion/eliminar/${id}`;
    view.requestAction(url);
  },
  validateDNI() {
    let selectDoc = document.getElementById('id_tipodocumento_alias');
    let isDNI = selectDoc.options[selectDoc.selectedIndex].text;
    let find_edit;

    if (typeof edit !== "undefined") {
      find_edit = edit;
    }
    else {
      find_edit = 0;
    }

    let dni = (isDNI == 'DNI') ? document.querySelector('#numerodocumento_alias').value : null;
    $.ajax({
      url: `${ruta}clientesopcion/validateForm`,
      data: { dni, find_edit },
      type: 'post',
      success(resp) {
        if (resp.status == false) {
          mensaje('warning', resp.msg);
          document.querySelector('#numerodocumento_alias').classList.add('errorAPI');
          document.querySelector('#numerodocumento_alias').value = '';
          document.querySelector('#alias').value = '';
        }
      }

    })

  },
  validateRUC(cardCompleta) {
    let ruc = cardCompleta.querySelector('#doc_tipo_empresa_value').value;
    let find_edit;

    if (typeof edit !== "undefined") {
      find_edit = edit;
    }
    else {
      find_edit = 0;
    }

    $.ajax({
      url: `${ruta}clientesopcion/validateForm`,
      data: { ruc, find_edit },
      type: 'post',
      async: false,
      success(resp) {
        if (resp.status == false) {
          mensaje('warning', resp.msg);
          // cardCompleta.querySelector('#doc_tipo_empresa_value').classList.add('errorAPI');
          cardCompleta.querySelector('#doc_tipo_empresa_value').value = '';
          cardCompleta.querySelector('.razon_social_j').value = '';
          cardCompleta.querySelector('.direccion_j').value = '';
          cardCompleta.querySelector('.e_sunat').value = '';
          cardCompleta.querySelector('.telefono').value = '';
          cardCompleta.querySelector('.dni').value = '';
          cardCompleta.querySelector('#doc_tipo_representante_value').value = '';
          cardCompleta.querySelector('#representante_empresa').value = '';
        }
      }
    })
  },
  requestView(url) {
    $('#barloadermodal').modal('show');
    $.ajax({
      url: url,
      type: 'POST',
      success: function (data) {
        $('#page-content').html(data);
        $('#barloadermodal').modal('hide');
        $(".modal-backdrop").remove();
      },
      error: function () {
        alert('Error inesperado');
      },
    });
  },
  requestAction(url, dataParam) {
    $.ajax({
      url: url,
      data: { data: dataParam },
      type: 'post',
      success: function (resp) {
        if (resp.status == true) {
          mensaje('success', resp.msg)
          view.index();
        }
        else {
          mensaje('danger', resp.msg)
        $('#dialog_confirm').modal('hide');
        }
      }
    })
  }
}

function setDatosPersona(tipo_doc, datos_pers) {
    if (tipo_doc == 'dni') {
        let nombrecompleto = datos_pers.nombre + ' ' + datos_pers.paterno + ' ' + datos_pers.materno;
        $('#identificacion').removeAttr('pattern');
        $("#razon_social").val(nombrecompleto)
    } else if (tipo_doc == 'ruc') {
        $("#razon_social").val(datos_pers.RazonSocial)
        $("#direccion_empresa").val(datos_pers.Direccion)
        $('#estado_sunat').val(datos_pers.Estado)
    }

    $('div.modaloader').removeClass('see');
}


function setDatosPersonaRepresentante(tipo_doc, datos_pers) {
    if (tipo_doc == 'dni') {
        let nombrecompleto = datos_pers.nombre + ' ' + datos_pers.paterno + ' ' + datos_pers.materno;

        $('#identificacion_representante').removeAttr('pattern');

        $("#representante_empresa").val(nombrecompleto)
    } else if (tipo_doc == 'ruc') {
        $("#representante_empresa").val(datos_pers.RazonSocial)
    }

    $('div.modaloader').removeClass('see');
}



function errorPetition(tipo_doc, response) {
    $('div.modaloader').removeClass('see');
    if (tipo_doc == 'dni') {
        $("#razon_social").val('')
        mensaje("warning", response.notification);
    } else if (tipo_doc == 'ruc') {
        mensaje('warning', 'Verifique que el RUC este escrito correctamente');
    }
}

$( document ).ready(function() {
    var tipodoc = new DocumentoPersona({
      tipo_doc_element: $('#doc_tipo_empresa'),
      nro_doc_element: $("#doc_tipo_empresa_value"),
      success_function: setDatosPersona,
      error_function: errorPetition,
      elemento_tipo_doc: "select",
      attr_data_api: "data-api",
  });

  var tipodoc2 = new DocumentoPersona({
    tipo_doc_element: $('#doc_tipo_representante'),
    nro_doc_element: $("#doc_tipo_representante_value"),
    success_function: setDatosPersonaRepresentante,
    error_function: errorPetition,
    elemento_tipo_doc: "select",
    attr_data_api: "data-api",
  });

});

$('#doc_tipo_empresa').change(function() {
    if ($(this).val() == 3) {
        $('.show-when-ruc').fadeIn(500);
    } else {
        $('.show-when-ruc').fadeOut(500);
    }
})
