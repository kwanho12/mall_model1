<%@page import="vo.Manager"%>
<%@page import="vo.ManagerPwHistory"%>
<%@page import="dao.ManagerRegisterDao"%>
<%@page import="vo.CustomerAddr"%>
<%@page import="vo.CustomerDetail"%>
<%@page import="vo.Customer"%>
<%@page import="dao.RegisterDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<% 
	String managerId = request.getParameter("managerId");
	String managerPw = request.getParameter("managerPw");
	String managerName = request.getParameter("managerName");

	ManagerRegisterDao managerRegisterDao = new ManagerRegisterDao();
	
	Manager manager = new Manager();
	ManagerPwHistory managerPwHistory = new ManagerPwHistory();
	
	manager.setManagerId(managerId);
	manager.setManagerPw(managerPw);
	manager.setManagerName(managerName);
	managerPwHistory.setManagerPw(managerPw);
	
	managerRegisterDao.register(manager, managerPwHistory);
	
	response.sendRedirect(request.getContextPath()+"/managerLogin.jsp");
%>