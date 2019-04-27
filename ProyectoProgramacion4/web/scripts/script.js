var catalogo = null;
var tablaEstudiantes = [];
var productoSeleccionado = null;


function inicializarDatos(nuevosDatos) {

    // Esta función se ejecuta cuando se carga la hoja de scripts.
    // NO se ejecuta como respuesta a un evento de la página.

    catalogo = nuevosDatos;
    console.log("Datos cargados..");
}

function cambiarClave(parametro) {
    let fetchURL = "ServicioCambiarClave?clave=" + parametro;
    fetch(fetchURL)
            .then(function (data) {
                location.reload(true);
            });
}
function obtenerEstudiante(id) {
    var r = null;
    for (var i = 0; i < catalogo.estudiantes.length; i++) {
        var estudiante = catalogo.estudiantes[i];
        if (estudiante.id === id) {
            r = estudiante;
            break;
        }
    }
    return r;
}
function seleccionarOpcion() {
    var refMenu = document.getElementById("selFil");
    if (refMenu) {
        var id = refMenu.value;
        if (id !== "null") {
            console.log("Seleccionando opcion: " + id);
            productoSeleccionado = obtenerEstudiante(id);
        } else {
            productoSeleccionado = null;
            console.error("No se ha seleccionado el producto.");
        }

        // Una vez que se ha seleccionado el producto, se muestra
        // la información en el formulario.
        // El producto no se agrega a la factura hasta que el usuario
        // haga clic en el botón correspondiente.

        actualizarFormulario();
    }
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
            id_epassActual.innerHTML = "Rellene los espacios";
        else
            id_epassActual.innerHTML = "";
        return false;
    }
}


