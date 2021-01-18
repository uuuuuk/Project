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
<link href="../css/style.css" rel="stylesheet" type="text/css">
<link href="../css/daily.css" rel="stylesheet" type="text/css">
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
	/*글 상세보기 페이지*/
	//notice.jsp페이지에서 글목록중..하나를 클릭 했을떄...요청받아 넘어온 num,pageNum 한글처리
	request.setCharacterEncoding("UTF-8");

	//notice.jsp페이지에서 글목록중..하나를 클릭 했을떄...요청받아 넘어온 num,pageNum 얻기
	int num =  Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	//글목록하나를 클릭 했을 떄.. 조회수 증가 DB작업
	BoardDAO boardDao = new BoardDAO();
	BoardBean bean = boardDao.getfileBoard(num);

	//글목록하나를 클릭 했을 떄.. 조회수 증가 DB작업
	BoardDAO dao = new BoardDAO();
	
	//조회수1증가 시키는 메소드 호출
	dao.updatefileReadCount(num);
	
	//DB로부터 하나의 글정보를 검색해서 얻기
	BoardBean boardBean = dao.getfileBoard(num);
	 
	//DB로 부터 하나의 글정보를 검색해서 가져온 BoardBean객체의 getter메소드를 호출 하여 리턴 받기
	int DBnum = boardBean.getNum(); //검색한 글번호 
	int DBReadcount = boardBean.getReadcount();//검색한 글의 조회수 
	String DBName = boardBean.getName();//검색한 글을 작성한 사람의 이름 
	Timestamp DBDate = boardBean.getDate();//검색한 글을 작성한 날짜 및 시간 
	String DBSubject = boardBean.getSubject();//검색한 글의 글제목
	String DBContent = ""; //검색한 글내용을 저장할 용도의 변수
	String DBFile = boardBean.getFile(); //파일저장
	
	//검색한 글의 내용이 있다면... 내용들 엔터키 처리 
	if(boardBean.getContent() != null){
		DBContent = boardBean.getContent().replace("\r\n", "<br>");
	}
	//답변 달기에 관한 검색한 값3개 저장
	int DBRe_ref = boardBean.getRe_ref();//주글과 답글이 같은 값을 가질수 있는 유일한 그룹값
	int DBRe_lev = boardBean.getRe_lev();//주글(답글)의 들여쓰기 정도값
	int DBRe_seq = boardBean.getRe_seq();//주글(답글)들을 board테이블에 추가하면 글의 순서
	
	
%>
<body>
	<div id="background">
		<div id="page">
			<div id="header">
			<span id="connect">
					<a href="http://facebook.com/freewebsitetemplates" target="_blank" class="facebook"></a>
					<a href="http://twitter.com/fwtemplates" target="_blank" class="twitter"></a>
					<a href="http://www.youtube.com/fwtemplates" target="_blank" class="vimeo"></a>
				</span>
	<div id="wrap">
		<!-- 헤더들어가는 곳 -->
		<jsp:include page="../inc/top.jsp"/>
		<!-- 헤더들어가는 곳 -->
		<div class="clear"></div>
			<!-- 로고들어가는 곳 -->
			<div id="logoo">
				<a href="../index.jsp"><img src="../images/logoo.png"></a>
			</div>
			<!-- 로고들어가는 곳 -->

		<!-- 왼쪽메뉴 -->
		<nav id="sub_menu">
			<ul>
				<li><a href="../center/notice.jsp">게시판</a></li>
				<li><a href="../updown/info.jsp">고객리뷰</a></li>
				<li><a href="#">서비스</a></li>
			</ul>
		</nav>
		<!-- 왼쪽메뉴 -->

		<!-- 게시판 -->
		<article>
			<h1>info Content</h1>
			<table id="notice">
				<tr>
					<td>글번호</td> <td><%=bean.getNum()%></td>
					<td>조회수</td> <td><%=bean.getReadcount()%></td>
				</tr>
				<tr>
					<td>작성자</td> <td><%=bean.getName()%></td>
					<td>작성일</td> <td><%=bean.getDate()%></td>
				</tr>		
				<tr>
					<td>글제목</td> <td colspan="3"><%=bean.getSubject()%></td>
				</tr>	
				
				
				<tr>
					<td>다운로드</td>
					<td colspan="3">
					<% System.out.println(bean.getFile()); %>
					<a href="download.jsp?path=upload&name=<%=bean.getFile() %>"><%=bean.getFile() %></a>
					<img src="../upload/<%=bean.getFile()%>" width="350px" height="350px">
					</td>
				</tr>
				
				<tr>
					<td>글내용</td> <td colspan="3"><%=bean.getContent()%></td>
				
				</tr>
				
				
			</table>
			
		<div id="table_search">
		<%
			//각각페이지에서 로그인후 이동해 올떄.. session영역의 id전달 받기
			String id = (String)session.getAttribute("id");
		
			if(id != null){
		%>
			<input type="button" value="글수정" class="btn" 
			onclick="location.href='update.jsp?num=<%=DBnum%>&pageNum=<%=pageNum%>'">
			
			<input type="button" value="글삭제" class="btn"
			onclick="location.href='review_delete.jsp?num=<%=DBnum%>&pageNum=<%=pageNum%>'">
			
			<input type="button" value="답글쓰기" class="btn"
			onclick="location.href='reWrite.jsp?num=<%=DBnum%>&re_ref=<%=DBRe_ref%>&re_lev=<%=DBRe_lev%>&re_seq=<%=DBRe_seq%>'">
		<%			
			}
		%>
		<input type="button" value="글목록" class="btn" 
		onclick="location.href='info.jsp?pageNum=<%=pageNum%>'">

		</div>
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