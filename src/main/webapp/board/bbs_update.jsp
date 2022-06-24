<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글수정</title>
<jsp:useBean id = "dao"  class="board.BoardDao"/>
<jsp:useBean id = "dto"  class="board.BoardDto"/>
<% 
	String board = (String)session.getAttribute("board");
	String bgcolor="";
	if(board=="전체"){
		bgcolor = "#94c4f6";
	}else if(board=="힐링"){
		bgcolor = "#DBEE81";
	}else if(board=="공포"){
		bgcolor = "#AA8BDE";
	}else if(board=="협동"){
		bgcolor = "#DE8B96";
	}else{
		bgcolor = "94c4f6"; 
	}
%>
<link type="text/css" rel="stylesheet" href="../css/bbs.css"></link>
<style>
	#frame_0{
		margin-top:50px;
		text-align:center;
	}
	#frame_1{
		display:inline-block;
		width:700px;
	}
	table {
	    margin-left:auto; 
	    margin-right:auto;
	}
	table, td, th {
	    border-collapse : collapse;
	}
	td{
		border-radius: 7px;
		border-style: hidden;
	}
	textarea:focus {
    	border:1px solid #000000;
    	box-shadow: 0px 5px 20px var(--light-gray);
    	outline-color: <%=bgcolor%>;
	}
	.inputSubject:focus {
		border:1px solid #000000;
    	box-shadow: 0px 5px 20px var(--light-gray);
    	outline-color: <%=bgcolor%>;
	}
</style>
</head>
<body>
<!-- 헤더부분 -->
<jsp:include page="../login/header.jsp" flush="false" />

<%
	String pageNum = request.getParameter("pageNum");	
	String bbsNum = request.getParameter("bbsNum");
   	dto = dao.getArticle(Integer.parseInt(bbsNum));
%>
<p class="nameOfBoard">글수정</p>
<div id="frame_0">
<div id="frame_1">
	
	<form id="uploadForm" method="post" action="bbs_updatePro.jsp">
		<input type="hidden" name="bbsNum" value="<%=bbsNum %>"/>
		<input type="hidden" name="pageNum" value="<%=pageNum %>"/>
	
		<table style="width:480px">
			<tr>
				<td bgcolor=<%=bgcolor%>>제목</td>
			</tr>
			<tr>
				<td><input class="inputSubject" type="text" name="bbsSubject" size="79" style="padding:5px;" value="<%=dto.getBbsSubject() %>"/></td>
			</tr>
			<tr>
				<td bgcolor=<%=bgcolor%>>내용</td> 
			</tr>
			<tr>
				<td><textarea name="bbsContent" cols="125" rows="30" wrap="hard" style="resize: none;"><%=dto.getModifiedContent() %></textarea></td>
			</tr>
			<tr>
				<td colspan="2">
					<input class="inputButton" type="submit" value="수정하기"/> &nbsp; | &nbsp;
					<input class="inputButton" type="button" value="글삭제" onclick="window.location='bbs_delete.jsp?bbsNum=<%=bbsNum %>' "/>
				</td>
			</tr>
		</table>
	</form>
</div>
</div>
<!-- 밑단 부분 -->
<div style="height:550px;"></div>
<jsp:include page="../login/footer.jsp" flush="false" />
</body>
</html>