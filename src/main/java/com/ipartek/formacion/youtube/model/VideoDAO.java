package com.ipartek.formacion.youtube.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.ipartek.formacion.youtube.pojo.Video;

public class VideoDAO implements CrudAble<Video> {

	private static VideoDAO INSTANCE = null;

	private final String SQL_GET_ALL = "SELECT id, codigo, nombre FROM video limit 1000;";
	private final String SQL_GET_BY_ID = "SELECT id, codigo, nombre  FROM video WHERE id = ?;";
	private final String SQL_UPDATE = "UPDATE video SET codigo=?, nombre=? WHERE id = ?;";
	private final String SQL_INSERT = "INSERT INTO video (codigo, nombre) VALUES (?,?);";
	private final String SQL_DELETE = "DELETE FROM video WHERE id=?;";

	private VideoDAO() {
		super();
	}

	public static synchronized VideoDAO getInstance() {
		if (INSTANCE == null) {
			INSTANCE = new VideoDAO();
		}
		return INSTANCE;
	}

	@Override
	public boolean insert(Video pojo) {

		boolean result = false;
		try (Connection con = ConnectionManager.getConnection();
				PreparedStatement ps = con.prepareStatement(SQL_INSERT, Statement.RETURN_GENERATED_KEYS);) {

			ps.setString(1, pojo.getCodigo());
			ps.setString(2, pojo.getNombre());


			int affectedRows = ps.executeUpdate();
			if (affectedRows == 1) {
				
				// Conseguir ID generado
				try (ResultSet rs = ps.getGeneratedKeys();) {
					
					while (rs.next()) {
						pojo.setId(rs.getLong(1));
						result = true;
					}
					
				} catch (Exception e) {
					e.getStackTrace();
					
				}

			}

		} catch (Exception e) {
			// TODO: handle exception
		}

		return result;
	}

	@Override
	public List<Video> getAll() {

		ArrayList<Video> videos = new ArrayList<>();
		try (Connection con = ConnectionManager.getConnection();
				PreparedStatement ps = con.prepareStatement(SQL_GET_ALL);) {
			ResultSet rs = ps.executeQuery();

			// mapear resultset a ArrayList
			Video v = null;
			while (rs.next()) {

				videos.add(rowwrapper(rs));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return videos;
	}

	@Override
	public Video getById(String id) {

		Video video = null;
		try (Connection con = ConnectionManager.getConnection();
				PreparedStatement ps = con.prepareStatement(SQL_GET_BY_ID)) {

			ps.setString(1, id);

			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					video = rowwrapper(rs);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return video;

	}

	@Override
	public boolean update(Video pojo) {
		boolean result = false;
		try (Connection con = ConnectionManager.getConnection();
				PreparedStatement ps = con.prepareStatement(SQL_UPDATE)) {

			ps.setString(2, pojo.getNombre());
			ps.setString(1, pojo.getCodigo());
			ps.setLong(3, pojo.getId());

			int affectedRows = ps.executeUpdate();
			if (affectedRows == 1) {
				result = true;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	@Override
	public boolean delete(String id) {
		boolean result = false;
		try (Connection con = ConnectionManager.getConnection();
				PreparedStatement ps = con.prepareStatement(SQL_DELETE)) {

			ps.setString(1, id);

			if (ps.executeUpdate() == 1) {
				result = true;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	public Video rowwrapper(ResultSet rs) throws Exception {
		Video v = new Video();
		if (rs != null) {
			v = new Video();
			v.setId(rs.getLong("id"));
			v.setCodigo(rs.getString("codigo"));
			v.setNombre(rs.getString("nombre"));
		}

		return v;
	}

}
