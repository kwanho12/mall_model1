package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import vo.Cart;

public class CartDao {
	
	public void addCart(Cart c) throws Exception {
		
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql ="INSERT INTO cart(goods_no, customer_no, quantity, createdate, updatedate) VALUES(?, ?, 1, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, c.getGoodsNo());
		stmt.setInt(2, c.getCustomerNo());
		
		int row = stmt.executeUpdate();
		System.out.println(row);
		if(row != 1) {
			conn.rollback();
			return;
		}
				
		conn.close();
		stmt.close();
	}
	
	public int getCartCount() throws Exception { 
		
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "SELECT count(*) FROM cart";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		int cartCount = 0;
		if(rs.next()) {
			cartCount = rs.getInt(1);
		}
		
		return cartCount;
	}
		
	public ArrayList<HashMap<String, Object>> cartList(int customerNo) throws Exception {
		
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		/*
		 * SELECT g.goods_title goodsTitle, g.goods_price goodsPrice, ca.quantity quantity, gi.filename filename
		 * FROM goods g INNER JOIN cart ca 
		 * ON g.goods_no = ca.goods_no INNER JOIN goods_img gi
		 * ON gi.goods_no = g.goods_no
		 * WHERE ca.customer_no = ? 
		 * */
		String sql = "SELECT g.goods_title goodsTitle, g.goods_price goodsPrice, ca.quantity quantity, gi.filename filename FROM goods g INNER JOIN cart ca ON g.goods_no = ca.goods_no INNER JOIN goods_img gi ON gi.goods_no = g.goods_no WHERE ca.customer_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, customerNo);
		ResultSet rs = stmt.executeQuery();
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<>();
		while(rs.next()) {
			
			HashMap<String, Object> map = new HashMap<>();
			map.put("goodsTitle", rs.getString("goodsTitle"));
			map.put("goodsPrice", rs.getString("goodsPrice"));
			map.put("quantity", rs.getString("quantity"));
			map.put("filename", rs.getString("filename"));
			
			list.add(map);
		}
		
		conn.close();
		stmt.close();
		rs.close();
		
		return list;
		
	}
	
	
}
