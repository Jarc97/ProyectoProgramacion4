<%-- 
    Document   : cambioClave
    Created on : 19/04/2019, 06:04:26 PM
    Author     : Feli
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Validar Contraseña</title> 

        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link href="css/default.css" rel="stylesheet" type="text/css"/>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <% response.setHeader("cache-control", "no-cache, no-store, must-revalidate"); %>
        <script src="scripts/script.js" type="text/javascript"></script>
    </head>
    <body>
        <jsp:directive.include file="headerIn.jsp" />
        <%
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
        <h6>Id de la sesion actual mediante bean: <jsp:getProperty name="sessionEst" property="id"/></h6>        <div id = "wrapperMostrar">

            <div id = "wrapperLogin">
                <h1>
                    Pagina de solicitud de cambio de contraseña
                </h1>
                <div class = "formContent">
                    <div class="fadeIn first">
                        <h5><br />
                            Por favor llene los siguientes espacios:
                        </h5>
                    </div>
                    <form name="formName" action="ServicioCambiarClave" method="POST" onsubmit='return validarClave()'>
                        <input type="password" name="passwordNew1" placeholder="Contraseña Nueva">
                        <div id="epasswordNew1" style="color:#f00;"></div>                   
                        <input type="password" name="passwordNew2" placeholder="Repita la contraseña">
                        <div id="epasswordNew2" style="color:#f00;"></div>  
                        <input type="submit" id ="ingresar" value="Ingresar">
                    </form>
                </div>
            </div>

            <jsp:directive.include file="footer.jsp" />
    </body>
</html>