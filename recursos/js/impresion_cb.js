var ruta = $('#base_url').val();
var products = [];

$(document).ready(function () {

  // Initial configuration
  $('.chosen').chosen({
    width: '100%',
    search_contains: true,
  });

  $("#charm").tcharm({
    'position': 'right',
    'display': false,
    'top': '50px'
  });

  $('#producto_complete').autocomplete({
    autoFocus: true,
    source: function (request, response) {

      $.ajax({
        url: ruta + 'producto/get_productos_json_impresion',
        dataType: 'json',
        data: {
          term: request.term,
        },
        success: function (data) {
          response(data);
        },
      });
    },
    minLength: 2,
    response: function (event, ui) {
      if (ui.content.length == 1) {
        // select one
      }
    },
    select: function (event, ui) {
      if (!getProduct(ui.item.id)) {
        addProduct({
          id: ui.item.id,
          name: ui.item.name,
          description: ui.item.description,
          cb: ui.item.codigo_barra,
          price_default: Number.isNaN(parseFloat(ui.item.precio)) ? 0 : parseFloat(ui.item.precio),
          price_dolar: Number.isNaN(parseFloat(ui.item.precio_dolar)) ? 0 : parseFloat(ui.item.precio_dolar),
          um: 'UND',
          tickets: 1,
        });
      }

    },
    close: function (e, ui) {
      $('#producto_complete').val('');
    },
  }).autocomplete('instance')._renderItem = function (ul, item) {
    return $('<li>').
      append('<div>' + item.label +
        '<br><span style=\'color: #888; font-size: 10px;\'>' + item.desc +
        '</span></div>').
      appendTo(ul);
  };


  // Events handlers
  $('.btn_buscar').on('click', function () {
    filterProducts();
  });

  $('#print_all').on('click', function () {
    printTicket(false);
  });

  $('#tickets_from_stock').on('click', function (e) {
    e.preventDefault();
    getStock();
  });

  $('#moneda').on('change', function () {
    renderProduct();
  });

});

// Functions
function getProduct(id) {
  return products.find(item => item.id == id);
}

function addProduct(product) {
  products.push(product);
  renderProduct();
}

function updateProductTickets(id, tickets) {
  products = products.map((item) => {
    if (item.id == id && !Number.isNaN(tickets)) {
      var p = {
        ...item,
        tickets,
      };
      return p;
    }

    return item;
  });
  renderProduct();
}

function removeProduct(id) {
  products = products.filter((item) => item.id != id);
  renderProduct();
}

function handleInputChange(input, productId) {
  var tickets = parseInt($(input).val(), 10);
  updateProductTickets(productId, tickets);
}


function printTicket(id) {
  if (products.length > 0) {

    var data = [];
    if (id) {
      data = products.filter((item) => item.id == id && parseInt(item.tickets) > 0).map((item) => ({
        id: item.id,
        tickets: item.tickets,
        moneda: $('#moneda').val(),
      }));
    } else {
      data = products
        .filter((item) => parseInt(item.tickets) > 0)
        .map((item) => ({
          id: item.id,
          tickets: item.tickets,
          moneda: $('#moneda').val(),
        }));
    }

    if (data.length > 0) {
      window.open(ruta + 'producto/imprimir_cb?data=' + JSON.stringify(data));
    }
  }
}

function computePrice(price_default, price_dolar) {
  if ($('#moneda').val() == 1029) {
    return `${$('#moneda option:selected').attr('data-simbolo')} ${price_default.toFixed(2)}`;
  } else {
    return `${$('#moneda option:selected').attr('data-simbolo')} ${price_dolar.toFixed(2)}`;
  }
}

function filterProducts() {
  $('#charm').tcharm('hide');

  var query = {
    'marca_id': $('#marca_id').val(),
    'grupo_id': $('#grupo_id').val(),
    'familia_id': $('#familia_id').val(),
    'linea_id': $('#linea_id').val(),
    'proveedor_id': $('#proveedor_id').val(),
  };

  if (query.marca_id == 0 && query.grupo_id == 0 && query.familia_id == 0 && query.linea_id == 0 && query.proveedor_id == 0) {
    show_msg('warning', 'Debe seleccionar al menos un filtro');
    return false;
  }

  $('#barloadermodal').modal('show');
  $.ajax({
    url: ruta + 'producto/get_productos_impresion',
    data: query,
    success: function (data) {
      var result = data.result;
      if (result.length > 0) {
        Object.keys(result).forEach((key) => {
          if (!getProduct(result[key].id)) {
            addProduct({
              id: result[key].id,
              name: result[key].producto_nombre,
              description: result[key].producto_descripcion,
              cb: result[key].barra,
              price_default: Number.isNaN(parseFloat(result[key].precio)) ? 0 : parseFloat(result[key].precio),
              price_dolar: Number.isNaN(parseFloat(result[key].precio_dolar)) ? 0 : parseFloat(result[key].precio_dolar),
              um: 'UND',
              tickets: 1,
            });
          }
        });
      }
    },
    error: function (err) {
      console.log(err);
    },
    complete: function () {
      $('#barloadermodal').modal('hide');
    }
  });
}

function getStock() {
  $('#barloadermodal').modal('show');

  var query = {
    ids: products.map((item) => item.id).join(','),
    local_id: $('#local').val(),
  };
  $.ajax({
    url: ruta + 'producto/get_stock_impresion',
    data: query,
    success: function (data) {
      var stock = data.stock;
      if (stock) {
        Object.keys(stock).forEach(function (key) {
          var tickets = parseInt(stock[key].cantidad_min, 10);
          updateProductTickets(stock[key].id_producto, tickets > 0 ? tickets : 0);
        });
      }
    },
    error: function (err) {
      console.log(err);
    },
    complete: function () {
      $('#barloadermodal').modal('hide');
    }
  })
}

function renderProduct() {
  var tbody = $('#tbody_content');

  // delete the missing products
  (tbody.find('tr') || []).each(function (index, item) {
    if (!getProduct($(item).attr('data-key'))) {
      item.remove();
    }
  });

  Object.keys(products).forEach(function (key) {
    var product = products[key];

    var tr = tbody.find(`tr[data-key="${product.id}"]`);
    if (tr.length == 0) {
      // add a new tr
      tr = `
      <tr id="${product.id}" data-key="${product.id}">
        <td>${product.id}</td>
        <td>${product.cb}</td>
        <td>${product.name}</td>
        <td>${product.description}</td>
        <td>${computePrice(product.price_default, product.price_dolar)}</td>
        <td>${product.um}</td>
        <td style="width: 50px;">
          <input 
          class="form-control" 
          oninput="handleInputChange(this, ${product.id})" 
          onfocus="$(this).select();"
          value="${product.tickets}" 
          />
        </td>
        <td class="text-right">
          <div class="btn-group">
            <a href="#" class="btn btn-default" onclick="printTicket(${product.id})" style="margin-right: 15px;">
              <i class="fa fa-print"></i>
            </a>
            <a href="#" class="btn btn-danger" onclick="removeProduct(${product.id})">
              <i class="fa fa-trash"></i>
            </a>
          </div>
        </td>
      </tr>`;

      tbody.append(tr);
    } else {
      // update the reactive fields
      tr = tr.first();

      // update the tickets
      var inputTicket = tr.find('td:nth-child(7) > input').first();
      if (inputTicket.val() != product.tickets) {
        inputTicket.val(product.tickets);
      }

      // update the currency
      var tdPrice = tr.find('td:nth-child(5)').first();
      if (computePrice(product.price_default, product.price_dolar) != tdPrice.html()) {
        tdPrice.html(computePrice(product.price_default, product.price_dolar));
      }
    }
  });
}