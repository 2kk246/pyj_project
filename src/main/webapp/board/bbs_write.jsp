<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판 글쓰기</title>
<script src="<%= request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
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
<script>
	var checkfile = 0; //파일 선택 버튼
	var checkSave = 0; //업로드 버튼
	$(function(){
	    $('#uploadBtn').on('click', function(){
	    	if(checkfile==0){
	    		alert("파일을 올려주세요");
	    	}else{
	    		uploadFile();
		        $(this).after("업로드 성공");
		        checkSave = 1;
	    	}
	    });
	    $('#submitto').on('click',function(){
	    	var board = "<%=board%>";
	    	if(checkfile!=0){
	    		if(checkSave!=1 && board=='한글패치'){
		    		alert("업로드 버튼을 눌러주세요");
		    	}else{
		    		$("#uploadForm").submit();
		    	}
	    	}else if(checkfile==0 && board=='한글패치'){
	    		alert("파일을 올려주세요");
	    	}else{
	    		$("#uploadForm").submit();
	    	}
	    	
	    });
	    $("#uploadfile").one('click',function(){
	    	checkfile = 1;
	    });
	});
	function uploadFile(){
	    var form = $('#uploadForm')[0];
	    var formData = new FormData(form);

	    $.ajax({
	        url : '<%= request.getContextPath()%>/ajax/uploadFile.jsp',
	        type : 'POST',
	        data : formData,
	        contentType : false,
	        processData : false,    
	        success : function(data){
	        	var dataJson = JSON.parse(data.trim());
				$("#bbsFRoute").val(dataJson[0].bbsFRoute);
				$("#bbsFRoute2").val(dataJson[0].bbsFRoute2);
	        }
	    }).done(function(data){
	        console.log("파일 전송 성공");
	    });
	}
</script>  
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
	    border-collapse: collapse;
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

<p class="nameOfBoard">글쓰기</p>
<div id="frame_0">
<div id="frame_1">
	
	<form id="uploadForm" name="frm" method="post" action="bbs_writePro.jsp">
		
		<span style="float:right;">
		<%
			if(board=="공략"){
				out.println("<input type='hidden' name='bbsInd' value='공략'></input>");
			}else if(board=="한글패치"){
				out.println("파일upload : <input type='file' id='uploadfile' name='uploadfile' value=''><button type='button' class='y-btn' id='uploadBtn'>업로드</button>");
				out.println("<input type='hidden' name='bbsInd' value='한글패치'></input>");
				out.println("<input type='hidden' id='bbsFRoute' name='bbsFRoute' value=''/>");
				out.println("<input type='hidden' id='bbsFRoute2' name='bbsFRoute2' value=''/>");
			}else if(board=="전체"){
				out.println("게시판 선택 <select name='bbsInd'><option>전체</option><option>힐링</option><option>공포</option><option>협동</option></select>");
			}else if(board=="힐링"){
				out.println("게시판 선택 <select name='bbsInd'><option>전체</option><option selected>힐링</option><option>공포</option><option>협동</option></select>");
			}else if(board=="공포"){
				out.println("게시판 선택 <select name='bbsInd'><option>전체</option><option>힐링</option><option selected>공포</option><option>협동</option></select>");
			}else if(board=="협동"){
				out.println("게시판 선택 <select name='bbsInd'><option>전체</option><option>힐링</option><option>공포</option><option selected>협동</option></select>");
			}else if(board=="공지"){
				out.println("<input type='hidden' name='bbsInd' value='공지'></input>");
			}
		%>
		</span>
		<table style="width:480px">
			<tr>
				<td bgcolor=<%=bgcolor%>>제목</td>
			</tr>
			<tr>
				<td><input class="inputSubject" type="text" name="bbsSubject" size="80" style="padding:5px;" /></td>
			</tr>
			<tr>
				<td bgcolor=<%=bgcolor%>>내용</td>
			</tr>
			<tr>
				<td><textarea name="bbsContent" cols="125" rows="30" style="resize: none;"></textarea></td>
			</tr>
			<tr>
				<td colspan="2">
					<input class="inputButton" id="submitto" type="button" value="글등록"/> &nbsp; | &nbsp;
					<input class="inputButton" type="reset" value="다시쓰기"/>&nbsp; | &nbsp;
					<input class="inputButton" type="button" value="목록보기" onclick="history.back()"/>
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