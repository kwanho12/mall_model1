<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>회원가입</title>
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
  	body {overflow : hidden;}
  </style>
</head>
<body>
  <!--================ Start Header Menu Area ===============-->
  <jsp:include page="/inc/customerLogoutMenu.jsp"></jsp:include>
  <!--================ End Header Menu Area =================-->
  
  
  <!--================Login Box Area =================-->
	<section class="login_box_area">
		<div class="container">
			<div class="row">
				<div class="col-lg-6">
					<div class="login_box_img">
						<div class="hover">
							<h4>이미 회원가입이 되어 있나요?</h4>
							
							<a class="button button-account" href="<%=request.getContextPath()%>/login.jsp">로그인</a>
						</div>
					</div>
				</div>
				<div class="col-lg-6">
					<div class="login_form_inner register_form_inner">
						<h3>회원가입</h3>
						<form class="row login_form" action="<%=request.getContextPath()%>/registerAction.jsp" id="register_form" >
							<div class="col-md-12 form-group">
								<input type="text" class="form-control" id="customerId" name="customerId" placeholder="아이디" onfocus="this.placeholder = ''" onblur="this.placeholder = '아이디'">
             				</div>
				            <div class="col-md-12 form-group">
								<input type="password" class="form-control" id="customerPw" name="customerPw" placeholder="비밀번호" onfocus="this.placeholder = ''" onblur="this.placeholder = '비밀번호'">
				            </div>
							<div class="col-md-12 form-group">
								<input type="text" class="form-control" id="customerName" name="customerName" placeholder="이름" onfocus="this.placeholder = ''" onblur="this.placeholder = '이름'">
							</div>
				            <div class="col-md-12 form-group">
								<input type="text" class="form-control" id="address" name="address" placeholder="주소" onfocus="this.placeholder = ''" onblur="this.placeholder = '주소'">
							</div>
							<div class="col-md-12 form-group">
								<input type="text" class="form-control" id="customerPhone" name="customerPhone" placeholder="휴대폰 번호" onfocus="this.placeholder = ''" onblur="this.placeholder = '휴대폰 번호'">
							</div>
							<div class="col-md-12 form-group">
								<button type="submit" value="submit" class="button button-register w-100">가입하기</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!--================End Login Box Area =================-->


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