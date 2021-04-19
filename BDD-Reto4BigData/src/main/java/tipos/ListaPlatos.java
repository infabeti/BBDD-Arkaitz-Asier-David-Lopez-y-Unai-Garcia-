package tipos;

import java.util.ArrayList;

public class ListaPlatos {
	
	private ArrayList<Plato> listaP;
	
	public ListaPlatos() {
		listaP  = new ArrayList<Plato>();
	}
	
	public ArrayList<Plato> getListaP() {
		return listaP;
	}

	public boolean addPlato(Plato plat) {
		try {
			listaP.add(plat);
			return true;
		}
		catch(Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public boolean limpiarLista() {
		try {
			listaP.clear();
			return true;
		}
		catch(Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public boolean eliminarPlato(int pos) {
		try {
			listaP.remove(pos);
			return true;
		}
		catch(Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public Plato cogerPlato(int pos) {
		return listaP.get(pos);
	}
	
	public double getPrecioPlato(int pos) {
		return cogerPlato(pos).getPrecio();
	}
	
	public String[] getListaPlatosString() {
		String listaPlatosString[] = new String[listaP.size()];
		
		for(int i = 0; i < listaP.size(); i++) {
			listaPlatosString[i] = listaP.get(i).getNombre();
		}
		
		return listaPlatosString;
	}
	
	public Plato devolverPlatoPorString(String nombre) {
		for (int i = 0; i < listaP.size(); i++) {
			if(listaP.get(i).getNombre().equalsIgnoreCase(nombre)) {
				return listaP.get(i);
			}
		}
		return null;
	}
	
	public int devolverPosPlatoString(String nombre) { //Devuelve la posición de un producto dado su string
		for(int i = 0; i <listaP.size(); i++) {
			if(listaP.get(i).getNombre() == nombre) {
				return i;
			}
		}
		return -1;
	}
	
	public double precioProductoString(String nombre) {
		Plato plat = this.devolverPlatoPorString(nombre);
		if(plat != null) {
			return plat.getPrecio();
		}
		else {
			return -1;
		}
	}
	
}
