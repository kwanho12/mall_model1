<%@page import="dao.ManagerLoginDao"%>
<%@page import="vo.Manager"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String managerId = request.getParameter("managerId");
	String managerPw = request.getParameter("managerPw");
	
	Manager manager = new Manager();
	manager.setManagerId(managerId);
	manager.setManagerPw(managerPw);
	
	ManagerLoginDao managerLoginDao = new ManagerLoginDao();
	ResultSet rs = managerLoginDao.login(manager);
	
	if(rs.next()) { // 로그인 성공
		session.setAttribute("managerId", rs.getString("managerId"));
		response.sendRedirect(request.getContextPath()+"/customerList.jsp");
	} else { // 로그인 실패
		String msg = URLEncoder.encode("아이디,비밀번호를 확인하세요."); // 한글이 깨찜 방지
		response.sendRedirect(request.getContextPath()+"/managerLogin.jsp?msg="+msg);	
	}
%>