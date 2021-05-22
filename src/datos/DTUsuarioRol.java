package datos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import entidades.UsuarioRol;
import vistas.VW_usuario_rol;

public class DTUsuarioRol 
{
	PoolConexion pc = PoolConexion.getInstance();
	Connection c = null;
	DTUsuario dtu = new DTUsuario();
	private ResultSet rsUsuarioRol = null;
	private ResultSet rs = null;
	private PreparedStatement ps = null;
	
	//Método para llenar el resultset usuario
	public void llenarRsUsuarioRol(Connection c)
	{
		String sql = "SELECT * FROM public.tbl_usuario_rol";
		try 
		{
			//c = PoolConexion.getConnection();
			ps = c.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, ResultSet.HOLD_CURSORS_OVER_COMMIT);
			rsUsuarioRol = ps.executeQuery();
		} 
		catch (Exception e) 
		{
			System.err.println("DT USUARIO: Error en listar usuarios " + e.getMessage());
			e.printStackTrace();
		}
	}
	
	public boolean guardarUsuarioRol(UsuarioRol ur)
	{
		boolean guardado = false;
		
		
		try 
		{
			c = PoolConexion.getConnection();
			this.llenarRsUsuarioRol(c);
			//AQUI INICIA EL GUARDAR
			rsUsuarioRol.moveToInsertRow();
			
			rsUsuarioRol.updateInt("idusuario", ur.getUsuario());
			rsUsuarioRol.updateInt("idrol", ur.getRol());
			
			rsUsuarioRol.insertRow();
			rsUsuarioRol.moveToCurrentRow();
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
				if(rsUsuarioRol != null)
				{
					rsUsuarioRol.close();
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
	
	public boolean LoginUsuario(VW_usuario_rol vwr)
	{
		boolean encontrado = false;
		
		PreparedStatement ps;
//		String sql = ("SELECT * from public.usuario_vs_roles_opciones where usuario = ? AND pwd = ? AND \"idRol\" = ? ");
		String sql = ("select * from vw_usuario_rol vwr where usuario = ? and pwd = ? and idrol = ?");
		try 
		{
			c = PoolConexion.getConnection();
			ps = c.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			ps.setString(1, vwr.getUsuario());
			ps.setString(2, dtu.md5(vwr.getPwd()));
			ps.setInt(3, vwr.getIdrol());
			
			rs = ps.executeQuery();
			
			if(rs.next())
			{
				encontrado = true;
			}
			else
			{
				encontrado = false;
			}
			
		} 
		catch (Exception e) 
		{
			System.out.println("DATOS: ERROR AL VERIFICAR EL LOGIN "+ e.getMessage());
			e.printStackTrace();
		}
		
		return encontrado;
	}
	
	public ArrayList<VW_usuario_rol> listaOpciones(String loginuser, int idrol)
	{
		ArrayList<VW_usuario_rol> permisosUsuarios = new ArrayList<VW_usuario_rol>();
		String sql = "SELECT * from public.vw_usuario_rol where usuario = ? AND idrol = ?";
		
		try 
		{
			c = PoolConexion.getConnection();
			PreparedStatement ps = c.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, 
					ResultSet.CONCUR_UPDATABLE,ResultSet.HOLD_CURSORS_OVER_COMMIT);
			ps.setString(1, loginuser);
			ps.setInt(2, idrol);
			rs = ps.executeQuery();
			
			while(rs.next())
			{
				VW_usuario_rol vwur = new VW_usuario_rol();
				
				vwur.setIdusuario(rs.getInt("idusuario"));
				vwur.setNombre(rs.getString("nombre"));
				vwur.setApellido(rs.getString("apellido"));
				vwur.setUsuario(rs.getString("usuario"));
				vwur.setPwd(rs.getString("pwd"));
				vwur.setDescripcion(rs.getString("descripcion"));
				vwur.setNombre_opcion(rs.getString("nombre_opcion"));
				vwur.setUrl(rs.getString("url"));
				
				
				permisosUsuarios.add(vwur);
			}
		} 
		catch (SQLException e) 
		{
			System.err.println("DATOS: ERROR AL OBTENER OPCIONES");
			e.printStackTrace();
		}
		return permisosUsuarios;
	}
}
