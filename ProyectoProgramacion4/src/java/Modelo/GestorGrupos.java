/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelo;

import Entidades.Grupo;
import Entidades.Estudiante;

import cr.ac.database.managers.DBManager;
import java.sql.Connection;
import java.sql.PreparedStatement;
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
    
    public void crearGrupo(long secuencia, String nombre, int cupo)throws SQLException{
        
        try (
            Connection cnx = bd.getConnection(BASE_DATOS, USUARIO_BD, CLAVE_BD);
            PreparedStatement stm = cnx.prepareStatement(CMD_AGREGAR_GRUPO)) {
            
            stm.clearParameters();
            stm.setLong(1, secuencia);
            stm.setString(2, nombre);
            stm.setInt(3, cupo);
            stm.execute();
            
            

        } catch (Exception ex) {
            System.out.println(ex.getMessage());
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
        try{
            StringBuilder strb = new StringBuilder();
            List<Grupo> grupos = listarGrupos();
            ListIterator<Grupo> iterGrupos = grupos.listIterator();
            
            strb.append("<div class='row'>");
            for (int i = 0; i < grupos.size(); i++) {
                
                if (iterGrupos.hasNext()) {
                    
                    Grupo grupo = iterGrupos.next();
                    strb.append("    <div class='col-6'>");
                    strb.append("        <table style='width:100%'>");
                    strb.append("            <tr>");
                    strb.append(String.format("                <th id='tableHeader1' colspan='2'>Grupo %d</th>", grupo.getId()));
                    strb.append("            </tr>");
                    strb.append("            <tr>");
                    strb.append(String.format("                <th id='tableHeader2' colspan='2'>%s</th>", grupo.getNombre()));
                    strb.append("            </tr>");
                    
                    List<Estudiante> estudiantes = listarEstudiantesPorGrupo(grupo.getId());
                    ListIterator<Estudiante> iterEstudiantes = estudiantes.listIterator();

                    while (iterEstudiantes.hasNext()) {
                        Estudiante est = iterEstudiantes.next();
                        strb.append("            <tr>");
                        strb.append(String.format("                <td>%s</td>", est.getNombre()));
                        strb.append(String.format("                <td>%s</td>", est.getApellidos()));
                        strb.append("            </tr>");
                    }
                    strb.append("        </table>");
                    strb.append("    </div>");
                    if (i % 2 == 0) {
                        continue;
                    } else {
                        strb.append("</div>");
                        strb.append("<div class='row'>");
                    }
                }
            }
            strb.append("</div>");
            return strb.toString();
            
        } catch (SQLException e) {
            return e.getMessage();
        }
    }
    
    public List<Estudiante> listarEstudiantesPorGrupo(long idGrupo) {
        List<Estudiante> r = new ArrayList<>();
        String formattedQuery = String.format(CMD_LISTAR_ESTUDIANTES_POR_GRUPO, idGrupo);
        try (
            Connection cnx = bd.getConnection(BASE_DATOS, USUARIO_BD, CLAVE_BD);
            Statement stm = cnx.createStatement();
            ResultSet rs = stm.executeQuery(formattedQuery)) {

            while (rs.next()) {
                String nombre = rs.getString("nombre");
                String apellidos = rs.getString("apellidos");

                r.add(new Estudiante("", 0, apellidos, nombre, 0, "", null, 0));
            }
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        return r;
    }
    
    public void inscribirEstudianteEnGrupo(String idEstudiante, String idGrupo) {
        
        String sql = String.format(CMD_INSCRIBIR_ESTUDIANTE_EN_GRUPO, idGrupo, idEstudiante);
        try (
            Connection cnx = bd.getConnection(BASE_DATOS, USUARIO_BD, CLAVE_BD);
            PreparedStatement stm = cnx.prepareStatement(sql)) {
            stm.execute();
            
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
    }
    
    public boolean verificarEstudianteEnGrupo(String idEstudiante) {
        String formattedQuery = String.format(CMD_VERIFICAR_ESTUDIANTE_EN_GRUPO, idEstudiante);
        try (
            Connection cnx = bd.getConnection(BASE_DATOS, USUARIO_BD, CLAVE_BD);
            Statement stm = cnx.createStatement();
            ResultSet rs = stm.executeQuery(formattedQuery)) {

            while (rs.next()) {
                String nombre = null;
                nombre = rs.getString("nombre");

                if (nombre != null) {
                    return true;
                } else {
                    return false;
                }
            }
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        return false;
    }
    
    public String buscarIdGrupoPorNombre(String nombreGrupo) {
        String formattedQuery = String.format(CMD_BUSCAR_ID_GRUPO_POR_NOMBRE, nombreGrupo);
        try (
            Connection cnx = bd.getConnection(BASE_DATOS, USUARIO_BD, CLAVE_BD);
            Statement stm = cnx.createStatement();
            ResultSet rs = stm.executeQuery(formattedQuery)) {

            while (rs.next()) {
                String id = rs.getString("id");
                return id;
            }
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        return null;
    }
    
    // Para verificar que aun hay miembros en un grupo
    public void verificarActividadEnGrupos() {
        String formattedQuery = String.format(CMD_VERIFICAR_ACTIVIDAD_GRUPOS);
        try (
            Connection cnx = bd.getConnection(BASE_DATOS, USUARIO_BD, CLAVE_BD);
            Statement stm = cnx.createStatement();
            ResultSet rs = stm.executeQuery(formattedQuery)) {

            while (rs.next()) {
                String nombre = rs.getString("nombre");
                System.out.println(nombre);
            }
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
    }
    
    
    
    private DBManager bd = null;
    private static GestorGrupos instancia = null;
    private static final String BASE_DATOS = "eif209_1901_p01"; 
    private static final String USUARIO_BD = "root";
    private static final String CLAVE_BD = "root";
    
    // private static final String CMD_LISTAR_GRUPOS = "SELECT grupo.nombre, estudiante.nombre FROM grupo INNER JOIN estudiante ON grupo.id = estudiante.grupo_id"; 
    private static final String CMD_LISTAR_GRUPOS = "select * from grupo where activo = 1;";
    private static final String CMD_BUSCAR_ID_GRUPO_POR_NOMBRE = "select id from grupo where nombre = '%s';";
    private static final String CMD_AGREGAR_GRUPO = "INSERT INTO grupo(secuencia, nombre, cupo) VALUES (?,?,?);"; 
    
    private static final String CMD_LISTAR_ESTUDIANTES_POR_GRUPO = "select nombre, apellidos from estudiante where grupo_id = %d;";
    private static final String CMD_INSCRIBIR_ESTUDIANTE_EN_GRUPO = "update estudiante set grupo_id = %s where id = '%s';";
    private static final String CMD_VERIFICAR_ESTUDIANTE_EN_GRUPO = "select estudiante.nombre from estudiante, grupo where grupo_id = grupo.id and estudiante.id = %s;";
    private static final String CMD_DESACTIVAR_GRUPO = "update grupo set activo = 0 where nombre = '%s';";
    // private static final String CMD_VERIFICAR_ACTIVIDAD_GRUPOS = "select grupo.nombre from grupo, estudiante where grupo.activo = 1 and estudiante.grupo_id != grupo.id;";
    
    // WIP
    private static final String CMD_VERIFICAR_ACTIVIDAD_GRUPOS = "select grupo.nombre from grupo, estudiante where grupo.activo = 1 and estudiante.grupo_id != grupo.id;";
}