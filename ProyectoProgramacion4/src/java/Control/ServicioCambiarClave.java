/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Control;

import Modelo.GestorEstudiantes;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Feli
 */
public class ServicioCambiarClave extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String clave = request.getParameter("passwordActual");
        System.out.println("La clave es: "+clave);
        try (PrintWriter out = response.getWriter()){            
            HttpSession sesion = request.getSession(true);
            Object usu = sesion.getAttribute("usuario");
            String id_usuario = usu.toString();
            
            
            response.setContentType("application/json");
            String claveNueva1 = request.getParameter("passwordNew1");  
            String claveNueva2 = request.getParameter("passwordNew2");
            
            GestorEstudiantes ge = GestorEstudiantes.obtenerInstancia();
            if (claveNueva1.equals(claveNueva2)) {
                ge.cambiarClave(id_usuario, claveNueva1); 
                System.out.println("Clave cambiada correctamente");
            }
            else
                System.out.println("Las entradas no coinciden");
            response.sendRedirect("principalEstudiante.jsp");     
        } catch (Exception e) {
            
        }
    }

 /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
