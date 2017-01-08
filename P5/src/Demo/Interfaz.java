package Demo;

import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JFrame;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.JTextField;
import javax.swing.WindowConstants;
import javax.swing.border.TitledBorder;

import jess.JessException;

public class Interfaz extends JFrame{
	Codigo c = new Codigo();
	private String[] sistemas = {"android", "ios", "win"};
	private String[] tematica = {"fantasia", "scifi", "slice", "fantasia scifi", "scifi slice", "fantasia slice", "fantasia scifi slice"};
	private String[] genero = {"rpg", "accion", "plataformas", "rpg accion", "rpg plataformas", "accion plataformas", "rpg accion plataformas"};
	public Interfaz(){
		super("Recomendador de juegos");
		initGUI();
	}
	
	private void initGUI(){
		try{
			setPreferredSize(new Dimension(1000, 600));
			setDefaultCloseOperation(WindowConstants.DISPOSE_ON_CLOSE);
			setVisible(true);
			pack();
			getContentPane().setLayout(new BorderLayout());
			
			//panel para nuevo usuario
			JPanel northUser = new JPanel();
			northUser.setBorder(new TitledBorder("Nuevo Usuario"));
			northUser.setPreferredSize(new Dimension(1000, 110));
			this.add(northUser, BorderLayout.NORTH);
			
			
			//nick del usuario.
			final JTextField uNick = new JTextField();
			uNick.setBorder(new TitledBorder("Nick"));
			northUser.add(uNick);
			uNick.setPreferredSize(new Dimension(150, 40));
			
			//Edad del usuario.
			final JTextField uEdad = new JTextField();
			uEdad.setBorder(new TitledBorder("Edad"));
			uEdad.setPreferredSize(new Dimension(150, 40));
			northUser.add(uEdad);
			
			//Caja donde elegir los generos preferentes del usuario.
			final JComboBox<String> uGenero = new JComboBox<String>(genero);
			uGenero.setBorder(new TitledBorder("Genero(s)"));
			uGenero.setPreferredSize(new Dimension(150, 50));
			northUser.add(uGenero);
			
			//Caja donde elegir las tematicas preferentes del usuario
			final JComboBox<String> uTematica = new JComboBox<String>(tematica);
			uTematica.setBorder(new TitledBorder("Tematica(s)"));
			uTematica.setPreferredSize(new Dimension(150, 50));
			northUser.add(uTematica);
			
			
			//Maxima cantidad de dinero a gastar por el usuario
			final JTextField uPrecio = new JTextField();
			uPrecio.setBorder(new TitledBorder("Precio máx."));
			uPrecio.setPreferredSize(new Dimension(150, 40));
			northUser.add(uPrecio);
			
			//Caja donde elegir el sistema operativo usado por el usuario.
			final JComboBox<String> SOs = new JComboBox<String>(sistemas);
			SOs.setBorder(new TitledBorder("Sistema Operativo"));
			SOs.setPreferredSize(new Dimension(150, 50));
			northUser.add(SOs);
			
			//boton con el cual iniciar la inclusion del usuario a la base de conocimiento y mostrar las recomendaciones resultantes.
			JButton crearUser = new JButton("Buscar");
			crearUser.addActionListener(new ActionListener(){
				public void actionPerformed(ActionEvent e){
					String n = uNick.getText();
					if (n.length() == 0){
						JOptionPane.showMessageDialog(null, "Nombre vacio", "Error en datos de usuario", JOptionPane.ERROR_MESSAGE);
						return;
					}
					System.out.println("nick: " + n);
					int ed = 0;
					try{
						ed = Integer.parseInt(uEdad.getText());
						System.out.println("edad: " + ed);
					}catch(NumberFormatException nfe1){
						JOptionPane.showMessageDialog(null, "Edad no valida", "Error en datos de usuario", JOptionPane.ERROR_MESSAGE);
						return;
					}
					
					String af = uGenero.getSelectedItem().toString() + " " + uTematica.getSelectedItem().toString();
					System.out.println("aficion: " + af);
					
					int pr = 0;
					try{
						pr = Integer.parseInt(uPrecio.getText());
						System.out.println("precio: " + pr);
					}catch(NumberFormatException nfe1){
						JOptionPane.showMessageDialog(null, "Precio no valido", "Error en datos de usuario", JOptionPane.ERROR_MESSAGE);
						return;
					}
					
					String so = SOs.getSelectedItem().toString();
					System.out.println("sistema: " + so);
					try {
						String lista = c.creaUsuario(n,ed,af,pr,so);
						if (lista.length() == 0){
							lista = c.extraeHechos(uNick.getText(), "MAIN::recomen2");
							JOptionPane.showMessageDialog(null,"Lo sentimos, no hay recomendaciones para ti :( \n Esta es una lista de recomendiciones menos especificas: \n"+ lista , "Recomendaciones para " + n, JOptionPane.INFORMATION_MESSAGE);
						}else
							JOptionPane.showMessageDialog(null,lista, "Recomendaciones para " + n, JOptionPane.INFORMATION_MESSAGE);					
					
					} catch (JessException e1) {
						// TODO Auto-generated catch block
						e1.printStackTrace();
					}
					
				}
				
			});
			northUser.add(crearUser);

			
			JTextArea app = new JTextArea(c.listaHechos());
			app.setEditable(false);
			app.setBorder(new TitledBorder("Lista de Apps"));
			JScrollPane barra = new JScrollPane(app);
			
			this.add(barra);
			
			this.setVisible(true);
			
		} catch (Exception e) {
            e.printStackTrace();
        }
	}
}
