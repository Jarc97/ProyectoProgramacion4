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
        <script src="scripts/script.js" type="text/javascript"></script>
    </head>
    <body>
        <%
            HttpSession sesionActual = request.getSession();
            String passActual;
            passActual = sesionActual.getAttribute("clave").toString();
            out.print("<h5>Usuario= " + passActual + "</h5>");
        %>
        
        <jsp:directive.include file="header.jsp" />
        <h1>
            Pagina de solicutud de cambio de contraseña
        </h1>
        <form name="cambioClave" action="ServicioCambiarClave" method="POST" onsubmit='return validarClave()'>
            <div id="epasswordActual" style="color:#f00;"></div>
            <div>Clave actual: <input type="password" name="claveActual"/></div>
            <div id="epasswordNew1" style="color:#f00;"></div>
            <div>Clave nueva: <input type="password" name="claveNueva"/></div>
            <div>Repita la clave: <input type="password" name="claveNuevaRep"/></div>
            <div><input type="submit" value="Cambiar"/></div>
        </form>
        <jsp:directive.include file="footer.jsp" />
    </body>
</html>