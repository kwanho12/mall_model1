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
  
  	<!--구글폰트 -->
  	<link rel="preconnect" href="https://fonts.googleapis.com">
  	<link rel="preconnect" href="https://fonts.gstatic.com" >
  	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&display=swap" >
  	<link rel="stylesheet" href="css/font.css">
  	
	 <style>
	.page-link {
	  color: #999; 
	  background-color: #000;
	  border-color: #444;
	}	
	
	.page-link:focus, .page-link:hover {
	  color: #ccc;
	  background-color: #222; 
	  border-color: #444;
	}
	</style>
  	
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
<!-- ================ end banner area ================= -->

<%
	//start controller code
	int currentPage=1;
	if(request.getParameter("currentPage") != null){
		currentPage=Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 2;
	int beginRow=(currentPage-1)*rowPerPage;

	// moder 호출 코드(controller code)
	// 문의사항 model값
	QuestionDao cd = new QuestionDao();
	ArrayList<HashMap<String,Object>> list = cd.selectQuestionList(beginRow, rowPerPage);
	
	int lastPage = cd.selectQuestionLastPage(rowPerPage);
	System.out.println(lastPage+"<--lastPage");
	
	// 공지사항 model값
	NoticeDao nd = new NoticeDao();
	ArrayList<HashMap<String,Object>> list2 = nd.selectNoticeList();
	//end controller code
	
		%>
		<br>
		<br>
	
	<div class="container">
	<table class="table table-hover">
		<thead class="table-dark">
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
	
<div class="container">
	<ul class="pagination justify-content-center">
    <li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/question.jsp?currentPage=1">처음</a></li>
    <%
    	for(int i = 1; i<=lastPage; i=i+1){
    %>
    <li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/question.jsp?currentPage=<%=i %>"><%=i %></a></li>
	<%
    }
	%>
    <li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/question.jsp?currentPage=<%=lastPage%>">마지막</a></li>
  </ul>
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
