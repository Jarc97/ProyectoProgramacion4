<%-- 
    Document   : login
    Created on : 19/04/2019, 02:43:29 PM
    Author     : Feli
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            HttpSession sesionActual;
            sesionActual = request.getSession(true);

            sesionActual.invalidate();
            sesionActual = request.getSession(true);
        %>
        <jsp:directive.include file="header.jsp" />
        <div id = "wrapper">


            <form name="loginForm" action="ServicioLogin" method="POST">
                <table class ="inicio" width="65%" cellpadding="8">
                    <tr>
                        <td align="right">
                            <strong>Id usuario:</strong>&nbsp;
                        </td><td>
                            <input type="text" size="30" id="usuario" name="usuario" autocomplete="off" />
                        </td>
                    </tr><tr>
                        <td align="right">
                            <strong>Clave de acceso:</strong>&nbsp;
                        </td><td>
                            <input type="text" size="30" id="password" name="password" />
                        </td>
                    </tr><tr>
                        <td align="center" colspan="2">
                            <button type="submit">Ingresar</button>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
        <jsp:directive.include file="footer.jsp" />
    </body>
</html>
