<%@page import="com.ipartek.formacion.youtube.controller.HomeController"%>


<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<!DOCTYPE html>
<html lang="en">

<head>

<!-- Comenza todas las URLs desde el href indicado -->
<base href="<%=request.getContextPath()%>/">

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>Youtube Video Play List</title>

<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">

<!-- Bootstrap core CSS -->
<link href="https://blackrockdigital.github.io/startbootstrap-shop-item/vendor/bootstrap/css/bootstrap.min.css"	rel="stylesheet">

<!-- Custom styles for this template -->
<link href="css/shop-item.css" rel="stylesheet">

</head>

<body>

	<!-- Navigation -->
	<nav id="menu" class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
		<div class="container">
			<img src="images/youtube.png" alt="Smiley face" height="42"">
			<a class="navbar-brand" href="#">Youtube PlayList</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarResponsive" aria-controls="navbarResponsive"
				aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			
			<span class="text-warning">Ultima visita: ${cookie['cVisita'].getValue()}</span>
			<div class="collapse navbar-collapse" id="navbarResponsive">
				<ul class="navbar-nav ml-auto">
					<li class="nav-item active">
						<!-- Usuario sin pasar por login -->
						<c:if test="${empty sessionScope.usuario}">
							 <!-- formulario Login -->
							<form action="login" method="post"
								class="d-flex flex-row mt-2 mt-md-0">
								<input name="usuario" class="form-control mr-sm-2" type="text"
									placeholder="${cookie['nombreUsuario'].getValue()}" required pattern=".{3,30}">
								<input name="pass" class="form-control mr-sm-2" type="password"
									placeholder="Contraseña" required pattern=".{2,50}">
								
								
								<div class="input-group mr-sm-2">
								  <div class="input-group-prepend">
								    <div class="input-group-text">
								      <input type="checkbox" aria-label="Checkbox for following text input" name="guardarUsuario">
								    </div>
								  </div>
								  <p class="form-control" aria-label="Text input with checkbox">Guardar usuario</p>
								</div>
								
								
								
								<button class="btn btn-outline-info my-2 my-sm-0" type="submit">Entrar</button>
							</form> 
						</c:if>
						<!-- Usuario logueado -->
						<c:if test="${not empty sessionScope.usuario}">
							<div id="add-video" class="d-flex flex-row align-items-center">
								<form action="" method="post" class="d-flex flex-row mt-2 mt-md-0">
									<input name="id" class="form-control mr-sm-2" type="text"
										placeholder="ID 11 caracerteres" title="11 caracteres" required
										pattern=".{11,11}"> <input name="nombre"
										class="form-control mr-sm-2" type="text"
										placeholder="Nombre minimo 2 letras" required
										pattern=".{2,125}">
									<button class="btn btn-outline-info my-2 my-sm-0" type="submit">Añadir</button>
								</form>
	
								<img src="images/user.png" alt="Smiley face" height="42" width="42">
								<div class="d-flex flex-column">
				ñkm					<p> ${cookie['nombreUsuario'].getValue()}</p>
									<a href="logout">Logout</a>
									<a href="backoffice/index.jsp">Backoffice</a>
								</div>
							</div>
						</c:if>
					</li>

				</ul>



			</div>
		</div>
	</nav>

	<!-- Page Content -->
	<div class="container">

		<c:if test="${empty alert}">
			${alert = null}
		</c:if>
		<c:if test="${not empty alert}">
			<div class="container">
				<div class="alert ${alert.getTipo()} alert-dismissible fade show" role="alert">
					<p>${alert.getTexto()}</p>
					<button type="button" class="close" data-dismiss="alert"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
			</div>
			
		</c:if>

		<div class="row">

			<div class="col-lg-3">
				<h4 class="my-4 text-center">Lista Reproduccion</h4>
				<ul class="list-group">
				
					<c:forEach items="${videos}" var="v">
						<li	class="list-group-item d-flex justify-content-between align-items-center">
							<a href="inicio?id=${v.getId()}">${v.getNombre()}</a>
							<a href="inicio?id=${v.getId()}%>&op=<${HomeController.OP_ELIMINAR}">
								<i style="color: red;" class="float-right fas fa-trash-alt"></i>
							</a>
						</li>
					</c:forEach>
						
				</ul>

				<h4 class="my-4 text-center">Videos Reproducidos</h4>
				<ul class="list-group">
					<c:if test="${not empty videosReproducidos}">
						<c:forEach items="${videosReproducidos}" var="v">
							<li class="list-group-item d-flex justify-content-between align-items-center">
								<a href="inicio?id=${v.getId()}">${v.getNombre()}</a>
							</li>
						</c:forEach>
					</c:if>
					<c:if test="${empty videosReproducidos}">
						<li>
							<p>Por favor, <a href="#" onclick="focusLogin">Inicial Sesion</a> para guardar tus videos reproducidos</p>
						</li>
					</c:if>
				</ul>

			</div>

			<!-- /.col-lg-3 -->

			<div class="col-lg-9">

				<div class="card mt-4">
					<iframe id="iframe" width="823" height="415" src="https://www.youtube.com/embed/${videoInicio.getId()}?autoplay=1"
						frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>

					<div class="card-body">
						<h3 class="card-title"><${videoInicio.getNombre()}></h3>
						<p class="card-text">Lorem ipsum dolor sit amet, consectetur
							adipisicing elit. Sapiente dicta fugit fugiat hic aliquam itaque
							facere, soluta. Totam id dolores, sint aperiam sequi pariatur
							praesentium animi perspiciatis molestias iure, ducimus!</p>
						<span class="text-warning">&#9733; &#9733; &#9733; &#9733;
							&#9734;</span> 4.0 stars
					</div>
			
				</div>
				<!-- /.card -->

				<div class="card card-outline-secondary my-4">
					<div class="card-header">Comentarios</div>
					<div class="card-body">
						<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.
							Omnis et enim aperiam inventore, similique necessitatibus neque
							non! Doloribus, modi sapiente laboriosam aperiam fugiat laborum.
							Sequi mollitia, necessitatibus quae sint natus.</p>
						<small class="text-muted">Posted by Anonymous on 3/1/17</small>
						<hr>
						<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.
							Omnis et enim aperiam inventore, similique necessitatibus neque
							non! Doloribus, modi sapiente laboriosam aperiam fugiat laborum.
							Sequi mollitia, necessitatibus quae sint natus.</p>
						<small class="text-muted">Posted by Anonymous on 3/1/17</small>
						<hr>
						<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.
							Omnis et enim aperiam inventore, similique necessitatibus neque
							non! Doloribus, modi sapiente laboriosam aperiam fugiat laborum.
							Sequi mollitia, necessitatibus quae sint natus.</p>
						<small class="text-muted">Posted by Anonymous on 3/1/17</small>

					</div>
				</div>
				<!-- /.card -->

			</div>
			<!-- /.col-lg-9 -->

		</div>

	</div>
	<!-- /.container -->

	<!-- Footer -->
	<footer class="py-5 bg-dark">
		<div class="container">
			<p class="m-0 text-center text-white">Copyright &copy; Your
				Website 2017</p>
		</div>
		<!-- /.container -->
	</footer>

	<!-- Bootstrap core JavaScript -->
	<script
		src="https://blackrockdigital.github.io/startbootstrap-shop-item/vendor/jquery/jquery.min.js"></script>
	<script
		src="https://blackrockdigital.github.io/startbootstrap-shop-item/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script>

		function focusLogin() {

			$("form[action=login] input[name='usuario']").focus();

		}
	</script>

</body>

</html>