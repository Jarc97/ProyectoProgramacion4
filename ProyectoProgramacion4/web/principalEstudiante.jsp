<%-- 
// principalEstudiante.jsp  
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
<%@taglib prefix="estudiantes" uri="/WEB-INF/tlds/estudiantes" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Perfil del Estudiante</title>
        <meta charset="UTF-8">
        <link href="css/principalEstudiante.css" rel="stylesheet" type="text/css"/>
        <% response.setHeader("cache-control", "no-cache, no-store, must-revalidate"); %>
    </head>
    <body>
        <jsp:directive.include file="headerIn.jsp" />
        <%
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

        <div id ="wrapperEstudiante">                
            <h1 class ="infoPag">
                Bienvenido al sistema de grupos, <%= ge.obtenerNombre(session)%>
            </h1>
            <h4 id = "contents">            
                Con esta herramienta usted podrá crear o unirse a un grupo para coordinar sus trabajos en equipo, consultar los grupos 
                existentes o ver los estudiantes que se encuentran activos. En su perfil podrá consultar sus datos personales y cambiar
                su contraseña. 
                <br>Proyecto implementado por Luis Felipe Soto Cruz y Julio Rodríguez Chavarría para el curso de Programación 4, 2019.</br>
            </h4></br> 
            <div class="contPers">
                <div class="datosPersonales">
                    <h1>Datos personales</h1>          
                    <p>
                        <%= ge.obtenerEstudiante(sesionActual)%>
                    </p>
                    <form action="cambioClave.jsp" method ="GET">
                        <input type="submit" value="Cambiar Clave"/>
                    </form>
                </div> 
            </div>
        </div> 
        <jsp:directive.include file="footer.jsp" />
    </body>
</html>
