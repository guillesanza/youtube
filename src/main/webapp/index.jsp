<%
	/*
		Redireccionamos al HomeController para poder cargarla informacion
		necesaria en la vista home.jsp
	*/
	response.sendRedirect(request.getContextPath() + "/inicio");


	/*
		Tambien podemos usar el fichero "web.xml"
	*/
%>