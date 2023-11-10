<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>관리자 추가</title>
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
			<div class="login_form_inner register_form_inner mx-auto" style="width:500px;">
				<h3>관리자 추가</h3>
				<form class="row login_form" action="<%=request.getContextPath()%>/managerRegisterAction.jsp" id="register_form" >
					<div class="col-md-8 form-group">
						<input type="text" class="form-control" id="managerId" name="managerId" placeholder="아이디" onfocus="this.placeholder = ''" onblur="this.placeholder = '아이디'">
           			</div>
           			<div class="col-md-4 form-group">
       					<button type="button" class="form-control" id="idCheck">중복체크</button>    					
       				</div>
		            <div class="col-md-12 form-group">
						<input type="password" class="form-control" id="managerPw" name="managerPw" placeholder="비밀번호" onfocus="this.placeholder = ''" onblur="this.placeholder = '비밀번호'">
		            </div>
					<div class="col-md-12 form-group">
						<input type="text" class="form-control" id="managerName" name="managerName" placeholder="이름" onfocus="this.placeholder = ''" onblur="this.placeholder = '이름'">
					</div>
		   
					<div class="col-md-12 form-group">
						<button type="submit" value="submit" class="button button-register w-100 mx-auto" style="margin:30px;">추가하기</button>
						<a href="<%=request.getContextPath()%>/managerLogin.jsp" style="font-size:20px">이전으로</a>
					</div>
				</form>
			</div>		
		</div>
	</section>
	<!--================End Login Box Area =================-->
	
	<script>
	// ID 중복체크
	$('#idCheck').click(function(){
	
		let managerId = $('#managerId').val(); // 입력된 id를 가져 옴.
		
		if(managerId != "") {
			$.ajax({
				url: "<%=request.getContextPath()%>/managerIdCheckAction.jsp",
				type: "post",
				data: {managerId : managerId},
				dataType: 'json',
				success: function(result) {
					if(result == 0) {
						alert('이미 등록된 아이디입니다.');
					} else {
						alert('사용 가능한 아이디입니다.');
					}
				}
			});
		} else {
			alert('아이디를 입력해 주세요.');	
		}		
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