package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import vo.Goods;

public class GoodsOneDao {
	
	public Goods goodsOne(int goodsNo) throws Exception{
		
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall" ;
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "SELECT goods_title goodsTitle, goods_price goodsPrice, soldout, goods_memo goodsMemo, createdate, updatedate FROM goods WHERE goods_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, goodsNo );
		ResultSet rs = stmt.executeQuery();
		Goods g = null;
		if(rs.next()) {
			g = new Goods();
			g.setGoodsNo(goodsNo);
			g.setGoodsTitle(rs.getString("goodsTitle"));
			g.setGoodsPrice(rs.getInt("goodsPrice"));
			g.setSoldout(rs.getString("soldout"));
			g.setGoodsMemo(rs.getString("goodsMemo"));
			g.setCreatedate(rs.getString("createdate"));
			g.setUpdatedate(rs.getString("updatedate"));
		}
		
		conn.close();
		stmt.close();
		rs.close();
		
		return g;

	}
}
