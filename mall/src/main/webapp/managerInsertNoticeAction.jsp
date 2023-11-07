<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	//한글 깨짐 인코딩
	request.setCharacterEncoding("UTF-8");
	
	int managerNo = Integer.parseInt(request.getParameter("managerNo"));
	String noticeTitle = request.getParameter("noticeTitle");
	String noticeContent = request.getParameter("noticeContent");
	
	// 공지사항 내용 디버깅
	System.out.println(managerNo + "<--managerNo");
	System.out.println(noticeTitle + "<--noticeTitle");
	System.out.println(noticeContent + "<--noticeContent");
	
	//넘어온 값을 notice객체에 담아줌
	Notice notice = new Notice();
	notice.setManagerNo(managerNo);
	notice.setNoticeTitle(noticeTitle);
	notice.setNoticeContent(noticeContent);
	
	//NoticeDao 객체 생성
	NoticeDao noticeDao = new NoticeDao();
	//managerInsertNotice를 호출
	noticeDao.managerInsertNotice(notice);
	
	// 리다이렉트 -> 추가가 완료되면 managerNotice.jsp로 이동
	response.sendRedirect(request.getContextPath()+"/managerNotice.jsp");
	

%>