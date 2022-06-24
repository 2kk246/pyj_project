<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글삭제 처리</title>
</head>
<body>

<jsp:useBean id="dao" class="board.BoardDao"/>
<jsp:useBean id="Cdao" class="board.CommentDao"/>
<jsp:useBean id="Fdao" class="board.FileDao"/>

<%
	request.setCharacterEncoding("UTF-8");
	String board = (String)session.getAttribute("board");
	String bbsNum = request.getParameter("bbsNum"); 
	System.out.println(board);
	try{
		if(board=="한글패치"){
			System.out.println(1);
			Fdao.deleteAll(Integer.parseInt(bbsNum)); //게시글과 관련된 첨부파일을 삭제
			Cdao.deleteAll(Integer.parseInt(bbsNum)); //게시글과 관련된 댓글들 삭제
			dao.delete(Integer.parseInt(bbsNum)); //게시글 삭제
		}else{
			System.out.println(2);
			Cdao.deleteAll(Integer.parseInt(bbsNum)); //게시글과 관련된 댓글들 삭제
			dao.delete(Integer.parseInt(bbsNum)); //게시글 삭제
		}
		
		
   	}catch(Exception e){e.printStackTrace();}
   
	out.println("<script>alert('글이 삭제되었습니다');</script>");
	out.print("<script>history.go(-3)</script>");//총 게시글 수는 변경 못함

%>

</body>
</html>