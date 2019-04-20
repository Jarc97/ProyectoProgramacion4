<%-- 
// consultaGrupos.jsp  
// 
// EIF209 - Programación 4 – Proyecto #1
// Abril 2019 
// 
// Autores: 
//  - 402360123 Luis Felipe Soto Cruz
//  - 116760031 Julio Rodriguez Chavarria
// 
// --%> 

<%@page import="Modelo.GestorGrupos"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <meta name = "viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <% response.setHeader("cache-control", "no-cache, no-store, must-revalidate"); %>
    </head>
    <body>
        <%
            GestorGrupos gc = GestorGrupos.obtenerInstancia();
            HttpSession sesionActual = request.getSession();
            long transcurrido = System.currentTimeMillis() - sesionActual.getLastAccessedTime();
            
           String usua;
           
           if (transcurrido > (1000 * 60 * 5)) {
                request.getRequestDispatcher("errorLogin.jsp?error=1").forward(request, response);
            }
           if (sesionActual.getAttribute("usuario")!=null) {                 
            usua = sesionActual.getAttribute("usuario").toString();
            out.print("<h5>Usuario= " + usua+"</h5>");
            }
            else{
                request.getRequestDispatcher("errorLogin.jsp").forward(request, response);
            }

        %>


        <jsp:directive.include file="headerIn.jsp" />
        <div id = "wrapper">
            <h2>Grupos registrados</h2>

            <div class = "totalMat">
                <div class="tablaCursosMat">      
                    <tbody>
                        <%= gc.mostrarGrupos()%>
                    </tbody>
                </div>
            </div>  

        </div>
        <jsp:directive.include file="footer.jsp" />
    </body>
</html>
