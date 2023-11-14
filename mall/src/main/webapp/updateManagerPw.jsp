<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>관리자 비밀번호 변경</title>
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
  
  <!-- jQuery -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
<%
	//세션 적용(로그인하지 않은 사람은 접근하지 않게 하기 위함)
	int managerNo = 0;
	if(session.getAttribute("managerNo") == null) {
		response.sendRedirect(request.getContextPath()+"/managerLogin.jsp");
		return;
	} else {
		managerNo = (Integer) session.getAttribute("managerNo");
	}

%>

	<!--================ Start Header Menu Area ===============-->
    <jsp:include page="/inc/managerMenu.jsp"></jsp:include>
    <!--================ End Header Menu Area =================-->
  
  <!--================Login Box Area =================-->
	<section class="login_box_area section-margin">
		<div class="container">
			<div class="login_form_inner register_form_inner mx-auto" style="width:500px;">
				<h3>관리자 비밀번호 변경</h3>	
				<form class="row login_form" id="updateForm">
		            <div class="col-md-12 form-group">
		            	<div>원래 비밀번호 : <input type="password" name="oldPw" id="oldPw" maxlength="15"></div>
		            </div>
		            <div class="col-md-12 form-group">
		            	<div>변경할 비밀번호 : <input type="password" name="newPw" id="newPw" maxlength="15"></div>
		            </div> 
            		<div class="col-md-12 form-group">
	            		<div id="msg"></div>
		            </div>            
		            <div class="form-group container" style="width:400px;">
						<button type="button" style="font-size:15px; margin:7px;" class="btn btn-light" id="updateBtn">변경완료</button>					
					</div>
				</form>
			</div>		
		</div>
	</section>
	<!--================End Login Box Area =================-->
	
	<script>
		$('#oldPw').focus();
		
		$('#updateBtn').click(function(){
	    	
	    	let checkNumber = $('#newPw').val().search(/[0-9]/g);
		    let checkEnglish = $('#newPw').val().search(/[a-z]/ig);
	    	
	    	if($('#oldPw').val() == "") { 
				// 원래 비밀번호 창에 아무것도 입력하지 않았을 때
				$('#msg').text('원래 비밀번호를 입력하세요.')
				return;
			} else if($('#newPw').val() == "") { 
				// 비밀번호 창에 아무것도 입력하지 않았을 때
				$('#msg').text('변경할 비밀번호를 입력하세요.')
				return;
			}  else if($('#newPw').val().length < 6) { 
				// 비밀번호 창의 입력값의 length가 6 미만일 때
				$('#msg').text('변경할 비밀번호를 6자 이상 입력하세요.')
				return;
			} else if(checkNumber <0 || checkEnglish <0){
				// 숫자와 영어를 혼용하지 않았을 때
				$('#msg').text('변경할 비밀번호는 숫자와 영문자를 혼용하여야 합니다.')
		        return;
		    }
	 	    	
	    	let dataset = $('#updateForm').serialize();
	    	
	    	$.ajax({
				url: "<%=request.getContextPath()%>/updateManagerPwAction.jsp",
				type: "post",
				data: dataset,
				dataType: 'json',
				success: function(result) {
					if(result == 1) {
						$('#msg').text('변경할 비밀번호가 이전 비밀번호와 같습니다.');
						$('#newPw').focus();
					} else if(result == 2){
						$('#msg').text('입력한 원래 비밀번호가 일치하지 않습니다.');
						$('#oldPw').focus();
					} else if(result == 4){
						alert('비밀번호가 변경되었습니다.')
						$(location).attr("href","<%=request.getContextPath()%>/managerOne.jsp?managerNo=<%=managerNo%>");
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