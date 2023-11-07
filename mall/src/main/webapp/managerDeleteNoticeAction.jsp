<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%
	//한글 깨짐 인코딩
	request.setCharacterEncoding("UTF-8");
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));

	NoticeDao noticeDao = new NoticeDao();
	noticeDao.managerDeleteNotice(noticeNo);
	
	response.sendRedirect(request.getContextPath()+"/managerNotice.jsp");

%>