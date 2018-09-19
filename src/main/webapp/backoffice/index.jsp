<%@page import="java.util.HashMap"%>
<%@page import="com.ipartek.formacion.youtube.pojo.Usuario"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<p>Solo pueden entrar usuarios logueados</p>
	<%
		Usuario u = (Usuario) session.getAttribute("usuario");
		if (u != null) {
	%>
	<p>Usuario nulo</p>
	<%
		} else {
	%>
	<p>
		Usuario:<%=u.getNombre()%>
	</p>
	<%
		}
	%>

	
	<%
	HashMap	<String ,Usuario> usuariosConectados = (HashMap<String ,Usuario>)application.getAttribute("uConectados");
	for (HashMap.Entry<String, Usuario> uConectado : usuariosConectados.entrySet()) {
		%>
			<li><%=uConectado.getValue().getNombre() %></li>
		
		<%
	}

	%>> 
</body>
</html>