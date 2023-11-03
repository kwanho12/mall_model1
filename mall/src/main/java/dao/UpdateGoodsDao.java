package dao;

import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import vo.Goods;

public class UpdateGoodsDao {
	
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
		
		// 수정 전 파일의 저장 이름 가져 오기(oldName)
		String sql1 = "SELECT filename FROM goods_img WHERE goods_no = ?";
		PreparedStatement stmt1 = conn.prepareStatement(sql1);
		stmt1.setInt(1, g.getGoodsNo());
		ResultSet rs = stmt1.executeQuery();
		oldName = null;
		if(rs.next()) {
			oldName = rs.getString("filename");
		}
		
		// 상품 테이블 수정
		String sql2 = "UPDATE goods SET goods_title = ?, goods_price = ?, soldout = ?, goods_memo = ? WHERE goods_no = ?";
		PreparedStatement stmt2 = conn.prepareStatement(sql2);
		stmt2.setString(1, g.getGoodsTitle());
		stmt2.setInt(2, g.getGoodsPrice());
		stmt2.setString(3, g.getSoldout());
		stmt2.setString(4, g.getGoodsMemo());
		stmt2.setInt(5, g.getGoodsNo());
		
		int row1 = stmt2.executeUpdate();
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
			String sql3 = "UPDATE goods_img SET filename = ?, origin_name = ?, content_type = ?  WHERE goods_no = ?";
			PreparedStatement stmt3 = conn.prepareStatement(sql3);
			stmt3.setString(1, updateName);
			stmt3.setString(2, name);
			stmt3.setString(3, contentType);
			stmt3.setInt(4, g.getGoodsNo());
			int row2 = stmt3.executeUpdate();
			if(row2 != 1) {
				// 잘못된 수정 or 실패
				conn.rollback();
				return;
				
			}
			stmt3.close();
		}
		
		// 트랜젝션 처리
		conn.commit(); 
		
		conn.close();
		stmt1.close();
		stmt2.close();
		rs.close();
	
	}
}
