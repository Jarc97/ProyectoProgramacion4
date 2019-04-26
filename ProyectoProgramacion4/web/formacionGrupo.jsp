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
<!DOCTYPE html>
<html>
    <head>
        <title>Formación de Grupos</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">       
        <meta name = "viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link href="css/default.css" rel="stylesheet" type="text/css"/>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <% response.setHeader("cache-control", "no-cache, no-store, must-revalidate"); %>
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
  <div id="wrapper">
            <div class="container">
                
                <div class="row">
                    <div class="col-3">
                    </div>
                    
                    <div class="col-sm-6 text-center">
                        <div id="form">
                            <h4 id="formTitulo"> Crear un grupo </h4>
                            <form>
                                <input type="text" size="30" id="formNombre" name="nombre" autocomplete="off" placeholder="Nombre del grupo" />
                                <br>
                                <button id="formSubmit" type="submit">Crear</button>
                            </form>
                        </div>
                    </div>
                    
                    <div class="col-3">
                    </div>
                </div>
                
                <div class="row">
                    <div class="col-6">
                        <table style="width:100%">
                            <tr>
                                <th id="tableHeader1" colspan="2">Grupo 1</th>
                            </tr>
                            <tr>
                                <th id="tableHeader2" colspan="2">Los mejores</th>
                            </tr>
                            <tr>
                                <td>Julio</td>
                                <td>Rodriguez</td>
                            </tr>
                            <tr>
                                <td>Felipe</td>
                                <td>Soto</td>
                            </tr>
                        </table>
                    </div>
                    <div class="col-6">
                        <table style="width:100%">
                            <tr>
                                <th id="tableHeader1" colspan="2">Grupo 2</th>
                            </tr>
                            <tr>
                                <th id="tableHeader2" colspan="2">Oompa Loompas</th>
                            </tr>
                            <tr>
                                <td>Julio</td>
                                <td>Rodriguez</td>
                            </tr>
                            <tr>
                                <td>Felipe</td>
                                <td>Soto</td>
                            </tr>
                        </table>
                    </div>
                </div>
                
            </div> 
        </div>
        
        <jsp:directive.include file="../footer.jsp" />
    </body>
</html>
