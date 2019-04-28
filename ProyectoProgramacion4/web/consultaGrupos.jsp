<%-- 
// consultaGrupos.jsp  
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
<%@page import="Modelo.GestorGrupos"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Consulta de Grupos</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">        
        <meta name = "viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
        <link href="css/consultaGrupos.css" rel="stylesheet" type="text/css"/>
        <script src="scripts/consultaGrupos.js" type="text/javascript"></script>
        <% response.setHeader("cache-control", "no-cache, no-store, must-revalidate"); %>
    </head>
    <body onload="init2()">
        <jsp:directive.include file="headerIn.jsp" />
        <%
            GestorGrupos gc = GestorGrupos.obtenerInstancia();
            GestorEstudiantes ge = GestorEstudiantes.obtenerInstancia();
            HttpSession sesionActual = request.getSession();
            long transcurrido = System.currentTimeMillis() - sesionActual.getLastAccessedTime();
            String id = "";

            if (transcurrido > (1000 * 60 * 5)) {
                request.getRequestDispatcher("errorLogin.jsp?error=1").forward(request, response);
            }

            if (sesionActual.getAttribute("usuario") != null) {
                id = sesionActual.getAttribute("usuario").toString();

            } else {
                request.getRequestDispatcher("errorLogin.jsp").forward(request, response);
            }
        %>
        <jsp:useBean id="sessionEst" class ="Entidades.Estudiante" scope="session"/>
        <jsp:setProperty name = "sessionEst" property="id" value= "<%=id%>" />
        <h6>Id de la sesion actual mediante bean: <jsp:getProperty name="sessionEst" property="id"/></h6>        <div id = "wrapperMostrar">
            <div id = "wrapperConsulta">
                <h1 class="infoPag">
                    Grupos registrados
                </h1>
                <h4 id="contents">
                    En esta seccion, se muestran los grupos creados, junto a los estudiantes que pertenecen al mismo. Ademas, muestra una lista de los estudiantes que estan activos en el sistema.
                </h4>
                <div class="contenido">
                    <%= gc.mostrarGruposConsulta()%>
                </div>            
            </div>
            <jsp:directive.include file="footer.jsp" />
    </body>
</html>
