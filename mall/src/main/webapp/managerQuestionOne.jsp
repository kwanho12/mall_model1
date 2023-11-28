<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매니져 문의사항 관리</title>
	<meta charset="UTF-8">
  	<meta name="viewport" content="width=device-width, initial-scale=1.0">
  	<meta http-equiv="X-UA-Compatible" content="ie=edge">
  	<title>고객 목록</title>
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
  	<link rel="preconnect" href="https://fonts.gstatic.com">
  	<link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&display=swap" rel="stylesheet">
  	<link rel="stylesheet" href="css/font.css">

  	<!-- jQuery CDN-->
  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
  
   <style>
      th { background-color: black; color: white;" }
    </style>
    
</head>
<body>
<% 
	//세션 적용(로그인하지 않은 사람은 접근하지 않게 하기 위함)
	if(session.getAttribute("managerNo") == null) {
		response.sendRedirect(request.getContextPath()+"/managerLogin.jsp");
	}

	int questionNo = Integer.parseInt(request.getParameter("questionNo"));
	System.out.println(questionNo + "<--상세보기할 문의사항 번호");	//디버깅
	
	QuestionDao questionDao = new QuestionDao();
	QuestionCommentDao questionCommentDao = new QuestionCommentDao();
	ArrayList<HashMap<String,Object>> list = questionDao.selectQuestionOne(questionNo);
	ArrayList<HashMap<String,Object>> list2 = questionCommentDao.selectQuestionCommentOne(questionNo);
	
	int comment = 0;
	//답글이 존재하면 comment = 1, 존재하지 않으면 comment = 0
	comment = questionCommentDao.selectQuestionComment(questionNo);
	


%>
<!--================ Start Header Menu Area ===============-->
	<jsp:include page="/inc/managerMenu.jsp"></jsp:include>
<!--================ End Header Menu Area =================-->
<div class="container">
	<h3>문의사항 관리</h3>
	<br>
	<table class="table table-hover table-bordered">
		<colgroup>
            <col width=20%>
            <col width=80%>
 	    </colgroup>
		<tr>
			<th>게시물번호</th><td><%=list.get(0).get("questionNo") %></td>
		</tr>
		<tr>
			<th>고객ID</th><td><%=list.get(0).get("customerId") %></td>
		</tr>
		<tr>
			<th>상품</th><td><%=list.get(0).get("goodsTitle") %></td>
		</tr>
		<tr>
			<th>게시물 제목</th><td><%=list.get(0).get("questionTitle") %></td>
		</tr>
		<tr>
			<th>게시물 내용</th><td><%=list.get(0).get("questionContent") %></td>
		</tr>
		<tr>
			<th>작성일</th><td><%=list.get(0).get("createdate") %></td>
		</tr>
		<tr>
			<th>수정일</th><td><%=list.get(0).get("updatedate") %></td>
		</tr>
	</table>	
</div>
<% 
	if(comment == 1){	
%>
	
<div class="container">
	<h3>답변</h3>
	<br>
	<table class="table table-hover table-bordered">
		<colgroup>
            <col width=20%>
            <col width=80%>
 	    </colgroup>
		<tr>
			<th>담당매니져</th><td><%=list2.get(0).get("managerName") %></td>
		</tr>
		<tr>
			<th>답변내용</th><td><%=list2.get(0).get("commentContent") %></td>
		</tr>
		<tr>
			<th>답변 작성일</th><td><%=list2.get(0).get("createdate") %></td>
		</tr>
		<tr>
			<th>답변 수정일</th><td><%=list2.get(0).get("updatedate") %></td>
		</tr>
	</table>	
</div>
<%
	}
%>
<div class="container text-right">
	<a class="btn btn-dark" id="deleteQuestion">문의 사항 삭제</a>

<%
	if(comment == 0){
%>

	<a href="<%=request.getContextPath() %>/managerInsertQuestionCommentForm.jsp?questionNo=<%=list.get(0).get("questionNo") %>" class="btn btn-dark" >답글 추가</a>

<%
	}
	if(comment == 1){	
%>

	<a href="<%=request.getContextPath() %>/managerUpdateQuestionCommentForm.jsp?commentNo=<%=list2.get(0).get("commentNo")%>&&questionNo=<%=questionNo%> " class="btn btn-dark" >
		답글 수정
	</a>
	<a id="deleteQuestionComment" class="btn btn-dark">
		답글 삭제
	</a>
</div>

<%
	}
%>
	<script>
	    $(document).ready(function() {
	        // 문의사항 삭제 버튼 클릭 시
	        $("#deleteQuestion").click(function() {
	            // 삭제시 다시한번 확인
	            var result = confirm("삭제하시겠습니까?");
	            
	            // 확인이면 삭제 액션 실행
	            if (result) {
	                var deleteUrl = "<%=request.getContextPath() %>/managerDeleteQuestionAction.jsp?questionNo=<%=list.get(0).get("questionNo") %>";		               
	                window.location.href = deleteUrl;
	            }
	        });
	        
	        // 답변 삭제 버튼 클릭 시
	        $("#deleteQuestionComment").click(function() {
	            // 삭제시 다시한번 확인
	            var result = confirm("삭제하시겠습니까?");
	            
	            // 확인이면 삭제 액션 실행
	            if (result) {
	                var deleteUrl = "<%=request.getContextPath() %>/managerDeleteQuestionCommentAction.jsp?commentNo=<%=list2.get(0).get("commentNo")%>&&questionNo=<%=questionNo%>";		               
	                window.location.href = deleteUrl;
	            }
	        });
	    });
	</script>
	

</body>
</html>