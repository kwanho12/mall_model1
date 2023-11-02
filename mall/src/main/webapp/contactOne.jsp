<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
  	<meta charset="UTF-8">
  	<meta name="viewport" content="width=device-width, initial-scale=1.0">
  	<meta http-equiv="X-UA-Compatible" content="ie=edge">
  	<title>Aroma Shop - Contact</title>	
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
  	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&display=swap" >
  	<link rel="stylesheet" href="css/font.css">
  
  
  	<!-- BootStrap5 -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>	
</head>
<body>
  <!--================ Start Header Menu Area ===============-->
  <jsp:include page="/inc/menu.jsp"></jsp:include>
  <!--================ End Header Menu Area =================-->
  	<!-- ================ start banner area ================= -->
	<section class="blog-banner-area" id="contact">
		<div class="container h-100">
			<div class="blog-banner">
				<div class="text-center">
					<h1>QnA</h1>
					<nav aria-label="breadcrumb" class="banner-breadcrumb">
            <ol class="breadcrumb">
              <li class="breadcrumb-item"><a href="#">notice</a></li>
              <li class="breadcrumb-item active" aria-current="page">QnA</li>
            </ol>
          </nav>
				</div>
			</div>
    </div>
	</section>
	<!-- ================ end banner area ================= -->
<%
	// contact.jsp에서 넘어온 파라미터
  	int questionNo = Integer.parseInt(request.getParameter("questionNo"));
  	System.out.println(questionNo + "<-- questionNo");	// questionNo 디버깅
  	
	// moder 호출 코드(controller code)
	ContactDao cd = new ContactDao();
	ArrayList<HashMap<String, Object>> list = cd.selectQuestionOne(questionNo);
	//end controller code
%>
	<div class="container">
	<table class="table">

		<%
			for(HashMap<String, Object> cdOne : list){
		%>
		<tr><th>번호</th><td><%=cdOne.get("questionNo") %></td></tr>
		<tr><th>제목</th><td><%=cdOne.get("questionTitle") %></td></tr>
		<tr><th>작성자</th><td><%=cdOne.get("customerId") %></td></tr>
		<tr><th>내용</th><td><%=cdOne.get("questionContent") %></td></tr>
		<tr><th>작성일</th><td><%=cdOne.get("createdate") %></td></tr>
		
		<%
			}
		%>
	</table>
	</div>


</body>
</html>
