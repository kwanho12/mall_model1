<%@page import="vo.Cart"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.CartDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	int customerNo = (Integer) session.getAttribute("customerNo");

	CartDao cartDao = new CartDao();
	ArrayList<Integer> cartsNo = cartDao.getCartNo(customerNo); // 특정 고객에 대한 모든 장바구니 번호 가져 오기
	
	cartDao.updateCart(cartsNo, request);
	
	response.sendRedirect(request.getContextPath()+"/cart.jsp");
%>
