/*$(".buscar_ruc").on("click",function(){
   delegateRUC({target:$(this).parent().parent().find("#doc_tipo_empresa_value")[0]});
});
$('body table.formempresa input#doc_tipo_empresa_value').unbind("keyup", delegateRUC);*/

function isEmail(e) {
  var email = $(e.target).val();
  var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
  console.log(email);
  if( regex.test(email) ){
  	$(e.target).removaClass("invalido");
  }else{
  	$(e.target).addClass("invalido");
  }
}
$("#correo").bind("keyup",isEmail);