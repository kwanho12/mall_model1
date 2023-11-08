package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

public class OrdersDao {

	public void orders(int customerNo) throws Exception {
		
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
				
		/*
		 * SELECT c.goods_no goodsNo, c.quantity quantity, g.goods_price goodsPrice, ca.address address
		 * FROM cart c INNER JOIN goods g 
		 * ON c.goods_no = g.goods_no INNER JOIN customer_addr ca 
		 * ON ca.customer_no = c.customer_no WHERE c.customer_no = ? 
		 * */
		String sql1 = "SELECT c.goods_no goodsNo, c.quantity quantity, g.goods_price goodsPrice, ca.customer_addr_no customerAddrNo FROM cart c INNER JOIN goods g ON c.goods_no = g.goods_no INNER JOIN customer_addr ca ON ca.customer_no = c.customer_no WHERE c.customer_no = ?";
		PreparedStatement stmt1 = conn.prepareStatement(sql1);
		stmt1.setInt(1,customerNo);
		ResultSet rs = stmt1.executeQuery();
		
		ArrayList<HashMap<String,Object>> list = new ArrayList<>();
		while(rs.next()) {
			HashMap<String,Object> map = new HashMap<>();
			map.put("goodsNo", rs.getInt("goodsNo"));
			map.put("quantity", rs.getInt("quantity"));
			map.put("goodsPrice", rs.getInt("goodsPrice"));
			map.put("customerAddrNo", rs.getString("customerAddrNo"));
			
			list.add(map);
		}
			
		for(HashMap<String,Object> map : list) {
			
			
			int totalPrice = (Integer) map.get("goodsPrice") * (Integer) map.get("quantity");
						
			/*
			 * INSERT INTO orders(goods_no, customer_no, customer_addr_no, quantity, total_price, orders_state, createdate, updatedate) 
			 * VALUES(?, ?, ?, ?, ?, '주문완료', NOW(), NOW())
			 * */
			String sql2 = "INSERT INTO orders(goods_no, customer_no, customer_addr_no, quantity, total_price, orders_state, createdate, updatedate) VALUES(?, ?, ?, ?, ?, '주문완료', NOW(), NOW())";
			PreparedStatement stmt2 = conn.prepareStatement(sql2);
			stmt2.setObject(1, map.get("goodsNo"));
			stmt2.setInt(2, customerNo);
			stmt2.setObject(3, map.get("customerAddrNo"));
			stmt2.setObject(4, map.get("quantity"));
			stmt2.setInt(5, totalPrice);
			
			int row = stmt2.executeUpdate();
			if(row != 1) {
				return;
			}
			stmt2.close();
		}
		
		conn.close();
		stmt1.close();
		rs.close();
		
	
	}
	
	public ArrayList<HashMap<String, Object>> orderList(int customerNo) throws Exception {
		
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		/*
		 * SELECT g.goods_title goodsTitle, o.quantity quantity, o.total_price totalPrice 
		 * FROM goods g INNER JOIN orders o 
		 * ON g.goods_no = o.goods_no WHERE o.customer_no = ?
		 * */
		String sql = "SELECT g.goods_title goodsTitle, o.orders_no ordersNo, o.quantity quantity, o.total_price totalPrice FROM goods g INNER JOIN orders o ON g.goods_no = o.goods_no WHERE o.customer_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, customerNo);
		
		ResultSet rs = stmt.executeQuery();
		ArrayList<HashMap<String, Object>> list = new ArrayList<>();
		while(rs.next()) {
			HashMap<String, Object> map = new HashMap<>();
			map.put("goodsTitle", rs.getString("goodsTitle"));
			map.put("ordersNo", rs.getInt("ordersNo"));
			map.put("quantity", rs.getInt("quantity"));
			map.put("totalPrice", rs.getInt("totalPrice"));

			list.add(map);
		}
		
		conn.close();
		stmt.close();
		rs.close();
		
		return list;
		
		
	}
	
	public void deleteOrder(int ordersNo) throws Exception {
		
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "DELETE FROM orders WHERE orders_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, ordersNo);
		
		int row = stmt.executeUpdate();
		if(row != 1) {
			return;
		}
		
		conn.close();
		stmt.close();

	}
}
