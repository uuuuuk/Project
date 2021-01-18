<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
    	<h1>deletePro.jsp</h1>
    	
	<%
		// 한글처리
		request.setCharacterEncoding("UTF-8");
	
		// 1. 요청값 얻기 (delete.jsp페이지에서 요청한 값)
		int num = Integer.parseInt(request.getParameter("num"));
		String pageNum = request.getParameter("pageNum"); // 삭제할 글이 속해 있는 페이지 번호
		String passwd = request.getParameter("passwd"); // 글삭제를 위해 입력한 글에 대한 비밀번호
		
		
		// 2. 요청값을 얻어 응답값 마련(글 삭제에 성공? 실패? 관련 응답 메세지)
		BoardDAO bdao = new BoardDAO();
		// 글삭제 DELETE작업 메소드 호출
		int check = bdao.deleteBoard(num,passwd); // 삭제할 글번호, 삭제를 위해 입력했던 글의 비밀번호
		 
		// 글삭제 DELETE에 성공하면 1을 반환, 실패하면 0을 반환
		
		if(check == 1){ // 글 삭제했다
	%>	
			<script type="text/javascript">
			alert("삭제성공");
			location.href = "notice.jsp?pageNum=<%=pageNum%>";
		
		</script>	
			
			
	<%		
		}else{ // 삭제 실패
	%>		
		<script>
			alert("비밀번호 틀림")
			history.back(); // 이전 delete.jsp로 이동
		</script>	
		
		
			
	<%		
		}
	
	
	
	%>
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	