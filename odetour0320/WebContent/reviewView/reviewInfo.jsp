<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ include file="../totalScriptCSS.jsp" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% request.setCharacterEncoding("UTF-8"); %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"/> 
<c:set var="sessionEmail" value="${sessionScope.email}"/>
<c:set var="sessionName" value="${sessionScope.name}"/>
<c:set var="recommentList" value="${requestScope.recommentList}"/>
<c:set var="imageFilePath" value="${requestScope.imageFilePath}"/> 
<c:set var="recommentSize" value="${requestScope.recommentSize}"/>
<c:set var="commentListSize" value="${commentListSize}"/>
<c:set var="commentInit" value="${commentInit}"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>REVIEW INFO</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" initial-scale="1">

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	/* 글 수정 */ 
	/*	<div id="current_btn">	
		<div id= "modify_btn_enable"> */
	$(function (){
		$("#current_btn").show();
		$("#modify_btn_enable").hide();
	});
	function modify_enable(obj){// 수정하기 클릭시 form input 창 활성화 
		document.getElementById("re_title").readOnly=false;
	 	document.getElementById("re_content").readOnly=false;
		document.getElementById("re_imageFileName").hidden=false; 
		$("#current_btn").hide();
		$("#modify_btn_enable").show();
	}
	function click_modify_review(obj){ //수정반영하기 클릭
		obj.action = "${contextPath}/main/reviewUpdate.do";
		obj.submit();
	}
	function click_modify_cancle(obj){//수정하기 취소
		document.getElementById("re_title").readOnly=true;
	 	document.getElementById("re_content").readOnly=true;
		document.getElementById("re_imageFileName").hidden=true; 
		
		$("#re_title").val('${reviewView.title}');
		$("#re_content").val('${reviewView.content}');
		$("#re_imageFileName").val('${reviewView.imageFileName}');
		
		$("#current_btn").show();
		$("#modify_btn_enable").hide();
	}
	function modify_image(obj){ //첨부파일 누를 때 이미지 preview 해제하기  
		document.getElementById("preview").style.display="block";
	}
    function readURL(input) { //이미지 미리보기 
    	$("#imageArea").hide();
	      if (input.files && input.files[0]) {
		      var reader = new FileReader();
		      reader.onload = function (e) {
		        $('#preview').attr('src', e.target.result);
	          }
	         reader.readAsDataURL(input.files[0]);
	      }
	  }  
	/* 댓글 수정 */
	$(function() {
		for(var i=0; i<'${recommentSize}'; i++){
			$("#updateButton"+i).hide();

		}
	});
	function comment_enable(idx){
			$("#updateButton"+idx).show();
			$("#current_comment"+idx).hide();
			//document.getElementById("comment${num.index}").disabled=false;
			//$("#comment"+idx).disabled = false;
			document.getElementById("comment"+idx).disabled=false;
			//document.getElementById("current_comment").style.display="none"; //수정하기 눌렀을 때 수정하기 버튼 감추기 
	}
	function click_modify_comment(idx, idx2, input){ //수정반영하기 클릭
	var commentRealIdx = idx;
	var commentOutputIdx = idx2;
	var commentRewriteContext = input[idx2].value;
		$.ajax({
		type:"post", 
		url:"${contextPath}/main/commentModify.do",
		data:{"commentRealIdx" : commentRealIdx, 
				"commentRewriteContext" : commentRewriteContext },
		success:function(result){
			if(result == "1"){
				click_comment_cancle(commentRealIdx , commentOutputIdx);
			}
			else{
				alert("ajax실패");
			}
		}
	});	
 }
	function click_comment_cancle(obj, idx){
		$("#updateButton"+idx).hide();
		$("#current_comment"+idx).show();
		document.getElementById("comment"+idx).disabled=true;
	}
	function click_delete_comment(realCommentIdx,commentOutputIdx){
		$.ajax({
			type:"post", 
			url:"${contextPath}/main/commentDelete.do",
			data:{"realCommentIdx" : realCommentIdx},
			success:function(result){
				if(result == "1"){
					$("#commentArea"+commentOutputIdx).remove();
				}
			}
		});	
 	}
</script>

<style>
	/*후기 수정반영하기 버튼 숨기기  */
	#modify_btn_enable{display:none;}
    /*댓글 수정반영하기 버튼 숨기기   */
	#comment_btn_enable{display:none;}
 	/* 이미지 첨부하기 버튼  숨기기*/
  	#preview{display:none;}
  	/* Title ETC */
  	#reviewInfoTitle {font-family: sans-serif; font-size: 32px; color: teal;}
  	input[type="file" i] {width: 150px;}
  	/* Table Stripe Color */
  	.table-striped>tbody>tr:nth-child(odd)>td, 
	.table-striped>tbody>tr:nth-child(odd)>th {background-color: #f5f5f5;}
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
						<h2 id="reviewInfoTitle">
							<i class="fas fa-plane-arrival fa-sm mr-5"></i>R E V I E W
						</h2>
					</div><br>
				</div>
			</div>
		</div>
	</section><br>
	<div class="container">
		<form name="reviewForm" method="post" enctype="multipart/form-data">
		<input type="hidden" value="${reviewView.idx}" name="idx"/>
		<table class="table table-striped" id="review" style="width: 90%; text-align:center; margin-left: 40px;">
			<tr>
				<td style="border-top:none; width:20%; text-align:left;"><i class="far fa-check-circle fa-lg mr-2 ml-5"></i><b>No.</b></td>
				<td style="border-top:none; width:30%; text-align:left;"><b>No.${reviewView.idx}</b>
					<input type="hidden" name="idx" value="${reviewView.idx}">
					<input type="hidden" name="parentNum" value="${reviewView.idx}">
				</td>
				<td style="border-top:none; width:20%; text-align:left;"><i class="far fa-check-circle fa-lg mr-2 ml-5"></i><b>조회수</b></td>
				<td style="border-top:none; width:30%; text-align:left;"><b>${reviewView.readCount}</b></td>
			</tr>
			<tr>
				<td style="width:20%; text-align:left; border-top:none;"><i class="far fa-check-circle fa-lg mr-2 ml-5"></i><b>작성자</b></td>
				<td style="width:30%; text-align:left; border-top:none;"><b>${reviewView.writer}</b></td>
				<td style="width:20%; text-align:left; border-top:none;"><i class="far fa-check-circle fa-lg mr-2 ml-5"></i><b>작성일</b></td>
				<td style="width:30%; text-align:left; border-top:none;"><b>${reviewView.writeDate}</b></td>
			</tr>		
			<tr>
				<td style="width:20%; text-align:left; border-top:none;"><i class="far fa-check-circle fa-lg mr-2 ml-5"></i><b>제 목</b></td>
				<td colspan="3" style="width:80%; text-align:left; border-top:none;">
					<input type="text" id="re_title" name="title" value="${reviewView.title}" style="width:600px; border:none; background-color:#f5f5f5;" readonly/>
				</td>
			</tr>	
			<tr>
				<td style="width:20%; text-align:left; border-top:none;"><i class="far fa-check-circle fa-lg mr-2 ml-5"></i><b>리 뷰</b></td>
				<td colspan="3" style="border-top:none; padding-top:10px; padding-left:0; padding-bottom:0;">
					<textarea class="form-control" id="re_content" name="content" rows="15" cols="100" maxlength="2048" placeholder="" style="width:97%; text-align:left; border:none !important; background-color:#ffffff; resize:none;" readonly>${reviewView.content}</textarea>
				</td>
			</tr>
			
	<c:choose>
		<c:when test="${reviewView.imageFileName == null}">
			<tr>
				<td style="width:20%; text-align:left; border-top:none; background-color:#ffffff;"><i class="far fa-file-alt fa-lg mr-2 ml-5"></i><b>첨부사진</b></td>
				<td colspan="3" style="width:80%; text-align:left; background-color:#ffffff;">
					<input type="text" id="imageFileName" name="imageFileName" value="등록된 사진이 없습니다." disabled style="width:94%; border:none; background-color:#ffffff;">
				</td>
			</tr>
			<tr>
				<td id="btnReviewModifyFile" class="collapse" style="border-top:none; width:20%; text-align:right;">
					<input type="file" id="re_imageFileName" name="imageFileName" value="${reviewView.imageFileName}" onchange="readURL(this);" hidden onclick="modify_image(this.form)">
				</td>
				<td colspan="3" style="border-top:none; width:80%; text-align:left; background-color:#ffffff;">
					<img id="preview" src="#" width="650" height="400"/>
				</td>
			</tr>
			<tr>
				<td id="editFile" style="border-top:none; width:20%; text-align:right; background-color:#ffffff;">
				</td>
				<td colspan="3" style="border-top:none; width:80%; text-align:left; background-color:#ffffff;">
					<img id="preview" src="#" width="650" height="400"/>
				</td>
			</tr>
		</c:when>
		<c:otherwise>		
			<tr>
				<td style="width:20%; text-align:left; border-top:none; background-color:#ffffff;"><i class="far fa-file-alt fa-lg mr-2 ml-5"></i><b>첨부파일</b></td>
				<td colspan="3" style="width:80%; text-align:left; background-color:#ffffff;">
					<input type="text" id="imageFileName" name="imageFileName" value="${reviewView.imageFileName}" disabled style="width:94%; border:none; background-color:#ffffff;">
				</td>
			</tr>
			<tr>
				<td style="border-top:none; width:20%; text-align:right;">
					<input type="file" id="re_imageFileName" name="imageFileName" value="${reviewView.imageFileName}" onchange="readURL(this);" hidden onclick="modify_image(this.form)">
				</td>
				<td colspan="3" style="border-top:none; width:80%; text-align:left;">
					<img id="imageArea" src="${imageFilePath}/upload/${reviewView.email}/${reviewView.imageFileName}" width="650" height="400" />
				</td>
			</tr>
			<tr>
				<td id="editFile" style="border-top:none; width:20%; text-align:right; background-color:#ffffff;">
				</td>
				<td colspan="3" style="border-top:none; width:80%; text-align:left; background-color:#ffffff;">
					<img id="preview" src="#" width="650" height="400"/>
				</td>
			</tr>
		</c:otherwise>	
	</c:choose>	
		</table>	
		
		<div style="width:81%; text-align:right;">
			<div id="current_btn">	
				<c:if test="${sessionEmail == reviewView.email}">
					<input type="button" class="btn btn-info active" data-toggle="collapse" data-target="#btnReviewModifyFile" value="수정하기" onclick="modify_enable(this.form)"/>
					<input type="button" class="btn btn-info active" value="삭제하기" onclick="location.href='${contextPath}/main/reviewDelete.do?idx=${reviewView.idx}'"/>
				</c:if>				
					<input type="button" class="btn btn-info active" value="목록보기" onclick="location.href='${contextPath}/main/reviewList.do'"/>
			</div>
			<div id="modify_btn_enable">
				<input type="button" class="btn btn-info active" value="수정완료" onclick="click_modify_review(this.form);">
				<input type="button" class="btn btn-info active" value="취소" onclick="click_modify_cancle(this.form)">
				<input type="button" class="btn btn-info active" value="목록보기" onclick="location.href='${contextPath}/main/reviewList.do'"/>
			</div>
		</div>
		</form><br><br>
			
		<table class="table" id="commentListArea" style="width:90%; text-align:center; margin-left:40px;">
			<tr style="background-color:#f5f5f5;">
				<td style="width:13%; border:none;"><b>작성자</b></td>
				<td style="width:37%; border:none;"><b>댓 글</b></td>
				<td style="width:13%; border:none;"><b>작성일</b>
					<td style="width:37%; border:none;"></td>
				</td>
			</tr>
			<c:choose> 
				<c:when test="${recommentList == null}">
					<tr>
					<td colspan="4">
					<p align="center">
					 	<span>등록된 댓글이 없습니다</span>
					</p>
					</td>
					</tr>
				</c:when>
				<c:when test="${recommentList != null }">
					<c:forEach var="recommentList" items="${recommentList}" varStatus="num">
					 	<tr id="commentArea${num.index}"> 
							<td style="border-top:none;">
								<i class="far fa-user fa-lg"></i>
								<b>${recommentList.writer}</b>
							</td>
							<td style="border-top:none;">
								<input type="text" id="comment${num.index}" value="${recommentList.content}" name="recontent" disabled style="border:none; background-color:#ffffff; width:450px;">
							</td>
							<td style="border-top:none;"><b>${recommentList.writeDate }</b></td>
						<c:if test="${recommentList.email eq sessionEmail}">
							<td style="padding:7px; border-top:none;">
								<input type="button" class="btn btn-info active float-right mr-5" value="수정하기"  id= "current_comment${num.index}" onClick="comment_enable('${num.index}')" >
				   				<div id="updateButton${num.index}">
					   				<input id="comment_btn_enable${num.index}" type="button" class="btn btn-info active float-right mr-5" value="수정" onClick="click_modify_comment('${recommentList.idx}', '${num.index}', document.getElementsByName('recontent'))" id='${num.index}'>						
				         			<input id="comment_btn_enable${num.index}" type="button" class="btn btn-info active float-right" value="삭제"  onClick="click_delete_comment('${recommentList.idx}','${num.index}')">
				         			<input id="comment_btn_enable${num.index}" type="button" class="btn btn-info active float-right" value="취소"  onClick="click_comment_cancle('${recommentList.idx}','${num.index}')" >
			  					</div>
							</td>
						</c:if>
						</tr>
					</c:forEach>
				</c:when>
			</c:choose>
		</table>
		
		<form action="${contextPath}/main/commentWrite.do" method="post">	
			<input type="hidden" name="commentParentNum" value="${reviewView.idx}" >
			<input type="hidden" name="name" value="${sessionName}"/>
			<input type="hidden" name="email" value="${sessionEmail}"/>
			<c:if test="${sessionEmail eq null}">
				<div>
					<div> 
						<textarea class="form-control" placeholder="로그인 후 댓글을 남겨보세요..." name="commentContent" id="commentContent" maxlength="50" style="width:80%; height:35px; margin-left:130px;"></textarea>
					</div>
				</div>
			</c:if>
			<c:if test="${sessionEmail ne null}">
			<div>
				<div> 
					<textarea class="form-control" placeholder="댓글을 남겨보세요..." name="commentContent" id="commentContent" maxlength="1000" style="width:80%; height:35px; margin-left:130px;"></textarea>
				</div>
			</div>
			<div id="current_comment" style="border:none;"></div>
				<input type="submit" class="form-control btn btn-info active float-right" value="댓글쓰기" style="width:90px; margin-right:125px;"><br><br>
			</c:if>
		</form>
	</div> <!-- CONTAINER END -->
	<br><br>
	
	<!-- INCLUDE FOOTER -->
    <jsp:include page="../inc/footer.jsp"></jsp:include>
	
</body>
</html>