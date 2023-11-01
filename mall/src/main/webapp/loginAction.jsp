<%@page import="java.net.URLEncoder"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="dao.LoginDao"%>
<%@page import="vo.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String customerId = request.getParameter("customerId");
	String customerPw = request.getParameter("customerPw");
	
	Customer customer = new Customer();
	customer.setCustomerId(customerId);
	customer.setCustomerPw(customerPw);
	
	LoginDao loginDao = new LoginDao();
	ResultSet rs = loginDao.login(customer, customerId, customerPw);
	
	if(rs.next()) { // 로그인 성공
		session.setAttribute("customerId", rs.getString("customerId"));
		response.sendRedirect(request.getContextPath()+"/home.jsp");
	} else { // 로그인 실패
		String msg = URLEncoder.encode("아이디,비밀번호를 확인하세요."); // 한글이 깨찜 방지
		response.sendRedirect(request.getContextPath()+"/login.jsp?msg="+msg);	
	}
%>