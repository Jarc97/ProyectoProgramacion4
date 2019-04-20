<%-- 
    Document   : principalEstudiante
    Created on : 16/04/2019, 10:38:11 PM
    Author     : Feli
--%>

<%@page import="Modelo.GestorEstudiantes"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <title>JSP Page</title>
    </head>
    <body>
        <%
            GestorEstudiantes ge = GestorEstudiantes.obtenerInstancia();
             HttpSession sesionActual = request.getSession();
                long transcurrido = System.currentTimeMillis() - sesionActual.getLastAccessedTime();
                String usua;
                String clave;

                if (transcurrido > (1000 * 60 * 5)) {
                    request.getRequestDispatcher("errorLogin.jsp?error=1").forward(request, response);
                }

                if (sesionActual.getAttribute("usuario") != null) {
                    usua = sesionActual.getAttribute("usuario").toString();
                    out.print("<h5>Usuario= " + usua + "</h5>");
                    
                } else {
                    request.getRequestDispatcher("errorLogin.jsp").forward(request, response);
                }
        %>
        
        
        <jsp:directive.include file="headerIn.jsp" />
        <div id = "wrapper">


            <h2>Bienvenido al sistema de grupos, <%= ge.obtenerNombre(session)%>
            </h2>
            <div id = "contents">            
                Lorem Ipsum is simply dummy text of the printing and typesetting industry.
                Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown 
                printer took a galley of type and scrambled it to make a type specimen book. It has survived not 
                only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. 
                It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, 
                and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
            </div>           
            <h1>Datos personales</h1>
            <div id="contents">

                <div class="datosPersonales">            
                    <p>
                        <%= ge.obtenerEstudiante(sesionActual)%>
                    </p>
                </div>
            </div>
            <div>
                <a href="cambioClave.jsp">Click para cambiar clave</a>
            </div>
        </div> 
        <jsp:directive.include file="footer.jsp" />
    </body>
</html>
