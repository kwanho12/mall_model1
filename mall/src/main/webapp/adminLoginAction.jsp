<%@page import="java.net.URLEncoder"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="dao.LoginDao"%>
<%@page import="vo.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String adminId = request.getParameter("adminId");
	String adminPw = request.getParameter("adminPw");
	
	if(adminId.equals("admin") && adminPw.equals("1234")) { // 로그인 성공
		session.setAttribute("adminId", adminId);
		response.sendRedirect(request.getContextPath()+"/customerList.jsp");
	} else { // 로그인 실패
		String msg = URLEncoder.encode("아이디,비밀번호를 확인하세요."); // 한글이 깨찜 방지
		response.sendRedirect(request.getContextPath()+"/adminLogin.jsp?msg="+msg);	
	}
%>