//Solo Texto o Letras
function soloTexto(event) {
    var key = window.event ? event.keyCode : event.which;

    tecla = String.fromCharCode(key).toLowerCase();
    letras = " �����abcdefghijklmn�opqrstuvwxyz";

    if (event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 46 || event.keyCode == 37 || event.keyCode == 39) {
        return true;
    }
    else if (letras.indexOf(tecla) == -1) {
        return false;
    } else return true;
}

//Solo Numeros
function soloNumeros(event) {
    var key = window.event ? event.keyCode : event.which;

    if (event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 46|| event.keyCode == 37 || event.keyCode == 39) {
        return true;
    }
    else if ((key < 48 || key >58) && (key < 96|| key >105) || (key ==69) || key==189 || key==190
        || key==109 || key==107) {
        return false;
    }
    else return true;
}

//Setencia para validar Ingreso de Decimal
var objeto2;
function soloDecimal(objeto, e) {
    var keynum
    var keychar
    var numcheck
    if (window.event) { /*/ IE*/
        keynum = e.keyCode
    }

    else if (e.which) { /*/ Netscape/Firefox/Opera/*/
        keynum = e.which
    }

    if ((keynum >= 35 && keynum <= 37) || keynum == 8 || keynum == 9 || keynum == 46 || keynum == 39) {
        return true;
    }

    if (keynum == 190 || keynum == 110 || (keynum >= 95 && keynum <= 105) || (keynum >= 48 && keynum <= 57)) {

        posicion = objeto.value.indexOf('.');

        if (posicion == -1) {
            return true;
        } else {
            if (!(keynum == 190 || keynum == 110)) {
                objeto2 = objeto;
                t = setTimeout('dosDecimales()', 150);
                return true;
            } else {
                objeto2 = null;
                return false;
            }
        }
    } else {
        return false;
    }
}

var objeto3decimal;
function soloDecimal3(objeto, e) {
    var keynum
    var keychar
    var numcheck
    if (window.event) { /*/ IE*/
        keynum = e.keyCode
    }

    else if (e.which) { /*/ Netscape/Firefox/Opera/*/
        keynum = e.which
    }

    if ((keynum >= 35 && keynum <= 37) || keynum == 8 || keynum == 9 || keynum == 46 || keynum == 39) {
        return true;
    }

    if (keynum == 190 || keynum == 110 || (keynum >= 95 && keynum <= 105) || (keynum >= 48 && keynum <= 57)) {

        posicion = objeto.value.indexOf('.');

        if (posicion == -1) {
            return true;
        } else {
            if (!(keynum == 190 || keynum == 110)) {
                objeto3decimal = objeto;
                t = setTimeout('tresDecimales()', 250);
                return true;
            } else {
                objeto3decimal = null;
                return false;
            }
        }
    } else {
        return false;
    }
}
var objeto4decimal;
function soloDecimal4(objeto, e) {
    var keynum
    var keychar
    var numcheck
    if (window.event) { /*/ IE*/
        keynum = e.keyCode
    }

    else if (e.which) { /*/ Netscape/Firefox/Opera/*/
        keynum = e.which
    }

    if ((keynum >= 35 && keynum <= 37) || keynum == 8 || keynum == 9 || keynum == 46 || keynum == 39) {
        return true;
    }

    if (keynum == 190 || keynum == 110 || (keynum >= 95 && keynum <= 105) || (keynum >= 48 && keynum <= 57)) {

        posicion = objeto.value.indexOf('.');

        if (posicion == -1) {
            return true;
        } else {
            if (!(keynum == 190 || keynum == 110)) {
                objeto4decimal = objeto;
                t = setTimeout('cuatroDecimales()', 250);
                return true;
            } else {
                objeto4decimal = null;
                return false;
            }
        }
    } else {
        return false;
    }
}


function dosDecimales() {
    var objeto = objeto2;
    var posicion = objeto.value.indexOf('.');
    var decimal = 2;
    if (objeto.value.length - posicion < decimal) {
        objeto.value = objeto.value.substr(0, objeto.value.length - 1);
    } else {
        objeto.value = objeto.value.substr(0, posicion + decimal + 1);
    }
    return;
}


function tresDecimales() {
    var objeto = objeto3decimal;
    var posicion = objeto.value.indexOf('.');
    var decimal = 3;
    /* if(objeto.value.length - posicion < decimal){
     objeto.value = objeto.value.substr(0,objeto.value.length-1);
     }else {
     objeto.value = objeto.value.substr(0,posicion+decimal+1);
     }*/
    objeto.value = objeto.value.substr(0, posicion + decimal + 1);
    return;
}

function cuatroDecimales() {
    var objeto = objeto4decimal;
    var posicion = objeto.value.indexOf('.');
    var decimal = 4;
    /* if(objeto.value.length - posicion < decimal){
     objeto.value = objeto.value.substr(0,objeto.value.length-1);
     }else {
     objeto.value = objeto.value.substr(0,posicion+decimal+1);
     }*/
    objeto.value = objeto.value.substr(0, posicion + decimal + 1);
    return;
}


//Setencia para Validar Ingreso de Decimal para porcentaje
var objeto3;
function soloPorcentaje(objeto, e) {
    var keynum
    var keychar
    var numcheck
    if (window.event) { /*/ IE*/
        keynum = e.keyCode
    }

    else if (e.which) { /*/ Netscape/Firefox/Opera/*/
        keynum = e.which
    }

    if ((keynum >= 35 && keynum <= 37) || keynum == 8 || keynum == 9 || keynum == 46 || keynum == 39) {
        return true;
    }

    if (keynum == 190 || keynum == 110 || (keynum >= 95 && keynum <= 105) || (keynum >= 48 && keynum <= 57)) {

        posicion = objeto.value.indexOf('.');

        if (posicion == -1) {
            return true;
        } else {
            if (!(keynum == 190 || keynum == 110)) {
                objeto3 = objeto;
                t = setTimeout('unDecimal()', 150);
                return true;
            } else {
                objeto3 = null;
                return false;
            }
        }
    } else {
        return false;
    }
}


function unDecimal() {
    var objeto = objeto3;
    var posicion = objeto.value.indexOf('.');
    var decimal = 1;
    if (objeto.value.length - posicion < decimal) {
        objeto.value = objeto.value.substr(0, objeto.value.length - 1);
    } else {
        objeto.value = objeto.value.substr(0, posicion + decimal + 1);
    }
    return;
}

function selectInCombo(combo, val) {
    for (var ind = 0; ind < document.getElementById(combo).length; ind++) {
        if (document.getElementById(combo).options[ind].value == val)
            document.getElementById(combo).selectedIndex = ind;
    }
}