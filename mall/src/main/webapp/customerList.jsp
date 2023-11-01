<%@page import="dao.CustomerListDao"%>
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
	<title>Insert title here</title>
	<!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
	
	<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
	
	<!--구글폰트 -->
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="css/font.css">
</head>
<body>
<%
	CustomerListDao customerDao = new CustomerListDao();
	ArrayList<HashMap<String, Object>> list = customerDao.customerList();
%>	
	
	<div class="container p-5 my-5 border">
		<h1>고객 DB</h1>
		<table class="table table-dark table-striped table-hover">
			<colgroup>
	            <col width=10%>
	            <col width=15%>
	            <col width=10%>
	            <col width=45%>
	            <col width=10%>
	            <col width=10%>
     	    </colgroup>
			<thead>
				<tr>
					<th>고객번호</th>
					<th>ID</th>
					<th>이름</th>
					<th>주소</th>
					<th>휴대폰 번호</th>
					<th>활동 상태</th>
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
						</tr>
				<%		
					}
				%>
			</tbody>
		</table>
	</div>
	
	
	<br>
</body>
</html>