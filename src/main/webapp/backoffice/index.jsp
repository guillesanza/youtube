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
		Usuario u = (Usuario)session.getAttribute("usuario");
		if(u != null){
			%>
			<p>Usuario nulo</p>
			<%
		}else{
			%>
			<p>Usuario:<%=u.getNombre()%> </p>	
			<%
		}
	%>

</body>
</html>