<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 문의 관리</title>
	<meta charset="UTF-8">
  	<meta name="viewport" content="width=device-width, initial-scale=1.0">
  	<meta http-equiv="X-UA-Compatible" content="ie=edge">
  	<title>관리자 문의 관리</title>
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
   
   <style>
      th { background-color: black; color: white;" }
    </style>
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
	String questionType= "";
	
	// 검색값으로 넘어온 문자가 있으면
	if(request.getParameter("questionType") != null){
		questionType= request.getParameter("questionType");
	}
	
	if(request.getParameter("searchWord") != null){
		searchWord= request.getParameter("searchWord");
	}
	// 검색값 디버깅
	System.out.println(questionType+"<--questionType");
	System.out.println(searchWord+"<--searchWord");


	QuestionDao questionDao= new QuestionDao();
	ArrayList<HashMap<String,Object>> list = questionDao.selectQuestionList(beginRow, rowPerPage, searchWord, questionType);

	int lastPage = questionDao.selectQuestionLastPage(rowPerPage);
	System.out.println(lastPage+"<--lastPage");
	
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
 				<a class="btn btn-light" href="<%=request.getContextPath()%>/managerQuestion.jsp?currentPage=<%=currentPage-1%>">이전</a>
 		<%
 			}
 		%>
 		
 		<%
			if(currentPage < lastPage) {
		%>
				<a class="btn btn-light" href="<%=request.getContextPath()%>/managerQuestion.jsp?currentPage=<%=currentPage+1%>">다음</a>
		<%		
			}
		%>

 	</div>
 
 	<form action="<%=request.getContextPath()%>/managerQuestion.jsp">
		<div>
	          <div class="input-group filter-bar-search">
	            <select name="questionType">
					<option value="" selected="selected">-전체보기-</option>
				 	<option value="[배송]">[배송]</option>
				 	<option value="[상품]">[상품]</option>
				 	<option value="[AS]" >[AS]</option>
				 	<option value="[환불]">[환불]</option>			
				 	<option value="[기타]">[기타]</option>	
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
	<h3>문의사항 관리</h3>
	<table class="table table-hover table-bordered">
		<colgroup>
            <col width=10%>
            <col width=10%>
            <col width=10%>
            <col width=45%>
            <col width=10%>
            <col width=10%>
            <col width=5%>
 	    </colgroup>
		<thead>
			<tr>
				<th>게시물 번호</th>
				<th>고객 ID</th>
				<th>상품</th>
				<th>게시물 제목</th>
				<th>작성일</th>
				<th>수정일</th>
				<th>관리</th>
			</tr>
		</thead>
		<tbody>
			<%
				for(HashMap<String, Object> q : list) {
			%>
					<tr>
						<td><%=q.get("questionNo")%></td>
						<td><%=q.get("customerId")%></td>
						<td><%=q.get("goodsTitle")%></td>
						<td><%=q.get("questionTitle")%></td>
						<td><%=q.get("createdate")%></td>
						<td><%=q.get("updatedate")%></td>
						<td><a href="<%=request.getContextPath()%>/managerQuestionOne.jsp?questionNo=<%=q.get("questionNo")%>">관리</a></td>				
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