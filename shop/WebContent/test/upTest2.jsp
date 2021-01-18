
<%@page import="board.BoardDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="board.BoardBean"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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
		
	
		// session값 얻기
		String id = (String)session.getAttribute("id");

		// session값이 저장되어 있지 않다면 .. login.jsp로 이동
		if(id == null){
			response.sendRedirect("../member/login.jsp");
			
		}
		// 한글처리
		request.setCharacterEncoding("UTF-8");
	%>	
	<% 	
		/* String name = request.getParameter("name");
		String passwd = request.getParameter("passwd");
		String file = request.getParameter("file");
		String subject = request.getParameter("subject");
		String content = request.getParameter("content"); 
		
		BoardBean bBean = new BoardBean();
		
		bBean.setName(name);
		bBean.setPasswd(passwd);
		bBean.setFile(file); 
		bBean.setSubject(subject);
		bBean.setContent(content);
		
		 BoardBean b = new BoardBean();*/
	%>	 
		 <jsp:useBean id="bBean" class="board.BoardBean"/>
		 <%-- request객체에서 꺼내온 모든값을? 
			BoardBean객체의 모든 setter메소드 호출하여 모든 변수에 저장 --%>
		 <jsp:setProperty property="*" name="bBean"/>
	
	
	
	<%	 
		// 1.2.1 현재 글쓴 날짜, 시간정보... 를 추가로 BoardBean에 저장
			bBean.setDate(new Timestamp(System.currentTimeMillis()));
			
			// 1.2.2 글쓴사람의 ip주소를 추가로 BoardBean에 저장
			bBean.setIp(request.getRemoteAddr());
			
			
			// 2. jspbeginner데이터베이스의 board테이블에 우리가 입력한 새글 정보를 INSERT
			BoardDAO bdao = new BoardDAO(); // DB작업
			
			// DB의 board테이블에 새글 정보를 INSERT하기 위해
			// inserBoard(BoardBean bean)메소드 호출시...
			// 매개변수 인자로.. BoardBean객체 전달
			bdao.inserBoard(bBean); 
			
			// info.jsp를 재요청(포워딩) 해 이동 // 웹브라우저 거쳐서 재요청
			response.sendRedirect("info.jsp");
			
			
			
			
		///////////////////////////////////////////////////////	
		
		
		
		
		//현재 실행중인 웹프로젝트애 대한 정보들이 저장되어 있는 객체 얻기
		ServletContext ctx = getServletContext();
		
		//실제 파일이 업로드되는 경로 얻기
		String realPath = ctx.getRealPath("/upload");
	
		out.println(realPath);
		
		//업로드할 수 있는 파일의 최대사이즈 지정 10MB
		int max = 10 * 1024 * 1024;
		String fileName = "";
		String originalFileName = "";
		
		
		//실제 파일 업로드 
		// 1. request : form태그에서 요청한 데이터가 저장된 request를 전달
		// 2. realPath : 업로드될 파일의 위치를 의미
		// 3. max : 최대 크기
		// 4. "UTF-8"  : 업로드된 파일 이름이 한글일 경우 문제가 되므로 인코딩 방식 지정
		// 5. new DefaultFileRenamePolicy() : 
		// 업로드될 경로에 이미 업로드된 파일이름이 동일할경우
		// 파일이름 중복 방지를 위해 파일이름을 자동으로 변환 해주는 객체 전달
		MultipartRequest multi 
		= new MultipartRequest(request,
							 realPath,			//"D://upload",
							 max,
							 "UTF-8",
							 new DefaultFileRenamePolicy());
		
	
		
		// basic.html페이지에서 파일업로드를 위해 선택한 
		// <input type="file" name="upFile1">
		// <input type="file" name="upFile2">
		// <input type="file" name="upFile3">
		// .. name 속성값을 모두 Enumeration인터페이스의 자식배열객체에 담아..
		// 자식 배열 객체를 반환 해서 e변수에 저장
		Enumeration e = multi.getFileNames();
		// Enumeration 인터페이스 타입 //Enumeration자식객체(배열)를 받는다(반복) 
		
		
		// Enumeration인터페이스의 자식배열객체에 데이터가 존재 하는 동안 반복
		while(e.hasMoreElements()){
			
			
			out.println("클라이언트가 업로드한 파일의 원본 이름 : "
					+ multi.getOriginalFileName(bBean.getName()) + "<br>");
				
			out.println("서버경로에 실제로 업로드된 파일의 이름 : "
					+ multi.getFilesystemName(bBean.getName()) + "<br>");
			
			// 서버경로에 업로드된 파일에 접근 하기 위해.. File객체 얻기
			File f =  multi.getFile(bBean.getName());
			out.println("업로드된 파일의 사이즈 : " + f.length() + "byte<br>");
		}
		
		
	%>


		<!--  파일요청받은거 처리하는 페이지  -->


</body>
</html>