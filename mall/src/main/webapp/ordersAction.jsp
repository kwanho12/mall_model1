<%@page import="dao.OrdersDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%

	int customerNo = (Integer) session.getAttribute("customerNo");
	int ship = Integer.parseInt(request.getParameter("ship")); // 배송비
	
	

	OrdersDao ordersDao = new OrdersDao();
	
	
	
	
%>
