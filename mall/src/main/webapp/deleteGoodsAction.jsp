<%@page import="dao.GoodsDao"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%

	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	int currentPage = Integer.parseInt(request.getParameter("currentPage"));
	int rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
	
	GoodsDao goodsDao = new GoodsDao();
	String filename = goodsDao.deleteGoods(goodsNo);
	
	// 파일삭제
	// String path = request.getServletContext().getRealPath("/upload");
	String path = "/Users/jkh/Desktop/DB/mall-gitRepository/mall/mall/src/main/webapp/upload";
	File f = new File(path+"/"+filename);
	if(f.exists()) {
		f.delete();
	}
	
	int totalRow = goodsDao.goodsListPaging(); // 데이터가 삭제된 뒤의 행 개수
	if(totalRow % rowPerPage == 0) {
		--currentPage;
		if(currentPage == 0) { // customerList의 행 개수가 1개인 상태에서 행을 삭제하면 currentPage가 0이 되므로
			currentPage = 1;
		}
		response.sendRedirect(request.getContextPath()+"/managerGoodsList.jsp?currentPage="+currentPage);
		return;
	} 
	
	response.sendRedirect(request.getContextPath()+"/managerGoodsList.jsp?currentPage="+currentPage);
	
	

%>