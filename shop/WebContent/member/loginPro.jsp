<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <%
    	// 1. login.jsp에서 입력한 id password request영역에서 꺼내오기
    	String id = request.getParameter("id");
    	String passwd = request.getParameter("passwd");
    	
    	// 2. 입력한 ID와 PASSWORD가 DB에 존재 하는지 유무 체크
    	MemberDAO memberdao = new MemberDAO();
    	
    	// 유무체크를 위한 메소드 호출!
    	// check = 1 -> 아이디, 비밀번호가 DB에 존재
    	// check = 0 -> 아이디맞음, 비밀번호 틀림
    	// check = -1 -> 아이디 틀림
    	
    	int check = memberdao.userCheck(id,passwd); 
    	
    	if(check == 1){ // DB에 저장되어 있는 아이디, 비밀번호가 입력한 아이디, 비밀번호 같을때..
    		// 로그인 화면에서 입력한 아이디를 Session내장객체 메모리에 저장
    		session.setAttribute("id", id);
    		// index.jsp로 포워딩(재요청하여 이동)
    		response.sendRedirect("../index.jsp");
    		
    		
    		
    	}else if(check == 0){ // DB에 저장되어 있는 아이디는 같으나, 비밀번호는 다를때
  %>  		
    	<script>
    	 alert("비밀번호 틀림");
    	 history.go(-1); // 이전 페이지로 이동
    	</script>		
    
    		
   <%		
    	}else{ // check == -1 이므로 아이디를 틀림 -> 이전페이지(login.jsp)로 이동
    		
  %>	
    	<script>
    		alert("아이디 없음");
    		history.back(); // 이전 페이지로 이동
    	
    	
    	</script>	
	    	
   <% 	
    	}
    
   
  
  
  %>
    
    
    
    
    
    
    
    
    
    
    
    
    
    