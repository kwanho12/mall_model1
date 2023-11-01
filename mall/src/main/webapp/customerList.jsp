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
</head>
<body>
<%
	
%>	
	<h1>게시판 리스트입니다.</h1>
	<table border="1">
		<thead>
			<tr>
				<th>고객번호</th>
				<th>고객ID</th>
				<th>createdate</th>
				<th>updatedate</th>
				<th>active</th>
			</tr>
		</thead>
		<tbody>
			<%
				for(HashMap<String, Object> c : list) {
			%>
					<tr>
						<td><%=c.get("customerNo")%></td>
						<td><%=c.get("customerId")%></td>
						<td><%=c.get("createdate")%></td>
						<td><%=c.get("updatedate")%></td>
						<td><%=c.get("active")%></td>
					
					</tr>
			<%		
				}
			%>
		</tbody>
	</table>
	<br>
</body>
</html>