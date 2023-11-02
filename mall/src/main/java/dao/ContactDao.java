package dao;
import java.util.*;
import vo.*;
import java.sql.*;

//DB	: mall
//sql	: crud
public class ContactDao {
	
	//호출(controller) : contact.jsp - 문의사항(table:question) 의 데이터를 contact.jsp에 출력
	public ArrayList<Question> selectQuestionList(int beginRow, int rowPerPage) throws Exception{
		ArrayList<Question> list = new ArrayList<>();
		
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
		
		String sql = "SELECT question_no questionNo, question_title questionTitle FROM question LIMIT ?,?";
		PreparedStatement stmt=conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		System.out.println(stmt + "<--stmt");	//쿼리문 확인 디버깅
		ResultSet rs = stmt.executeQuery();	//jdbc환경의 모델
		list = new ArrayList<>();	//일반화된 모델값으로 변환
		while(rs.next()){
			Question q = new Question();
			q.setQuestionNo(rs.getInt("questionNo"));
			q.setQuestionTitle(rs.getString("questionTitle"));
			list.add(q);
		}
		
		//end model code	: model date -> ArrayList<Question> list
		return list;

	}
	
	
	//호출(controller) : contactOne.jsp - 문의사항 상세보기
	public ArrayList<HashMap<String, Object>> selectQuestionOne(int questionNo) throws Exception{
		//ArrayList<Question> list = new ArrayList<>();
		
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
		
		/*
		 * 	문의사항 상세 정보 - 문의사항번호, 상품이름, 고객ID, 문의사항제목, 문의사항내용
		 * SELECT q.question_no questionNo, g.goods_title goodsTitle, c.customer_id customerId, 
		 * 		q.question_title questionTitle, q.question_content questionContent, q.createdate createdate,q.updatedate updatedate
				FROM question q INNER JOIN customer c 
				ON q.customer_no = c.customer_no	INNER JOIN goods g
				ON q.goods_no = g.goods_no;
		 * 
		 */
		
		String sql = "SELECT q.question_no questionNo, g.goods_title goodsTitle, c.customer_id customerId, q.question_title questionTitle, q.question_content questionContent, q.createdate createdate, q.updatedate updatedate FROM question q INNER JOIN customer c ON q.customer_no = c.customer_no INNER JOIN goods g ON q.goods_no = g.goods_no WHERE question_no =?";
		PreparedStatement stmt=conn.prepareStatement(sql);
		stmt.setInt(1, questionNo);
		System.out.println(stmt + "<--stmt");	//쿼리문 확인 디버깅
		ResultSet rs = stmt.executeQuery();	//jdbc환경의 모델
		
		ArrayList<HashMap<String, Object>> contactOne = new ArrayList<>();
		while(rs.next()) { 
			HashMap<String, Object> cdOne = new HashMap<>();
			
			cdOne.put("questionNo", rs.getInt("questionNo"));
			cdOne.put("goodsTitle", rs.getString("goodsTitle"));
			cdOne.put("customerId", rs.getString("customerId"));
			cdOne.put("questionTitle", rs.getString("questionTitle"));
			cdOne.put("questionContent", rs.getString("questionContent"));
			cdOne.put("createdate", rs.getString("createdate"));
			cdOne.put("updatedate", rs.getString("updatedate"));
			contactOne.add(cdOne);

		}
		//end model code	: model date -> ArrayList<Question> list
		return contactOne;
		
	}
}