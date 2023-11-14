<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>탈퇴하기</title>
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
<%
	//세션 적용(로그인하지 않은 사람은 접근하지 않게 하기 위함)
	int customerNo = 0;
	if(session.getAttribute("customerNo") == null) {
		response.sendRedirect(request.getContextPath()+"/login.jsp");
		return;
	} 

%>

  <!--================ Start Header Menu Area ===============-->
  <jsp:include page="/inc/customerLoginMenu.jsp"></jsp:include>
  <!--================ End Header Menu Area =================-->
  
  <!--================Login Box Area =================-->
	<section class="login_box_area section-margin">
		<div class="container">
			<div class="login_form_inner register_form_inner mx-auto" style="width:500px;">
				<h3>탈퇴하기</h3>	
				<form class="row login_form" id="withdrawalForm">
		            <div class="col-md-12 form-group">
		            	<div>비밀번호 : <input type="password" name="customerPw" id="customerPw" maxlength="15"></div>
		            </div>
            		<div class="col-md-12 form-group">
	            		<div id="msg"></div>
		            </div>            
		            <div class="form-group container" style="width:400px;">
						<button type="button" style="font-size:15px; margin:7px;" class="btn btn-light" id="withdrawalBtn">탈퇴하기</button>					
					</div>
				</form>
			</div>		
		</div>
	</section>
	<!--================End Login Box Area =================-->
	
	<script>
		$('#customerPw').focus();
		
		$('#withdrawalBtn').click(function(){
			
			let customerPw = $('#customerPw').val();
			
			$.ajax({
				url: "<%=request.getContextPath()%>/withdrawalCustomerAction.jsp",
				type: "post",
				data: {customerPw : customerPw},
				dataType: 'json',
				success: function(result) {
					if(result == 1) {
						$('#msg').text('비밀번호를 확인하세요.');
						$('#customerPw').focus();
					} else if(result == 3){
						alert('탈퇴되었습니다.');
						$(location).attr("href","<%=request.getContextPath()%>/home.jsp");
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