<%@page import="java.util.Enumeration"%>
<%@page import="java.util.ArrayList"%>
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
	<%-- 
		multi.jsp의 2번 폼태그에서 요청한 텍스트데이터 + 업로드할 파일정보는?
		request내장객체 영역에 저장되어 유지 되고 있다.
		request내장객체 영역에 저장된 요청 값 얻기
	 --%>
	
	<%
		// 한글처리
		request.setCharacterEncoding("UTF-8");
		/* response.setContentType("text/html;charset=utf-8"); */
		// 업로드될 실제 서버 경로 얻기
		String realFolder = getServletContext().getRealPath("/upload");
		//out.println(realFolder);
	
		// 업로드 할 수 있는 파일의 최대 크기 지정 10MB
		int max = 10 * 1024 * 1024;
		
		//실제 파일 업로드 담당 객체 생성 하여 다중 파일 업로드 처리
		MultipartRequest multipartRequest = 
					new MultipartRequest(request, realFolder, max, 
										"UTF-8", new DefaultFileRenamePolicy());
		// 다중파일 업로드 후 ..
		// 우리가 입력한 텍스트 값 얻기
		String name = multipartRequest.getParameter("name");
		String addr = multipartRequest.getParameter("addr");
		String note = multipartRequest.getParameter("note");
	
		
		// 서버에 실제로 업로드된 파일의 "이름"을 저장할 컬렉션프레임워크에 속해 있는 
		// ArrayList가변길이 객체 배열 생성
		ArrayList saveFiles = new ArrayList();
		
		// 클라이언트가 서버에 실제로 업로드 하기전의 원본파일명을 저장할 용도의 ArrayList객체 생성
		ArrayList originFiles = new ArrayList();
		
		// multi.jsp페이지에서.. 파일 업로드를 하기 위해 선택했던
		// <input type="file" name="upFilex"> 태그들 중
		// name속성값들을 모두 Enumeraction인터페이스의 자식배열 객체에 담아
		// Enumeraction인터페이스의 자식 배열 객체 자체를 반환 받는다.
		Enumeration e =  multipartRequest.getFileNames();
		
		while(e.hasMoreElements()){
			
			// <input type="file">인? 태그의 name속성값을 하나씩 꺼내어 얻는다.
			Object obj = e.nextElement();
			String filename = (String)obj;
			
			// 서버에 실제로 업로드된 파일의 이름을 하나씩 얻어 ArrayList가변길이 배열에 담기
			saveFiles.add(multipartRequest.getFilesystemName(filename));
			
			// 클라이언트가 업로드한 파일의 원본이름을 하나씩 얻어 ArrayList가변길이 배열에 담기
			originFiles.add(multipartRequest.getOriginalFileName(filename));
			
		}
		
	%>
		<ul>
			<li>이름 : <%=name %></li>
			<li>주소 : <%=addr %></li>
			<li>하고 싶은 말 : <%=note %></li>
		</ul>
		<hr/>
		업로드된 파일 리스트<br>
		<ul>
			<%
				for(int i=0; i<saveFiles.size(); i++){
			%>
					<%-- 업로드된 파일을 다운로드 하기 위해.. 
							다운로드 로직을 처리할 dowonload.jsp로 다운로드 요청함 --%>
				
					<a href="download.jsp?path=upload&name=<%=saveFiles.get(i)%>">
						<li><%=originFiles.get(i) %></li>
					</a>
			<%		
				}
			
			%>
		
		
		
		</ul>





</body>
</html>