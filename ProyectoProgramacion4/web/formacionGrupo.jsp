<%-- 
// formacionGrupo.jsp  
// 
// EIF209 - Programación 4 – Proyecto #1
// Abril 2019 
// 
// Autores: 
//  - 402360123 Luis Felipe Soto Cruz
//  - 116760031 Julio Rodriguez Chavarria
// 
// --%> 

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Modelo.GestorGrupos" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Formacion de grupos</title>
        <meta name = "viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
        <link rel="stylesheet" href="css/formacionGrupo.css" type="text/css">
        <script src="scripts/formacionGrupo.js" type="text/javascript"></script>
    </head>
    <body>
        <jsp:directive.include file="headerIn.jsp" />
        <%
            GestorGrupos gg = GestorGrupos.obtenerInstancia();
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
        <h6>Id de la sesion actual mediante bean: <jsp:getProperty name="sessionEst" property="id"/></h6>
        <div id="wrapperFormacion">
            <h1 class="infoPag">
                Creacion de grupos
            </h1>
            <h4 id="contents">
                En esta seccion, se muestra un formulario para que indique el nombre del grupo a crear, tambien permite ver los grupos que ya estan creados 
                y da la opcion de entrar a ese grupo si asi lo desea. De igual manera, le permite salirse del grupo o cambiarse a otro previamente creado.
                El cupo maximo de cada grupo es de 5 integrantes.
            </h4>
            <div class="container">
                <div class="row">
                    <div class="col-3">
                    </div>
                    <div class="col-sm-6 text-center">

                        <div class="formCrear">
                            <h4 id="formTitulo"> 
                                Crear un grupo 
                            </h4>
                            <form name ="formNomGrup" action="ServicioCrearGrupo" method="POST" onsubmit='return validarNombre()'>
                                <input type="text" size="30" id="formNombre" name="nombreGrupo" autocomplete="off" placeholder="Nombre del grupo" />
                                <div id="enombre" style="color:#f00;"></div> 
                                <p class="mesjDup">${error}</p>
                                <input id="formSubmit" type="submit" value="Crear">
                            </form>
                        </div>
                    </div>
                    <div class="col-3"></div>
                </div>
                <div class="listaGrupos">
                    <%=gg.mostrarGrupos(id)%>
                </div>
            </div> 
        </div>
            <jsp:directive.include file="footer.jsp" />
    </body>
</html>
