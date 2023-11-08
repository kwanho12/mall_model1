<%@page import="dao.GoodsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	String search = request.getParameter("search");

	GoodsDao goodsDao = new GoodsDao();
	goodsDao.goodsSearch();
%>
