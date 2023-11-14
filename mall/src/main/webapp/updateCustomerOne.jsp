<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.CustomerDao"%>
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
  <title>마이페이지</title>
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
	int customerNo = 0;
	if(session.getAttribute("customerNo") == null) {
		response.sendRedirect(request.getContextPath()+"/login.jsp");
		return;
	} else {
		customerNo = (Integer) session.getAttribute("customerNo");
	}

	CustomerDao customerDao = new CustomerDao();
	ArrayList<HashMap<String,Object>> list = customerDao.customerOne(customerNo);
	
	String msg = request.getParameter("msg");
%>

  <!--================ Start Header Menu Area ===============-->
  <jsp:include page="/inc/customerLoginMenu.jsp"></jsp:include>
  <!--================ End Header Menu Area =================-->
  
  <!--================Login Box Area =================-->
	<section class="login_box_area section-margin">
		<div class="container">
			<div class="login_form_inner register_form_inner mx-auto" style="width:500px;">
				<h3>마이페이지</h3>
				
			<% 
				for(HashMap<String,Object> map : list) {
			%>				
				<form class="row login_form" action="<%=request.getContextPath()%>/updateCustomerOneAction.jsp" id="updateForm">
		            <div class="col-md-12 form-group">
		            	<div>ID : <input type="text" value="<%=map.get("customerId")%>" maxlength="14"  readonly></div>
		            </div>
		            <div class="col-md-12 form-group">
		            	<div>이름 : <input type="text" value="<%=map.get("customerName")%>" name="customerName" id="customerName" maxlength="10"></div>
		            </div>
		            <div class="col-md-12 form-group">
		            	<div>휴대폰 번호 : <input type="text" value="<%=map.get("customerPhone")%>" name="customerPhone" id="customerPhone" maxlength="11"></div>
		            </div>      
        	        <div class="col-md-12 form-group">
		            	<div>주소 : <textarea rows="2" cols="50" style="resize:none;" name="address" id="address"><%=map.get("address")%></textarea></div>
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
		$('#customerName').focus();
		
		// 정규식을 이용한 이름 입력 체크(영문, 한글만 입력 가능)
		$('#customerName').keyup(function(){
			$(this).val($(this).val().replace(/[^a-zA-Z가-힣]/g, ''));
		});
		
		// 정규식을 이용한 휴대폰 번호 입력 체크(숫자만 입력 가능)
		$('#customerPhone').keyup(function(){
			$(this).val($(this).val().replace(/[^0-9]/g, ''));
		});
		
		// 수정 버튼 클릭
		$('#updateBtn').click(function(){
			if($('#customerName').val() == "") {
				// 이름 창에 아무것도 입력하지 않았을 때
				alert('이름을 입력하세요.');
				return;
			} else if($('#customerName').val().length < 2) { 
				// 이름 창의 입력값의 length가 2 미만일 때
				alert('이름을 2자 이상 입력하세요.');
				return;
			}
			
			if($('#customerPhone').val() == "") {
				// 휴대폰 번호 창에 아무것도 입력하지 않았을 때
				alert('휴대폰 번호를 입력하세요.');
				return;
			} else if(($('#customerPhone').val().length != 11) || ($('#customerPhone').val().substr(0,3) != '010') ) {
				// 휴대폰 번호의 길이가 11이 아니거나 번호가 010으로 시작하지 않을 때
				alert('휴대폰 번호의 형식이 올바르지 않습니다.');
				return;
			}
			
			if($('#address').val() == "") {
				// 주소 창에 아무것도 입력하지 않았을 때
				alert('주소를 입력하세요.');
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