/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelo;

import cr.ac.database.managers.DBManager;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Feli
 */
public class GestorEstudiantes {
    

    private GestorEstudiantes()
            throws InstantiationException, ClassNotFoundException, IllegalAccessException {
        bd = DBManager.getDBManager(DBManager.DB_MGR.MYSQL_SERVER);
    }

    public static GestorEstudiantes obtenerInstancia()
            throws InstantiationException, ClassNotFoundException, IllegalAccessException {
        if (instancia == null) {
            instancia = new GestorEstudiantes();
        }
        return instancia;
    }

    public boolean verificarUsuario(String id, String clave) {
        boolean encontrado = false;
        try {
            Connection cnx = bd.getConnection(BASE_DATOS, USUARIO_BD, CLAVE_BD);
            try (PreparedStatement stm = cnx.prepareStatement(CMD_VERIFICAR)) {
                stm.clearParameters();
                stm.setString(1, id);
                stm.setString(2, clave);
                ResultSet rs = stm.executeQuery();
                encontrado = rs.next();
            }
        } catch (SQLException ex) {
            ex.printStackTrace(System.err);
        } finally {
            if (bd != null) {
                bd.closeConnection();
            }
        }
        return encontrado;
    }
    public String obtenerEstudiante(HttpSession session) {
        StringBuilder r = new StringBuilder();
        try {
            Estudiante registros = listarInformacionPersonal(session);
            r.append(registros.toString());
        } catch (SQLException ex) {
            r.append(String.format(
                    "<tr><td>(Excepción: '%s')</td></tr>", ex.getMessage()));
        }
        return r.toString();
    }
    
    public Estudiante listarInformacionPersonal(HttpSession session) throws SQLException {
        Estudiante e;
        try (Connection cnx = bd.getConnection(BASE_DATOS, USUARIO_BD, CLAVE_BD);
                PreparedStatement stm = cnx.prepareStatement(CMD_RECUPERAR)) {
            Object objeto = session.getAttribute("usuario");
            String idEst = objeto.toString();
            
            stm.clearParameters();
            
            stm.setString(1, idEst);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    return e = new Estudiante(rs.getString("id"), rs.getInt("nrc"), rs.getString("apellidos"), rs.getString("nombre"), rs.getInt("secuencia"), rs.getString("clave"), rs.getDate("ultimo_acceso"), rs.getInt("grupo_id"));
                } 
            }
            return null;
        }
    }
    
    public String obtenerNombre(HttpSession session) {
        StringBuilder r = new StringBuilder();
        try {
            String registros = listarNombre(session);
            StringBuilder append = r.append(registros);
        } catch (SQLException ex) {
            r.append(String.format(
                    "<tr><td>(Excepción: '%s')</td></tr>", ex.getMessage()));
        }
        return r.toString();
    }
     public String listarNombre(HttpSession session) throws SQLException {
        String e;
        try (Connection cnx = bd.getConnection(BASE_DATOS, USUARIO_BD, CLAVE_BD);
                PreparedStatement stm = cnx.prepareStatement(CMD_RECUPERAR_NOMBRE)) {
            Object objeto = session.getAttribute("usuario");
            String idEst = objeto.toString();
            
            stm.clearParameters();
            
            stm.setString(1, idEst);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    return e =  rs.getString("nombre")+ " "+ rs.getString("apellidos");
                } 
            }
            return null;
        }
    }
     
    public void cambiarClave(String id, String claveActual, String claveNueva) throws SQLException {
        try {
            if (verificarUsuario(id, claveActual)) {
                try (Connection cnx = bd.getConnection(BASE_DATOS, USUARIO_BD, CLAVE_BD);
                        PreparedStatement stm = cnx.prepareStatement(CMD_CAMBIAR_CLAVE)) {
                    stm.clearParameters();
                    stm.setString(1, claveNueva);
                    stm.setString(2, id);
                    stm.execute();
                } catch (Exception ex) {
                    System.out.println("Error");
                }
            }
        } catch (Exception e) {
            System.out.println("Error");
        }

    }
    
    private DBManager bd = null;
    private static GestorEstudiantes instancia = null;
    private static final String BASE_DATOS = "eif209_1901_p01"; 
    private static final String USUARIO_BD = "root";
    private static final String CLAVE_BD = "root";
    private static final String CMD_VERIFICAR = "SELECT id FROM estudiante WHERE id = ? AND clave = ?;";
    private static final String CMD_RECUPERAR = "SELECT id, nrc, apellidos, nombre, secuencia, clave, ultimo_acceso, grupo_id FROM estudiante WHERE id=?; ";
    private static final String CMD_RECUPERAR_NOMBRE = "SELECT apellidos, nombre FROM estudiante WHERE id=?; ";
    private static final String CMD_CAMBIAR_CLAVE = "UPDATE estudiante SET clave = ? WHERE id=?; ";
}
