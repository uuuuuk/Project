
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="airlineList" value="${airlineInfo.dep}" />
<c:set var="airlineList2" value="${airlineInfo.dep2}" />
<c:set var="parkList" value="${airlineInfo.parkList}" />
<c:set var="parkList2" value="${airlineInfo.parkList2}" />
<%-- <c:set var="wIcon" value='http://openweathermap.org/img/wn/${wIcon}.png'/> --%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>항공권 조회</title>

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<!-- 아이콘 -->
<script src='https://kit.fontawesome.com/a076d05399.js'></script>
<!-- JQuery CDN 연동 -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- 아임포트(결제 API) JQuery CDN -->
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<!-- Bootstrap JS -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>

<script>
	// 아임포트(결제API)	-	https://admin.iamport.kr/
	// 아임포트 사용방법		-	https://www.iamport.kr/getstarted
	// 아임포트 매뉴얼		-	https://docs.iamport.kr/
	/*
		pg(결제대행)						pay_method(결제방식)
		
		'kakao':카카오페이,				'samsung':삼성페이,
		'html5_inicis':이니시스(웹표준결제)	'card':신용카드,
		'nice':나이스페이					'trans':실시간계좌이체,
		'jtnet':제이티넷					'vbank':가상계좌,
		'uplus':LG유플러스				'phone':휴대폰소액결제
		'danal':다날
		'payco':페이코
		'syrup':시럽페이
		'paypal':페이팔
	*/
	
	/* 결제 */
	function payment() {
				
		var payUid = document.getElementById('pay1VihicleId').innerHTML;
		var payName = document.getElementById('pay1Name').innerHTML;
		var payAmount = Number(document.getElementById('pay1Amount').innerHTML);
		
		if(document.getElementById('pay2VihicleId') != null){
			payUid += "&" + document.getElementById('pay2VihicleId').innerHTML;
			payName += "&" + document.getElementById('pay2Name').innerHTML;
			payAmount += Number(document.getElementById('pay2Amount').innerHTML);
		}
			
		var IMP = window.IMP; 		// 생략가능
		IMP.init("imp78062500"); 	// 가맹점 식별코드 (코드확인 : 아임포트 관리자페이지 -> 내정보 -> 가맹점식별코드)

		IMP.request_pay({
			pg : 'danal' ,														// PG사(결제대행사)
			pay_method : 'card',												// 결제방식
			merchant_uid : payUid + new Date().getTime(),					// 결제 시 고유 주문번호(결제가 된 적이 있는 merchant_uid로는 결제 불가)
            
			name : payName,   												// 구매할 상품명
			amount : payAmount,												// 가격
            
			buyer_email : 'ODE@tour.com',										// 판매자 이메일
			buyer_name : 'ODE TOUR',											// 판매자 이름
			buyer_tel : '051) 803 - 0909',										// 판매자 전화번호
			buyer_addr : '부산 부산진구 동천로 109 삼한골든게이트 7층',						// 판매자 주소
			buyer_postcode : '211-0005',										// 판매자 우편번호
        	
			m_redirect_url : 'https://www.yourdomain.com/payments/complete'		// 결제 완료 후 보낼 컨트롤러의 메서드명 (*임의 변경 시 오작동)
            
		}, function(rsp) {
			console.log(rsp);
			if (rsp.success) {
				var msg = '결제가 완료되었습니다.';
				msg += '고유ID : ' 		+ rsp.imp_uid;
				msg += '상점 거래ID : '	+ rsp.merchant_uid;
				msg += '결제 금액 : ' 		+ rsp.paid_amount;
				msg += '카드 승인번호 : ' 	+ rsp.apply_num;
			} else {
				var msg = '결제에 실패하였습니다.';
				msg += '에러내용 : ' 		+ rsp.error_msg;
			}
			alert(msg);
		});
	}
			var searchDay;
		   window.onload = function(){
			searchDay = $("#depTime").val(); // 가는 날 최초 검색 날짜
			searchDay2 = $("#arrTime").val(); // 오는 날 최초 검색 날짜
		   };
		
		   function plusDateChange(depTime) {         // 날짜(String -> (Date + 1) -> String
			      var year = depTime.substr(0,4);
			      var month = depTime.substr(4,2);
			      var day = depTime.substr(6,2);
			      
			      var date = new Date(year, month-1, day);
			      
			      date.setDate(date.getDate() + 1);
			      
			      year = date.getFullYear();
			      month = date.getMonth() + 1;
			       if(month<10) month = '0' + month;
			       date = date.getDate();
			       if(date<10) date = '0' + date;

			       return year + month + date;
			   }
		   function minusDateChange(depTime) { // 날짜(String -> (Date + 1) -> String
				  var year = depTime.substr(0,4);
			      var month = depTime.substr(4,2);
			      var day = depTime.substr(6,2);
			      
			      var date = new Date(year, month-1, day);
			      
			      date.setDate(date.getDate() - 1);
			      
			      year = date.getFullYear();
			      month = date.getMonth() + 1;      
			       if(month<10) month = '0' + month;
			       date = date.getDate();
			       if(date<10) date = '0' + date;

			       return year + month + date;
			   }
		/* 이전날짜 항공권 조회 */
	function prevDay(depAirportNm , arrAirportNm) {
		var prevDay;

			if('${airlineList[0].depAirportNm}' == depAirportNm){
					prevDay = minusDateChange(searchDay);
					searchDay = prevDay;
			}
			else{
				if(searchDay == searchDay2 - 1){
					alert("가는 날과 오는 날이 겹칠 수 없습니다");
					return;
				}
				else{
					prevDay = minusDateChange(searchDay2);
					searchDay2 = prevDay;
				}
			}
			$.ajax({
	 	 		type:'post',
	   	 		dataType:'json',
	 	 		mimeType:'application/json',  
	 	 		url:'${contextPath}/main/airPlaneResearch.do',
	 	 		 data:{
	 	 			'depAirportNm' : depAirportNm, 
	 	 			'arrAirportNm' : arrAirportNm, 
	 	 			'depPlandTime' : prevDay },
	  	 		success: function(data) {
	  				console.log(data);
	  	 		}
	 	 	}).done(function (data){
				if('${airlineList[0].depAirportNm}' == depAirportNm){
					$("#depDay").empty();
					for(var i = 0 ; i < data.length ; i++){
						var airline = data[i];
						document.getElementById('depDay').innerHTML += 
							"<div class='row border rounded-lg shadow mb-2 text-center alert-info' style='font-size: 20px;'>" +
							"<div class='col-1 m-auto'>" +
								"<img src='../images/"+ airline.airlineImg +"' width='80px'>" +
							"</div>" +
							"<div class='col m-auto'>" +
								"<small>" + airline.depAirportNm + "&nbsp;<i class='fas fa-plane'></i>&nbsp;" + airline.arrAirportNm + "</small>" +
								"<br>" +
								airline.airlineNm + airline.vihicleId +
							"</div>" +
							"<div class='col m-auto'>" +
								airline.depDate +
								"<br>" +
								airline.depPlandTime + "&nbsp;─&nbsp; " + airline.arrPlandTime +
							"</div>" +
							"<div class='col m-auto'>" +
							 "￦" + airline.economyCharge + 
	 						"</div>" +
							"<div class='col-2 m-auto' align='right'>" +
  								"<input type='button' value='선택' class='btn btn-outline-dark' onclick=\"onwaySelected('" + airline.airlineNm + "'," +
																	"'" + airline.vihicleId + "'," +
																"'" + airline.depDate + "'," +
																 "'" + airline.depPlandTime + "'," +
																 "'" + airline.arrPlandTime + "'," +
																 "'" + airline.economyCharge + "')\">" +
 							"</div>" +
						"</div>";					
					}
				}
				else{
					$("#arrDay").empty();
					for(var i = 0 ; i < data.length ; i++){
						var airline = data[i];
						document.getElementById('arrDay').innerHTML += 
							"<div class='row border rounded-lg shadow mb-2 text-center alert-info' style='font-size: 20px;'>" +
							"<div class='col-1 m-auto'>" +
								"<img src='../images/"+ airline.airlineImg +"' width='80px'>" +
							"</div>" +
							"<div class='col m-auto'>" +
								"<small>" + airline.depAirportNm + "&nbsp;<i class='fas fa-plane'></i>&nbsp;" + airline.arrAirportNm + "</small>" +
								"<br>" +
								airline.airlineNm + airline.vihicleId +
							"</div>" +
							"<div class='col m-auto'>" +
								airline.depDate +
								"<br>" +
								airline.depPlandTime + "&nbsp;─&nbsp; " + airline.arrPlandTime +
							"</div>" +
							"<div class='col m-auto'>" +
							 "￦" + airline.economyCharge + 
	 						"</div>" +
							"<div class='col-2 m-auto' align='right'>" +
								"<input type='button' value='선택' class='btn btn-outline-dark' onclick=\"roundtripSelected('" + airline.airlineNm + "'," +
																													"'" + airline.vihicleId + "'," +
																													 "'" + airline.depDate + "'," +
																													 "'" + airline.depPlandTime + "'," +
																													 "'" + airline.arrPlandTime + "'," +
																													 "'" + airline.economyCharge + "')\">" +
							"</div>" +
						"</div>";					
					}
				}
	 	 	});
	}
	
	/* 다음날짜 항공권 조회 */
	function nextDay(depAirportNm , arrAirportNm) {
		var aftDay;
			if('${airlineList[0].depAirportNm}' == depAirportNm){
				if(searchDay == searchDay2 - 1){
					alert("가는 날과 오는 날이 겹칠 수 없습니다");
					return;
				}
				else{
				aftDay = plusDateChange(searchDay);
				searchDay = aftDay;
				}
			}
			else{
					aftDay = plusDateChange(searchDay2);
					searchDay2= aftDay;
			}
		 	 $.ajax({
		 		type:'post',
	  	 		dataType:'json',
		 		mimeType:'application/json',  
		 		url:'${contextPath}/main/airPlaneResearch.do',
		 		 data:{
		 			'depAirportNm' : depAirportNm, 
		 			'arrAirportNm' : arrAirportNm, 
		 			'depPlandTime' : aftDay },
	 	 		success: function(data) {
	 				console.log(data);
	 	 		}
		 	}).done(function (data){
				if('${airlineList[0].depAirportNm}' == depAirportNm){
					$("#depDay").empty();
					for(var i = 0 ; i < data.length ; i++){
						var airline = data[i];
						document.getElementById('depDay').innerHTML += 
							"<div class='row border rounded-lg shadow mb-2 text-center alert-info' style='font-size: 20px;'>" +
							"<div class='col-1 m-auto'>" +
								"<img src='../images/"+ airline.airlineImg +"' width='80px'>" +
							"</div>" +
							"<div class='col m-auto'>" +
								"<small>" + airline.depAirportNm + "&nbsp;<i class='fas fa-plane'></i>&nbsp;" + airline.arrAirportNm + "</small>" +
								"<br>" +
								airline.airlineNm + airline.vihicleId +
							"</div>" +
							"<div class='col m-auto'>" +
								airline.depDate +
								"<br>" +
								airline.depPlandTime + "&nbsp;─&nbsp; " + airline.arrPlandTime +
							"</div>" +
							"<div class='col m-auto'>" +
							 "￦" + airline.economyCharge + 
							"</div>" +
							"<div class='col-2 m-auto' align='right'>" +
							"<input type='button' value='선택' class='btn btn-outline-dark' onclick=\"onwaySelected('" + airline.airlineNm + "'," +
																													"'" + airline.vihicleId + "'," +
																													 "'" + airline.depDate + "'," +
																													 "'" + airline.depPlandTime + "'," +
																													 "'" + airline.arrPlandTime + "'," +
																													 "'" + airline.economyCharge + "')\">" +
							"</div>" +
						"</div>";					
					}
				}
	 			else{
					$("#arrDay").empty();
					for(var i = 0 ; i < data.length ; i++){
						var airline = data[i];
						document.getElementById('arrDay').innerHTML += 
							"<div class='row border rounded-lg shadow mb-2 text-center alert-info' style='font-size: 20px;'>" +
							"<div class='col-1 m-auto'>" +
								"<img src='../images/"+ airline.airlineImg +"' width='80px'>" +
							"</div>" +
							"<div class='col m-auto'>" +
								"<small>" + airline.depAirportNm + "&nbsp;<i class='fas fa-plane'></i>&nbsp;" + airline.arrAirportNm + "</small>" +
								"<br>" +
								airline.airlineNm + airline.vihicleId +
							"</div>" +
							"<div class='col m-auto'>" +
								airline.depDate +
								"<br>" +
								airline.depPlandTime + "&nbsp;─&nbsp; " + airline.arrPlandTime +
							"</div>" +
							"<div class='col m-auto'>" +
							 "￦" + airline.economyCharge + 
							"</div>" +
							"<div class='col-2 m-auto' align='right'>" +
								"<input type='button' value='선택' class='btn btn-outline-dark' onclick=\"roundtripSelected('" + airline.airlineNm + "'," +
																													"'" + airline.vihicleId + "'," +
																													 "'" + airline.depDate + "'," +
																													 "'" + airline.depPlandTime + "'," +
																													 "'" + airline.arrPlandTime + "'," +
																													 "'" + airline.economyCharge + "')\">" +
							"</div>" +
						"</div>";					
					}
				} 
		 	});
	}
		
	/* 가는날 항공권 선택 시 사이드배너에 추가 */
	function onwaySelected(airlineNm, vihicleId, depDate, depPlandTime, arrPlandTime, economyCharge) {
		document.getElementById('pay1sel').innerHTML = '<div class="alert alert-info">' +
															'<button type="button" class="close" data-dismiss="alert" aria-label="Close">' +
																'<span aria-hidden="true">&times;</span>' +
															'</button>' +
															'<p><span id="pay1Name">' + airlineNm + '</span>(<span id="pay1VihicleId">' + vihicleId + '</span>)</p>' + 
															'<p>' + depDate + '&nbsp;&nbsp;&nbsp;&nbsp;' + depPlandTime + ' - ' + arrPlandTime + '</p>' +
															'<h5 align="right">￦<span id="pay1Amount">' + economyCharge + '</span></h5>' +
														'</div>';
	}
	
	/* 오는날 항공권 선택 시 사이드배너에 추가 */
	function roundtripSelected(airlineNm, vihicleId, depDate, depPlandTime, arrPlandTime, economyCharge) {
		document.getElementById('pay2sel').innerHTML =	'<div class="alert alert-info">' +
															'<button type="button" class="close" data-dismiss="alert" aria-label="Close">' +
																'<span aria-hidden="true">&times;</span>' +
															'</button>' +
															'<p><span id="pay2Name">' + airlineNm + '</span>(<span id="pay2VihicleId">' + vihicleId + '</span>)</p>' + 
															'<p>' + depDate + '&nbsp;&nbsp;&nbsp;&nbsp;' + depPlandTime + ' - ' + arrPlandTime + '</p>' +
															'<h5 align="right">￦<span id="pay2Amount">' + economyCharge + '</span></h5>' +
														'</div>';
	}
	
	$(function() {
		/* 사이드 플로팅배너 */
		var floatPosition = parseInt($("#floatMenu").css('top')); // floatMenu의 CSS top값을 가져와 floatPosition에 저장
		$(window).scroll(function() {
			var scrollTop = $(window).scrollTop(); // 현재 스크롤 위치를 가져옴
			var newPosition = scrollTop + floatPosition + "px";

			// $("#floatMenu").css('top', newPosition); // 애니메이션 없이 상단에 고정
			$("#floatMenu").stop().animate({
				"top" : newPosition
			}, 300);

		}).scroll();
		
	});
	
</script>

<style type="text/css">
/* 플로팅배너 CSS 설정*/
#floatMenu {	
	position: absolute;
	width: 200px;
	height: 200px;
	left: 20px;
	top: 10px;
}
</style>

</head>
<body>
<!-- 조회결과 END -->
<div id="test"></div>
<div class="row">
	<div class="container col p-5">
		<!-- 가는날 항공편 조회결과 -->
		<h1>
			<span class="badge p-3" style="background: #ccc;">
				<i class='fas fa-plane-departure'></i>${airlineList[0].depAirportNm}
				&nbsp;&nbsp;<i class='fas fa-minus'></i>&nbsp;&nbsp;
				<i class='fas fa-plane-arrival'></i>${airlineList[0].arrAirportNm}
			</span>
			<span class="ml-3">
		  		<button type="button" id="home" class="btn btn-outline-info active bg-lg shadow-sm" onclick="location.href='${contextPath}/main/home.do';"><i class="fas fa-home"></i><br>H O M E</button>
			</span>
		</h1>
		<h3 align="center" class="bg-dark text-white rounded p-2">
			<i class='fas fa-angle-left' onclick="prevDay('${airlineList[0].depAirportNm}','${airlineList[0].arrAirportNm}')"></i>
			&nbsp;&nbsp;가는날&nbsp;&nbsp;
			<input type="hidden" id="depTime" value="${airlineList[0].depTime}">
			<i class='fas fa-angle-right' onclick="nextDay('${airlineList[0].depAirportNm}','${airlineList[0].arrAirportNm}')"></i>
		</h3>
		<div class="container mb-5" id="depDay">
			<c:choose>
				<c:when test="${airlineList != null}">
					<c:forEach var="airLine" items="${airlineList}">
						<div class="row border rounded-lg shadow mb-2 text-center alert-info" style="font-size: 20px;">
							<div class="col-1 m-auto">
								<img src="../images/${airLine.airlineImg}" width="80px">
							</div>
							<div class="col m-auto">
								<small>${airLine.depAirportNm}&nbsp;<i class='fas fa-plane'></i>&nbsp;${airLine.arrAirportNm}</small>
								<br>
								${airLine.airlineNm}(${airLine.vihicleId})
							</div>
							<div class="col m-auto">
								${airLine.depDate}
								<br>
								${airLine.depPlandTime}&nbsp;─&nbsp;${airLine.arrPlandTime}
							</div>
							<div class="col m-auto">
								￦<fmt:formatNumber value="${airLine.economyCharge}" type="number"/>
							</div>
							<div class="col-2 m-auto" align="right">
								<input type="button" value="선택" class="btn btn-outline-dark" onclick="onwaySelected('${airLine.airlineNm}', 
																													 '${airLine.vihicleId}',
																													 '${airLine.depDate}',
																													 '${airLine.depPlandTime}',
																													 '${airLine.arrPlandTime}',
																													 '${airLine.economyCharge}')">
							</div>
						</div>
					</c:forEach>
				</c:when>
			</c:choose>
		</div>
		
		<!-- 오는날 항공편 조회결과 -->
		<c:choose>
			<c:when test="${airlineList2 != null}">
				<h1>
					<span class="badge p-3" style="background: #ccc;">
						<i class='fas fa-plane-departure'></i>${airlineList[0].arrAirportNm}
						&nbsp;&nbsp;<i class='fas fa-minus'></i>&nbsp;&nbsp;
						<i class='fas fa-plane-arrival'></i>${airlineList[0].depAirportNm}
					</span>
				</h1>
				<h3 align="center" class="bg-dark text-white rounded p-2">
					<i class='fas fa-angle-left' onclick="prevDay('${airlineList2[0].depAirportNm}','${airlineList2[0].arrAirportNm}')"></i>
					&nbsp;&nbsp;오는날&nbsp;&nbsp;
				<input type="hidden" id="arrTime" value="${airlineList2[0].depTime}">
					<i class='fas fa-angle-right' onclick="nextDay('${airlineList2[0].depAirportNm}','${airlineList2[0].arrAirportNm}')"></i>
				</h3>
				<div class="container mb-5" id="arrDay">
					<c:forEach var="airLine2" items="${airlineList2}">
						<div class="row border rounded-lg shadow mb-2 text-center alert-info" style="font-size: 20px;">
							<div class="col-1 m-auto">
								<img src="../images/${airLine2.airlineImg}" width="80px">
							</div>
							<div class="col m-auto">
								<small>${airLine2.depAirportNm}&nbsp;<i class='fas fa-plane'></i>&nbsp;${airLine2.arrAirportNm}</small>
								<br>
								${airLine2.airlineNm}(${airLine2.vihicleId})
							</div>
							<div class="col m-auto">
								${airLine2.depDate}
								<br>
								${airLine2.depPlandTime}&nbsp;─&nbsp;${airLine2.arrPlandTime}
							</div>
							<div class="col m-auto">
								￦<fmt:formatNumber value="${airLine2.economyCharge}" type="number"/>
							</div>
							<div class="col-2 m-auto" align="right">
								<input type="button" value="선택" class="btn btn-outline-dark" onclick="roundtripSelected('${airLine2.airlineNm}', 
																														 '${airLine2.vihicleId}',
																														 '${airLine2.depDate}',
																													 	 '${airLine2.depPlandTime}',
																													 	 '${airLine2.arrPlandTime}',
																														 '${airLine2.economyCharge}')">
							</div>
						</div>
					</c:forEach>
				</div>
				</c:when>
			</c:choose>
		<!-- 항공권 조회결과 END -->
		<!-- 주차 조회결과 -->
		<div class="row">
			<div class="col">
				<c:choose>
					<c:when test="${parkList != null}">
						<h3>
							<i class='fas fa-car-side'></i>${airlineList[0].depAirportNm}공항 주차현황
							<small class="text-black-50">(${parkList[0].parkingGetdate} ${parkList[0].parkingGettime})</small>
						</h3>
						<table class="table">
							<tr class="thead-dark" align="center">
								<th width="30%">주차장명</th>
								<th>총주차공간</th>
								<th>현재 주차수</th>
								<th style="color: yellow">주차 가능수</th>
							</tr>
							<c:forEach var="park" items="${parkList}">
								<tr align="center">
									<td>${park.parkingAirportCodeName}</td>
									<td>${park.parkingFullSpace}</td>
									<td>${park.parkingIstay}</td>
									<td style="color: red">${park.parkingIempty}</td>
								</tr>
							</c:forEach>
						</table>
					</c:when>
				</c:choose>
				</div>
				<div class="col">
				<c:choose>
					<c:when test="${parkList2 != null}">
						<h3>
							<i class='fas fa-car-side'></i>${airlineList2[0].depAirportNm}공항 주차현황
							<small class="text-black-50">(${parkList2[0].parkingGetdate} ${parkList2[0].parkingGettime})</small>
						</h3>
						<table class="table">
							<tr class="thead-dark" align="center">
								<th width="30%">주차장명</th>
								<th>총주차공간</th>
								<th>현재 주차수</th>
								<th style="color: yellow">주차 가능수</th>
							</tr>
							<c:forEach var="park" items="${parkList2}">
								<tr align="center">
									<td>${park.parkingAirportCodeName}</td>
									<td>${park.parkingFullSpace}</td>
									<td>${park.parkingIstay}</td>
									<td style="color: red">${park.parkingIempty}</td>
								</tr>
							</c:forEach>
						</table>
					</c:when>
				</c:choose>
			</div>
		</div>
		<!-- 주차 조회결과 END -->
	</div>
	<!-- 사이드배너 -->
	<div class="col-3">
		<div id="floatMenu" class="p-3">
			<div class="card bg-light" style="width: 18rem;">
			  <div class="card-body">
			    <h5 class="card-title">선택한 항공편</h5>
			    <h6 class="card-subtitle mb-2 text-muted" id="sideText">항공편을 확인해주세요.</h6>
				    <div id="pay1sel"></div>
				    <div id="pay2sel"></div>
			    <input type="button" id="pay" value="결제" class="btn btn-dark btn-block" onclick="payment()">
			  </div>
			</div><br>
		</div>
	</div>
	<!-- 사이드배너 END -->
</div>
<!-- 조회결과 END -->
</body>
</html>