<%@page import="dao.ManagerDao"%>
<%@page import="vo.Manager"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String managerId = request.getParameter("managerId");
	String managerPw = request.getParameter("managerPw");
	
	Manager manager = new Manager();
	manager.setManagerId(managerId);
	manager.setManagerPw(managerPw);
	
	ManagerDao managerDao = new ManagerDao();
	int result = managerDao.managerLogin(manager, session);
	
	out.write(result + "");
%>