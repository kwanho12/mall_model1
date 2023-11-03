package dao;

import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.HttpServletRequest;

public class DeleteGoodsDao {
	
	public void deleteGoods(int goodsNo, HttpServletRequest request) throws Exception{
		
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
		if(row1 == 1) {
			
			// goods_img 테이블의 데이터가 제거 완료되면 goods 테이블의 데이터 제거
			String sql3 = "DELETE FROM goods WHERE goods_no = ?";
			PreparedStatement stmt3 = conn.prepareStatement(sql3);
			stmt3.setInt(1, goodsNo);
			
			int row2 = stmt3.executeUpdate();
			if(row2 == 1) {
				conn.commit();
			} else {
				conn.rollback();
				return;
			}
		}
		
		// 파일삭제
		// String path = request.getServletContext().getRealPath("/upload");
		String path = "/Users/jkh/Desktop/DB/mall-gitRepository/mall/mall/src/main/webapp/upload";
		File f = new File(path+"/"+filename);
		if(f.exists()) {
			f.delete();
		}
	}
}
