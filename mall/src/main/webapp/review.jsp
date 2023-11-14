<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
  	<link rel="stylesheet" href="vendors/nice-select/nice-select.css">
  	<link rel="stylesheet" href="vendors/nouislider/nouislider.min.css">
  
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
	int rowPerPage = 5;
	int beginRow=(currentPage-1)*rowPerPage;

	// 검색을 위한 변수
	String searchWord = "";
	String searchGoodsTitle= "";
	
	// 검색값으로 넘어온 문자가 있으면
	if(request.getParameter("searchGoodsTitle") != null){
		searchGoodsTitle= request.getParameter("searchGoodsTitle");
	}
		
	if(request.getParameter("searchWord") != null){
		searchWord= request.getParameter("searchWord");
	}
	// 검색값 디버깅
	System.out.println(searchGoodsTitle+"<--searchGoodsTitle");
	System.out.println(searchWord+"<--searchWord");

	// moder 호출 코드(controller code)
	// 리뷰 model값
	ReviewDao reviewDao = new ReviewDao(); 
	ArrayList<HashMap<String,Object>> list = reviewDao.selectReview(beginRow, rowPerPage, searchGoodsTitle, searchWord);

	//페이징을 위해 마지막 페이지알아오기
	int lastPage = reviewDao.selectReviewLastPage(rowPerPage);
	
	//리뷰 검색목록에 상품명 출력을 위해
		QuestionDao questionDao = new QuestionDao();
		 ArrayList<HashMap<String,Object>> list2 = questionDao.selectQuestionGoodsList();
		 int totalGoods = list2.size();
		 System.out.println(totalGoods + "<--상품 총 개수 출력");

	%>
	<!-- Start Paging, search Bar -->

 <div class="filter-bar d-flex flex-wrap align-items-center">
 	<div class="sorting mr-auto">
 
 		<%
 			if(currentPage > 1) {
 		%>	
 				<a class="btn btn-light" href="<%=request.getContextPath()%>/review.jsp?currentPage=<%=currentPage-1%>">이전</a>
 		<%
 			}
 		%>
 		
 		<%
			if(currentPage < lastPage) {
		%>
				<a class="btn btn-light" href="<%=request.getContextPath()%>/review.jsp?currentPage=<%=currentPage+1%>">다음</a>
		<%		
			}
		%>

 	</div>
 
 	<form action="<%=request.getContextPath()%>/review.jsp">
		<div>
	          <div class="input-group filter-bar-search">
	            <select name=searchGoodsTitle id="searchGoodsTitle">
				 	<option value="" selected="selected">-전체보기-</option>
				 <%
				 		for(int i = 0 ; i <totalGoods; i=i+1){
				 %>
				 	<option value="<%=list2.get(i).get("goodsTitle") %>"><%=list2.get(i).get("goodsTitle") %></option>		
				 <%
				 		}
				 %>	
				</select>
	            	<input type="text" placeholder="입력" name="searchWord" class="col">	 
	            <div>
		            <button style="height:38px;"><i class="ti-search"></i></button>
		        </div>
       	  	</div>
     	</div>
	</form>
</div>
<!-- End Paging, search Bar -->
  		
 	<%
	// 로그인이 되어 있고 orders에 구매 내역이 있는 고객이라면
	if(session.getAttribute("customerNo") != null) {
		// orders에 구매내역이 있는지 확인
		ArrayList<HashMap<String, Object>> list3 = reviewDao.selectReviewGoodsTitle((int)session.getAttribute("customerNo"));
		System.out.println("리뷰작성을 위해 로그인되어 있고");
			if(list3.size() != 0){
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
		        <col width=35%>
		        <col width=8%>
		        <col width=15%>
	     </colgroup>
		<thead class="table-primary">
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
				// 본인이 작성한 리뷰는 수정, 삭제 가능 
				// 리뷰작성자 customerNo와 로그인 customerNo가 같으면
				String customerId = (String)review.get("customerId");
				int reviewWriterNo = (int)reviewDao.askCustomerNo(customerId);
				if(session.getAttribute("customerNo") != null){
					if((int)(session.getAttribute("customerNo"))==reviewWriterNo){	
		%>
				<tr class="text-right">
					<td colspan="6">
					<%=review.get("customerId") %>님이 작성한 리뷰입니다.
						<a href="<%=request.getContextPath() %>/updateReviewForm.jsp?reviewNo=<%=review.get("reviewNo") %>" class="btn btn-dark">
							수정
						</a>
						<a href="<%=request.getContextPath() %>/deleteReviewAction.jsp?reviewNo=<%=review.get("reviewNo") %>" class="btn btn-dark">
							삭제
						</a>
					</td>
				</tr>
		<% 
					}
				}
						
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