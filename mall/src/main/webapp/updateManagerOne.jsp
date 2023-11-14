<%@page import="vo.Manager"%>
<%@page import="dao.ManagerDao"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.GoodsDao"%>
<%@page import="vo.Goods"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>관리자 수정</title>
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

	ManagerDao managerDao = new ManagerDao();
	ArrayList<Manager> list = managerDao.managerOne(managerNo);
	
%>

	<!--================ Start Header Menu Area ===============-->
    <jsp:include page="/inc/managerMenu.jsp"></jsp:include>
    <!--================ End Header Menu Area =================-->
  
  <!--================Login Box Area =================-->
	<section class="login_box_area section-margin">
		<div class="container">
			<div class="login_form_inner register_form_inner mx-auto" style="width:500px;">
				<h3>관리자 정보 수정</h3>
				
			<% 
				for(Manager m : list) {
			%>				
				<form class="row login_form" id="updateForm" action="<%=request.getContextPath()%>/updateManagerOneAction.jsp">
		            <div class="col-md-12 form-group">
		            	<div>ID : <input type="text" value="<%=m.getManagerId()%>" readonly></div>
		            </div>
		            <div class="col-md-12 form-group">
		            	<div>이름 : <input type="text" value="<%=m.getManagerName()%>" name="managerName" id="managerName" maxlength="10"></div>
		            </div>
		            <div class="col-md-12 form-group">
		            	<div>가입 날짜 : <input type="text" value="<%=m.getCreatedate()%>" readonly></div>
		            </div>
		            <div class="col-md-12 form-group">
		            	<div>수정 날짜 : <input type="text" value="<%=m.getUpdatedate()%>" readonly></div>
		            </div>     
		            
		            <div class="form-group container" style="width:400px;">
						<button type="button" style="font-size:15px; margin:10px;" class="btn btn-light" id="updateBtn">수정완료</button>													
					</div>
				</form>
			<%
				}
			%>
				
			</div>
					
		</div>
	</section>
	<!--================End Login Box Area =================-->
	
	<script>
		$('#managerName').focus();
		
		$('#updateBtn').click(function(){
			if($('#managerName').val() == "") {
				// 이름 창에 아무것도 입력하지 않았을 때
				alert('이름을 입력하세요.');
				$('#managerName').focus();
				return;
			} else if($('#managerName').val().length < 2) { 
				// 이름 창의 입력값의 length가 2 미만일 때
				alert('이름을 2자 이상 입력하세요.');
				$('#managerName').focus();
				return;
			}
			
			alert('정보가 수정되었습니다.')
			
			$('#updateForm').submit();
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