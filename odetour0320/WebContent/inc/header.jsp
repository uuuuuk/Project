<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../totalScriptCSS.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="sessionEmail" value="${sessionScope.email}" />
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

	<style type="text/css">
	  /* Modal Position */
	  #modalLoginCheck, #modalLoginSuccess {top: 15%;} 
	  #modalDeleteCheck, #messageModal {top: 20%;}
	  #modalLRForm2 {top: -5%;}
 	  .modal-c-tabs .md-tabs li a {color: white;}
 	  /* Mouse Hover */
 	  .nav-link:hover {text-shadow: 2px 2px 4px #000000;}
	  .nav-link {cursor: pointer;}
	</style>
    
    
    <!-- INCLUDE loginHeader.jsp -->
	<jsp:include page="loginHeader.jsp"></jsp:include>
    
    
       <header class="site-navbar site-navbar-target bg-white" role="banner">

        <div class="container">
          <div class="row align-items-center position-relative">
			<div class="col-lg-4 text-center">
              <div class="site-logo">
                <a href="${contextPath}/main/home.do"><img src="../images/ODE_logo.png" width="64px"></a>
                <a href="${contextPath}/main/home.do"><img src="../images/ODE_logoText.png" width="130px"></a>
              </div>
              <div class="ml-auto toggle-button d-inline-block d-lg-none"><a href="#" class="site-menu-toggle py-5 js-menu-toggle text-white"><span class="icon-menu h3 text-primary"></span></a></div>
            </div>
            <div class="col-lg-8">
              <nav class="site-navigation text-center mr-auto " role="navigation">
                <ul class="site-menu main-menu js-clone-nav ml-auto d-none d-lg-block">
                  <li><a href="${contextPath}/main/listNotice.do" class="nav-link">NOTICE</a></li>
                  <li><a href="${contextPath}/main/reviewList.do" class="nav-link">REVIEW</a></li>
                  <li><a href="${contextPath}/main/qnaWriteForm.do" class="nav-link">1:1 QnA</a></li>
                  <li><a class="nav-link" data-toggle="modal" data-target="#chatingForm">CHAT</a></li>
  			<c:choose>
               	<c:when test="${sessionEmail == null}" >	 
				 <li class="nav-item no-arrow mx-0">
			       <a class="nav-link" href="#" id="messagesDropdown" role="button" data-toggle="modal" data-target="#modalLRForm" aria-haspopup="true" aria-expanded="false">
			         <i class="far fa-user pr-2" aria-hidden="true">&nbsp;Login</i>
			       </a>
				 </li>
				</c:when>				 
  				<c:when test="${sessionEmail == 'admin@odetour.com'}" >	 
				  <li class="nav-item dropdown no-arrow mx-0">
			       <a class="nav-link dropdown-toggle" href="#" id="messagesDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
			         <i class="far fa-user pr-2" aria-hidden="true">&nbsp;관리자</i>
			       </a>
			       <div class="dropdown-menu dropdown-menu-center" aria-labelledby="messagesDropdown">
			     	<a class="dropdown-item" href="${contextPath}/main/adminSearchPage.do">회원관리</a>
			       	<a class="dropdown-item" href="${contextPath}/main/memberLogout.do">로그아웃</a>
				 </li>
		    	</c:when>  	
 				<c:otherwise>
 				 <li class="nav-item dropdown no-arrow mx-0">
			       <a class="nav-link dropdown-toggle" href="#" id="messagesDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
			         <i class="far fa-user pr-0" aria-hidden="true">&nbsp;회원</i>
			       </a>
			       <div class="dropdown-menu dropdown-menu-center" aria-labelledby="messagesDropdown">
			     	<a class="dropdown-item" href="#" data-toggle="modal" data-target="#modalLRForm2" onclick="memberInfo()">내 정보</a>
			       	<a class="dropdown-item" href="${contextPath}/main/memberLogout.do">로그아웃</a>
				 </li>
				 <li class="nav-item no-arrow mx-0">
			  		<a class="nav-link" href="#" id="" data-toggle="modal" data-target="#modalInbox">
						<i class="far fa-envelope fa-lg mr-auto"></i>
						<sup><span id="messageCount" class="label label-info px-1 py-0"></span></sup>
			     	</a>
			  	 </li>
			    </c:otherwise>
			</c:choose>		 
 				</ul>
              </nav>
            </div>
          </div>
        </div>
      </header>

      
      
      
      
      
      
      
      
      
      
      