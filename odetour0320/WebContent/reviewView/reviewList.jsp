<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../totalScriptCSS.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    

<% request.setCharacterEncoding("UTF-8"); %>    
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>       
<c:set var="imageFilePath" value="${requestScope.imageFilePath}"/>
<c:set var="reviewSize" value="${reviewSize}"/>
<c:set var="reviewInit" value="${reviewInit}"/>
<c:set var="reviewVO" value="${requestScope.reviewList}"/>
<c:set var="commentSize" value="${requestScope.commentSize}"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>REVIEW LIST</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" initial-scale="1">

<script type="text/javascript">
</script>

<style type="text/css">
	#reviewList {font-family: sans-serif; font-size: 32px; color: teal;}
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
						<h2 id="reviewList">
							<i class="fas fa-plane-arrival fa-sm mr-5"></i>R E V I E W
						</h2>
					</div><br>
				</div>
			</div>
		</div>
	</section><br>
	<div class="container">
		<div class = "row">
			<table class="table table-striped" style="text-align:center;"> 
				<thead>
					<tr style="border-top:none;">
						<th style="text-align: center;">NO.</th>
						<th style="text-align: center;">제 목</th>
						<th style="text-align: center;">작성자</th>
						<th style="text-align: center;">작성일</th>
						<th style="text-align: center;">조회수</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${empty reviewList}">
							<tr height="10">
								<td colspan="5">
									<p align="center">
										<b><span>등록된 글이 없습니다.</span></b>
									</p>
								</td>
							</tr>
						</c:when>	
						<c:otherwise>
							<c:forEach var="review" items="${reviewVO}" varStatus="status">
								<tr>
									<td>${review.idx}</td>
									<td width="50%" style="text-align: left;"><a href="${contextPath}/main/reviewInfo.do?idx=${review.idx}">${review.title}</a>
										&nbsp;<sup><span style="color:teal;"><i class="far fa-comment-dots fa-md" style="font-size:16px;"></i></span></sup> 
										<sup><span style="color:teal; font-size:14px;"><b>${commentSize[status.index]}</b></span></sup>
									</td> 
									<td><i class="far fa-user fa-md mr-2"></i>${review.writer}</td> 
									<td>${review.writeDate}</td> 
									<td>${review.readCount}</td> 			
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>				
				</tbody>
			</table>
		</div>
		
		<!-- 리뷰 글쓰기 -->
		<div style="text-align:right; margin-right:20px;">
			<input type="button" class="btn btn-info active" value="REVIEW &nbsp; 글쓰기" onclick="location.href='${contextPath}/main/reviewWriteForm.do'"/>
		</div><br>
		
		<!-- PAGING --> 
		<nav aria-label="Page navigation example">
			<ul class="pagination pagination-lg justify-content-center">
				<c:if test="${pageinfo.page>1}">
					<li class="page-item">
     					<a class="page-link" href="${contextPath}/main/reviewList.do?page=${pageinfo.page-1}" tabindex="-1" aria-disabled="true">Previous</a>
   					</li>
				</c:if>
   				<c:forEach var="i" begin="${pageinfo.startPage}" end="${pageinfo.endPage}">
					<c:if test="${pageinfo.page==i}">
						<li class="page-item"><a class="page-link" href="#">${i}</a></li>
					</c:if>
					<c:if test="${pageinfo.page!=i}">
						<li class="page-item"><a class="page-link" href="${contextPath}/main/reviewList.do?page=${i}">${i}</a></li>
					</c:if>
				</c:forEach>
   				<c:if test="${pageinfo.page<pageinfo.maxPage}">
   					<li class="page-item">
     					<a class="page-link" href="${contextPath}/main/reviewList.do?page=${pageinfo.page+1}">Next</a>
   					</li>
				</c:if>
			</ul>
		</nav><br>
	
	</div>
    
    <!-- INCLDUE FOOTER	 -->
    <jsp:include page="../inc/footer.jsp"></jsp:include>
    
</body>
</html>