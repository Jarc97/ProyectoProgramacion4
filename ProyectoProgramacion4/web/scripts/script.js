/*
// script.js
// 
// EIF209 - Programación 4 – Proyecto #1
// Abril 2019 
// 
// Autores: 
//  - 402360123 Luis Felipe Soto Cruz
//  - 116760031 Julio Rodriguez Chavarria
// 
*/

var catalogo = null;
var tablaEstudiantes = [];
var productoSeleccionado = null;

function inicializarDatos(nuevosDatos) {
    catalogo = nuevosDatos;
    console.log("Datos cargados..");
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
        actualizarFormulario();
    }
}



