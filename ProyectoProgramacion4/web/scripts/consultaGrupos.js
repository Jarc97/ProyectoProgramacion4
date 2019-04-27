function init2() {
    setInterval(refresh, 3000);
}

function refresh() {
    let url = "ServicioConsultaGrupos";
    fetch(url)
    .then((resp) => resp.json()) // Transform the data into json
    .then(function(data) {
        console.log(data.reply);
        let c = document.getElementById("contenido");
        c.innerHTML = "";
        c.innerHTML = data.reply;
    });
}