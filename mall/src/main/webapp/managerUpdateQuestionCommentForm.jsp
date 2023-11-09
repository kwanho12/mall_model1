<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%
	//로그인 후 접근가능
	if(session.getAttribute("managerNo") == null) { // 세션에 managerNo를 만든적이 없다
		response.sendRedirect(request.getContextPath()+"/managerLogin.jsp");
		return;
	}
	
	int questionNo = Integer.parseInt(request.getParameter("questionNo"));
	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	
	
	QuestionCommentDao questionCommentDao = new QuestionCommentDao();
	
	ArrayList<HashMap<String, Object>> list = questionCommentDao.selectQuestionCommentOne(questionNo);
	
	//ArrayList<HashMap<String, Object>> 값 가져와서 변수에 저장
	String commentContent = list.get(0).get("commentContent").toString();

%>
<!DOCTYPE html>
<html>
<head>
  	<meta charset="UTF-8">
  	<meta name="viewport" content="width=device-width, initial-scale=1.0">
  	<meta http-equiv="X-UA-Compatible" content="ie=edge">
  	<title>답글 수정</title>	
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
  	<link rel="preconnect" href="https://fonts.gstatic.com">
  	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&display=swap" >
  	<link rel="stylesheet" href="css/font.css">
  
</head>
<body>
<!--================ Start Header Menu Area ===============-->
	<jsp:include page="/inc/managerMenu.jsp"></jsp:include>
<!--================ End Header Menu Area =================-->

<div class="container">
	<h3>답글 수정</h3><br>
	<form action="<%=request.getContextPath()%>/managerUpdateQuestionCommentAction.jsp" method="post">
		<input type="hidden" name="managerNo" value="<%=session.getAttribute("managerNo")%>">
		<input type="hidden" name="questionNo" value="<%=questionNo%>">
		<input type="hidden" name="commentNo" value="<%=commentNo%>">
<div class="mb-3 mt-3">
	<label for="title" class="form-label">문의사항번호</label>
	<input type="text" class="form-control" id="commentNo" name="commentNo" value="<%=questionNo%>" readonly="readonly">
</div>
<div class="mb-3">
	<label for="comment">답변 내용</label>
		<textarea class="form-control" rows="5" id="commentContent" name="commentContent" ><%=commentContent%></textarea>
</div>
<div class="text-right">
	<button type="submit" class="btn btn-dark">수정</button>
</div>
</form>
</div>
</body>
</html>