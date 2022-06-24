<%@ page language="java" contentType="text/html; charset=UTF-8"
	    pageEncoding="UTF-8"%>
<%@ page import ="java.util.List,board.*,java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게임 추천 게시판</title>
<link type="text/css" rel="stylesheet" href="../css/bbs.css"></link>
<style>
	select {
		  width: 100px;
		  height: 30px;
		  padding: 5px 10px 5px 10px;
		  border-radius: 10px;
		  outline: 0 none;
		}
</style>
</head>

<body>
<jsp:useBean id="dao" class="board.BoardDao" />
<%
	request.setCharacterEncoding("utf-8");
	String board = (String)session.getAttribute("board");
	String select = (String)request.getParameter("select"); //페이지를 넘겼을 떄 못가져옴..-> select값이 null이라는 오류를 발생시킴
	String searchFor = (String)request.getParameter("searchFor");	
	
	String bgcolor="";
	if(board=="힐링"){
		bgcolor = "#DBEE81";
	}else if(board=="공포"){
		bgcolor = "#AA8BDE";
	}else if(board=="협동"){
		bgcolor = "#DE8B96";
	}else{
		bgcolor = "#77acf1";
	}
		
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
    
    String pageNum = request.getParameter("pageNum");
    if (pageNum == null) {
        pageNum = "1";
    }
    
    int listSize = 10;//화면에 표시할 게시글 숫자
    int totalNum = dao.searchArticles(board, select, searchFor);//DB에 저장된 총 게시글 숫자
    
    int currPageNum = Integer.parseInt(pageNum);//현재 페이지의 네비게이션 번호
	int startRow = (currPageNum - 1) * listSize + 1;//게시글 출력시 시작번호
    int endRow = currPageNum * listSize;//게시글 출력시 끝번호
    int number = 0;//화면에 표시할 글번호
    
    List<BoardDto> articleList = null;
    
    if (totalNum > 0) {
        articleList = dao.getArticles_search(startRow, listSize * currPageNum, board, select, searchFor);
    }
    
    number = totalNum - (currPageNum - 1) * listSize;
%>

<!-- 헤더 부분 -->
<jsp:include page="../login/header.jsp" flush="false" />

<!-- 게시글 부분 -->
<p class="nameOfBoard">"<%=searchFor %>" 검색 결과</p>


<!-- 검색 부분 -->
<div style="text-align:center;">
	<form name="frm" action="search.jsp" method="get">
	<span>
		<h2>검색된 게시글 수 : <%=totalNum %>개</h2><br>
		<select name="select">
			<option>전체</option>
			<option>작성자</option>
			<option>제목</option>
			<option>내용</option>
		</select>
		<input type="text" name="searchFor" style="padding: 10px 50px; placeholder='입력하세요!'; font-size : 30px">
		&nbsp;&nbsp;&nbsp;<input type="image" src="../img/glass.png" alt="검색" width="40px">	
	</span>
	</form>
</div>
<br>
<div id="frame_1">
<div id="table">



<%

if(articleList == null){
%>	
	검색 결과가 없습니다

<%
}else{

	%>
	<table style="width:100%">

		<tr bgcolor=<%=bgcolor %>>
			<th>게시판</th>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>		
			<th>작성일</th>
			<th>조회수</th>
			<th>추천수</th>
		</tr>
	<%	
	for(BoardDto dto : articleList){
	   String regDate = sdf.format(dto.getRegDate());
%>
    <tr>
    	<td><%=dto.getBbsInd() %></td>
    	<td width="5%"><%=number-- %></td>
    	<td width="50%"><a href="bbs_content.jsp?bbsNum=<%=dto.getBbsNum() %>&pageNum=<%=pageNum %>"><%=dto.getBbsSubject() %></a></td>
    	<td><%=dto.getBbsWriter() %></td>
    	<td><%=regDate %></td>
    	<td><%=dto.getReadCount() %></td>
    	<td><%=dto.getRecommend() %></td>
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
        <a href="search.jsp?pageNum=<%=i%>&select=<%=select%>&searchFor=<%=searchFor%>"> [<%=i%>] </a>&nbsp;
<%
        }
    }else{//총 네비게이션 번호가 6 이상인 경우

    	if((startNum + navSize) <= totalNavNum){//네비게이션 시작번호와 네비게이션 표시 개수를 더한 값이 네비게이션 총 개수보다 작거나 같은 경우 
    		endNum = startNum + navSize-1;
    	}else{ endNum = totalNavNum; }	
    	
        if(startNum > navSize){
%>
        	<a href="search.jsp?pageNum=<%= (startNum-navSize) %>&select=<%=select%>&searchFor=<%=searchFor%>"> &lt;이전&nbsp;</a> 
<%   
        }
        
		for (int i = startNum; i <= endNum; i++){
%>        
           <a href="search.jsp?pageNum=<%= i %>&select=<%=select%>&searchFor=<%=searchFor%>"> [<%= i %>] </a>&nbsp;
<%
        }
        
        if(endNum < totalNavNum){
%>
            <a href="search.jsp?pageNum=<%= (endNum+1) %>&select=<%=select%>&searchFor=<%=searchFor%>"> 다음&gt; </a>
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