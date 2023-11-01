package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

public class CustomerListDao {
	
	public ArrayList<HashMap<String, Object>> customerList() throws Exception {
		
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		// 회원정보 조회 : 고객번호, id, 활동상태, 주소, 고객이름, 휴대폰 번호
		/*
		 * SELECT c.customer_no customerNo, c.customer_id customerId, c.active, cd.customer_name customerName, cd.customer_phone customerPhone, ca.address
		 * FROM customer c INNER JOIN customer_detail cd 
		 * ON c.customer_no = cd.customer_no INNER JOIN customer_addr ca 
		 * ON ca.customer_no = c.customer_no
		 * */
		String sql = "SELECT c.customer_no customerNo, c.customer_id customerId, c.active, cd.customer_name customerName, cd.customer_phone customerPhone, ca.address FROM customer c INNER JOIN customer_detail cd ON c.customer_no = cd.customer_no INNER JOIN customer_addr ca ON ca.customer_no = c.customer_no";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<>();
		while(rs.next()) { 
			
			HashMap<String, Object> c = new HashMap<>();
			
			c.put("customerNo", rs.getInt("customerNo"));
			c.put("customerId", rs.getString("customerId"));
			c.put("active", rs.getString("active"));
			c.put("customerName", rs.getString("customerName"));
			c.put("customerPhone", rs.getString("customerPhone"));
			c.put("address", rs.getString("address"));
			
			list.add(c);
		
		}
		
		return list;
	}
}
