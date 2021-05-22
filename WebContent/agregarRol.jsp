<%@page import="vistas.VW_usuario_rol"%>
<%@page import="java.util.ArrayList"%>
<%@page import="datos.DTUsuario"%>
<%@page import="entidades.Usuario"%>
<%@page import="datos.DTRol"%>
<%@page import="entidades.Rol"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>Seguridad - Agregar Rol</title>

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
					<h1 class="h3 mb-2 text-gray-800">Editar Rol</h1>
					<%
						String idrol = request.getParameter("idrol");
						idrol = idrol == null ? "" : idrol;
						
						String idusuario = request.getParameter("idusuario");
						idusuario = idusuario == null ? "" : idusuario;
						
						Usuario u = new Usuario();
						DTUsuario dtu =  new DTUsuario();
						u = dtu.getUsuario(Integer.parseInt(idusuario));
						
						Rol r = new Rol();
						DTRol dtr =  new DTRol();
            		 %>
					<form class="form-group" method="post" action="./SLgestionUsuarioRol">
						<div class="form-group">
						<input hidden="true" name="idrol" value="<%=idrol%>">
						<input hidden="true" name="idusuario" value="<%=idusuario%>">
							<label class="col-sm-2 control-label">Usuario: </label>
							<div class="col-sm-6">
								<input type="hidden" id="opcion" name="opcion" value="1" required />
								<input id="usuarionombre" name="usuarinombre" disabled="disabled"/>
							</div>	
							<label class="col-sm-2 control-label">Rol: </label>
							<div class="col-sm-6">
								<select name="rol" id="rol" class="custom-select">
								<option value="0">SELECCIONE</option>
								<%
								ArrayList<Rol> listaRol = new ArrayList<Rol>();
								listaRol = dtr.listarRoles();
								for(Rol r1 : listaRol)
								{
								%>
								<option value="<%=r1.getIdRol() %>"><%=r1.getDescripcion() %></option>
								<%
								}
								%>
								</select>
								
							</div>	
					</div>
					
					<div class="form-group has-feedback middle">
					
						<div class="col-sm-12">
							<h4 class="page-header">Acciones</h4>
							<div class="col-sm-6 text-center">
								<button class="btn btn-outline-primary" type="submit" title="Guardar Registro">
									<i class="fas fa-save"> </i>
								</button>
							</div>							
						</div>
					</div>
				</form>
					
				</div>
				
				<h1 class="h3 mb-2 text-gray-800">Roles de Usuario</h1>


					<!-- DataTales Example -->
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">Roles del usuario</h6>
							
						</div>
						<div class="card-body">
							<div class="table-responsive">
								<table class="table table-bordered" id="dataTable" width="100%"	cellspacing="0">
								<%
										ArrayList<VW_usuario_rol> listaRolUsuario = new ArrayList<VW_usuario_rol>();

										listaRolUsuario = dtr.getRolUsuario(Integer.parseInt(idusuario));

										for (VW_usuario_rol vwr : listaRolUsuario) {
								%>
									<thead>
										<tr>
											<th>ID</th>
											<th>Descripcion</th>
											<th>Acciones</th>
										</tr>
									</thead>
									<tfoot>
										<tr>
											<th>ID</th>
											<th>Descripcion</th>
											<th>Acciones</th>
										</tr>
									</tfoot>
									<tbody>
										
										<tr>
											<td><%=vwr.getIdrol()%></td>
											<td><%=vwr.getDescripcion()%></td>
										</tr>
											<%
										}
											%>
									</tbody>
								</table>
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
		
		$(document).ready(function()
		{
			$("#usuarionombre").val("<%=u.getUsuarioNombre() %>");
			
		});
		</script>
</body>

</html>