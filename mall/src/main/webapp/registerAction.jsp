<%@page import="vo.CustomerAddr"%>
<%@page import="vo.CustomerDetail"%>
<%@page import="vo.Customer"%>
<%@page import="dao.RegisterDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<% 
	String customerId = request.getParameter("customerId");
	String customerPw = request.getParameter("customerPw");
	String customerName = request.getParameter("customerName");
	String address = request.getParameter("address");
	String customerPhone = request.getParameter("customerPhone");

	RegisterDao registerDao = new RegisterDao();
	Customer customer = new Customer();
	CustomerDetail customerDetail = new CustomerDetail();
	CustomerAddr customerAddr = new CustomerAddr();
	
	customer.setCustomerId(customerId);
	customer.setCustomerPw(customerPw);
	customerDetail.setCustomerName(customerName);
	customerDetail.setCustomerPhone(customerPhone);
	customerAddr.setAddress(address);
	
	registerDao.register(customer, customerDetail, customerAddr);
	session.setAttribute("customerId", request.getParameter("customerId"));
	
	response.sendRedirect(request.getContextPath()+"/home.jsp");
%>