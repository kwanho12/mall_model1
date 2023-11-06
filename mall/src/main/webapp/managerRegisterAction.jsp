<%@page import="dao.ManagerDao"%>
<%@page import="vo.Manager"%>
<%@page import="vo.ManagerPwHistory"%>
<%@page import="vo.CustomerAddr"%>
<%@page import="vo.CustomerDetail"%>
<%@page import="vo.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<% 
	String managerId = request.getParameter("managerId");
	String managerPw = request.getParameter("managerPw");
	String managerName = request.getParameter("managerName");

	ManagerDao managerDao = new ManagerDao();
	
	Manager manager = new Manager();
	ManagerPwHistory managerPwHistory = new ManagerPwHistory();
	
	manager.setManagerId(managerId);
	manager.setManagerPw(managerPw);
	manager.setManagerName(managerName);
	managerPwHistory.setManagerPw(managerPw);
	
	managerDao.managerRegister(manager, managerPwHistory);
	
	response.sendRedirect(request.getContextPath()+"/managerLogin.jsp");
%>