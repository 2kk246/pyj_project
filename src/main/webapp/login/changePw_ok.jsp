<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경 화면</title>

<link type="text/css" rel="stylesheet" href="../css/bbs.css"></link>

<style>
	#frame_0{
	margin-top:50px;
	text-align:center;
	}
    div#frame_1{
    	display:inline-block;
    	width:400px;
    }
</style>

</head>
<body>
	<!-- 헤더부분 -->
	<jsp:include page="header.jsp" flush="false" />
	
	<!-- 비밀번호 변경 -->
	<div id="frame_0">
		<div id="frame_1">
		<h2>비밀번호가 변경되었습니다</h2>
		<a href="login.jsp">로그인 하러 가기</a>
		</div>
	</div>
<!-- 밑단 부분 -->
<div style="height:550px;"></div>
<jsp:include page="footer.jsp" flush="false" />
</body>
</html>