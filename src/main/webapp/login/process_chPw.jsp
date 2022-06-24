<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,org.json.simple.*" %>
<%
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String user = "system";
	String password = "1234";
	
	int result=0;
	try{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(url, user, password);
		
		//findIdPw의 searchPw()메소드에서 가져온 값
		String memberPw = request.getParameter("memberPw");
		String sessionId = (String)session.getAttribute("sessionId");
		//member_tb테이블에 있는 memberId를 가져오기 위한 sql문
		String sql = "update memberTb set memberPw=? where memberId=?";
		psmt = conn.prepareStatement(sql);
		psmt.setString(1, memberPw);
		psmt.setString(2, sessionId);
		psmt.executeUpdate();
		
		result=1;
		if(result ==1){
			out.print("<script>window.location.href='changePw_ok.jsp'</script>");
		}else{
			out.print("<script>history.back()</script>");
		}
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(conn != null) conn.close();
		if(psmt != null) psmt.close();
		if(rs != null) rs.close();
	}
%>

<%=result%>