<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%
	//한글 깨짐 방지 인코딩
	request.setCharacterEncoding("UTF-8");

	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	int questionNo = Integer.parseInt(request.getParameter("questionNo"));
	
	QuestionCommentDao questionCommentDao = new QuestionCommentDao();
	
	questionCommentDao.deleteQuestionComment(commentNo,questionNo);

	// response.sendRedirect(request.getContextPath()+"/managerQuestionOne.jsp?questionNo=questionNo");
	response.sendRedirect(request.getContextPath()+"/managerQuestion.jsp");
	
%>