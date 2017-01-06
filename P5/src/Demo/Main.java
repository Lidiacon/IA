package Demo;

import java.io.IOException;
import java.util.Scanner;

import jess.JessException;


public class Main {
	public static void main(String[] args) {
		Interfaz i = new Interfaz();
	    Codigo c = new Codigo();
	    try {
	    	Scanner sn = new Scanner(System.in);
	    	System.out.println("Introduzca nombre de usuario");
	    	String nick = sn.next();
	    	System.out.println("Introduzca edad del usuario");
	    	int ed = sn.nextInt();
	    	System.out.println("Introduzca aficion de usuario");
	    	String af = sn.next();
	    	System.out.println("Introduzca capacidad adquisitiva de usuario");
	    	int pr = sn.nextInt();
	    	System.out.println("Introduzca dispositivo de usuario");
	    	String disp = sn.next();
	      c.creaUsuario(nick,ed,af,pr,disp);
	    } catch (JessException e) {
	      e.printStackTrace();
	    }
	  }
}
