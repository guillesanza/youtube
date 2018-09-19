package com.ipartek.formacion.youtube.filter;

import java.io.IOException;
import java.util.Enumeration;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ipartek.formacion.youtube.pojo.Usuario;

/**
 * Filtramos todas la request que coincidan con urlPattern = {"/backoffice/*"}
 * <br>
 * Comprobamos que el usuario haya pasado por el login para dejarle continuar.
 * <br>
 * Si el usuario no se ha logeado => redirect "/incio"
 */
@WebFilter("/backoffice/*")
public class FilterBackOffice implements Filter {

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// Se ejecuta al destruir el hilo
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		// TODO Auto-generated method stub
		// place your code here
		HttpServletRequest requestHttp = (HttpServletRequest) request;
		HttpServletResponse responseHttp = (HttpServletResponse) response;
		HttpSession session = requestHttp.getSession();

		try {
			Usuario u = (Usuario) session.getAttribute("usuario");
			if (u != null) {
				chain.doFilter(request, response);
			} else {

				// Usuario no logeado
				informacionCliente(requestHttp);
				responseHttp.sendRedirect(requestHttp.getContextPath() + "/inicio");
				
			}

		} catch (Exception e) {
			responseHttp.sendRedirect(requestHttp.getContextPath() + "/inicio");
		}

	}

	private void informacionCliente(HttpServletRequest req) {

		System.out.println("-------------------------------------");
		System.out.println("LOCAL");
		System.out.println("Local host:" + req.getLocalAddr());
		System.out.println("Local host:" + req.getLocalPort());
		System.out.println("Local host:" + req.getLocalAddr());
		System.out.println("Local host:" + req.getLocalName());
		System.out.println();
		System.out.println("Remote");
		System.out.println("Remote host: " + req.getRemoteHost());
		System.out.println("Remote addr: " + req.getRemoteAddr());
		System.out.println("Remote port: " + req.getRemotePort());
		System.out.println("Remote user: " + req.getRemoteUser());
		System.out.println();
		Enumeration<String> nombresCabeceras = req.getHeaderNames();
		String nombre;
		while (nombresCabeceras.hasMoreElements()) {
			nombre = (String) nombresCabeceras.nextElement();
			System.out.println(nombre + ":" + req.getHeader(nombre));
		}

		Map<String, String[]> parametros = req.getParameterMap();
		for (Map.Entry<String, String[]> param : parametros.entrySet()) {
			System.out.println(param.getKey() + ":");
			for(String value : param.getValue()) {
				System.out.println(value);
			}
		}

		System.out.println("-------------------------------------");

	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// Se ejecuta al iniciar la app
	}

}
