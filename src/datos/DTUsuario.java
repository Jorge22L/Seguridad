package datos;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

import entidades.Usuario;

public class DTUsuario 
{
	PoolConexion pc = PoolConexion.getInstance();
	Connection c = null;
	private ResultSet rsUsuario = null;
	private ResultSet rs = null;
	private PreparedStatement ps = null;
	
	//Método para llenar el resultset usuario
	public void llenarRsUsuario(Connection c)
	{
		String sql = "SELECT * FROM public.tblusuario where estado <> 3";
		try 
		{
			//c = PoolConexion.getConnection();
			ps = c.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, ResultSet.HOLD_CURSORS_OVER_COMMIT);
			rsUsuario = ps.executeQuery();
		} 
		catch (Exception e) 
		{
			System.err.println("DT USUARIO: Error en listar usuarios " + e.getMessage());
			e.printStackTrace();
		}
	}
	
	public ArrayList<Usuario> listarUsuarios()
	{
		ArrayList<Usuario> listaUsuarios = new ArrayList<Usuario>();
		
		String sql = "SELECT * FROM public.tblusuario where estado <> 3";
		try 
		{
			c = PoolConexion.getConnection();
			ps = c.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, ResultSet.HOLD_CURSORS_OVER_COMMIT);
			rs = ps.executeQuery();
			while(rs.next())
			{
				Usuario u = new Usuario();
				u.setIdUsuario(rs.getInt("idusuario"));
				u.setNombre(rs.getString("nombre"));
				u.setApellido(rs.getString("apellido"));
				u.setUsuarioNombre(rs.getString("usuario"));
				
				listaUsuarios.add(u);
				
			}
		} 
		catch (Exception e) 
		{
			System.err.println("DT USUARIO: Error en listar usuarios " + e.getMessage());
			e.printStackTrace();
		}
		finally 
		{
			try 
			{
				if(rs != null)
					rs.close();
				
				if(ps != null)
					ps.close();
				
				if(c != null)
					PoolConexion.closeConnection(c);
			} 
			catch (Exception e2) 
			{
				System.err.println("DT USUARIO: Error en listar usuarios " + e2.getMessage());
				e2.printStackTrace();
			}
		}
		
		return listaUsuarios;
	}
	
	public boolean guardarUsuario(Usuario u)
	{
		boolean guardado = false;
		Date utilDate = new Date();
		java.sql.Date sqlDate =  new java.sql.Date(utilDate.getTime());
		
		try 
		{
			c = PoolConexion.getConnection();
			this.llenarRsUsuario(c);
			//AQUI INICIA EL GUARDAR
			rsUsuario.moveToInsertRow();
			rsUsuario.updateString("nombre", u.getNombre());
			rsUsuario.updateString("apellido", u.getApellido());
			rsUsuario.updateString("usuario", u.getUsuarioNombre());
			rsUsuario.updateString("pwd", md5(u.getPwd()));
			rsUsuario.updateDate("fechaCreacion", sqlDate);
			rsUsuario.updateInt("estado", 1);
			
			rsUsuario.insertRow();
			rsUsuario.moveToCurrentRow();
			guardado = true;
			//FIN DEL GUARDAR
			
		} 
		catch (Exception e) 
		{
			System.err.println("DTUSUARIO: Error al guardar usuario " + e.getMessage());
			e.printStackTrace();
		}
		finally 
		{
			try 
			{
				if(rsUsuario != null)
				{
					rsUsuario.close();
				}
				if(c != null)
				{
					c.close();
				}
			} 
			catch (Exception e2) 
			{
				System.err.println("DTUSUARIO: Error al cerrar conexion " + e2.getMessage());
				e2.printStackTrace();
			}
		}
		
		return guardado;
	}
	
	public boolean modificarUsuario(Usuario u)
	{
		boolean modificado = false;
		
		try 
		{
			c = PoolConexion.getConnection();
			this.llenarRsUsuario(c);
			rsUsuario.beforeFirst();
					
				
			while(rsUsuario.next())
			{
				if(rsUsuario.getInt(1) == u.getIdUsuario()) 
				{
					System.out.println("Id del usuario: " + u.getIdUsuario());
					
					//rsUsuario.updateInt("idusuario", u.getIdUsuario());
					rsUsuario.updateString("nombre", u.getNombre());
					rsUsuario.updateString("apellido", u.getApellido());
					rsUsuario.updateString("usuario", u.getUsuarioNombre());
					rsUsuario.updateString("pwd", md5(u.getPwd()));
					rsUsuario.updateInt("estado", 2);
					
					rsUsuario.updateRow();
					modificado = true;
					break;
				}
				
			}
			
		} 
		catch (Exception e) 
		{
			System.err.println("DTUSUARIO: Error al modificar usuario " + e.getMessage());
			e.printStackTrace();
		}
		finally 
		{
			try 
			{
				if(rsUsuario != null)
				{
					rsUsuario.close();
				}
				if(c != null)
				{
					c.close();
				}
			} 
			catch (Exception e2) 
			{
				System.err.println("DTUSUARIO: Error al cerrar conexion " + e2.getMessage());
				e2.printStackTrace();
			}
		}
		
		return modificado;
	}
	
	public boolean eliminarUsuario(int idusuario)
	{
		boolean eliminado = false;
		
		
		try 
		{
			c = PoolConexion.getConnection();
			this.llenarRsUsuario(c);
			rsUsuario.beforeFirst();
			while(rsUsuario.next())
			{
				
				if(rsUsuario.getInt(1) == idusuario) 
				{
					rsUsuario.updateInt("estado", 3);	
					rsUsuario.updateRow();
					
					eliminado = true;
					break;
				}
				
			}
			
		} 
		catch (SQLException e) 
		{
			System.err.println("DTUSUARIO: Error al eliminar usuario " + e.getMessage());
			e.printStackTrace();
			System.err.println(e.getSQLState());
		}
		finally 
		{
			try 
			{
				if(rsUsuario != null)
				{
					rsUsuario.close();
				}
				if(c != null)
				{
					c.close();
				}
			} 
			catch (Exception e2) 
			{
				System.err.println("DTUSUARIO: Error al cerrar conexion " + e2.getMessage());
				e2.printStackTrace();
			}
		}
		
		return eliminado;
	}
	
	public Usuario getUsuario(int idusuario)
	{
		Usuario u = new Usuario();
		String sql = "Select * from public.tblusuario where estado <> 3 and idusuario = ?";
		
		try 
		{
			c = PoolConexion.getConnection();
			ps = c.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, ResultSet.HOLD_CURSORS_OVER_COMMIT);
			ps.setInt(1, idusuario);
			rs = ps.executeQuery();
			if(rs.next())
			{
				u.setIdUsuario(idusuario);
				u.setNombre(rs.getString("nombre"));
				u.setApellido(rs.getString("apellido"));
				u.setUsuarioNombre(rs.getString("usuario"));
			}
		} 
		catch (SQLException e) 
		{
			System.err.println("DATOS: error getUsuario(): " + e.getMessage());
			e.printStackTrace();
		}
		finally 
		{
			try 
			{
				if(rsUsuario != null)
				{
					rsUsuario.close();
				}
				if(c != null)
				{
					c.close();
				}
			} 
			catch (Exception e2) 
			{
				System.err.println("DTUSUARIO: Error al cerrar conexion " + e2.getMessage());
				e2.printStackTrace();
			}
		}
		
		
		return u;
	}
	
	public String md5(String input)
	{
		try 
		{ 
			  
            // Static getInstance method is called with hashing MD5 
            MessageDigest md = MessageDigest.getInstance("MD5"); 
  
            // digest() method is called to calculate message digest 
            //  of an input digest() return array of byte 
            byte[] messageDigest = md.digest(input.getBytes()); 
  
            // Convert byte array into signum representation 
            BigInteger no = new BigInteger(1, messageDigest); 
  
            // Convert message digest into hex value 
            String hashtext = no.toString(16); 
            while (hashtext.length() < 32) { 
                hashtext = "0" + hashtext; 
            } 
            return hashtext; 
        }  
        // For specifying wrong message digest algorithms 
        catch (NoSuchAlgorithmException e) 
		{ 
        	System.err.println("Error al encriptar: " + e.getMessage());
        	e.printStackTrace();
            throw new RuntimeException(e); 
        } 
				
	}

	
	
	
	
	
	
}
