  //CONFIGURACIONES INICIALES
  App.sidebar('close-sidebar');   


var view = {
  create() {
    let url = `${ruta}clientes_tipo/form_tipo`;
    view.requestView(url);
  },
  edit(id){
    let url = `${ruta}clientes_tipo/form_tipo/${id}`;
    view.requestView(url);
  },
  info(id){
    let url = `${ruta}clientes_tipo/form_tipo/${id}`;
    view.requestView(url);
    setTimeout(function(){view.info_disabled();},100);

  },
  delete(id){
    let url = `${ruta}clientes_tipo/eliminar/${id}`;
    view.requestAction(url);
  },
  confirm(id){
    $("#dialog_confirm").modal('show');
    document.querySelector('#dialog_confirm #confirm_button').setAttribute('onclick',`view.delete(${id})`);
  },
  requestView(url){
    $('#barloadermodal').modal('show');
    $.ajax({
      url: url,
      type: 'POST',
      success: function(data) {
            $('#barloadermodal').modal('hide');
            $('#dialog_cotizar_traspasos').html('');
            $('#dialog_cotizar_traspasos').modal('show');
            $('#dialog_cotizar_traspasos').html(data);
      },
      error: function() {
        alert('Error inesperado');
      },
    });
  },
  requestAction(url, dataParam){
    $.ajax({
      url: url,
      data: { data: dataParam },
      type: 'post',
      success: function(resp){
        if(resp.status == true){
          mensaje('success', resp.msg)
          view.reset_view_crud();
        }
        else{
          mensaje('error', resp.msg)
        }
      }
    })
  },
  reset_view_crud(){
    /// all modall confimr clear
     $('#barloadermodal').modal('show');
     $("#dialog_confirm").modal('hide');
     $("#dialog_cotizar_traspasos").modal('hide');
     $("#dialog_cotizar_traspasos").html('');
     ///////////////////////////////////
     $('#page-content').html('');
     let url = `${ruta}clientes_tipo`;
     $.ajax({
        url: url,
        type: 'POST',
        success: function(data) {
          $('#barloadermodal').modal('hide');
          $(".modal-backdrop").remove();
          $('#page-content').html(data);
        },
        error: function() {
          alert('Error inesperado');
        },
      });
  },
  info_disabled(){
    var array_element = document.querySelectorAll('#formagregar input');
    document.querySelector('#btn_confirmar').disabled=true;
    Array.from(array_element).map(elem => {
      elem.disabled = true;
     })

  }

}

