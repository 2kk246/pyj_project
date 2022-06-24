<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, jdbc.DBConnection" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 보기</title>
<jsp:useBean id="dao" class="member.MemberDao"/>
<jsp:useBean id="dto" class="member.MemberDto"/>

<link type="text/css" rel="stylesheet" href="../css/bbs.css"></link>
<style>
	#frame_0{
		margin-top:50px;
		text-align:center;
	}
	#frame_1{
		display:inline-block;
		width:500px;
	}
    table, td{
        margin:auto;
        width: 400px;
        border-bottom: 1px solid gray;
        border-collapse:collapse;
        text-align: center;
    }
    
    h2, h4{ text-align: center;}
    a { text-decoration: none;}
</style>
<%
	request.setCharacterEncoding("utf-8");
	String memberId = (String)session.getAttribute("id");
	dto=dao.getMemberInfo(memberId, dto);
%>
<script src="<%= request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
<script>
	$(function(){
		$(document).one("click", "#checkPW", function() {
			//1. div-password 붙여서 값 가져오기
			$(this).append("<div>비밀번호를 입력하세요 : <input type='password' id='inputpw' name='inputpw'></input></div><div id='alert'></div>");
		});
		$(document).on("blur","#inputpw",function(){
			//2. dao의 메소드를 이용해 비밀번호와 맞는 값인지 확인
			$.ajax({
				type:"get",
				url:"<%= request.getContextPath()%>/ajax/getId.jsp",
				data: $(this).serialize(),
				success:function(data){
					//3. 맞으면 href="update_member.jsp"로 넘겨주고 아니면 틀렸다고 하기
					if(data==1){
						window.location.href = "update_member.jsp";
					}else{
						$("#alert").html("<div style='color:red'>비밀번호가 틀립니다</div>");
						
					}
				}
			});			
		});
	});
</script>



</head>
<body>
<!-- 헤더부분 -->
<jsp:include page="header.jsp" flush="false" />
<h2>회원정보</h2>
<div id="frame_0">
<div id="frame_1">
	<table>
    <tr>
        <td>아이디</td><td>${dto.getMemberId()}</td>
    </tr>
    <tr>
        <td>이름</td><td>${dto.getMemberName()}</td>
    </tr>
    <tr>
        <td>닉네임</td><td>${dto.getMemberNick()}</td>
    </tr>
    <tr>
        <td>전화번호</td><td>${dto.getPhoneNo()}</td>
    </tr>
	</table>
</div>
</div>
<h4>
<a href="#" id="checkPW" class="y-btn">회원 정보 수정</a>
<a href="process_withdrawal.jsp" class="y-btn">회원 탈퇴</a>
</h4>
<h5>
<a href="../board/myArticles.jsp" class="w-btn w-btn-blue">내가 쓴 게시글 보기</a>
<a href="../board/myComments.jsp" class="w-btn w-btn-blue">내가 쓴 댓글 보기</a>
</h5>

<!-- 밑단 부분 -->
<div style="height:550px;"></div>
<jsp:include page="footer.jsp" flush="false" />
</body>
</html>