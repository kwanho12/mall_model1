package dao;
import java.util.*;
import vo.*;
import java.sql.*;

public class QuestionDao {
	
	//호출(controller) : question.jsp - 문의사항(table:question) 의 데이터를 question.jsp에 출력
	public ArrayList<HashMap<String, Object>> selectQuestionList(int beginRow, int rowPerPage, String searchWord, String questionType ) throws Exception{
		
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
		
		
		/*	문의사항리스트 : 문의사항번호, 고객ID, 상품이름, 문의사항제목, 문의사항내용, 작성일, 수정일
			SELECT q.question_no questionNo, c.customer_id customerId, g.goods_title goodsTitle, q.question_title questionTitle, q.question_content questionContent, q.createdate ,q.updatedate
				FROM question q INNER JOIN customer c
				ON q.customer_no = c.customer_no
				INNER JOIN goods g
				ON g.goods_no = q.goods_no
				WHERE q.question_title LIKE CONCAT('%',?,'%',?,'%')
				ORDER BY q.createdate desc
				LIMIT ?,?;
		 */
		
		String sql = "SELECT q.question_no questionNo, c.customer_id customerId, g.goods_title goodsTitle, q.question_title questionTitle, q.question_content questionContent, q.createdate ,q.updatedate FROM question q INNER JOIN customer c ON q.customer_no = c.customer_no INNER JOIN goods g ON g.goods_no = q.goods_no WHERE q.question_title LIKE CONCAT('%',?,'%',?,'%') ORDER BY q.createdate desc LIMIT ?,?";
		PreparedStatement stmt=conn.prepareStatement(sql);
		stmt.setString(1, questionType);
		stmt.setString(2, searchWord);
		stmt.setInt(3, beginRow);
		stmt.setInt(4, rowPerPage);
		System.out.println(stmt + "<--stmt2");	//쿼리문 확인 디버깅
		ResultSet rs = stmt.executeQuery();	
		ArrayList<HashMap<String,Object>> list = new ArrayList<>();
		while(rs.next()) {
			
			HashMap<String, Object> q = new HashMap<>();
			
			q.put("questionNo", rs.getInt("questionNo"));
			q.put("customerId", rs.getString("customerId"));
			q.put("goodsTitle", rs.getString("goodsTitle"));
			q.put("questionTitle", rs.getString("questionTitle"));
			q.put("questionContent", rs.getString("questionContent"));
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
	
	
	//호출(controller) : QuestionOne.jsp - 문의사항 상세보기
	public ArrayList<HashMap<String, Object>> selectQuestionOne(int questionNo) throws Exception{

		System.out.println(questionNo + "<-- 상세보기 할 questionNo");
		
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
		
		/* 문의사항 상세 정보 : 문의사항번호, 상품이름, 고객ID, 문의사항제목, 문의사항내용
		   SELECT q.question_no questionNo, g.goods_title goodsTitle, c.customer_id customerId, 
		  		q.question_title questionTitle, c.customer_id customerId, q.question_content questionContent, q.createdate createdate,q.updatedate updatedate
				FROM question q INNER JOIN customer c 
				ON q.customer_no = c.customer_no	INNER JOIN goods g
				ON q.goods_no = g.goods_no;		  
		 */
		
		String sql = "SELECT q.question_no questionNo, g.goods_title goodsTitle, c.customer_id customerId, q.question_title questionTitle, c.customer_id customerId, q.question_content questionContent, q.createdate createdate, q.updatedate updatedate FROM question q INNER JOIN customer c ON q.customer_no = c.customer_no INNER JOIN goods g ON q.goods_no = g.goods_no WHERE question_no =?";
		PreparedStatement stmt=conn.prepareStatement(sql);
		stmt.setInt(1, questionNo);
		System.out.println(stmt + "<--stmt");	//쿼리문 확인 디버깅
		ResultSet rs = stmt.executeQuery();	//jdbc환경의 모델
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<>();
		while(rs.next()) { 
			HashMap<String, Object> qOne = new HashMap<>();
			
			qOne.put("questionNo", rs.getInt("questionNo"));
			qOne.put("goodsTitle", rs.getString("goodsTitle"));
			qOne.put("customerId", rs.getString("customerId"));
			qOne.put("questionTitle", rs.getString("questionTitle"));
			qOne.put("customerId", rs.getString("customerId"));
			qOne.put("questionContent", rs.getString("questionContent"));
			qOne.put("createdate", rs.getString("createdate"));
			qOne.put("updatedate", rs.getString("updatedate"));
			list.add(qOne);

		}
		
		// DB자원 반납
		conn.close();
		stmt.close();
		rs.close();
		
		return list;
		
	}
	
	//호출(controller) : insertQuestionAction.jsp - 문의사항 추가
	public int insertQuestion(Question question) throws Exception{
			
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
		
		/* 문의사항 추가 : 문의사항번호, 상품번호, 고객번호, 문의사항제목, 문의사항내용, 작성일
		   INSERT INTO question(goods_no, customer_no, question_title, question_content, createdate, updatedate)
			VALUE(?,?,?,?,NOW(),NOW());
		  
		 */
		
		String sql = "INSERT INTO question(goods_no, customer_no, question_title, question_content, createdate, updatedate) VALUE(?,?,?,?,NOW(),NOW())";
		PreparedStatement stmt=conn.prepareStatement(sql);
		stmt.setInt(1,question.getGoodsNo() );
		stmt.setInt(2,question.getCustomerNo() );
		stmt.setString(3,question.getQuestionTitle() );
		stmt.setString(4,question.getQuestionContent() );
		System.out.println(stmt + "<--stmt");	//쿼리문 확인 디버깅
		// insert에 성공하면 row에 1이 들어감
		int row = stmt.executeUpdate();	
		System.out.println(row + "<--row"); //insert 성공확인 디버깅 
		
		// DB자원 반납
		conn.close();
		stmt.close();
		
		return row;
			
		}
	
		
	//호출(controller) : insertQuestionAction.jsp - goodsNo 알아오기
	public int askGoodsNo(String goodsTitle) throws Exception{
	
		System.out.println(goodsTitle + "<-- goodsNo 값 구할 goodsTitle");
		
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
		
		/* goodsTitle를 입력받아 goodsNo 출력
		   SELECT goods_no goodsNo
				FROM goods
				WHERE goods_title = ?;
		 */
		
		String sql = "SELECT goods_no goodsNo FROM goods WHERE goods_title = ?";
		PreparedStatement stmt=conn.prepareStatement(sql);
		stmt.setString(1,goodsTitle);
		
		System.out.println(stmt + "<--stmt");	//쿼리문 확인 디버깅

	
		int goodsNo = 0;
		
		// goodsTitle 로 goodsNo를 조회
		ResultSet rs = stmt.executeQuery();	//jdbc환경의 모델
		if(rs.next()) {
			goodsNo = rs.getInt(1);	
		}else {
			System.out.println("상품번호(goodsNo) 가져오기 실패");
		}
		System.out.println(goodsNo + "<--goodsNo");	//goodsNo 디버깅
		
		// DB자원 반납
		conn.close();
		stmt.close();
		rs.close();
		
		return goodsNo;
		
			}
		
	//호출(controller) : questionOne.jsp - customerNo 알아오기
	public int askCustomerNo(int questionNo) throws Exception{
		
		System.out.println(questionNo + "<-- customerNo 값 구할  questionNo");
		
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
		
		/* questionNo를 입력받아 customerNo 출력
		  SELECT c.customer_no customerNo
				FROM question q INNER JOIN customer c
				ON q.customer_no = c.customer_no
				WHERE q.customer_no=? AND q.question_no =?;
		  
		 */
		
		String sql = "SELECT c.customer_no customerNo FROM question q INNER JOIN customer c ON q.customer_no = c.customer_no WHERE q.question_no =?";
		PreparedStatement stmt=conn.prepareStatement(sql);
		stmt.setInt(1,questionNo);
		
		System.out.println(stmt + "<--stmt");	//쿼리문 확인 디버깅

		
		int customerNo = 0;
		
		// goodsTitle 로 goodsNo를 조회
		ResultSet rs = stmt.executeQuery();	
		if(rs.next()) {
			customerNo = rs.getInt(1);	
		}else {
			System.out.println("고객번호(customerNo) 가져오기 실패");
		}
		System.out.println(customerNo + "<--customerNo");	//goodsNo 디버깅
		
		// DB자원 반납
		conn.close();
		stmt.close();
		rs.close();
		
		return customerNo;
		
	}
	
	
	//호출(controller) : questionOne.jsp - question_comment 테이블에 테이터가 있다면 먼저 삭제하고 qeustion을 삭제
	public void deleteQuestion(int questionNo) throws Exception{
		
		System.out.println(questionNo + "<-- 삭제할 questionNo");
		
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
		
		conn.setAutoCommit(false); 	//outoCommit을 꺼준다
		
		/* 	삭제하려는 question_no를 가진 question_comment가 DB에 존재하는지 확인
		 	SELECT question_no questionNo FROM question_comment WHERE question_no = ?
		 */
		
		String sql = "SELECT question_no questionNo FROM question_comment WHERE question_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, questionNo);
		ResultSet rs = stmt.executeQuery();
		
		//question_comment가 존재하는지 확인할 변수
		boolean comment = rs.next();
		System.out.println(comment + "<--comment true면 comment존재");
		if(comment) {

			System.out.println("삭제하려는 문의사항에 매니져 코맨트가 존재합니다");
		
		}else {
			System.out.println("삭제하려는 문의사항에 매니져 코맨트가 존재하지 않습니다");
		}
		
		// 매니져 코맨트가 존재한다면 삭제
		if(comment) {
			
			/* question_comment 테이블 데이터 삭제
				questionNo를 입력받아 삭제
				DELETE FROM question_comment WHERE question_no = ?
			*/
			
			// question_comment 테이블 데이터 삭제
			String sql1 = "DELETE FROM question_comment WHERE question_no = ?";
			PreparedStatement stmt1 = conn.prepareStatement(sql1);
			stmt1.setInt(1, questionNo);
			int row1 = stmt1.executeUpdate();
			
			if(row1 != 1) {
				conn.rollback();
				System.out.println("questionComment를 삭제 하지 못했습니다.");
				return;
			}else {
				System.out.println("qustionComment를 삭제했습니다");
			}
		}
				
		/* question 테이블 데이터 삭제
			questionNo를 입력받아 삭제
			DELETE FROM question WHERE question_no = ?
		 */
		
		String sql2 = "DELETE FROM question WHERE question_no = ?";
		PreparedStatement stmt2=conn.prepareStatement(sql2);
		stmt2.setInt(1, questionNo);
		System.out.println(stmt2 + "<--stmt");	//쿼리문 확인 디버깅

		int row2 = stmt2.executeUpdate();	
		
		if(row2 != 1) {
			System.out.println("문의사항 삭제실패");
			conn.rollback();
		}else {
			System.out.println("문의사항 삭제성공");
		}
		
		
		conn.commit();
		
		// DB자원 반납
		conn.close();
		stmt.close();
		stmt2.close();
		rs.close();
			
	}
	
		
	//호출(controller) : questionOne.jsp 
	public void updateQuestion(int questionNo, String questionContent) throws Exception{
		
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
			questionNo를 입력받아 업데이트
			UPDATE question SET question_content = ?, updatedate=NOW()
				WHERE question_no = ?;
			
		 */
		
		String sql = "UPDATE question SET question_content = ?, updatedate=NOW() WHERE question_no = ?";
		PreparedStatement stmt=conn.prepareStatement(sql);
		stmt.setString(1, questionContent);
		stmt.setInt(2, questionNo);
		System.out.println(stmt + "<--stmt");	//쿼리문 확인 디버깅

		int row = stmt.executeUpdate();	
		
		if(row == 1) {
			System.out.println("문의사항 수정성공");
		}else {
			System.out.println("문의사항 수정실패");
		}
		
		// DB자원 반납
		conn.close();
		stmt.close();
			
	}
	
	//호출(controller) : question.jsp -> 페이지의 마지막 페이지
	public int selectQuestionLastPage(int rowPerPage) throws Exception{
		
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
		
		/* 페이징을 위해 lastPage 반환하기 위한 전체 문의사항 수 
		 	SELECT COUNT(*)
				FROM question;
			
		 */
		
		String sql = "SELECT COUNT(*) FROM question";
		PreparedStatement stmt=conn.prepareStatement(sql);
		System.out.println(stmt + "<--stmt");	//쿼리문 확인 디버깅
		ResultSet rs = stmt.executeQuery();
		int totalRow = 0;
		if(rs.next()) {
			totalRow = rs.getInt(1);
		}
		
		int lastPage = totalRow / rowPerPage; 
		if(totalRow%rowPerPage != 0) {
			lastPage = lastPage + 1;
		}
				
		// DB자원 반납
		conn.close();
		stmt.close();
		rs.close();
		
		return lastPage;
	}

	//호출(controller) : questionInsertForm.jsp - 문의할 상품명을 출력
	public ArrayList<HashMap<String,Object>> selectQuestionGoodsList() throws Exception{
		
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
		
		
		/*	문의사항 입력에 출력될 상품명을 출력
		 	SELECT goods_title goodsTitle
		 		FROM goods 
		 */
		
		String sql = "SELECT goods_title goodsTitle FROM goods";
		PreparedStatement stmt=conn.prepareStatement(sql);
		System.out.println(stmt + "<--stmt");	//쿼리문 확인 디버깅
		
		ResultSet rs = stmt.executeQuery();	
		ArrayList<HashMap<String,Object>> list = new ArrayList<>();
		
			while(rs.next()) {
			
				HashMap<String, Object> q = new HashMap<>();
			
			q.put("goodsTitle", rs.getString("goodsTitle"));

			
			list.add(q);
		}
		//end model code
		
		//DB자원 반납
		conn.close();
		stmt.close();
		rs.close();
		
		return list;
	
	}
		
		
}