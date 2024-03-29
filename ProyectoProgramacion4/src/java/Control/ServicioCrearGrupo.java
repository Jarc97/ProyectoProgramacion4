/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Control;

import Modelo.GestorGrupos;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpSession;
import org.apache.tomcat.jni.SSLContext;

/**
 *
 * @author julio
 */
public class ServicioCrearGrupo extends HttpServlet {

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
            
            GestorGrupos gg = GestorGrupos.obtenerInstancia();
            String nombreGrupo = request.getParameter("nombreGrupo");
            if (gg.validarNombreGrupo(nombreGrupo) == false) {
                String formattedErrorString = String.format("El nombre \"%s\" no está disponible.", nombreGrupo);
                request.setAttribute("error", formattedErrorString);
                request.getRequestDispatcher("/formacionGrupo.jsp").forward(request, response);
                return;
            }
            
            int cupoGrupo = 5;
            HttpSession sesion = request.getSession(true);
            String idEstudiante = (String) sesion.getAttribute("usuario");
            
            String idGrupoViejo = gg.buscarGrupoDeEstudiante(idEstudiante);
            gg.crearGrupo(0, nombreGrupo, cupoGrupo);
            String idGrupoNuevo = gg.buscarIdGrupoPorNombre(nombreGrupo);
            gg.inscribirEstudianteEnGrupo(idEstudiante, idGrupoNuevo);
            gg.verificarActividadDeGrupo(idGrupoViejo);
            
            response.sendRedirect("formacionGrupo.jsp");
            
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
        // processRequest(request, response);
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
