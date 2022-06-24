<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,org.json.simple.*" %>
<%@ page import="board.CommentDto" %>
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
		
		//세션에서 아이디와 bbsNum(게시글 넘버) 가져오고 input에서 댓글내용을 가져오기
		String nick = (String)session.getAttribute("nick");
		int bbsNum = (Integer)session.getAttribute("bbsNum");
		String comment = request.getParameter("commentInput");
		
		String sql = "insert into bbsComment"
				+ "(bbsCNum, bbsCContent, bbsCWriter, bbsNum) "
				+ "values(bbsCSeq.nextval,?,?,?)";
		psmt = conn.prepareStatement(sql);
		
		psmt.setString(1, comment);
		psmt.setString(2, nick);
		psmt.setInt(3, bbsNum);
		
		psmt.executeUpdate();
		
		PreparedStatement psmt2 = null;
		ResultSet rs2 = null;
		
		psmt2 = conn.prepareStatement("SELECT * FROM BBSCOMMENT WHERE BBSCNUM=(SELECT MAX(bbsCNum) FROM BBSCOMMENT)");
		rs2 = psmt2.executeQuery();
		
		while(rs2.next()){
			CommentDto Cdto = new CommentDto();
			Cdto.setBbsCNum(rs2.getInt("bbsCNum"));
			Cdto.setBbsCContent(rs2.getString("bbsCContent"));
			Cdto.setCregDate(rs2.getDate("Cregdate"));
			Cdto.setBbsNum(rs2.getInt("bbsNum"));
			Cdto.setBbsCWriter(rs2.getString("bbsCWriter"));
		}
		result=1;
		psmt2.close();rs2.close();
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(conn != null) conn.close();
		if(psmt != null) psmt.close();
		if(rs != null) rs.close();
	}
%>
<%=result%>