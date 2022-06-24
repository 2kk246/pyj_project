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
    	width:300px;
    }
    div.password_field{
        margin:15px;
        padding:5px;
    }
    
    input.password-input{
        height: 40px;
        width: 200px;
    }
    input.password-change-submit{
    	height: 30px;
    	width: 200px;
    	margin-bottom:10px;
    }
</style>

</head>
<body>
	<!-- 헤더부분 -->
	<jsp:include page="header.jsp" flush="false" />
	
	<!-- 비밀번호 변경 -->
	<div id="frame_0">
		<div id="frame_1">
		<h2>비밀번호 변경</h2>
			<form name="PwForm" method="post" action="process_chPw.jsp">
				<div class="password_field">
					<input type="password" class="password-input" name="memberPw" placeholder="새 비밀번호" required>
					<%  
						String sessionId = (String)session.getAttribute("sessionId");
					%>
					<input type="hidden" name="memberId" value="<%=sessionId%>">
				</div>
				<div class="password_field">
					<input type="submit" class="password-change-submit" value="변경 완료">
				</div>
			</form>
		</div>
	</div>
	
<!-- 밑단 부분 -->
<div style="height:550px;"></div>
<jsp:include page="footer.jsp" flush="false" />
</body>
</html>