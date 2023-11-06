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
  	<title>문의사항 상세보기</title>	
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
  <jsp:include page="/inc/customerLogoutMenu.jsp"></jsp:include>
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
	QuestionDao qDao = new QuestionDao();
	ArrayList<HashMap<String, Object>> list = qDao.selectQuestionOne(questionNo);
	
	//end controller code
%>
	<div class="container">
	<table class="table">

<%
	for(HashMap<String, Object> qOne : list){
%>
		<tr><th>번호</th><td><%=qOne.get("questionNo") %></td></tr>
		<tr><th>제목</th><td><%=qOne.get("questionTitle") %></td></tr>
		<tr><th>작성자</th><td><%=qOne.get("customerId") %></td></tr>
		<tr><th>상품명</th><td><%=qOne.get("goodsTitle") %></td></tr>
		<tr><th>내용</th><td><%=qOne.get("questionContent") %></td></tr>
		<tr><th>작성일</th><td><%=qOne.get("createdate") %></td></tr>
		
<%
		}
%>
	</table>
	</div>
	<div class="container">
<% 

	// 로그인 한 customerNo 와 문의사항 작성자의 customerNo가 같으면 수정, 삭제 가능
	System.out.println((int)session.getAttribute("customerNo") + "<-- 로그인된 고객번호");
	System.out.println(qDao.askCustomerNo(questionNo) + "<-- 작성자 고객번호");
	
	if((int)session.getAttribute("customerNo") == qDao.askCustomerNo(questionNo)) {
%>
		<a href="<%=request.getContextPath() %>/questionUpdateForm.jsp?questionNo=<%=questionNo%>">수정</a>
		<a href="<%=request.getContextPath() %>/questionDeleteAction.jsp?questionNo=<%=questionNo%>">삭제</a>

<%
		}	

%>

	</div>


</body>
</html>
