package tipos;

import java.sql.Date;

public class Producto {

	private String nombre;
	private double precioCompra, precioVenta;
	private Date fechaCaducidad;
	private String tipo;
	
	public Producto(String nombre, Date fechaCaducidad, String tipo, double precioCompra, double precioVenta) {
		this.nombre = nombre;
		this.fechaCaducidad = fechaCaducidad;
		this.tipo = tipo;
		this.precioCompra = precioCompra;
		this.precioVenta = precioVenta;
	}
	
	public Producto(String nombre, Date fechaCaducidad, String tipo, double precioCompra) {
		this.nombre = nombre;
		this.fechaCaducidad = fechaCaducidad;
		this.tipo = tipo;
		this.precioCompra = precioCompra;
	}
	
	public Producto(String nombre) {
		this.nombre = nombre;
	}
	
	public Producto()
	{
		this.nombre="DEFAULT";
	}
	
	public String getNombre() {
		return this.nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public double getPrecioCompra() {
		return this.precioCompra;
	}
	public void setPrecioCompra(double precioCompra) {
		this.precioCompra = precioCompra;
	}
	public double getPrecioVenta() {
		return this.precioVenta;
	}
	public void setPrecioVenta(double precioVenta) {
		this.precioVenta = precioVenta;
	}
	public Date getFechaCaducidad() {
		return this.fechaCaducidad;
	}
	public void setFechaCaducidad(Date fechaCaducidad) {
		this.fechaCaducidad = fechaCaducidad;
	}
	public String getTipo() {
		return this.tipo;
	}
	public void setTipo(String tipo) {
		this.tipo = tipo;
	}
	
	@Override
	public String toString() {
		return " - " + this.nombre + " x " + this.precioVenta + "�";
	}
	
}
