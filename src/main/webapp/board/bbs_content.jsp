<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.util.List,board.*,java.text.SimpleDateFormat" %>

<jsp:useBean id = "dao"  class="board.BoardDao"/>
<jsp:useBean id = "dto"  class="board.BoardDto"/>
<jsp:useBean id = "Cdao"  class="board.CommentDao"/>
<jsp:useBean id = "Fdao"  class="board.FileDao"/>

<%
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm");
	String pageNum = request.getParameter("pageNum");
	int bbsNum=Integer.parseInt(request.getParameter("bbsNum"));//게시글 넘버
	dao.updateReadCount(bbsNum);//조회수 증가
	dto=dao.getArticle(bbsNum);//어떤 글의 정보를 가져올까 bbsNum으로 정해준다
	session.setAttribute("bbsNum",bbsNum);//댓글쓰기 위한 게시글 찾는 sql에 들어감
	String nick = (String)session.getAttribute("nick");
	int bbsCNum=0;
	String comment="";
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%=dto.getBbsSubject() %></title>

<script src="<%= request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
<script>
	//추천수 증가 함수
	var recnum=0;
	var allData = {"bbsNum": <%=bbsNum%>};
	<%/*
	스크립트릿(서버 사이드 스크립트)는 자바스크립트(클라 사이드 스크립트) 문법에 상관없이 그냥 실행된다
	서로 정보 전달을 위해서는 이렇게 하지말고 AJAX & JSON을 이용하는 것이 좋다
	dao.updateRecommend(bbsNum); (X)
	*/%>
	function recommendFn(){
		if(recnum==0){
			$.ajax({
				type:"get",
				url:"<%= request.getContextPath()%>/ajax/recommendAjax.jsp",
				data:allData,
				success:function(data){
					//추천수를 증가시키고 1을 반환
					if(data==1){
						$("#rec span").text(Number($("#rec span").text())+1);
						recnum++;					
					}else{
						alert("추천 실패");
					}
				}
			});
		}else{
			alert("추천은 한번만 가능합니다");
		}	
	}
</script>
<link type="text/css" rel="stylesheet" href="../css/bbs.css"></link>
<link rel="preconnect" href="https://fonts.gstatic.com" />
<link
  href="https://fonts.googleapis.com/css2?family=Ubuntu&display=swap"
  rel="stylesheet"
/>
<link rel="stylesheet" href="../css/animate.css" />
<style>
	table {
	    margin-left:auto; 
	    margin-right:auto;
	    
	}
	table, td, th {
	    border-collapse : collapse;
	    border-bottom : 1px solid black;
	}
	::placeholder { /* Chrome, Firefox, Opera, Safari 10.1+ */
 		font-size: 1.4em;
 		font-weight: 400;
	}
	#outputArea { 
		text-align : left;
		margin-left:50px; 
	    margin-right:50px;
	}
	.modNdel{
		background-color:transparent;
		border-radius: 20px;
		box-shadow: 1px 1px 3px 1px #dadce0;
	}
	
</style>
</head>
<body>
<!-- 헤더부분 -->
<jsp:include page="../login/header.jsp" flush="false" />

<!-- 제목&작성자 부분 -->
<h2 style="padding-left:50px"><%=dto.getBbsSubject() %></h2>
<div style="text-align:right; padding-right:20px">
<h4>작성자 : <%=dto.getBbsWriter() %><br> 작성일 : <%=dto.getRegDate() %></h4>
<span>
<%
	if(dto.getBbsWriter().equals(nick)){
%>
	<button class="y-btn" onclick="window.location='bbs_update.jsp?bbsNum=<%=bbsNum %>&pageNum=<%=pageNum %>' ">수정하기</button>&nbsp; | &nbsp;
	<button class="y-btn" onclick="window.location='bbs_delete.jsp?bbsNum=<%=bbsNum %>' ">글삭제</button>&nbsp; | &nbsp;
<% } %>
	<button class="y-btn" onclick="window.location='bbs_list.jsp'">글목록</button>
</span>
</div>
<div id="frame_1" style="margin-top: 10px">
	<div id="outputArea"><%=dto.getBbsContent() %></div><br>
<!-- 추천 부분 -->
	<p id="rec"> 추천수 <span><%=dto.getRecommend() %></span> <button type="button" onclick="recommendFn()"><img src="../img/thumbs-up.png" alt="추천" width="20px"></button></p>
<!-- 첨부 파일 부분 -->
<%
String board = (String)session.getAttribute("board");
if(board=="한글패치"){
%>

<form name="downloadForm" action="fileDownload.jsp" method="post">
	파일명 : <input type="text" value="<%=Fdao.findBbsFRoute(bbsNum)%>" disabled/>
	<input type="hidden" name="sys_file" value="<%=Fdao.findBbsFRoute(bbsNum)%>"/>
	<button onclick="javascript:downloadForm.submit()">다운받기</button>
</form>

</body>
<%}%>
<!-- 댓글 부분 (ajax로 구현) -->
	<textarea name="commentInput" id="commentInput" placeholder="댓글을 입력해주세요" tabindex="3" style="width:70%;border:1;overflow:visible;text-overflow:ellipsis; resize: none;" rows="8" ></textarea><br>
	<%
		int totalNum = Cdao.countComments(bbsNum);//DB에 저장된 총 댓글 숫자   
		List<CommentDto> commentList = null;
		if (totalNum > 0) {
	        commentList = Cdao.getComments(bbsNum);
	    }
	%>
	
	
	<table id="comment" style = "table-layout: auto; width: 80%; table-layout: fixed;">
	<tr>
		<td style="border:none;"></td>
		<td style="border:none;"></td>
		<td style="border:none;"><button class="y-btn" type="button" onclick="submitComment()">등록</button></td>
	</tr>
	<tr>
		<td style="border:none;">
			전체 댓글 :<span><%=totalNum%></span> 개
		</td>
	</tr>
	<% 
	if(commentList == null){ //댓글이 없는 경우
	}else{ //댓글이 있는 경우
		for(CommentDto Cdto : commentList){
			String CregDate = sdf.format(Cdto.getCregDate());
			bbsCNum = Cdto.getBbsCNum();
	%>
	<tr>
		<td width="150px">
		<span hidden><%=bbsCNum%></span>
		<%=Cdto.getBbsCWriter() %>&nbsp;·&nbsp;<%=CregDate %></td>
		<td width="400px"><%=Cdto.getBbsCContent() %></td>
		<td>
		<% if(nick!=null){
			if(nick.equals(Cdto.getBbsCWriter())){%>
			<input class="modNdel" type="button" value="수정" onclick="mod_comment(this)"/>&nbsp;/&nbsp;
			<input id="del" class="modNdel" type="button" value="삭제" onclick="del_comment(this)"/>
		<%} } %>
		</td>
	</tr>
	<%
		}//for문의 닫힘 괄호
	}//else문의 닫힘 괄호
	%>	
	</table>
</div>
<script>
//1. 수정 버튼을 누름
function mod_comment(obj){
	//2. 두번쨰 td에 있는 내용을 가져옴
	var text = $(obj).parent().prev().html();
	//3. textarea의 배경을 투명하게 주고 두번째 td를 지움
	$(obj).parent().prev().after("<textarea rows='2' style='width:100%; border:1; overflow:visible; text-overflow:ellipsis; resize: none; background-color:transparent'>"+text+"</textarea>");
	$(obj).parent().prev().prev().remove();
	//4. 수정버튼을 제거하고 수정완료 버튼으로 변경
	$(obj).after("<input class='modNdel' type='button' value='수정완료' onclick='mod_comment2(this)'/>");
	$(obj).remove();
	//5. 내용을 받아서 modComment.jsp ajax로 넘겨줌 -> mod_comment2()에서 진행
}
function mod_comment2(obj){
	//textarea또한 입력양식이므로 val로 가져온다
	var text = $(obj).parent().prev().val();
	var bbsCNum = $(obj).parent().parent().find('span').html();
	$.ajax({
		type:"post",
		url:"<%= request.getContextPath()%>/ajax/modComment.jsp",
		data:{"bbsCContent": text, "bbsCNum" : bbsCNum},
		success:function(data){
			//댓글지우기를 성공하면 1을 반환
			if(data==1){
				window.location.reload();
			}else{
				alert("댓글 수정 실패");
			}
		}
	});
}
function del_comment(obj){
	var text = $(obj).parent().parent().find('span').html();
	console.log(text);
	$.ajax({
		type:"get",
		url:"<%= request.getContextPath()%>/ajax/delComment.jsp",
		data:{"bbsCNum": text},
		success:function(data){
			//댓글지우기를 성공하면 1을 반환
			if(data==1){
				window.location.reload();
			}else{
				alert("댓글 지우기 실패");
			}
		}
	});
}
function submitComment(){
	var nick = "<%=nick%>";
	var commentInput = $("#commentInput").val();
	
	var today = new Date();
	var dd = today.getDate();
	var mm = today.getMonth()+1; //January is 0!
	var yyyy = today.getFullYear();
	var hours = ('0' + today.getHours()).slice(-2);
	var minutes = ('0' + today.getMinutes()).slice(-2);
	if(dd<10) {dd='0'+dd} 
	if(mm<10) {mm='0'+mm} 
	today = yyyy+'.'+mm+'.'+dd+" "+hours+":"+minutes;
	
	if(nick=="null"){
		alert("로그인 하신 후 댓글을 등록할 수 있습니다");
	}else{
		$.ajax({
			type:"get",
			url:"<%= request.getContextPath()%>/ajax/writeComment.jsp",
			data: $("#commentInput").serialize(),
			success:function(data){
				//댓글 입력 성공시 0이 아님 
				if(data!=0){
					$("#comment").append("<tr><span hidden>"+<%=bbsCNum%>+"</span><td>"+nick+" · "+today+"</td><td>"+commentInput+"</td><td><input class='modNdel' type='button' value='수정' onclick='mod_comment()'/>&nbsp;/&nbsp;<input class='modNdel' type='button' value='삭제' onclick='del_comment()'/></td></tr>");
					$("#com span").text(Number($("#com span").text())+1);
					$("#commentInput").val("");
					window.location.reload();
				}else{
					alert("댓글 입력 실패");
				}
			}
		});	
	}//end_of_else
}
</script>
<!-- 밑단 부분 -->
<div style="height:550px;"></div>
<jsp:include page="../login/footer.jsp" flush="false" />
</body>
</html>