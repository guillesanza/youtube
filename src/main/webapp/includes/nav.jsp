
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

			<div class="collapse navbar-collapse" id="navbarResponsive">
				<ul class="navbar-nav ml-auto">
					<li class="nav-item active">
						<!-- Usuario sin pasar por login -->
						<c:if test="${empty sessionScope.usuario}">
							 <!-- formulario Login -->
							<form action="login" method="post" class="d-flex flex-row mt-2 mt-md-0">
								<input name="usuario" value="${cookie['nombreUsuario'].getValue()}" class="form-control mr-sm-2" type="text" placeholder="nombre" required pattern=".{3,30}">
								<input name="pass" value="" class="form-control mr-sm-2" type="password" placeholder="Contraseña" required pattern=".{2,50}">
								<div class="input-group mr-sm-2">
								  <div class="input-group-prepend">
								    <div class="input-group-text">
								      <input type="checkbox" aria-label="Checkbox for following text input" name="guardarUsuario" ${empty cookie['nombreUsuario'].getValue()?"":"checked"}>
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
									<p> ${cookie['nombreUsuario'].getValue()}</p>
									<a href="logout">Logout</a>
									<a href="backoffice/index.jsp">Backoffice</a>
								</div>
							</div>
						</c:if>
					</li>

				</ul>
				<ul class="navbar-nav ml-auto idioma">
		     		<li class="nav-item ${(sessionScope.idioma eq 'es_ES')?'active':''}"><a href="inicio?idioma=es_ES">es</a></li>
		     		<li class="nav-item ${(sessionScope.idioma eq 'eu_ES')?'active':''}"><a href="inicio?idioma=eu_ES">eu</a></li>
		     		<li class="nav-item ${(sessionScope.idioma eq 'en_EN')?'active':''}"><a href="inicio?idioma=en_EN">en</a></li>
		     	</ul>


			</div>
		</div>
	</nav>