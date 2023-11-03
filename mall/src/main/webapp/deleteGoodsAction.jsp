<%@page import="dao.DeleteGoodsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%

	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	
	DeleteGoodsDao deleteGoodsDao = new DeleteGoodsDao();
	deleteGoodsDao.deleteGoods(goodsNo, request);
	
	
	response.sendRedirect(request.getContextPath()+"/goodsList.jsp");

%>