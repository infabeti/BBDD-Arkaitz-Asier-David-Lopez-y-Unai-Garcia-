package tipos;

import java.util.ArrayList;

public class ListaProductos {
	
	private ArrayList<Producto> listaProd; 
	
	public ListaProductos() {
		listaProd  = new ArrayList<Producto>();
	}
	
	public boolean addProducto(Producto prod) {
		try {
			listaProd.add(prod);
			return true;
		}
		catch(Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public boolean limpiarLista() {
		try {
			listaProd.clear();
			return true;
		}
		catch(Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public boolean eliminarProducto(int pos) {
		try {
			listaProd.remove(pos);
			return true;
		}
		catch(Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public Producto cogerProducto(int pos) {
		return listaProd.get(pos);
	}
	
	public double getPrecioProducto(int pos) {
		return cogerProducto(pos).getPrecioVenta();
	}
	
	public String[] getListaProductosString() {
		String listaProductosString[] = new String[listaProd.size()];
		
		for(int i = 0; i < listaProd.size(); i++) {
			listaProductosString[i] = listaProd.get(i).getNombre();
		}
		
		return listaProductosString;
	}
	
	public Producto devolverProductoPorString(String nombre) {
		for (int i = 0; i < listaProd.size(); i++) {
			if(listaProd.get(i).getNombre() == nombre) {
				return listaProd.get(i);
			}
		}
		return null;
	}
	
	public int devolverPosProductoString(String nombre) { //Devuelve la posición de un producto dado su string
		for(int i = 0; i <listaProd.size(); i++) {
			if(listaProd.get(i).getNombre() == nombre) {
				return i;
			}
		}
		return -1;
	}
	
	public double precioProductoString(String nombre) {
		Producto prod = this.devolverProductoPorString(nombre);
		if(prod != null) {
			return prod.getPrecioVenta();
		}
		else {
			return -1;
		}
	}
}
