package com.ipartek.formacion.youtube.controller;

import java.io.IOException;
import java.util.Locale;
import java.util.ResourceBundle;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ipartek.formacion.youtube.pojo.Alert;
import com.ipartek.formacion.youtube.pojo.Usuario;

/**
 * Servlet implementation class LoginController
 */
@WebServlet("/login")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doProcess(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doProcess(request, response);
	}

	private void doProcess(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		Alert alert = new Alert();
		HttpSession session = request.getSession();

		try {
			
			String idioma = ( session.getAttribute("idioma")!=null ? (String)session.getAttribute("idioma"):"es_ES");
			Locale locale = new Locale(idioma.split("_")[0],idioma.split("_")[1]);
			ResourceBundle idiomas=ResourceBundle.getBundle("idiomas",locale);
			
			
			//idioma = request.getLocale();
			System.out.println(idiomas.getString("msj.bienvenida"));
			
			
			// recoger parametros
			String usuarioNombre = request.getParameter("usuario");
			String pass = request.getParameter("pass");

			// comprobar usuario
			if ("admin".equals(pass) && "admin".equals(usuarioNombre)) {

				alert.setTexto(idiomas.getString("msj.bienvenida") + usuarioNombre);
				alert.setTipo(Alert.PRIMARY);

				// guardar Usuario en session
				Usuario u = new Usuario(usuarioNombre, pass);

				gestionarCookies(request, response, u);

				session.setAttribute("usuario", u);
				session.setMaxInactiveInterval(60 * 5); // 5min

			} else {

				alert.setTexto("Credenciales incorrectas");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.setAttribute("alert", alert);
			// request.getRequestDispatcher("home.jsp").forward(request, response);
			response.sendRedirect(request.getContextPath() + "/inicio");
		}

	}

	private void gestionarCookies(HttpServletRequest request, HttpServletResponse response, Usuario u) {

		Boolean guardarCoockie = (Boolean) ("on".equals(request.getParameter("guardarUsuario")) ? true : false);
		Cookie nombreUsuario = new Cookie("nombreUsuario", u.getNombre());
		if (guardarCoockie) {
			// Creamos y guardamos la cookie del usuario
			nombreUsuario.setMaxAge(60 * 60 * 24 * 30 * 3);
		} else {
			// Eliminamos la cookie
			nombreUsuario.setMaxAge(0);
		}
		response.addCookie(nombreUsuario);

	}

}