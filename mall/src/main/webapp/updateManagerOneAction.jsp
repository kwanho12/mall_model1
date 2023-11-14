<%@page import="dao.ManagerDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int managerNo = (Integer) session.getAttribute("managerNo");

	String managerName = request.getParameter("managerName");
	
	ManagerDao managerDao = new ManagerDao();
	managerDao.updateManagerOne(managerNo, managerName);
	
	response.sendRedirect(request.getContextPath()+"/managerOne.jsp");
%>
