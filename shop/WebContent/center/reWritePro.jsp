<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%
		// 한글처리
		request.setCharacterEncoding("UTF-8");
	
		// reWrite.jsp에서 입력한 답글 내용 + 주글에 대한 정보를 request영역에서 얻어
		// BoardBean객체의 각변수에 저장	
	%>
		<jsp:useBean id="bBean" class="board.BoardBean"/>
		<jsp:setProperty property="*" name="bBean"/>
	<%
		// 추가로 .. 답글을 작성한 사람의 IP주소를 BoardBean의 변수에 저장
		bBean.setIp(request.getRemoteAddr());
	
		// 답글 추가 DB작업을 위한 BoardDAO객체 생성 후 메소드 호출!
		BoardDAO bdao = new BoardDAO();
		
		// 메소드 호출시.. (답변글내용 + 주글에 대한 정보가 저장되어 있는 BoardBean객체 전달함)
		bdao.reInsertBoard(bBean); 
	
		// 포워딩! notice.jsp
		response.sendRedirect("notice.jsp");
	
	
	%>



</body>
</html>