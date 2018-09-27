package com.ipartek.formacion.youtube.pojo;

public class Video {

	public static final int ID_LONGITUD = 11;

	private long id;
	private String codigo;
	private String nombre;

	public Video() throws Exception {
		super();
		this.id = -1;
		this.setCodigo("YlUKcNNmywk");
		this.nombre = "Red Hot Chili Peppers - Californication";
	}

	public Video(String codigo, String nombre) throws Exception {
		this();
		this.setCodigo(codigo);
		this.nombre = nombre;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getCodigo() {
		return this.codigo;
	}

	public void setCodigo(String cod) throws Exception {
		if (cod != null && cod.length() == ID_LONGITUD) {
			this.codigo = cod;
		} else {
			throw new Exception("El ID debe ser exactamente de " + ID_LONGITUD + " caracteres");
		}
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

}
