package Demo;
import java.util.Iterator;

import jess.*;
public class Codigo {
	 static Rete r = new Rete();
	 String fichero = "casos.clp";
	 String datosApp[] = {"Titulo: ", "Precio: ", "Genero: ", "Tematica: ", "Edad: ", "SO: "};
	 
	//Funcion que añade un usuario a la base de conocimiento y muestra las recomendaciones del susodicho.
	public  String creaUsuario(String nick, int ed, String af,int pr, String disp) throws JessException{
	    try
	      {
	        Value v = r.batch(fichero);
	      } catch (JessException je0) {
	        System.out.println("Error de lectura en " + fichero);
	        je0.printStackTrace();
	      }
	    Fact f = new Fact("usuario", r);
	    ValueVector vv = new ValueVector();
	    String[] list = af.split(" ");
	    for(int i = 0; i< list.length;i++)
	    	vv.add(new Value(list[i], RU.SYMBOL));
	    f.setSlotValue("nick", new Value(nick, RU.SYMBOL));
	    f.setSlotValue("edad", new Value(ed, RU.INTEGER));
	    f.setSlotValue("aficiones", new Value(vv,  RU.LIST));
	    f.setSlotValue("prefPrecio", new Value(pr, RU.INTEGER));
	    f.setSlotValue("dispositivo", new Value(disp, RU.SYMBOL));
	    r.assertFact(f);
	    r.run();
	    return extraeHechos(nick, "MAIN::recomen1");    
	  }
	
	//Funcion que genera una lista de las app disponibles en la memoria.
	public String listaHechos() {
		 try{
			 Value v = r.batch(fichero);
		 }catch (JessException je0) {
			 System.out.println("Error de lectura en " + fichero);
			 je0.printStackTrace();
	     }
		 Iterator<Fact> iterador;
		 iterador = r.listFacts();
		 Fact f;
		 String lista = "";
		 Value ed;
		 while (iterador.hasNext()) {
			 f = iterador.next();
			 if (f.getName().equals("MAIN::app")){
				 try {
					 String carac;
					 String[] as = {};
					 for(int i = 0; i<datosApp.length-1; i++){
						 ed = f.get(i);
						 carac = datosApp[i];
						 String s = ed.toString();
						 as = s.split(" ");
						 lista = lista + carac + as[0]+ "\n";
					 }
					 as = (f.get(datosApp.length-1)).toString().split(" ");
					 lista = lista + datosApp[datosApp.length-1] + as[0] + " ";
					 for(int j = 1; j < as.length; j++){
						 lista = lista + as[j]+ " ";
					 }
					 lista = lista+"\n"+"\n";
				} catch (JessException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			}
		return lista;
	}
	
	
	//Funcion que devuelve una lista con los hechos especificos relacionados con un usuario especifico.
	public static String extraeHechos(String nick, String busqueda) {
		Iterator<Fact> iterador;
		int contador = 0;
		iterador = r.listFacts();
		Fact f;
		String lista = "";
		System.out.println("Lista recomendada de "+nick+": ");
		while (iterador.hasNext()) {
			f = iterador.next();
			if (f.getName().equals(busqueda)){
				try {
					String s = f.get(0).toString();
					if (s.contains(nick)){
						contador++;
						String[] as = s.split(" ");
						lista = lista + as[1]+ "\n";
						System.out.println(as[1]);
					}
				if (contador == 3) return lista;
				} catch (JessException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}		
		}
		return lista;
	}
}
