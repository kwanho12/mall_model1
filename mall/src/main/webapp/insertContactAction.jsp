<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	String contactTitle = request.getParameter("contactTitle");
	String goodsTitle = request.getParameter("goodsTitle");
	String contactContent = request.getParameter("contactContent");
	String customerId = request.getParameter("customerId");
	
	System.out.println(contactTitle+"<--contactTitle");
	System.out.println(goodsTitle+"<--goodsTitle");
	System.out.println(contactContent+"<--contactContent");
	System.out.println(contactContent+"<--contactContent");
	
	Question question = new Question();
	ContactDao contactDao = new ContactDao();
	
	//customerId로 customerNo를 알아냄
	int customerNo = contactDao.askCustomerNo("customerId");
	
	//goodsTitle로 goodsNo를 알아냄
	int goodsNo = contactDao.askGoodsNo("goodsTitle");
	
	question.setCustomerNo(customerNo);
	question.setGoodsNo(goodsNo);
	question.setQuestionTitle("contactTitle");
	question.setQuestionContent("contactContent");

	
	
	contactDao.insertQuestion(question);
	
	// 공지사항및문의사항으로 리다이렉션
	response.sendRedirect(request.getContextPath()+"/contact.jsp");
%>
