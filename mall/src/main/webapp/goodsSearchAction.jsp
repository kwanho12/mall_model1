<%@page import="dao.GoodsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	String search = request.getParameter("search");

	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 6;
	
	GoodsDao goodsDao = new GoodsDao();
	int totalRow = goodsDao.goodsListPaging();
	int lastPage = totalRow / rowPerPage;
	if(totalRow % rowPerPage != 0) {
		lastPage = lastPage + 1;
	}
	int beginRow = (currentPage-1)*rowPerPage;
	
	// 제품 검색 SQL
	goodsDao.searchGoodsList(search, beginRow, rowPerPage);
%>
