package Demo;
import java.util.Iterator;

import jess.*;
public class Codigo {
	 static Rete r = new Rete();
	 String fichero = "casos.clp";
	 String datosApp[] = {"Titulo: ", "Precio: ", "Genero: ", "Tematica: ", "Edad: ", "SO: "};
	public  String creaUsuario(String nick, int ed, String af,int pr, String disp) throws JessException{
	    try
	      {
	        Value v = r.batch(fichero);
	      } catch (JessException je0) {
	        System.out.println("Error de lectura en " + fichero);
	        je0.printStackTrace();
	      }
	    Deffacts deffacts = new Deffacts(fichero, null, r);
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
	    return extraeHechos(nick);
	    
	  }
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
		 System.out.println("Lista de hechos:");
		 while (iterador.hasNext()) {
			 f = iterador.next();
			 if (f.getName().equals("MAIN::app")){
				 try {
					 String carac;
					 for(int i = 0; i<datosApp.length; i++){
						 ed = f.get(i);
						 carac = datosApp[i];
						 String s = ed.toString();
						 String[] as = s.split(" ");
						 lista = lista + carac + as[0]+ "\n";
					}
					 for(int j = datosApp.length; j < f.size(); j++){
						 ed = f.get(j);
						 String s = ed.toString();
						 String[] as = s.split(" ");
						 lista = lista + as[0]+ " ";
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
	public static String extraeHechos(String nick) {
		// Ejemplo de cómo podemos seleccionar sólo los hechos de la template usuario
		// Y de esos hechos quedarnos sólo con el slot edad e imprimir su valor
		Iterator<Fact> iterador;
		iterador = r.listFacts();
		Fact f;
		String lista = "";
		Value ed;
		System.out.println("Lista recomendada de "+nick+": ");
		while (iterador.hasNext()) {
		f = iterador.next();
		if (f.getName().equals("MAIN::recomen1")){
			try {
				ed = f.get(0);
				String s = ed.toString();
				if (s.contains(nick)){
					String[] as = s.split(" ");
					lista = lista + as[1]+ "\n";
					System.out.println(as[1]);
				}
			} catch (JessException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 
		}
			}
		return lista;
		}

}
