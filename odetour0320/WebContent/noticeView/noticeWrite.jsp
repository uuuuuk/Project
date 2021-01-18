<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../totalScriptCSS.jsp" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% request.setCharacterEncoding("UTF-8"); %> 
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  /> 

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>NOTICE WRITE</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" initial-scale="1">
	
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	/* 게시글 공백 체크 */
	function Check()
	{
	 var form = document.noticeForm;
	 
	 if( !form.title.value )  
	 {
	  alert( "제목을 입력 하세요." ); 
	  form.title.focus();  
	  return;
	 }else if( !form.content.value )
	 {
	  alert( "내용을 입력 하세요." );
	  form.content.focus();
	  return;
	 
	 }else{
		form.submit();
		return true;;
	 }	
	 
	} 
	/* 목록 보기 */
	function NoticeList(obj){
		obj.action="${contextPath}/main/listNotice.do";
		obj.submit();
	}
</script>

<style type="text/css">
	#noticeWrite {font-family: sans-serif; font-size: 32px; color: teal; }
</style> 
</head>
	
<body>
	<!-- INCLUDE Header -->
	<jsp:include page="../inc/header.jsp"></jsp:include>
	<br>
	<section id="intro">
		<div class="container">
			<div align="center">
				<div class="col-lg-3 col-lg-offset-3 col-md-8 col-md-offset-2 text-center">
					<div class="intro animate-box" style="border-bottom:1px solid;">
						<h2 id="noticeWrite">N O T I C E</h2>
					</div><br>
				</div>
			</div>
		</div>
	</section><br>
	<div class="container">
		<form name="noticeForm" method="post" action="${contextPath}/main/addNotice.do" onSubmit="Check(); return false">
			<table class="table" style="margin-left:auto; margin-right:auto; width:80%; text-align:center;" >
				<input type="hidden" name="email" value="admin@odetour.com">
				<tr>
					<td style="width: 130px; text-align:left; border-top:none; padding-top:10px;">
						<i class="far fa-check-circle fa-lg mr-2 ml-2"></i><b>작 성 자</b>
					</td>
					<td style="width: auto; text-align:left; border-top:none; padding:0">
						<input class="form-control" name="writer" type="text" value="${sessionScope.name}" readonly
						style="padding-top:0px; padding-bottom:0px; border:none !important; width:300px; background-color:#ffffff; color:#000067; text-transform:uppercase;"/>
					</td>
				</tr>
				<tr>
					<td style="width: 130px; text-align:left; border-top:none; padding-top:6px; padding-bottom:10px;">
					<i class="far fa-check-circle fa-lg mr-2 ml-2"></i><b>공지사항</b>
				</td>
					<td style="width: auto; text-align:left; border-top:none; padding-top:0px; padding-left:0px; padding-bottom:5px;">
						<input class="form-control" name="title" type="text" placeholder="40자 이내로 입력" maxlength="40" 
						style="padding-top:0px; border:none !important; width:600px; background-color:#ffffff;"/>
					</td>
				</tr>
				<tr>
					<td style="width: 130px; text-align:left; border-top:none; padding-top:5px;">
					<i class="far fa-check-circle fa-lg mr-2 ml-2"></i><b>공지내용</b>
				</td>
					<td style="border-top:none; width:auto; text-align:left; padding-top:4px;">
						<textarea class="form-control" name="content" rows="15" cols="90" placeholder="공지사항 내용 입력" maxlength="2048" style="padding-left:0px; padding-top:0px; border:none; height: 350px;"></textarea>
					</td>
				</tr>
			</table>	
				
			<div style="width:900px; text-align:right;">
			<input type="submit" class="btn btn-info active" value="작성완료" />
			<input type="button" class="btn btn-info active" value="목록보기" onClick="NoticeList(this.form)" />
			</div>
				
		</form>

		</div><br><br><br>

	<!-- INCLDUE FOOTER -->
    <jsp:include page="../inc/footer.jsp"></jsp:include>

</body>
</html>