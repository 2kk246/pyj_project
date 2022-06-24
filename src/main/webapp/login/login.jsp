<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
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
    div.login_field{
        margin:15px;
        padding:5px;
    }
    
    input.login-input{
        height: 40px;
        width: 200px;
    }
    
    input.login-button-submit{
    	height: 30px;
    	width: 200px;
    	margin-bottom:10px;
    }
   	div.other{
    	margin-top:10px;
    	height: 30px;
    	width: 200px;
    	text-align:center;
    }
    a.other-button{
    	padding:10px;
    	background-color:#94c4f6;
    }
</style>

</head>
<body>
	<!-- 헤더부분 -->
	<jsp:include page="header.jsp" flush="false" />
	
	<!-- 로그인박스 -->
	<div id="frame_0">
		<div id="frame_1">
		<h2>로그인</h2>
			<form name="loginForm" method="post" action="process_login.jsp">
				<div class="login_field"><input type="text" class="login-input" name="memberId" placeholder="아이디(이메일)" maxlength="20" required></div>
				<div class="login_field"><input type="password" class="login-input" name="memberPw" placeholder="비밀번호" required></div>
				<div class="login_field">
					<input class="w-btn w-btn-blue" type="submit" class="login-button-submit" value="로그인">
				</div>
				
				<button type="button" onclick="document.location.href='join.jsp'">회원가입</button>
				<button type="button" onclick="document.location.href='findIdPw.jsp'">아이디/비밀번호 찾기</button>
			</form>
		</div>
	</div>
<!-- 밑단 부분 -->
<div style="height:550px;"></div>
<jsp:include page="footer.jsp" flush="false" />
</body>
</html>