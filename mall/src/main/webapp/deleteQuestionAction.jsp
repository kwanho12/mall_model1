<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>

<%
	int questionNo = Integer.parseInt(request.getParameter("questionNo"));
	System.out.println(questionNo + "<-- 삭제할 qeustionNo"); //삭제할 게시글 번호 디버깅
	
	// QuestionDao 객체 생성
	QuestionDao qDao = new QuestionDao();
	
	// 삭제 deleteQeustion 호출
	qDao.deleteQuestion(questionNo);
	
	//리다이렉션 -> question.jsp
	response.sendRedirect(request.getContextPath()+"/question.jsp");
	
%>
