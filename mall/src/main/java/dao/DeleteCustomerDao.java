package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class DeleteCustomerDao {

	public void deleteCustomer(int customerNo) throws Exception{
		
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall" ;
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		conn.setAutoCommit(false);
		
		String sql1 = "DELETE FROM customer_detail WHERE customer_no = ?";
		PreparedStatement stmt1 = conn.prepareStatement(sql1);
		stmt1.setInt(1, customerNo);
		int row1 = stmt1.executeUpdate();
		
		if(row1 != 1) {
			conn.rollback();
			return;
		}
		
		String sql2 = "DELETE FROM customer_addr WHERE customer_no = ?";
		PreparedStatement stmt2 = conn.prepareStatement(sql2);
		stmt2.setInt(1, customerNo);
		int row2 = stmt2.executeUpdate();
		
		if(row2 != 1) {
			conn.rollback();
			return;
		}
		
		String sql3 = "DELETE FROM customer_pw_history WHERE customer_no = ?";
		PreparedStatement stmt3 = conn.prepareStatement(sql3);
		stmt3.setInt(1, customerNo);
		int row3 = stmt3.executeUpdate();
		
		if(row3 != 1) {
			conn.rollback();
			return;
		}
		
		String sql4 = "DELETE FROM customer WHERE customer_no = ?";
		PreparedStatement stmt4 = conn.prepareStatement(sql4);
		stmt4.setInt(1, customerNo);
		int row4 = stmt4.executeUpdate();
		
		if(row4 != 1) {
			conn.rollback();
			return;
		}
		
		conn.commit();
		
		conn.close();
		stmt1.close();
		stmt2.close();
		
		stmt4.close();

	}
}
