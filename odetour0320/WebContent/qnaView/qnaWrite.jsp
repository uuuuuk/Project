<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../totalScriptCSS.jsp" %>        
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% request.setCharacterEncoding("UTF-8"); %> 
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  /> 
<c:set var="sessionEmail" value="${sessionScope.email}"/>
<c:set var="sessionName" value="${sessionScope.name}"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>QnAWrite</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" initial-scale="1">
	
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	/* 게시글 공백 체크 */
	$(document).ready(function() {
		if('${sessionEmail}'  == ''){
			alert("로그인 후 이용하여 주세요");
			location.href="${contextPath}/main/home.do";
		}
		else if('${sessionEmail}' == 'admin@odetour.com'){
			alert("관리자");
			location.href="${contextPath}/main/home.do";
		}
	}); 
	/* 공백체크 */
	function Check() {
		var form = document.noticeForm;
		if( !form.title.value ) {  
			$('#modal_fail_title').html("Message");
	  		$('#modal_fail_body').html("제목을 입력해 주세요.");
	  		$('#modal_fail').modal("show");	 
			form.title.focus();  
	  		return;
		}else if(!form.content.value) {
			$('#modal_fail_title').html("Message");
	  		$('#modal_fail_body').html("내용을 입력해 주세요.");
	  		$('#modal_fail').modal("show");	  
			form.content.focus();
	  		return;
		}else {
			$('#modal_success_title').html("Message");
	  		$('#modal_success_body').html("1:1 문의가 작성되었습니다.");
			$('#modal_success').modal("show");
		}	
	}
	/* 글작성 완료 */
	function qnaSubmit() {
		document.noticeForm.submit();
		return true;
	}
	/* 목록 보기 */
	function QnaList(obj){
		obj.action="${contextPath}/main/home.do";
		obj.submit();
	}
</script>

<style type="text/css">
	/* Modal Position */
	#modal_fail, #modal_success {top:20%;}
	/* Title */
	#qnaWriteTitle {font-family: sans-serif; font-size: 28px; color: teal; }
</style>  
</head>
	
<body>
	<!-- INCLUDE HEADER -->
	<jsp:include page="../inc/header.jsp"></jsp:include>
	<br>
	<section id="intro">
		<div class="container">
			<div align="center">
				<div class="col-lg-4 col-lg-offset-3 col-md-8 col-md-offset-2 text-center">
					<div class="intro animate-box" style="border-bottom:1px solid;">
						<h2 id="qnaWriteTitle">Q n A &nbsp;&nbsp; W R I T E</h2>
					</div><br>
				</div>
			</div>
		</div>
	</section><br>
	<div class="container">
		<form name="noticeForm" method="post" action="${contextPath}/main/qnaWrite.do" onSubmit="Check(); return false">
		<table class="table" style="margin-left:auto; margin-right:auto; width:80%; text-align:center;" >
			<tr>
				<td style="width: 15%; text-align:left; border-top:none; padding-top:20px; padding-bottom:0px;">
					<i class="far fa-check-circle fa-lg mr-2 ml-2"></i><b>문의사항</b>
				</td>
				<td style="width: 85%; text-align:left; border-top:none; padding-left:0px; padding-top:10px; padding-bottom:0px;">
					<input class="form-control" id="title" name="title" type="text" placeholder="17자 이내로 입력해 주세요." maxlength="17" style="border:none !important; width:400px; background-color:#ffffff;"/>
				</td>
			</tr>
			<tr>
				<td style="width: 15%; text-align:left; border-top:none; padding-top:15px;">
					<i class="far fa-check-circle fa-lg mr-2 ml-2"></i><b>문의내용</b>
				</td>
				<td style="width:85% text-align:left; padding-top:5px; padding-left: 0px;">
					<textarea id="content" name="content" class="form-control" rows="15" cols="100" placeholder="문의하실 내용을 남겨주세요." maxlength="2048" style="border:none !important; height: 350px;"></textarea>
				</td>
			</tr>
		</table>
		
		<div style="width:900px; text-align:right;">
			<input type="hidden" name="email" value="${sessionEmail}">
			<input type="hidden" name="name" value="${sessionName}">
			<input type="submit" class="btn btn-info active" value="글쓰기" />
			<input type="button" class="btn btn-info active" value="취소" onClick="QnaList(this.form)" />
		</div>
	  </form>
	</div><br><br><br>
	
<!-- 메세지 MODAL-FAIL ------------------------------------------------------------------------------------------ -->
<div class="modal fade" id="modal_fail" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-notify modal-info" role="document">
    	<div class="modal-content" style="width:85%;">
      		<div class="modal-header">
		      	<p><i class="fas fa-edit fa-lg mr-1" style="color:#ffffff;">
		      		<span class="heading lead" id="modal_fail_title"></span></i></p>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		        	<span aria-hidden="true" class="white-text">&times;</span></button>
			</div>
			<div class="modal-body">
		        <div class="text-center mb-2">
		        	<i class="fas fa-user-edit fa-4x mb-3"></i><p id="modal_fail_body"></p>
		        </div>
			</div>
			<div class="modal-footer justify-content-center">
	        	<a type="button" class="btn btn-outline-primary waves-effect" data-dismiss="modal">확인</a>
			</div>
    	</div>
	</div>
</div>
<!-- 메세지 MODAL-FAIL ------------------------------------------------------------------------------------------ -->

<!-- 메세지 MODAL-SUCCESS --------------------------------------------------------------------------------------- -->
<div class="modal fade" id="modal_success" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-notify modal-info" role="document">
    	<div class="modal-content" style="width:85%;">
      		<div class="modal-header">
		      	<p><i class="fas fa-edit fa-lg mr-1" style="color:#ffffff;">
		      		<span class="heading lead" id="modal_success_title"></span></i></p>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		        	<span aria-hidden="true" class="white-text">&times;</span></button>
			</div>
			<div class="modal-body">
		        <div class="text-center mb-2">
		        	<i class="far fa-check-circle fa-4x mb-3 animated flipInX"></i><p id="modal_success_body"></p>
		        </div>
			</div>
			<div class="modal-footer justify-content-center">
	        	<a type="button" class="btn btn-outline-primary waves-effect" data-dismiss="modal" onclick="qnaSubmit();">확인</a>
			</div>
    	</div>
	</div>
</div>
<!-- 메세지 MODAL-SUCCESS --------------------------------------------------------------------------------------- -->
		
	<!-- INCLDUE FOOTER -->
    <jsp:include page="../inc/footer.jsp"></jsp:include>

</body>
</html>