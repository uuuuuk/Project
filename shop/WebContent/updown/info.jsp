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
<title>Notice</title>

<link href="../css/daily.css" rel="stylesheet" type="text/css">
<link href="../css/style.css" rel="stylesheet" type="text/css">
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
		<jsp:include page="../inc/top.jsp"/>
		<!-- 헤더들어가는 곳 -->

		<div id="wrap">
			<!-- 로고들어가는 곳 -->
			<div id="logoo">
				<a href="../index.jsp"><img src="../images/logoo.png"></a>
			</div>
			<!-- 로고들어가는 곳 -->
			<nav id="top_menu">
				<ul id="navigation">
					<li><a href="../index.jsp">상의</a></li>
					<li><a href="../pants.jsp">하의</a></li>
					<li><a href="../shoes.jsp">신발</a></li>
					<li><a href="../acc.jsp">ACC</a></li>
					<li><a href="../center/notice.jsp">게시판</a></li>
				</ul>
			</nav>
		<!-- 본문들어가는 곳 -->

		<!-- 왼쪽메뉴 -->
		<nav id="sub_menu">
			<ul>
				<li><a href="../center/notice.jsp">게시판</a></li>
				<li><a href="#">서비스</a></li>
			</ul>
		</nav>
		<!-- 왼쪽메뉴 -->

		<!-- 게시판 -->
		<%
			
		
			//게시판에 새글을 추가 했다면.. notice.jsp페이지에
			//DB에 저장된 새글 정보를 검색하여 가져와서 글리스트 목록을 아래에 출력 해주어야 함.
			BoardDAO boardDAO = new BoardDAO();

		
			//게시판(board테이블)에 저장되어 있는 전체 글개수 검색해서 얻기
			int count = boardDAO.getfileBoardCount();	 
			
			//한페이지에 보여줄 글 개수 5개로 지정
			int pageSize = 5;
			
			//notice.jsp화면의 아래쪽 페이지번호를 클릭시..클릭한 페이지 번호 받아오기
			String pageNum = request.getParameter("pageNum");
			
			
			//notice.jsp화면 요청시..아래쪾의 페이지번호를 클릭 하지 않은 상태이다..
			//이럴때는 현재 클릭한 페이지 번호가 없으면? 현재 보여지는 페이지를 1페이지로 지정
			if(pageNum == null){
				pageNum = "1";
			}
			
			//위의 pageNum변수값을 정수로 변환 해서 저장
			int currentPage = Integer.parseInt(pageNum);
			
			//-------------------------------------------------------------
			
			//각페이지 마다... 첫번째로 보여질 시작 글번호 구하기 
			//(현재 보여지는 페이지번호  - 1) * 한페이지당 보여줄 글개수 5
			int startRow = (currentPage - 1) * pageSize;
			
			//board테이블에서 검색한 글의 정보를 저장할 용도의 
			//List인터페이스 타입의 변수 list선언
			List<BoardBean> list = null;
			
			//만약 board테이블에 글이 존재 한다면
			if(count > 0){
				
				//board테이블에 모든 글 검색
				//(각페이지 마다 맨위에 첫번째로 보여질 시작 글번호, 한페이지당 보여줄 글개수)
				list = boardDAO.getfileBoradList(startRow,pageSize);
				
			} 	
		%>		
		<article>
			<h1>고객리뷰[글개수 : <%=count %>]</h1>
			<table id="notice">
				<tr>
					<th class="tno">No.</th>
					<th class="ttitle">Title</th>
					<th class="twrite">Writer</th>
					<th class="tdate">Date</th>
					<th class="tread">Read</th>
				</tr>
		<%
			if(count > 0){//게시판에 글이 존재 하면
				//ArrayList사이즈 만큼 반복 (BoardBean객체 개수 만큼)
				for(int i=0;  i<list.size(); i++){
					//ArrayList배열의 각 인덱스 위치에 저장된  BoardBean객체 얻기
					BoardBean bean = list.get(i);
		%>			
				<tr onclick="location.href='review_content.jsp?num=<%=bean.getNum()%>&pageNum=<%=pageNum%>'">
					<td><%=bean.getNum()%></td>
					
					<td class="left">
					<%
						int wid = 0; // 답변글에 대한 들여쓰기값 저장
						
						if(bean.getRe_lev() > 0){ // 답변글에 대한 들여쓰기 값이 0보다 크다면?
							wid = bean.getRe_lev() * 10;
							
						
						
					%>
					<img src="../images/center/level.gif" width="<%=wid%>" height="15">
					<img src="../images/center/re.gif">
					
					<%
					}
					%>
					
					<%=bean.getSubject() %>
					</td>
					
					<td><%=bean.getName() %></td>
					<td><%= new SimpleDateFormat("yyyy/MM/dd").format(bean.getDate())%></td>
					<td><%=bean.getReadcount() %></td>
				</tr>	
		<%						
				}
			}else{
		%>		
				<tr>
					<td cospan="5">게시판 글 없음</td>	
				</tr>
		<%		
			}
		%>
				
				
			</table>
			
			<%
				//각각 페이지에서 로그인후.. 현재 게시판페이지로 이동 해 올 떄..
				//session영역은 유지가 됨.
				//session영역에 저장되어 있는 값이 있냐 업냐에 따라..
				//글쓰기 버튼을 보이게 보이지 않게 설정 하자.
				String id = (String)session.getAttribute("id");
				
				//session영역에 값이 저장되어 있으면.. 글쓰기 버튼을 만들어 보이게 설정
				if(id != null){
			%>		
					<div id="table_search"> 
						<input type="button" value="글쓰기" class="btn" onclick="location.href='review_write.jsp'">
					</div>		
			<%	
				}
			%>
					<div id="table_search">
						<input type="text" name="search" class="input_box"> 
						<input type="button" value="검색" class="btn">
					</div>
			<div class="clear"></div>
			
			<div id="page_control">
			<%
				if(count > 0){
					// 전체 페이지 수 구하기
					// 예) 글20개 -> 한페이지당 보여줄 글수 10개 => 2개의 페이지
					// 예) 글25개 -> 한페이지당 보여줄 글수 10개 => 3개의 페이지
					// 전체 페이지수 = 전체글 / 한페이지당 보여줄 글수 + (전체글수를 한페이지에 보여줄 글수로 나눈 나머지값)
					int pageCount = count/pageSize + (count%pageSize == 0? 0:1);

					// 하나의 화면에 보여질 페이지 수 설정
					int pageBlock = 2;
					
					// 시작 페이지 번호 구하기
					// 1~10 => 1	11~20 => 11		21~30 => 21
					// ( (아래쪽에 클릭한 페이지 번호 / 한화면에 보여줄 페이지수) -
					// 	(아래쪽에 클릭한 페이지 번호를 한화면에 보여줄 페이지수로 나눈 나머지값) )	
					// * 하나의 화면에 보여줄 페이지수 + 1 
					int startPage = ( (currentPage/pageBlock) - (currentPage%pageBlock==0? 1:0) ) * pageBlock +1;
					
					
					// 끝페이지 번호 구하기
					// 1~10 => 10	11~20 => 20		21~30 => 30
					// 시작페이지번호 + 현재블럭(한화면)에 보여줄 페이지수 -1
					int endPage = startPage + pageBlock -1;
					
					// 끝페이지 번호가 전체페이지 수 보다 클때..
					if(endPage > pageCount){
						// 끝페이지 번호를 전체 페이지수로 저장
						endPage = pageCount;
						
					}
					// [이전] 시작페이지 번호가 한화면에 보여줄 페이지 수보다 클때..
					if(startPage > pageBlock){
					%>	
						<a href="info.jsp?pageNum=<%=startPage-pageBlock%>">[이전]</a>
												
					<%		
					}
					// [1] [2]... 페이지번호 나타내기
					for(int i=startPage; i<=endPage; i++){
					%>
					
						<a href="info.jsp?pageNum=<%=i %>">[<%=i %>]</a>
					
					<%
					}
					// [다음] 끝페이지 번호가 전체페이지 수보다 작을때..
					if(endPage < pageCount){
					%>	
						<a href="info.jsp?pageNum=<%=startPage+pageBlock%>">[다음]</a>
						
						
					<%	
					}
					
					
				}
			
			
			%>			


			</div>
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