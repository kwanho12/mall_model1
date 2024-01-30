package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import vo.*;

public class ReviewDao {
	
	//호출(controller) : review.jsp - 리뷰리스트 출력 고객/관리자
	public ArrayList<HashMap<String, Object>> selectReview(int beginRow, int rowPerPage, String searchGoodsTitle,String searchWord) throws Exception{
		
		// db핸들링(model)
		Class.forName("org.mariadb.jdbc.Driver");	// DB Driver클래스 코드
		System.out.println("드라이브 로딩 성공");		// DB 드라이브 로딩 확인 디버깅
		// DB연결에 필요한 정보를 변수에 담아줌 (가독성)
		String url = "jdbc:mariadb://52.78.98.70/mall";		
		String dbuser = "root";
		String dbpw = "rkskek12";
		//DB연결을 위한 Connection객체 생성, 연결
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		System.out.println("DB접속 성공");	//DB접속 확인 디버깅
		
		
		/*	리뷰 리스트 : 리뷰 번호,리뷰 내용, 작성자ID, 상품명, 리뷰작성일, 리뷰수정일, 이미지파일 이름, 이미지파일타입 , 주문번호
			SELECT r.review_no reviewNo ,r.review_content reviewContent, g.goods_title goodsTitle, c.customer_id customerId, gi.filename giFileName, gi.content_type giContentType, r.createdate createdate, r.updatedate updatedate, o.orders_no ordersNo
				FROM review r INNER JOIN orders o
				ON r.orders_no = o.orders_no INNER JOIN goods g
				ON o.goods_no = g.goods_no INNER JOIN customer c
				ON o.customer_no = c.customer_no INNER JOIN goods_img gi
				ON g.goods_no = gi.goods_no
				WHERE  g.goods_title LIKE CONCAT('%',?,'%')
				AND r.review_content LIKE CONCAT('%',?,'%')
				ORDER BY r.createdate desc
				LIMIT ?,?
				
		 */
		
		String sql = "SELECT r.review_no reviewNo ,r.review_content reviewContent, g.goods_title goodsTitle, c.customer_id customerId, gi.filename giFileName, gi.content_type giContentType, r.createdate createdate, r.updatedate updatedate, o.orders_no ordersNo FROM review r INNER JOIN orders o ON r.orders_no = o.orders_no INNER JOIN goods g ON o.goods_no = g.goods_no INNER JOIN customer c ON o.customer_no = c.customer_no INNER JOIN goods_img gi ON g.goods_no = gi.goods_no WHERE g.goods_title LIKE CONCAT('%',?,'%') AND r.review_content LIKE CONCAT('%',?,'%') ORDER BY r.createdate desc LIMIT ?,?;";
		PreparedStatement stmt=conn.prepareStatement(sql);
		stmt.setString(1, searchGoodsTitle);
		stmt.setString(2, searchWord);
		stmt.setInt(3, beginRow);
		stmt.setInt(4, rowPerPage);
		System.out.println(stmt + "<--stmt");	//쿼리문 확인 디버깅
		ResultSet rs = stmt.executeQuery();	
		ArrayList<HashMap<String,Object>> list = new ArrayList<>();
		while(rs.next()) {
			
			HashMap<String, Object> r = new HashMap<>();
			
			r.put("goodsTitle", rs.getString("goodsTitle"));
			r.put("reviewContent", rs.getString("reviewContent"));
			r.put("customerId", rs.getString("customerId"));
			r.put("giFileName", rs.getString("giFileName"));
			r.put("giContentType", rs.getString("giContentType"));
			r.put("createdate", rs.getString("createdate"));
			r.put("updatedate", rs.getString("updatedate"));
			r.put("ordersNo", rs.getInt("ordersNo"));
			r.put("reviewNo", rs.getInt("reviewNo"));
			
			list.add(r);
		}
		//end model code
		
		//DB자원 반납
		conn.close();
		stmt.close();
		rs.close();
		
		return list;

	} 
	//호출(controller) : review.jsp - 리뷰작성 버튼 유무, 리뷰작성시 구매한 상품내역 셀렉트박스로 출력
	public ArrayList<HashMap<String, Object>> selectReviewGoodsTitle(int customerNo) throws Exception{
		
		// db핸들링(model)
		Class.forName("org.mariadb.jdbc.Driver");	// DB Driver클래스 코드
		System.out.println("드라이브 로딩 성공");		// DB 드라이브 로딩 확인 디버깅
		// DB연결에 필요한 정보를 변수에 담아줌 (가독성)
		String url = "jdbc:mariadb://52.78.98.70/mall";		
		String dbuser = "root";
		String dbpw = "rkskek12";
		//DB연결을 위한 Connection객체 생성, 연결
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		System.out.println("DB접속 성공");	//DB접속 확인 디버깅
		
		
		/*	리뷰작성 폼 : 주문번호, 상품명, 고객ID
		 	SELECT o.orders_no ordersNo, g.goods_title goodsTitle, c.customer_no customerNo
				FROM orders o INNER JOIN customer c
				ON o.customer_no = c.customer_no INNER JOIN goods g
				ON o.goods_no = g.goods_no
				WHERE c.customer_no = ?;
				
		 */
		
		String sql = "SELECT o.orders_no ordersNo, g.goods_title goodsTitle, c.customer_no customerNo FROM orders o INNER JOIN customer c ON o.customer_no = c.customer_no INNER JOIN goods g ON o.goods_no = g.goods_no WHERE c.customer_no = ?";
		PreparedStatement stmt=conn.prepareStatement(sql);
		stmt.setInt(1, customerNo);
		System.out.println(stmt + "<--stmt");	//쿼리문 확인 디버깅
		ResultSet rs = stmt.executeQuery();	
		ArrayList<HashMap<String,Object>> list = new ArrayList<>();
		while(rs.next()) {
			
			HashMap<String, Object> r = new HashMap<>();
			
			r.put("ordersNo", rs.getString("ordersNo"));
			r.put("goodsTitle", rs.getString("goodsTitle"));
			r.put("customerNo", rs.getString("customerNo"));
			
			list.add(r);
		}
		//end model code
		
		//DB자원 반납
		conn.close();
		stmt.close();
		rs.close();
		
		return list;
	
	}
	
	//호출(controller) : insertReviewAction.jsp - 리뷰 추가
	public int insertReview(Review review) throws Exception{
			
		// db핸들링(model)
		Class.forName("org.mariadb.jdbc.Driver");	// DB Driver클래스 코드
		System.out.println("드라이브 로딩 성공");		// DB 드라이브 로딩 확인 디버깅
		// DB연결에 필요한 정보를 변수에 담아줌 (가독성)
		String url = "jdbc:mariadb://52.78.98.70/mall";		
		String dbuser = "root";
		String dbpw = "rkskek12";
		//DB연결을 위한 Connection객체 생성, 연결
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		System.out.println("DB접속 성공");	//DB접속 확인 디버깅
		
		/* 리뷰 추가 : 주문번호,리뷰내용, 작성일, 작성일
			INSERT INTO review(orders_no, review_content, createdate, updatedate) 
				VALUE(?, ?, NOW(), NOW());
		  
		 */
		
		String sql = "INSERT INTO review(orders_no, review_content, createdate, updatedate) VALUE(?, ?, NOW(), NOW())";
		PreparedStatement stmt=conn.prepareStatement(sql);
		stmt.setInt(1, review.getOrdersNo());
		stmt.setString(2, review.getReviewContent());
		System.out.println(stmt + "<--stmt");	//쿼리문 확인 디버깅
		// insert에 성공하면 row에 1이 들어감
		int row = stmt.executeUpdate();	
		
		//insert 성공확인 디버깅 
		if(row == 1) {
			System.out.println("리뷰작성 성공");
		}else {
			System.out.println("리뷰작성 실패");
		}
		
		// DB자원 반납
		conn.close();
		stmt.close();
		
		return row;
			
		}
	//호출(controller) : insertReviewAction.jsp - 리뷰 작성을 위한 ordersNo 알아오기
	public int askOrdersNo(int goodsNo, int customerNo) throws Exception{
		
		//디버깅
		System.out.println(goodsNo + "<-- ordersNo 값 구할 goodsNo");
		System.out.println(customerNo + "<-- ordersNo 값 구할 customerNo");
		
		// db핸들링(model)
		Class.forName("org.mariadb.jdbc.Driver");		// DB Driver클래스 코드
		System.out.println("드라이브 로딩 성공");	// DB 드라이브 로딩 확인 디버깅
		// DB연결에 필요한 정보를 변수에 담아줌 (가독성)
		String url = "jdbc:mariadb://52.78.98.70/mall";		
		String dbuser = "root";
		String dbpw = "rkskek12";
		//DB연결을 위한 Connection객체 생성, 연결
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		System.out.println("DB접속 성공");	//DB접속 확인 디버깅
		
		/* goodsNo와 customerNo를 입력받아 ordersNo 출력
		   SELECT  orders_no ordersNo
			FROM orders
			WHERE goods_no = ? AND customer_no = ?
			ORDER BY createdate desc
		 */
		
		String sql = "SELECT orders_no ordersNo FROM orders WHERE goods_no = ? AND customer_no = ? ORDER BY createdate desc";
		PreparedStatement stmt=conn.prepareStatement(sql);
		stmt.setInt(1,goodsNo);
		stmt.setInt(2,customerNo);
		
		System.out.println(stmt + "<--stmt");	//쿼리문 확인 디버깅
	
		int ordersNo = 0;
		
		// goodsTitle 로 goodsNo를 조회
		ResultSet rs = stmt.executeQuery();	//jdbc환경의 모델
		if(rs.next()) {
			ordersNo = rs.getInt(1);	
		}else {
			System.out.println("오더번호(ordersNo) 가져오기 실패");
		}
		System.out.println(ordersNo + "<-- 리뷰작성할 오더의 번호");	//goodsNo 디버깅
		
		// DB자원 반납
		conn.close();
		stmt.close();
		rs.close();
		
		return ordersNo;
		
			}

	//호출(controller) : reveiw.jsp/managerReview.jsp 리뷰삭제 고객, 관리자
	public void deleteReview(int reviewNo) throws Exception{
		
		System.out.println(reviewNo + "<-- 삭제할 reviewNo");
		
		// db핸들링(model)
		Class.forName("org.mariadb.jdbc.Driver");	// DB Driver클래스 코드
		System.out.println("드라이브 로딩 성공");		// DB 드라이브 로딩 확인 디버깅
		// DB연결에 필요한 정보를 변수에 담아줌 (가독성)
		String url = "jdbc:mariadb://52.78.98.70/mall";		
		String dbuser = "root";
		String dbpw = "rkskek12";
		//DB연결을 위한 Connection객체 생성, 연결
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		System.out.println("DB접속 성공");	//DB접속 확인 디버깅
		
		/*
			questionNo를 입력받아 삭제
			DELETE FROM review WHERE review_no = ?
		 */
		
		String sql = "DELETE FROM review WHERE review_no = ?";
		PreparedStatement stmt=conn.prepareStatement(sql);
		stmt.setInt(1, reviewNo);
		System.out.println(stmt + "<--stmt");	//쿼리문 확인 디버깅

		int row = stmt.executeUpdate();	
		
		if(row == 1) {
			System.out.println("리뷰 삭제성공");
		}else {
			System.out.println("리뷰 삭제실패");
		}
		
		// DB자원 반납
		conn.close();
		stmt.close();
			
	}

	//호출(controller) : review.jsp - customerNo 알아오기 , Review객체에 담긴 customerId로 customerNo를 구해 비교하여 로그인 한 customerNo와 비교하기 위함
	public int askCustomerNo(String customerId) throws Exception{
		
		System.out.println(customerId + "<-- customerNo 값 구할  customerId");
		
		// db핸들링(model)
		Class.forName("org.mariadb.jdbc.Driver");	// DB Driver클래스 코드
		System.out.println("드라이브 로딩 성공");		// DB 드라이브 로딩 확인 디버깅
		// DB연결에 필요한 정보를 변수에 담아줌 (가독성)
		String url = "jdbc:mariadb://52.78.98.70/mall";		
		String dbuser = "root";
		String dbpw = "rkskek12";
		//DB연결을 위한 Connection객체 생성, 연결
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		System.out.println("DB접속 성공");	//DB접속 확인 디버깅
		
		/* customerId 입력받아 customerNo 출력
		  SELECT customer_no customerNo
			FROM customer
			WHERE customer_id = ?;
		 */
		
		String sql = "SELECT customer_no customerNo FROM customer WHERE customer_id = ?";
		PreparedStatement stmt=conn.prepareStatement(sql);
		stmt.setString(1,customerId);
		
		System.out.println(stmt + "<--stmt");	//쿼리문 확인 디버깅

		
		int customerNo = 0;
		
		// customerId 로 customerNo를 조회
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
	
	//호출(controller) : updatereviewAction.jsp -  본인이 작성한 리뷰 수정 
	public void updatereview(int reviewNo, String reviewContent) throws Exception{
		
		// db핸들링(model)
		Class.forName("org.mariadb.jdbc.Driver");	// DB Driver클래스 코드
		System.out.println("드라이브 로딩 성공");		// DB 드라이브 로딩 확인 디버깅
		// DB연결에 필요한 정보를 변수에 담아줌 (가독성)
		String url = "jdbc:mariadb://52.78.98.70/mall";		
		String dbuser = "root";
		String dbpw = "rkskek12";
		//DB연결을 위한 Connection객체 생성, 연결
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		System.out.println("DB접속 성공");	//DB접속 확인 디버깅
		
		/*
			Review 객체를 입력받아 업데이트
			UPDATE review SET review_content = ?, updatedate=NOW()
				WHERE review_no=?
			
		 */
		
		String sql = "UPDATE review SET review_content = ?, updatedate=NOW() WHERE review_no=?";
		PreparedStatement stmt=conn.prepareStatement(sql);
		stmt.setString(1, reviewContent);
		stmt.setInt(2, reviewNo );
		System.out.println(stmt + "<--stmt");	//쿼리문 확인 디버깅

		int row = stmt.executeUpdate();	
		
		if(row == 1) {
			System.out.println("리뷰 수정성공");
		}else {
			System.out.println("리뷰 수정실패");
		}
		
		// DB자원 반납
		conn.close();
		stmt.close();
			
	}

	//호출(controller) : updateReviewForm.jsp - review 수정 페이지에서 수정 전 내용 출력을 위해
	public ArrayList<HashMap<String, Object>> selectReviewOne(int reviewNo) throws Exception{
		
		// db핸들링(model)
		Class.forName("org.mariadb.jdbc.Driver");	// DB Driver클래스 코드
		System.out.println("드라이브 로딩 성공");		// DB 드라이브 로딩 확인 디버깅
		// DB연결에 필요한 정보를 변수에 담아줌 (가독성)
		String url = "jdbc:mariadb://52.78.98.70/mall";		
		String dbuser = "root";
		String dbpw = "rkskek12";
		//DB연결을 위한 Connection객체 생성, 연결
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		System.out.println("DB접속 성공");	//DB접속 확인 디버깅
		
		
		/*	리뷰 수정페이지에서 보일 리스트 : 리뷰번호, 리뷰내용, 상품명, 상품사진 
		 	SELECT r.review_no reviewNo ,r.review_content reviewContent, g.goods_no goodsNo, g.goods_title goodsTitle, gi.filename giFileName, o.orders_no orderNo
				FROM review r INNER JOIN orders o
				ON r.orders_no = o.orders_no INNER JOIN goods g
				ON o.goods_no = g.goods_no INNER JOIN customer c
				ON o.customer_no = c.customer_no INNER JOIN goods_img gi
				ON g.goods_no = gi.goods_no
				WHERE review_no = ?
				
		 */
		
		String sql = "SELECT r.review_no reviewNo ,r.review_content reviewContent, g.goods_no goodsNo, g.goods_title goodsTitle, gi.filename giFileName, o.orders_no orderNo FROM review r INNER JOIN orders o ON r.orders_no = o.orders_no INNER JOIN goods g ON o.goods_no = g.goods_no INNER JOIN customer c ON o.customer_no = c.customer_no INNER JOIN goods_img gi ON g.goods_no = gi.goods_no WHERE review_no = ?";
		PreparedStatement stmt=conn.prepareStatement(sql);
		System.out.println(stmt + "<--stmt");	//쿼리문 확인 디버깅
		stmt.setInt(1, reviewNo);
		ResultSet rs = stmt.executeQuery();	
		ArrayList<HashMap<String,Object>> list = new ArrayList<>();

		
			while(rs.next()) {
			
			HashMap<String, Object> r = new HashMap<>();
			
			r.put("reviewNo", rs.getInt("reviewNo"));
			r.put("reviewContent", rs.getString("reviewContent"));
			r.put("goodsNo", rs.getInt("goodsNo"));
			r.put("goodsTitle", rs.getString("goodsTitle"));
			r.put("giFileName", rs.getString("giFileName"));
			r.put("orderNo", rs.getString("orderNo"));	
			
			list.add(r);
		}
		//end model code
		
		//DB자원 반납
		conn.close();
		stmt.close();
		rs.close();
		
		return list;

	} 
	
	//호출(controller) : question.jsp -> 페이지의 마지막 페이지
	public int selectReviewLastPage(int rowPerPage) throws Exception{
		
		// db핸들링(model)
		Class.forName("org.mariadb.jdbc.Driver");	// DB Driver클래스 코드
		System.out.println("드라이브 로딩 성공");		// DB 드라이브 로딩 확인 디버깅
		// DB연결에 필요한 정보를 변수에 담아줌 (가독성)
		String url = "jdbc:mariadb://52.78.98.70/mall";		
		String dbuser = "root";
		String dbpw = "rkskek12";
		//DB연결을 위한 Connection객체 생성, 연결
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		System.out.println("DB접속 성공");	//DB접속 확인 디버깅
		
		/* 페이징을 위해 lastPage 반환하기 위한 전체 리뷰 수 
		 	SELECT COUNT(*)
				FROM review;
			
		 */
		
		String sql = "SELECT COUNT(*) FROM review";
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
	

}
