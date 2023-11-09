<%@page import="dao.CustomerDao"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.Connection" %>
<%@ page import ="java.sql.DriverManager" %>
<%@ page import ="java.sql.PreparedStatement" %>
<%@ page import ="java.sql.ResultSet" %>
<%@ page import ="java.util.ArrayList" %>


<!DOCTYPE html>
<html>
<head>
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
	
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 6;
	
	String searchField = request.getParameter("searchField");
	String searchText = request.getParameter("searchText");
	
	CustomerDao customerDao = new CustomerDao();
	int totalRow = customerDao.customerSearchListPaging(searchField, searchText);
	int lastPage = totalRow / rowPerPage;
	if(totalRow % rowPerPage != 0) {
		lastPage = lastPage + 1;
	}
	int beginRow = (currentPage-1)*rowPerPage;
	
	ArrayList<HashMap<String, Object>> list = customerDao.searchCustomerList(searchField, searchText, beginRow, rowPerPage);
	
	if(request.getParameter("searchField").equals("select")) { // 검색창에서 세부사항을 선택을 하지 않고 검색할 때
		response.sendRedirect(request.getContextPath()+"/customerList.jsp");
	}
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
          				<a class="btn btn-light" href="<%=request.getContextPath()%>/customerSearchList.jsp?currentPage=<%=currentPage-1%>&searchField=<%=searchField%>&searchText=<%=searchText%>">이전</a>
          		<%
          			}
          		%>
          		
          		<%
					if(currentPage < lastPage) {
				%>
						<a class="btn btn-light" href="<%=request.getContextPath()%>/customerSearchList.jsp?currentPage=<%=currentPage+1%>&searchField=<%=searchField%>&searchText=<%=searchText%>">다음</a>
				<%		
					}
				%>

          	</div>
      
            <form action="<%=request.getContextPath()%>/customerSearchList.jsp">
      			<div>
	              <div class="input-group filter-bar-search">
	              
	              	<table>
	              		<tr>
	              			<td>
	              				<select name="searchField">
									<option value="select">선택</option>
									<option value="id">ID</option>
									<option value="name">이름</option>
									<option value="address">주소</option>
									<option value="phone">휴대폰 번호</option>
									<option value="active">활동 상태</option>
								</select>
	              			</td>
	              			<td>
	              				<input type="text" placeholder="입력" name="searchText" class="col">	 
	              			</td>
	              			<td>
	              				<div >
			                  		<button style="height:38px;"><i class="ti-search"></i></button>
			              		</div>
	              			</td>
	              		</tr>
	              	</table>
	              		
              	  </div>
            	</div>
      		</form>
      		
      		</div>
          <!-- End Paging, search Bar -->
	
	<div class="container-fluid">
		<h3>고객 관리</h3>
		<table class="table table-hover table-bordered">
			<colgroup>
	            <col width=8%>
	            <col width=10%>
	            <col width=9%>
	            <col width=31%>
	            <col width=10%>
	            <col width=8%>
	            <col width=10%>
	            <col width=10%>
	            <col width=4%>
     	    </colgroup>
			<thead class="thead-dark">
				<tr>
					<th>고객번호</th>
					<th>ID</th>
					<th>이름</th>
					<th>주소</th>
					<th>휴대폰 번호</th>
					<th>활동 상태</th>
					<th>createdate</th>
					<th>updatedate</th>
					<th>삭제</th>
				</tr>
			</thead>
			<tbody>
				<%
					for(HashMap<String, Object> c : list) {
				%>
						<tr>
							<td><%=c.get("customerNo")%></td>
							<td><%=c.get("customerId")%></td>
							<td><%=c.get("customerName")%></td>
							<td><%=c.get("address")%></td>
							<td><%=c.get("customerPhone")%></td>
							<td><%=c.get("active")%></td>
							<td><%=c.get("createdate")%></td>
							<td><%=c.get("updatedate")%></td>
							<td><a href="<%=request.getContextPath()%>/deleteCustomerAction.jsp?customerNo=<%=c.get("customerNo")%>">삭제</a></td>				
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