var CurrentVideo = {};

$('#accordian').on('click', 'a.module', function(){

    var link = $(this);
    var closest_ul = link.closest("ul");
    var parallel_active_links = closest_ul.find(".active")
    var closest_li = link.closest("li");
    var folderOpen = closest_li.find('.folder');
    var link_status = closest_li.hasClass("active");
    var count = 0;

    $('#accordian .folder').removeClass("fa-folder-open folder-active");
    $('#accordian .folder').addClass('fa-folder');

    closest_ul.find("ul").slideUp(function() {
            if (++count == closest_ul.find("ul").length){ 
                    parallel_active_links.removeClass("active");
            }
    });

    if (!link_status) {
            closest_li.children("ul").slideDown();
            closest_li.addClass("active");
            folderOpen.addClass("fa-folder-open folder-active");
    }
})

$('#accordian').on('click', 'a.submenu', function(){
    
    let ancla = $(this);
    let id = ancla.find('.submenu-id').val();

    $('#accordian a.submenu').removeClass('item-video-activate');
    ancla.addClass('item-video-activate');
    
    $.ajax({
        url: `${ruta}aprendizaje/getVideo`,
        data: { id },
        type: 'POST',
        dataType: 'json',
        success(data){
          CurrentVideo = data.video;
          hideNextOrPrev();
          document.querySelector('#documentacion-link').href = data.video.linkDocumento;
          document.querySelector('#titulo-video').innerHTML = `${data.opcionNombre.toUpperCase()}: ${data.video.opcionNombre}`;
          document.querySelector('#descripcion-video').innerHTML = data.video.descripcionOpcion;
          document.querySelector('iframe').src = data.video.linkVideo;
        },
        error(){
            alert("Error interno");
        }
    })
})

$('#prev').click(function(){
    nextOrPrev('previousElementSibling');
})

$('#next').click(function(){
    nextOrPrev('nextElementSibling');
})

$('#search').on('keypress', function(event){
    let tecla = event.keyCode;
    if(tecla == 13){
      searchModule()
    } 
})

$('#btn-search').click(function(){
    searchModule()
})

$('#comenzar').click(function(){
    let firstVideo = document.querySelector('a.submenu');
    let firstModule = document.querySelector('a.module');

    if(firstVideo == null && firstModule == null) return;
    if(firstModule != null){
        firstModule.click();
    }
    if(firstVideo != null){
        firstVideo.click();
    }

    $('.bienvenida').hide();
    $('.iframe').show();
    $('.aside-right').show();
    $('.controls').show();
})

function nextOrPrev(sibling){
    let currentLi = document.querySelector(`.item-video .submenu-id[value="${CurrentVideo.id}"]`);

    if(currentLi == null){
        return;
    }

    let liVideo = currentLi.parentNode.parentNode.parentNode;
    let direction = liVideo[sibling];

    if(direction == null){
        return;
    }

    direction.querySelector('a.submenu').click()
}

function hideNextOrPrev(){
    let currentLi = document.querySelector(`.item-video .submenu-id[value="${CurrentVideo.id}"]`);
    let liVideo = currentLi.parentNode.parentNode.parentNode;
    let directionPrev = liVideo.previousElementSibling;
    let directionNext = liVideo.nextElementSibling;

    if(directionPrev == null && directionNext == null){
        $('.controls #next').hide();
        $('.controls #prev').hide();
        return;
    }

    if(directionPrev == null){
        $('.controls #next').show();
        $('.controls #prev').hide();
        return;
    }

    if(directionNext == null){
        $('.controls #next').hide();
        $('.controls #prev').show();
        return;
    }

}

function searchModule(){
   let search = document.getElementById('search').value;

   $.ajax({
      url: `${ruta}aprendizaje/filterModules`,
      data: { search },
      type: 'POST',
      dataType: 'json',
      success(data){
        generateAccordion(data);
      },
      error(){
        alert("Error interno");
      }
   })
}

function generateAccordion(data){
    let accordian = document.getElementById('accordian');
        accordian.innerHTML = '';

    let ulParent = document.createElement('ul');

    if(data.length == undefined){
        let ul = document.createElement('ul');
        let li = document.createElement('li');
            li.className = 'item-video';
            ul.style.display = 'block';

        ul.innerHTML = itemVideo(data);
        li.appendChild(ul);
        ulParent.appendChild(li);
        accordian.appendChild(ulParent);
        return;
    }

    if(data.length == 0){
        let li = document.createElement('li');
        let span = document.createElement('span');

        span.textContent = 'No hay modulos en este criterio de busqueda';
        span.style = 'font-size: 12px;'
        li.style = 'text-align: center;'

        li.appendChild(span);
        ulParent.appendChild(li);
        accordian.appendChild(ulParent);
        return;
    }

    data.forEach(item => {
        let li = document.createElement('li');
        let ul = document.createElement('ul');
        let label = document.createElement('label');
        let ancla = document.createElement('a');
        let icon = document.createElement('i');
        let span = document.createElement('span');

        ancla.href = 'javascript:void(0)';
        ancla.className = 'module';
        icon.className = 'folder fa fa-lg fa-folder';
        li.className = 'item-video';
        span.textContent = item.opcionNombre;

        ancla.appendChild(icon);
        ancla.appendChild(span);
        label.appendChild(ancla);
        li.appendChild(label);

        item.videos.forEach(video => {
            ul.innerHTML += itemVideo(video);
        })

        li.appendChild(ul);
        ulParent.appendChild(li);
    })
    
    accordian.appendChild(ulParent);
}

function itemVideo(video){
    return `<li>
              <a href="javascript:void(0)" class="submenu">
               <div class="guia_name">
                  <i class="fa fa-play-circle icon-blue"></i>
                  <span>${video.opcionNombre}</span>
                  <input hidden class="submenu-id" value="${video.id}">
               </div>
               <div class="duration">
                 <span class="clock">${video.tiempoVideo}<i class="fa fa-clock-o"></i></span>
               </div>
              </a>
             </li>
            `
}