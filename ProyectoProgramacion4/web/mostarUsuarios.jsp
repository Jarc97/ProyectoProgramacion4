<%-- 
// mostrarUsuarios.jsp  
// 
// EIF209 - Programación 4 – Proyecto #1
// Abril 2019 
// 
// Autores: 
//  - 402360123 Luis Felipe Soto Cruz
//  - 116760031 Julio Rodriguez Chavarria
// 
// --%> 

<%@page import="Modelo.GestorEstudiantes"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Estudiantes Registrados</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">        
        <meta name = "viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link href="css/default.css" rel="stylesheet" type="text/css"/>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <% response.setHeader("cache-control", "no-cache, no-store, must-revalidate"); %>
        <script>setTimeout('document.location.reload()', 1000);</script>
        <script src="scripts/script.js" type="text/javascript"></script>
    </head>
    <body>
        <jsp:directive.include file="headerIn.jsp" />
        <%
            HttpSession sesionActual = request.getSession();
            GestorEstudiantes ge = GestorEstudiantes.obtenerInstancia();
            long transcurrido = System.currentTimeMillis() - sesionActual.getLastAccessedTime();
            String usua;

            if (transcurrido > (1000 * 60 * 5)) {
                request.getRequestDispatcher("errorLogin.jsp?error=1").forward(request, response);
            }

            if (sesionActual.getAttribute("usuario") != null) {
                usua = sesionActual.getAttribute("usuario").toString();
                out.print("<h5>Usuario= " + usua + "</h5>");
            } else {
                request.getRequestDispatcher("errorLogin.jsp").forward(request, response);
            }
        %>

        <div id = "wrapperMostrar">

            <h2>Usuarios activos</h2>
            <div id = "contents">            
                Lorem Ipsum is simply dummy text of the printing and typesetting industry.
                Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown 
                printer took a galley of type and scrambled it to make a type specimen book. It has survived not 
                only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. 
                It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, 
                and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
            </div>  
            <div class="usuariosTotales">            
                <p>
                    <%= ge.obtenerEstudiantesActivos()%>
                </p>
            </div>
        </div>            
        <jsp:directive.include file="footer.jsp" />
    </body>
</html>
