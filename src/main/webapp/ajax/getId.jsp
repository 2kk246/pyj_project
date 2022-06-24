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
		
		//세션에서 아이디를 가져오고 blur에서 비밀번호를 가져오기
		String id = (String)session.getAttribute("id");
		String pw = request.getParameter("inputpw");
		//member_tb테이블에 있는 모든 데이터를 가져오기 위한 sql문
		//있으면 count는 1 없으면 0
		String sql = "select memberPw from memberTb where memberId=?";
		psmt = conn.prepareStatement(sql);
		psmt.setString(1, id);
		rs = psmt.executeQuery();
		
		while(rs.next()){
			if(pw.equals(rs.getString("memberPw"))){
				result=1;
			}
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