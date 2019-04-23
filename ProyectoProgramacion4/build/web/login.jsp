<%-- 
// login.jsp  
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
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Ingreso</title>
        <meta name = "viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
    <div id = "wrapper">
        <jsp:directive.include file="header.jsp" />
        <div id = "contents">
            <h2 class ="ingreso">Bienvenido al sistema de ingreso</h2>
            <p>
                <%
                    HttpSession sesionActual;
                    sesionActual = request.getSession(true);
                    
                    sesionActual.invalidate();
                    sesionActual = request.getSession(true);
                %>
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
                            <input type="password" size="30" id="password" name="password" />
                        </td>
                    </tr><tr>
                        <td align="center" colspan="2">
                            <button type="submit">Ingresar</button>
                        </td>
                    </tr>
                </table>
            </form>

        </div>            
    </div>
    <jsp:directive.include file="footer.jsp" />
</body>
</html>