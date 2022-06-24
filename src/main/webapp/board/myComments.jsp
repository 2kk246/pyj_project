<%@ page language="java" contentType="text/html; charset=UTF-8"
	    pageEncoding="UTF-8"%>
<%@ page import ="java.util.List,board.*,java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>나의 댓글</title>
<link type="text/css" rel="stylesheet" href="../css/bbs.css"></link>
</head>

<body>
<jsp:useBean id="dao" class="board.BoardDao" />
<%
	request.setCharacterEncoding("utf-8");
	String nick = (String)session.getAttribute("nick");	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
    
    String pageNum = request.getParameter("pageNum");
    if (pageNum == null) {
        pageNum = "1";
    }
    
    int listSize = 10;//화면에 표시할 게시글 숫자
    int totalNum = dao.countMyComments(nick);//DB에 저장된 총 게시글 숫자
    
    int currPageNum = Integer.parseInt(pageNum);//현재 페이지의 네비게이션 번호
	int startRow = (currPageNum - 1) * listSize + 1;//게시글 출력시 시작번호
    int endRow = currPageNum * listSize;//게시글 출력시 끝번호
    int number = 0;//화면에 표시할 글번호
    
    List<CommentDto> commentList = null;
    
    if (totalNum > 0) {
        commentList = dao.getMyComments(startRow, listSize * currPageNum, nick);
    }
    
    number = totalNum - (currPageNum - 1) * listSize;
%>

<!-- 헤더 부분 -->
<jsp:include page="../login/header.jsp" flush="false" />
<h2>내가 쓴 댓글 수 : <%=totalNum %>개</h2>

<!-- 게시글 부분 -->
<div id="frame_1">
<div id="table">


<%

if(commentList == null){
%>
<%
}else{%>
<table style="width:100%">

	<tr bgcolor="#77acf1">
		<th>번호</th>
		<th>글제목</th>		
		<th>댓글내용</th>
		<th>작성자</th>
		<th>작성일</th>
	</tr>

<%
	
	for(CommentDto Cdto : commentList){
	   String CregDate = sdf.format(Cdto.getCregDate());
	   String bbsSubject = dao.getFromComment(Cdto.getBbsNum());
%>
    <tr>
    	<td width="5%"><%=number-- %></td>
    	<td><%=bbsSubject %></td>
    	<td width="40%"><a href="bbs_content.jsp?bbsNum=<%=Cdto.getBbsNum() %>&pageNum=<%=pageNum %>"><%=Cdto.getBbsCContent() %></a></td>
    	<td><%=Cdto.getBbsCWriter() %></td>
    	<td><%=CregDate %></td>
    </tr>
<%
	}//for문의 닫힘 괄호
%>
</table>
</div>

<br/>
<%
	int navSize = 5;//화면에 표시할 페이지 네비게이션 숫자
	int startNum = (currPageNum/navSize)*navSize + 1;//페이지 네비이션 시작 번호
	int endNum = 5;//페이지 네비게이션 끝 번호
	int totalNavNum = ((totalNum % listSize) == 0)? (totalNum/listSize):(totalNum/listSize)+1;//총 네비게이션 번호
	
    if(totalNavNum < 6){//총 네비게이션 번호가 5이하인 경우
        for (int i = startNum; i <= totalNavNum; i++){
%>
        <a href="myComments.jsp?pageNum=<%=i%>"> [<%=i%>] </a>&nbsp;
<%
        }
    }else{//총 네비게이션 번호가 6 이상인 경우

    	if((startNum + navSize) <= totalNavNum){//네비게이션 시작번호와 네비게이션 표시 개수를 더한 값이 네비게이션 총 개수보다 작거나 같은 경우 
    		endNum = startNum + navSize-1;
    	}else{ endNum = totalNavNum; }	
    	
        if(startNum > navSize){
%>
        	<a href="myComments.jsp?pageNum=<%=(startNum-navSize)%>"> &lt;이전&nbsp;</a> 
<%   
        }
        
		for (int i = startNum; i <= endNum; i++){
%>        
           <a href="myComments.jsp?pageNum=<%= i %>"> [<%= i %>] </a>&nbsp;
<%
        }
        
        if(endNum < totalNavNum){
%>
            <a href="myComments.jsp?pageNum=<%= (endNum+1) %>"> 다음&gt; </a>
<% 
         }
    }
}//else문의 닫힘 괄호
%>
</div>
<!-- 밑단 부분 -->
<div style="height:550px;"></div>
<jsp:include page="../login/footer.jsp" flush="false" />
</body>
</html>