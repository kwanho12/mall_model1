<%@page import="dao.ManagerDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int managerNo = (Integer) session.getAttribute("managerNo");
	String oldPw = request.getParameter("oldPw");
	String newPw = request.getParameter("newPw");
	
	ManagerDao managerDao = new ManagerDao();
	int result = managerDao.updateManagerPw(managerNo, oldPw, newPw);
	
	out.write(result + "");
%>
