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
	
	String result="";
	try{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(url, user, password);
		
		//findIdPw의 searchPw()메소드에서 가져온 값
		String memberId = request.getParameter("memberId");		
		//member_tb테이블에 있는 memberId를 가져오기 위한 sql문
		String sql = "select memberPw from memberTb where memberId=?";
		psmt = conn.prepareStatement(sql);
		psmt.setString(1, memberId);
		rs = psmt.executeQuery();
		
		if(rs.next()){
			result=rs.getString("memberPw"); //찾은 비밀번호를 result에 저장
		}else{
			result="회원정보가 없습니다";
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