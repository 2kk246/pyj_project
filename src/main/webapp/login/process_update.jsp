<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="jdbc.DBConnection, java.sql.*" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정 페이지</title>
</head>
<%
//스크립트릿:_jspService()메소드 내에서 실행되는 자바 소스 코드
	request.setCharacterEncoding("UTF-8");
%>

	<jsp:useBean id="dto" class="member.MemberDto"/>
	<jsp:setProperty name="dto" property="*"/>
	<jsp:useBean id="dao" class="member.MemberDao"/>

<%
	int result = dao.updateMemberInfo(dto);
	if(result==1){
		out.println("<script>alert('회원 정보가 변경되었습니다')</script>");
		out.println("<script>location.href=\"member_info.jsp\"</script>");
	}else{
		out.println("<script>alert('정보 수정이 정상적으로 이루어 지지 않았습니다.')</script>");
		out.println("<script>history.back();</script>");
	}

%>
<body>
</body>
</html>