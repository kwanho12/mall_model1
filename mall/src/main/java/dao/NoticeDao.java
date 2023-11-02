package dao;
import java.util.*;
import java.sql.*;

public class NoticeDao {
		
	//호출(controller)	: contact.jsp - 공지사항(table:notice)데이터를 문의사항 위에 출력
	public ArrayList<HashMap<String,Object>> selectNoticeList() throws Exception{
		
		// db핸들링(model)
		Class.forName("org.mariadb.jdbc.Driver");		// DB Driver클래스 코드
		System.out.println("드라이브 로딩 성공");	// DB 드라이브 로딩 확인 디버깅
		// DB연결에 필요한 정보를 변수에 담아줌 (가독성)
		String url = "jdbc:mariadb://localhost:3306/mall";		
		String dbuser = "root";
		String dbpw = "java1234";
		//DB연결을 위한 Connection객체 생성, 연결
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		System.out.println("DB접속 성공");	//DB접속 확인 디버깅
		
		/*	공지사항리스트 : 번호, 매니져번호(관리자페이지), 매니져이름(관리자페이지), 공지제목, 공지내용, 작성일, 수정일
		 *SELECT n.notice_no noticeNo, n.manager_no managerNo, n.notice_title noticeTitle, n.notice_content noticeContent, n.createdate createdate, n.updatedate updatedate, m.manager_name managerName
				FROM notice n INNER JOIN manager m
				ON n.manager_no = m.manager_no;
		 */
		
		String sql = "SELECT n.notice_no noticeNo, n.manager_no managerNo, n.notice_title noticeTitle, n.notice_content noticeContent, n.createdate createdate, n.updatedate updatedate, m.manager_name managerName FROM notice n INNER JOIN manager m ON n.manager_no = m.manager_no";
		PreparedStatement stmt=conn.prepareStatement(sql);
		System.out.println(stmt + "<--stmt");	//쿼리문 확인 디버깅
		ResultSet rs = stmt.executeQuery();	//jdbc환경의 모델
		ArrayList<HashMap<String,Object>> list = new ArrayList<>();
		while(rs.next()) {
			
			HashMap<String, Object> n = new HashMap<>();
			
			n.put("noticeNo", rs.getInt("noticeNo"));
			n.put("managerNo", rs.getString("managerNo"));
			n.put("noticeTitle", rs.getString("noticeTitle"));
			n.put("noticeContent", rs.getString("noticeContent"));
			n.put("createdate", rs.getString("createdate"));
			n.put("updatedate", rs.getString("updatedate"));
			n.put("managerName", rs.getString("managerName"));
			
			list.add(n);
		}
		//end model code	
		
		return list;		
	}
	
	
}
