<%-- 
    Document   : principalEstudiante
    Created on : 16/04/2019, 10:38:11 PM
    Author     : Feli
--%>

<%@page import="Modelo.GestorEstudiantes"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Perfil del Estudiante</title>
        <meta charset="UTF-8">
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link href="css/default.css" rel="stylesheet" type="text/css"/>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <% response.setHeader("cache-control", "no-cache, no-store, must-revalidate"); %>
    </head>
    <body>
        <jsp:directive.include file="headerIn.jsp" />
        <%
            GestorEstudiantes ge = GestorEstudiantes.obtenerInstancia();
            HttpSession sesionActual = request.getSession();
            long transcurrido = System.currentTimeMillis() - sesionActual.getLastAccessedTime();
            String usua;
            String clave;

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



        <div id ="wrapperEstudiante">
            <h1>
                Bienvenido al sistema de grupos, <%= ge.obtenerNombre(session)%>
            </h1>
            <h4 id = "contents">            
                Con esta herramienta usted podrá crear o unirse a un grupo para coordinar sus trabajos en equipo, consultar los grupos 
                existentes o ver los estudiantes que se encuentran activos. En su perfil podrá consultar sus datos personales y cambiar
                su contraseña. 
                <br>Proyecto implementado por Luis Felipe Soto Cruz y Julio Rodríguez Chavarría para el curso de Programación 4, 2019.</br>
            </h4></br> 
            <div id="contents">
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
