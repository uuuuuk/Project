<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../totalScriptCSS.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>답변 쓰기</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	function QnAList(obj){
    	obj.action="${contextPath}/qna/qnaList.do";
    	obj.submit();
  	}
</script>
</head>

<body>
<center>
<h2>1:1문의 답글 쓰기</h2>
	
	<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
	
	<%-- ${requestScope.qnaNum } --%>

<form action="${contextPath}/qna/qnaReWrite.do?parentNum=${qnaNum}" method="post">
<table width="600" border="1" bordercolor="gray">
	<tr height="40">
		<td align="center" width="150"> 작성자 </td>
		<td width="400"> <input type="text" name="writer" size="50"></td>
	</tr>
	
	<tr height="40">
		<td align="center" width="150"> 제목 </td>
		<td width="400"> <input type="text" name="title" size="50"></td>
	</tr>
	
	
	<!-- 관리자만 답변 가능하게 해야함 -->
	<tr height="40">
		<td align="center" width="150"> 이메일 </td>
		<td width="400"> <input type="email" name="email" size="50"></td>
	</tr>
	
	<tr height="40">
		<td align="center" width="150"> 글내용 </td>
		<td width="400"> <textarea rows="10" cols="60" name="content"></textarea></td>
	</tr>
	
	<tr height="40">
		<td align="center" colspan="2">
			<input type="submit" value="글쓰기"> &nbsp;&nbsp;
			<input type="reset" value="다시작성"> &nbsp;&nbsp;
			<button onclick="QnAList(this.form)">취소</button>
		</td>
	</tr>

</table>
</form>
</center>



</body>
</html>