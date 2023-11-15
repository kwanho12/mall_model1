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
	<!-- ================ end banner area ================= -->
  <% 
	
	// question.jsp에서 넘어온 파라미터
  	int questionNo = Integer.parseInt(request.getParameter("questionNo"));
  	System.out.println(questionNo + "<-- questionNo");	// questionNo 디버깅
	
	// moder 호출 코드(controller code)
	QuestionDao qDao = new QuestionDao();
	ArrayList<HashMap<String, Object>> list = qDao.selectQuestionOne(questionNo);
	
	QuestionCommentDao qcDao = new QuestionCommentDao();
	int comment = qcDao.selectQuestionComment(questionNo);
	
	//end controller code
%>
	<br>
	<br>
<div class="container">
	<br>
	<table class="table">
	<colgroup>
		 <col width=10%>
		 <col width=40%>
		 <col width=10%>
		 <col width=10%>
		 <col width=10%>
		 <col width=20%>
	</colgroup>
<%
	for(HashMap<String, Object> qOne : list){
%>
		<tr><th>제목</th><td><%=qOne.get("questionTitle") %></td>
		<th>작성자</th><td><%=qOne.get("customerId") %></td>
		<th>작성일</th><td><%=qOne.get("createdate") %></td></tr>
		<tr><th>상품명</th><td colspan="5"><%=qOne.get("goodsTitle") %></td></tr>
		<tr><th>내용</th><td colspan="5"><%=qOne.get("questionContent") %></td></tr>	
<%
		}
%>
	</table>
	</div>
	<div class="container text-right">
<%
	// 세션에 customerNo가 존재하고, customerNo가 작성자의 customerNo와 같다면
	if((session.getAttribute("customerNo") != null)&&((int)session.getAttribute("customerNo") == qDao.askCustomerNo(questionNo))) {
%>
	<a href="<%=request.getContextPath() %>/updateQuestionForm.jsp?questionNo=<%=questionNo%>" class="btn btn-dark">수정</a>
	<a href="<%=request.getContextPath() %>/deleteQuestionAction.jsp?questionNo=<%=questionNo%>" class="btn btn-dark" id="deleteQuestionButton">삭제</a>
<%
	}
%>	
	</div>	
	
	
<div class="container">
	<h3>Answer</h3>
	<table class="table">
<%
	if(comment == 1){
		//답변 내용이 있다면 comment == 1, 없다면 comment == 0
		ArrayList<HashMap<String, Object>> list2 = qcDao.selectQuestionCommentOne(questionNo);
		

		for(HashMap<String, Object> qcOne : list2){
%>
			<tr><th>담당자</th><td><%=qcOne.get("managerName") %></td></tr>
			<tr><th>답변</th><td><%=qcOne.get("commentContent") %></td></tr>
			<tr><th>작성일</th><td><%=qcOne.get("createdate") %></td></tr>
<%
		}
		}else if(comment == 0){
%>
			
			<tr><th>담당자</th><td></td></tr>
			<tr><th>답변</th><td>매니져 답변 대기중</td></tr>
			<tr><th>작성일</th><td></td></tr>
<% 
		}
%>

	</table>
	</div>
	
	
	
	
	<div class="container">
<% 
	//로그인이 되어 있다면
	if(session.getAttribute("customerNo") != null) {
	// 로그인 한 customerNo 와 문의사항 작성자의 customerNo가 같으면 수정, 삭제 가능
	System.out.println((int)session.getAttribute("customerNo") + "<-- 로그인된 고객번호");
	System.out.println(qDao.askCustomerNo(questionNo) + "<-- 작성자 고객번호");
	}	
%>

	</div>
	<!--  
	<script>
	
	//삭제 버튼을 누르면 다시 한번 확인하기
	$('#deleteQuestionButton').click(function() {

	var result = confirm("정말 삭제하시겠습니까?");
	    
	 if (result) {
	      alert("삭제를 완료했습니다.");
	      var questionNo = '<%= request.getParameter("questionNo") %>';
	      var deleteUrl = '<%= request.getContextPath() %>/deleteQuestionAction.jsp?questionNo=' + questionNo;
	      window.location.href = deleteUrl;
	    } else {
	      alert("삭제를 취소했습니다.");
	      return;
	    }
	});
	
	</script>
-->
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
