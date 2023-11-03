package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import vo.Customer;
import vo.CustomerAddr;
import vo.CustomerDetail;
import vo.Manager;
import vo.ManagerPwHistory;

public class ManagerRegisterDao {
	public void register(Manager manager, ManagerPwHistory managerPwHistory) throws Exception{ 
		
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		conn.setAutoCommit(false);
		
		String sql1 = "INSERT INTO manager(manager_id, manager_pw, manager_name, createdate, updatedate, active) VALUES(?, password(?), ?, now(), now(), 'Y')";
		PreparedStatement stmt1 = conn.prepareStatement(sql1, Statement.RETURN_GENERATED_KEYS);
		stmt1.setString(1, manager.getManagerId());
		stmt1.setString(2, manager.getManagerPw());
		stmt1.setString(3, manager.getManagerName());
		System.out.println(stmt1 + "<--- stmt1 insertTest()");
		
		stmt1.executeUpdate();
		ResultSet rs1 = stmt1.getGeneratedKeys();
		
		int managerNo = 0;
		
		// AutoIncrement 값을 반환
		if(rs1.next()) {
			managerNo = rs1.getInt(1);
		} else {
			conn.rollback();
			return;
		}
				
		String sql2 = "INSERT INTO manager_pw_history(manager_no, manager_pw, createdate) VALUES(?, password(?), now() )";
		PreparedStatement stmt2 = conn.prepareStatement(sql2);
		stmt2.setInt(1, managerNo);
		stmt2.setString(2, manager.getManagerPw());
		System.out.println(stmt2 + "<--- stmt2 insertTest()");
		
		int row2 = stmt2.executeUpdate();
		if(row2 != 1) {
			conn.rollback();
			return;
		}
		
		conn.commit();
		stmt1.close();
		rs1.close();
		stmt2.close();
	}
}
