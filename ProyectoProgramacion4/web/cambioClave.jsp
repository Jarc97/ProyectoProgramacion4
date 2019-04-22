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
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link href="css/default.css" rel="stylesheet" type="text/css"/>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <% response.setHeader("cache-control", "no-cache, no-store, must-revalidate"); %>
        
            
    
    <script type="text/javascript">
<!--
function validate_password()
{
	//Cogemos los valores actuales del formulario
	pasActual=document.formName.passwordActual;
	pasNew1=document.formName.passwordNew1;
	pasNew2=document.formName.passwordNew2;
	//Cogemos los id's para mostrar los posibles errores
	id_epassActual=document.getElementById("epasswordActual");
	id_epassNew=document.getElementById("epasswordNew1");

	//Patron para los numeros
	var patron1=new RegExp("[0-9]+");
	//Patron para las letras
	var patron2=new RegExp("[a-zA-Z]+");

	if(pasNew1.value==pasNew2.value && pasNew1.value.length>=6 && pasActual.value!="" && pasNew1.value.search(patron1)>=0 && pasNew1.value.search(patron2)>=0){
		//Todo correcto!!!
		return true;
	}else{
		if(pasNew1.value.length<6)
			id_epassNew.innerHTML="La longitud mínima tiene que ser de 6 caracteres";
		else if(pasNew1.value!=pasNew2.value)
			id_epassNew.innerHTML="La copia de la nueva contraseña con coincide";
		else if(pasNew1.value.search(patron1)<0 || pasNew1.value.search(patron2)<0)
			id_epassNew.innerHTML="La contraseña tiene que tener numeros y letras";
		else
			id_epassNew.innerHTML="";
		if(pasActual.value=="")
			id_epassActual.innerHTML="Indicar tu contraseña actual";
		else
			id_epassActual.innerHTML="";
		return false;
	}
}
-->
</script>


    </head>
    <body>
        <jsp:directive.include file="headerIn.jsp" />
        <%
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

        
        <form name="formName" action="ServicioCambiarClave" method="POST" onsubmit='return validate_password()'>
	<div id="epasswordActual" style="color:#f00;"></div>
	<div>Password Actual: <input type="password" name="passwordActual"/></div>
	<div id="epasswordNew1" style="color:#f00;"></div>
	<div>Nuevo Passowrd: <input type="password" name="passwordNew1"/></div>
	<div>Repite Passowrd: <input type="password" name="passwordNew2"/></div>
	<div><input type="submit" value="enviar"/></div>
</form>
        
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
                <form name="cambioClave" action="ServicioCambiarClave" method="POST" onsubmit='return validarClave()'>
                    <input type="password" id = "epasswordActual" name="claveActual" placeholder="Contraseña Actual">
                    <input type="password" id = "epasswordNew1" name="claveNueva" placeholder="Contraseña Nueva">
                    <input type="password" id = "epasswordNew2" name="claveNuevaRep" placeholder="Repita la contraseña">
                    <input type="submit" id ="ingresar" value="Ingresar">
                </form>
            </div>
        </div>

        <jsp:directive.include file="footer.jsp" />
    </body>
</html>