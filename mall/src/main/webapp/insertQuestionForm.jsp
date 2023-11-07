<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	// 로그인 후 접근가능
	if(session.getAttribute("customerNo") == null) { // 세션에 customerNo를 만든적이 없다
		response.sendRedirect(request.getContextPath()+"/login.jsp");
		return;
	}
	//String msg = request.getParameter("msg");

%>
<!DOCTYPE html>
<html>
<head>
  	<meta charset="UTF-8">
  	<meta name="viewport" content="width=device-width, initial-scale=1.0">
  	<meta http-equiv="X-UA-Compatible" content="ie=edge">
  	<title>문의사항 추가</title>	
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

<div class="container">
	
<form action="<%=request.getContextPath()%>/insertQuestionAction.jsp" method="post">
		<input type="hidden" name="customerNo" value="<%=session.getAttribute("customerNo")%>">
	<div class="mb-3 mt-3">
		<label for="title" class="form-label">제목</label>
			<input type="text" class="form-control" id="questiontitle" placeholder="제목을 입력하세요." name="questionTitle">
	</div>
	<div class="mb-3 mt-3">
		<label for="goodsName" class="form-label">상품명</label>
			<input type="text" class="form-control" id="goodsTitle" placeholder="상품명을 입력하세요." name="goodsTitle">
	</div>
	<div class="mb-3">
		<label for="comment">문의</label>
			<textarea class="form-control" rows="5" id="questionContent" name="questionContent"></textarea>
	</div>
	<div class="form-check mb-3">	
		<label class="form-check-label">
  			<input class="form-check-input" type="checkbox" name="private"> 비밀글</label>
	</div>

	<button type="submit" class="btn btn-primary">등록</button>
</form>
</div>
	<br>
	<br>
</body>
</html>