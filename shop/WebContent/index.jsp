<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- Website template by freewebsitetemplates.com -->
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>Shop</title>
	<link rel="stylesheet" href="css/style.css" type="text/css" charset="utf-8" />	
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
				
				<!-- ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ -->
				
				
				
				
	<%
			// session객체영역에 세션id값을 얻어...
			String id = (String)session.getAttribute("id");
			// getAttribute -> 반환받는 타입은 Object타입
			
			// session객체 영역에 세션id값이 저장되어 있지 않다면?
			if(id == null){ // 로그아웃된 상태
	%>
				
				<span id="infos">
					<a href="member/login.jsp">로그인</a> | <a href="member/join.jsp">회원가입</a>
				</span>
	<%		
			}else{ // session객체 영역에 세션id값이 저장되어 있다면?
	%>
			
			<div id="infos">
				<a href="member/mypage.jsp"><%=id %>님 마이페이지</a> | 
				<a href="member/logout.jsp">로그아웃</a>
			</div>

			
			
			</div>
		<%
			}	
		%>	
		
		
		<div id="logoo">
			<a href="index.jsp"><img src="images/logoo.png"></a>
		</div>
			<a href="index.jsp" id="logo"></a> 		
		<!-- /#logo -->
		
		
		<ul id="navigation">
			
			<li><a href="toptop.jsp">상의</a>
				<ul>
					<li><a href="#">아우터</a></li>
					<li><a href="#">후드/맨투맨</a></li>
					<li><a href="#">셔츠</a></li>
				</ul>
			</li>
			
			<li><a href="pants.jsp">하의</a>
				<ul>
					<li><a href="#">데님</a></li>
					<li><a href="#">그외</a></li>
				</ul>
			
			</li>
			<li><a href="shoes.jsp">신발</a></li>
			<li><a href="acc.jsp">ACC</a></li>
			<li><a href="center/notice.jsp">게시판</a></li>
			
		</ul>
			
			
		
		
		
		</div> 
			
		
			
			<!-- /#header -->
			<div id="contents">
				<div id="main">
					<div id="adbox">
						<img src="images/logo.jpg" alt="Img" />
					</div>
				</div>
				
				<div>
				<ul>
					<li><h2>누적 판매순TOP4</h2></li>
				</ul>
				</div>
				
				<div id="featured">
					<ul>
						<li><img src="images/top5_1.png" alt="shirt" width="230px" height="240px"/></li>
						<li><img src="images/pants6.png" alt="pants" width="230px" height="240px"/></li>
						<li><img src="images/shoes1.png" alt="shoes" width="230px" height="240px"/></li>
						<li class="last"><img src="images/acc3.png" alt="images" width="230px" height="240px"/></li>
					</ul>
					<a href="index.jsp" class="button">TOP !</a> 
				</div>
			</div> <!-- /#contents -->
			<div id="footer">
				<div id="description">
					<div>
						<li><img src="images/logoo.png" alt="logoo" width="150px" height="100px"/>
						<!-- <a href="index.jsp" class="logo"></a> --> 
						</li>
						<!-- <span>&copy; Copyright &copy; 2011. <a href="index.jsp">Company name</a> All rights reserved</span> -->
					</div>
					<p>
						This website template has been designed by <a href="http://www.freewebsitetemplates.com/">Free Website Templates</a> for you, for free. You can replace all this text with your own text.
						You can remove any link to our website from this website template, you're free to use this website template without linking back to us.
						If you're having problems editing this website template, then don't hesitate to ask for help on the <a href="http://www.freewebsitetemplates.com/forum/">Forum</a>.
					</p>
				</div>
				<div class="navigation">
					<a href="index.jsp">Home</a>|
					<a href="toptop.jsp">TOP</a>|
					<a href="pants.jsp">PANTS</a>|
					<a href="shoes.jsp">SHOES</a>|
					<a href="acc.jsp">ACC</a>
				</div>
			</div> <!-- /#footer -->
		</div> <!-- /#page -->
	</div> <!-- /#background -->
	
	
	<!-- 푸터 -->
	<%@include file="inc/footer.jsp" %>
	
</body>
</html>