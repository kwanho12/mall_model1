<%@page import="dao.CustomerDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int customerNo = Integer.parseInt(request.getParameter("customerNo"));
	int currentPage = Integer.parseInt(request.getParameter("currentPage"));
	int rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));

	CustomerDao customerDao = new CustomerDao();
	customerDao.deleteCustomer(customerNo); // 해당하는 데이터 삭제
	
	int totalRow = customerDao.customerListPaging(); // 데이터가 삭제된 뒤의 행 개수
	if(totalRow % rowPerPage == 0) {
		--currentPage;
		if(currentPage == 0) { // customerList의 행 개수가 1개인 상태에서 행을 삭제하면 currentPage가 0이 되므로
			currentPage = 1;
		}
		response.sendRedirect(request.getContextPath()+"/customerList.jsp?currentPage="+currentPage);
		return;
	} 
	
	response.sendRedirect(request.getContextPath()+"/customerList.jsp?currentPage="+currentPage);
%>