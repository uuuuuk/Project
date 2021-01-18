<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

	<script type="text/javascript">
		function result(){
// 	사용사능한 ID이면.. 사용함 버튼 눌러.. 부모창인? join.jsp에
// 	 사용가능한 ID값 나타내서 출력 해주기
	// join.jsp창의 아이디 입력란의 값 = 현재 join_IDCheck.jsp창의 입력한 아이디값;
		opener.document.fr.id.value = document.nfr.userid.value;
		
		// 창닫기
		window.close();
		
		}
	
	
	</script>



</head>
<body>
	<%
		 /* 요청값 받기 */
		// 1. join.jsp의 function winopen()함수에 의해서 전달받은 userid값 얻기
		// 2. 아래의 중복확인 버튼 클릭시..<form>태그로 부터 전달받은 userid값 얻기
		String id = request.getParameter("userid");
	
		/* 요청값에 의해 DB작업(DB에 저장된 ID와 우리가 입력한 ID가 동일한지 체크)*/
		MemberDAO mdao = new MemberDAO();
		
		// 3. 입력한 id값을 MemberDAO객체의 idCheck()메소드 호출시..
		//	   매개변수로 전달하여 DB에 저장된 ID와 중복되는지 유무 얻기
		int check = mdao.idCheck(id); // check=1일때 아이디 중복
									//	check=0일때 아이디 중복 아님
									
		// 4. 조건에 의해서 사용자의 웹브라우저에 응답
		if(check == 1){
			out.println("사용중인 ID입니다.");
		}else{
			out.println("사용가능한 ID입니다.");
	%>		
			<%-- 사용사능한 ID이면.. 사용함 버튼 눌러.. 부모창인? join.jsp에
				 사용가능한 ID값 나타내서 출력 해주기
			 --%>
			<input type="button" value="사용함" onclick="result();"/>
		
	<%		
			}
		
	%>





	<form action="join_IDCheck.jsp" method="post" name="nfr">
		아이디 : <input type="text" name="userid" value="<%=id%>" >
		<input type="submit" value="중복확인">
		
	</form>



</body>
</html>