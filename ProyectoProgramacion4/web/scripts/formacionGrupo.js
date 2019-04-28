/*
// formacionGrupo.js
// 
// EIF209 - Programación 4 – Proyecto #1
// Abril 2019 
// 
// Autores: 
//  - 402360123 Luis Felipe Soto Cruz
//  - 116760031 Julio Rodriguez Chavarria
// 
*/

function entrarAGrupo(idGrupo) {
    let fetchURL = "ServicioEntrarGrupo?id_grupo=" + idGrupo;
    fetch(fetchURL)
    .then(function(data) {
        // console.log(data);
        location.reload(true);
    });
}

function salirDelGrupo(idGrupo) {
    let fetchURL = "ServicioSalirGrupo?id_grupo=" + idGrupo;
    fetch(fetchURL)
    .then(function(data) {
        // console.log(data);
        location.reload(true);
    });
}

function validarNombre()
{
    nomb = document.formNomGrup.nombreGrupo;
    id_newNom = document.getElementById("enombre");

    if (nomb.value) {
        return true;
    } else {
        if (nomb.value === "")
            id_newNom.innerHTML = "Por favor indique el nombre";
        else
            id_newNom.innerHTML = "";
        return false;
    }
}
