package com.ipartek.formacion.youtube.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Locale;
import java.util.ResourceBundle;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ipartek.formacion.youtube.model.VideoDAO;
import com.ipartek.formacion.youtube.pojo.Alert;
import com.ipartek.formacion.youtube.pojo.Video;

/**
 * Servlet implementation class HomeController
 */
@WebServlet("/inicio")
public class HomeController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public static final String OP_ELIMINAR = "1";
	public static final String OP_MODIFICAR = "2";
	// private static VideoArrayListDAO dao_old;
	private static VideoDAO dao;
	private ArrayList<Video> videos;
	private Video videoInicio;

	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		// Se ejecuta solo con la 1º petición, el resto de peticiones iran a "service"
		dao = VideoDAO.getInstance();

	}

	@Override
	public void destroy() {
		super.destroy();
		// se ejecuta al parar el servidor
		dao = null;
	}

	/**
	 * Cada request se ejecuta en un hilo o thread
	 */
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		super.service(request, response);
		// idiomas
		HttpSession session = request.getSession();
		String idioma = request.getParameter("idioma");

		try {

			if (idioma == null) {
				idioma = (String) session.getAttribute("idioma");
			}

			if (idioma == null) {
				// conseguir idioma del usuario a traves de la request
				/*
				 * idioma = request.getLocale().toString(); if ( idioma.length() != 5 ) { idioma
				 * = "es_ES"; }
				 */

				idioma = "es_ES";
			}
		} catch (Exception e) {
			idioma = "es_ES";
		} finally {
			// guardar en session
			session.setAttribute("idioma", idioma);
		}
		// Locale locale = new Locale("en", "EN");
		Locale locale = new Locale(idioma.split("_")[0], idioma.split("_")[1]);
		ResourceBundle idiomas = ResourceBundle.getBundle("idiomas", locale);

		// despues de realizar GET o POST
		request.setAttribute("videos", videos);
		request.setAttribute("videoInicio", videoInicio);

		String playList = "";
		for (int i = 1; i < videos.size(); i++) {
			playList += videos.get(i).getCodigo() + ",";
		}

		request.setAttribute("playList", playList);

		request.getRequestDispatcher("view/home.jsp").forward(request, response);

	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		Alert alert = null;

		try {

			// parametros
			String id = request.getParameter("id");
			String op = request.getParameter("op");

			// eliminar ?
			if (op != null && OP_ELIMINAR.equals(op)) {
				if (dao.delete(id)) {
					alert = new Alert(Alert.SUCCESS, "Video Eliminado correctamente");

				} else {
					alert = new Alert();

				}
			}

			// listado videos
			videos = (ArrayList<Video>) dao.getAll();

			// video de inicio
			videoInicio = new Video();
			if (id != null && !OP_ELIMINAR.equals(op)) {

				videoInicio = dao.getById(id);

				HttpSession session = request.getSession();
				// Si esta logueado
				if (session.getAttribute("usuario") != null) {

					ArrayList<Video> videosReproducidos = (ArrayList<Video>) session.getAttribute("videosReproducidos");

					if (videosReproducidos == null) {
						videosReproducidos = new ArrayList<Video>();
					}
					videosReproducidos.add(videoInicio);
					session.setAttribute("videosReproducidos", videosReproducidos);
				}

			} else if (!videos.isEmpty()) {
				videoInicio = videos.get(0);
			}

		} catch (Exception e) {
			e.printStackTrace();
			alert = new Alert();
		} finally {

		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		Alert alert = null;
		try {

			String op = request.getParameter("op");
			String id = request.getParameter("id");

			// recoger parametros
			String codigo = request.getParameter("codigo");
			String nombre = request.getParameter("nombre");

			if (op != null && OP_MODIFICAR.equals(op)) {

				Video v = dao.getById(id);
				v.setNombre(nombre);
				
			} else {
				// insertar
				videoInicio = new Video(codigo, nombre);
				if (dao.insert(videoInicio)) {
					alert = new Alert(Alert.SUCCESS, "Gracias por subir tu vídeo");
				} else {
					alert = new Alert(Alert.WARNING, "Error, no se pudo crear el vídeo, por favor asegurese de que no está duplicado el vídeo");

				}

			}

			// pedir listado
			videos = (ArrayList<Video>) dao.getAll();

		} catch (Exception e) {
			e.printStackTrace();
			alert = new Alert();
		} finally {
			request.setAttribute("alert", alert);

		}
	}

}