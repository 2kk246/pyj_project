<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.util.List,board.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c"%>

<jsp:useBean id = "dao"  class="board.BoardDao"/>
<jsp:useBean id = "dto"  class="board.BoardDto"/>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>메인 화면</title>
<link type="text/css" rel="stylesheet" href="../css/bbs.css"></link>
<link rel="stylesheet" href="../css/style.css" />
<link rel="preconnect" href="https://fonts.gstatic.com" />
<link
  href="https://fonts.googleapis.com/css2?family=Ubuntu&display=swap"
  rel="stylesheet"
/>
<style>
    .footer, h2{text-align: center;}
    table {
	    margin-left:auto; 
	    margin-right:auto;
	    text-align:center;
	}
	table, td, th {
	    border-collapse: collapse;
	    height : 50px;
	}
	td{
		border-style: hidden;
	}
	.scrollpop { opacity:0; }
	.y-btn {background-color:white; padding: 10px 30px;}
</style>
<script src="<%= request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
<script src="<%= request.getContextPath()%>/js/scrollevent.js"></script>
<script type="text/javascript" src="../js/jquery.visible.js"></script>
    <script type="text/javascript" src="../js/wow.min.js"></script>
    <script src="../js/main.js" defer></script>
    <script type="module" src="../js/form-submission-handler.js" defer></script>
    <script
      src="https://kit.fontawesome.com/b519885361.js"
      crossorigin="anonymous"
      defer
    ></script>
    
    
</head>
<body id="top" style="overflow-x: hidden">
	<!-- 헤더부분 -->
	<jsp:include page="header.jsp" flush="false" />
<%
//공지 상위 5개의 글
List<BoardDto> noticeList = null;
noticeList = dao.getArticles(1, 5, "공지");
pageContext.setAttribute("Ndto", noticeList);

//랜덤으로 어떤 글의 정보를 가져올까 bbsNum으로 정해준다 
dto=dao.getArticle(dao.getArticleRandom());
pageContext.setAttribute("dto",dto);

//최근 덧글 5개의 글
List<BoardDto> articleList = null;
articleList = dao.getTop5Comment();
pageContext.setAttribute("Bdto", articleList);
%>
<c:set var="board" value="전체" scope="session"/>
	<!-- 메인화면 이미지 -->
	<section class="home scroll" id="main_home">
	<div id="frame_1" style="box-shadow:none;">
	<a class="y-btn more__btn" href="#main_notice">공지사항</a>
	<a class="y-btn more__btn" href="#main_randomGame">랜덤게임</a>
	<a class="y-btn more__btn" href="#main_lastComment5">최근댓글게시판</a>
	<br>
	<div style="position: static;">
		<img id="test" 
	        src="../img/mainimg.jpg"
	        width="90%"
	        alt="메인화면 이미지"
	        border="0"
	      />
	</div>
	</div>

	<div class="wave_container">
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 200">
          <path
            background-color: #94c4f6;
            fill="#f1f7fb"
            fill-opacity="1"
            d="M0,96L40,85.3C80,75,160,53,240,69.3C320,85,400,139,480,154.7C560,171,640,149,720,122.7C800,96,880,64,960,74.7C1040,85,1120,139,1200,133.3C1280,128,1360,64,1400,32L1440,0L1440,320L1400,320C1360,320,1280,320,1200,320C1120,320,1040,320,960,320C880,320,800,320,720,320C640,320,560,320,480,320C400,320,320,320,240,320C160,320,80,320,40,320L0,320Z"
          ></path>
        </svg>
      </div>
      </section>
	<!-- 공지 사항 -->
	<div id="main_notice" class="scrollpop" style="text-align:center; height:500px;">
	<table style="width:500px;">
		<tr style="cursor:pointer;" onclick="location.href='../board/bbs_notice.jsp'"><td colspan=4><h2>
			<img src="../img/notice.png"
	         width="25px"
	         alt="구획"/> 공지 사항
	    </h2></td></tr>
		<tr bgcolor="#77acf1">
		<th>번호</th>
		<th>제목</th>
		<th>작성자</th>		
		<th>조회수</th>
	</tr>
	<c:choose>
		<c:when test="${empty Ndto}">
			<tr>
				<td colspan="5">게시판에 올린 글이 없습니다. 글을 올려 주세요..</td>
			</tr>	
		</c:when>
		<c:otherwise>
			<c:forEach var="Ndto" items="${Ndto}">
				<tr style="cursor:pointer;" onclick="location.href='../board/bbs_content.jsp?bbsNum=${Ndto.getBbsNum()}'">
			    	<td>${Ndto.getBbsNum()}</td>
			    	<td width="50%">${Ndto.getBbsSubject()}</td>
			    	<td>${Ndto.getBbsWriter()}</td>
			    	<td>${Ndto.getReadCount()}</td>
			    </tr>
			</c:forEach>
		</c:otherwise>
	</c:choose>
	</table>
	</div>
	
	<!-- 랜덤 게임 추천 -->
	<div id="main_randomGame" class="scrollpop" style="text-align:center; height:500px;">
	<table style="width:500px; cursor:pointer;" onclick="location.href='../board/bbs_content.jsp?bbsNum=<%=dto.getBbsNum() %>'">
		<tr><td><h2>
			<img src="../img/reload.png"
	         width="25px"
	         alt="구획"/> 랜덤 게임
	    </h2></td></tr>
		<tr><td bgcolor="94c4f6">${dto.bbsSubject}</td></tr>
		<tr><td>${dto.getBbsContent()}</td></tr>
	</table>
	</div>
	
	<!-- 최근 덧글이 달린 게시판 상위 5개  -->
	<div id="main_lastComment5" class="scrollpop" style="position: relative;">
		
		<table style="width:500px">
			<tr><td colspan="4"><h2>
			<img src="../img/message.png"
	         width="25px"
	         alt="구획"/> 최근 댓글이 달린 게시판
	         </h2></td></tr>
			<tr bgcolor="94c4f6">
				<td>번호</td>
				<td>게시판</td>
				<td>제목</td>
				<td>작성자</td>
			</tr>
		<c:choose>
			<c:when test="${empty Bdto}">
				<tr>
					<td colspan="5">게시판에 올린 글이 없습니다. 글을 올려 주세요..</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach var="Bdto" items="${Bdto}">
					<tr onclick="location.href='../board/bbs_content.jsp?bbsNum=${Bdto.getBbsNum()}'" style="cursor:pointer">
						<td>${Bdto.getBbsNum()}</td>
						<td>${Bdto.getBbsInd()}</td>
						<td width="50%">${Bdto.getBbsSubject()}</td>
						<td>${Bdto.getBbsWriter()}</td>
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
		
		</table>
	</div>
	
	
	
	
	
	
</div>

<!-- 밑단 부분 -->
<div style="height:550px;"></div>
<jsp:include page="footer.jsp" flush="false" />

<!-- top 버튼 -->
<a href="#top" style="width:50px; height:50px; position:fixed; right:10px; bottom:10px;">
			<img class="scrollpop" src="../img/up-arrow.png"
	         width="50px"
	         alt="구획"/>
</a>
</body>
</html>