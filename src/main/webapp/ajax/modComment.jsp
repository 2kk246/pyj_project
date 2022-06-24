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
		
		//request.getParameter은 오직 String형만 반환하기 떄문에 int형으로 바꿔주는 작업이 필요하다
		int bbsCNum = Integer.parseInt(request.getParameter("bbsCNum"));
		String bbsCContent = request.getParameter("bbsCContent");
		String sql = "update bbsComment set bbsCContent=? where bbsCNum =?";
		psmt = conn.prepareStatement(sql);
		psmt.setString(1, bbsCContent);
		psmt.setInt(2, bbsCNum);
		
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