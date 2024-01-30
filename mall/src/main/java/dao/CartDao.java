package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import vo.Cart;

public class CartDao {
	
	public void addCart(Cart c) throws Exception {
		
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://52.78.98.70/mall";
		String dbuser = "root";
		String dbpw = "rkskek12";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql ="INSERT INTO cart(goods_no, customer_no, quantity, createdate, updatedate) VALUES(?, ?, 1, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, c.getGoodsNo());
		stmt.setInt(2, c.getCustomerNo());
		
		int row = stmt.executeUpdate();
		if(row != 1) {
			conn.rollback();
			return;
		}
				
		conn.close();
		stmt.close();
	}
	
	public int getCartCount(int customerNo) throws Exception { 
		
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://52.78.98.70/mall";
		String dbuser = "root";
		String dbpw = "rkskek12";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "SELECT count(*) FROM cart WHERE customer_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, customerNo);
		ResultSet rs = stmt.executeQuery();
		int cartCount = 0;
		if(rs.next()) {
			cartCount = rs.getInt(1);
		}
		
		conn.close();
		stmt.close();
		rs.close();
		
		return cartCount;
	}
		
	public ArrayList<HashMap<String, Object>> cartList(int customerNo) throws Exception {
		
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://52.78.98.70/mall";
		String dbuser = "root";
		String dbpw = "rkskek12";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		/*
		 * SELECT g.goods_title goodsTitle, g.goods_price goodsPrice, ca.quantity quantity, gi.filename filename
		 * FROM goods g INNER JOIN cart ca 
		 * ON g.goods_no = ca.goods_no INNER JOIN goods_img gi
		 * ON gi.goods_no = g.goods_no
		 * WHERE ca.customer_no = ? 
		 * */
		String sql = "SELECT g.goods_title goodsTitle, g.goods_price goodsPrice, ca.cart_no cartNo ,ca.quantity quantity, gi.filename filename FROM goods g INNER JOIN cart ca ON g.goods_no = ca.goods_no INNER JOIN goods_img gi ON gi.goods_no = g.goods_no WHERE ca.customer_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, customerNo);
		ResultSet rs = stmt.executeQuery();
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<>();
		while(rs.next()) {
			
			HashMap<String, Object> map = new HashMap<>();
			map.put("goodsTitle", rs.getString("goodsTitle"));
			map.put("goodsPrice", rs.getInt("goodsPrice"));
			map.put("cartNo", rs.getInt("cartNo"));
			map.put("quantity", rs.getInt("quantity"));
			map.put("filename", rs.getString("filename"));
			
			list.add(map);
		}
		
		conn.close();
		stmt.close();
		rs.close();
		
		return list;
		
	}
	
	public ArrayList<Integer> getCartNo(int customerNo) throws Exception {
		
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://52.78.98.70/mall";
		String dbuser = "root";
		String dbpw = "rkskek12";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "SELECT cart_no cartNo FROM cart WHERE customer_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, customerNo);
		ResultSet rs = stmt.executeQuery();
		ArrayList<Integer> list = new ArrayList<>();
		while(rs.next()) {
			list.add(rs.getInt("cartNo"));
		}
		
		conn.close();
		stmt.close();
		rs.close();
		
		return list;
	}
	
	public void updateCart(ArrayList<Integer> cartsNo, HttpServletRequest request) throws Exception {
		
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://52.78.98.70/mall";
		String dbuser = "root";
		String dbpw = "rkskek12";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		for(int cartNo : cartsNo) { // 특정 고객에 대한 장바구니 번호들을 1개씩 가져 오기  [
			
			String cartNoToString = Integer.toString(cartNo);
			
			// <input> 태그의 이름을 cartNo로 설정했기 때문에 각각의 cartNo 에 대한 quantity를 가져 옴
			int updateQuantity = Integer.parseInt(request.getParameter(cartNoToString)); 
			
			String sql = "UPDATE cart SET quantity = ?, updatedate = now() WHERE cart_no = ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, updateQuantity);
			stmt.setInt(2, cartNo);
			stmt.executeUpdate();
			
			stmt.close();
			
		}
		
		conn.close();
	}
	
	public void deleteCart(int cartNo) throws Exception {
		
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://52.78.98.70/mall";
		String dbuser = "root";
		String dbpw = "rkskek12";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "DELETE FROM cart WHERE cart_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cartNo);
		stmt.executeUpdate();
	}
	
	
}
