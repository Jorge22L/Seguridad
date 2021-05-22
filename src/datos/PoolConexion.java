package datos;

import java.sql.Connection;
import java.sql.SQLException;

import javax.swing.JOptionPane;

import org.apache.commons.dbcp.BasicDataSource;

public class PoolConexion 
{
	private static PoolConexion INSTANCE = null;
	
	private static Connection con  = null;
	private static BasicDataSource dataSource;
	
	//Datos de la Conexion
	
	private static String db = "seguridad";
	private static String url = "jdbc:postgresql://localhost:5432/"+db;
	private static String user = "postgres";
	private static String pass = "1234";
	
	private PoolConexion()
	{
		inicializaDataSource();
	}
	
	private synchronized static void createInstance()
	{
		if(INSTANCE == null)
		{
			INSTANCE = new PoolConexion();
		}
	}
	
	public static PoolConexion getInstance()
	{
		if(INSTANCE == null)
		{
			createInstance();
		}
		return INSTANCE;
	}
	
	public final void inicializaDataSource()
	{
		BasicDataSource basicDataSource = new BasicDataSource();
		
		basicDataSource.setDriverClassName("org.postgresql.Driver");
		basicDataSource.setUsername(user);
		basicDataSource.setPassword(pass);
		basicDataSource.setUrl(url);
		basicDataSource.setMaxActive(100);
		dataSource = basicDataSource;
	}
	
	public static boolean EstaConectado()
	{
		boolean resp = false;
		
		try 
		{
			if((con == null) || (con.isClosed()))
			{
				resp = false;
			}
			else
			{
				resp = true;
			}
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
		
		return resp;
	}
	
	public static Connection getConnection()
	{
		if(EstaConectado() == false)
		{
			try 
			{
				con = PoolConexion.dataSource.getConnection();
			} 
			catch (SQLException e) 
			{
				System.out.println(e.getMessage());
				e.printStackTrace();
			}
		}
		
		return con;
	}
	
	public static void closeConnection(Connection con)
	{
		if(EstaConectado() != false)
		{
			try 
			{
				con.close();
				System.out.println("Cerrando la conexión");
			} 
			catch (SQLException e) 
			{
				System.out.println(e.getMessage());
				e.printStackTrace();
			}
		}
	}
	
	public static void main (String[] args) throws SQLException
	{
		PoolConexion.getInstance();
		Connection con = null;
		
		try 
		{
			con = PoolConexion.getConnection();
			if(con != null)
			{
				JOptionPane.showMessageDialog(null, "Conectado a " + db);
			}
			else
			{
				JOptionPane.showMessageDialog(null, "Error al conectar a " + db);
			}
					
		}
		finally
		{
			try 
			{
				con.close();
				System.out.println("Se desconecto de la bd");
			} 
			catch (SQLException e) 
			{
				System.out.println(e.getMessage());
				e.printStackTrace();
			}
		}
		
	}
	
	
	
	
	
	
	
}
