<%-- 
// index.jsp  
// 
// EIF209 - Programación 4 – Proyecto #1
// Abril 2019 
// 
// Autores: 
//  - 402360123 Luis Felipe Soto Cruz
//  - 116760031 Julio Rodriguez Chavarria
// 
// --%> 

<%@page import="Modelo.GestorEstudiantes"%>
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
        <%
            HttpSession sesionActual = request.getSession();
            String usua;
            if (sesionActual.getAttribute("usuario")!=null) {                 
            usua = sesionActual.getAttribute("usuario").toString();
            out.print("<h5>Usuario= " + usua+"</h5>");
            }
        %>
        <div id = "wrapper">

            <jsp:directive.include file="header.jsp" />
             <h2>
                 Bienvenido a la herramienta de grupos
             </h2>
            <div id = "contents">            
              Por favor autentiquese en la opcion de login para la formacion de grupos, consultar los grupos y ver los usuarios.
            </div>        
        </div>
        
        <jsp:directive.include file="footer.jsp" />
    </body>
</html>
