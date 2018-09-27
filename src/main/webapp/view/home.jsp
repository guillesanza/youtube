<%@ include file="../includes/header.jsp" %>

	<!-- Page Content -->
	<div class="container">
		<c:if test="${empty alert}">
			${alert = null}
		</c:if>
		<c:if test="${not empty alert}">
			<div class="container">
				<div class="alert ${alert.tipo} alert-dismissible fade show" role="alert">
					<p>${alert.texto}</p>
					<button type="button" class="close" data-dismiss="alert"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
			</div>
		</c:if>
		<div class="row">
			<div class="col-lg-3">
				<h4 class="my-4 text-center"><fmt:message key="lista.reproduccion" /></h4>
				
				
				<ul class="list-group">
					<c:forEach items="${videos}" var="v">
						<li	class="list-group-item d-flex justify-content-between align-items-center">
							<a href="inicio?id=${v.id}">${v.nombre}</a>
							<a href="inicio?id=${v.id}%>&op=<${HomeController.OP_ELIMINAR}">
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
								<a href="inicio?id=${v.id}">${v.nombre}</a>
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
					<iframe id="iframe" width="823" height="415" src="https://www.youtube.com/embed/${videoInicio.codigo}?autoplay=1" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
					<div class="card-body">
						<h3 class="card-title"><${videoInicio.nombre}></h3>
						<p class="card-text">Lorem ipsum dolor sit amet, consectetur
							adipisicing elit. Sapiente dicta fugit fugiat hic aliquam itaque
							facere, soluta. Totam id dolores, sint aperiam sequi pariatur
							praesentium animi perspiciatis molestias iure, ducimus!</p>
						<span class="text-warning">&#9733; &#9733; &#9733; &#9733;&#9734;</span> 4.0 stars
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

<%@ include file="../includes/footer.jsp" %>	