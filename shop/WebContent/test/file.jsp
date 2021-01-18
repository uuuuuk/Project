<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

		<script type="text/javascript">
		/*
			두번째 form태그에 저의는 업로드될 파일 개수를 사용자에 의해서 동적으로 입력 받기 때문에
			두번째 form태그 내부의 for문을 이용하여 <input type="file">태그가 동적으로 만들어짐
			동적으로 만들어진 <input type="file"> 태그중에서 .. 업로드할 파일 경로를 지정 하지 않은?
			<input> 태그가 존재 한다면..
			x번째 파일 정보가 누락되었습니다 라고~ 경고 메세지창을 띄워 줘야 합니다.		
		*/
		
		function Check(f) {
			// 두번째 form태그에 접근하여 form태그 내부에 있는 모든 input태그의 개수 구하기
			// forms[] 배열 : <form>태그에 접근 하는 방법
			// elements : <form>태그 내부에 존재하는 모든 <input>태그들을 말함 : 배열
			// length : 개수, 길이
//			var cnt = document.forms[1].elements.length; 
			var cnt = f.elements.length; 
			// 두번째 폼태그 1번 인덱스위치.
			/*
				위 cnt변수에 들어갈 <input>태그의 개수에 대한 설명!
				-> 두번째 <form>태그에 고정된 <input type="hidden"> 3개,
									  <input type="button"> 1개 이므로..
								총 4개의 <input>태그가 고정으로 만들어져 있다.
			
			*/
			
			//누락된 파일 업로드 위치를 나타낼 변수 선언
			var filecnt = 1;
				
			// 두번째 form태그 내부의 모든 <input>태그의 개수만큼 반복					
			for(i=0; i<cnt; i++){
				
				// 만약에 두번째 <form>태그 내부에 있는 <input>태그의 type속성값이 file 이고
//				if(document.forms[1].elements[i].type == "file"){
				if(f.elements[i].type == "file"){
					
					// 만약에 <input type="file">인 태그들 중에서..
					// 업로드할 파일을 선택하지 않은 태그가 존재 한다면
//					if(document.forms[1].elements[i].value == ""){
					if(f.elements[i].value == ""){
						
						// x번째 <input type="file"> 내용이 비었습니다. 라고 경고메세지 띄우기
						var msg = filecnt + "번째 파일 정보가 누락 되었습니다.\n 올바른 선택을 해주세여";
						alert(msg);
						// 파일 업로드시 선택하지 않은 <input>태그에 포커스 주기
//						document.forms[1].elements[i].focus();
						f.elements[i].focus();
						// for반복문 빠져 나감
						return;
						
					} // 안쪽 if
					
					filecnt++; // 1씩 증가 => <input type="file">일때만 .. ++
					
				} // 바깥 if
				
			} // for문
			
			// 두번째 form태그 다중파일 업로드 요청 전송!
//			document.forms[1].submit();
			f.submit();
			
		}
		
			</script>


</head>
<body>

	<%--
		스토리 설명 : 
		여러개의 파일을 업로드 할 수 있도록 여러개의 <input type="file">태그를 생성 하는데
		이왕이면 딱 정해진 개수를 생성 하는것 보다 내가 원하는 개수만큼 늘려서 파일 업로드를 해보자.
	
	 --%>
	
	<%
		// [1번 폼]에서 입력하여 요청한 데이터는 request영역에 저장되어 있으므로..
		// 한글처리
		request.setCharacterEncoding("UTF-8");	
	%>
	
	<%!
		// [1번 폼]태그의 input태그의 value=""에서 호출하는 메소드 만들기
		public String getParam(HttpServletRequest request, String param){
			// 매개변수로 전달 받은 request객체에 데이터가 저장되어 있을 경우
			if(request.getParameter(param) != null){
				return request.getParameter(param);
				
			}else{
				return "";
			}
				
	}
	
	
	%>


	<%-- [1번 폼] : 업로드할 파일수를 입력받아.. filePro.jsp 서버페이지로 요청함 --%>
	<form action="file.jsp" enctype="multipart/form-data">
		이름 : <input type="text" name="name" value='<%=getParam(request, "name")%>'> <br>
		주소 : <input type="text" name="addr" value='<%=getParam(request, "addr")%>'> <br>
		하고싶은 말 : <br>
		<textarea rows="3" cols="70" name="note"><%=getParam(request, "note") %></textarea> <br>
		업로드할 파일수 입력 : <input type="text" name="add" size="2">
		<input type="submit" value="확인">
	</form>

	
	<%
		// 업로드할 파일 수를 저장할 변수
		int filecnt = 0;
	
		// [1번 폼]태그에서 입력한 파일수가 존재하면..
		if(request.getParameter("add") != null){
			
			// 입력한 파일수를 받아와 저장 (스트링타입을 인트타입으로 변환하기 위해)
			filecnt = Integer.parseInt(request.getParameter("add"));
			
		}
	
	%>
	
	<%-- [2번폼] : 
		 [1번폼]에서.. 입력한 업로드할 파일수를 전달 받아..  
		  업로드할 파일 수만큼 for문을 이용하여 <input type="file">태그를 반복해서 만들어서
		 [2번폼]태그를 이용하여 다중 파일 업로드를 요청 함.	
	--%>
	<form action="../center/fileboard.jsp" enctype="multipart/form-data" method="post">
	
		<input type="hidden" name="name" value='<%=getParam(request, "name")%>'>
		<input type="hidden" name="addr" value='<%=getParam(request, "addr")%>'>
		<input type="hidden" name="note" value='<%=getParam(request, "note")%>'>
	
	<%
		for(int i=0; i<filecnt; i++){
	%>		
			<%=i+1 %>번째 파일 선택 :<input type="file" name="upFile<%=i%>"> <br>	
			
	<%		
		}
	
	%>
			<input type="button" value="다중 파일 업로드 요청" onclick="Check(this.form);">
	</form>



</body>
</html>