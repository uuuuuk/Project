<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- Website template by freewebsitetemplates.com -->
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>TOP</title>
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
				
				
	<%
    			//각 상단 메뉴에서 공통적으로 사용된 소스
    			// 세션 영역에 저장된 값 얻기
    			String id = (String)session.getAttribute("id");
    			
    			if(id == null){ // 세션값이 존재 하지 않을때..
    		%>		
    				<div id="infos">
    				<a href="member/login.jsp">로그인</a> | <a
    					href="member/join.jsp">회원가입</a>
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
    		

    
    
	
			
			<div class="clear"></div>
			<!-- 로고들어가는 곳 -->
			<div id="logoo">
				<a href="index.jsp"><img src="images/logoo.png"></a>
			</div>
			<!-- 로고들어가는 곳 -->
	
	
				

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





			</div> <!-- /#header -->
			
			
			<div id="contents">
				<div id="shop">
					<ul class="items">
						<li>
							<span><img src="images/top1_1.png" alt="shirt1" 
									width="230px" height="240px"/></span>
							<span class="price">KRW 50,000</span> 후드티<br/>
							<a href="#" class="buy">Buy</a>
						</li>
						<li>
							<span><img src="images/top2.png" alt="shirt2" 
									width="230px" height="240px"/></span>
							<span class="price">KRW 50,000</span> 맨투맨<br/>
							<a href="#" class="buy">Buy</a>
						</li>
						<li>
							<span><img src="images/top6.png" alt="shirt3" 
									width="230px" height="240px"/></span>
							<span class="price">KRW 50,000</span> 맨투맨<br/>
							<a href="#" class="buy">Buy</a>
						</li>
						<li class="last">
							<span><img src="images/top10.png" alt="shirt4" 
									width="230px" height="240px"/></span>
							<span class="price">KRW 50,000</span> 맨투맨<br/>
							<a href="#" class="buy">Buy</a>
						</li>

						<li>
							<span><img src="images/top5_1.png" alt="shirt5" 
									width="230px" height="240px"/></span>
							<span class="price">KRW 100,000</span> 자켓<br/>
							<a href="#" class="buy">Buy</a>
						</li>
						<li>
							<span><img src="images/top7.png" alt="shirt6" 
									width="230px" height="240px"/></span>
							<span class="price">KRW 100,000</span> 야상<br/>
							<a href="#" class="buy">Buy</a>
						</li>
						<li>
							<span><img src="images/top8_1.png" alt="shirt7" 
									width="230px" height="240px"/></span>
							<span class="price">KRW 100,000</span> 패딩<br/>
							<a href="#" class="buy">Buy</a>
						</li>
						<li class="last">
							<span><img src="images/top9.png" alt="shirt8" 
									width="230px" height="240px"/></span>
							<span class="price">KRW 100,000</span> 코트<br/>
							<a href="#" class="buy">Buy</a>
						</li>
					</ul>
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
</body>
</html>