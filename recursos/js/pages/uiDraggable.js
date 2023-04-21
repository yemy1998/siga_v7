/*
 *  Document   : uiDraggable.js
 *  Author     : pixelcave
 *  Description: Custom javascript code used in Draggable Blocks page
 */

var UiDraggable = function () {

  return {
    init: function () {
      /* Initialize draggable and sortable blocks, check out more examples at https://jqueryui.com/sortable/ */
      $('.draggable-blocks').sortable({
        connectWith: '.block',
        items: '.block',
        opacity: 0.75,
        handle: '.block-title',
        placeholder: 'draggable-placeholder',
        tolerance: 'pointer',
        start: function (e, ui) {
          ui.placeholder.css('height', ui.item.outerHeight());
        }
      });

      $('.draggable-tbody').sortable({
        tolerance: 'pointer',
        start: function (e, ui) {
          ui.placeholder.css('height', ui.item.outerHeight());
        },
        // handle: '.fa-arrows-v',
        update: function (event, ui) {
          var count = 0;
          $("tr[id^='trunidad']").each(function () {
            $(this).attr('id', 'trunidad' + count);

            $("#trunidad" + count + " select[name^='medida']").attr('name', 'medida[' + count + ']');
            $("#trunidad" + count + " select[name^='medida']").attr('id', 'medida' + count + '');

            $("#trunidad" + count + " input[name^='unidad']").attr('name', 'unidad[' + count + ']');
            $("#trunidad" + count + " input[name^='unidad']").attr('id', 'unidad[' + count + ']');
            $("#trunidad" + count + " input[name^='unidad']").attr('data-row', count);

            var countprecio = 0;
            $("#trunidad" + count + " input.input-soles").each(function (a, e) {
              var id_precios = $(this).attr('data-nombre_precio')
              $(this).attr('id', id_precios + count);
              $(this).attr('name', 'precio_valor_[' + count + '][' + countprecio + ']');
              countprecio++;
            });

            countprecio = 0;
            $("#trunidad" + count + " input.input-dolar").each(function (a, e) {
              var id_precios = $(this).attr('data-nombre_precio')
              $(this).attr('id', id_precios + count);
              $(this).attr('name', 'precio_valor_dolar[' + count + '][' + countprecio + ']');
              countprecio++;
            });

            $(this).find(".input-flex").each(function (a, e) {
              $(e).find('input.precio_id').attr('name', 'precio_id_[' + count + '][' + a + ']');
              $(e).find('input.precio_id_dolar').attr('name', 'precio_id_dolar[' + count + '][' + a + ']');
            });

            $("#trunidad" + count + " input").attr('data-row', count);
            $("#trunidad" + count + " a[id^='eliminar']").attr('id', 'eliminar' + count);
            $("#trunidad" + count + " a[id^='eliminar']").attr('onclick', 'eliminarunidad(' + count + ')');

            count++;
          })
        }
      });
    }
  };
}();