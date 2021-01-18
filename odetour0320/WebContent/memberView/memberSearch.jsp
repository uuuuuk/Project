<%@ page language="java" contentType="text/html; charset=UTF-8"
    	 pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>MemberList</title>
	<!-- MODAL CSS ---------------------------------------------------------------------------------------- -->
    <link rel="icon" href="../css_modal/img/mdb-favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.11.2/css/all.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap">
    <link rel="stylesheet" href="../css_modal/css/bootstrap.min.css">
    <link rel="stylesheet" href="../css_modal/css/style.css">
    <!-- <link rel="stylesheet" href="../css_modal/css/mdb.min.css"> -->
	<!-- BootStrap CDN -->
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">	
	<!-- CSS PLUS(CDN) -->
	<!-- Font Awesome -->
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
	<!-- Google Fonts -->
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap">
	<!-- Bootstrap core CSS -->
	<link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.4.1/css/bootstrap.min.css" rel="stylesheet">
	<!-- BootStrap CDN -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
	
	<style type="text/css">
		#modalDeleteCheck {top: 10%;}
		#modalDeleteResult {top: 10%; left:2%;} 
		#qnaAdmin {margin-left: 10px;} 
		#home {margin-left: 30px;}
	</style>
	
	<script type="text/javascript">
		var request = new XMLHttpRequest();
		function searchFunction() {
			request.open("Post", "${contextPath}/main/adminSearch.do?name=" + $('#name').val(), true);
			request.onreadystatechange = searchProcess; // event => searchProcess();
			request.send(null);
		}		
		function searchProcess(){ 
			var table = document.getElementById("memberListTable");
			table.innerHTML = "";
			if(request.readyState == 4 && request.status == 200) {
				var object = eval('(' + request.responseText + ')');
				var result = object.result;
				for(var i=0; i<result.length; i++) {
					var row = table.insertRow(0);
					for(var j=0; j<result[i].length; j++) {
						var cell = row.insertCell(j);
						cell.innerHTML = result[i][j].value;
						if(j == 5){
							var memberButton = '<button class="btn btn-outline-danger my-3 my-sm-0 float-center shadow-md" id="deleteButton" type="button" value="탈퇴" onclick="adminAuthDelete(' + result[i][4].value + ');"><i class="fas fa-user-times"> 탈퇴</button>';
							cell.innerHTML = memberButton;
						}
					}
				}
			}
		}//searchProcess()

		var realtel;
		function adminAuthDelete(tel){
			realtel = tel + "";
 			$('#modalDeleteCheck').modal("show");
		}
		function deleteFunction() {
			adminAuthDeleteFinal(realtel);
		}
		function adminAuthDeleteFinal(realtel) {
			location.href="${contextPath}/main/adminAuthMemberDelete.do?tel=" + realtel;
		}
		
	</script>
</head>

<body>
	<br>
	<div class="container">
		<div class="form-group">
			<div class="form-inline my-2 my-lg-0">
	      		<input class="form-control mr-sm-2" id="name" onkeyup="searchFunction()" type="text" placeholder="이름으로 검색" aria-label="Search">
	      		<button class="btn btn-outline-info my-2 my-sm-0" id="btnSearch" type="button" onclick="searchFunction();">
	      			<i class="fas fa-search pr-2"></i>회원검색
	      		</button>
	      		<button class="btn btn-outline-info active shadow-md" id="qnaAdmin" onclick="location.href='${contextPath}/main/adminQnaListPage.do'">
	      			<i class="fas fa-user-edit pr-2"></i>문의내역<i class="far fa-arrow-alt-circle-up pl-2 fa-lg"></i>
	      		</button>
	      		<button class="btn btn-outline-info" id="home" onclick="location.href='${contextPath}/main/home.do'">
	      			<i class="fas fa-home pr-2"></i>HOME
	      		</button>
	    	</div>
		</div>
		<table class="table table-hover" style="text-align: center;">
			<thead>
				<tr>
					<th style="background-color: #dddddd; text-align: center;">이 름</th>
					<th style="background-color: #dddddd; text-align: center;">Email</th>
					<th style="background-color: #dddddd; text-align: center;">생년월일</th>
					<th style="background-color: #dddddd; text-align: center;">포인트</th>
					<th style="background-color: #dddddd; text-align: center;">전화번호</th>
					<th style="background-color: #dddddd; text-align: center; width: 180px;">관 리</th>
				</tr>
			</thead>
			<tbody id="memberListTable">
			</tbody>
		</table>
	</div>
	
<!-- 회원삭제 확인창 모달 ------------------------------------------------------------------------------------------------ -->
<div class="modal fade" id="modalDeleteCheck" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-notify modal-danger" role="document">
    <!--Content-->
    <div class="modal-content">
      <!--Header-->
      <div class="modal-header" style='background-color: #dddddd;'>
        <p class="heading lead">회원삭제 Message</p>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true" class="white-text">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <div class="text-center">
          <i class="fas fa-user-times fa-4x mb-3" style='color: skyblue'></i>
          <p>회원을 삭제하시겠습니까?</p>
        </div>
      </div>
      <div class="modal-footer justify-content-center">
      	<a type="button" class="btn btn-outline-info waves-effect shadow-sm border-info active" data-dismiss="modal">
	      	<i class="fas fa-times pr-4"></i>취소</a>
        <a type="button" class="btn btn-outline-danger waves-effect shadow-sm border-warning active" onclick="deleteFunction();">
        	<i class="fas fa-check pr-3"></i>확인</a>
      </div>
    </div>
    <!--/.Content-->
  </div>
</div>	
<!-- 회원삭제 확인창 모달 ------------------------------------------------------------------------------------------------ -->	

	<%
  	String messageType = null;
	if(session.getAttribute("messageType") != null) {
		messageType = (String) session.getAttribute("messageType");
	}
	String messageContent = null;
	if(session.getAttribute("messageContent") != null) {
		messageContent = (String) session.getAttribute("messageContent");
	}
	if(messageContent != null) {
	%>
	
<!-- 회원삭제 결과 Modal-MemberDelete Result --------------------------------------------------------------------------------- -->
	<div class="modal fade" id="modalDeleteResult" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
	  aria-hidden="true">
	  <div class="modal-dialog modal-notify modal-info" role="document">
	    <!--Content-->
	    <div class="modal-content">
	      <!--Header-->
	      <div class="modal-header" style='background-color: #dddddd;'>
	        <p class="heading lead">${messageType}</p>
	
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true" class="white-text">&times;</span>
	        </button>
	      </div>
	      <!--Body-->
	      <div class="modal-body">
	        <div class="text-center">
	          <i class="fas fa-user-minus fa-4x mb-3" style='color: skyblue'></i>
	          	<p>${messageContent}</p>
	        </div>
	      </div>
	      <!--Footer-->
	      <div class="modal-footer justify-content-center">
	        <a type="button" class="btn btn-outline-info waves-effect shadow-sm active" data-dismiss="modal">
	        	<i class="fas fa-check pr-3"></i>확인</a>
	      </div>
	    </div>
	    <!--/.Content-->
	  </div>
	</div>
<!-- 회원삭제 결과 Modal-MemberDelete Result --------------------------------------------------------------------------------- -->
	
	<script>
		$('#modalDeleteResult').modal("show");
	</script>
	<%	
		session.removeAttribute("messageContent");
		session.removeAttribute("messageType");
		}
	%>

	<script type="text/javascript">
		// 첫화면에  모든 회원목록 출력
		window.onload = function() {
			searchFunction();
		}
	</script>














</body>
</html>