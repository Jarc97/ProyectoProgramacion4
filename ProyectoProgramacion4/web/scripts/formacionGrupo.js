
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