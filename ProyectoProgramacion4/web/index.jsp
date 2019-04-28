<%-- 
// index.jsp  
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
        <title>Inicio</title>
        <meta charset="UTF-8">        
        <meta name = "viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
        <link href="css/index.css" rel="stylesheet" type="text/css"/>
<% response.setHeader("cache-control", "no-cache, no-store, must-revalidate"); %>
    </head>
    <body>
        <jsp:directive.include file="header.jsp" />
        <%
            HttpSession sesionActual = request.getSession();
            String usua;
            if (sesionActual.getAttribute("usuario") != null) {
                usua = sesionActual.getAttribute("usuario").toString();
                out.print("<h5>Usuario= " + usua + "</h5>");
            }
        %>
        <div id = "wrapper">            
            <h2>
                Bienvenido a la herramienta de grupos
            </h2>
            <h4 id = "contents">
                Con esta herramienta usted podrá crear o unirse a un grupo para coordinar sus trabajos en equipo, consultar los grupos 
                existentes o ver la lista de los estudiantes. En su perfil podrá consultar sus datos personales y cambiar
                su contraseña. </br>
                Por favor autentiquese en la opcion de login para la formacion de grupos, consultar los grupos y ver los usuarios.
            </h4>        
        </div>
        <jsp:directive.include file="footer.jsp" />
    </body>
</html>
