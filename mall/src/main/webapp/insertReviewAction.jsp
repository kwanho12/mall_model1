<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	//한글 깨짐 인코딩
	request.setCharacterEncoding("UTF-8");
	
	int customerNo = Integer.parseInt(request.getParameter("customerNo"));
	String reviewContent = request.getParameter("reviewContent");
	String goodsTitle = request.getParameter("goodsTitle");

	
	// 문의사항 내용 디버깅
	System.out.println(customerNo+"<--customerNo 리뷰작성할 고객No");	
	System.out.println(goodsTitle+"<--goodsTitle 리뷰작성할 상품명");

	
	//리뷰내용을 넣을 Review 객체 생성
	Review review = new Review();
	
	//ContactDao.askGoodsNo 호출을 위한 객체 생성
	QuestionDao questionDao = new QuestionDao();
	//goodsTitle로 goodsNo를 알아냄 -> Review 객체에 담을 orderNo를 알아내기 위해서
	int goodsNo = questionDao.askGoodsNo(goodsTitle);
	System.out.println(goodsNo + "<-- 리뷰작성할 상품의 번호");
	
	//ReviewDao 객체 생성
	ReviewDao reviewDao = new ReviewDao();
	int ordersNo = reviewDao.askOrdersNo(goodsNo, customerNo);
	System.out.println(ordersNo +"<-- 리뷰작성할 오더의 번호");
	
	//넘어온 값을 review객체에 담아줌
	review.setReviewContent(reviewContent);
	review.setOrdersNo(ordersNo);

	// insertReview 호출
	reviewDao.insertReview(review);
	
	// 리뷰페이지로 리다이렉션
	response.sendRedirect(request.getContextPath()+"/review.jsp");
%>
