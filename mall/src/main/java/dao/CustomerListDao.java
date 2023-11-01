package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

public class CustomerListDao {
	
	public void customerList() throws Exception {
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		// 회원정보 조회 : 고객번호, id, 비밀번호, 주소, 고객이름, 휴대폰 번호 
		String sql = "SELECT customer_no customerNo, customer_id customerId, createdate, updatedate, active FROM customer";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<>();
		while(rs.next()) { 
			
			HashMap<String, Object> c = new HashMap<>();
			
			c.put("customerNo", rs.getInt("customerNo"));
			c.put("customerId", rs.getString("customerId"));
			c.put("createdate", rs.getString("createdate"));
			c.put("updatedate", rs.getString("updatedate"));
			c.put("active", rs.getString("active"));
			
			list.add(c);
		
		}
	}
}
