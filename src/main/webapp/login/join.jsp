<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html> <!-- HTML5 적용 표시 -->
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입</title>
<link type="text/css" rel="stylesheet" href="../css/bbs.css"></link>
<style>
	span{
	display:block;
	text-align:left;
	color:red;
	font-size:10px;
	}
    #frame_0{
	margin-top:50px;
	text-align:center;
	}
    div#frame_1{
    	display:inline-block;
    	width:300px;
    }
    div.join_field{
        margin:10px;
        padding:5px;
    }
    
    input.join-input{
        height: 30px;
        width: 200px;
    }
    
    input.join-button-submit{
        margin: 10px 15px 10px 25px; /*순서: (시계방향으로) 위쪽, 오른쪽, 아랫쪽, 왼쪽*/
    }
    
    div.join-header{
        margin: 10px;
        padding-left: 20px;
    }
    .y-btn{
    	padding:4px 20px;
    }
</style>
<script src="<%= request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>

<script>
//빈칸 확인
	$(function(){
		$(document).on("blur","input",function(){
			var content = $(this).val();
			//내용이 비어있고 span이 없는 경우
			if(content=="" && !$(this).next().is("span")){
				$(this).after("<span>*필수 정보입니다</span>");
			//내용이 있고 span이 있는 경우
			}else if(content!="" && $(this).next().is("span")){
				$(this).next("span").remove();
				
			}
		});
//비밀번호 확인 부분
		$(document).on("blur","input[name=memberPw2]",function(){
			var content = $(this).val();
			var pw1 = $("input[name=memberPw1]").val();
			var pw2 = $("input[name=memberPw2]").val();
			//비번이 일치하지 않고 span이 있는경우
			if(pw1 != pw2){
				console.log(1);
				$(this).next("span").remove();
				$(this).after("<span>*비밀번호가 일치하지 않습니다</span>");
			}
		});
	})
//아이디 중복 체크
	function fn_dbCheckId(){
		var joinForm = document.joinForm;
		var id = joinForm.memberId.value;
		if(id.length==0 || id==""){
			alert('아이디를 입력해주세요');
			joinForm.memberId.focus();
		}else{
			window.open("checkId.jsp?memberId="+id,"","width=500, height=300");
		}
	}
</script>
</head>

<body>
<!-- 헤더부분 -->
<jsp:include page="header.jsp" flush="false" />

<div id="frame_0">
<div id="frame_1">

	<h2>회원가입</h2>

    <form action="process_join.jsp" method="post" name="joinForm">

	<div class="join_field">
          <input type="email" class="join-input" name="memberId"
                 id="join-email-input" value="" maxlength="80" placeholder="아이디(이메일)" />
                 
          <button type="button" onclick="fn_dbCheckId()" name="dbCheckId">중복 확인</button>
          <!-- 아이디 중복 체크 여부 -->
          <input type="hidden" name="idDuplication" value="idUncheck"/>
	</div>
	     
	<div class="join_field">
          <input type="password" class="join-input" name="memberPw1"
                 id="join-password-input" value="" maxlength="20" placeholder="비밀번호">             
	</div>
	 
	<div class="join_field">
           <input type="password" class="join-input" name="memberPw2"
                  id="verify-join-password-input" value="" maxlength="20" placeholder="비밀번호 확인">
	</div>
	
	<div class="join_field">
           <input type="Name" class="join-input" name="memberName"
                  id="join-name-input" maxlength="40" value="" placeholder="이름">
	</div>
	<div class="join_field">
           <input type="Nick" class="join-input" name="memberNick"
                  id="join-name-input" maxlength="40" value="" placeholder="닉네임">
	</div>
	<div class="join_field">
           <input type="tel" class="join-input" name="phoneNo"
                id="join-phone-input" value="" autocomplete="off" placeholder="휴대폰 번호">
	</div>

	<div class="join_field">  
	   
           <input class="y-btn" type="submit" class="join-button-submit" value="가입하기">
           <input class="y-btn" type="reset" class="join-button-reset" value="취소하기">
        
	</div>
	
    </form> 
</div>
</div>
<!-- 밑단 부분 -->
<div style="height:550px;"></div>
<jsp:include page="footer.jsp" flush="false" />
</body>
</html>        