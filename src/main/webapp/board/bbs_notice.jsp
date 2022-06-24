<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.util.List,board.*,java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게임 추천 게시판</title>
<script src="<%= request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
<link type="text/css" rel="stylesheet" href="../css/bbs.css"></link>
</head>

<body>
<jsp:useBean id="dao" class="board.BoardDao" />
<%
	session.setAttribute("board","공지");
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	String id = (String)session.getAttribute("nick");
	
    String pageNum = request.getParameter("pageNum");
    if (pageNum == null) {
        pageNum = "1";
    }
    
    int listSize = 10;//화면에 표시할 게시글 숫자
    int totalNum = dao.countArticles("공지");//DB에 저장된 총 게시글 숫자
    
    int currPageNum = Integer.parseInt(pageNum);//현재 페이지의 네비게이션 번호
	int startRow = (currPageNum - 1) * listSize + 1;//게시글 출력시 시작번호
    int endRow = currPageNum * listSize;//게시글 출력시 끝번호
    int number = 0;//화면에 표시할 글번호
    
    List<BoardDto> articleList = null;
    
    if (totalNum > 0) {
        articleList = dao.getArticles(startRow, listSize * currPageNum, "공지");
    }
    
    number = totalNum - (currPageNum - 1) * listSize;
%>

<!-- 헤더 부분 -->
<jsp:include page="../login/header.jsp" flush="false" />

<!-- 게시글 부분 -->
<p class="nameOfBoard">Notice</p>

<script>
	$(function(){
		$(document).one("click", ".list-write-link", function() {
			var id = "<%=id%>";
			if(id!="null"){
				location.href="bbs_write.jsp";
			}else{
				alert('로그인 후 글을 등록하실 수 있습니다');
				location.reload();
			}
		});
	})
</script>
<%
	if(id==null){
		//로그인을 안함
	}else{
		if(id.equals("운영자")){
			%>
			<!-- 글쓰기 버튼 -->
			<div style="text-align:right;"><div class="list-write-link" style="display: inline;"><img src="../img/write.png" alt="글쓰기" width="30px" style="cursor: pointer;"></div></div>
			<%
		}else{//운영자가 아닌 유저
			
		}
	}
	
	
%>
<!-- 추천순 조회순 정렬 부분 -->
<div style="text-align:left">
	<a href="bbs_list_rec.jsp">추천순&nbsp;&nbsp;</a>
	<a href="bbs_list_hit.jsp">조회순&nbsp;&nbsp;</a>
</div>
<br>

<div id="frame_1">
<div id="table">

<table style="width:100%">

	<tr bgcolor="#77acf1">
		<th>게시판</th>
		<th>번호</th>
		<th>제목</th>
		<th>작성자</th>		
		<th>작성일</th>
		<th>조회수</th>
		<th>추천수</th>
	</tr>

<%

if(articleList == null){
%>	
	<tr>
		<td colspan="5">게시판에 올린 글이 없습니다. 글을 올려 주세요..</td>
	</tr>

<%
}else{
	
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
        <a href="bbs_notice.jsp?pageNum=<%=i%>"> [<%=i%>] </a>&nbsp;
<%
        }
    }else{//총 네비게이션 번호가 6 이상인 경우

    	if((startNum + navSize) <= totalNavNum){//네비게이션 시작번호와 네비게이션 표시 개수를 더한 값이 네비게이션 총 개수보다 작거나 같은 경우 
    		endNum = startNum + navSize-1;
    	}else{ endNum = totalNavNum; }	
    	
        if(startNum > navSize){
%>
        	<a href="bbs_notice.jsp?pageNum=<%= (startNum-navSize) %>"> &lt;이전&nbsp;</a> 
<%   
        }
        
		for (int i = startNum; i <= endNum; i++){
%>        
           <a href="bbs_notice.jsp?pageNum=<%= i %>"> [<%= i %>] </a>&nbsp;
<%
        }
        
        if(endNum < totalNavNum){
%>
            <a href="bbs_notice.jsp?pageNum=<%= (endNum+1) %>"> 다음&gt; </a>
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