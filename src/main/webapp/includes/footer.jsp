	<!-- Footer -->
<%@page import="java.util.Date"%>
<footer class="py-5 bg-dark">
		<div class="container">
			<c:set var="anyo" value="<%= new java.util.Date() %>"/>
			<p class="m-0 text-center text-white">
				Copyright &copy; Your Website <fmt:formatDate type="Both" pattern="yyyy MM" value="${anyo}"/>
				<!-- https://docs.oracle.com/javase/7/docs/api/java/text/SimpleDateFormat.html -->
			</p>
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