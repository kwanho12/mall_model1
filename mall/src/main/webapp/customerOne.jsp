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
	
%>

  <!--================ Start Header Menu Area ===============-->
  <jsp:include page="/inc/customerLoginMenu.jsp"></jsp:include>
  <!--================ End Header Menu Area =================-->
  
  <!--================Login Box Area =================-->
	<section class="login_box_area section-margin">
		<div class="container">
			<div class="login_form_inner register_form_inner mx-auto" style="width:500px;">
				<h3>내 정보</h3>
				
			<% 
				for(HashMap<String,Object> map : list) {
			%>				
				<form class="row login_form" action="<%=request.getContextPath()%>/updateCustomerOne.jsp">
		            <div class="col-md-12 form-group">
		            	<div>ID : <input type="text" value="<%=map.get("customerId")%>" name="customerId" readonly></div>
		            </div>
		            <div class="col-md-12 form-group">
		            	<div>이름 : <input type="text" value="<%=map.get("customerName")%>" name="customerName" readonly></div>
		            </div>
		            <div class="col-md-12 form-group">
		            	<div>휴대폰 번호 : <input type="text" value="<%=map.get("customerPhone")%>" name="customerPhone" readonly></div>
		            </div>      
        	        <div class="col-md-12 form-group">
		            	<div>주소 : <textarea rows="2" cols="50" style="resize:none; border:none; text-align:center;" name="address" readonly><%=map.get("address")%></textarea></div>
		            </div> 
		            
		            <div class="form-group container" style="width:400px;">
						<button style="font-size:15px; margin:10px;" class="btn btn-light">수정하기</button>
						<button type="button" style="font-size:15px; margin:7px;" class="btn btn-light" onclick="location.href='updateCustomerPw.jsp'">비밀번호 변경</button>
						<button type="button" style="font-size:15px; margin:7px;" class="btn btn-light" onclick="location.href='withdrawalCustomer.jsp'">탈퇴하기</button>														
					</div>
				</form>
			<%
				}
			%>
				
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