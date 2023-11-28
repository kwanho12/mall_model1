<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta charset="UTF-8">
<title>관리자 공지 관리</title>
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

%>
<!--================ Start Header Menu Area ===============-->
	<jsp:include page="/inc/managerMenu.jsp"></jsp:include>
<!--================ End Header Menu Area =================-->

<div class="container">
<h3>공지 추가</h3><br>
	
<form action="<%=request.getContextPath()%>/managerInsertNoticeAction.jsp" method="post" id="insertNotice">
		<input type="hidden" name="managerNo" value="<%=session.getAttribute("managerNo")%>">
	<div class="mb-3 mt-3">
		<label for="title" class="form-label">제목</label>
			<input type="text" class="form-control" id="noticeTitle" placeholder="제목을 입력하세요." name="noticeTitle">
	</div>
	<div class="mb-3">
		<label for="comment">공지사항</label>
			<textarea class="form-control" rows="5" id="noticeContent" name="noticeContent"></textarea>
	</div>
	
	<button type="button" class="btn btn-dark" id="button">등록</button>
</form>

</div>
	<script>
	$('#button').click(function() {

	//공지 제목 필수 입력
	if($('#noticeTitle').val() == ""){
		alert('공지제목을 입력하세요.');
		return;
	}
	
	//공지 내용 필수 입력
	if($('#noticeContent').val() == ""){
		alert('공지내용을 입력하세요.');
		return;
	}

	alert('공지사항작성이 완료되었습니다.')
	$('#insertNotice').submit();
	});
	
	</script>
</body>
</html>