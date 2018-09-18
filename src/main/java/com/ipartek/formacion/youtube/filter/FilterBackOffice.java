package com.ipartek.formacion.youtube.filter;

import java.io.IOException;

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
				responseHttp.sendRedirect(requestHttp.getContextPath() + "/inicio");
			}
			// pass the request along the filter chain
			chain.doFilter(request, response);

		} catch (Exception e) {
			responseHttp.sendRedirect(requestHttp.getContextPath() + "/inicio");
		}

	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// Se ejecuta al iniciar la app
	}

}
