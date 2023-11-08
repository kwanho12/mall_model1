<%@page import="dao.OrdersDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));

	OrdersDao ordersDao = new OrdersDao();
	ordersDao.deleteOrder(ordersNo);
	
	response.sendRedirect(request.getContextPath()+"/orderConfirmation.jsp");
%>
