<%@page import="dao.CustomerDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String customerId = request.getParameter("customerId");
	CustomerDao customerDao = new CustomerDao();
	int idCheck = customerDao.customerIdCheck(customerId);
	
	out.write(idCheck + "");
%>
