<%@page import="vistas.VW_usuario_rol"%>
<%@page import="entidades.Usuario"%>
<%@page import="java.util.ArrayList"%>
<%@page import="datos.DTUsuario"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
	<%
	
	ArrayList<VW_usuario_rol> opciones = new ArrayList<VW_usuario_rol>();
	
	//Recuperar sesión
	opciones = (ArrayList<VW_usuario_rol>)session.getAttribute("opcion");
	//Recuperamos la url actual
	int index = request.getRequestURL().lastIndexOf("/");
	String miPagina = request.getRequestURL().substring(index+1);
	boolean permiso = false;
	String opcionActual = "";
	
	//Buscamos si el rol tiene el permiso para la pagina actual
	for(VW_usuario_rol vwr : opciones)
	{
		opcionActual = vwr.getUrl().trim();
		
		if(opcionActual.equals(miPagina.trim()))
		{
			permiso = true;
			break;
		}
		else
		{
			permiso = false;
		}
		
	}
	

	if(!permiso)
	{
		response.sendRedirect("404.html");
	}
	%>
<!DOCTYPE html>
<html lang="es">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>Seguridad - Usuario</title>

<!-- Custom fonts for this template-->
<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
	type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">


<!-- Custom styles for this template-->
<link href="css/sb-admin-2.min.css" rel="stylesheet">

<!-- Custom styles for this page -->
<link href="vendor/datatables/dataTables.bootstrap4.min.css"
	rel="stylesheet">

</head>

<body id="page-top">

	<!-- Page Wrapper -->
	<div id="wrapper">

		<!-- Sidebar -->
		<jsp:include page="WEB-INF/layout/sidebar.jsp"></jsp:include>
		<!-- End of Sidebar -->

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">

				<!-- Topbar -->

				<jsp:include page="WEB-INF/layout/header.jsp"></jsp:include>

				<!-- End of Topbar -->

				<!-- Begin Page Content -->
				<div class="container-fluid">

					<!-- Page Heading -->
					<h1 class="h3 mb-2 text-gray-800">Lista de Usuarios</h1>


					<!-- DataTales Example -->
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">Lista de
								Usuarios</h6>
							<span id="agregar" data-toggle="modal"
								data-target="#modalLoginForm"> Agregar Usuario</span>
						</div>
						<div class="card-body">
							<div class="table-responsive">
								<table class="table table-bordered" id="dataTable" width="100%"
									cellspacing="0">
									<thead>
										<tr>
											<th>ID</th>
											<th>Nombre</th>
											<th>Apellido</th>
											<th>NombreUsuario</th>
											<th>Acciones</th>
										</tr>
									</thead>
									<tfoot>
										<tr>
											<th>ID</th>
											<th>Nombre</th>
											<th>Apellido</th>
											<th>NombreUsuario</th>
											<th>Acciones</th>
										</tr>
									</tfoot>
									<tbody>
										<%
											DTUsuario dtu = new DTUsuario();
										ArrayList<Usuario> listaUsuarios = new ArrayList<Usuario>();

										listaUsuarios = dtu.listarUsuarios();

										for (Usuario u : listaUsuarios) {
										%>
										<tr>
											<td><%=u.getIdUsuario()%></td>
											<td><%=u.getNombre()%></td>
											<td><%=u.getApellido()%></td>
											<td><%=u.getUsuarioNombre()%></td>
											<td>
												<span>
                    								<a onclick="eliminarUsuario(<%=u.getIdUsuario()%>);">
                    									<i class="fas fa-trash"></i>
                    								</a>
                    							</span>
                    							<span>
                    								<a onclick="valoreditar(<%=u.getIdUsuario() %>)">
                    									<i class="fas fa-edit"></i>
                    								</a>
                    							</span>
                    							<span>
                    								<a onclick="agregarRol(<%=u.getIdUsuario() %>)">
                    									<i class="fa fa-plus-circle"></i>
                    								</a>
                    							</span>
                    							<span>
                    								<a onclick="DetalleRol(<%=u.getIdUsuario() %>)">
                    									<i class="fas fa-user-tag"></i>
                    								</a>
                    							</span>
                    						</td>

										</tr>
										<%
											}
										%>
									</tbody>
								</table>
							</div>
						</div>
					</div>

				</div>

				<!-- /.container-fluid -->

			</div>
			<!-- End of Main Content -->

			<!-- Footer -->

			<jsp:include page="WEB-INF/layout/footer.jsp"></jsp:include>

			<!-- End of Footer -->

		</div>
		<!-- End of Content Wrapper -->
		</div>

		<!-- End of Page Wrapper -->

		<!-- Scroll to Top Button-->
		<a class="scroll-to-top rounded" href="#page-top"> <i
			class="fas fa-angle-up"></i>
		</a>

		<!-- Logout Modal-->
		<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">Ready to
							Leave?</h5>
						<button class="close" type="button" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">×</span>
						</button>
					</div>
					<div class="modal-body">Select "Logout" below if you are
						ready to end your current session.</div>
					<div class="modal-footer">
						<button class="btn btn-secondary" type="button"
							data-dismiss="modal">Cancel</button>
						<a class="btn btn-primary" href="login.html">Logout</a>
					</div>
				</div>
			</div>
		</div>
		<!--     AgregarUsuario Modal -->
		<!-- 		<form action="./SLguardarUsuario" method="post"> -->
		<!-- 			<div class="modal fade" id="agregarUsuario" tabindex="-1" -->
		<!-- 				role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true"> -->
		<!-- 				<div class="modal-dialog" role="document"> -->
		<!-- 					<div class="modal-header"> -->
		<!-- 						<h5 class="modal-title">Agregar Usuario</h5> -->
		<!-- 						<button type="button" class="close" data-dismiss="modal" -->
		<!-- 							aria-label="close"> -->
		<!-- 							<span aria-hidden="true">&times;</span> -->
		<!-- 						</button> -->
		<!-- 					</div> -->
		<!-- 					<div class="modal-body"> -->
		<!-- 						<span>Nombre: </span> <input type="text" class="form-control" -->
		<!-- 							id="nombreU" name="nombreU" /> <span>Apellido: </span> <input -->
		<!-- 							type="text" class="form-control" id="apellidoU" name="apellidoU" /> -->
		<!-- 						<span>NombreUsuario: </span> <input type="text" -->
		<!-- 							class="form-control" id="nomUsuario" name="nomUsuario" /> <span>Clave: -->
		<!-- 						</span> <input type="text" class="form-control" id="clave" name="clave" /> -->

		<!-- 					</div> -->
		<!-- 					<div class="modal-footer"> -->
		<!-- 						<button type="reset" class="btn btn-secondary" -->
		<!-- 							data-dismiss="modal">Cerrar</button> -->
		<!-- 						<button type="submit" class="btn btn-primary" data-dismiss="modal">Guardar</button> -->
		<!-- 					</div> -->
		<!-- 				</div> -->
		<!-- 			</div> -->
		<!-- 		</form> -->

		<form action="./SLguardarUsuario" method="post">
			
			<div class="modal fade" id="modalLoginForm" tabindex="-1"
				role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header text-center">
							<h4 class="modal-title w-100 font-weight-bold">Sign in</h4>
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body">
							<span>Nombre: </span> <input type="text" class="form-control"
								id="nombreU" name="nombreU" /> <span>Apellido: </span> <input
								type="text" class="form-control" id="apellidoU" name="apellidoU" />
							<span>NombreUsuario: </span> <input type="text"
								class="form-control" id="nomUsuario" name="nomUsuario" /> <span>Clave:
							</span> <input type="text" class="form-control" id="clave" name="clave" />

						</div>
						<div class="modal-footer d-flex justify-content-center">
							<button class="btn btn-default">Guardar</button>
						</div>
					</div>
				</div>
			</div>
		</form>

		<div class="text-center">
			<a href="" class="btn btn-default btn-rounded mb-4"
				data-toggle="modal" data-target="#modalLoginForm">Launch Modal
				Login Form</a>
		</div>

		<!-- Bootstrap core JavaScript-->
		<script src="vendor/jquery/jquery.min.js"></script>
		<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

		<!-- Core plugin JavaScript-->
		<script src="vendor/jquery-easing/jquery.easing.min.js"></script>

		<!-- Custom scripts for all pages-->
		<script src="js/sb-admin-2.min.js"></script>

		<!-- Page level plugins -->
		<script src="vendor/datatables/jquery.dataTables.min.js"></script>
		<script src="vendor/datatables/dataTables.bootstrap4.min.js"></script>

		<!-- Page level custom scripts -->
		<script src="js/demo/datatables-demo.js"></script>
		<script type="text/javascript">
		
		function valoreditar(idusuario)
		{
			window.location.href="usuarioEditar.jsp?idusuario="+idusuario;
			location.reload
		}
		
		function agregarRol(idusuario)
		{
			window.location.href="agregarRol.jsp?idusuario="+idusuario;
			location.reload
		}
		
		
		function eliminarUsuario(id)
		{
			window.open("SLeliminarUsuario?id="+id);
		}
		
		function DetalleRol(idusuario)
		{
			window.open("Permisos_Usuario?idusuario="+idusuario);
		}
		
		</script>
</body>

</html>