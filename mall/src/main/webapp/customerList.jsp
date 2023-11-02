<%@page import="dao.CustomerListDao"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.Connection" %>
<%@ page import ="java.sql.DriverManager" %>
<%@ page import ="java.sql.PreparedStatement" %>
<%@ page import ="java.sql.ResultSet" %>
<%@ page import ="java.util.ArrayList" %>


<!DOCTYPE html>
<html>
<head>
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
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="css/font.css">
</head>
<body>
<%
	CustomerListDao customerDao = new CustomerListDao();
	ArrayList<HashMap<String, Object>> list = customerDao.customerList();
%>	
	<!--================ Start Header Menu Area ===============-->
    <jsp:include page="/inc/adminMenu.jsp"></jsp:include>
    <!--================ End Header Menu Area =================-->
	
	<div class="container">
		<h3>고객 DB</h3>
		<table class="table table-dark table-striped table-hover
		">
			<colgroup>
	            <col width=10%>
	            <col width=15%>
	            <col width=10%>
	            <col width=45%>
	            <col width=10%>
	            <col width=10%>
     	    </colgroup>
			<thead>
				<tr>
					<th>고객번호</th>
					<th>ID</th>
					<th>이름</th>
					<th>주소</th>
					<th>휴대폰 번호</th>
					<th>활동 상태</th>
				</tr>
			</thead>
			<tbody>
				<%
					for(HashMap<String, Object> c : list) {
				%>
						<tr>
							<td><%=c.get("customerNo")%></td>
							<td><%=c.get("customerId")%></td>
							<td><%=c.get("customerName")%></td>
							<td><%=c.get("address")%></td>
							<td><%=c.get("customerPhone")%></td>
							<td><%=c.get("active")%></td>
						</tr>
				<%		
					}
				%>
			</tbody>
		</table>
	</div>
	<script src="vendors/jquery/jquery-3.2.1.min.js"></script>
	 <script src="vendors/bootstrap/bootstrap.bundle.min.js"></script>
	 <script src="vendors/skrollr.min.js"></script>
	 <script src="vendors/owl-carousel/owl.carousel.min.js"></script>
	 <script src="vendors/nice-select/jquery.nice-select.min.js"></script>
	 <script src="vendors/jquery.ajaxchimp.min.js"></script>
	 <script src="vendors/mail-script.js"></script>
	 <script src="js/main.js"></script>
</body>
</html>