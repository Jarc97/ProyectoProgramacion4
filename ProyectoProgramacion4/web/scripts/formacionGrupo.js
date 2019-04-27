
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
