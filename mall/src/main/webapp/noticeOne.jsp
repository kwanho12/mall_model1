<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<meta charset="UTF-8">
  	<meta name="viewport" content="width=device-width, initial-scale=1.0">
  	<meta http-equiv="X-UA-Compatible" content="ie=edge">
  	<title>Aroma Shop - notice</title>	
  	<link rel="icon" href="img/Fevicon.png" type="image/png">
  	<link rel="stylesheet" href="vendors/bootstrap/bootstrap.min.css">
  	<link rel="stylesheet" href="vendors/fontawesome/css/all.min.css">	
  	<link rel="stylesheet" href="vendors/themify-icons/themify-icons.css">
	<link rel="stylesheet" href="vendors/linericon/style.css">
  	<link rel="stylesheet" href="vendors/owl-carousel/owl.theme.default.min.css">
  	<link rel="stylesheet" href="vendors/owl-carousel/owl.carousel.min.css">
  	<link rel="stylesheet" href="css/style.css">
  
  	<!--구글폰트 -->
  	<link rel="preconnect" href="https://fonts.googleapis.com">
  	<link rel="preconnect" href="https://fonts.gstatic.com" >
  	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&display=swap" >
  	<link rel="stylesheet" href="css/font.css">
  	
</head>
<body>
<!--================ Start Header Menu Area ===============-->
  <!--================ Start Header Menu Area ===============-->
 <%
  	if(session.getAttribute("customerNo") != null) {
  %>
  		<jsp:include page="/inc/customerLoginMenu.jsp"></jsp:include>
  <% 	
  	} else {
  %>
  		<jsp:include page="/inc/customerLogoutMenu.jsp"></jsp:include>
  <% 	
  	}
  %>
  <!--================ End Header Menu Area =================-->
<!--================ End Header Menu Area =================-->
<!-- ================ start banner area ================= -->
	<br>
	<div class="container">
		<div class="text-center">
			<h1>Notice</h1>
		</div>
    </div>
<!-- ================ end banner area ================= -->
<%
	// request.getParameter로 넘어온 값 저장
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	System.out.println(noticeNo + "<-- noticeNo");	//parameter값 디버깅
	
	// moder 호출 코드(controller code)
	NoticeDao noticeDao = new NoticeDao();
	ArrayList<HashMap<String,Object>> list = noticeDao.selectNoticeOne(noticeNo);

%>
	<br>

	<div class="container">
		<table class="table">
		<colgroup>
		        <col width=10%>
		        <col width=40%>
		        <col width=10%>
		        <col width=15%>
		        <col width=10%>
		        <col width=15%>
	     </colgroup>

		<%
			for(HashMap<String, Object> noOne : list){
		%>
		<tr><th>제목</th><td><%=noOne.get("noticeTitle") %></td>
		<th>관리자</th><td>매니져(<%=noOne.get("managerName") %>)</td>
		<th>작성일</th><td><%=noOne.get("createdate") %></td>	
		<tr><th>내용</th><td colspan="5"><%=noOne.get("noticeContent") %></td></tr>

		<%
			}
		%>
		</table>
	</div>
	<script src="vendors/jquery/jquery-3.2.1.min.js"></script>
  	<script src="vendors/bootstrap/bootstrap.bundle.min.js"></script>
  	<script src="vendors/skrollr.min.js"></script>
  	<script src="vendors/owl-carousel/owl.carousel.min.js"></script>
  	<script src="vendors/nice-select/jquery.nice-select.min.js"></script>
  	<script src="vendors/jquery.form.js"></script>
  	<script src="vendors/jquery.validate.min.js"></script>
  	<script src="vendors/contact.js"></script>
  	<script src="vendors/jquery.ajaxchimp.min.js"></script>
  	<script src="vendors/mail-script.js"></script>
  	<script src="js/main.js"></script>
</body>
</html>