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

<%@page import="Modelo.GestorGrupos"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Consulta de Grupos</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">        
        <meta name = "viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link href="css/default.css" rel="stylesheet" type="text/css"/>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <% response.setHeader("cache-control", "no-cache, no-store, must-revalidate"); %>
    </head>
    <body>
        <jsp:directive.include file="headerIn.jsp" />
        <%
            GestorGrupos gc = GestorGrupos.obtenerInstancia();             
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
        <jsp:useBean id="sessionEst" class ="Modelo.Estudiante" scope="session"/>
        <jsp:setProperty name = "sessionEst" property="id" value= "<%=id%>" />
        <h6>El id de la sesion actual mediante bean es: <jsp:getProperty name="sessionEst" property="id"/></h6>
        <div id = "wrapper">
            <h2>Grupos registrados</h2>

            <div class = "totalMat">
                <div class="tablaCursosMat">      
                    <tbody>
                        <%= gc.mostrarGrupos()%>
                    </tbody>
                </div>
            </div>  

        </div>
        <jsp:directive.include file="footer.jsp" />
    </body>
</html>
