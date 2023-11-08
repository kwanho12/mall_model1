package dao;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;
import vo.*;

public class QuestionCommentDao {
	
	//호출(controller) : managerInsertQuestionComment.jsp -문의사항 답변 등록
	public int insertQuestionComment(QuestionComment questionComment) throws Exception{
			
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
		
		/*  공지사항 코맨트 추가 : 
		 	INSERT INTO question_comment(question_comment_no, question_no, manager_no, COMMENT, createdate, updatedate)
				VALUE(?,?,?,?,NOW(),NOW())
		 */
		
		String sql = "INSERT INTO question_comment(question_comment_no, question_no, manager_no, COMMENT, createdate, updatedate) VALUE(?,?,?,?,NOW(),NOW())";
		PreparedStatement stmt=conn.prepareStatement(sql);
		stmt.setInt(1, questionComment.getQuestionCommentNo() );
		stmt.setInt(2, questionComment.getQuestionNo() );
		stmt.setInt(3, questionComment.getManagerNo() );
		stmt.setString(4, questionComment.getComment());
		System.out.println(stmt + "<--stmt");	//쿼리문 확인 디버깅
		// insert에 성공하면 row에 1이 들어감
		int row = stmt.executeUpdate();	
		System.out.println(row + "<--row"); //insert 성공확인 디버깅 
		
		if(row == 1) {
			System.out.println("답글 추가성공");
		}else {
			System.out.println("답글 추가실패");
		}
		
		// DB자원 반납
		conn.close();
		stmt.close();
		
		return row;
			
		}

	//호출(controller)	: managerInsertQuestionForm.jsp - 문의사항 답글 존재유무 확인
	public int selectQuestionComment(int questionNo) throws Exception{
		
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
		
		/*	답글 유무 확인 
		  SELECT COMMENT
			FROM question_comment
			WHERE question_no = ?
		 */
		
		String sql = "SELECT COMMENT FROM question_comment WHERE question_no = ?";
		PreparedStatement stmt=conn.prepareStatement(sql);
		stmt.setInt(1, questionNo);
		System.out.println(stmt + "<--stmt");	//쿼리문 확인 디버깅
		ResultSet rs = stmt.executeQuery();	//jdbc환경의 모델
		
		int row = 0;
		
		if(rs!=null && rs.isBeforeFirst()) {
			row = row + 1;
		}
		
		// DB자원 반납
		conn.close();
		stmt.close();
		rs.close();
		
		return row;		
	}
	
	//호출(controller) : managerQuestionOne.jsp , QuestionOne.jsp -> 답변내용 출력
	public ArrayList<HashMap<String, Object>> selectQuestionCommentOne(int questionNo) throws Exception{
		
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
		
		/*	문의사항 답변 내용 출력
			SELECT m.manager_name managerName,  qc.question_comment_no commentNo, qc.`comment` qcComment, qc.createdate createdate, qc.updatedate updatedate
				FROM question_comment qc INNER JOIN manager m
				ON qc.manager_no = m.manager_no
				WHERE qc.question_no = ?;
		 */
		
		String sql = "SELECT m.manager_name managerName, qc.question_comment_no commentNo, qc.`comment` commentContent, qc.createdate createdate, qc.updatedate updatedate FROM question_comment qc INNER JOIN manager m ON qc.manager_no = m.manager_no WHERE qc.question_no = ?";
		PreparedStatement stmt=conn.prepareStatement(sql);
		stmt.setInt(1, questionNo);
		System.out.println(stmt + "<--stmt");	//쿼리문 확인 디버깅
		ResultSet rs = stmt.executeQuery();	
		ArrayList<HashMap<String,Object>> list = new ArrayList<>();
		while(rs.next()) {
			
			HashMap<String, Object> q = new HashMap<>();
			
			q.put("commentNo", rs.getString("commentNO"));
			q.put("managerName", rs.getString("managerName"));
			q.put("commentContent", rs.getString("commentContent"));
			q.put("createdate", rs.getString("createdate"));
			q.put("updatedate", rs.getString("updatedate"));
			
			list.add(q);
		}
		//end model code
		
		//DB자원 반납
		conn.close();
		stmt.close();
		rs.close();
		
		return list;	
	}
	
	//호출(controller) : managerDeleteQuestionCommentAction.jsp
	public int managerDeleteQuestionComment(int commentNo, int questionNo) throws Exception{
		
		System.out.println(commentNo + "<-- 삭제할 commentNo");
		
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
			questioncommentNo 입력받아 삭제
			DELETE FROM question_comment WHERE question_comment_no = ?
		 */
		
		String sql = "DELETE FROM question_comment WHERE question_comment_no = ?";
		PreparedStatement stmt=conn.prepareStatement(sql);
		stmt.setInt(1, commentNo);
		System.out.println(stmt + "<--stmt");	//쿼리문 확인 디버깅
	
		int row = stmt.executeUpdate();	
		
		if(row == 1) {
			System.out.println("답변 삭제성공");
		}else {
			System.out.println("답변 삭제실패");
		}
		
		// DB자원 반납
		conn.close();
		stmt.close();
		
		return questionNo;
	}
	
	
}
