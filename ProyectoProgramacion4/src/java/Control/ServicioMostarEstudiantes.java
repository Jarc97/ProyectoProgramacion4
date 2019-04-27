/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Control;

import Entidades.Estudiante;
import Modelo.GestorEstudiantes;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author Feli
 */
public class ServicioMostarEstudiantes extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            String opc = request.getParameter("selFil");
            try {
                GestorEstudiantes ge = GestorEstudiantes.obtenerInstancia();                
                String estStr = ge.obtenerEstudiantes(opc);
                
                System.out.println("Mostrando por: "+ opc);
                request.setAttribute("opcion", opc);
                request.setAttribute("listaE", ge.obtenerEstudiantes(opc));                
                request.getRequestDispatcher("mostarUsuarios.jsp").forward(request, response);
             
                JSONObject jsonObj = new JSONObject();
                jsonObj.put("reply", estStr);
                out.print(jsonObj);
                out.flush();
                
                
                
            } catch (InstantiationException | ClassNotFoundException | IllegalAccessException ex) {
                Logger.getLogger(ServicioMostarEstudiantes.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
    public String listaProductosJSON() {
        try {
            JSONObject r = new JSONObject();
            JSONArray a = new JSONArray();
            
            GestorEstudiantes g = null;
            try {
                g = GestorEstudiantes.obtenerInstancia();
            } catch (InstantiationException ex) {
                Logger.getLogger(ServicioMostarEstudiantes.class.getName()).log(Level.SEVERE, null, ex);
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(ServicioMostarEstudiantes.class.getName()).log(Level.SEVERE, null, ex);
            } catch (IllegalAccessException ex) {
                Logger.getLogger(ServicioMostarEstudiantes.class.getName()).log(Level.SEVERE, null, ex);
            }
            List<Estudiante> estudiantes = g.listarEstudiantesActivos();
            for (Estudiante p : estudiantes) {
                JSONObject jp = new JSONObject();
                jp.put("id", p.getId());
                jp.put("nrc", p.getNrc());
                jp.put("nombre", p.getNombre());
                jp.put("ultimo_acceso", p.getUltimo_acceso());
                jp.put("grupo", p.getGrupo_id());
                a.put(jp);
            }
            
            r.put("estudiantes", a);
            
            return r.toString(4);
        } catch (SQLException ex) {
            Logger.getLogger(ServicioMostarEstudiantes.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
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
