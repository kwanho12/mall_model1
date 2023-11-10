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
	
	//페이징 변수
	int beginRow = 0;
	int rowPerPage = 10;
	
	//검색 변수
	String searchWord = "";
	
	ReviewDao reviewDao = new ReviewDao();
	ArrayList<HashMap<String,Object>> list = reviewDao.selectReview(beginRow, rowPerPage, searchWord);
	
	
%>
<!--================ Start Header Menu Area ===============-->
	<jsp:include page="/inc/managerMenu.jsp"></jsp:include>
<!--================ End Header Menu Area =================-->

<div class="container-fluid">
	<h3>리뷰 관리</h3><br>
		<table class="table table-hover table-bordered">
			<colgroup>
				<col width=5%>
		        <col width=5%>
		        <col width=10%>
		        <col width=10%>
		        <col width=20%>
		        <col width=10%>
		        <col width=8%>
		        <col width=7%>
		        <col width=5%>
			</colgroup>
			<thead class="thead-dark">
				<tr>
					<th>번호</th>
					<th>주문번호</th>
					<th>상품</th>
					<th>상품명</th>
					<th>내용</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>수정일</th>
					<th>삭제</th>
				</tr>
			</thead>
				<%
					for(HashMap<String,Object> r : list){
				%>
					<tr>
						<td><%=r.get("reviewNo") %></td>
						<td><%=r.get("ordersNo") %></td>
						<td><img src="<%=request.getContextPath() %>/upload/<%=r.get("giFileName") %>" width = "100" height="110"></td>
						<td><%=r.get("goodsTitle") %></td>
						<td><%=r.get("reviewContent") %></td>
						<td><%=r.get("customerId") %></td>
						<td><%=r.get("createdate") %></td>
						<td><%=r.get("updatedate") %></td>
						<td>
							<a href="<%=request.getContextPath()%>/managerDeleteReviewAction.jsp?reviewNo=<%=r.get("reviewNo") %>" class="btn btn-dark">
								삭제						
							</a>
						</td>
					</tr>
				<%
					}
				%>
		</table>
</div>
</body>
</html>