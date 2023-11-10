<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
    
<%
	// 로그인 후 접근가능
	if(session.getAttribute("customerNo") == null) { // 세션에 customerNo를 만든적이 없다
		response.sendRedirect(request.getContextPath()+"/login.jsp");
		return;
	}
	//String msg = request.getParameter("msg");

%>
<!DOCTYPE html>
<html>
<head>
  	<meta charset="UTF-8">
  	<meta name="viewport" content="width=device-width, initial-scale=1.0">
  	<meta http-equiv="X-UA-Compatible" content="ie=edge">
  	<title>문의사항 추가</title>	
  	<link rel="icon" href="img/Fevicon.png" type="image/png">
  	<link rel="stylesheet" href="vendors/bootstrap/bootstrap.min.css">
  	<link rel="stylesheet" href="vendors/fontawesome/css/all.min.css">	
  	<link rel="stylesheet" href="vendors/themify-icons/themify-icons.css">
	<link rel="stylesheet" href="vendors/linericon/style.css">
  	<link rel="stylesheet" href="vendors/owl-carousel/owl.theme.default.min.css">
  	<link rel="stylesheet" href="vendors/owl-carousel/owl.carousel.min.css">
  	<link rel="stylesheet" href="css/style.css">
  	<link rel="stylesheet" href="vendors/nice-select/nice-select.css">
  	<link rel="stylesheet" href="vendors/nouislider/nouislider.min.css">
  
  	<!--구글폰트 -->
  	<link rel="preconnect" href="https://fonts.googleapis.com">
  	<link rel="preconnect" href="https://fonts.gstatic.com">
  	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&display=swap" >
  	<link rel="stylesheet" href="css/font.css">
  
</head>
<style>
select {
			width: 200px;
			padding: .8em .5em;
			border: 1px solid #999;
			font-family: inherit;
			background: url('arrow.jpg') no-repeat 95% 50%;
			border-radius: 0px;
			-webkit-appearance: none;
			-moz-appearance: none;
			appearance: none;
}

</style>
<body>
<!--================ Start Header Menu Area ===============-->
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
<!--================ End Header Menu Area =================-->
<!-- ================ start banner area ================= -->
	<br>
	<div class="container">
		<div class="text-center">
			<h1>Question</h1>
		</div>
    </div>
<!-- ================ end banner area ================= -->
<%
	QuestionDao questionDao = new QuestionDao();
	 ArrayList<HashMap<String,Object>> list = questionDao.selectQuestionGoodsList();
	 int totalGoods = list.size();
	 System.out.println(totalGoods + "<--상품 총 개수 출력");
	 
%>

<div class="container">
	
<form action="<%=request.getContextPath()%>/insertQuestionAction.jsp" method="post">
		<input type="hidden" name="customerNo" value="<%=session.getAttribute("customerNo")%>">
	<div class="mb-3 mt-3">
		<select name="questionType" id="questionType">
				 <option selected="selected">-문의종류-</option>
				 <option value="[배송]">[배송]</option>
				 <option value="[상품]">[상품]</option>
				 <option value="[AS]" >[AS]</option>
				 <option value="[환불]">[환불]</option>			
				 <option value="[기타]">[기타]</option>			
		</select>
		<br>
		<select name="goodsTitle" id="goodsTitle">
				 <option selected="selected">-상품명-</option>
				 <%
				 	for(int i = 0 ; i <totalGoods; i=i+1){
				 %>
				 <option value="<%=list.get(i).get("goodsTitle") %>"><%=list.get(i).get("goodsTitle") %></option>		
				 <%
				 	}
				 %>	
		</select>
		<br>
		<br>
		<br>
	</div>
	<div class="mb-3 mt-3">
		<label for="title" class="form-label">제목</label>
			<input type="text" class="form-control" id="questiontitle" placeholder="제목을 입력하세요." name="questionTitle">
	</div>
	<div class="mb-3">
		<label for="comment">문의</label>
			<textarea class="form-control" rows="5" id="questionContent" name="questionContent"></textarea>
	</div>
	<!--  
	<div class="form-check mb-3">	
		<label class="form-check-label">
  			<input class="form-check-input" type="checkbox" name="private"> 비밀글</label>
	</div>-->
	<div class="text-right">
	<button type="submit" class="btn btn-dark">등록</button>
	</div>
</form>
</div>
	<br>
	<br>
	<script src="vendors/jquery/jquery-3.2.1.min.js"></script>
  	<script src="vendors/bootstrap/bootstrap.bundle.min.js"></script>
  	<script src="vendors/skrollr.min.js"></script>
  	<script src="vendors/owl-carousel/owl.carousel.min.js"></script>
  	<script src="vendors/nice-select/jquery.nice-select.min.js"></script>
  	<script src="vendors/nouislider/nouislider.min.js"></script>
  	<script src="vendors/jquery.ajaxchimp.min.js"></script>
  	<script src="vendors/mail-script.js"></script>
  	<script src="js/main.js"></script>
</body>
</html>