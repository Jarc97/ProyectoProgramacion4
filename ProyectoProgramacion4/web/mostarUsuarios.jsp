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

<%@page import="java.util.List"%>
<%@page import="Entidades.Estudiante"%>
<%@page import="Modelo.GestorEstudiantes"%>
<%@page import="Control.ServicioMostarEstudiantes" %>
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
        <% response.setHeader("cache-control", "no-cache, no-store, must-revalidate");%>
        <script src="scripts/script.js" type="text/javascript"></script> 
        <script src="scripts/mostrarUsuarios.js" type="text/javascript"></script>
        <script type="text/javascript">
            inicializarDatos(<%= new ServicioMostarEstudiantes().listaProductosJSON()%>);
        </script>
    </head>
    <body>
        <jsp:directive.include file="headerIn.jsp" />
        <%
            HttpSession sesionActual = request.getSession();
            GestorEstudiantes ge = GestorEstudiantes.obtenerInstancia();
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
        <h6>Id de la sesion actual mediante bean: <jsp:getProperty name="sessionEst" property="id"/></h6>       
        <div id = "wrapperMostrar">

            <div id = "contents">
                <h2>Seccion de Usuarios</h2>
                <h6>
                    En esta seccion, usted podra ver todos los estudiantes activos y todos los registros en la base de datos mediante un criterio de busqueda. 
                </h6>
            </div>
            <h4>Listado de estudiantes activos</h4>
            <div id="contenido">
                <%= ge.obtenerEstudiantesActivos()%>
            </div>
            <h4>Listado de estudiantes por criterio de busqueda ${opcion}</h4>
            <form name="buscarPor" action="ServicioMostarEstudiantes" method="POST">
                <h5>
                    Mostrar por...
                    <select name="selFil" onchange="seleccionarOpcion()">
                        <option value="por Defecto" selected="selected">Elija una opcion</option>
                        <option value="por Grupo de Trabajo">Grupo de trabajo</option>
                        <option value="por Grupo Matriculado">Grupo matriculado</option>
                        <option value="por Numero Identificacion">Numero de identificacion</option>
                        <option value="por Apellidos y Nombre">Apellidos y nombre</option>
                        <option value="por Ultimo Acceso">Ultimo Acceso</option>
                    </select>
                    <input type="submit" value="Filtar"/>
                </h5>

            </form>
            <div id="usuariosTotales"> 
                ${listaE}
            </div>
        </div>            
        <jsp:directive.include file="footer.jsp" />
    </body>
</html>