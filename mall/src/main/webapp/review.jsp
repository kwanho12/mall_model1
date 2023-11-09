<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
  	<meta charset="UTF-8">
  	<meta name="viewport" content="width=device-width, initial-scale=1.0">
  	<meta http-equiv="X-UA-Compatible" content="ie=edge">
  	<title>리뷰</title>	
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

  <!-- ================ start banner area ================= -->
		<br>
		<div class="container">
				<div class="text-center">
					<h1>Review</h1>
				</div>
    	</div>
  <!-- ================ end banner area ================= -->
<%
	//start controller code
	int currentPage=1;
	if(request.getParameter("currentPage") != null){
		currentPage=Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 2;
	int beginRow=(currentPage-1)*rowPerPage;

	String searchWord = "";
	// moder 호출 코드(controller code)
	// 리뷰 model값
	ReviewDao reviewDao = new ReviewDao(); 
	ArrayList<HashMap<String,Object>> list = reviewDao.selectReview(beginRow, rowPerPage, searchWord);

	

	// 페이징
	// int lastPage = cd.selectQuestionLastPage(rowPerPage);
	//System.out.println(lastPage+"<--lastPage");
	
	//end controller code
	
		%>
  		
 	<%
	// 로그인이 되어 있고 orders에 구매 내역이 있는 고객이라면
	if(session.getAttribute("customerNo") != null) {
		// orders에 구매내역이 있는지 확인
		ArrayList<HashMap<String, Object>> list2 = reviewDao.selectReviewGoodsTitle((int)session.getAttribute("customerNo"));
		System.out.println("리뷰작성을 위해 로그인되어 있고");
			if(list2.size() != 0){
				System.out.println("주문내역 있음");
	%>
			<div class="container text-right">
				<a href="<%=request.getContextPath() %>/insertReviewForm.jsp" class="btn btn-dark">
					리뷰등록
				</a>
			</div>
	<% 
				
			}
	
	} 	
  	
 	%>
		<br>
	
	<div class="container text-center">
	<table class="table">
		<colgroup>
		        <col width=5%>
		        <col width=17%>
		        <col width=10%>
		        <col width=38%>
		        <col width=7%>
		        <col width=13%>
	     </colgroup>
		<thead class="table-dark">
			<tr>
				<th>No</th>
				<th>상품이미지</th>
				<th>상품명</th>
				<th>리뷰</th>
				<th>작성자</th>
				<th>작성일</th>
			</tr>
		</thead>
		<tbody>
		<%
			for(HashMap<String, Object> review : list){
					System.out.println(review.get("reviewNo")+" <--reviewNo");
					System.out.println(review.get("giFileName")+" <--giFileName");
					System.out.println(review.get("goodsTitle")+" <--goodsTitle");
					System.out.println(review.get("reviewContent")+" <--reviewContent");
					System.out.println(review.get("customerId")+" <--customerId");
					System.out.println(review.get("createdate")+" <--createdate");
		%>
				<tr>
					<td><%=review.get("reviewNo") %></td>
			
					<td>
					<img src="<%=request.getContextPath() %>/upload/<%=review.get("giFileName") %>" width = "100" height="110">
					</td>
			
					<td><%=review.get("goodsTitle") %></td>
				
					<td><%=review.get("reviewContent") %></td>
				
					<td><%=review.get("customerId") %></td>
				
					<td><%=review.get("createdate") %></td>
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