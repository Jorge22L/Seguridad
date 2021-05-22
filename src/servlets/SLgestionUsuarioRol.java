package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import datos.DTUsuarioRol;

import entidades.UsuarioRol;

/**
 * Servlet implementation class SLgestionUsuarioRol
 */
@WebServlet("/SLgestionUsuarioRol")
public class SLgestionUsuarioRol extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SLgestionUsuarioRol() {
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
		int opc = 0;
		opc = Integer.parseInt(request.getParameter("opcion"));
		
		//Objetos de Rol
		DTUsuarioRol dtur =  new DTUsuarioRol();
		UsuarioRol ur = new UsuarioRol();
		
		ur.setRol(Integer.parseInt(request.getParameter("rol")));
		ur.setUsuario(Integer.parseInt(request.getParameter("idusuario")));
	
		
		switch (opc) 
		{
			case 1: 
				try 
				{
					if(dtur.guardarUsuarioRol(ur))
					{
						response.sendRedirect("Usuario.jsp");
					}
					else
					{
						response.sendRedirect("Usuario.jsp?msj=2");
					}
				} 
				catch (Exception e) 
				{
					System.err.println("SLgestionUsuarioRol el error es: " +e.getLocalizedMessage());
					e.printStackTrace();
				}
			
				break;
				
			case 2:
				

			default:
				break;
		}
		
	}

}
