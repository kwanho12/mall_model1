<%@page import="dao.DeleteCustomerDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int customerNo = Integer.parseInt(request.getParameter("customerNo"));
	DeleteCustomerDao deleteCustomerDao = new DeleteCustomerDao();
	deleteCustomerDao.deleteCustomer(customerNo);
	
	response.sendRedirect(request.getContextPath()+"/customerList.jsp");
%>