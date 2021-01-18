<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="../css/daily.css" rel="stylesheet" type="text/css">
<link href="../css/style.css" rel="stylesheet" type="text/css">
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
		<!-- 헤더들어가는 곳 -->
		
			<ul>
				<div id="infos">
				<a href="logout.jsp">로그아웃</a> |
				<a href="../index.jsp">처음으로</a>
			</div>
			</ul>	
		
			<div class="clear"></div>
			<!-- 로고들어가는 곳 -->
			<div id="logoo">
				<a href="../index.jsp"><img src="../images/logoo.png"></a>
			</div>
			<!-- 로고들어가는 곳 -->
<%
		String id=(String)session.getAttribute("id");
		if(id == null){
			
			response.sendRedirect("login.jsp");
		}
		
		MemberBean memB = new MemberBean();
		MemberDAO memD = new MemberDAO();
		memB = memD.selectDB(id);
%>




		
		
		
		
		<article>
		<div id="mypage">
			<h1>마이페이지</h1>
		</div>
			
			<form action="modify.jsp" id="modify" method="post" name="myinfo">
				<fieldset>
					<legend>Basic Info</legend>
				ID <input type="text" name="id" value="<%=memB.getId()%>" readonly> <br>
				PW <input type="text" name="passwd" value="<%=memB.getPasswd()%>" readonly> <br>
				NAME <input type="text" name="name" value="<%=memB.getName()%>" readonly> <br>
				E-MAIL	<input type="text" name="email" value="<%=memB.getEmail()%>" readonly> <br>
				우편번호	<input type="text" name="address" value="<%=memB.getAddress()%>" readonly> <br>
				도로명주소	<input type="text" name="address1" value="<%=memB.getAddress1()%>" readonly> <br>
				지번주소	<input type="text" name="address2" value="<%=memB.getAddress2()%>" readonly> <br>
				상세주소	<input type="text" name="address3" value="<%=memB.getAddress3()%>" readonly> <br>
				참고		<input type="text" name="address4" value="<%=memB.getAddress4()%>" readonly> <br>
				NUMBER	<input type="text" name="tel" value="<%=memB.getTel()%>" readonly> <br>
				PHONE  <input type="text" name="mtel" value="<%=memB.getMtel()%>" readonly> <br>	
					
				<input type="submit" value="수정하기">
				<input type="reset" value="취소">	
					
			</form>
		</article>
				
				<!-- <form action="modify.jsp">
				
				<input type="submit" value="회원정보 수정" class="submit" >
		
				</form> -->
				<!-- 푸터들어가는 곳 -->
		<jsp:include page="../inc/footer.jsp"/>
		<!-- 푸터들어가는 곳 -->
		
</body>
</html>





