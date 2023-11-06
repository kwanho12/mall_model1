<%@page import="dao.CustomerDao"%>
<%@page import="vo.CustomerAddr"%>
<%@page import="vo.CustomerDetail"%>
<%@page import="vo.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<% 
	String customerId = request.getParameter("customerId");
	String customerPw = request.getParameter("customerPw");
	String customerName = request.getParameter("customerName");
	String address = request.getParameter("address");
	String customerPhone = request.getParameter("customerPhone");

	CustomerDao customerDao = new CustomerDao();
	
	Customer customer = new Customer();
	CustomerDetail customerDetail = new CustomerDetail();
	CustomerAddr customerAddr = new CustomerAddr();
	
	customer.setCustomerId(customerId);
	customer.setCustomerPw(customerPw);
	customerDetail.setCustomerName(customerName);
	customerDetail.setCustomerPhone(customerPhone);
	customerAddr.setAddress(address);
	
	customerDao.customerRegister(customer, customerDetail, customerAddr);
	
	response.sendRedirect(request.getContextPath()+"/home.jsp");
%>