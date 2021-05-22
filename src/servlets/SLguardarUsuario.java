package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import datos.DTUsuario;
import entidades.Usuario;

/**
 * Servlet implementation class SLguardarUsuario
 */
@WebServlet("/SLguardarUsuario")
public class SLguardarUsuario extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SLguardarUsuario() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try 
		{
			Usuario u = new Usuario();
			DTUsuario dtu = new DTUsuario();
			
			String nombre, apellido, usuario, pwd = "";
			
			nombre = request.getParameter("nombreU");
			apellido = request.getParameter("apellidoU");
			usuario = request.getParameter("nomUsuario");
			pwd = request.getParameter("clave");
			
			u.setNombre(nombre);
			u.setApellido(apellido);
			u.setUsuarioNombre(usuario);
			u.setPwd(pwd);
			
			if(dtu.guardarUsuario(u))
			{
				response.sendRedirect("Usuario.jsp");
			}
			else
			{
				response.sendRedirect("Usuario.jsp?error");
			}
		} 
		catch (Exception e) 
		{
			System.err.println("SL USUARIO: Error al guardar usuario " +e.getMessage());
			e.printStackTrace();
		}
		
		
		
	}

}
