package dao;
import java.util.*;
import vo.*;
import java.sql.*;

//DB	: mall
//sql	: crud
public class QuestionDao {
	
	//호출(controller) : contact.jsp - 문의사항(table:question) 의 데이터를 contact.jsp에 출력
	public ArrayList<HashMap<String, Object>> selectQuestionList(int beginRow, int rowPerPage) throws Exception{
		
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
		
		/*	문의사항리스트 : 문의사항번호, 고객ID, 상품이름, 문의사항제목, 문의사항내용, 작성일, 수정일
			SELECT q.question_no questionNo, c.customer_id customerId, g.goods_title goodsTitle, q.question_title questionTitle, q.question_content questionContent, q.createdate ,q.updatedate
				FROM question q INNER JOIN customer c
				ON q.customer_no = c.customer_no
				INNER JOIN goods g
				ON g.goods_no = q.goods_no
				ORDER BY q.createdate desc;
		 */
		
		String sql = "SELECT q.question_no questionNo, c.customer_id customerId, g.goods_title goodsTitle, q.question_title questionTitle, q.question_content questionContent, q.createdate ,q.updatedate FROM question q INNER JOIN customer c ON q.customer_no = c.customer_no INNER JOIN goods g ON g.goods_no = q.goods_no ORDER BY q.createdate desc LIMIT ?,?";
		PreparedStatement stmt=conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		System.out.println(stmt + "<--stmt");	//쿼리문 확인 디버깅
		ResultSet rs = stmt.executeQuery();	//jdbc환경의 모델
		ArrayList<HashMap<String,Object>> list = new ArrayList<>();
		while(rs.next()) {
			
			HashMap<String, Object> c = new HashMap<>();
			
			c.put("questionNo", rs.getInt("questionNo"));
			c.put("customerId", rs.getString("customerId"));
			c.put("goodsTitle", rs.getString("goodsTitle"));
			c.put("questionTitle", rs.getString("questionTitle"));
			c.put("questionContent", rs.getString("questionContent"));
			c.put("createdate", rs.getString("createdate"));
			c.put("updatedate", rs.getString("updatedate"));
			
			list.add(c);
		}
		//end model code	
		
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
		 * 	문의사항 상세 정보 : 문의사항번호, 상품이름, 고객ID, 문의사항제목, 문의사항내용
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
	
	//호출(controller) : insertContactAction.jsp - 문의사항 추가
		public int insertQuestion(Question question) throws Exception{
			
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
			 * 	문의사항 추가 : 문의사항번호, 상품번호, 고객번호, 문의사항제목, 문의사항내용, 작성일
			 * INSERT INTO question(goods_no, customer_no, question_title, question_content, createdate, updatedate)
					VALUE(?,?,?,?,NOW(),NOW());
			 * 
			 */
			
			String sql = "INSERT INTO question(goods_no, customer_no, question_title, question_content, createdate, updatedate) VALUE(?,?,?,?,NOW(),NOW())";
			PreparedStatement stmt=conn.prepareStatement(sql);
			stmt.setInt(1,question.getGoodsNo() );
			stmt.setInt(2,question.getCustomerNo() );
			stmt.setString(3,question.getQuestionTitle() );
			stmt.setString(4,question.getQuestionContent() );
			System.out.println(stmt + "<--stmt");	//쿼리문 확인 디버깅
			// insert에 성공하면 row에 1이 들어감
			int row = stmt.executeUpdate();	//jdbc환경의 모델
			System.out.println(row + "<--row"); //insert 성공확인 디버깅 
			
			//end model code	: model date -> ArrayList<Question> list
			return row;
			
		}
		
		//session 변경으로 사용X
		//호출(controller) : insertContactAction.jsp - customerNo 알아오기
		public int askCustomerNo(String customerId) throws Exception{
			
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
			 * 	customerId를 입력받아 customerNo 출력
			 * 	SELECT customer_No customerNo
					FROM customer
					WHERE customer_id = ?;
			 */
			
			String sql = "SELECT customer_No customerNo FROM customer WHERE customer_id = ?";
			PreparedStatement stmt=conn.prepareStatement(sql);
			stmt.setString(1,customerId);
			
			System.out.println(stmt + "<--stmt");	//쿼리문 확인 디버깅
			// customerId 로 customerNo를 조회
			
			int customerNo=0;
			
			ResultSet rs = stmt.executeQuery();	//jdbc환경의 모델
			if(rs.next()) {
				customerNo = rs.getInt(1);
			}else {
				System.out.println("고객번호(customerNo) 가져오기 실패");
			}
			
			//end model code	: model date -> ArrayList<Question> list
			System.out.println(customerNo + "<--customerNo");	//customerNo 디버깅
			
			return customerNo;
			
		}

		
		//호출(controller) : insertContactAction.jsp - goodsNo 알아오기
		public int askGoodsNo(String goodsTitle) throws Exception{
			
			System.out.println(goodsTitle + "<-- 넘어온 goodsTitle");
			
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
			 * 	goodsTitle를 입력받아 goodsNo 출력
			 * 	SELECT goods_no goodsNo
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
			return goodsNo;
			
		}
				
		
		
}