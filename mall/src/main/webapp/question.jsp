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
  	<title>문의사항 및 공지</title>	
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
  	
  	<!-- jQuery CDN-->
  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>

  	
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
					<h1>QnA</h1>
				</div>
    	</div>
 
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

	// moder 호출 코드(controller code)
	// 문의사항 model값
	QuestionDao cd = new QuestionDao();
	ArrayList<HashMap<String,Object>> list = cd.selectQuestionList(beginRow, rowPerPage, searchWord, questionType);
	
	int lastPage = cd.selectQuestionLastPage(rowPerPage);
	System.out.println(lastPage+"<--lastPage");
	
	// 공지사항 model값
	NoticeDao nd = new NoticeDao();
	ArrayList<HashMap<String,Object>> list2 = nd.selectNoticeList();
	//end controller code
	
		%>
<!-- Start Paging, search Bar -->

 <div class="filter-bar d-flex flex-wrap align-items-center">
 	<div class="sorting mr-auto">
 
 		<%
 			if(currentPage > 1) {
 		%>	
 				<a class="btn btn-light" href="<%=request.getContextPath()%>/question.jsp?currentPage=<%=currentPage-1%>">이전</a>
 		<%
 			}
 		%>
 		
 		<%
			if(currentPage < lastPage) {
		%>
				<a class="btn btn-light" href="<%=request.getContextPath()%>/question.jsp?currentPage=<%=currentPage+1%>">다음</a>
		<%		
			}
		%>

 	</div>
 
 	<form action="<%=request.getContextPath()%>/question.jsp">
		<div>
	          <div class="input-group filter-bar-search">
	            <select name="questionType" id="questionType">
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
		<br>
		<br>
	              		
	<div class="container">
	<table class="table table-hover">
		<thead class="table-primary">
			<tr>
				<th>No</th>
				<th>작성자</th>
				<th>제목</th>
				<th>작성일</th>
			</tr>
		</thead>
	
			<%
				for(HashMap<String,Object> notice : list2){
			%>
			<tr bgcolor=#fffff0>
				<td>공지</td>
				<td>
					매니져
						<!--<%=notice.get("managerName") %>-->
				</td>
				<td>
						<a href="<%=request.getContextPath() %>/noticeOne.jsp?noticeNo=<%=notice.get("noticeNo") %>">
						<%=notice.get("noticeTitle") %>
						</a>
				</td>
				<td>
						<%=notice.get("createdate") %>
				</td>
			</tr>
			<% 		
				} 
			%>
	
			<%
				for(HashMap<String,Object> question : list){
			%>
			<tr> 
				<td>
						<%=question.get("questionNo") %>
				</td>
				
				<td>
						<%=question.get("customerId") %>
				</td>
				<td>
					<a href="<%=request.getContextPath()%>/questionOne.jsp?questionNo=<%=question.get("questionNo") %>">
					<%=question.get("questionTitle") %>
					</a>
				</td>
				<td>
					<%=question.get("createdate") %>
				</td>
			</tr>
			<%
				}
			%>
	
	</table>
	</div>
	<div class="container text-right">
	
	
	<%
		//로그인한 사용자만 글쓰기 가능
		if(session.getAttribute("customerNo") != null) {	
	%>
		<a href="<%=request.getContextPath() %>/insertQuestionForm.jsp" class="btn btn-dark">
			글쓰기
		</a>
	<%
		}
	%>
	</div>
	<br>
	<br>
	<script>
	
	
	
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
