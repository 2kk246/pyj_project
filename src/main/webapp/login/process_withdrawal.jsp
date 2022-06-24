<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
<jsp:useBean id="dao" class="member.MemberDao"/>
<jsp:useBean id="dto" class="member.MemberDto"/>

<% //회원 탈퇴
	String id = (String)session.getAttribute("id");
	int result = dao.withdrawalMember(id);
	if(result==1){
		session.invalidate();
		out.print("<script>alert('정상적으로 회원탈퇴가 완료되었습니다')</script>");
		out.print("<script>location.href='main.jsp'</script>");
	}else{
		out.print("<script>alert('회원탈퇴에 오류가 발생했습니다')</script>");
		out.print("<script>history.back()</script>");
	}
	
%>

</body>
</html>