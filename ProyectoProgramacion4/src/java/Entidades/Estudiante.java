/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Entidades;

import java.sql.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

/**
 *
 * @author Feli
 */
public class Estudiante {

    public Estudiante(String id, int nrc, String apellidos, String nombre, int secuencia, String clave, Timestamp ultimo_acceso, int grupo_id) {
        this.id = id;
        this.nrc = nrc;
        this.apellidos = apellidos;
        this.nombre = nombre;
        this.secuencia = secuencia;
        this.clave = clave;
        this.ultimo_acceso = ultimo_acceso;
        this.grupo_id = grupo_id;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public int getNrc() {
        return nrc;
    }

    public void setNrc(int nrc) {
        this.nrc = nrc;
    }

    public String getApellidos() {
        return apellidos;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public int getSecuencia() {
        return secuencia;
    }

    public void setSecuencia(int secuencia) {
        this.secuencia = secuencia;
    }

    public String getClave() {
        return clave;
    }

    public void setClave(String clave) {
        this.clave = clave;
    }

    public Timestamp getUltimo_acceso() {
        return ultimo_acceso;
    }

    public void setUltimo_acceso(Timestamp ultimo_acceso) {
        this.ultimo_acceso = ultimo_acceso;
    }

    public int getGrupo_id() {
        return grupo_id;
    }

    public void setGrupo_id(int grupo_id) {
        this.grupo_id = grupo_id;
    }

    public String timestampToString(Timestamp ult_acc) {
        String formattedDate = new SimpleDateFormat("HH:mm:ss dd/MM/yyyy").format(ult_acc);
        return formattedDate;
    }
    
    public String estaActivo(Timestamp ult_acc){
        String activo;
        activo = (ult_acc == null) ? "<span style=\"color:red;\"><strong>Inactivo</strong></span>" 
                : "<span style=\"color:green;\"><strong>"+timestampToString(ultimo_acceso)+"</strong></span>";        
        return activo;
    }
    
    public String grupoEscogido(int grupo_id){
        String escogido;
        escogido = (grupo_id == 0)  ?  "<span style=\"color:red;\"><strong>Sin grupo</strong></span>" 
                : "<span style=\"color:green;\"><strong>Grupo "+Integer.toString(grupo_id)+"</strong></span>";
        return escogido;
    }
    
    @Override
    public String toString() {
        StringBuilder strb = new StringBuilder();
        strb.append("<br> ID: <strong>");strb.append(id);strb.append("</strong></br>");        
        strb.append("<br> NRC del curso matriculado: <strong>");strb.append(Integer.toString(nrc));strb.append("</strong></br>");
        strb.append("<br> Nombre: <strong>");strb.append(nombre);strb.append("</strong></br>");
        strb.append("<br> Apellidos: <strong>");strb.append(apellidos);strb.append("</strong></br><br></br>");

        return strb.toString() + "\n" + "Estudiante: " + "id=" + id + ", nrc=" + nrc + ", apellidos=" + apellidos + ", nombre=" + nombre + ", secuencia=" + secuencia + ", clave=" + clave + ", ultimo_acceso=" + ultimo_acceso + ", grupo_id=" + grupo_id;
    }

    public String toStringActivos() {
        StringBuilder strb = new StringBuilder();
        strb.append("<tr><td>");strb.append(id);strb.append("</td>");
        strb.append("<td>");strb.append(Integer.toString(nrc));
        strb.append("<td>");strb.append(nombre);strb.append(" ");strb.append(apellidos);strb.append("</td>");
        strb.append("<td>");strb.append(estaActivo(ultimo_acceso));strb.append("</td>");
        strb.append("<td>");strb.append(grupoEscogido(grupo_id));strb.append("</tr></td>");
        
        return strb.toString();
    }

    private String id;
    private int nrc;
    private String apellidos;
    private String nombre;
    private int secuencia;
    private String clave;
    private Timestamp ultimo_acceso;
    private int grupo_id;
}
