<%@page import="dao.CartDao"%>
<%@page import="vo.Cart"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	int customerNo = (Integer) session.getAttribute("customerNo");

	Cart c = new Cart();
	c.setGoodsNo(goodsNo);
	c.setCustomerNo(customerNo);
	
	CartDao cartDao = new CartDao();
	cartDao.addCart(c);
	
	response.sendRedirect(request.getContextPath()+"/cart.jsp");
	
	
%>