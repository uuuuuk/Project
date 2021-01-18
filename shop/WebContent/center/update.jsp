<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>

<%@page import="board.BoardBean"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js" type="text/javascript"></script>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
<![endif]-->
<!--[if IE 6]>
 <script src="../script/DD_belatedPNG_0.0.8a.js"></script>
 <script>
   /* EXAMPLE */
   DD_belatedPNG.fix('#wrap');
   DD_belatedPNG.fix('#main_img');   

 </script>
 <![endif]-->
</head>
<%
	/*글수정을 위한 하나의 글정보를 검색해서 가져와서 화면에 출력하는  페이지*/
	
	String id = (String)session.getAttribute("id");
	
	//세션값이 없으면.. loing.jsp로 이동
	if(id == null){
		response.sendRedirect("../member/login.jsp");
	}
	
	//content.jsp페이지에서 글수정버튼을 클릭해서  요청받아 넘어온 num,pageNum 한글처리
	request.setCharacterEncoding("UTF-8");

	//content.jsp페이지에서 글수정버튼을 클릭해서  요청받아 넘어온 num,pageNum 얻기
	int num =  Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	//글수정을 위한 하나의 글정보 검색 DB작업을 위한 객체 생성
	BoardDAO dao = new BoardDAO();
	
	//DB로부터 하나의 글정보를 검색해서 얻기
	BoardBean boardBean = dao.getBoard(num);
	 
	//DB로 부터 하나의 글정보를 검색해서 가져온 BoardBean객체의 getter메소드를 호출 하여 리턴 받기
	int DBnum = boardBean.getNum();//검색한 글번호 
	int DBReadcount = boardBean.getReadcount();//검색한 글의 조회수 
	String DBName = boardBean.getName();//검색한 글을 작성한 사람의 이름 
	Timestamp DBDate = boardBean.getDate();//검색한 글을 작성한 날짜 및 시간 
	String DBSubject = boardBean.getSubject();//검색한 글의 글제목
	String DBContent = ""; //검색한 글내용을 저장할 용도의 변수
	
	//검색한 글의 내용이 있다면... 내용들 엔터키 처리 
	if(boardBean.getContent() != null){
		DBContent = boardBean.getContent().replace("<br>","\r\n");
	}
		
%>
<body>
	<div id="wrap">
		<!-- 헤더들어가는 곳 -->
		<jsp:include page="../inc/top.jsp"/>
		<!-- 헤더들어가는 곳 -->

		<!-- 본문들어가는 곳 -->
		<!-- 메인이미지 -->
		<div id="sub_img_center"></div>
		<!-- 메인이미지 -->

		<!-- 왼쪽메뉴 -->
		<nav id="sub_menu">
			<ul>
				<li><a href="#">Notice</a></li>
				<li><a href="#">Public News</a></li>
				<li><a href="#">Driver Download</a></li>
				<li><a href="#">Service Policy</a></li>
			</ul>
		</nav>
		<!-- 왼쪽메뉴 -->

		<!-- 게시판 -->
		<article>
			<h1>Notice Update</h1>
		<form action="updatePro.jsp?pageNum=<%=pageNum%>" method="post">
		
			<input type="hidden" name="num" value="<%=num%>">		
			
			
			<table id="notice">
				<tr>
					<td>이름</td>
					<td><input type="text" name="name" value="<%=DBName%>"></td>
				</tr>	
							
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="passwd"></td>
				</tr>
				
				<tr>
					<td>글제목</td>
					<td><input type="text" name="subject" value="<%=DBSubject%>"></td>
				</tr>
				
				<tr>
					<td>글내용</td>
					<td>
						<textarea name="content" rows="13" cols="40">
						<%=DBContent %>
						</textarea>
					
					</td>
				</tr>			
							
			</table>
			
		<div id="table_search">
			<input type="submit" value="글수정" class="btn">
			<input type="reset" value="다시작성" class="btn">
			<input type="button" value="글목록"  class="btn" 
				onclick="location.href='notice.jsp?pageNum=<%=pageNum%>'">
		
		</div>
		</form> 
		<!-- submit 버튼이 있으면 무조건 form태그로 묶어 줘야함. -->
		
		
		<div class="clear"></div>
		
		
		<div id="page_control"></div>
			
			
		</article>
		<!-- 게시판 -->
		
		
		
			
		<!-- 본문들어가는 곳 -->
		<div class="clear"></div>
		
		<!-- 푸터들어가는 곳 -->
		<jsp:include page="../inc/footer.jsp"/>
		<!-- 푸터들어가는 곳 -->
		
		
	</div>
</body>
</html>