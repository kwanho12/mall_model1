package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class AddGoodsDao {
	
	public void addGoods(String goodsTitle, int goodsPrice, String goodsMemo, String contentType, String filename, String originName) throws Exception{
		
		// DB product테이블 & image테이블에 입력
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall" ;
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql1 = "INSERT INTO goods(goods_title, goods_price, soldout, goods_memo, createdate, updatedate) VALUES(?, ?, 'N', ?, NOW(), NOW())";
		// 입력시 생성된 AutoIncrement값을 ResultSet 받아오는 옵션 매개값 Statement.RETURN_GENERATED_KEYS
		PreparedStatement stmt1 = conn.prepareStatement(sql1, Statement.RETURN_GENERATED_KEYS);
		stmt1.setString(1, goodsTitle);
		stmt1.setInt(2, goodsPrice);
		stmt1.setString(3, goodsMemo);
		int row1 = stmt1.executeUpdate();
		
		ResultSet rs = stmt1.getGeneratedKeys();
		int goodsNo = 0;
		if(rs.next()) {
			goodsNo = rs.getInt(1);
		}
		
		String sql2 = "INSERT INTO goods_img(goods_no, filename, origin_name, content_type, createdate, updatedate) VALUES(?, ?, ?, ?, NOW(), NOW())";
		PreparedStatement stmt2 = conn.prepareStatement(sql2);
		stmt2.setInt(1, goodsNo); // 
		stmt2.setString(2, filename); 
		stmt2.setString(3, originName); 
		stmt2.setString(4, contentType); 
		int row2 = stmt2.executeUpdate();
		
		stmt1.close();
		rs.close();
		stmt2.close();
		conn.close();

	}
}
