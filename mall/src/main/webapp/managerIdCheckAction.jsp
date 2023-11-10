<%@page import="dao.ManagerDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String managerId = request.getParameter("managerId");
	ManagerDao managerDao = new ManagerDao();
	int idCheck = managerDao.managerIdCheck(managerId);
	
	out.write(idCheck + "");
%>
