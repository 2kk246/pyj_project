<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글수정 처리</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	String pageNum = request.getParameter("pageNum");
	String bbsNum = request.getParameter("bbsNum");
	System.out.println(pageNum);
	System.out.println(bbsNum);
%>

<jsp:useBean id="dto" class="board.BoardDto"/>
<jsp:setProperty name="dto" property="*"/>
<jsp:useBean id="dao" class="board.BoardDao"/>

<% 
	String id = (String)session.getAttribute("nick");
   	try{
		dao.update(dto,id);
  	}catch(Exception e){e.printStackTrace();}
    
	String url ="bbs_content.jsp?bbsNum="+bbsNum+"&pageNum="+pageNum;
	pageContext.forward(url);
%>

</body>
</html>