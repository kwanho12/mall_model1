<%@page import="vo.Goods"%>
<%@page import="dao.GoodsOneDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>상품 수정</title>
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

	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	GoodsOneDao goodsOneDao = new GoodsOneDao();
	Goods g = goodsOneDao.goodsOne(goodsNo);
%>

	<!--================ Start Header Menu Area ===============-->
  	<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
  	<!--================ End Header Menu Area =================-->
  
  <!--================Login Box Area =================-->
	<section class="login_box_area section-margin">
		<div class="container">
			<div class="login_form_inner register_form_inner mx-auto" style="width:500px;">
				<h3>상품 수정</h3>
		
				<form method="post" enctype="multipart/form-data" class="row login_form" action="<%=request.getContextPath()%>/updateGoodsAction.jsp?goodsNo=<%=g.getGoodsNo()%>">
	
					<div class="col-md-12 form-group">
						<div>상품 번호 : <input type="text" value="<%=g.getGoodsNo()%>" readonly></div>
         			</div>
         			
					<div class="col-md-12 form-group">
						<input type="file" name="goodsImg">
         			</div>
		            <div class="col-md-12 form-group">
		            	<div>상품 이름 : <input type="text" value="<%=g.getGoodsTitle()%>" name="goodsTitle"></div>
		            </div>
		            <div class="col-md-12 form-group">
		            	<div>상품 가격 : <input type="text" value="<%=g.getGoodsPrice()%>" name="goodsPrice"></div>
		            </div>
		            <div class="col-md-12 form-group">
		            	<div>soldout : <input type="text" value="<%=g.getSoldout()%>" name="soldout"></div>
		            </div>
		            <div class="col-md-12 form-group">
		            	<div>createdate : <input type="text" value="<%=g.getCreatedate()%>" readonly></div>
		            </div>
		            <div class="col-md-12 form-group">
		            	<div>updatedate : <input type="text" value="<%=g.getUpdatedate()%>" readonly></div>
		            </div>
        	        <div class="col-md-12 form-group">
		            	<div>memo <textarea class="form-control" rows="7" name="goodsMemo"><%=g.getGoodsMemo()%></textarea></div>
		            </div>
		           
					<div class="col-md-12 form-group">
						<button type="submit" value="submit" class="button button-register w-100 mx-auto" style="margin:30px;">수정완료</button>
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