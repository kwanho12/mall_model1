<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 공지 관리</title>
	<meta charset="UTF-8">
 	<meta name="viewport" content="width=device-width, initial-scale=1.0">
 	<meta http-equiv="X-UA-Compatible" content="ie=edge">
  	<title>관리자 공지 관리</title>
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
</head>
<body>
<% 
	//세션 적용(로그인하지 않은 사람은 접근하지 않게 하기 위함)
	if(session.getAttribute("managerNo") == null) {
		response.sendRedirect(request.getContextPath()+"/managerLogin.jsp");
	}

	//페이징을 위한 변수
	int currentPage= 1;
	if(request.getParameter("currentPage") != null){
		currentPage=Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 5;
	int beginRow=(currentPage-1)*rowPerPage;
	
	// 검색을 위한 변수
	String searchWord = "";
	String searchType = "";
	
	// 검색값으로 넘어온 문자가 있으면
	if(request.getParameter("searchType") != null){
		searchType= request.getParameter("searchType");
	}
	if(request.getParameter("searchWord") != null){
		searchWord= request.getParameter("searchWord");
	}
	// 검색값 디버깅
	System.out.println(searchType+"<--searchType");
	System.out.println(searchWord+"<--searchWord");
	
	
	NoticeDao noticeDao = new NoticeDao();
	ArrayList<HashMap<String,Object>> list = noticeDao.managerSelectNoticeList(beginRow, rowPerPage, searchType, searchWord);
	
	//페이징을 위해 마지막 페이지알아오기
	int lastPage = noticeDao.selectNoticeLastPage(rowPerPage);
	System.out.println(lastPage + "<--lastPate(notice)");
	
%>
<!--================ Start Header Menu Area ===============-->
	<jsp:include page="/inc/managerMenu.jsp"></jsp:include>
<!--================ End Header Menu Area =================-->

<!-- Start Paging, search Bar -->
<div class="filter-bar d-flex flex-wrap align-items-center">
 	<div class="sorting mr-auto">
 
 		<%
 			if(currentPage > 1) {
 		%>	
 				<a class="btn btn-light" href="<%=request.getContextPath()%>/managerNotice.jsp?currentPage=<%=currentPage-1%>">이전</a>
 		<%
 			}
 		%>
 		
 		<%
			if(currentPage < lastPage) {
		%>
				<a class="btn btn-light" href="<%=request.getContextPath()%>/managerNotice.jsp?currentPage=<%=currentPage+1%>">다음</a>
		<%		
			}
		%>

 	</div>
 
 	<form action="<%=request.getContextPath()%>/managerNotice.jsp">
		<div>
	          <div class="input-group filter-bar-search">
	            <select name=searchType id="searchType">
				 	<option value="" selected="selected">-전체보기-</option>
				 	<option value="managerName">매니져</option>		
				 	<option value="noticeTitle">제목</option>		
				 	<option value="noticeContent">내용</option>		
				</select>
	            	<input type="text" placeholder="입력" name="searchWord" class="col">	 
	            <div>
		            <button style="height:38px;"><i class="ti-search"></i></button>
		        </div>
       	  	</div>
     	</div>
	</form>
</div>
<!-- End Paging, search Bar -->

<div class="container-fluid">
	<h3>공지 관리</h3><br>
	<h4>
		<a href="<%=request.getContextPath()%>/managerInsertNoticeForm.jsp?managerNo=<%=session.getAttribute("managerNo")%>" class="btn btn-dark">
			공지추가
		</a>
	</h4>

	<table class="table table-hover table-bordered">
		<colgroup>
		        <col width=10%>
		        <col width=15%>
		        <col width=40%>
		        <col width=15%>
		        <col width=15%>
		        <col width=5%>
	     </colgroup>
		<thead class="thead-dark">
			<tr>
				<th>공지사항 번호</th>
				<th>매니져</th>
				<th>제목</th>
				<th>작성일</th>
				<th>수정일</th>
				<th>관리</th>
			</tr>
		</thead>
		<tbody>
			<%
				for(HashMap<String, Object> n : list) {
			%>
					<tr>
						<td><%=n.get("noticeNo")%></td>
						<td><%=n.get("managerName")%></td>
						<td><%=n.get("noticeTitle")%></td>
						<td><%=n.get("createdate")%></td>
						<td><%=n.get("updatedate")%></td>
						<td><a href="<%=request.getContextPath()%>/managerNoticeOne.jsp?noticeNo=<%=n.get("noticeNo")%>">관리</a></td>				
					</tr>
			<%		
				}
			%>
		</tbody>
	</table>
</div>
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