package Demo;

import java.awt.BorderLayout;
import java.awt.Component;
import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.Panel;
import java.awt.BorderLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JFrame;
import javax.swing.JMenuBar;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JTextField;
import javax.swing.WindowConstants;
import javax.swing.border.TitledBorder;

public class Interfaz extends JFrame{
	public Interfaz(){
		super("Ventana base");
		initGUI();
	}
	
	private void initGUI(){
		try{
			setPreferredSize(new Dimension(600, 600));
			setDefaultCloseOperation(WindowConstants.DISPOSE_ON_CLOSE);
			setVisible(true);
			pack();
			getContentPane().setLayout(new BorderLayout());
			
			//parte de arriba (datos usuario)
			JPanel north = new JPanel();
			//north.setLayout(new FlowLayout());
			north.setBorder(new TitledBorder("Nuevo Usuario"));
			this.add(north, BorderLayout.NORTH);
			
			JTextField uNick = new JTextField();
			uNick.setBorder(new TitledBorder("Nick"));
			north.add(uNick);
			uNick.setPreferredSize(new Dimension(150, 40));
			
			JTextField uPrecio = new JTextField();
			uPrecio.setBorder(new TitledBorder("Precio máx."));
			uPrecio.setPreferredSize(new Dimension(150, 40));
			north.add(uPrecio);
			
			String[] sistemas = {"Android", "iOS", "Windows"};
			JComboBox SOs = new JComboBox(sistemas);
			SOs.setBorder(new TitledBorder("Sistema Operativo"));
			north.add(SOs);
			
			
			//BorderLayout con ComboBox arriba para opciones y GridLayout en el centro
			//se muestran 2 columnas de 5 aplicaciones
			JPanel capaApps = new JPanel();
			
			JButton app = new JButton("APP");
			app.addActionListener(new ActionListener(){
				public void actionPerformed(ActionEvent e){
					String informacion = "Info de la app: \n Nombre: \n Tipo: \n Caracteristicas: \n";
					JOptionPane.showMessageDialog(null, informacion, "Informacion de la app", JOptionPane.INFORMATION_MESSAGE);
				}
			});
			//app.setVisible(true);
			
			this.add(app);
			this.setVisible(true);
			
		} catch (Exception e) {
            e.printStackTrace();
        }
	}
}
