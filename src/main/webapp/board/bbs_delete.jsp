<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글삭제</title>
<link type="text/css" rel="stylesheet" href="../css/bbs.css"></link>
</head>
<body>
<!-- 헤더부분 -->
<jsp:include page="../login/header.jsp" flush="false" />

<div style="margin-top: 50px"><h3>글 삭제</h3></div>
<div id="frame_1" style="margin-top: 10px">
<form action="bbs_deletePro.jsp">

    <input type="hidden" name="bbsNum" value="<%=request.getParameter("bbsNum") %>"/>
	<div>정말 글삭제를 하시겠습니까?</div>	
	<input type="submit" value="삭제하기"/>&nbsp; | &nbsp;
	<input type="button" value="목록보기" onclick="window.location='bbs_list.jsp' "/>

</form>
</div>
<!-- 밑단 부분 -->
<div style="height:550px;"></div>
<jsp:include page="../login/footer.jsp" flush="false" />
</body>
</html>