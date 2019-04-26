/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Control;

import Modelo.GestorGrupos;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author julio
 */
public class ServicioEntrarGrupo extends HttpServlet {

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
            throws ServletException, IOException, SQLException, InstantiationException, ClassNotFoundException, IllegalAccessException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            HttpSession sesion = request.getSession(true);
            String idEstudiante = (String) sesion.getAttribute("usuario");
            
            String idGrupo = request.getParameter("id_grupo");
            
            GestorGrupos gg = GestorGrupos.obtenerInstancia();
            if (gg.verificarCupoMaximoDeGrupo(idGrupo)) {
                gg.inscribirEstudianteEnGrupo(idEstudiante, idGrupo);
            } else {
                request.setAttribute("error", "No se pudo ingresar al grupo seleccionado");
            }
            // response.sendRedirect("formacionGrupo.jsp");
            
        } catch (InstantiationException | ClassNotFoundException | IllegalAccessException ex) {
            Logger.getLogger(ServicioCrearGrupo.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
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
        try {
            processRequest(request, response);
        } catch (SQLException | InstantiationException | ClassNotFoundException | IllegalAccessException ex) {
            Logger.getLogger(ServicioEntrarGrupo.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (SQLException | InstantiationException | ClassNotFoundException | IllegalAccessException ex) {
            Logger.getLogger(ServicioCrearGrupo.class.getName()).log(Level.SEVERE, null, ex);
        }
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