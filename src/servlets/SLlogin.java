package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import datos.DTUsuarioRol;
import vistas.VW_usuario_rol;

/**
 * Servlet implementation class SLlogin
 */
@WebServlet("/SLlogin")
public class SLlogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SLlogin() {
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
			VW_usuario_rol vwr = new VW_usuario_rol();
			DTUsuarioRol dtur = new DTUsuarioRol();
			
			int idrol = 0;
			String usuario, clave = "";
			
			usuario = request.getParameter("usuario");
			clave = request.getParameter("password");
			idrol = Integer.parseInt(request.getParameter("rol"));
			
			vwr.setUsuario(usuario);
			vwr.setPwd(clave);
			vwr.setIdrol(idrol);
			
			if(dtur.LoginUsuario(vwr)) 
			{
				System.out.println("EL USUARIO ES CORRECTO");
				
				//SE CREA VARIABLE SESIÓN
				HttpSession hts = request.getSession(true);
				//Se agrega atributo al objeto sesión
				hts.setAttribute("login", usuario);
				hts.setAttribute("idrolusuario", idrol);
				
				System.out.println("USUARIO: "+ usuario);
				
				response.sendRedirect("index.jsp");
			}
			else
			{
				System.err.println("ERROR AL AUTENTICAR USUARIO");
				response.sendRedirect("login.jsp?error=1");
			}
		} 
		catch (Exception e) 
		{
			System.out.println("ERROR LOGINUSUARIO() :" + e.getMessage());
			e.printStackTrace();
		}
	}

}
