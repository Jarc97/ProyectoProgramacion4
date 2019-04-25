/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
function cambiarClave(parametro) {
    let fetchURL = "ServicioCambiarClave?clave=" + parametro;
    fetch(fetchURL)
            .then(function (data) {
                location.reload(true);
            });
}

function validarClave()
{
    pasNew1 = document.formName.passwordNew1;
    pasNew2 = document.formName.passwordNew2;
    id_epassActual = document.getElementById("epasswordNew1");
    id_epassNew = document.getElementById("epasswordNew2");

    var patron1 = new RegExp("[0-9]+");
    var patron2 = new RegExp("[a-zA-Z]+");

    if (pasNew1.value === pasNew2.value && pasNew1.value.length >= 6 && pasNew1.value !== "" && pasNew2.value !== "" && pasNew1.value.search(patron1) >= 0 && pasNew1.value.search(patron2) >= 0) {
        return true;
    } else {
        if (pasNew1.value.length < 6)
            id_epassNew.innerHTML = "La longitud mínima tiene que ser de 6 caracteres";
        else if (pasNew1.value !== pasNew2.value)
            id_epassNew.innerHTML = "La copia de la nueva contraseña con coincide";
        else if (pasNew1.value.search(patron1) < 0 || pasNew1.value.search(patron2) < 0)
            id_epassNew.innerHTML = "La contraseña tiene que tener numeros y letras";
        else
            id_epassNew.innerHTML = "";
        if (pasNew1.value === "" || pasNew2.value === "")
            id_epassActual.innerHTML = "Rellene los esapcios";
        else
            id_epassActual.innerHTML = "";
        return false;
    }
}
