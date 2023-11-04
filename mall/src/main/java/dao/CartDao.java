package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

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
	
	public int getCartCount() throws Exception{
		
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
	
}
