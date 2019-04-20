/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelo;

import java.sql.Date;

/**
 *
 * @author Feli
 */
public class Estudiante {

    public Estudiante(String id, int nrc, String apellidos, String nombre, int secuencia, String clave, Date ultimo_acceso, int grupo_id) {
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

    public Date getUltimo_acceso() {
        return ultimo_acceso;
    }

    public void setUltimo_acceso(Date ultimo_acceso) {
        this.ultimo_acceso = ultimo_acceso;
    }

    public int getGrupo_id() {
        return grupo_id;
    }

    public void setGrupo_id(int grupo_id) {
        this.grupo_id = grupo_id;
    }

    @Override
    public String toString() {
        return "Estudiante{" + "id=" + id + ", nrc=" + nrc + ", apellidos=" + apellidos + ", nombre=" + nombre + ", secuencia=" + secuencia + ", clave=" + clave + ", ultimo_acceso=" + ultimo_acceso + ", grupo_id=" + grupo_id + '}';
    }

    private String id;
    private int nrc;
    private String apellidos;
    private String nombre;
    private int secuencia;
    private String clave;
    private Date ultimo_acceso;
    private int grupo_id;
}
