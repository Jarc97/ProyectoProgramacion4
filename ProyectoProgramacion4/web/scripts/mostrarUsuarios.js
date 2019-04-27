function init3() {
    setInterval(refresh, 3000);
}

function refresh() {
    let url = "ServicioMostarEstudiantes";
    fetch(url)
    .then((resp) => resp.json()) // Transform the data into json
    .then(function(data) {
        console.log(data.reply);
        let c = document.getElementById("usuariosTotales");
        c.innerHTML = "";
        c.innerHTML = data.reply;
    });
}
function refresh1() {
    setTimeout(function () {
        location.reload();
    }, 1000);
}