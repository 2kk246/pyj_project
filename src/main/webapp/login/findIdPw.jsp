<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디/비밀번호 찾기 페이지</title>
<link type="text/css" rel="stylesheet" href="../css/bbs.css"></link>
<script src="<%= request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
<script>
	function searchId(){		
		$.ajax({
			type: "post",
			url: "<%= request.getContextPath()%>/ajax/searchId.jsp",
			data: $("#frmId").serialize(), //memberName=??&phoneNo=??
			success:function(data){
				$("#answer1").text(data);
			}
		});
	}
	function searchPw(){
		$.ajax({
			type: "post",
			url: "<%= request.getContextPath()%>/ajax/test.jsp",
			data: $("#frmPw").serialize(),
			success:function(data){
				//data:1 전송성공
				var dataJson = JSON.parse(data.trim());
				console.log(dataJson[0].result);
				if(dataJson[0].result==1){
					$("#answer2").text("데이터 전송 성공");
					var html = "";
					html += "<br>메일으로 보내진 코드 5자리를 입력해 주세요<br>"
							+"<input type='text' id='checkPw'></input><input type='button' onclick='changePw()' value='확인'>"
							+"<input type='hidden' id='hdcode' value='"+dataJson[0].code+"'></input>"; //input에 숨겨진 코드
					$("#answer2").after(html);
				}else{
					$("#answer2").text("데이터 전송 실패");
				}
			}
		});
	}
	function changePw(){
		if($("#checkPw").val() == $("#hdcode").val()){ //코드를 알맞게 입력한경우
			window.location.href = "changePw.jsp";
		}else{ //코드를 잘못 입력한 경우
			$("#answer2").text("잘못된 코드입니다");
		}
	}
</script>
</head>
<body>
	<!-- 헤더부분 -->
	<jsp:include page="header.jsp" flush="false" />
	
	<!-- 아이디 찾기 -->
	<form id="frmId">
		<fieldset>
			<legend>아이디 찾기</legend>
			이름 : <br>
			<input type="text" name="memberName"/><br>
			전화번호 : <br>
			<input type="text" name="phoneNo"/><br>
			<button type="button" onclick="searchId()">찾기</button><br>
			<span id="answer1"></span>
		</fieldset>
	</form>
	
	<br>
	
	<!-- 비밀번호 찾기 -->
	<form id="frmPw">
		<fieldset>
		<legend>비밀번호 찾기</legend>
		아이디 : <br>
		<input type="text" name="memberId"/><br>
		<button type="button" onclick="searchPw()">찾기</button>
		<span id="answer2"></span>
		</fieldset>
	</form>
	
<!-- 밑단 부분 -->
<div style="height:550px;"></div>
<jsp:include page="footer.jsp" flush="false" />
</body>
</html>