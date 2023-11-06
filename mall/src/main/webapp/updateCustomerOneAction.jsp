<%@page import="dao.CustomerDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	String customerName = request.getParameter("customerName");
	String customerPhone = request.getParameter("customerPhone");
	String address = request.getParameter("address");
	
	int customerNo = (Integer) session.getAttribute("customerNo");
	
	CustomerDao customerDao = new CustomerDao();
	customerDao.updateCustomerOne(customerNo, customerName, customerPhone, address);
	
	response.sendRedirect(request.getContextPath()+"/customerOne.jsp");
	
%>