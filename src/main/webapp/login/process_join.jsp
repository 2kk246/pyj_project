<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="jdbc.DBConnection, java.sql.*" %>    
<!DOCTYPE html>
<html><head><meta charset="UTF-8"><title>회원가입 처리 페이지</title></head>
<body>
<%
//스크립트릿:_jspService()메소드 내에서 실행되는 자바 소스 코드
	request.setCharacterEncoding("UTF-8");

%>
	<jsp:useBean id="dto" class="member.MemberDto"/>
	<jsp:setProperty name="dto" property="*"/>
	<jsp:useBean id="dao" class="member.MemberDao"/>

<%
	String memberPw1 = request.getParameter("memberPw1");
	String memberPw2 = request.getParameter("memberPw2");
	
	//비밀번호 일치 여부 확인
	if(memberPw1.equals(memberPw2)){
		dto.setMemberPw(memberPw1);
		int result = dao.joinMember(dto);
		if(result == 1){
			out.println("<script>alert('정상적으로 회원가입이 되었습니다');");
			out.println("location.href='login.jsp';</script>");
		}else{
	    	out.println("<script>alert('회원정보 입력 실패')</script>");
	    	out.println("<script> history.back(); </script>");
	    }
	}else{
		out.println("<script>alert('비밀번호가 일치하지 않습니다')</script>");
    	out.println("<script> history.back(); </script>");
	}
	
%>

</body>
</html>