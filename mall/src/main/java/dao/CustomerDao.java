package dao;

import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import vo.Customer;
import vo.CustomerAddr;
import vo.CustomerDetail;

public class CustomerDao {
	
	public ArrayList<HashMap<String, Object>> customerList(int beginRow, int rowPerPage) throws Exception {
		
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		// 회원정보 조회 : 고객번호, id, 활동상태, 주소, 고객이름, 휴대폰 번호
		/*
		 * SELECT c.customer_no customerNo, c.customer_id customerId, c.active, cd.customer_name customerName, cd.customer_phone customerPhone, ca.address
		 * FROM customer c INNER JOIN customer_detail cd 
		 * ON c.customer_no = cd.customer_no INNER JOIN customer_addr ca 
		 * ON ca.customer_no = c.customer_no
		 * LIMIT ?, ?
		 * */
		String sql = "SELECT c.customer_no customerNo, c.customer_id customerId, c.createdate createdate, c.updatedate updatedate, c.active, cd.customer_name customerName, cd.customer_phone customerPhone, ca.address FROM customer c INNER JOIN customer_detail cd ON c.customer_no = cd.customer_no INNER JOIN customer_addr ca ON ca.customer_no = c.customer_no LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<>();
		while(rs.next()) { 
			
			HashMap<String, Object> c = new HashMap<>();
			
			c.put("customerNo", rs.getInt("customerNo"));
			c.put("customerId", rs.getString("customerId"));
			c.put("createdate", rs.getString("createdate"));
			c.put("updatedate", rs.getString("updatedate"));
			c.put("active", rs.getString("active"));
			c.put("customerName", rs.getString("customerName"));
			c.put("customerPhone", rs.getString("customerPhone"));
			c.put("address", rs.getString("address"));
			
			list.add(c);
		
		}
		
		conn.close();
		stmt.close();
		rs.close();
		
		return list;
	}
	
	public void deleteCustomer(int customerNo) throws Exception{
		
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall" ;
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		conn.setAutoCommit(false);
		
		// customer_detail 테이블 데이터 삭제 
		String sql1 = "DELETE FROM customer_detail WHERE customer_no = ?";
		PreparedStatement stmt1 = conn.prepareStatement(sql1);
		stmt1.setInt(1, customerNo);
		int row1 = stmt1.executeUpdate();
		
		if(row1 != 1) {
			conn.rollback();
			return;
		}
		
		// customer_addr 테이블 데이터 삭제
		String sql2 = "DELETE FROM customer_addr WHERE customer_no = ?";
		PreparedStatement stmt2 = conn.prepareStatement(sql2);
		stmt2.setInt(1, customerNo);
		int row2 = stmt2.executeUpdate();
		
		if(row2 != 1) {
			conn.rollback();
			return;
		}
		
		// customer_pw_history 테이블 데이터 삭제
		String sql3 = "DELETE FROM customer_pw_history WHERE customer_no = ?";
		PreparedStatement stmt3 = conn.prepareStatement(sql3);
		stmt3.setInt(1, customerNo);
		int row3 = stmt3.executeUpdate();
		
		if(row3 != 1) {
			conn.rollback();
			return;
		}
		
		// cart 테이블 데이터 삭제
		String sql4 = "DELETE FROM cart WHERE customer_no = ?";
		PreparedStatement stmt4 = conn.prepareStatement(sql4);
		stmt4.setInt(1, customerNo);
		int row4 = stmt4.executeUpdate();
		
		CartDao cartDao = new CartDao();
		int cartCount = cartDao.getCartCount(customerNo);
		
		if(row4 != cartCount) {
			conn.rollback();
			return;
		}
		
		// customer 테이블 데이터 삭제
		String sql5 = "DELETE FROM customer WHERE customer_no = ?";
		PreparedStatement stmt5 = conn.prepareStatement(sql5);
		stmt5.setInt(1, customerNo);
		int row5 = stmt5.executeUpdate();
		
		if(row5 != 1) {
			conn.rollback();
			return;
		}
		
		conn.commit();
		
		conn.close();
		stmt1.close();
		stmt2.close();
		stmt3.close();
		stmt4.close();
		stmt5.close();

	}
	
	public void withdrawalCustomer(int customerNo, String customerPw, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall" ;
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		conn.setAutoCommit(false);
		
		String sql1 = "SELECT customer_no FROM customer WHERE customer_no = ? AND customer_pw = PASSWORD(?)";
		PreparedStatement stmt1 = conn.prepareStatement(sql1);
		stmt1.setInt(1, customerNo);
		stmt1.setString(2, customerPw);
		
		ResultSet rs = stmt1.executeQuery();
		if(!rs.next()) {
			conn.rollback();
			String msg = URLEncoder.encode("비밀번호를 확인하세요."); // 한글 깨짐 방지
			response.sendRedirect(request.getContextPath()+"/withdrawalCustomer.jsp?msg="+msg);
			return;
		}
		
		// customer_detail 테이블 데이터 삭제 
		String sql2 = "DELETE FROM customer_detail WHERE customer_no = ?";
		PreparedStatement stmt2 = conn.prepareStatement(sql2);
		stmt2.setInt(1, customerNo);
		int row1 = stmt2.executeUpdate();
		
		if(row1 != 1) {
			conn.rollback();
			return;
		}
		
		// customer_addr 테이블 데이터 삭제
		String sql3 = "DELETE FROM customer_addr WHERE customer_no = ?";
		PreparedStatement stmt3 = conn.prepareStatement(sql3);
		stmt3.setInt(1, customerNo);
		int row2 = stmt3.executeUpdate();
		
		if(row2 != 1) {
			conn.rollback();
			return;
		}
		
		// customer_pw_history 테이블 데이터 삭제
		String sql4 = "DELETE FROM customer_pw_history WHERE customer_no = ?";
		PreparedStatement stmt4 = conn.prepareStatement(sql4);
		stmt4.setInt(1, customerNo);
		int row3 = stmt4.executeUpdate();
		
		if(row3 != 1) {
			conn.rollback();
			return;
		}
		
		// cart 테이블 데이터 삭제
		String sql5 = "DELETE FROM cart WHERE customer_no = ?";
		PreparedStatement stmt5 = conn.prepareStatement(sql5);
		stmt5.setInt(1, customerNo);
		int row4 = stmt5.executeUpdate();
		
		CartDao cartDao = new CartDao();
		int cartCount = cartDao.getCartCount(customerNo);
		
		if(row4 != cartCount) {
			conn.rollback();
			return;
		}
		
		// customer 테이블 데이터 삭제
		String sql6 = "DELETE FROM customer WHERE customer_no = ?";
		PreparedStatement stmt6 = conn.prepareStatement(sql6);
		stmt6.setInt(1, customerNo);
		int row5 = stmt6.executeUpdate();
		
		if(row5 != 1) {
			conn.rollback();
			return;
		}
		
		conn.commit();
		
		session.invalidate();
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		
		conn.close();
		stmt1.close();
		rs.close();
		stmt2.close();
		stmt3.close();
		stmt4.close();
		stmt5.close();
		stmt6.close();

	}
	
	public void customerRegister(Customer customer, CustomerDetail customerDetail, CustomerAddr customerAddr) throws Exception{ 
		
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		conn.setAutoCommit(false);
		
		String sql1 = "INSERT INTO customer(customer_id, customer_pw, createdate, updatedate, active) VALUES(?, password(?), NOW(), NOW(), 'Y')";
		PreparedStatement stmt1 = conn.prepareStatement(sql1, Statement.RETURN_GENERATED_KEYS);
		stmt1.setString(1, customer.getCustomerId());
		stmt1.setString(2, customer.getCustomerPw());
		
		stmt1.executeUpdate();
		ResultSet rs1 = stmt1.getGeneratedKeys();
		
		int customerNo = 0;
		
		// AutoIncrement 값을 반환
		if(rs1.next()) {
			customerNo = rs1.getInt(1);
		} else {
			conn.rollback();
			return;
		}
		
		String sql2 = "INSERT INTO customer_detail(customer_no, customer_name, customer_phone, createdate, updatedate) VALUES(?, ?, ?, NOW(), NOW() )";
		PreparedStatement stmt2 = conn.prepareStatement(sql2);
		stmt2.setInt(1, customerNo);
		stmt2.setString(2, customerDetail.getCustomerName());
		stmt2.setString(3, customerDetail.getCustomerPhone());
		System.out.println(stmt2 + "<--- stmt2 insertTest()");
		
		int row2 = stmt2.executeUpdate();
		if(row2 != 1) {
			conn.rollback();
			return;
		}
		
		String sql3 = "INSERT INTO customer_addr(customer_no, address, createdate, updatedate) VALUES(?, ?, NOW(), NOW() )";
		PreparedStatement stmt3 = conn.prepareStatement(sql3);
		stmt3.setInt(1, customerNo);
		stmt3.setString(2, customerAddr.getAddress());
		System.out.println(stmt3 + "<--- stmt3 insertTest()");
		
		int row3 = stmt3.executeUpdate();
		if(row3 != 1) {
			conn.rollback();
			return;
		}
		
		String sql4 = "INSERT INTO customer_pw_history(customer_no, customer_pw, createdate) VALUES(?, password(?), NOW() )";
		PreparedStatement stmt4 = conn.prepareStatement(sql4);
		stmt4.setInt(1, customerNo);
		stmt4.setString(2, customer.getCustomerPw());
		System.out.println(stmt4 + "<--- stmt4 insertTest()");
		
		int row4 = stmt4.executeUpdate();
		if(row4 != 1) {
			conn.rollback();
			return;
		}
		
		conn.commit();
		stmt1.close();
		rs1.close();
		stmt2.close();
		stmt3.close();
		stmt4.close();
	}
	
	public ResultSet customerLogin(Customer customer) throws Exception{
		
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "SELECT customer_no customerNo FROM customer WHERE customer_id=? AND customer_pw = PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, customer.getCustomerId());
		stmt.setString(2, customer.getCustomerPw());
		ResultSet rs = stmt.executeQuery();
		
		conn.close();
		stmt.close();
		rs.close();
		
		return rs;
	}
	
	public ArrayList<HashMap<String,Object>> customerOne(int customerNo) throws Exception {
		
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		/*
		 * SELECT c.customer_id customerId, cd.customer_name customerName, cd.customer_phone customerPhone, ca.address address 
		 * FROM customer c INNER JOIN customer_detail cd 
		 * ON c.customer_no = cd.customer_no INNER JOIN customer_addr ca 
		 * ON ca.customer_no = c.customer_no WHERE c.customer_no = ?
		 * */
		String sql = "SELECT c.customer_id customerId, cd.customer_name customerName, cd.customer_phone customerPhone, ca.address address FROM customer c INNER JOIN customer_detail cd ON c.customer_no = cd.customer_no INNER JOIN customer_addr ca ON ca.customer_no = c.customer_no WHERE c.customer_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, customerNo);
		ResultSet rs = stmt.executeQuery();
		
		ArrayList<HashMap<String,Object>> list = new ArrayList<>();
		if(rs.next()) {
			
			HashMap<String, Object> map = new HashMap<>();
			
			map.put("customerId",rs.getString("customerId"));
			map.put("customerName", rs.getString("customerName"));
			map.put("customerPhone", rs.getString("customerPhone"));
			map.put("address", rs.getString("address"));
			
			list.add(map);
		}
		
		conn.close();
		stmt.close();
		
		return list;
	}
	
	public void updateCustomerOne(int customerNo, String customerName, String customerPhone, String address) throws Exception {
		
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		conn.setAutoCommit(false);
		
		// customer_detail 테이블 데이터 수정
		String sql1 = "UPDATE customer_detail SET customer_name = ?, customer_phone = ?, updatedate = NOW() WHERE customer_no = ? ";
		PreparedStatement stmt1 = conn.prepareStatement(sql1);
		stmt1.setString(1, customerName);
		stmt1.setString(2, customerPhone);
		stmt1.setInt(3, customerNo);
		
		int row1 = stmt1.executeUpdate();
		
		if(row1 != 1) {
			conn.rollback();
			return;
		}
		
		// customer_addr 테이블 데이터 수정
		String sql2 = "UPDATE customer_addr SET address = ?, updatedate = NOW() WHERE customer_no = ? ";
		PreparedStatement stmt2 = conn.prepareStatement(sql2);
		stmt2.setString(1, address);
		stmt2.setInt(2, customerNo);
		
		int row2 = stmt2.executeUpdate();
		
		if(row2 != 1) {
			conn.rollback();
			return;
		}

		conn.commit();
		
		stmt1.close();
		stmt2.close();
		
	}
	
	public void updateCustomerPw(int customerNo, String oldPw, String newPw, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall";
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		conn.setAutoCommit(false);
		
		// 변경할 비밀번호가 이전에 사용했던 비밀번호와 다른지 검사
		// 같다면 비밀번호 변경 화면으로 redirect해서 메시지 출력
		String sql0 = "SELECT customer_pw customerPw FROM customer_pw_history WHERE customer_no = ? AND customer_pw = PASSWORD(?)";
		PreparedStatement stmt0 = conn.prepareStatement(sql0);
		stmt0.setInt(1, customerNo);
		stmt0.setString(2, newPw);
		ResultSet rs = stmt0.executeQuery();
		if(rs.next()) { // 변경할 비밀번호가 이전에 사용했던 비밀번호와 같다면
			conn.rollback();
			String msg = URLEncoder.encode("변경할 비밀번호가 이전의 비밀번호와 같습니다. 다른 비밀번호를 입력해주세요.");
			response.sendRedirect(request.getContextPath()+"/updateCustomerPw.jsp?msg="+msg);
			return;
		}
		
			
		// 입력한 비밀번호가 원래 비밀번호와 일치하는지 대조하고 일치한다면 customer 테이블 데이터 수정(비밀번호 수정)
		String sql1 = "UPDATE customer SET customer_pw = password(?), updatedate = NOW() WHERE customer_no = ? AND customer_pw = password(?)";
		PreparedStatement stmt1 = conn.prepareStatement(sql1);
		stmt1.setString(1, newPw);
		stmt1.setInt(2, customerNo);
		stmt1.setString(3, oldPw);
	
		int row1 = stmt1.executeUpdate();
		
		if(row1 != 1) {
			conn.rollback();
			String msg = URLEncoder.encode("비밀번호를 확인하세요.");
			response.sendRedirect(request.getContextPath()+"/updateCustomerPw.jsp?msg="+msg);
			return;
		}
		
		// 비밀번호를 수정하고 customer_pw_history 테이블에 비밀번호 변경 내역 추가
		String sql2 = "INSERT INTO customer_pw_history(customer_no, customer_pw, createdate) VALUES(?, PASSWORD(?), NOW())";
		PreparedStatement stmt2 = conn.prepareStatement(sql2);
		stmt2.setInt(1, customerNo);
		stmt2.setString(2, newPw);
		int row2 = stmt2.executeUpdate();
		
		if(row2 != 1) {
			conn.rollback();
			return;
		}
		
		conn.commit();
		
		response.sendRedirect(request.getContextPath()+"/customerOne.jsp?customerNo="+customerNo);
	}
	
	public int customerListPaging() throws Exception{
		
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall" ;
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		// 페이징 sql
		String sql = "SELECT COUNT(*) FROM customer";
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
	
	public int customerSearchListPaging(String searchField, String searchText) throws Exception{
		
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall" ;
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		// 페이징 sql
		int totalRow = 0;
		if(searchField.equals("id")) {
			
			String sql = "SELECT COUNT(*) FROM customer WHERE customer_id LIKE CONCAT('%',?,'%')";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, searchText);
			ResultSet rs = stmt.executeQuery();
			if(rs.next()) {
				totalRow = rs.getInt("COUNT(*)"); // rs1.getInt(1)
			}
			
			conn.close();
			stmt.close();
			rs.close();
		}
		
		if(searchField.equals("name")) {
			
			String sql = "SELECT COUNT(*) FROM customer_detail WHERE customer_name LIKE CONCAT('%',?,'%')";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, searchText);
			ResultSet rs = stmt.executeQuery();
			if(rs.next()) {
				totalRow = rs.getInt("COUNT(*)"); // rs1.getInt(1)
			}
			
			conn.close();
			stmt.close();
			rs.close();
		}
		
		if(searchField.equals("address")) {
			
			String sql = "SELECT COUNT(*) FROM customer_addr WHERE address LIKE CONCAT('%',?,'%')";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, searchText);
			ResultSet rs = stmt.executeQuery();
			if(rs.next()) {
				totalRow = rs.getInt("COUNT(*)"); // rs1.getInt(1)
			}
			
			conn.close();
			stmt.close();
			rs.close();
		}
		
		if(searchField.equals("phone")) {
			
			String sql = "SELECT COUNT(*) FROM customer_detail WHERE customer_phone LIKE CONCAT('%',?,'%')";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, searchText);
			ResultSet rs = stmt.executeQuery();
			if(rs.next()) {
				totalRow = rs.getInt("COUNT(*)"); // rs1.getInt(1)
			}
			
			conn.close();
			stmt.close();
			rs.close();
		}
		
		if(searchField.equals("active")) {
			
			String sql = "SELECT COUNT(*) FROM customer WHERE active LIKE CONCAT('%',?,'%')";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, searchText);
			ResultSet rs = stmt.executeQuery();
			if(rs.next()) {
				totalRow = rs.getInt("COUNT(*)"); // rs1.getInt(1)
			}
			
			conn.close();
			stmt.close();
			rs.close();
		}

		return totalRow;
	}
	
	public ArrayList<HashMap<String, Object>> searchCustomerList(String searchField, String searchText, int beginRow, int rowPerPage) throws Exception{
		
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mariadb://localhost:3306/mall" ;
		String dbuser = "root";
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<>();
		if(searchField.equals("id")) { // 검색창에서 id를 선택했을 때 
			
			/*
			 * SELECT c.customer_no customerNo, c.customer_id customerId, c.createdate createdate, c.updatedate updatedate, c.active, cd.customer_name customerName, cd.customer_phone customerPhone, ca.address 
			 * FROM customer c INNER JOIN customer_detail cd 
			 * ON c.customer_no = cd.customer_no INNER JOIN customer_addr ca 
			 * ON ca.customer_no = c.customer_no 
			 * WHERE c.customer_id LIKE CONCAT('%',?,'%') 
			 * LIMIT ?, ?
			 * */
			String sql = "SELECT c.customer_no customerNo, c.customer_id customerId, c.createdate createdate, c.updatedate updatedate, c.active, cd.customer_name customerName, cd.customer_phone customerPhone, ca.address FROM customer c INNER JOIN customer_detail cd ON c.customer_no = cd.customer_no INNER JOIN customer_addr ca ON ca.customer_no = c.customer_no WHERE c.customer_id LIKE CONCAT('%',?,'%') LIMIT ?, ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, searchText);
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
			ResultSet rs = stmt.executeQuery();
			
			while(rs.next()) {
				
				HashMap<String, Object> c = new HashMap<>();
				
				c.put("customerNo", rs.getInt("customerNo"));
				c.put("customerId", rs.getString("customerId"));
				c.put("createdate", rs.getString("createdate"));
				c.put("updatedate", rs.getString("updatedate"));
				c.put("active", rs.getString("active"));
				c.put("customerName", rs.getString("customerName"));
				c.put("customerPhone", rs.getString("customerPhone"));
				c.put("address", rs.getString("address"));
				
				list.add(c);
			}
			
			stmt.close();
			rs.close();
		
		}
				
		if(searchField.equals("name")) { // 검색창에서 id를 선택했을 때 
			
			/*
			 * SELECT c.customer_no customerNo, c.customer_id customerId, c.createdate createdate, c.updatedate updatedate, c.active, cd.customer_name customerName, cd.customer_phone customerPhone, ca.address 
			 * FROM customer c INNER JOIN customer_detail cd 
			 * ON c.customer_no = cd.customer_no INNER JOIN customer_addr ca 
			 * ON ca.customer_no = c.customer_no 
			 * WHERE cd.customer_name LIKE CONCAT('%',?,'%') 
			 * LIMIT ?, ?
			 * */
			String sql = "SELECT c.customer_no customerNo, c.customer_id customerId, c.createdate createdate, c.updatedate updatedate, c.active, cd.customer_name customerName, cd.customer_phone customerPhone, ca.address FROM customer c INNER JOIN customer_detail cd ON c.customer_no = cd.customer_no INNER JOIN customer_addr ca ON ca.customer_no = c.customer_no WHERE cd.customer_name LIKE CONCAT('%',?,'%') LIMIT ?, ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, searchText);
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
			ResultSet rs = stmt.executeQuery();
			
			while(rs.next()) {
				
				HashMap<String, Object> c = new HashMap<>();
				
				c.put("customerNo", rs.getInt("customerNo"));
				c.put("customerId", rs.getString("customerId"));
				c.put("createdate", rs.getString("createdate"));
				c.put("updatedate", rs.getString("updatedate"));
				c.put("active", rs.getString("active"));
				c.put("customerName", rs.getString("customerName"));
				c.put("customerPhone", rs.getString("customerPhone"));
				c.put("address", rs.getString("address"));
				
				list.add(c);
			}
			
			stmt.close();
			rs.close();
		
		}
		
		if(searchField.equals("address")) { // 검색창에서 id를 선택했을 때 
			
			/*
			 * SELECT c.customer_no customerNo, c.customer_id customerId, c.createdate createdate, c.updatedate updatedate, c.active, cd.customer_name customerName, cd.customer_phone customerPhone, ca.address 
			 * FROM customer c INNER JOIN customer_detail cd 
			 * ON c.customer_no = cd.customer_no INNER JOIN customer_addr ca 
			 * ON ca.customer_no = c.customer_no 
			 * WHERE ca.address LIKE CONCAT('%',?,'%') 
			 * LIMIT ?, ?
			 * */
			String sql = "SELECT c.customer_no customerNo, c.customer_id customerId, c.createdate createdate, c.updatedate updatedate, c.active, cd.customer_name customerName, cd.customer_phone customerPhone, ca.address FROM customer c INNER JOIN customer_detail cd ON c.customer_no = cd.customer_no INNER JOIN customer_addr ca ON ca.customer_no = c.customer_no WHERE ca.address LIKE CONCAT('%',?,'%') LIMIT ?, ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, searchText);
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
			ResultSet rs = stmt.executeQuery();
			
			while(rs.next()) {
				
				HashMap<String, Object> c = new HashMap<>();
				
				c.put("customerNo", rs.getInt("customerNo"));
				c.put("customerId", rs.getString("customerId"));
				c.put("createdate", rs.getString("createdate"));
				c.put("updatedate", rs.getString("updatedate"));
				c.put("active", rs.getString("active"));
				c.put("customerName", rs.getString("customerName"));
				c.put("customerPhone", rs.getString("customerPhone"));
				c.put("address", rs.getString("address"));
				
				list.add(c);
			}
			
			stmt.close();
			rs.close();
		
		}
		
		if(searchField.equals("phone")) { // 검색창에서 id를 선택했을 때 
			
			/*
			 * SELECT c.customer_no customerNo, c.customer_id customerId, c.createdate createdate, c.updatedate updatedate, c.active, cd.customer_name customerName, cd.customer_phone customerPhone, ca.address 
			 * FROM customer c INNER JOIN customer_detail cd 
			 * ON c.customer_no = cd.customer_no INNER JOIN customer_addr ca 
			 * ON ca.customer_no = c.customer_no 
			 * WHERE cd.customer_phone LIKE CONCAT('%',?,'%') 
			 * LIMIT ?, ?
			 * */
			String sql = "SELECT c.customer_no customerNo, c.customer_id customerId, c.createdate createdate, c.updatedate updatedate, c.active, cd.customer_name customerName, cd.customer_phone customerPhone, ca.address FROM customer c INNER JOIN customer_detail cd ON c.customer_no = cd.customer_no INNER JOIN customer_addr ca ON ca.customer_no = c.customer_no WHERE cd.customer_phone LIKE CONCAT('%',?,'%') LIMIT ?, ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, searchText);
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
			ResultSet rs = stmt.executeQuery();
			
			while(rs.next()) {
				
				HashMap<String, Object> c = new HashMap<>();
				
				c.put("customerNo", rs.getInt("customerNo"));
				c.put("customerId", rs.getString("customerId"));
				c.put("createdate", rs.getString("createdate"));
				c.put("updatedate", rs.getString("updatedate"));
				c.put("active", rs.getString("active"));
				c.put("customerName", rs.getString("customerName"));
				c.put("customerPhone", rs.getString("customerPhone"));
				c.put("address", rs.getString("address"));
				
				list.add(c);
			}
			
			stmt.close();
			rs.close();
		
		}
		
		if(searchField.equals("active")) { // 검색창에서 id를 선택했을 때 
			
			/*
			 * SELECT c.customer_no customerNo, c.customer_id customerId, c.createdate createdate, c.updatedate updatedate, c.active, cd.customer_name customerName, cd.customer_phone customerPhone, ca.address 
			 * FROM customer c INNER JOIN customer_detail cd 
			 * ON c.customer_no = cd.customer_no INNER JOIN customer_addr ca 
			 * ON ca.customer_no = c.customer_no 
			 * WHERE c.active LIKE CONCAT('%',?,'%') 
			 * LIMIT ?, ?
			 * */
			String sql = "SELECT c.customer_no customerNo, c.customer_id customerId, c.createdate createdate, c.updatedate updatedate, c.active, cd.customer_name customerName, cd.customer_phone customerPhone, ca.address FROM customer c INNER JOIN customer_detail cd ON c.customer_no = cd.customer_no INNER JOIN customer_addr ca ON ca.customer_no = c.customer_no WHERE c.active LIKE CONCAT('%',?,'%') LIMIT ?, ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, searchText);
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
			ResultSet rs = stmt.executeQuery();
			
			while(rs.next()) {
				
				HashMap<String, Object> c = new HashMap<>();
				
				c.put("customerNo", rs.getInt("customerNo"));
				c.put("customerId", rs.getString("customerId"));
				c.put("createdate", rs.getString("createdate"));
				c.put("updatedate", rs.getString("updatedate"));
				c.put("active", rs.getString("active"));
				c.put("customerName", rs.getString("customerName"));
				c.put("customerPhone", rs.getString("customerPhone"));
				c.put("address", rs.getString("address"));
				
				list.add(c);
			}
			
			stmt.close();
			rs.close();
		
		}

		conn.close();
		return list;
	}
}
