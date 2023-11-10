<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%
	//한글 깨짐 인코딩
	request.setCharacterEncoding("UTF-8");
	
	int managerNo = Integer.parseInt(request.getParameter("managerNo"));
	int questionNo = Integer.parseInt(request.getParameter("questionNo"));
	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	String commentContent = request.getParameter("commentContent");

	
	// 수정값 디버깅
	System.out.println(managerNo + "<--managerNo");
	System.out.println(questionNo + "<--questionNo");
	System.out.println(commentNo + "<--commentNo");
	System.out.println(commentContent + "<--commentContent");
	
	//QuestionCommentDao객체 생성
	QuestionCommentDao questionCommentDao = new QuestionCommentDao();
	
	questionCommentDao.updateQuestionComment(commentNo, commentContent);
	

	// 리다이렉트 -> 수정이 완료되면 수정한 managerQuestionOne.jsp로 이동
	response.sendRedirect(request.getContextPath()+"/managerQuestionOne.jsp?questionNo="+questionNo);
	

%>