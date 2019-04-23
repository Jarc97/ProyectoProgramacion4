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
        <title>JSP Page</title>
        <meta name = "viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="css/formacionGrupo.css" type="text/css">
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    </head>
    <body>
        <%
            // GestorGrupos gc = GestorGrupos.obtenerInstancia();
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
        
        <nav class="navbar navbar-expand-sm bg-dark navbar-dark fixed-top">
            <a class="navbar-brand" href="#">Logo</a>
            <ul class="navbar-nav">
                <li class="nav-item active">
                    <a class="nav-link" href="#">Crear/Unirse a un grupo</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link disabled" href="#">|</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Consulta grupos</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link disabled" href="#">|</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Usuarios conectados</a>
                </li>
            </ul>
        </nav>
       
        <div id="wrapper">
            <div class="container">
                
                <div class="row">
                    <div class="col-3">
                    </div>
                    
                    <div class="col-sm-6 text-center">
                        <div id="form">
                            <h4 id="formTitulo"> Crear un grupo </h4>
                            <form action="ServicioCrearGrupo" method="POST">
                                <input type="text" size="30" id="formNombre" name="nombreGrupo" autocomplete="off" placeholder="Nombre del grupo" />
                                <br>
                                <button id="formSubmit" type="submit">Crear</button>
                            </form>
                        </div>
                    </div>
                    
                    <div class="col-3">
                    </div>
                </div>
                
                <%
                    GestorGrupos gg = GestorGrupos.obtenerInstancia();
                %>
                <%=
                    gg.mostrarGrupos()
                %>
                
            </div> 
        </div>
        
        <jsp:directive.include file="footer.jsp" />
    </body>
</html>
