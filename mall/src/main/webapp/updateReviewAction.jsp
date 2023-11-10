<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
   
<%
	// 한글 깨짐 방지 인코딩
	request.setCharacterEncoding("UTF-8");
	
	int reviewNo = Integer.parseInt(request.getParameter("reviewNo"));
	String reviewContent = request.getParameter("reviewContent");
	
	// 수정 내용 디버깅
	System.out.println(reviewNo + "<-- 수정할 리뷰 번호");
	System.out.println(reviewContent + "<-- 수정할 리뷰 내용");
	
	// reviewDao 객체 생성
	ReviewDao reviewDao = new ReviewDao();
	
	
	// 수정 updateReview 호출
	reviewDao.updatereview(reviewNo, reviewContent);
	
	//리다이렉션 -> 수정이 완료되면 수정한 문의사항으로 이동 qeustionOne.jsp
	response.sendRedirect(request.getContextPath()+"/review.jsp");
%>
