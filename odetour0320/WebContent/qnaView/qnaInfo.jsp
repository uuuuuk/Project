<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../totalScriptCSS.jsp" %>       
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% request.setCharacterEncoding("UTF-8"); %> 
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  /> 
<c:set var="sessionEmail" value="${sessionScope.email}"/>
<c:set var="qnaVO" value="${requestScope.QnaReplyMap.qnaVO}"/>
<c:set var="replyVO" value="${requestScope.QnaReplyMap.replyVO}"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>QnAInfo</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" initial-scale="1">

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	window.onload=function(){
		$("#rewriteSubmitBtn").hide();
		$("#rewriteCancelBtn").hide();
	}

	function qnaRewriteBtn(){
		$("#rewriteSubmitBtn").show();
		$("#rewriteCancelBtn").show();
		$("#qnaTitle").attr("disabled",false).attr("enabled",true);
		$("#qnaContent").attr("disabled",false).attr("enabled",true);
		$("#rewriteBtn").hide();
	}
	function qnaRewriteCancelBtn(){
		
		$("#rewriteBtn").show();
		$("#rewriteSubmitBtn").hide();
		$("#rewriteCancelBtn").hide();
		
		$("#qnaTitle").attr("enabled",false).attr("disabled",true);
		$("#qnaContent").attr("enabled",false).attr("disabled",true);
		
		$("#qnaTitle").val('${qnaVO.title}');
		$("#qnaContent").val('${qnaVO.content}');
	}
	function replyWrite(form){
		form.method="post";
		form.action="${contextPath}/main/replyWrite.do";
		form.submit();
	}
</script>

<style type="text/css">
	/* Title */
	#qnaContentTitle {font-family: sans-serif; font-size: 32px; color: teal;}
	/* 답변 확인중 */
	#waitQnaReply
	@-webkit-keyframes flash {from, 50%, to {opacity: 1;} 25%, 75% {opacity: 0;}}
	@keyframes flash {from, 50%, to {opacity: 1;} 25%, 75% {opacity: 0;}}
	#waitQnaReply {-webkit-animation: flash 4s 4s infinite linear alternate;
	animation: flash 4s 4s infinite linear alternate; animation-delay : 0s;}
</style>
</head>
	
<body>
	<!-- INCLUDE HEADER -->
	<jsp:include page="../inc/header.jsp"></jsp:include>
	<br>
	<section id="intro">
		<div class="container">
			<div align="center">
				<div class="col-lg-5 col-lg-offset-3 col-md-8 col-md-offset-2 text-center">
					<div class="intro animate-box" style="border-bottom:1px solid;">
						<h2 id="qnaContentTitle">Q n A &nbsp;&nbsp; C O N T E N T</h2>
					</div><br>
				</div>
			</div>
		</div>
	</section><br>
	<div class="container">
		<form name="articleForm" action="${contextPath}/main/qnaRewrite.do" mehtod="post">
		<table class="table" id="notice" style="margin-left:auto; margin-right:auto; width:80%; text-align:center; font-size: 20px;" >
			<tr>
				<td style="border-top: none; width:25%; text-align:left;"><i class="far fa-check-circle fa-lg mr-2 ml-5"></i><b>문의No.</b></td>
				<td style="border-top: none; width:25%; text-align: left; margin-left: 90px;"><b>No.${qnaVO.qnaNum}</b></td>
				<c:if test="${qnaVO.adminCheck ne '1' && replyVO eq null && sessionEmail ne 'admin@odetour.com'}">
				<td colspan="2" style="color: #000067; text-align:center; border-top: none;">
					<i class="far fa-user mr-2"></i><span id="waitQnaReply"><b>답변 확인중...</b></span>
				</td>
				</c:if>
			</tr>
			<tr>
				<td style="text-align:left; border-top:none;"><i class="far fa-check-circle fa-lg mr-2 ml-5"></i><b>고객명</b></td>
				<td style="text-align: left; margin-left: 90px;"><b>${qnaVO.writer}</b></td>
				<td style="width:25%;"><i class="far fa-check-circle fa-lg mr-2 ml-5"></i><b>문의일</b></td>
				<td style="width:25%; text-align:left;"><b>${qnaVO.writeDate}</b></td>
			</tr>		
			<tr>
				<td style="width:25%; text-align:left; border-top:none;"><i class="far fa-check-circle fa-lg mr-2 ml-5"></i><b>문의사항</b></td>
				<td colspan="3" style="text-align:left;"><input disabled type="text" name="qnaTitle" id="qnaTitle" value="${qnaVO.title}" style="width:100%; border: none; text-align: left; background-color: #ffffff;" ></td>
			</tr>	
			<tr>
				<td style="width:25%; text-align:left; border-top:none;"><i class="far fa-check-circle fa-lg mr-2 ml-5"></i><b>문의내용</b></td>
				<td colspan="3">
					<textarea disabled rows="15" cols="100" name="qnaContent" id="qnaContent" style="padding-left:0px; padding-right:30px; text-align: left; border:none; width:102%; height: 100%; background-color:#ffffff;">${qnaVO.content}</textarea>
				</td>
			</tr>				
		</table>
			
		<div align="right" style="margin-right: 130px;" >
			<input type="hidden" value="${qnaVO.qnaNum}" name="qnaNum">
		
		<c:if test="${replyVO ne null}">
			<p width="50%" style="text-align: left; margin-left: 305px;"><i class="fas fa-user-edit fa-md mr-2 ml-5"></i>문의사항에 답변 드립니다.</p>
			<textarea class="form-control" rows="15" cols="100" placeholder="답변 내용" style="padding-left:0; width:65%; text-align:left; border:none; background-color:#ffffff;" readonly>${replyVO.content}</textarea><br>
		</c:if>
		
		<c:if test="${qnaVO.adminCheck ne '1' && replyVO eq null && sessionEmail eq 'admin@odetour.com'}">
			<p width="50%" style="text-align: left; margin-left:305px;"><i class="fas fa-user-edit fa-md mr-2 ml-5"></i>문의사항에 답변 드립니다.</p>
			<textarea class="form-control" rows="15" cols="100" placeholder="답변 내용" id="replyTextArea" name="replyTextArea" style="text-align:left; border:none; padding-left:10px; padding-right:10px; width:645px; background-color:#ffffff;"></textarea><br>
		</c:if>
		
		<c:if test="${qnaVO.adminCheck ne '1' && qnaVO.email eq sessionEmail}">
			<input type="button" class="btn btn-info active" id="rewriteBtn" value="수정하기" onclick="qnaRewriteBtn();">
			<input type="submit" class="btn btn-info active" id="rewriteSubmitBtn" value="수정완료">
			<input type="button" class="btn btn-info active" id="rewriteCancelBtn" value="수정취소" onclick="qnaRewriteCancelBtn();">
		</c:if>
		
		<c:if test="${qnaVO.email ne sessionEmail && qnaVO.adminCheck ne '1'}">
			<input type="submit" class="btn btn-info active" id="replySubmitBtn" value="답변 달기" onclick="replyWrite(this.form)">
		</c:if>
		
		<c:if test="${sessionEmail eq 'admin@odetour.com'}">
			<input type="button" class="btn btn-info active" value="문의내역 LIST" onclick="location.href='${contextPath}/memberView/qnaSearch.jsp'" />				
		</c:if>				
			<input type="button" class="btn btn-info active mr-4" value="메인으로" onClick="location.href='${contextPath}/main/home.do'" />
		</div><br>

		</form>
	</div>
    <br>
    <!-- INCLUDE FOOTER -->
    <jsp:include page="../inc/footer.jsp"></jsp:include>

</body>
</html>