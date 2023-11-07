<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매니져 문의사항 관리</title>
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
  
   <style>
      th { background-color: ; }
    </style>
    
</head>
<body>
<% 
	//세션 적용(로그인하지 않은 사람은 접근하지 않게 하기 위함)
	if(session.getAttribute("managerNo") == null) {
		response.sendRedirect(request.getContextPath()+"/managerLogin.jsp");
	}

	int questionNo = Integer.parseInt(request.getParameter("questionNo"));
	System.out.println(questionNo + "<--상세보기할 문의사항 번호");	//디버깅
	
	QuestionDao questionDao = new QuestionDao();
	ArrayList<HashMap<String,Object>> list = questionDao.selectQuestionOne(questionNo);

%>
<!--================ Start Header Menu Area ===============-->
	<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
<!--================ End Header Menu Area =================-->
	<div class="container-fluid">
		<h3>문의사항 관리</h3>
		<table class="table table-hover table-bordered">
			<tr>
				<th>게시물번호</th><td><%=list.get(0).get("questionNo") %></td>
			</tr>
			<tr>
				<th>고객ID</th><td><%=list.get(0).get("customerId") %></td>
			</tr>
			<tr>
				<th>상품</th><td><%=list.get(0).get("goodsTitle") %></td>
			</tr>
			<tr>
				<th>게시물 제목</th><td><%=list.get(0).get("questionTitle") %></td>
			</tr>
			<tr>
				<th>게시물 내용</th><td><%=list.get(0).get("questionContent") %></td>
			</tr>
			<tr>
				<th>작성일</th><td><%=list.get(0).get("createdate") %></td>
			</tr>
			<tr>
				<th>수정일</th><td><%=list.get(0).get("updatedate") %></td>
			</tr>
		</table>	
	</div>
	<div class="container-fluid">
		<a href="<%=request.getContextPath() %>/managerInsertQuestionComentForm.jsp?questionNo=<%=list.get(0).get("questionNo") %>">답글</a>
		<a href="<%=request.getContextPath() %>/managerDeleteQuestionAction.jsp?questionNo=<%=list.get(0).get("questionNo") %>">삭제</a>
	</div>
</body>
</html>