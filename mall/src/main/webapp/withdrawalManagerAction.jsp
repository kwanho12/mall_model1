<%@page import="dao.ManagerDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int managerNo = (Integer) session.getAttribute("managerNo");
	String managerPw = request.getParameter("managerPw");

	ManagerDao managerDao = new ManagerDao();
	managerDao.withdrawalManager(managerNo, managerPw, request, response, session);
%>
