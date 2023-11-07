<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%
	//한글 깨짐 방지 인코딩
	request.setCharacterEncoding("UTF-8");

	int questionNo = Integer.parseInt(request.getParameter("questionNo"));
	
	QuestionDao questionDao = new QuestionDao();
	
	questionDao.deleteQuestion(questionNo);
	
	response.sendRedirect(request.getContextPath()+"/managerQuestion.jsp");
	
%>
