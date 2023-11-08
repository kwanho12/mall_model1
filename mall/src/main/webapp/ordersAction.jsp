<%@page import="dao.OrdersDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%

	int customerNo = (Integer) session.getAttribute("customerNo");
	
	OrdersDao ordersDao = new OrdersDao();
	ordersDao.orders(customerNo);
	
	response.sendRedirect(request.getContextPath()+"/orderConfirmation.jsp");
	
%>
