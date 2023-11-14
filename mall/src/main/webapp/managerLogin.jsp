<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	if(session.getAttribute("customerId") != null) { // 로그인 되어 있으면 
	response.sendRedirect(request.getContextPath()+"/home.jsp");
	return;	
	}
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>관리자 로그인</title>
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
  
  <!-- jQuery CDN 주소 -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script> 
</head>
<body>
  
  <!--================Login Box Area =================-->
	<section class="login_box_area section-margin">
		<div class="container">
			<div class="login_form_inner mx-auto" style="width:500px;">
				<h3 style="margin-bottom:70px;">관리자 로그인 화면</h3>
				<div id="msg" style="margin-bottom:40px;"></div>
				<form class="row login_form" id="loginForm" >
					<div class="col-md-12 form-group">
						<input type="text" class="form-control" id="managerId" name="managerId" placeholder="아이디" onfocus="this.placeholder = ''" onblur="this.placeholder = '아이디'">
					</div>
					<div class="col-md-12 form-group">
						<input type="password" class="form-control" id="managerPw" name="managerPw" placeholder="비밀번호" onfocus="this.placeholder = ''" onblur="this.placeholder = '비밀번호'">
					</div>
					
					<div class="col-md-12 form-group">
						<button type="button" class="button button-login w-100 mx-auto" id="loginBtn" style="margin:20px;">로그인</button>
						<a href="<%=request.getContextPath()%>/managerRegister.jsp" style="font-size:20px;">관리자 추가</a>
						<a href="<%=request.getContextPath()%>/home.jsp" style="font-size:20px;">홈페이지로 이동</a>
					</div>
				</form>
			</div>	
		</div>
	</section>
	<!--================End Login Box Area =================-->
	
	<script>
		$('#loginBtn').click(function(){
			
			let dataset = $('#loginForm').serialize();
			
			$.ajax({
				url: "<%=request.getContextPath()%>/managerLoginAction.jsp",
				type: "post",
				data: dataset,
				dataType: 'json',
				success: function(result) {
					if(result == 1) {
						$('#msg').text('ID, 비밀번호가 일치하지 않습니다.');					
					} else if(result == 2) {
						$('#msg').text('탈퇴된 관리자입니다.');
					} else if(result == 3){
						alert('로그인 성공하였습니다.');
						$(location).attr("href","<%=request.getContextPath()%>/customerList.jsp");	
					}
				}
			});
		});
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