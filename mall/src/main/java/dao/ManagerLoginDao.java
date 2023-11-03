package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import vo.Manager;

public class ManagerLoginDao {
	
		public ResultSet login(Manager manager) throws Exception{
		
			Class.forName("org.mariadb.jdbc.Driver");
			String url = "jdbc:mariadb://localhost:3306/mall";
			String dbuser = "root";
			String dbpw = "java1234";
			Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
			
			String sql = "SELECT manager_id managerId FROM manager WHERE manager_id=? AND manager_pw = PASSWORD(?)";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, manager.getManagerId());
			stmt.setString(2, manager.getManagerPw());
			System.out.println(stmt+" <--stmt");
			ResultSet rs = stmt.executeQuery();
			
			conn.close();
			stmt.close();
			rs.close();
			
			return rs;
		}
}
