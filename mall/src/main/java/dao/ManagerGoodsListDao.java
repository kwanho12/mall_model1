package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;


public class ManagerGoodsListDao{
	
	public int goodsListPaging(int currentPage, int rowPerPage) throws Exception{
	
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall" ;
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		// 페이징 sql
		String sql = "SELECT COUNT(*) FROM goods";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		int totalRow = 0;
		if(rs.next()) {
			totalRow = rs.getInt("COUNT(*)"); // rs1.getInt(1)
		}
		int lastPage = totalRow / rowPerPage;
		if(totalRow % rowPerPage != 0) {
			lastPage = lastPage + 1;
		}
		int beginRow = (currentPage-1)*rowPerPage;
		
		conn.close();
		stmt.close();
		rs.close();
		
		return beginRow;		
	}
	
	public ArrayList<HashMap<String,Object>> selectGoodsList(int beginRow, int rowPerPage) throws Exception {
		
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall" ;
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "SELECT g.goods_no goodsNo, g.goods_title goodsTitle, g.goods_price goodsPrice, g.soldout soldout, g.goods_memo goodsMemo, gi.filename filename FROM goods g INNER JOIN goods_img gi ON g.goods_no = gi.goods_no ORDER BY g.goods_no DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<>();
		while(rs.next()) {
			
			HashMap<String, Object> map = new HashMap<>();
			map.put("goodsNo", rs.getInt("goodsNo"));
			map.put("goodsTitle", rs.getString("goodsTitle"));
			map.put("goodsPrice", rs.getInt("goodsPrice"));
			map.put("soldout", rs.getString("soldout"));
			map.put("goodsMemo", rs.getString("goodsMemo"));
			map.put("filename", rs.getString("filename"));
			
			list.add(map);
		}
		
		return list;
	
	}
}
