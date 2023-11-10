<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%
	//한글 깨짐 인코딩
	request.setCharacterEncoding("UTF-8");
	
	int managerNo = Integer.parseInt(request.getParameter("managerNo"));
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	String noticeTitle = request.getParameter("noticeTitle");
	String noticeContent = request.getParameter("noticeContent");
	
	// 수정값 디버깅
	System.out.println(managerNo + "<--managerNo");
	System.out.println(noticeNo + "<--noticeNo");
	System.out.println(noticeTitle + "<--noticeTitle");
	System.out.println(noticeContent + "<--noticeContent");

	NoticeDao noticeDao = new NoticeDao();
	
	noticeDao.managerUpdateNotice(noticeNo, noticeContent, managerNo);
	
	// 리다이렉트 -> 수정이 완료되면 수정한 공지의 managerNoticeOne.jsp로 이동
	response.sendRedirect(request.getContextPath()+"/managerNoticeOne.jsp?managerNo="+managerNo);
	

%>