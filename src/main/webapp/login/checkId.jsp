<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ID 중복 확인</title>
<script type="text/javascript">
	function sendCheckValue(){
		
		var openJoinfrm = opener.document.joinForm;
		console.log(openJoinfrm);
		if(document.checkIdForm.chResult.value=="N"){
			alert("다른 아이디를 입력해주세요");
			openJoinfrm.memberId.value="";
			openJoinfrm.memberId.focus();
			window.close();
		}else{
			//중복 체크 결과인 idCheck 값을 전달
			openJoinfrm.idDuplication.value="idCheck";
			openJoinfrm.dbCheckId.disabled=true;
			openJoinfrm.dbCheckId.style.cursor="default";
			window.close();
		}
	}
</script>
</head>
<body>
	<b><font size="4" color="gray">ID 중복 확인</font></b><br>
	<jsp:useBean id="dto" class="member.MemberDto"/>
	<jsp:setProperty name="dto" property="*"/>
	<jsp:useBean id="dao" class="member.MemberDao"/>
	
	<form name="checkIdForm">
	<input type="text" name="id" value="${memberId}" id="memberId" disabled>
	<%
		String id = request.getParameter("memberId");
		int result = dao.idCheck(id);
		
		session.setAttribute("result", result);
		
	%>
	<c:if test="${result eq 0}">
		<p style='color:red'>이미 사용중인 아이디입니다<p>
		<input type='hidden' name='chResult' value='N'/>
	</c:if>
	<c:if test="${result ne 0}">
		<p style='color:red'>사용가능한 아이디입니다<p>
		<input type='hidden' name='chResult' value='Y'/>
	</c:if>
	
	<input type="button" onclick="window.close()" value="취소"/><br>
	<input type="button" onclick="sendCheckValue()" value="사용하기"/>
	
	</form>
<!-- 밑단 부분 -->
<div style="height:550px;"></div>
<jsp:include page="footer.jsp" flush="false" />
</html>