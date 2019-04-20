/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
function cambiarClave(parametro){
    let fetchURL = "ServicioCambiarClave?clave=" + parametro;
    fetch(fetchURL)
            .then(function(data){
                location.reload(true);
            });
}

function validarClave()
{
    passActual = document.formName.claveActual;
    passNueva = document.formName.claveNueva;
    passNuevaRep = document.formName.claveNuevaRep;
    id_epassActual = document.getElementById("epasswordActual");
    id_epassNew = document.getElementById("epasswordNew1");

    //Patron para los numeros
    var patronNumeros = new RegExp("[0-9]+");
    //Patron para las letras
    var patronLetras = new RegExp("[a-zA-Z]+");

    if (passNueva.value === passNuevaRep.value && passNueva.value.length >= 6 && passActual.value !== "" && passNueva.value.search(patronNumeros) >= 0 && passNueva.value.search(patronLetras) >= 0) {
        return true;
    } else {
        if (passNueva.value.length < 8)
            id_epassNew.innerHTML = "La longitud mínima tiene que ser de 8 caracteres";
        else if (passNueva.value !== passNuevaRep.value)
            id_epassNew.innerHTML = "Las contraseñas con coinciden";
        else if (passNueva.value.search(patronNumeros) < 0 || passNueva.value.search(patronLetras) < 0)
            id_epassNew.innerHTML = "La nueva contraseña tiene que tener numeros y letras para mayor seguridad";
        else
            id_epassNew.innerHTML = "";
        if (passActual.value === "")
            id_epassActual.innerHTML = "Indicar tu contraseña actual";
        else
            id_epassActual.innerHTML = "";
        return false;
    }
}