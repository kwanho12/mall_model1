<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
   
<%
	// 한글 깨짐 방지 인코딩
	request.setCharacterEncoding("UTF-8");
	
	int questionNo = Integer.parseInt(request.getParameter("questionNo"));
	String questionContent = request.getParameter("questionContent");
	
	// 수정 내용 디버깅
	System.out.println(questionNo + "<-- 수정할 게시물 번호");
	System.out.println(questionContent + "<-- 수정할 게시글 내용");
	
	// QuestionDao 객체 생성
	QuestionDao questionDao = new QuestionDao();
	
	// 수정 updateQuestion 호출
	questionDao.updateQuestion(questionNo, questionContent);
	
	//리다이렉션 -> 수정이 완료되면 수정한 문의사항으로 이동 qeustionOne.jsp
	response.sendRedirect(request.getContextPath()+"/questionOne.jsp?questionNo="+questionNo);
%>
