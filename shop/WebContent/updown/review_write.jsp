
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%
	// Session영역에 저장되어 있는 값
	// 얻는 이유 : 글쓰기 화면에 글작성자의 이름을? id로 출력 하기
	String id = (String)session.getAttribute("id");		
	// session 영역에 값이 저장되어 있지 않으면?
			if(id == null){ // 로그인 페이지로 
				response.sendRedirect("../member/login.jsp");
			}
	%>
		
	


		
		<!-- 게시판 -->
		<article>
			<h1>review Write</h1>
			<form action="review_writePro.jsp" method="post" enctype="multipart/form-data">
			<table id="review">
				<tr>
					<td>아이디</td>
					<td> <input type="text" name="id" value="<%=id %>" readonly> </td>
				</tr>
				
				<tr>
					<td>비밀번호</td>
					<td> <input type="password" name="passwd"> </td>
				</tr>
				
				<tr>
					<td>파일선택</td>
					<td> <input type="file" name="File"> </td>
				</tr>
				
				
				<tr>
					<td>글제목</td>
					<td> <input type="text" name="subject"> </td>
				</tr>
				
				<tr>
					<td>글내용</td>
					<td><textarea rows="13" cols="50" name="content"></textarea></td>
				</tr>
				
				
			</table>
			
			
				
				<div id="table_search">
				<input type="submit" value="리뷰쓰기" class="btn"> 
				<input type="reset" value="다시작성" class="btn">
				<input type="button" value="글목록" class="btn" onclick="location.href='updown/info.jsp'">
			</div>
			</form>
			</article>
			<div class="clear"></div>
		
		
		
		
		
		
		
		
		
		
		
		

</body>
</html>