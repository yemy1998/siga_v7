
let ImageUpload = {
    imagen : null,
    fileOnload : (e) => {
        var result = e.target.result;
        ImageUpload.imagen.setAttribute("src", result);
    },
    asignarImagen : (input,imagen) => {
        if (input.files[0] && input.files[0]) {
            ImageUpload.imagen = imagen;
            var reader = new FileReader();
            reader.onload = ImageUpload.fileOnload;
            reader.readAsDataURL(input.files[0]);


        }
    }
}


let wrappersImg = {};
let inputsFile  = {}


$(document).ready(function () {

    inputFile = document.querySelector(`input[type="file"]`);

});

/**
 * Colocar los eventos de la libreria y/o activar dichos eventos
 *
 */
function triggerFotoUploadEvent(){

    wrappersImg = document.querySelectorAll("div[wrapper-img]");

    for(let wrapperImg of wrappersImg){

        wrapperImg.querySelector("#closeX").addEventListener("click", () => {

          aniadir_img_to_delete(wrapperImg.querySelector(".img-negocio"), wrapperImg.querySelector("input[type=file]"))

          wrapperImg.querySelector(".img-negocio").removeAttribute("src");
          wrapperImg.querySelector(`.file-image`).classList.add("hidden");
          wrapperImg.querySelector(`.file-upload`).classList.remove("hidden");

        })

        wrapperImg.querySelector(`input[type=file]`).addEventListener("change", function () {

          let input = this;
          let curFiles = input.files;
          let imgSrc   = wrapperImg.querySelector(".img-negocio").getAttribute("src");

          if( (!curFiles || curFiles.length === 0) && (imgSrc==undefined || imgSrc=="") ) {

                wrapperImg.querySelector("#closeX").click();

          } else {

              wrapperImg.querySelector(`.file-image`).classList.remove("hidden");
              wrapperImg.querySelector(`.file-upload`).classList.add("hidden");
              ImageUpload.imagen = null;
              ImageUpload.asignarImagen(input,wrapperImg.querySelector(".img-negocio"));
          }

        })


        let image_deletions_list = $("#image_deletions_list");

        function aniadir_img_to_delete(imagen, input){

            let string_list = image_deletions_list.val()
            let img_list = string_list.length > 0 ? JSON.parse(image_deletions_list.val()) : [];
            img_list.push(input.getAttribute("img_serve_src"))
            image_deletions_list.val(JSON.stringify(img_list));
            input.removeAttribute("img_serve_src");
        }

        let event = new Event('change')
        wrapperImg.querySelector("input[type=file]").dispatchEvent(event)

    }
}

/**
 * Coloca las rutas de las imagenes en eqtiquetas img y el img_serve_src el cual es usado para cuando se elimine una imagen
 *
 * @param JSON data contiene los nombres de los campos en base datos los cuales deben coincidir con sus id en las etiquetas html.
 * 
 */
function setImgView(data) {
  
  let imgName = inputFile.id

  if (data[inputFile.id] != null) {

    let content = `content${imgName}`

    document.querySelector(`#${content} #img-principal`).setAttribute("src", data[`fullLink${imgName}`]);
    document.querySelector(`#${content} #${imgName}`).setAttribute("img_serve_src", data[imgName]); 

  }

  
  triggerFotoUploadEvent(wrappersImg)

}



function getImgToUpload(data) {

  let toUpload = {};
  let imgName  = inputFile.id
  let urlImg   = document.querySelector(`#${imgName}`).getAttribute("img_serve_src");

  toUpload = {name: imgName, urlImg: urlImg};

  return toUpload;

}



function getNameInputToUpload(toJsonStringify = true) {

  let imgName = inputFile.id
  return imgName;

}


function getImagesToDelete(){
    let string_list_delete_img = $("#image_deletions_list").val()
    if( string_list_delete_img.length> 0 ){
        return JSON.parse($("#image_deletions_list").val());
    }else{
        return [];
    }
}
