package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import vo.Customer;

public class LoginDao {
	
	public ResultSet login(Customer customer) throws Exception{
		
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "SELECT customer_no customerNo FROM customer WHERE customer_id=? AND customer_pw = PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, customer.getCustomerId());
		stmt.setString(2, customer.getCustomerPw());
		ResultSet rs = stmt.executeQuery();
		
		conn.close();
		stmt.close();
		rs.close();
		
		return rs;
	}
}
