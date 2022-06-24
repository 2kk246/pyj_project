<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그아웃 페이지</title>
</head>
<body>

<%
	String id = (String)session.getAttribute("id");
	if(id != null){
		session.invalidate();
	}
	response.sendRedirect("main.jsp");
%>


</body>
</html>