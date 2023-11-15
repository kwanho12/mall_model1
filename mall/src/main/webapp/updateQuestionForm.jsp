<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%
	//로그인 후 접근가능
	if(session.getAttribute("customerNo") == null) { // 세션에 customerNo를 만든적이 없다
		response.sendRedirect(request.getContextPath()+"/login.jsp");
		return;
	}
	
	int questionNo = Integer.parseInt(request.getParameter("questionNo"));
	QuestionDao questionDao = new QuestionDao();
	ArrayList<HashMap<String, Object>> list = questionDao.selectQuestionOne(questionNo);
	
	//ArrayList<HashMap<String, Object>> 값 가져와서 변수에 저장
	String goodsTitle = list.get(0).get("goodsTitle").toString();
	String questionTitle = list.get(0).get("questionTitle").toString();
	String questionContent = list.get(0).get("questionContent").toString();

%>
<!DOCTYPE html>
<html>
<head>
  	<meta charset="UTF-8">
  	<meta name="viewport" content="width=device-width, initial-scale=1.0">
  	<meta http-equiv="X-UA-Compatible" content="ie=edge">
  	<title>문의사항 수정</title>	
  	<link rel="icon" href="img/Fevicon.png" type="image/png">
  	<link rel="stylesheet" href="vendors/bootstrap/bootstrap.min.css">
  	<link rel="stylesheet" href="vendors/fontawesome/css/all.min.css">	
  	<link rel="stylesheet" href="vendors/themify-icons/themify-icons.css">
	<link rel="stylesheet" href="vendors/linericon/style.css">
  	<link rel="stylesheet" href="vendors/owl-carousel/owl.theme.default.min.css">
  	<link rel="stylesheet" href="vendors/owl-carousel/owl.carousel.min.css">
  	<link rel="stylesheet" href="css/style.css">
  
  	<!--구글폰트 -->
  	<link rel="preconnect" href="https://fonts.googleapis.com">
  	<link rel="preconnect" href="https://fonts.gstatic.com">
  	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&display=swap" >
  	<link rel="stylesheet" href="css/font.css">
  	
  	<!-- jQuery CDN-->
  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
  
</head>
<body>
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

<!-- ================ start banner area ================= -->
	<br>
	<div class="container">
		<div class="text-center">
			<h1>QnA</h1>
		</div>
    </div>
<!-- ================ end banner area ================= -->

	<div class="container">
		<p>문의사항 내용만 수정이 가능합니다!</p>
	
	<form action="<%=request.getContextPath()%>/updateQuestionAction.jsp" method="post" id="updateQuestionForm">
			<input type="hidden" name="customerNo" value="<%=session.getAttribute("customerNo")%>">
			<input type="hidden" name="questionNo" value="<%=questionNo%>">
  		<div class="mb-3 mt-3">
    		<label for="title" class="form-label">제목</label>
    			<input type="text" class="form-control" id="questiontitle" name="questionTitle" value="<%=questionTitle%>" readonly="readonly">
  		</div>
  		<div class="mb-3 mt-3">
    		<label for="goodsName" class="form-label">상품명</label>
    			<input type="text" class="form-control" id="goodsTitle" name="goodsTitle" value="<%=goodsTitle%>" readonly="readonly">
  		</div>
  		<div class="mb-3">
    		<label for="comment">문의내용</label>
				<textarea class="form-control" rows="5" id="questionContent" name="questionContent" ><%=questionContent%></textarea>
  		</div>
  		
		<div class="text-right">
  		<button type="button" class="btn btn-dark" id="button">수정</button>
  		</div>
	</form>
	</div>
	<br>
	<br>
	<script>
		
	$('#button').click(function(){
		
		//문의사항 내용이 비어있는지 확인
		if($('#questionContent').val()== ""){
			alert('문의 내용을 입력하세요.');
			return;
		}
		
		alert('문의사항 수정이 완료되었습니다');
		$('#updateQuestionForm').submit();
	});
		
	</script>
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