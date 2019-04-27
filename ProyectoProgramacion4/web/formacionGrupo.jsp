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
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="css/formacionGrupo.css" type="text/css">
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
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
            <div id="wrapper">
                <h2>Creacion de grupos</h2>
                 <h6>
                     En esta seccion, se muestra un formulario para que indique el nombre del grupo a crear, tambien permite ver los grupos que ya estan creados 
                     y da la opcion de entrar a ese grupo si asi lo desea. De igual manera, le permite salirse del grupo o cambiarse a otro posteriormente creado.
                 </h6>
                <div class="container">
                    <div class="row">
                        <div class="col-3">
                        </div>
                        <div class="col-sm-6 text-center">
                            <p style="background-color: red; border-radius: 15px;">${error}</p>
                            <div id="form">
                                <h4 id="formTitulo"> Crear un grupo </h4>
                                <form name ="formNomGrup" action="ServicioCrearGrupo" method="POST" onsubmit='return validarNombre()'>
                                    <input type="text" size="30" id="formNombre" name="nombreGrupo" autocomplete="off" placeholder="Nombre del grupo" />
                                    <div id="enombre" style="color:#f00;"></div> 
                                    <br>
                                    <input id="formSubmit" type="submit" value="Crear">
                                </form>
                            </div>
                        </div>
                        <div class="col-3">
                        </div>
                    </div>
                    <%=gg.mostrarGrupos()%>
                </div> 
            </div>
            <jsp:directive.include file="footer.jsp" />
    </body>
</html>
