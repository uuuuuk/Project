<%@page import="java.io.BufferedOutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.BufferedInputStream"%>
<%@page import="java.io.File"%>
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
		
			// multi_pro.jsp페이지로부터 다운로드 요청 받은 값들 얻기
			// 1. 업로드된 파일(다운로드할 파일)의 가상경로 값
			String path = request.getParameter("path");
			
			// 2. 업로드된 파일의 실제이름 (다운로드할 파일의 실제이름)
			String name = request.getParameter("name");
			
			// 실제 파일을 다운로드할 경로 얻기
			// 가상경로 upload를 이용하여 -> 다운로드할 실제 서버의 경로 구하기
			String realPath = getServletContext().getRealPath("/"+path);
			// out.println(realPath);
		
			
			
			/*
				(설명)
				실행 가능한 파일일 지라도 무조건 다운로드 받게 처리 해야 하는데..
				그러기 위해서는 지금 까지는? 클라이언트 <---응답(파일) --- 서버 할때..
				응답데이터 + 응답할 파일 데이터에 대한 헤더정보(어떤형식, 누구한테 전달, 어떻게 만들어졌고, 응답데이터크기)
				등등... 응답할 파일 데이터의 헤더 정보 또한 같이 클라이언트의 웹브라우저에 전달 해야함..
			*/
			
			
			// 다운로드할 파일을 서버에서 클라이언트의 웹브라우저에 내보내기 전에..
			// response객체에 헤더 정보를 설정
			// 다운로드 문서형식으로 내보내겠다고 수정하기
			response.setContentType("Application/x-msdownload");
			// 클라이언트의 웹브라우저는 위의 코드를 인식함
			
			// 이미 정해져 있는 헤더정보를 담는 Content-Disposition변수 값을? 다운로드 시킬 파일이름으로 지정
			response.setHeader("Content-Disposition", "attachment;filename="+ name);
			
			// 업로드된 파일이 존재하는 서버 경로에 다운로드할 파일에 직접적으로 접근 할 수 있는 File객체 생성
			File file = new File(realPath + "/" + new String(name.getBytes("8859_1"),"UTF-8"));
			
			// 서버경로에 존재 하는 ㅠㅏ일의 내용을 읽어 들일 단위인? 1024바이트 배열 선언
			byte[] data = new byte[1024];
			
			// 응답할 데이터가 파일 형식이 맞다면?
			if(file.isFile()){
				// 입출력시 예외처리 필수!
				try{
					// 서버경로에 존재하는 다운로드 할 파일의 내용을 읽어 들이기 위한 스트림 통로 준비
					// new FileInputStream(file);
						// 다운로드할 실제 File객체가 가리키는 파일의 내용을? 1바이트 단위로 읽어 들여
						// 버터 메모리에 저장하기 위한 스트림 통로 만들기
					// new BufferedInputStream(new FileInputStream(file));
						// File객체가 가리키는 파일의 내용 모두를 1바이트씩 1바이트씩 읽어 들여
						// 별도의 버퍼 메모리에 저장해 두었다가...
						// 한번에 파일 전체의 내용을 버퍼에서 읽어 들이기 위한 스트림 통로 만들기
					BufferedInputStream input = 
						new BufferedInputStream(new FileInputStream(file));
					
					// 읽어들인 다운로드할 파일의 내용을 버퍼공간에서 내보내기(다운로드 시킬) 스트림 통로 준비
					// 참고: 별도의 출력 내부버퍼 공간을 가지고 있음
					BufferedOutputStream output = 
						new BufferedOutputStream(response.getOutputStream());
					
					// 파일의 내용을 1024바이트 배열의 크기만큼 읽어 들여 저장할 변수
					int read;
					
					// 파일의 내용을 1024바이트씩 끊어서 읽어 들여 내부 버퍼에 저장 하는데..
					// 읽어 들인 파일의 내용이 존재 하는 동안 반복
					while((read = input.read(data)) != -1){ // read()메소드릐 반환값은
															// 읽어들이기에 성공한 바이트수를 반환
															// 읽어들이기에 실패하면 -1을 반환
	
						// 출력 스트림 통로를 통해 파일로 부터 읽어 들인값을 출력(응답, 내보내기) 해야함
						// 전체 data배열의 0부터 1024바이트씩 묶어서 출력 버퍼에 내보낸다.
						output.write(data, 0, read);
						
					} // 반복
					
					
					// 출력 버퍼 공간이 가득 차지 않아도 파일 내용을 강제적으로 사용자의 웹브라우저 화면에 내보내기
					output.flush();
					// 자원 닫기
					output.close();
					input.close();
					
					
				}catch(Exception err){
					err.printStackTrace();
					
				}
				
				
			}
			
		%>


</body>
</html>