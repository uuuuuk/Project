<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/style.css" rel="stylesheet" type="text/css">
 			
 			<!--  상단 로그인창 -->
 </head>
<body>
	<div id="background">
		<div id="page">
			<div id="header">
			<span id="connect">
					<a href="http://facebook.com/freewebsitetemplates" target="_blank" class="facebook"></a>
					<a href="http://twitter.com/fwtemplates" target="_blank" class="twitter"></a>
					<a href="http://www.youtube.com/fwtemplates" target="_blank" class="vimeo"></a>
    		   </span>
    		    <%
    			//각 상단 메뉴에서 공통적으로 사용된 소스
    			// 세션 영역에 저장된 값 얻기
    			String id = (String)session.getAttribute("id");
    			
    			if(id == null){ // 세션값이 존재 하지 않을때..
    		%>		
    				<div id="infos">
    				<a href="login.jsp">로그인</a> | <a
    					href="join.jsp">회원가입</a>
    				</div>
    		
    		<%		
    			}else{ // 세션값이 존재 할때
    		%>	
    				<div id="infos">
				<a href="member/mypage.jsp"><%=id %>님 마이페이지</a> | 
				<a href="member/logout.jsp">로그아웃</a>
			</div>
    		
    		<%		
    			}
    		
    		
    		%>
    		    
    	<!--  상단 로그인창 -->
 
			
			<div class="clear"></div>
			<!-- 로고들어가는 곳 -->
			<div id="logoo">
				<a href="../index.jsp"><img src="../images/logoo.png"></a>
			</div>
			<!-- 로고들어가는 곳 -->

 	
 
 

	<div id="wrap">
		<!-- 헤더들어가는 곳 -->
		<header>
			<nav id="top_menu">
				<ul id="navigation">
					<li><a href="../index.jsp">상의</a></li>
					<li><a href="../pants.jsp">하의</a></li>
					<li><a href="../shoes.jsp">신발</a></li>
					<li><a href="../acc.jsp">ACC</a></li>
					<li><a href="../center/notice.jsp">게시판</a></li>
				</ul>
			</nav>
			
		</header>
		<!-- 헤더들어가는 곳 -->

		<!-- 본문들어가는 곳 -->
		<!-- 본문메인이미지 -->
		<div id="sub_img_member"></div>
		<!-- 본문메인이미지 -->
		<div id="loginpage">
		
		<!-- 본문내용 -->
		<article>
			<h1>Login</h1>
			<form action="loginPro.jsp" id="join" method="post">
				<fieldset>
					<legend>Login Info</legend>
					<label>User ID</label> <input type="text" name="id"><br>
					<label>Password</label> <input type="password" name="passwd"><br>
				</fieldset>
				<div class="clear"></div>
				<div id="buttons">
					<input type="submit" value="로그인" class="submit"> <input
						type="reset" value="다시입력" class="cancel">
				</div>
			</form>
		</article>
		</div>
		<!-- 본문내용 -->
		<!-- 본문들어가는 곳 -->

		<div class="clear"></div>
		<!-- 푸터들어가는 곳 -->
		<jsp:include page="../inc/footer.jsp" />
		<!-- 푸터들어가는 곳 -->
	</div>
</body>
</html>