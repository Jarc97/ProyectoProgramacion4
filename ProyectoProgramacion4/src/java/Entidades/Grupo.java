/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Entidades;

/**
 *
 * @author Feli
 */
public class Grupo {

    public Grupo() {
    }

    public Grupo(int id, int secuencia, String nombre, int cupo, boolean activo) {
        this.id = id;
        this.secuencia = secuencia;
        this.nombre = nombre;
        this.cupo = cupo;
        this.activo = activo;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getSecuencia() {
        return secuencia;
    }

    public void setSecuencia(int secuencia) {
        this.secuencia = secuencia;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public int getCupo() {
        return cupo;
    }

    public void setCupo(int cupo) {
        this.cupo = cupo;
    }

    public boolean isActivo() {
        return activo;
    }

    public void setActivo(boolean activo) {
        this.activo = activo;
    }

    @Override
    public String toString() {
        return "Grupo{" + "id=" + id + ", secuencia=" + secuencia + ", nombre=" + nombre + ", cupo=" + cupo + ", activo=" + activo + '}';
    }
    
        public String toStringAgregados() {
        StringBuilder strb = new StringBuilder();
        strb.append("<tr><td>");strb.append(Integer.toString(id));strb.append("</td>");
        strb.append("<td>"); strb.append(nombre);strb.append("</td>");
        strb.append("</td>");
      return strb.toString();
    }
        
    public String toStringHTML() {
        return "";
    }
        
    private int id;
    private int secuencia;
    private String nombre;
    private int cupo;
    private boolean activo;
}
