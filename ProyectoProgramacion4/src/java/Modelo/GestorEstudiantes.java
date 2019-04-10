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
                    return e = new Estudiante(rs.getString("id"), rs.getString("nombre"), rs.getString("apellido1"), rs.getString("apellido2"), rs.getString("clave"));
                } 
            }
            return null;
        }
    }
    
    private DBManager bd = null;
    private static GestorEstudiantes instancia = null;
    private static final String BASE_DATOS = "bd_grupos";
    private static final String USUARIO_BD = "root";
    private static final String CLAVE_BD = "root";
    private static final String CMD_VERIFICAR
            = "select id from estudiante "
            + "where id = ? and clave = ?;";
 private static final String CMD_RECUPERAR = "SELECT id, apellido1, apellido2, nombre, email, telefono, direccion FROM estudiante WHERE id=?; ";
}
