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
 * Servlet implementation class SLeliminarUsuario
 */
@WebServlet("/SLeliminarUsuario")
public class SLeliminarUsuario extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SLeliminarUsuario() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try 
		{
			Usuario u = new Usuario();
			DTUsuario dtu = new DTUsuario();
			
			int idusuario = 0;
			
			idusuario = Integer.parseInt(request.getParameter("id"));
			u.setIdUsuario(idusuario);
			if(dtu.eliminarUsuario(idusuario))
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
			System.err.println("SL USUARIO: Error al eliminar usuario " +e.getMessage());
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
