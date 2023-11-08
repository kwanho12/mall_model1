package dao;
import java.util.*;

import vo.Notice;

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
		
		/*	공지사항리스트 : 번호, 매니져이름, 공지제목,  작성일 - 최근 2개의 공지만 보이게
		 SELECT n.notice_no noticeNo, n.notice_title noticeTitle, n.createdate createdate, m.manager_name managerName
			FROM notice n INNER JOIN manager m
			ON n.manager_no = m.manager_no
			ORDER BY n.createdate DESC
			LIMIT 0,2;
		 */
		
		String sql = "SELECT n.notice_no noticeNo, n.notice_title noticeTitle, n.createdate createdate, m.manager_name managerName FROM notice n INNER JOIN manager m ON n.manager_no = m.manager_no ORDER BY n.createdate DESC LIMIT 0,2";
		PreparedStatement stmt=conn.prepareStatement(sql);
		System.out.println(stmt + "<--stmt");	//쿼리문 확인 디버깅
		ResultSet rs = stmt.executeQuery();	//jdbc환경의 모델
		ArrayList<HashMap<String,Object>> list = new ArrayList<>();
		while(rs.next()) {
			
			HashMap<String, Object> n = new HashMap<>();
			
			n.put("noticeNo", rs.getInt("noticeNo"));
			n.put("noticeTitle", rs.getString("noticeTitle"));
			n.put("createdate", rs.getString("createdate"));
			n.put("managerName", rs.getString("managerName"));
			
			list.add(n);
		}
		//end model code	
		
		// DB자원 반납
		conn.close();
		stmt.close();
		rs.close();
		
		return list;		
	}
	

	//호출(controller)	: noticeOne.jsp - 공지사항 상세보기 페이지 
	public ArrayList<HashMap<String,Object>> selectNoticeOne(int noticeNo) throws Exception{
		
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
		
		/*	공지사항 상세보기 : 번호, 매니져번호, 매니져이름, 공지제목, 공지내용, 작성일, 수정일
		SELECT n.notice_no noticeNo, n.notice_title noticeTitle, n.notice_content noticeContent, n.createdate createdate, n.updatedate updatedate, m.manager_name managerName
			FROM notice n INNER JOIN manager m
			ON n.manager_no = m.manager_no
			WHERE notice_no = ?
		 */
		
		String sql = "SELECT n.notice_no noticeNo, n.notice_title noticeTitle, n.notice_content noticeContent, n.createdate createdate, n.updatedate updatedate, m.manager_name managerName FROM notice n INNER JOIN manager m ON n.manager_no = m.manager_no WHERE notice_no = ?";
		PreparedStatement stmt=conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);
		System.out.println(stmt + "<--stmt");	//쿼리문 확인 디버깅
		ResultSet rs = stmt.executeQuery();	//jdbc환경의 모델

		ArrayList<HashMap<String, Object>> noticeOne = new ArrayList<>();
		while(rs.next()) { 
			HashMap<String, Object> noOne = new HashMap<>();
			
			noOne.put("noticeNo", rs.getInt("noticeNo"));
			noOne.put("noticeTitle", rs.getString("noticeTitle"));
			noOne.put("noticeContent", rs.getString("noticeContent"));
			noOne.put("createdate", rs.getString("createdate"));
			noOne.put("updatedate", rs.getString("updatedate"));
			noOne.put("managerName", rs.getString("managerName"));
			
			noticeOne.add(noOne);
			}	
		
		//end model code	
		
		// DB자원 반납
		conn.close();
		stmt.close();
		rs.close();
		
		return noticeOne;		
	}
	
	//호출(controller)	: managerNotice.jsp - 공지사항(table:notice) 전체 출력
	public ArrayList<HashMap<String,Object>> managerSelectNoticeList(int beginRow, int rowPerPage) throws Exception{
		
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
		
		/*	공지사항리스트 : 공지번호, 담당매니져이름, 공지제목, 공지내용, 작성일, 수정일 
		 	SELECT n.notice_no noticeNo, m.manager_name managerName, n.notice_title noticeTitle, n.notice_content noticeContent, n.createdate createdate, n.updatedate updatedate
				FROM notice n INNER JOIN manager m
				ON n.manager_no = m.manager_no;
		 */
		
		String sql = "SELECT n.notice_no noticeNo, m.manager_name managerName, n.notice_title noticeTitle, n.notice_content noticeContent, n.createdate createdate, n.updatedate updatedate FROM notice n INNER JOIN manager m ON n.manager_no = m.manager_no";
		PreparedStatement stmt=conn.prepareStatement(sql);
		System.out.println(stmt + "<--stmt");	//쿼리문 확인 디버깅
		ResultSet rs = stmt.executeQuery();	//jdbc환경의 모델
		ArrayList<HashMap<String,Object>> list = new ArrayList<>();
		while(rs.next()) {
			
			HashMap<String, Object> n = new HashMap<>();
			
			n.put("noticeNo", rs.getInt("noticeNo"));
			n.put("noticeTitle", rs.getString("noticeTitle"));
			n.put("createdate", rs.getString("createdate"));
			n.put("managerName", rs.getString("managerName"));
			n.put("noticeContent", rs.getString("noticeContent"));
			n.put("updatedate", rs.getString("updatedate"));
			
			list.add(n);
		}
		//end model code	
		
		// DB자원 반납
		conn.close();
		stmt.close();
		rs.close();
		
		return list;		
	}
	
	
	
	//호출(controller) : insertNoticeAction.jsp - 공지사항 추가
	public void managerInsertNotice(Notice notice) throws Exception{
		
		// db핸들링(model)
		Class.forName("org.mariadb.jdbc.Driver");	// DB Driver클래스 코드
		System.out.println("드라이브 로딩 성공");		// DB 드라이브 로딩 확인 디버깅
		// DB연결에 필요한 정보를 변수에 담아줌 (가독성)
		String url = "jdbc:mariadb://localhost:3306/mall";		
		String dbuser = "root";
		String dbpw = "java1234";
		//DB연결을 위한 Connection객체 생성, 연결
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		System.out.println("DB접속 성공");	//DB접속 확인 디버깅
		
		/*	공지사항 추가 : 공지사항번호, 매니져번호, 공지제목, 공지내용, 작성일, 수정일
		 	INSERT INTO notice(notice_no, manager_no, notice_title, notice_content, createdate, updatedate) 
		 		VALUE(?,?,?,?,NOW(),NOW());
		 */
		
		String sql = "INSERT INTO notice(notice_no, manager_no, notice_title, notice_content, createdate, updatedate) VALUE(?,?,?,?,NOW(),NOW())";
		PreparedStatement stmt=conn.prepareStatement(sql);
		stmt.setInt(1, notice.getNoticeNo());
		stmt.setInt(2, notice.getManagerNo());
		stmt.setString(3, notice.getNoticeTitle());
		stmt.setString(4, notice.getNoticeContent());
		stmt.setString(5, notice.getCreatedate());
		stmt.setString(6, notice.getUpdatedate());
		System.out.println(stmt + "<--stmt");	//쿼리문 확인 디버깅
		
		int row = stmt.executeUpdate();	
		System.out.println(row + "<--row"); //insert 성공확인 디버깅 
		
		if(row == 1) {
			System.out.println("공지추가성공");
		}else {
			System.out.println("공지추가실패");
		}
		
		// DB자원 반납
		conn.close();
		stmt.close();
		
	}
	
	//호출(controller) : managerDeleteNoticeAction.jsp
	public void managerDeleteNotice(int noticeNo) throws Exception{
		
		System.out.println(noticeNo + "<-- 삭제할 noticeNo");
		
		// db핸들링(model)
		Class.forName("org.mariadb.jdbc.Driver");	// DB Driver클래스 코드
		System.out.println("드라이브 로딩 성공");		// DB 드라이브 로딩 확인 디버깅
		// DB연결에 필요한 정보를 변수에 담아줌 (가독성)
		String url = "jdbc:mariadb://localhost:3306/mall";		
		String dbuser = "root";
		String dbpw = "java1234";
		//DB연결을 위한 Connection객체 생성, 연결
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		System.out.println("DB접속 성공");	//DB접속 확인 디버깅
		
		/*
			noticeNo를 입력받아 삭제
			DELETE FROM notice WHERE noticeno_no = ?
		 */
		
		String sql = "DELETE FROM notice WHERE notice_no = ?";
		PreparedStatement stmt=conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);
		System.out.println(stmt + "<--stmt");	//쿼리문 확인 디버깅

		int row = stmt.executeUpdate();	
		
		if(row == 1) {
			System.out.println("공지사항 삭제성공");
		}else {
			System.out.println("공지사항 삭제실패");
		}
		
		// DB자원 반납
		conn.close();
		stmt.close();
			
	}
	
	//호출(controller) : questionOne.jsp 
	public void managerUpdateNotice(int noticeNo, String noticeContent, int managerNo) throws Exception{
		
		// db핸들링(model)
		Class.forName("org.mariadb.jdbc.Driver");	// DB Driver클래스 코드
		System.out.println("드라이브 로딩 성공");		// DB 드라이브 로딩 확인 디버깅
		// DB연결에 필요한 정보를 변수에 담아줌 (가독성)
		String url = "jdbc:mariadb://localhost:3306/mall";		
		String dbuser = "root";
		String dbpw = "java1234";
		//DB연결을 위한 Connection객체 생성, 연결
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		System.out.println("DB접속 성공");	//DB접속 확인 디버깅
		
		/*
			noticeNo를 입력받아 업데이트
			UPDATE notice SET notice_content = ?, manager_no = ?, updatedate=NOW()
				WHERE notice_no = ?;
			
		 */
		
		String sql = "UPDATE notice SET notice_content = ?, manager_no = ?, updatedate=NOW() WHERE notice_no = ?";
		PreparedStatement stmt=conn.prepareStatement(sql);
		stmt.setString(1, noticeContent);
		stmt.setInt(2, managerNo);
		stmt.setInt(3, noticeNo);
		System.out.println(stmt + "<--stmt");	//쿼리문 확인 디버깅
	
		int row = stmt.executeUpdate();	
		
		if(row == 1) {
			System.out.println("공지 수정성공");
		}else {
			System.out.println("공지 수정실패");
		}
		
		// DB자원 반납
		conn.close();
		stmt.close();
			
	}
	
		
}

	
	
	

