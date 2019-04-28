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
        <link href="css/mostarUsuarios.css" rel="stylesheet" type="text/css"/>
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
            <div>
                <h1 class="infoPag">
                    Seccion de Usuarios
                </h1>
                <h4 id="contents">
                    En esta seccion, usted podra ver todos los estudiantes activos y todos los registros en la base de datos mediante un criterio de busqueda. 
                </h4>
            </div>
            <h4>Listado de estudiantes activos</h4>
            <div class="contenido">
                <%= ge.obtenerEstudiantesActivos()%>
            </div>
            <h4>Listado de estudiantes por criterio de busqueda ${opcion}</h4>
            <form name="buscarPor" action="ServicioMostarEstudiantes" method="POST">
                <h5 class="formFiltrar">
                    Mostrar por...
                    <select name="selFil" onchange="seleccionarOpcion()">
                        <option value="por Defecto" selected="selected">Elija una opcion</option>
                        <option value="por Grupo de Trabajo">Grupo de trabajo</option>
                        <option value="por Grupo Matriculado">Grupo matriculado</option>
                        <option value="por Numero Identificacion">Numero de identificacion</option>
                        <option value="por Apellidos y Nombre">Apellidos y nombre</option>
                        <option value="por Ultimo Acceso">Ultimo Acceso</option>
                    </select>
                    <input id="formSubmit" type="submit" value="Filtar"/>
                </h5>
            </form>
            <div class="usuariosTotales"> 
                ${listaE}
            </div>
        </div>            
        <jsp:directive.include file="footer.jsp" />
    </body>
</html>