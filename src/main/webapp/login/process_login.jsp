<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "jdbc.DBConnection, java.sql.*" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 처리 페이지</title>
</head>
<body>

<jsp:useBean id="dao" class="member.MemberDao"/>
<jsp:useBean id="dto" class="member.MemberDto"/>
<%
//아이디와 비밀번호 가져오기
	request.setCharacterEncoding("utf-8");
	String memberId = request.getParameter("memberId"); //input의 name에서 받아들인거
	String memberPw = request.getParameter("memberPw");
	
	int result = dao.login(memberId, memberPw);
	 if(result != 0){//회원인 경우
		//회원정보를 유지하기 위해 session객체 이용
		session.setAttribute("id", memberId);
	
		//닉네임도 세션에 저장해둠
		dto=dao.getMemberInfo(memberId, dto);
		session.setAttribute("nick", dto.getMemberNick());
		
		//main.jsp페이지로 이동
		out.print("<script>location.href='main.jsp';</script>");
		} else {
	out.print("<script>alert('아이디나 비밀번호가 일치하지 않습니다.')</script>");
	//다시 로그인페이지로 보내줌 & 새로운 요청
	out.print("<script>location.href = 'login.jsp'</script>");

	/*다시 로그인페이지로 보내줌
	out.println("<script> history.back(); </script>");
	*/
	/*다시 로그인페이지로 보내줌 하지만 새로운 요청이 될 수 있도록 response.sendredirect(주소)
	response.sendRedirect("login.jsp"); //아이디 비밀번호가 지워진다
	*/
		}
%>


</body>
</html>