<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>상품 추가</title>
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
	if(session.getAttribute("managerNo") == null) {
		response.sendRedirect(request.getContextPath()+"/managerLogin.jsp");
	}
%>

	<!--================ Start Header Menu Area ===============-->
  	<jsp:include page="/inc/managerMenu.jsp"></jsp:include>
  	<!--================ End Header Menu Area =================-->
  
  <!--================Login Box Area =================-->
	<section class="login_box_area section-margin">
		<div class="container">
			<div class="login_form_inner register_form_inner mx-auto" style="width:500px;">
				<h3>상품 추가</h3>
				<form method="post" enctype="multipart/form-data" class="row login_form" action="<%=request.getContextPath()%>/addGoodsAction.jsp">
					<div class="col-md-12 form-group">
						<input type="text" class="form-control" id="goodsTitle" name="goodsTitle" placeholder="상품 이름" maxlength="15" onfocus="this.placeholder = ''" onblur="this.placeholder = '상품 이름'">
           				</div>
		            <div class="col-md-12 form-group">
						<input type="number" class="form-control" id="goodsPrice" name="goodsPrice" placeholder="상품 가격" onfocus="this.placeholder = ''" onblur="this.placeholder = '상품 가격'">
		            </div>
					<div class="col-md-12 form-group">
						<textarea class="form-control" rows="7" name="goodsMemo" placeholder="메모" onfocus="this.placeholder = ''" onblur="this.placeholder = '메모'"></textarea>
					</div>
					<div class="col-md-12 form-group">
						<input type="file" class="form-control" id="goodsImg" name="goodsImg">
		            </div>
		   
					<div class="col-md-12 form-group">
						<button type="submit" value="submit" class="button button-register w-100 mx-auto" style="margin:30px;">추가하기</button>
					</div>
				</form>
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