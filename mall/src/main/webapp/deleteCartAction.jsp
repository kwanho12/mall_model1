<%@page import="dao.CartDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int cartNo = Integer.parseInt(request.getParameter("cartNo"));
	CartDao cartDao = new CartDao();
	cartDao.deleteCart(cartNo);
	
	response.sendRedirect(request.getContextPath()+"/cart.jsp");
%>
