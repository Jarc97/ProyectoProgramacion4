/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelo;

import cr.ac.database.managers.DBManager;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.ListIterator;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Feli
 */
public class GestorGrupos {
    private GestorGrupos()
            throws InstantiationException, ClassNotFoundException, IllegalAccessException {
        bd = DBManager.getDBManager(DBManager.DB_MGR.MYSQL_SERVER);
    }

    public static GestorGrupos obtenerInstancia()
            throws InstantiationException, ClassNotFoundException, IllegalAccessException {
        if (instancia == null) {
            instancia = new GestorGrupos();
        }
        return instancia;
    }
    
    public void crearGrupo(HttpSession sesion)throws SQLException{
        Grupo r = new Grupo();
        String domri = String.format(CMD_AGREGAR_GRUPO, sesion.getAttribute("usuario"));
        try (Connection cnx = bd.getConnection(BASE_DATOS, USUARIO_BD, CLAVE_BD);
                Statement stm = cnx.createStatement();
                ResultSet rs = stm.executeQuery(domri)) {

            while (rs.next()) {
                int id = rs.getInt("id");
                int secuencia = rs.getInt("secuencia");
                String nombre = rs.getString("nombre");
                int cupo = rs.getInt("cupo");
                boolean activo = rs.getBoolean("activo");
                r = new Grupo(id, secuencia, nombre, cupo, activo);
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }
    
    public List<Grupo> listarGrupos(/*HttpSession sesion*/) throws SQLException {
        List<Grupo> r = new ArrayList<>();
//        String domri = String.format(CMD_LISTAR_SOBRANTES, sesion.getAttribute("usuario"));
        try (Connection cnx = bd.getConnection(BASE_DATOS, USUARIO_BD, CLAVE_BD);
                Statement stm = cnx.createStatement();
                ResultSet rs = stm.executeQuery(CMD_LISTAR_GRUPOS)){
                       
            while (rs.next()) {
                int id = rs.getInt("id");
                int secuencia = rs.getInt("secuencia");
                String nombre = rs.getString("nombre");
                int cupo = rs.getInt("cupo");
                boolean activo = rs.getBoolean("activo");
                r.add(new Grupo(id, secuencia, nombre, cupo, activo));
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return r;
    }
    public String mostrarGrupos() {
        try {
            List<Grupo> registros;
            registros = listarGrupos();
            StringBuilder strb = new StringBuilder();

            ListIterator<Grupo> r = registros.listIterator();
            strb.append("<table class=\"tablaGrupos\">\n");
            strb.append("\t<tr>\n");
            strb.append("<th>ID</th>");
            strb.append("<th>Nombre</th>");
            strb.append("</tr>");

            while (r.hasNext()) {
                strb.append(String.format("%s", r.next().toStringAgregados()));
            }
            strb.append("</table>");
            return strb.toString();
        } catch (SQLException e) {
            return e.getMessage();
        }
    }
    
    private DBManager bd = null;
    private static GestorGrupos instancia = null;
    private static final String BASE_DATOS = "eif209_1901_p01"; 
    private static final String USUARIO_BD = "root";
    private static final String CLAVE_BD = "root";
    private static final String CMD_LISTAR_GRUPOS = "SELECT grupo.nombre, estudiante.nombre FROM grupo INNER JOIN estudiante ON grupo.id = estudiante.grupo_id"; 
    private static final String CMD_AGREGAR_GRUPO = "INSERT INTO grupo(id, secuencia, nombre, cupo, activo) VALUES (?,?,?,?,?);"; 

}