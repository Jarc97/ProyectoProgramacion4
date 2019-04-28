<%-- 
// errorLogin.jsp  
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
        <title>Error</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="refresh" content="5;login.jsp">        
        <meta name = "viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
        <link href="css/errorLogin.css" rel="stylesheet" type="text/css"/>
        <% response.setHeader("cache-control", "no-cache, no-store, must-revalidate"); %>
    </head>
    <body>
        <jsp:directive.include file="header.jsp" />
        <div id="wrapper">
            <div id="contents">
                <h2>
                    <span style="color: red; font-weight: bold;">Algo salió mal!</span><br />
                    <span>Se redigirá automáticamente a la página de login</span>
                </h2>
                <p><strong>No ha iniciado la sesión.</strong><br />
                    Esto puede deberse a que la sesión ha expirado
                    o que los datos
                    de ingreso son incorrectos.</p>
                <p>
                    <span style="color:red">
                        <%
                            int codError = 0;
                            String mensaje = "(Por favor, espere a la redireccion)";
                            try {
                                codError = Integer.parseInt(request.getParameter("error"));
                            } catch (Exception e) {
                            }
                            switch (codError) {
                                case 1:
                                    mensaje = "La sesión ha expirado. Por favor vuelva a iniciar sesión";
                                    break;
                                case 2:
                                    mensaje = "Puede que el numero de cédula o la clave sean incorrectas.";
                                    break;
                                case 3:
                                    mensaje = "Los datos no coinciden.";
                                    break;
                                default:
                                    break;
                            }
                            out.println(mensaje);
                        %>
                    </span>
                </p>
            </div>           
        </div>
        <jsp:directive.include file="footer.jsp" />
    </body>
</html>
