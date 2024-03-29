/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelo;

import Entidades.Estudiante;
import cr.ac.database.managers.DBManager;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.ListIterator;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Feli
 */
public class GestorEstudiantes implements Serializable {

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

    public ArrayList<Object[]> obtenerLista() {
        ArrayList<Object[]> estudiantes = new ArrayList<>();

        // Abre una conexión a la base de datos y carga la lista de usuarios.
        try {

            Connection cnx = bd.getConnection(BASE_DATOS, USUARIO_BD, CLAVE_BD);

            Statement stm = cnx.createStatement();
            ResultSet rs = stm.executeQuery(CMD_LISTAR_ESTUDIANTES);
            int maxCols = rs.getMetaData().getColumnCount();
            while (rs.next()) {
                Object[] registro = new Object[maxCols];
                for (int i = 0; i < maxCols; i++) {
                    registro[i] = rs.getObject(i + 1);
                }
                estudiantes.add(registro);
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        } finally {
            bd.closeConnection();
        }

        return estudiantes;
    }

    public static String listaUsuariosHTML(GestorEstudiantes g) {
        StringBuilder r = new StringBuilder();
        ArrayList<Object[]> usuarios = g.obtenerLista();
        if (usuarios.size() > 0) {
            for (Object[] registro : usuarios) {
                r.append("<tr>");
                for (Object e : registro) {
                    r.append("<td>");
                    if (e != null) {
                        r.append(e.toString());
                    } else {
                        r.append("(null)");
                    }
                    r.append("</td>");
                }
                r.append("</tr>");
            }
        } else {
            r.append("<tr><td colspan=\"5\">(No hay registros en la base de datos.)</td></tr>");
        }

        return r.toString();
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
                    return e = new Estudiante(rs.getString("id"), rs.getInt("nrc"), rs.getString("apellidos"), rs.getString("nombre"), rs.getInt("secuencia"), rs.getString("clave"), rs.getTimestamp("ultimo_acceso"), rs.getInt("grupo_id"));
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
                    return e = rs.getString("nombre") + " " + rs.getString("apellidos");
                }
            }
            return null;
        }
    }

    public void cambiarClave(String id, String claveNueva) throws SQLException {
        try {

            try (Connection cnx = bd.getConnection(BASE_DATOS, USUARIO_BD, CLAVE_BD);
                    PreparedStatement stm = cnx.prepareStatement(CMD_CAMBIAR_CLAVE)) {
                stm.clearParameters();
                stm.setString(1, claveNueva);
                stm.setString(2, id);
                stm.executeUpdate();
            } catch (Exception ex) {
                System.out.println(ex);
            }

        } catch (Exception e) {
            System.out.println("Error");
        }
    }

    public void cambiarEstadoActividad(String id) throws SQLException {
        try (Connection cnx = bd.getConnection(BASE_DATOS, USUARIO_BD, CLAVE_BD);
                PreparedStatement stm = cnx.prepareStatement(CMD_CAMBIAR_ACTIVIDAD)) {
            stm.clearParameters();
            Timestamp fecha = new Timestamp(System.currentTimeMillis());
            stm.setTimestamp(1, fecha);
            stm.setString(2, id);
            stm.execute();
        } catch (Exception ex) {
            System.out.println("Error");
        }
    }

    public String obtenerEstudiantesActivos(String condicion) {
        try {
            List<Estudiante> registros;
            registros = listarEstudiantesActivos(condicion);
            StringBuilder strb = new StringBuilder();

            ListIterator<Estudiante> r = registros.listIterator();
            strb.append("<table class=\"totalEstudiantes\">\n");
            strb.append("\t<tr>\n");
            strb.append("<th>Id</th>");
            strb.append("<th>Nrc</th>");
            strb.append("<th>Nombre</th>");
            strb.append("<th>Ultimo acceso</th>");
            strb.append("<th>Grupo</th>");
            strb.append("</tr>");

            while (r.hasNext()) {
                strb.append(String.format("%s", r.next().toStringActivos()));
            }
            strb.append("</table>");
            return strb.toString();
        } catch (SQLException e) {
            return e.getMessage();
        }
    }

    public List<Estudiante> listarEstudiantesActivos(String condicion) throws SQLException {
        List<Estudiante> r = new ArrayList<>();
        try (Connection cnx = bd.getConnection(BASE_DATOS, USUARIO_BD, CLAVE_BD);
                Statement stm = cnx.createStatement();
                ResultSet rs = stm.executeQuery(CMD_LISTAR_ESTUDIANTES + condicion(condicion))) {

            while (rs.next()) {
                String id = rs.getString("id");
                int nrc = rs.getInt("nrc");
                String apellidos = rs.getString("apellidos");
                String nombre = rs.getString("nombre");
                int secuencia = rs.getInt("secuencia");
                String clave = rs.getString("clave");
                Timestamp ultimo_acceso = rs.getTimestamp("ultimo_acceso");
                int grupo_id = rs.getInt("grupo_id");

                r.add(new Estudiante(id, nrc, apellidos,
                        nombre, secuencia, clave, ultimo_acceso, grupo_id));
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return r;
    }

    public List<Estudiante> listarEstudiantes() throws SQLException {
        List<Estudiante> r = new ArrayList<>();
        try (Connection cnx = bd.getConnection(BASE_DATOS, USUARIO_BD, CLAVE_BD);
                Statement stm = cnx.createStatement();
                ResultSet rs = stm.executeQuery(CMD_LISTAR_ESTUDIANTES)) {

            while (rs.next()) {
                String id = rs.getString("id");
                int nrc = rs.getInt("nrc");
                String apellidos = rs.getString("apellidos");
                String nombre = rs.getString("nombre");
                int secuencia = rs.getInt("secuencia");
                String clave = rs.getString("clave");
                Timestamp ultimo_acceso = rs.getTimestamp("ultimo_acceso");
                int grupo_id = rs.getInt("grupo_id");

                r.add(new Estudiante(id, nrc, apellidos,
                        nombre, secuencia, clave, ultimo_acceso, grupo_id));
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return r;
    }

    public String condicion(String cond) {
        String resultado = "";
        if (null != cond) {
            switch (cond) {
                case "grupoTrabajo":
                    resultado = CMD_ORDER_BY_GRUP_TRAB;
                    break;
                case "grupoMatriculado":
                    resultado = CMD_ORDER_BY_GRUP_MAT;
                    break;
                case "numeroId":
                    resultado = CMD_ORDER_BY_ID;
                    break;
                case "apellidosNombre":
                    resultado = CMD_ORDER_BY_APEL_NOMB;
                    break;
                case "ultimoAcceso":
                    resultado = CMD_ORDER_BY_ULT_ACC;
                    break;
                case "porDefecto":
                    resultado = ";";
                    break;
                default:
                    break;
            }
        }
        return resultado;
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
    private static final String CMD_LISTAR_ESTUDIANTES = "SELECT id, nrc, apellidos, nombre, secuencia, clave, ultimo_acceso, grupo_id FROM estudiante ";
    private static final String CMD_ORDER_BY_GRUP_TRAB = "ORDER BY 8 DESC;";
    private static final String CMD_ORDER_BY_GRUP_MAT = "ORDER BY 2;";
    private static final String CMD_ORDER_BY_ID = "ORDER BY 1;";
    private static final String CMD_ORDER_BY_APEL_NOMB = "ORDER BY 3, 4;";
    private static final String CMD_ORDER_BY_ULT_ACC = "ORDER BY 7 DESC;";
    private static final String CMD_CAMBIAR_ACTIVIDAD = "UPDATE estudiante SET ultimo_acceso = ? WHERE id=?; ";
}
