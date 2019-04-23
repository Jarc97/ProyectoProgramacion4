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
    
    public void crearGrupo(long id, long secuencia, String nombre, int cupo, boolean activo)throws SQLException{
        
        try (
            Connection cnx = bd.getConnection(BASE_DATOS, USUARIO_BD, CLAVE_BD);
            PreparedStatement stm = cnx.prepareStatement(CMD_AGREGAR_GRUPO)) {
            
            stm.clearParameters();
            stm.setLong(1, id);
            stm.setLong(2, secuencia);
            stm.setString(3, nombre);
            stm.setInt(4, cupo);
            stm.setBoolean(5, activo);
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
        try {
            
            StringBuilder strb = new StringBuilder();
            List<Grupo> grupos = listarGrupos();
            ListIterator<Grupo> iterGrupos = grupos.listIterator();
            
            while (iterGrupos.hasNext()) {
                strb.append("<div class='row'>");
                
                if (iterGrupos.hasNext()) {
                    Grupo grupo = iterGrupos.next();
                    List<Estudiante> estudiantes = listarEstudiantesPorGrupo(grupo.getId());
                    ListIterator<Estudiante> iterEstudiantes = estudiantes.listIterator();
                    strb.append("    <div class='col-6'>");
                    strb.append("        <table style='width:100%'>");
                    strb.append("            <tr>");
                    //strb.append("                <th id='tableHeader1' colspan='2'>Grupo 1</th>");
                    strb.append(String.format("                <th id='tableHeader1' colspan='2'>Grupo %d</th>", grupo.getId()));
                    strb.append("            </tr>");
                    strb.append("            <tr>");
                    // strb.append("                <th id='tableHeader2' colspan='2'>Los mejores</th>");
                    strb.append(String.format("                <th id='tableHeader2' colspan='2'>%s</th>", grupo.getNombre()));
                    strb.append("            </tr>");

                    if (iterGrupos.hasNext()) {
                        while (iterEstudiantes.hasNext()) {
                            if (iterEstudiantes.hasNext()) {
                                Estudiante est = iterEstudiantes.next();
                                strb.append("            <tr>");
                                strb.append(String.format("                <td>%s</td>", est.getNombre()));
                                strb.append(String.format("                <td>%s</td>", est.getApellidos()));
                                strb.append("            </tr>");
                            }
                        }
                    }
                    strb.append("        </table>");
                    strb.append("    </div>");
                }
                
                
                if (iterGrupos.hasNext()) {
                    Grupo grupo2 = iterGrupos.next();
                    List<Estudiante> estudiantes2 = listarEstudiantesPorGrupo(grupo2.getId());
                    ListIterator<Estudiante> iterEstudiantes2 = estudiantes2.listIterator();
                    strb.append("    <div class='col-6'>");
                    strb.append("        <table style='width:100%'>");
                    strb.append("            <tr>");
                    // strb.append("                <th id='tableHeader1' colspan='2'>Grupo 1</th>");
                    strb.append(String.format("                <th id='tableHeader1' colspan='2'>Grupo %d</th>", grupo2.getId()));
                    strb.append("            </tr>");
                    strb.append("            <tr>");
                    // strb.append("                <th id='tableHeader2' colspan='2'>Los mejores</th>");
                    strb.append(String.format("                <th id='tableHeader2' colspan='2'>%s</th>", grupo2.getNombre()));
                    strb.append("            </tr>");

                    if (iterGrupos.hasNext()) {
                        while (iterEstudiantes2.hasNext()) {
                            if (iterEstudiantes2.hasNext()) {
                                Estudiante est = iterEstudiantes2.next();
                                strb.append("            <tr>");
                                strb.append(String.format("                <td>%s</td>", est.getNombre()));
                                strb.append(String.format("                <td>%s</td>", est.getApellidos()));
                                strb.append("            </tr>");
                            }
                        }
                    }
                    strb.append("        </table>");
                    strb.append("    </div>");
                }
                strb.append("</div>");
            }
            
            System.out.println(strb.toString());
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
    
    
    
    private DBManager bd = null;
    private static GestorGrupos instancia = null;
    private static final String BASE_DATOS = "eif209_1901_p01"; 
    private static final String USUARIO_BD = "root";
    private static final String CLAVE_BD = "root";
    // private static final String CMD_LISTAR_GRUPOS = "SELECT grupo.nombre, estudiante.nombre FROM grupo INNER JOIN estudiante ON grupo.id = estudiante.grupo_id"; 
    private static final String CMD_LISTAR_GRUPOS = "select * from grupo;";
    private static final String CMD_AGREGAR_GRUPO = "INSERT INTO grupo(id, secuencia, nombre, cupo, activo) VALUES (?,?,?,?,?);"; 
    
    private static final String CMD_LISTAR_ESTUDIANTES_POR_GRUPO = "select nombre, apellidos from estudiante where grupo_id = %d;";
}