<%@page import="dao.CustomerDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int customerNo = Integer.parseInt(request.getParameter("customerNo"));
	CustomerDao customerDao = new CustomerDao();
	customerDao.deleteCustomer(customerNo);
	
	response.sendRedirect(request.getContextPath()+"/customerList.jsp");
%>