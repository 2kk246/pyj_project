<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<!DOCTYPE html>
<html>
	<link rel="stylesheet" href="../css/style.css" />
    <link rel="preconnect" href="https://fonts.gstatic.com" />
    <link
      href="https://fonts.googleapis.com/css2?family=Ubuntu&display=swap"
      rel="stylesheet"
    />
    <style>
	    ul{
		   list-style:none;	   
		   color: red; 
		   }
		.sub{
			display:none;
			padding:0px;
		}
		ul:not(.sub)>li:hover ul{
			display:block;
		}
		ul:not(.sub)>li{
			list-style:none;
			width:150px;
			background-color:
		}
		a{
	        margin-left: 10px; 
	        color:black; 
	        text-decoration:none;
   		}
   		h5{
	        text-align: right;
	        padding-right: 50px;
   		}	 
    </style>
	
<body>
<header>

<c:set var="id" value="${id}"/>
<c:choose>
	<c:when test="${!empty id}">
	<h5> ${nick}님 환영합니다&nbsp;&nbsp;&nbsp;&nbsp;|<a href="../login/process_logout.jsp" class="">로그아웃</a> </h5>
	</c:when>
	<c:otherwise>
	<h5><a href='../login/login.jsp'><img src='../img/users.png' width='20px' alt='메인화면 로고'/> 로그인</a>&nbsp;&nbsp;|<a href='../login/join.jsp'>회원가입</a></h5>
	</c:otherwise>
</c:choose>

	<!-- Navigation Bar -->
    <nav class="navbar">
      <span class="navbar_logo">
      	<a href="../login/main.jsp">
      		<img src="../img/mushroom.png"
	         width="30px"
	         alt="logo"/>
	         MoreGame
	    </a>
      </span>
      <ul class="navbar_menu">
        <li class="active"><a href="../login/main.jsp">Home</a></li>
        <li><a href="../board/bbs_list.jsp">게임추천</a>
        	<ul class="sub">
				<li><a href="../board/bbs_list_heal.jsp">힐링게임</a></li>
				<li><a href="../board/bbs_list_horror.jsp">공포게임</a></li>
				<li><a href="../board/bbs_list_coop.jsp">협동게임</a></li>
			</ul>
        </li>
        <li><a href="../board/bbs_gongrak.jsp">공략글</a></li>
        <li><a href="../board/bbs_korean.jsp">한글패치 자료</a></li>
        <li><a href="javascript:checkMemberFn()">MyPage</a></li>
      </ul>
      <a href="#" class="navbar_toggleBtn"><i class="fas fa-bars"></i></a>
    </nav>
    </header>
	<script>
		function checkMemberFn(){
			var member = "<c:out value='${id}'/>";
			if(member == ""){
				alert("로그인 후 이용하실 수 있습니다");
				window.location.href="../login/login.jsp";
			}else{
				window.location.href="../login/member_info.jsp";
			}
		}
	</script>
</body>
</html>















