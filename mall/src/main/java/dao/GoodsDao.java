package dao;

import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import vo.Goods;

public class GoodsDao {
	
	public void addGoods(String goodsTitle, int goodsPrice, String goodsMemo, String contentType, String filename, String originName) throws Exception{
		
		// DB product테이블 & image테이블에 입력
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall" ;
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		conn.setAutoCommit(false);
		
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
		
		if(row1 != 1) {
			conn.rollback();
			return;
		}
		
		String sql2 = "INSERT INTO goods_img(goods_no, filename, origin_name, content_type, createdate, updatedate) VALUES(?, ?, ?, ?, NOW(), NOW())";
		PreparedStatement stmt2 = conn.prepareStatement(sql2);
		stmt2.setInt(1, goodsNo); // 
		stmt2.setString(2, filename); 
		stmt2.setString(3, originName); 
		stmt2.setString(4, contentType); 
		int row2 = stmt2.executeUpdate();
		
		if(row2 != 1) {
			conn.rollback();
			return;
		}
		
		conn.commit();
		
		stmt1.close();
		rs.close();
		stmt2.close();
		conn.close();

	}
	
	public int goodsListPaging() throws Exception{
		
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
		
		conn.close();
		stmt.close();
		rs.close();
		
		return totalRow;
	}
	
	public int goodsSearchListPaging(String search) throws Exception{
		
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall" ;
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		// search 페이징 sql
		String sql = "SELECT COUNT(*) FROM goods WHERE goods_title LIKE CONCAT('%',?,'%') OR goods_memo LIKE CONCAT('%',?,'%')";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, search);
		stmt.setString(2, search);
		ResultSet rs = stmt.executeQuery();
		int totalRow = 0;
		if(rs.next()) {
			totalRow = rs.getInt("COUNT(*)"); // rs1.getInt(1)
		}
		
		conn.close();
		stmt.close();
		rs.close();
		
		return totalRow;
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
	
	public String deleteGoods(int goodsNo) throws Exception{
		
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall" ;
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		conn.setAutoCommit(false);
		
		// 상품 번호로 저장된 파일 이름 찾기(파일을 삭제하기 위함)
		String sql1 = "SELECT filename FROM goods_img WHERE goods_no = ?";
		PreparedStatement stmt1 = conn.prepareStatement(sql1);
		stmt1.setInt(1, goodsNo);
		ResultSet rs = stmt1.executeQuery();
		String filename = null; // 파일 삭제시 사용
		if(rs.next()) {
			filename = rs.getString("filename"); 
		}
		
		// goods_img 테이블의 데이터 제거
		String sql2= "DELETE FROM goods_img WHERE goods_no = ?";
		PreparedStatement stmt2 = conn.prepareStatement(sql2);
		stmt2.setInt(1, goodsNo);
		
		int row1 = stmt2.executeUpdate();
		if(row1 != 1) {
			conn.rollback();
			return "";
		}
		
		// cart 테이블의 데이터 제거
		String sql3= "DELETE FROM cart WHERE goods_no = ?";
		PreparedStatement stmt3 = conn.prepareStatement(sql3);
		stmt3.setInt(1, goodsNo);
		int row2 = stmt3.executeUpdate();
		// 카트는 삭제되는 행의 값이 없을 수도 있으므로 rollback 처리를 하지 않는다.
		
		
		// goods_img 테이블의 데이터가 제거 완료되면 goods 테이블의 데이터 제거
		String sql4 = "DELETE FROM goods WHERE goods_no = ?";
		PreparedStatement stmt4 = conn.prepareStatement(sql4);
		stmt4.setInt(1, goodsNo);
		
		int row3 = stmt4.executeUpdate();
		if(row3 != 1) {
			conn.rollback();
			return "";		
		} 

		conn.commit();
		
		conn.close();
		stmt1.close();
		rs.close();
		stmt2.close();
		stmt3.close();
		stmt4.close();
			
		return filename;
		
	}
	
	public String getOldFilename(int goodsNo) throws Exception {
		
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall" ;
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw); // 기본값 자동 커밋
		
		// 수정 전 파일의 저장 이름 가져 오기(oldName)
		String sql1 = "SELECT filename FROM goods_img WHERE goods_no = ?";
		PreparedStatement stmt1 = conn.prepareStatement(sql1);
		stmt1.setInt(1, goodsNo);
		ResultSet rs = stmt1.executeQuery();
		String oldName = null;
		if(rs.next()) {
			oldName = rs.getString("filename");
		}
		
		conn.close();
		stmt1.close();
		rs.close();
		
		return oldName;
		
	}
	

	public void updateGoods(Goods g, String updateName, String name, String contentType, String oldName, String uploadPath) throws Exception {
		
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall" ;
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw); // 기본값 자동 커밋
		conn.setAutoCommit(false); // 수동 커밋(conn.commit()메서드를 코드에 호출 필요)
		
		// 상품 테이블 수정
		String sql1 = "UPDATE goods SET goods_title = ?, goods_price = ?, soldout = ?, goods_memo = ?, updatedate = NOW() WHERE goods_no = ?";
		PreparedStatement stmt1 = conn.prepareStatement(sql1);
		stmt1.setString(1, g.getGoodsTitle());
		stmt1.setInt(2, g.getGoodsPrice());
		stmt1.setString(3, g.getSoldout());
		stmt1.setString(4, g.getGoodsMemo());
		stmt1.setInt(5, g.getGoodsNo());
		
		int row1 = stmt1.executeUpdate();
		if(row1 != 1) { // 잘못된 수정 or 실패
			conn.rollback();
			return;
		}
		
		if(updateName != null) {
			
			// 이미지 수정 : 이전 이미지 삭제 -> 이미지 테이블 수정
			File oldFile = new File(uploadPath+"/"+oldName);
			if(oldFile.exists()) {
				oldFile.delete();
			}
			
			// 이미지 테이블 수정
			String sql2= "UPDATE goods_img SET filename = ?, origin_name = ?, content_type = ?  WHERE goods_no = ?";
			PreparedStatement stmt2 = conn.prepareStatement(sql2);
			stmt2.setString(1, updateName);
			stmt2.setString(2, name);
			stmt2.setString(3, contentType);
			stmt2.setInt(4, g.getGoodsNo());
			int row2 = stmt2.executeUpdate();
			if(row2 != 1) {
				// 잘못된 수정 or 실패
				conn.rollback();
				return;
				
			}
			stmt2.close();
		}
		
		// 트랜젝션 처리
		conn.commit(); 
		
		conn.close();
		stmt1.close();

	}
	
	public ArrayList<HashMap<String,Object>> searchGoodsList(String search, int beginRow, int rowPerPage) throws Exception {
		
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall" ;
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		/*
		 * SELECT g.goods_no goodsNo, g.goods_title goodsTitle, g.goods_price goodsPrice, g.soldout soldout, g.goods_memo goodsMemo, gi.filename filename 
		 * FROM goods g INNER JOIN goods_img gi 
		 * ON g.goods_no = gi.goods_no 
		 * WHERE g.goods_title LIKE CONCAT('%',?,'%')
		 * OR g.goods_memo LIKE CONCAT('%',?,'%') 
		 * ORDER BY g.goods_no DESC LIMIT ?, ?
		 * */
		String sql = "SELECT g.goods_no goodsNo, g.goods_title goodsTitle, g.goods_price goodsPrice, g.soldout soldout, g.goods_memo goodsMemo, gi.filename filename FROM goods g INNER JOIN goods_img gi ON g.goods_no = gi.goods_no WHERE g.goods_title LIKE CONCAT('%',?,'%') OR g.goods_memo LIKE CONCAT('%',?,'%') ORDER BY g.goods_no DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, search);
		stmt.setString(2, search);
		stmt.setInt(3, beginRow);
		stmt.setInt(4, rowPerPage);
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
