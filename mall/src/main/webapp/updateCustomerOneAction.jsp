<%@page import="dao.CustomerDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	String customerName = request.getParameter("customerName");
	String oldPw = request.getParameter("oldPw");
	String newPw = request.getParameter("newPw");
	String customerPhone = request.getParameter("customerPhone");
	String address = request.getParameter("address");
	
	int customerNo = (Integer) session.getAttribute("customerNo");
	
	CustomerDao customerDao = new CustomerDao();
	String customerPw = null;
	customerDao.updateCustomerOne(customerNo, customerName, oldPw, newPw, customerPhone, address, customerPw, request, response);
	
%>