$(document).ready(function () {
	$('#cargando_modal').modal('hide');
	TablesDatatables.init(0);

	$("#cerrar_pago_modal").on('click', function (){
	    $("#pago_modal").modal('hide');
	});
});

function imprimir(id, local_origen, id_status){
    $.bootstrapGrowl('<p>IMPRIMIENDO TRASPASO</p>', {
        type: 'success',
        delay: 2500,
        allow_dismiss: true
    });

    $("#imprimir_frame").attr('src', url + 'traspaso/imprimir/' + id + '/' + local_origen + '/' + id_status);
}

function ver(id, id_status, status){
    $("#verModal").html($("#loading").html());
    $("#verModal").load(url + 'traspaso/verDetalle/'+id+'/'+id_status+'/'+status);
    $('#verModal').modal('show');
}

function cambiarestado(id, status, local){
    id_origen = $("#locales").val();
    origen = $("#locales option:selected").text().replace(/ /g,'');
    $("#verModal").html($("#loading").html());
    $("#verModal").load(url + 'traspaso/cambiarEstado/'+id+'/'+status+'/'+local+'/'+id_origen+'/'+origen);
    $('#verModal').modal('show');
}

function guia_remision_modal(id, tipo){
  $('#dialog_cotizar_traspasos').html('');
  $('#dialog_cotizar_traspasos').modal('show');
  $('#dialog_cotizar_traspasos').html($('#loading').html());

  $.ajax({
    url: ruta + 'guia_remision/get_cotizar_remision_validar/',
    type: 'POST',
    data: { id, tipo},

    success: function(data) {
      $('#dialog_cotizar_traspasos').html(data);
    },
    error: function() {
      alert('Error inesperado');
    },
  });
  
}

