package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import vo.Customer;
import vo.CustomerAddr;
import vo.CustomerDetail;

public class RegisterDao {
	
	public void register(Customer customer, CustomerDetail customerDetail, CustomerAddr customerAddr) throws Exception{ 
	
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		conn.setAutoCommit(false);
		
		String sql1 = "INSERT INTO customer(customer_id, customer_pw, createdate, updatedate, active) VALUES(?, password(?), now(), now(), 'Y')";
		PreparedStatement stmt1 = conn.prepareStatement(sql1, Statement.RETURN_GENERATED_KEYS);
		stmt1.setString(1, customer.getCustomerId());
		stmt1.setString(2, customer.getCustomerPw());
		System.out.println(stmt1 + "<--- stmt1 insertTest()");
		
		stmt1.executeUpdate();
		ResultSet rs1 = stmt1.getGeneratedKeys();
		
		int customerNo = 0;
		
		// AutoIncrement 값을 반환
		if(rs1.next()) {
			customerNo = rs1.getInt(1);
		} else {
			conn.rollback();
			return;
		}
		
		String sql2 = "INSERT INTO customer_detail(customer_no, customer_name, customer_phone, createdate, updatedate) VALUES(?, ?, ?, now(), now() )";
		PreparedStatement stmt2 = conn.prepareStatement(sql2);
		stmt2.setInt(1, customerNo);
		stmt2.setString(2, customerDetail.getCustomerName());
		stmt2.setString(3, customerDetail.getCustomerPhone());
		System.out.println(stmt2 + "<--- stmt2 insertTest()");
		
		int row2 = stmt2.executeUpdate();
		if(row2 != 1) {
			conn.rollback();
			return;
		}
		
		String sql3 = "INSERT INTO customer_addr(customer_no, address, createdate, updatedate) VALUES(?, ?, now(), now() )";
		PreparedStatement stmt3 = conn.prepareStatement(sql3);
		stmt3.setInt(1, customerNo);
		stmt3.setString(2, customerAddr.getAddress());
		System.out.println(stmt3 + "<--- stmt3 insertTest()");
		
		int row3 = stmt3.executeUpdate();
		if(row3 != 1) {
			conn.rollback();
			return;
		}
		
		String sql4 = "INSERT INTO customer_pw_history(customer_no, customer_pw, createdate) VALUES(?, ?, now() )";
		PreparedStatement stmt4 = conn.prepareStatement(sql4);
		stmt4.setInt(1, customerNo);
		stmt4.setString(2, customer.getCustomerPw());
		System.out.println(stmt4 + "<--- stmt4 insertTest()");
		
		int row4 = stmt4.executeUpdate();
		if(row4 != 1) {
			conn.rollback();
			return;
		}
		
		conn.commit();
	}	
}
