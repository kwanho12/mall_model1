<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>

<%
	int reviewNo = Integer.parseInt(request.getParameter("reviewNo"));
	System.out.println(reviewNo + "<-- 삭제할 reviewNo"); //삭제할 게시글 번호 디버깅
	
	// ReviewDao 객체 생성
	ReviewDao reviewDao = new ReviewDao();
	
	// 삭제 deleteReview 호출
	reviewDao.deleteReview(reviewNo);
	
		
	//리다이렉션 -> review.jsp
	response.sendRedirect(request.getContextPath()+"/review.jsp");
	
	
%>
