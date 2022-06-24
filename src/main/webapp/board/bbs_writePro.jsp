<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글쓰기 처리</title>
</head>
<body>

<%
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="dto" class="board.BoardDto" />
<jsp:setProperty property="*" name="dto"/>
<jsp:useBean id="dao" class="board.BoardDao" />
<jsp:useBean id="Fdto" class="board.FileDto" />
<jsp:setProperty property="*" name="Fdto"/>
<jsp:useBean id="Fdao" class="board.FileDao" />
<%
	String id = (String)session.getAttribute("nick");
	int result = dao.insert(dto,id);
	String board = (String)session.getAttribute("board");
	if(board=="한글패치"){
		String bbsFRoute = request.getParameter("bbsFRoute");
		String bbsFRoute2 = request.getParameter("bbsFRoute2");
		if(result != 0){//여기서 bbsNum값인 result를 가지고 파일업로드에 대한 작업을 수행
			System.out.println(result);
			System.out.println("절대경로 : "+bbsFRoute+", 상대경로 : "+bbsFRoute2);
			int result2 = Fdao.insert(Fdto, id, bbsFRoute, bbsFRoute2, result);
			out.println("<script>alert('게시글이 정상적으로 입력되었습니다'); history.go(-2);</script>");
		}else{
			out.println("<script>");
			out.println("alert('게시글 입력 실패');");
			out.println("history.back();");
			out.println("</script>");
		}
	}else{ //한글패치가 아닌 다른 게시판인 경우
		if(result != 0){//여기서 bbsNum값인 result를 가지고 파일업로드에 대한 작업을 수행
			out.println("<script>alert('게시글이 정상적으로 입력되었습니다'); history.go(-2);</script>");
		}else{
			out.println("<script>");
			out.println("alert('게시글 입력 실패');");
			out.println("history.back();");
			out.println("</script>");
		}
	}
	
%>
</body>
</html>