<%@page import="dao.CustomerDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int customerNo = (Integer) session.getAttribute("customerNo");
	String oldPw = request.getParameter("oldPw");
	String newPw = request.getParameter("newPw");
	
	CustomerDao customerDao = new CustomerDao();
	int result = customerDao.updateCustomerPw(customerNo, oldPw, newPw);
	
	out.print(result);
%>
