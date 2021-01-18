<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <header>
    		<%
    			//각 상단 메뉴에서 공통적으로 사용된 소스
    			// 세션 영역에 저장된 값 얻기
    			String id = (String)session.getAttribute("id");
    			
    			if(id == null){ // 세션값이 존재 하지 않을때..
    		%>		
    				<div id="infos">
    				<a href="../member/login.jsp">로그인</a> | <a
    					href="../member/join.jsp">회원가입</a>
    				</div>
    		
    		<%		
    			}else{ // 세션값이 존재 할때
    		%>	
    				<div id="infos">
				<a href="../member/mypage.jsp"><%=id %>님 마이페이지</a> | 
				<a href="../member/logout.jsp">로그아웃</a>
			</div>

    		
    		<%		
    			}
    		%>
    		
    
    
			
			<div class="clear"></div>
			<!-- 로고들어가는 곳 -->
			<div id="logoo">
				<a href="../index.jsp"><img src="images/logoo.png"></a>
			</div>
			<!-- 로고들어가는 곳 -->
			
			
			
		</header>
    
    
    