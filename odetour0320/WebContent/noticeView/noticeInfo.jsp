<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../totalScriptCSS.jsp" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% request.setCharacterEncoding("UTF-8"); %> 
<c:set var="contextPath" value="${pageContext.request.contextPath}" /> 

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>NOTICE INFO</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" initial-scale="1">

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	function NoticeList(obj){
	   	obj.action="${contextPath}/main/listNotice.do";
	   	obj.submit();
	}
</script>

<style type="text/css">
	#noticeContent {font-family: sans-serif; font-size: 32px; color: teal;}
</style>
</head>
	
<body>
	<!-- INCLUDE HEADER -->
	<jsp:include page="../inc/header.jsp"></jsp:include>
	<br>
	<section id="intro">
		<div class="container">
			<div align="center">
				<div class="col-lg-3 col-lg-offset-3 col-md-8 col-md-offset-2 text-center">
					<div class="intro animate-box" style="border-bottom:1px solid;">
						<h2 id="noticeContent">N O T I C E</h2>
					</div><br>
				</div>
			</div>
		</div>
	</section><br>
	<div class="container">
		<form name="articleForm" method="post">
		<table class="table table-striped" id="notice" style="margin-left:auto; margin-right:auto; width:80%; text-align:center; font-size: 20px;" >
			<tr>
				<td style="border-top:none; width:25%; text-align:left;"><i class="far fa-check-circle fa-lg mr-2 ml-5"></i><b>공지No.</b></td>
				<td style="border-top:none; width:25%; text-align:left;"><b>No.${num}</b></td>
				<td style="border-top:none; width:25%; text-align:left;"><i class="far fa-check-circle fa-lg mr-2 ml-5"></i><b>조회수</b></td>
				<td style="border-top:none; width:25%; text-align:left;"><b>${noticeView.readCount}</b></td>
			</tr>
			<tr>
				<td style="border-top:none; width:25%; text-align:left;"><i class="far fa-check-circle fa-lg mr-2 ml-5"></i><b>작성자</b></td>
				<td style="border-top:none; width:25%; text-align:left;"><b>${noticeView.writer}</b></td>
				<td style="border-top:none; width:25%; text-align:left;"><i class="far fa-check-circle fa-lg mr-2 ml-5"></i><b>작성일</b></td>
				<td style="border-top:none; width:25%; text-align:left;"><b>${noticeView.writeDate}</b></td>
			</tr>
			<tr>
				<td style="border-top:none; width:25%; text-align:left;"><i class="far fa-check-circle fa-lg mr-2 ml-5"></i><b>공지제목</b></td>
				<td colspan="3" style="border-top:none; width:25%; text-align:left;"><b>${noticeView.title}</b></td>
			</tr>
			<tr>
				<td style="border-top:none; width:25%; text-align:left;"><i class="far fa-check-circle fa-lg mr-2 ml-5"></i><b>공지내용</b></td>
				<td colspan="3" height="400" style="border-top:none; width:25%; text-align:left;"><b>${noticeView.content}</b></td>
			</tr>
		</table>
			
		<div style="text-align:right; margin-right:150px;">
			<c:if test="${sessionScope.name eq 'admin'}"> 
				<input type="button" class="btn btn-info active" value="삭제하기" onclick="location.href='${contextPath}/main/deleteNotice.do?idx=${noticeView.idx}'"/>
		 	</c:if> 
			<input type="button" class="btn btn-info active" value="목록보기" onClick="NoticeList(this.form)" />
		</div>
		</form>
	</div>
    <br>
    <!-- INCLUDE FOOTER -->
    <jsp:include page="../inc/footer.jsp"></jsp:include>

</body>
</html>