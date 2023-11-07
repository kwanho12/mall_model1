package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

public class OrdersDao {

	public void Orders(int customerNo) throws Exception {
		
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
			/*
			 * INSERT INTO orders(goods_no goodsNo, customer_no customerNo, customer_addr_no customerAddrNo, quantity, total_price totalPrice, orders_state ordersState, createdate, updatedate) 
			 * VALUES(?, ?, ?, ?, ?, '주문완료', NOW(), NOW())
			 * */
			
			int totalPrice = (Integer) map.get("goodsPrice") * (Integer) map.get("quantity");
			System.out.println(totalPrice);
			
			String sql = "INSERT INTO orders(goods_no goodsNo, customer_no customerNo, customer_addr_no customerAddrNo, quantity, total_price totalPrice, orders_state ordersState, createdate, updatedate) VALUES(?, ?, ?, ?, ?, '주문완료', NOW(), NOW())";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, (Integer) map.get("goodsNo"));
			stmt.setInt(2, customerNo);
			stmt.setInt(3, (Integer) map.get("customerAddrNo"));
			stmt.setInt(4, (Integer) map.get("quantity"));
			stmt.setInt(5, totalPrice);
			
			int row = stmt.executeUpdate();
			if(row != 1) {
				return;
			}
		}
		
		
	}
}
