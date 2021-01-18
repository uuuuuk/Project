<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../totalScriptCSS.jsp" %>
<%@ taglib prefix="c"    uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%> 
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>       
<c:set var="noticeList" value="${requestScope.noticeList}" />

<%
	request.setCharacterEncoding("UTF-8");
/////////////////  캐쉬 지우기  /////////////////////
response.setHeader("Pragma", "No-cache"); 
response.setDateHeader("Expires", 0); 
response.setHeader("Cache-Control", "no-Cache"); 
///////////////////////////////////////////////////
%> 
<meta http-equiv="Cache-Control" content="No-Cache">
<meta http-equiv="Pragma" content="No-Cache">

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>NOTICE LIST</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" initial-scale="1">

<script src="http://code.jquery.com/jquery-latest.min.js"></script>	
<script type="text/javascript">
	window.onpageshow = function (event) {
		if (event.persisted) {
			console.log('BFCahe로부터 복원됨');
		}
		else {
			console.log('새로 열린 페이지');
		}
	};
</script> 

<style type="text/css">
	#title {font-family: sans-serif; font-size: 32px; color: teal;}
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
						<h2 id="title">N O T I C E</h2>
					</div><br>
				</div>
			</div>
		</div>
	</section><br>
	<div class="container">
		<table class="table table-striped"  style="text-align:center;"> 
			<thead>
				<tr>
					<th style="text-align: center;">NO.</th>
					<th style="text-align: center;">제 목</th>
					<th style="text-align: center;">작성자</th>
					<th style="text-align: center;">작성일</th>
					<th style="text-align: center;">조회수</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
				<c:when test="${empty noticeList}">
					<tr height="10">
						<td colspan="5">
							<p align="center">
								<b><span>등록된 글이 없습니다.</span></b>
							</p>
						</td>
					</tr>	
				</c:when>
				<c:otherwise>
					<c:forEach var="notice" items="${noticeList}" varStatus="status">
						<tr>
							<!-- 전체 레코드 수 - ( (현재 페이지 번호 - 1) * 한 페이지당 보여지는 레코드 수 + 현재 게시물 출력 순서 ) -->
							<c:set var="num" value="${pageinfo.listCount-((pageinfo.page-1)*5+status.index)}"/> 
							<td>${notice.idx}</td> 								
							<td width="50%" style="text-align: left;">
								<a href="${contextPath}/main/viewNotice.do?idx=${notice.idx}&num=${num}" id="noticeview">${notice.title}</a>							
							</td> 
							<td><i class="far fa-user mr-2"></i>${notice.writer}</td> 
							<td>${notice.writeDate}</td> 
							<td>${notice.readCount}</td> 			
						</tr>		
					</c:forEach>						
				</c:otherwise>
				</c:choose>
			</tbody>
		</table>
		<!-- 공지사항 작성버튼  -->
		<c:if test="${sessionScope.name=='admin'}">	
			<div style="text-align:right; margin-right:20px;">
			<input type="button" class="btn btn-info active" value="공지사항 작성" onclick="location.href='${contextPath}/main/writeNotice.do'"/>
			</div>			
	 	</c:if> 
		
		<!-- PAGING --> 
		<nav aria-label="Page navigation example">
 			<ul class="pagination pagination-lg justify-content-center">
 				<c:if test="${pageinfo.page>1}">
 					<li class="page-item">
	      			<a class="page-link" href="${contextPath}/main/listNotice.do?page=${pageinfo.page-1}" tabindex="-1" aria-disabled="true">Previous</a>
	    		</li>
 				</c:if>
	    	<c:forEach var="i" begin="${pageinfo.startPage}" end="${pageinfo.endPage}">
				<c:if test="${pageinfo.page==i}">
					<li class="page-item"><a class="page-link" href="#">${i}</a></li>
				</c:if>
				<c:if test="${pageinfo.page!=i}">
					<li class="page-item"><a class="page-link" href="${contextPath}/main/listNotice.do?page=${i}">${i}</a></li>
				</c:if>
			</c:forEach>
	    	<c:if test="${pageinfo.page<pageinfo.maxPage}">
	    		<li class="page-item">
	      			<a class="page-link" href="${contextPath}/main/listNotice.do?page=${pageinfo.page+1}">Next</a>
	    		</li>
 				</c:if>
 			</ul>
		</nav><br>
	</div>
    <!-- INCLDUE FOOTER	 -->
    <jsp:include page="../inc/footer.jsp"></jsp:include>

</body>
</html>