<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 리뷰 관리</title>
	<meta charset="UTF-8">
 	<meta name="viewport" content="width=device-width, initial-scale=1.0">
 	<meta http-equiv="X-UA-Compatible" content="ie=edge">
  	<title>리뷰 목록</title>
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
  	
  	<!-- jQuery CDN-->
  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</head>
<body>
<% 
	//세션 적용(로그인하지 않은 사람은 접근하지 않게 하기 위함)
	if(session.getAttribute("managerNo") == null) {
		response.sendRedirect(request.getContextPath()+"/managerLogin.jsp");
	}
	
	//페이징을 위한 변수
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
<!--================ Start Header Menu Area ===============-->
	<jsp:include page="/inc/managerMenu.jsp"></jsp:include>
<!--================ End Header Menu Area =================-->

<!-- Start Paging, search Bar -->
 <div class="filter-bar d-flex flex-wrap align-items-center">
 	<div class="sorting mr-auto">
 
 		<%
 			if(currentPage > 1) {
 		%>	
 				<a class="btn btn-light" href="<%=request.getContextPath()%>/managerReview.jsp?currentPage=<%=currentPage-1%>">이전</a>
 		<%
 			}
 		%>
 		
 		<%
			if(currentPage < lastPage) {
		%>
				<a class="btn btn-light" href="<%=request.getContextPath()%>/managerReview.jsp?currentPage=<%=currentPage+1%>">다음</a>
		<%		
			}
		%>

 	</div>
 
 	<form action="<%=request.getContextPath()%>/managerReview.jsp">
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
						<%
							int reviewNo = (Integer)r.get("reviewNo");
						%>
							<a class="btn btn-dark" id="deleteReview">
								삭제						
							</a>
						</td>
					</tr>
				<%
					}
				%>
		</table>
</div>
	<script>
	    $(document).ready(function() {
	        // 문의사항 삭제 버튼 클릭 시
	        $("#deleteReview").click(function() {
	            // 삭제시 다시한번 확인
	            var result = confirm("삭제하시겠습니까?");
	            
	            // 확인이면 삭제 액션 실행
	            if (result) {
	                var deleteUrl = "<%=request.getContextPath()%>/managerDeleteReviewAction.jsp?reviewNo=reviewNo";		               
	                window.location.href = deleteUrl;
	            }
	        });
	    });
	</script>
	
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