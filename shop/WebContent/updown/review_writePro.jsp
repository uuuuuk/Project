<%@page import="java.util.Enumeration"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="board.BoardBean"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
	String name = multipartRequest.getParameter("id");
	String passwd = multipartRequest.getParameter("passwd");
	String file = multipartRequest.getFilesystemName("File");
	String subject = multipartRequest.getParameter("subject");
	String content = multipartRequest.getParameter("content");
	
	//리뷰내용을 BoardBean객체에 저장 
	BoardBean bean = new BoardBean();
	
	bean.setName(name);
	bean.setPasswd(passwd);
	bean.setFile(file);
	bean.setSubject(subject);
	bean.setContent(content);
	

	
	//BoardDAO객체의 setfileBoard에 리뷰내용이 들어있는 bean객체를 넣어서 DB에 저장
	BoardDAO dao = new BoardDAO();
	dao.setfileBoard(bean);

	//등록이 끝났으면 리뷰게시판으로 돌아간다.
	response.sendRedirect("info.jsp");
%>

