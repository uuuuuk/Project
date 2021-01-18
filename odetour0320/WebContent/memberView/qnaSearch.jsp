<%@ page language="java" contentType="text/html; charset=UTF-8"
    	 pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>QnAList</title>
	<!-- BootStrap CDN -->
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">	
	<!-- CSS PLUS(CDN) -->
	<!-- Font Awesome -->
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
	<!-- Google Fonts -->
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap">
	<!-- Bootstrap core CSS -->
	<link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.4.1/css/bootstrap.min.css" rel="stylesheet">
	
	<style type="text/css">
		#memberAdmin {margin-left: 10px;} 
 		#home {margin-left: 30px;}
	</style>
	
	<script src = "http://code.jquery.com/jquery-latest.min.js"></script>
	<script type="text/javascript">
		var request = new XMLHttpRequest();
		function searchFunction() {
			request.open("Post", "${contextPath}/main/adminQnaSearch.do?email=" + encodeURIComponent(document.getElementById("email").value), true);
			request.onreadystatechange = searchProcess; // 이벤트 발생시 searchProcess 함수 호출
			request.send(null);
		}		
		function searchProcess(){ 
// 			var table = $('#qnaListTable').val();
			var table = document.getElementById("qnaListTable");
			table.innerHTML = "";
			if(request.readyState == 4 && request.status == 200) {
				var object = eval('(' + request.responseText + ')');
				var result = object.result;
				for(var i=0; i<result.length; i++) {
					var row = table.insertRow(0);
					for(var j=0; j<result[i].length; j++) {
						var cell = row.insertCell(j);
						cell.innerHTML = result[i][j].value;
 						// QNA Number
						if(j == 0){
							var btnQnaNum = '<button class="btn btn-outline-info ml-3 my-3 my-sm-0 float-left shadow-md" id="qnaIntoBtn" type="button" onclick="qnaInto(' + result[i][0].value + ');">'+ 'No.' + result[i][0].value + '</button>';
							cell.innerHTML = btnQnaNum;
						}
						// Reply Status
						if(result[i][5].value== "1") {
							result[i][5].value = "답변완료 &nbsp;" + '<i class="fas fa-check fa-lg"></i>';
						}else if(result[i][5].value== "0") {
							result[i][5].value = 
								'<style>'
								+ '#replyAlarm {color:red;}'
								+ '@-webkit-keyframes flash {from, 50%, to {opacity: 1;} 25%, 75% {opacity: 0;}}'
								+ '@keyframes flash {from, 50%, to {opacity: 1;} 25%, 75% {opacity: 0;}}'
								+ '#replyAlarm {-webkit-animation: flash 2s 2s infinite linear alternate;'
								+   'animation: flash 2s 2s infinite linear alternate;' + 'animation-delay : 0s;}'
								+ '</style>' 	
								+ '<span id="replyAlarm">' +"요청중 "+ '<i class="far fa-edit fa-md" style="color:red"></i>' + '</span>';
						}
						// Shortcut Button
						if(j == 6){
							var intoButton = '<button class="btn btn-outline-info my-3 my-sm-0 float-center shadow-md" id="qnaIntoBtn" type="button" value="" onclick="qnaInto(' + result[i][0].value + ');"><i class="fas fa-user-edit"> 답변</button>';
							cell.innerHTML = intoButton;
						}
					}
				}
			}
		}//searchProcess()
		
		function qnaInto(qnaNum){
			location.href="${contextPath}/main/qnaInto.do?qnaNum="+qnaNum;
		}
	</script>
</head>

<body>
	<br>
	<div class="container">
		<div class="form-group">
			<div class="form-inline my-2 my-lg-0">
	      		<input class="form-control mr-sm-2" id="email" onkeyup="searchFunction()" type="text" placeholder="이메일 검색" aria-label="Search">
	      		<button class="btn btn-outline-info my-2 my-sm-0" id="btnSearch" type="button" onclick="searchFunction();">
	      			<i class="fas fa-search pr-2"></i>이메일검색
	      		</button>
	      		<button class="btn btn-outline-info shadow-md active" id="memberAdmin" onclick="location.href='${contextPath}/main/adminSearchPage.do'">
	      			<i class="fas fa-user-friends pr-2"></i>회원관리<i class="far fa-arrow-alt-circle-up pl-2 fa-lg"></i>
	      		</button>
	      		<button class="btn btn-outline-info" id="home" onclick="location.href='${contextPath}/main/home.do'">
	      			<i class="fas fa-home pr-2"></i>HOME
	      		</button>
	    	</div>
		</div>
		<table class="table table-hover" style="text-align: center;">
			<thead>
				<tr>
					<th style="background-color: #dddddd; text-align: center;">No.QnA</th>
					<th style="background-color: #dddddd; text-align: center;">제 목</th>
					<th style="background-color: #dddddd; text-align: center;">Email</th>
					<th style="background-color: #dddddd; text-align: center;">작성자</th>
					<th style="background-color: #dddddd; text-align: center;">작성일</th>
					<th style="background-color: #dddddd; text-align: center;">답변유무</th>
					<th style="background-color: #dddddd; text-align: center;">바로가기</th>
				</tr>
			</thead>
			<tbody id="qnaListTable">
			</tbody>
		</table>
	</div>
	
	<!-- BootStrap CDN -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
	
	<script type="text/javascript">
		// 첫화면에  모든 QNA목록 출력
		window.onload = function() {
			searchFunction();
		}
	</script>
	
</body>
</html>