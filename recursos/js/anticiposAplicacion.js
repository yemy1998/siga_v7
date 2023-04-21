let parametrosAnticipos = {}
let validacionCredito = false;

function setAnticipos({id_actor,localId,naturalezaActor,selectorSimboloMoneda,selectorTotalPagar,idMoneda,tipo_pago}){
        /*"id_actor es la id del cliente/proveedor"*/

        let tipoPago = document.querySelector(`${tipo_pago}`)
        let bodyTable = document.querySelector("#tableAnticiposBody");
        let totalPagar = document.querySelector(selectorTotalPagar).value;

        parametrosAnticipos = {
            "id_actor": id_actor,
            "localId": localId,
            "naturalezaActor": naturalezaActor,
            "selectorSimboloMoneda": selectorSimboloMoneda,
            "selectorTotalPagar": selectorTotalPagar,
            "idMoneda": idMoneda,
            "tipoPago": tipoPago,
            "totalPagar": totalPagar,
            "importe": totalPagar,
            "selectorTotalPagar": selectorTotalPagar,
        }


        if (validacionCredito) {

            parametrosAnticipos.importe    = validacionCredito;
            parametrosAnticipos.totalPagar = validacionCredito;

        }


        $.ajax({
                url: `${ruta}anticipos/getAnticipos/${id_actor}/${localId}/${naturalezaActor}/${idMoneda}`,
                type: 'POST',
                dataType:'JSON',
                success: function(data) {

                    let contenedor = document.querySelector("#contentTablaAnticipos");
                    if (data != null) {


                        contenedor.style.display = 'block'

                        let responseDrawTable = drawTableAnticipos(data,"#tableAnticiposBody");

                        if(responseDrawTable.status === true){

                          setSelectionAnticipos(parametrosAnticipos.importe);
                          caclTotalImpoteAnticipo(parametrosAnticipos.importe);

                        }


                    }else {

                        contenedor.style.display = 'none';
                    }
                
                },
                error: function() {
                  console.error("Fallo al obtner anticipos")
                },
            });
    }

function drawTableAnticipos(data,id_bodyTable){

        
        let bodyTable = document.querySelector(`${id_bodyTable}`);
        let tr = "";
        let simboloMoneda = document.querySelector(parametrosAnticipos.selectorSimboloMoneda).innerText;
        let montosAnticipos = "0.00";
        let idAnticiposValidados = []
        let checkedInput = "";

        /*onclick del boton editar_importeAnticipo | reservado para una function futura onclick="editInputImporteAncicipo(event,'anticipo_${elemen.id}')"*/
      
        idAnticiposValidados = validacionAnticposMontos(data,parametrosAnticipos.totalPagar);

        data.forEach((elemen) => {

            idAnticiposValidados.forEach((anticipoValidado) => {

                if (anticipoValidado.idAnticipos == elemen.id) {

                    montosAnticipos = anticipoValidado.monto 

                    if(anticipoValidado.monto != "0.00"){

                        checkedInput = 'checked="true"'
                    }
                }
                
            })

            tr += `<tr id="anticipo_${elemen.id}">
                    <td align="center">${elemen.created_at}</td>
                    <td align="center">${elemen.saldoAnticipo}</td>
                    <td align="center">
                        <div class="input-group">
                            <div class="input-group-addon tipo_moneda" style="padding: 0px; min-width: 25px;">
                                ${simboloMoneda}
                            </div>
                            <input type="text" style="text-align: center;" class='form-control' data-index="0" name="importeAnticipo" id="importeAnticipo" data-idAnticipo="${elemen.id}" value="${parseFloat(montosAnticipos).toFixed(2)}" onkeydown="return soloDecimal4(this, event);" readonly>
                            <a id="editar_importeAnticipo" 
                             onclick="editInputImporteAncicipo(event,'anticipo_${elemen.id}','${parametrosAnticipos.importe}')"
                             data-estado="0" 
                             href="javascript:void(0)" 
                             class="input-group-addon" 
                             style="padding: 0px; min-width: 25px;"><i class="fa fa-edit"></i></a>
                        </div>
                    </td>

                    <td align="center">
                        <div>
                            <div class="d-flex align-items-center justify-content-center">
                                <label id="anticipoSelect" style="float: right; margin-bottom: 5px;" class="contenedor-check mt-10">
                                    <input type="checkbox" class="BOTONES_VENTA" ${checkedInput}>
                                    <span class="checkmark" style="top: -11; left: 9px;"></span>
                                </label>
                            </div>
                        </div>
                    </td>

                  </tr>`

            montosAnticipos = "0.00"
            checkedInput = "";
        });

        
        bodyTable.innerHTML = tr;

        if (tr != "") {
            
            return {'status':true};
        }else {

            return {'status': false};
        }

}


function validacionAnticposMontos(anticipos,totalPagarString){
    /*Aquí se valida si un anticipo es igual al monto a pagar o si la suma de anticipos es mayor al monto a pagar o si la suma de anticipos es menor al monto a pagar*/
    sumaAnticiposMayorVenta = false;
    let input = "";
    let anticiposValidate = [];
    let totalAnticipos = 0.00;
    let totalPagar =  parseFloat(totalPagarString);
    let sumaAnticipos = 0.00;
    let diferencia = 0.00;


    /*Chequeamos el total de la suma de anticipos disponibles*/
    anticipos.forEach((anticipo) => {

        totalAnticipos = totalAnticipos + parseFloat(anticipo.saldoAnticipo) ;

    })

    /*Comparamos el total de la suma para saber si este es 
    mayor o menor a la venta*/

    if (totalAnticipos >= totalPagar) {

        let i = 0;

        /*Hacemos una busqueda de que monto a que monto obtenemos el importe que 
        debemos pagar para así obetener su id para despues colocarlos en los imputs*/

        while (sumaAnticipos < totalPagar) {
            
            sumaAnticipos = sumaAnticipos + parseFloat(anticipos[i].saldoAnticipo);

            anticiposValidate.push({idAnticipos: anticipos[i].id, monto: parseFloat(anticipos[i].saldoAnticipo)})

            i++;
        }


        if (sumaAnticipos > totalPagar) {

             /*si el nuestra suma de anticipo exede el importe le restamos la diferencia 
             al anticipo más reciente, que este caso es el ultimo ya que la consulta esa ordenada de manera ASC por la fecha*/

            diferencia = sumaAnticipos - totalPagar;

            if (diferencia > 0) {

                anticiposValidate[anticiposValidate.length - 1].monto = anticiposValidate[anticiposValidate.length - 1].monto - diferencia;
            }
        }


        return anticiposValidate;
       

    }


    if (totalAnticipos < totalPagar) {

         anticipos.forEach((anticipo,index) => {
   
            anticiposValidate.push({idAnticipos: anticipo.id, monto: anticipo.saldoAnticipo });
        

    })

        return anticiposValidate;
       
    }

}


function setSelectionAnticipos(totalPagar){


    let inputs = document.querySelectorAll("#anticipoSelect")
    let importeTotalAnticipos = document.querySelector("#importeTotalAnticipos")


    for(let input of inputs){
    
        input.addEventListener("click",() => caclTotalImpoteAnticipo(totalPagar))
    }
    

}

function caclTotalImpoteAnticipo(totalPagar){

    let divNumeroAnticipos = document.querySelector("#numero_anticipos");
    let importesAnticipo   = document.querySelectorAll("#importeAnticipo");
    let montoRecibir       = document.querySelector("#montoRecibir");
    let totalMontoAnticipo = 0.00;
    let cantidadAnticipos  = 0;
    let montoRecibirTotal  = 0.00;

    for(let importes of importesAnticipo){


       let tr_Id = importes.getAttribute("data-idAnticipo")
       let checkBox = document.querySelector(`#anticipo_${tr_Id} input[type="checkbox"]`)


        if(checkBox.checked){

            cantidadAnticipos++

            totalMontoAnticipo = parseFloat(totalMontoAnticipo) + parseFloat(importes.value)

        }else {

            totalMontoAnticipo += 0.00;

        }
       

    }

    montoRecibirTotal = totalPagar - totalMontoAnticipo;

    montoRecibir.innerHTML          = `<strong>S/.${parseFloat(montoRecibirTotal).toFixed(2)}</strong>`
    importeTotalAnticipos.innerHTML = `<strong>S/.${parseFloat(totalMontoAnticipo).toFixed(2)}</strong>`
    divNumeroAnticipos.innerHTML    = `<strong>${cantidadAnticipos}</strong>`
}



function aplicarAnticipos(idOperacion,naturalizaAnticipo,tipo,caja_procesada = 0){

    let anticposGuardar = [];
    let contenedor      =  true;

    if (tipo === "VENTA" || tipo === "COMPRA" && caja_procesada == 0) {

        let importesAnticipo = document.querySelectorAll("#importeAnticipo");
        let contenedor = document.querySelector("#contentTablaAnticipos").style.display;

        for(let importes of importesAnticipo){


           let id_anticipo = importes.getAttribute("data-idAnticipo")
           let checkBox = document.querySelector(`#anticipo_${id_anticipo} input[type="checkbox"]`)

           if(checkBox.checked){

            anticposGuardar.push({idAnticipo: id_anticipo, monto: importes.value ,idOperacion: idOperacion, naturalizaAnticipo: naturalizaAnticipo, tipo: tipo, caja_procesada: caja_procesada})

            }
           

        }
    }else if(tipo === "COMPRA" && caja_procesada == 1){

        anticposGuardar.push({ idOperacion: idOperacion, naturalizaAnticipo: naturalizaAnticipo, tipo: tipo , caja_procesada: 1})
    }

    
    if (anticposGuardar.length != 0  && contenedor != "none") {

         $.ajax({
            url: `${ruta}anticipos/aplicarAnticipos`,
            type: 'POST',
            data: {data: anticposGuardar},
            dataType:'JSON',
            success: function(data) {
                console.log(data);
            
            },
            error: function() {
              $.bootstrapGrowl('<h4>Error.</h4> <p>Ha ocurrido un error en la operaci&oacute;n</p>', {
                type: 'danger',
                delay: 5000,
                allow_dismiss: true,
              });
             
            },
        });

    }
    
}


function validacionesCreditoAnticipos({id_actor,localId,naturalezaActor,idMoneda,totalPagar,tipoPago, selectorTotal}){

     /*cuando es a credito se envia una notificacion si el monto de la venta es menor a la suma de anticipos*/
     return new Promise((resolve, reject) => {

          let crediTotalVenta  = parseFloat(document.querySelector(`${selectorTotal}`).value)
            let creditoSaldoInicial = document.querySelector("#c_saldo_inicial")
            let response = null;
            let totalAnticipos = 0.00;
            let tipoPagoValue = document.querySelector(`${tipoPago}`).value;

            if (tipoPagoValue == 2 || tipoPagoValue == "CREDITO") {

                $.ajax({
                    url: `${ruta}anticipos/getAnticipos/${id_actor}/${localId}/${naturalezaActor}/${idMoneda}`,
                    type: 'POST',
                    dataType:'JSON',
                    success: function(data) {

                        if (data != null) {

                            data.forEach((anticipo) => {

                                totalAnticipos = totalAnticipos + parseFloat(anticipo.saldoAnticipo) ;

                            })

                            if (totalAnticipos >= crediTotalVenta) {
                                let msj = (naturalezaActor == 1)? "El cliente tiene anticipos que superan el monto de la venta, se sugiere realizar la venta al CONTADO" : "Se cuentan con anticipos pagados al proveedor que superan el monto de la compra, se debe realizar la compra al CONTADO";
                                var growlType = 'warning'
                                  $.bootstrapGrowl(`<h4>${msj}</h4>`, 
                                  {
                                    type: growlType,
                                    delay: 5000,
                                    allow_dismiss: true
                                  })

                                response = {"status": "MAYOR"};
                                resolve(response)

                            } else if (totalAnticipos < crediTotalVenta) {

                                creditoSaldoInicial.value = parseFloat(totalAnticipos).toFixed(2)

                                let event = new Event('keyup')
                                creditoSaldoInicial.dispatchEvent(event)

                                response = {"status": "MENOR" ,"total": totalAnticipos}

                                resolve(response)
                            }

                        }else {

                            response = {"status":"NO-ANTICIPOS"}
                            resolve(response)
                        }
                        
                    },
                    error: function() {

                        console.error("Fallo al obtner anticipos")
                        reject()
                        },
                });


            }else {
                response = {"status":"NO-APLICA"}
                resolve(response)
            }

            

    })

}


function editInputImporteAncicipo(event,id_Tr,totalPagar){
 
    event.preventDefault();
    var botonEdit = $(`#${id_Tr} #editar_importeAnticipo`);
    var input = $(`#${id_Tr} #importeAnticipo`);

    if (botonEdit.attr('data-estado') == '0') {
        input.removeAttr('readonly');
        input.trigger('focus');
        botonEdit.attr('data-estado', '1');
        botonEdit.html('<i class="fa fa-check"></i>');
    } else {
        
        input.attr('readonly', 'readonly');
        botonEdit.attr('data-estado', '0');
        botonEdit.html('<i class="fa fa-edit"></i>');

        caclTotalImpoteAnticipo(totalPagar)
    }

}