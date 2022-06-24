<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, jdbc.DBConnection" %>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내정보 수정화면</title>
<link type="text/css" rel="stylesheet" href="../css/bbs.css"></link>
<style>
	#frame_0{
	margin-top:50px;
	text-align:center;
	}
    div#frame_1{
    	display:inline-block;
    	width:350px;
    }
</style>
</head>
<body>
<!-- 헤더부분 -->
	<jsp:include page="header.jsp" flush="false" />
	
<jsp:useBean id="dao" class="member.MemberDao"/>
<jsp:useBean id="dto" class="member.MemberDto"/>

<%
	String memberId = (String)session.getAttribute("id");
	dto = dao.getMemberInfo(memberId, dto);
%>
<!-- 정보수정 박스 -->
<div id="frame_0">
	<div id="frame_1">
	<h2>회원정보 수정</h2>
	<form name="updateForm" method="post" action="process_update.jsp">
	<table>
	    <tr>
	        <td>아이디</td><td><input type="text" name="memberId" value="<%=dto.getMemberId() %>"></td>
	    </tr>
	    <tr>
	        <td>비밀번호</td><td><input type="text" name="memberPw" value="<%=dto.getMemberPw() %>"></td>
	    </tr>
	    <tr>
	        <td>이름</td><td><input type="text" name="memberName" value="<%=dto.getMemberName() %>"></td>
	    </tr>
	    <tr>
	        <td>닉네임</td><td><input type="text" name="memberNick" value="<%=dto.getMemberNick() %>"></td>
	    </tr>
	    <tr>
	        <td>전화번호</td><td><input type="text" name="phoneNo" value="<%=dto.getPhoneNo() %>"></td>
	    </tr>
	</table>
	<h4><a href="main.jsp">메인화면</a>&nbsp;&nbsp;<a href="javascript:updateForm.submit()">수정하기</a></h4>
	</form>
	</div>
</div>
<!-- 밑단 부분 -->
<div style="height:550px;"></div>
<jsp:include page="footer.jsp" flush="false" />
</body>
</html>