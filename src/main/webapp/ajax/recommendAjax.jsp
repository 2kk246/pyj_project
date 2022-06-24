<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,org.json.simple.*" %>
<%//추천수 증가 AJAX
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
		
		//data에서 bbsNum 가져오기
		String bbsNum = request.getParameter("bbsNum");
		String sql = "update bbsTb set recommend=(recommend+1) where bbsNum =?";
		psmt = conn.prepareStatement(sql);
		psmt.setString(1, bbsNum);
		psmt.executeUpdate();
		
		result=1;
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(conn != null) conn.close();
		if(psmt != null) psmt.close();
		if(rs != null) rs.close();
	}
%>
<%=result%>