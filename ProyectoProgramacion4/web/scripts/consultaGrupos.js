/*
// consultarGrupos.js
// 
// EIF209 - Programación 4 – Proyecto #1
// Abril 2019 
// 
// Autores: 
//  - 402360123 Luis Felipe Soto Cruz
//  - 116760031 Julio Rodriguez Chavarria
// 
*/

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