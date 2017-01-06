package Demo;
import java.util.Iterator;

import jess.*;
public class Codigo {
	public void creaUsuario(String nick, int ed, String af,int pr, String disp) throws JessException{
	    Rete r = new Rete();
	    String fichero = "casos.clp";
	    try
	      {
	        Value v = r.batch(fichero);
	        System.out.println("Value " + v);
	      } catch (JessException je0) {
	        System.out.println("Error de lectura en " + fichero);
	        je0.printStackTrace();
	      }
	    Deffacts deffacts = new Deffacts(fichero, null, r);
	    Fact f = new Fact("usuario", r);
	    f.setSlotValue("nick", new Value(nick, RU.SYMBOL));
	    f.setSlotValue("edad", new Value(ed, RU.INTEGER));
	    f.setSlotValue("aficiones", new Value(af, RU.SYMBOL));
	    f.setSlotValue("prefPrecio", new Value(pr, RU.INTEGER));
	    f.setSlotValue("dispositivo", new Value(disp, RU.SYMBOL));
	    r.assertFact(f);
	    r.run();
	    extraeHechos(r,nick);
	  }
	public static void listaHechos(Rete miRete) {
		@SuppressWarnings("unchecked")
		Iterator<Fact> iterador = miRete.listFacts();
		System.out.println("Lista de hechos:");
		while (iterador.hasNext()) {
			System.out.println(iterador.next());
		}
		}
	public static void extraeHechos(Rete miRete, String nick) {
		// Ejemplo de cómo podemos seleccionar sólo los hechos de la template usuario
		// Y de esos hechos quedarnos sólo con el slot edad e imprimir su valor
		Iterator<Fact> iterador;
		iterador = miRete.listFacts();
		Fact f;
		Value ed;
		System.out.println("Lista recomendada de "+nick+": ");
		while (iterador.hasNext()) {
		f = iterador.next();
		if (f.getName().equals("MAIN::recomen3")){
			try {
				ed = f.get(0);
				String s = ed.toString();
				if (s.contains(nick)){
					String[] as = s.split(" ");
					System.out.println(as[1]);
				}
			} catch (JessException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 
		}
			}
		}

}
