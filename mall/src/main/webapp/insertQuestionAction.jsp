<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	//한글 깨짐 인코딩
	request.setCharacterEncoding("UTF-8");
	
	int customerNo = (int)session.getAttribute("customerNo");
	String questionTitle = request.getParameter("questionTitle");
	String goodsTitle = request.getParameter("goodsTitle");
	String questionContent = request.getParameter("questionContent");
	
	// 문의사항 내용 디버깅
	System.out.println(customerNo+"<--customerNo");
	System.out.println(questionTitle+"<--questionTitle");
	System.out.println(goodsTitle+"<--goodsTitle");
	System.out.println(questionContent+"<--questionContent");
	
	//문의사항내용을 넣을 Question 객체 생성
	Question question = new Question();
	//ContactDao 호출을 위한 객체 생성
	QuestionDao QuestionDao = new QuestionDao();
	
	/*
	//session변경으로 사용X
	//customerId로 customerNo를 알아냄
	int customerNo = contactDao.askCustomerNo("customerId");
	*/
	
	//goodsTitle로 goodsNo를 알아냄
	int goodsNo = QuestionDao.askGoodsNo(goodsTitle);

	
	//넘어온 값을 question객체에 담아줌
	question.setCustomerNo(customerNo);
	question.setGoodsNo(goodsNo);
	question.setQuestionTitle(questionTitle);
	question.setQuestionContent(questionContent);

	// insertQuestion 호출
	QuestionDao.insertQuestion(question);
	
	// 공지사항및문의사항으로 리다이렉션
	response.sendRedirect(request.getContextPath()+"/question.jsp");
%>
