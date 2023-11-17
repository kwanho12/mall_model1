<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>

<%
	int questionNo = Integer.parseInt(request.getParameter("questionNo"));
	
	// QuestionDao 객체 생성
	QuestionDao qDao = new QuestionDao();
	
	// 삭제 deleteQeustion 호출
	qDao.deleteQuestion(questionNo);
	
	//리다이렉션 -> question.jsp
	response.sendRedirect(request.getContextPath()+"/question.jsp");
	
%>
