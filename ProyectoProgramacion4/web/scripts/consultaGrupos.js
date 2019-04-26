
function init() {
    setTimeout(refresh, 1000);
}

function refresh() {
    let fetchURL = "ServicioConsultaGrupos";
    fetch(fetchURL)
    .then(function(data) {
        console.log(data);
    });
}