<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	//한글 깨짐 인코딩
	request.setCharacterEncoding("UTF-8");
	
	int managerNo = Integer.parseInt(request.getParameter("managerNo"));
	int questionNo = Integer.parseInt(request.getParameter("questionNo"));
	String questionComment = request.getParameter("questionComment");
	
	// 공지사항 내용 디버깅
	System.out.println(managerNo + "<--managerNo");
	System.out.println(questionNo + "<--questionNo");
	System.out.println(questionComment + "<--questionComment");
	
	//넘어온 값을 	questionComment객체에 담아줌
	QuestionComment qComment = new QuestionComment();
	qComment.setManagerNo(managerNo);
	qComment.setQuestionNo(questionNo);
	qComment.setComment(questionComment);	
	
	//QuestionCommentDao 객체 생성
	QuestionCommentDao questionCommentDao = new QuestionCommentDao();
	
	//insertQuestionComment를 호출
	questionCommentDao.insertQuestionComment(qComment);
	
	// 리다이렉트 -> 추가가 완료되면 managerNotice.jsp로 이동
	response.sendRedirect(request.getContextPath()+"/managerQuestion.jsp");
	

%>