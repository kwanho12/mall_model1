<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>

<%
	int questionNo = Integer.parseInt(request.getParameter("questionNo"));
	System.out.println(questionNo + "<-- 삭제할 qeustionNo"); //삭제할 게시글 번호 디버깅
	
	QuestionDao qDao = new QuestionDao();
	
	qDao.deleteQuestion(questionNo);
	
	response.sendRedirect(request.getContextPath()+"/question.jsp");
	
%>
