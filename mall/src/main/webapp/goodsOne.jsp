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
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	GoodsDao goodsDao = new GoodsDao();
	Goods g = goodsDao.goodsOne(goodsNo);
	
	// 이미지 파일 이름 가져 오기
	GoodsDao GoodsDao = new GoodsDao();
	String filename = goodsDao.getOldFilename(goodsNo);
%>

	<!--================ Start Header Menu Area ===============-->
	  <%
	  	if(session.getAttribute("customerNo") != null) {
	  %>
	  		<jsp:include page="/inc/customerLoginMenu.jsp"></jsp:include>
	  <% 	
	  	} else {
	  %>
	  		<jsp:include page="/inc/customerLogoutMenu.jsp"></jsp:include>
	  <% 	
	  	}
	  %>
  <!--================ End Header Menu Area =================-->
  
  <!--================Login Box Area =================-->
	<section class="login_box_area section-margin">
		<div class="container">
			<div class="login_form_inner register_form_inner mx-auto" style="width:500px;">
				<h3>상품 상세정보</h3>
				
				<img class="card-img" src="<%=request.getContextPath()%>/upload/<%=filename%>">
				
				<form class="row login_form">
		            <div class="col-md-12 form-group">
		            	<div>상품 이름 : <input type="text" value="<%=g.getGoodsTitle()%>" readonly></div>
		            </div>
		            <div class="col-md-12 form-group">
		            	<div>상품 가격 : <input type="text" value="<%=g.getGoodsPrice()%>" readonly></div>
		            </div>
		            <div class="col-md-12 form-group">
		            	<div>soldout : <input type="text" value="<%=g.getSoldout()%>" readonly></div>
		            </div>      
        	        <div class="col-md-12 form-group">
		            	<div>상품 설명 <textarea class="form-control" rows="7" name="goodsMemo" placeholder="<%=g.getGoodsMemo()%>" readonly></textarea></div>
		            </div>
				</form>
				<div class="form-group container" style="width:400px;">
					<a href="<%=request.getContextPath()%>/goodsList.jsp" style="font-size:15px; margin:10px;" class="btn btn-light">이전으로</a>
					<a href="<%=request.getContextPath()%>/cartAction.jsp?goodsNo=<%=goodsNo%>" style="font-size:15px; margin:10px;" class="btn btn-light">장바구니에 추가</a>
					<a href="<%=request.getContextPath()%>/goodsList.jsp" style="font-size:15px; margin:10px;" class="btn btn-light">구매하기</a>
				</div>
				
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