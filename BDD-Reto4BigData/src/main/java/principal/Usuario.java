package principal;

public class Usuario {
	
	private String nombre;
	private String local;
	private String tipoLocal;
	private String nifLocal;
	
	public Usuario (String nombre, String local, String tipoLocal, String nifLocal) {
		this.nombre = nombre;
		this.local = local;
		this.tipoLocal = tipoLocal;
		this.nifLocal = nifLocal;
	}
	
	public String getNombre() {
		return this.nombre;
	}
	
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	
	public String getLocal() {
		return this.local;
	}
	
	public void setLocal(String local) {
		this.local = local;
	}
	
	public String getTipoLocal() {
		return this.tipoLocal;
	}
	
	public void setTipoLocal(String tipoLocal) {
		this.tipoLocal = tipoLocal;
	}

	public String getNifLocal() {
		return this.nifLocal;
	}

	public void setNifLocal(String nifLocal) {
		this.nifLocal = nifLocal;
	}

}
