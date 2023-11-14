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
				<form class="row login_form" action="<%=request.getContextPath()%>/managerRegisterAction.jsp" id="signinForm" >
					<div class="col-md-8 form-group">
						<input type="text" class="form-control" id="managerId" name="managerId" placeholder="아이디" maxlength="14" onfocus="this.placeholder = ''" onblur="this.placeholder = '아이디'">
           			</div>
           			<div class="col-md-4 form-group">
       					<button type="button" class="form-control" id="idCheck">중복체크</button>    					
       				</div>
		            <div class="col-md-12 form-group">
						<input type="password" class="form-control" id="managerPw" name="managerPw" placeholder="비밀번호" maxlength="15" onfocus="this.placeholder = ''" onblur="this.placeholder = '비밀번호'">
		            </div>
		            <div class="col-md-12 form-group">
						<input type="password" class="form-control" id="pwCheck" placeholder="비밀번호 확인" maxlength="15" onfocus="this.placeholder = ''" onblur="this.placeholder = '비밀번호 확인'">
		            </div>
					<div class="col-md-12 form-group">
						<input type="text" class="form-control" id="managerName" name="managerName" placeholder="이름" maxlength="10" onfocus="this.placeholder = ''" onblur="this.placeholder = '이름'">
					</div>
		   
					<div class="col-md-12 form-group">
						<button type="button" class="button button-register w-100 mx-auto" id="signBtn" style="margin:30px;">추가하기</button>
						<a href="<%=request.getContextPath()%>/managerLogin.jsp" style="font-size:20px">이전으로</a>
					</div>
				</form>
			</div>		
		</div>
	</section>
	<!--================End Login Box Area =================-->
	
	<script>
	
	// 정규식을 이용한 ID 입력 체크(영문 소문자, 숫자만 입력 가능)
	$('#managerId').keyup(function(){
		$(this).val($(this).val().replace(/[^a-z0-9]/g, ''));
	});
	
	// 정규식을 이용한 이름 입력 체크(영문, 한글만 입력 가능)
	$('#managerName').keyup(function(){
		$(this).val($(this).val().replace(/[^a-zA-Z가-힣]/g, ''));
	});
	
	let isIdCheck = false; 
	
	// 중복체크를 하고 난 뒤 아이디 입력란에 사용 가능한 아이디를 지우고 새로운 아이디를 입력했을 경우에 대처
	$('#customerId').keydown(function(){
		isIdCheck = false;
	});
	
	// ID 중복체크, 유효성 검증
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
						alert('이미 등록된 아이디입니다. 다른 아이디를 입력하세요.');
						$('#managerId').focus();
					} else {
						if(managerId.length < 5) {
							alert('아이디를 5자 이상 입력하세요.');
							$('#managerId').focus();
						} else {
							isIdCheck = true;
							alert('사용 가능한 아이디입니다.');
							$('#managerPw').focus();
						}
					}
				}
			});
		} else {
			alert('아이디를 입력해 주세요.');	
			$('#managerId').focus();
		}		
   });
	
	// 가입하기 
	$('#signBtn').click(function(){
		
		if(isIdCheck == false) {
			alert('ID 중복체크를 하세요.')
			return;
		}
		
		let checkNumber = $('#managerPw').val().search(/[0-9]/g);
	    let checkEnglish = $('#managerPw').val().search(/[a-z]/ig);
	    
		if($('#managerPw').val() == "") { 
			// 비밀번호 창에 아무것도 입력하지 않았을 때
			alert('비밀번호를 입력하세요.');
			return;
		} else if($('#managerPw').val() != $('#pwCheck').val()) { 
			// 비밀번호 일치 확인
			alert('비밀번호가 일치하지 않습니다.');
			return;
		} else if($('#managerPw').val().length < 6 || $('#pwCheck').val().length < 6) { 
			// 비밀번호 창의 입력값의 length가 6 미만일 때
			alert('비밀번호를 6자 이상 입력하세요.');
			return;
		} else if(checkNumber <0 || checkEnglish <0){
			// 숫자와 영어를 혼용하지 않았을 때
	        alert("비밀번호는 숫자와 영문자를 혼용하여야 합니다.");
	        return;
	    } 
		
		if($('#managerName').val() == "") {
			// 이름 창에 아무것도 입력하지 않았을 때
			alert('이름을 입력하세요.');
			return;
		} else if($('#managerName').val().length < 2) { 
			// 이름 창의 입력값의 length가 2 미만일 때
			alert('이름을 2자 이상 입력하세요.');
			return;
		}
				
		alert('가입이 완료되었습니다.')
		$('#signinForm').submit();
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