<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 공지 관리</title>
	<meta charset="UTF-8">
 	<meta name="viewport" content="width=device-width, initial-scale=1.0">
 	<meta http-equiv="X-UA-Compatible" content="ie=edge">
  	<title>고객 목록</title>
	<link rel="icon" href="img/Fevicon.png" type="image/png">
  	<link rel="stylesheet" href="vendors/bootstrap/bootstrap.min.css">
  	<link rel="stylesheet" href="vendors/fontawesome/css/all.min.css">
	<link rel="stylesheet" href="vendors/themify-icons/themify-icons.css">
	<link rel="stylesheet" href="vendors/linericon/style.css">
  	<link rel="stylesheet" href="vendors/owl-carousel/owl.theme.default.min.css">
  	<link rel="stylesheet" href="vendors/owl-carousel/owl.carousel.min.css">
  	<link rel="stylesheet" href="vendors/nice-select/nice-select.css">
  	<link rel="stylesheet" href="vendors/nouislider/nouislider.min.css">
  	<link rel="stylesheet" href="css/style.css">

	<!--구글폰트 -->
  	<link rel="preconnect" href="https://fonts.googleapis.com">
  	<link rel="preconnect" href="https://fonts.gstatic.com">
  	<link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&display=swap" rel="stylesheet">
  	<link rel="stylesheet" href="css/font.css">
</head>
<body>
<% 
	//세션 적용(로그인하지 않은 사람은 접근하지 않게 하기 위함)
	if(session.getAttribute("managerNo") == null) {
		response.sendRedirect(request.getContextPath()+"/managerLogin.jsp");
	}

	int beginRow = 0;
	int rowPerPage = 10;
	
	NoticeDao noticeDao = new NoticeDao();
	ArrayList<HashMap<String,Object>> list = noticeDao.managerSelectNoticeList(beginRow, rowPerPage);
%>
<!--================ Start Header Menu Area ===============-->
	<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
<!--================ End Header Menu Area =================-->

<div class="container-fluid">
	<h3>공지 관리</h3><br>
	<h4>
		<a href="<%=request.getContextPath()%>/managerInsertNoticeForm.jsp?managerNo=<%=session.getAttribute("managerNo")%>" class="btn btn-dark">
			공지추가
		</a>
	</h4>

	<table class="table table-hover table-bordered">
		<colgroup>
		        <col width=10%>
		        <col width=15%>
		        <col width=40%>
		        <col width=15%>
		        <col width=15%>
		        <col width=5%>
	     </colgroup>
		<thead class="thead-dark">
			<tr>
				<th>공지사항 번호</th>
				<th>매니져</th>
				<th>제목</th>
				<th>작성일</th>
				<th>수정일</th>
				<th>관리</th>
			</tr>
		</thead>
		<tbody>
			<%
				for(HashMap<String, Object> n : list) {
			%>
					<tr>
						<td><%=n.get("noticeNo")%></td>
						<td><%=n.get("managerName")%></td>
						<td><%=n.get("noticeTitle")%></td>
						<td><%=n.get("createdate")%></td>
						<td><%=n.get("updatedate")%></td>
						<td><a href="<%=request.getContextPath()%>/managerNoticeOne.jsp?noticeNo=<%=n.get("noticeNo")%>">관리</a></td>				
					</tr>
			<%		
				}
			%>
		</tbody>
	</table>
</div>
</body>
</html>