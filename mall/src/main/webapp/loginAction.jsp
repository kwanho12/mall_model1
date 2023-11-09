<%@page import="dao.CustomerDao"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="vo.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String customerId = request.getParameter("customerId");
	String customerPw = request.getParameter("customerPw");
	
	Customer customer = new Customer();
	customer.setCustomerId(customerId);
	customer.setCustomerPw(customerPw);
	
	CustomerDao customerDao = new CustomerDao();
	customerDao.customerLogin(customer, request, response, session);
	
%>