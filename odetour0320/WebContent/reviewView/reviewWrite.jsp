<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../totalScriptCSS.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% request.setCharacterEncoding("UTF-8"); %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<c:set var="sessionEmail" value="${sessionScope.email}" />
<c:set var="sessionName" value="${sessionScope.name}" />
<c:set var="sessionDomain" value="${sessionScope.domain}" />

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>REVIEW WRITE</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" initial-scale="1">

<script type="text/javascript"src="../naver-smarteditor2/demo/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	function readURL(input) {
    	if (input.files && input.files[0]) {
	    	var reader = new FileReader();
	      	reader.onload = function (e) {
	        	$('#preview').attr('src', e.target.result);
        	}
       		reader.readAsDataURL(input.files[0]);
		}
	}  
	$(function() {
		var sessionEmail = '${sessionEmail}';
	    if(sessionEmail == "" || sessionEmail == null){
	    	alert("로그인 후 이용하여주세요.");
	    	location.href="${contextPath}/main/reviewList.do";
	    }
	}); 
	/* 공백체크 */
	function Check() {
		var form = document.articleForm;
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
	  		$('#modal_success_body').html("${sessionName}"+"님의 리뷰가 작성되었습니다.");
			$('#modal_success').modal("show");
		}	
	}
	function reviewSubmit() {
		document.articleForm.submit();
		return true;
	}
</script>

<style type="text/css">
	/* Modal Position */
	#modal_fail, #modal_success {top:20%;}
	#reviewWriteTitle {font-family: sans-serif; font-size: 32px; color: teal;}
	input[type="file" i] {width: 140px;}
</style>
</head>

<body>
	<!-- INCLUDE HEADER -->
	<jsp:include page="../inc/header.jsp"></jsp:include>
	<br>
	<section id="intro">
		<div class="container">
			<div align="center">
				<div class="col-lg-6 col-lg-offset-3 col-md-8 col-md-offset-2 text-center">
					<div class="intro animate-box" style="border-bottom:1px solid;">
						<h2 id="reviewWriteTitle">
							<i class="fas fa-plane-arrival fa-sm mr-5"></i>R E V I E W &nbsp;&nbsp; W R I T E
						</h2>
					</div><br>
				</div>
			</div>
		</div>
	</section><br>
	<div class="container">
	<form name="articleForm" method="post" action="${contextPath}/main/reviewWrite.do" onSubmit="Check(); return false" enctype="multipart/form-data">
	<table class="table" style="width: 80%; margin-left:auto; margin-right:auto; text-align: center;">
		<tr>
			<td style="width: 20%; text-align:left; border-top:none; padding-top:20px; padding-bottom:0px;">
				<i class="far fa-check-circle fa-lg mr-2 ml-2"></i><b>REVIEW 제목</b>
			</td>
			<td style="width: 80%; text-align:left; border-top:none; padding-top:10px; padding-bottom:3px;">
				<input class="form-control" id="title" name="title" type="text" placeholder="제목을  입력해 주세요. (35자이내)"  maxlength="35" style="padding:0; border:none !important; width:700px; background-color:#ffffff;"/>
			</td>
		</tr>
		<tr>
			<td style="width: 20%; text-align:left; border-top:none; padding-top:15px;">
				<i class="far fa-check-circle fa-lg mr-2 ml-2"></i><b>REVIEW 내용</b>
			</td>
			<td style="width: 80%; text-align:left; padding-top: 5px; padding-left: 0px; padding-right:10px;">
				<textarea id="content" class="form-control" rows="15" cols="100" placeholder="리뷰를 남겨주세요..." name="content" maxlength="2048" style="height: 350px; border:none !important;"></textarea>
			</td>
		</tr>
		<tr>
			<td style="width: 20%; text-align:left; border-top:none;">
				<input type="file" name="imageFileName" onchange="readURL(this);" data-toggle="collapse" data-target="#reviewWriteImage" style="background-color:#dddddd;"/>
			</td>
			<td id="reviewWriteImage" class="collapse" style="width: 80%; text-align:right;">
				<img class="" id="preview" src="#" width="650" height="400"/>
			</td>
		</tr>
	</table>	
	<div style="text-align: right; margin-right: 130px;" >
		<input type="hidden" name="email" value="${sessionEmail}"/>
		<input type="hidden" name="name" value="${sessionName}"/>
		<input type="hidden" name="domain" value="${sessionDomain}"/>
		<input type="submit" class="btn btn-info active" value="글쓰기"/>
		<input type="reset" class="btn btn-info active" value="다시쓰기"/>
		<input type="button" class="btn btn-info active" value="목록보기" onclick="location.href='${contextPath}/main/reviewList.do'"/>
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
	        	<a type="button" class="btn btn-outline-primary waves-effect" data-dismiss="modal" onclick="reviewSubmit();">확인</a>
			</div>
    	</div>
	</div>
</div>
<!-- 메세지 MODAL-SUCCESS --------------------------------------------------------------------------------------- -->
		
	<!-- INCLDUE FOOTER -->
    <jsp:include page="../inc/footer.jsp"></jsp:include>
    
</body>
</html>