<%@page import="dao.CustomerDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int customerNo = (Integer) session.getAttribute("customerNo");
	String oldPw = request.getParameter("oldPw");
	String newPw = request.getParameter("newPw");
	
	CustomerDao customerDao = new CustomerDao();
	customerDao.updateCustomerPw(customerNo, oldPw, newPw, request, response);
	
	response.sendRedirect(request.getContextPath()+"/updateCustomerPw.jsp");
%>
