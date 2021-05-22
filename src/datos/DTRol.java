package datos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import entidades.Rol;
import vistas.VW_usuario_rol;

public class DTRol 
{
	PoolConexion pc = PoolConexion.getInstance();
	Connection c = null;
	private ResultSet rsRol = null;
	private ResultSet rs = null;
	private PreparedStatement ps = null;
	
	//Método para llenar el resultset usuario
	public void llenarRsUsuario(Connection c)
	{
		String sql = "SELECT * FROM public.tblrol where estado <> 3";
		try 
		{
			//c = PoolConexion.getConnection();
			ps = c.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, ResultSet.HOLD_CURSORS_OVER_COMMIT);
			rsRol = ps.executeQuery();
		} 
		catch (Exception e) 
		{
			System.err.println("DT Rol: Error en listar roles " + e.getMessage());
			e.printStackTrace();
		}
	}
	
	public ArrayList<Rol> listarRoles()
	{
		ArrayList<Rol> listaRoles = new ArrayList<Rol>();
		
		String sql = "SELECT * FROM public.tblrol where estado <> 3";
		try 
		{
			c = PoolConexion.getConnection();
			ps = c.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, ResultSet.HOLD_CURSORS_OVER_COMMIT);
			rs = ps.executeQuery();
			while(rs.next())
			{
				Rol r = new Rol();
				r.setIdRol(rs.getInt("idrol"));
				r.setDescripcion(rs.getString("descripcion"));
				r.setEstado(rs.getInt("estado"));
				
				
				listaRoles.add(r);
				
			}
		} 
		catch (Exception e) 
		{
			System.err.println("DT ROL: Error en listar Roles " + e.getMessage());
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
		
		return listaRoles;
	}
	
	public boolean guardarRol(Rol r)
	{
		boolean guardado = false;
		
		try 
		{
			c = PoolConexion.getConnection();
			this.llenarRsUsuario(c);
			//AQUI INICIA EL GUARDAR
			rsRol.moveToInsertRow();
			rsRol.updateString("descripcion", r.getDescripcion());
			rsRol.updateInt("estado", 1);
			
			rsRol.insertRow();
			rsRol.moveToCurrentRow();
			guardado = true;
			//FIN DEL GUARDAR
			
		} 
		catch (Exception e) 
		{
			System.err.println("DTROL: Error al guardar rol " + e.getMessage());
			e.printStackTrace();
		}
		finally 
		{
			try 
			{
				if(rsRol != null)
				{
					rsRol.close();
				}
				if(c != null)
				{
					c.close();
				}
			} 
			catch (Exception e2) 
			{
				System.err.println("DTROL: Error al cerrar conexion " + e2.getMessage());
				e2.printStackTrace();
			}
		}
		
		return guardado;
	}
	
	public boolean modificarRol(Rol r)
	{
		boolean modificado = false;
		
		try 
		{
			c = PoolConexion.getConnection();
			this.llenarRsUsuario(c);
			rsRol.beforeFirst();
					
			while(rsRol.next())
			{
				if(rsRol.getInt(1) == r.getIdRol()) 
				{
					System.out.println("Id del rol: " + r.getIdRol());
					
					//rsUsuario.updateInt("idusuario", u.getIdUsuario());
					rsRol.updateString("descripcion", r.getDescripcion());
					rsRol.updateInt("estado", 2);
					
					rsRol.updateRow();
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
				if(rsRol != null)
				{
					rsRol.close();
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
	
	public boolean eliminarRol(int idrol)
	{
		boolean eliminado = false;
		
		
		try 
		{
			c = PoolConexion.getConnection();
			this.llenarRsUsuario(c);
			rsRol.beforeFirst();
			while(rsRol.next())
			{
				
				if(rsRol.getInt(1) == idrol) 
				{
					rsRol.updateInt("estado", 3);	
					rsRol.updateRow();
					
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
				if(rsRol != null)
				{
					rsRol.close();
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
	
	public Rol getRol(int idrol)
	{
		Rol r = new Rol();
		String sql = "Select * from public.tblrol where estado <> 3 and idrol = ?";
		
		try 
		{
			c = PoolConexion.getConnection();
			ps = c.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, ResultSet.HOLD_CURSORS_OVER_COMMIT);
			ps.setInt(1, idrol);
			rs = ps.executeQuery();
			if(rs.next())
			{
				r.setIdRol(rs.getInt("idrol"));
				r.setDescripcion(rs.getString("descripcion"));
				r.setEstado(rs.getInt("estado"));
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
				if(rsRol != null)
				{
					rsRol.close();
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
		
		
		return r;
	}
	public ArrayList<VW_usuario_rol> getRolUsuario(int idusuario)
	{
		ArrayList<VW_usuario_rol> listaRolesUsuario = new ArrayList<VW_usuario_rol>();
		String sql = "select * from public.vw_usuario_rol where idusuario = ?";
		
		try 
		{
			c = PoolConexion.getConnection();
			ps = c.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, ResultSet.HOLD_CURSORS_OVER_COMMIT);
			ps.setInt(1, idusuario);
			rs = ps.executeQuery();
			while(rs.next())
			{
				VW_usuario_rol vwr = new VW_usuario_rol();
				vwr.setIdrol(rs.getInt("idrol"));
				vwr.setDescripcion(rs.getString("descripcion"));
				listaRolesUsuario.add(vwr);
			}
		} 
		catch (SQLException e) 
		{
			System.err.println("DATOS: error getRoles(): " + e.getMessage());
			e.printStackTrace();
		}
		finally 
		{
			try 
			{
				if(rsRol != null)
				{
					rsRol.close();
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
		
		
		return listaRolesUsuario;
	}
}
