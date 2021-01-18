<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    	 pageEncoding="UTF-8"%>
<%@ page language="java" import="java.net.InetAddress" %>
<%@ include file="../totalScriptCSS.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% 
	request.setCharacterEncoding("UTF-8"); 
	SimpleDateFormat timeFormatter = new SimpleDateFormat("HH:mm");
	String writeTime = timeFormatter.format(new java.util.Date());
%>
<c:set var="sessionEmail" value="${sessionScope.email}"/>
<c:set var="sessionName" value="${sessionScope.name}"/>
<c:set var="sessionDomain" value="${sessionScope.domain}"/>
<c:set var="messageType" value="${sessionScope.messageType}"/>
<c:set var="messageContent" value="${sessionScope.messageContent}"/>
<% String sessionName = (String) session.getAttribute("name"); %>

<!-- contextPath -->
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1">
   <title>loginHeader</title>
   

<script type="text/javascript">
   var yearFlag = 0;
   var monthFlag = 0;
   var dayFlag = 0;
		
   var sessionEmail ;
   var passCheck = false;
   var rewritePassCheck = false;
   var emailCheck = false;
   var emailAuthCheck = false;
      function allPassCheck(){
		 var email = $("#email").val();
		 var emailDomain = $("#emailDomain").val();
		 var totalEmail = email + emailDomain;
		 var name = $("#name").val();
		 var pwd = $("#pwd1").val();
    	 var year = $("#year").val();
		 var month = $("#month").val();
		 var day = $("#day").val();
		 var birth = year +"."+ month + "." + day;
		 var tel = $("#tel").val();
         if(passCheck == false){
            alert("비밀번호를 동일하게 입력하여 주세요.");
         }
         else if(emailCheck == false){
            alert("이메일 중복 체크를 완료하여 주세요");
         }
         else if(emailAuthCheck == false){
            alert("이메일 인증을 완료하여 주세요");
         }
         else{
             $.ajax(
                     {
                          type:"post", 
                          url:"${contextPath}/main/memberAdd.do",
                          data:{"email" : totalEmail,
                        	  	"name" : name,
                        	  	"pwd" : pwd,
                        	  	"birth" : birth,
                        	  	"tel" : tel},
                          success:function(result){
	     					alert("회원가입 완료");
    						if(result == "1"){
    				              $.ajax(
    				                      {
    				                           type:"post", 
    				                           url:"${contextPath}/main/memberLoginChk.do",
    				                           data:{"email" : totalEmail,
    				                         	  	 "pwd" : pwd},
    				                           success:function(data){
    				     						if(data == "1"){
    				     							location.href="${contextPath}/main/home.do";
    				     						}
    				                           }
    				                      }
    				                ); 
    						}
    						else{
    							alert("회원가입에 실패 하였습니다");
    						}
                          }
                     }
               ); 
         }
      }
      $(function(){
      $('#pwd2').blur(function() {
          if($('#pwd1').val() == $(this).val()){
             $('#pwd2').attr('class', 'form-control mt-3 is-valid');
             passCheck = true;
          }else{
             $('#pwd2').attr('class', 'form-control mt-3 is-invalid').focus();
          }
       });      
      });
      $(function(){
          $('#rewritePwd2').blur(function() {
              if($('#rewritePwd1').val() == $(this).val()){
                 $('#rewritePwd2').attr('class', 'form-control mt-3 is-valid');
                 rewritePassCheck = true;
              }else{
                 $('#rewritePwd2').attr('class', 'form-control mt-3 is-invalid').focus();
              }
           });      
          });
      // 공백 체크 후 제거
      function spaceCheck(obj){
         var text = $(obj).val().replace(/\s/gi,"");
         $(obj).val(text);
       }
      //이메일 형식 및 중복 검사
      function emailTest(){
         var email = $("#email").val();
         var emailDomain = $("#emailDomain").val();
         var totalEmail = email + emailDomain;
         var getMail = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/);
         if (!getMail.test(totalEmail)) {
            window.alert("이메일 형식에 맞게 입력하여 주세요");
            $("#emailCheckResult").css("color","red");
            $("#emailCheckResult").text("이메일 사용 불가");
            return false;
         }
         else{
            $.ajax(
                  {
                     type:"post", //요청방식을 설정 합니다(post 또는 get 방식으로 선택)
                       url:"${contextPath}/main/memberEmailDuplChk.do",//요청할 서블릿의 매핑주소 또는 JSP의 주소 
/*                     url:"${contextPath}/member/emailDuplChk.do", */
                       data:{"email" : $('#email').val(),
                            "emailDomain" : $("#emailDomain").val()},//서블릿 또는 JSP페이지로 요청할 데이터 설정
                       success:function(data){
                             if(data == "0"){
                              $("#emailCheckResult").css("color","green");
                              $("#emailCheckResult").text("이메일 사용 가능 && ");
                              emailCheck = true;
                           }
                           else{
                              $("#emailCheckResult").css("color","red");
                              $("#emailCheckResult").text("이메일 사용 불가");
                              emailCheck = false;
                           }
                       }
                  }
            );
         }
      }
      function emailAuthTag(){
         var email = $("#email").val();
         var emailDomain = $("#emailDomain").val();
         var totalEmail = email + emailDomain;
         if(emailCheck == false){
            alert("이메일 중복체크를 완료하여 주세요");            
         }
         else{
            const str = 
        	    '<div class="md-form form-sm mt-0" id="emailArea">' +
					'<div class="input-group mb-5" id="emailArea">' +
                		'<i class="fas fa-lock prefix"></i>'+
                		'<input type="text" id="userAuthNum" name="userAuthNum" class="form-control form-control-lg validate" placeholder=" 6자리 이상의 정수 입력" onkeyup="spaceCheck(this);">' +
				  		'<div class="input-group-append">' +
							'<input type="button" id="btnAuthNumCheck" class="btn btn-outline-primary btn-sm" onclick="emailAuthNumCheck();" value="인증번호 확인">' +
	   			  		'</div>' +
              		'</div>' +
          		'</div>' ;
            $("#emailAuthTag").append(str);
            $("#btnEmailAuth").attr("disabled","disabled");
            $.ajax(
                  {
                       type:"post", //요청방식을 설정 합니다(post 또는 get 방식으로 선택)
                       url:"${contextPath}/main/memberEmailAuthNumSend.do",
                       /* url:"${contextPath}/member/emailAuthNumSend.do", */
                       data:{"totalEmail" :totalEmail},//서블릿 또는 JSP페이지로 요청할 데이터 설정
                       success:function(data){
                    	  adminAuthNum = data;
                          alert("인증번호 전송 완료" + data);
                        }
                  }
            );
         }
      }
      function emailAuthNumCheck(){
         var userAuthNum = $("#userAuthNum").val();
		 alert("adminAuthNum : " + adminAuthNum);
         if(userAuthNum == adminAuthNum){
        	 alert("인증번호 확인 완료");
	         $("#emailAuthCheckResult").css("color","green");
	         $("#emailAuthCheckResult").text("이메일 인증 완료");
	         emailAuthCheck = true;
	     }
         else{
        	 alert("인증번호를 확인하여 주세요");
         }
     }
     function loginCheck(){
    	 var email = $("#modalLRInput10").val();
    	 var pwd = $("#modalLRInput11").val();
              $.ajax(
                 {
                      type:"post", 
                      url:"${contextPath}/main/memberLoginChk.do",
                      data:{"email" : email,
                    	  	"pwd" : pwd},
                      success:function(data){
						if(data == "1"){
							location.href="${contextPath}/main/home.do";
						}
						else {
							$("#modalLoginCheck").modal("show");
							$("#modalLRInput10").val("");
							$("#modalLRInput11").val("");
							return;
						}
                      }
                 }
           ); 
    }
     function appendYear(){
    		var date = new Date();
    		var year = date.getFullYear();
    		var selectValue = document.getElementById("year");
    		var optionIndex = 0;
			if(yearFlag == 0){
	    		for(var i=year-100;i<=year;i++){
	    				selectValue.add(new Option(i+"년",i),optionIndex++);                        
	    		}
				yearFlag = 1;
			}
    	}
    	function appendMonth(){
    		var selectValue = document.getElementById("month"); 
    		var optionIndex = 0;
			
    		if(monthFlag == 0){
	    		for(var i=1;i<=12;i++){
	    				if(i < 10){
			    			selectValue.add(new Option( i+"월","0" + i),optionIndex++);
	    				}
	    				else{
			    			selectValue.add(new Option(i+"월",i),optionIndex++);
	    				}
	    		}
    			monthFlag = 1;
    		}
    	}
    	function appendDay(){
    		var selectValue = document.getElementById("day");
    		var optionIndex = 0;
			if(dayFlag == 0){
	    		for(var i=1;i<=31;i++){
	    			if(i < 10){
	    				selectValue.add(new Option(i+"일","0" + i),optionIndex++);
	    			}
	    			else{
	    				selectValue.add(new Option(i+"일",i),optionIndex++);
	    			}
	    		}
	    		dayFlag = 1;
			}
    	}
    	function memberDelete(){
            $.ajax(
                    {
                         type:"post", 
                         url:"${contextPath}/main/memberDelete.do",
                         success:function(data){
                        	 if(data == "1"){
                        	 location.href="${contextPath}/main/home.do";
                         	}
                       	}
                    });
    		/* location.href = "${contextPath}/member/memberDelete.do"; */
    	}
    	function memberInfo(){
            $.ajax(
                    {
                         type:"post", 
                         dataType: "json",
                         mimeType: "application/json",
                         url:"${contextPath}/main/memberMypageInfo.do",
                         success:function(data){
                         }
                    }).done(function (result){
                    		$("#memberEmail").attr("value",result.email);
                    		$("#memberName").attr("value",result.name);
                    		$("#memberBirth").attr("value",result.birth);
                    		$("#memberTel").attr("value",result.tel);
                    		$("#memberPoint").attr("value",result.point)
                    });
            
    	}
    	function memberRewritePwd(){
    		var rewritePasswd = $("#rewritePwd2").val();
    		if(rewritePassCheck == true){
	              $.ajax(
	                      {
	                           type:"post", 
	                           url:"${contextPath}/main/memberRewritePwd.do",
	                           data:{"pwd" : rewritePasswd},
	                           success:function(data){
	     						if(data == "1"){
	     							alert("비밀번호 수정 완료");
	     						}
	                           }
	                      }
	                ); 
    		}
    	}
    	function getUserQnaList(){
			var sessionEmail = '${sessionEmail}';
            $.ajax({
                         type:"post", 
                         dataType: "json",
                         mimeType: "application/json",
                         url:"${contextPath}/main/getQnaList.do",
                         data:{"email" : sessionEmail},
                         success:function(data){
                         }
                    }).done(function (data){
						$("#qnaListArea").empty();
						var qnaListTitle = "" + 
						"<tr>" +
							"<th style='text-align: center;'>" +"작성일"+ "</th>" +
							"<th style='text-align: center;'>" +"제 목"+ "</th>" +
							"<th style='text-align: center;'>" +"답변유무"+ "</th>" +
						"</tr>";
						$('#qnaListArea').append(qnaListTitle);
                    	for(var i = 0 ; i < data.length ; i++){
                    		if(data[i].adminCheck.toString() == "1") {
    							data[i].adminCheck = "답변완료 " + '<i class="fas fa-check fa-lg"></i>';
    						}else if(data[i].adminCheck.toString() == "0") {
    							data[i].adminCheck = "확인중 " + '<i class="fas fa-spinner fa-spin fa-lg"></i>';
    						}
                    	var qnaVO = "" +				
/* onClick='location.href='${contextPath}/main/qnaInto.do?qnaNum='" + data[i].qnaNum + "'*/
						"<tr>" +
							"<th style='background-color: #eeeeee; text-align: center;'>"+ data[i].writeDate +"</th>" +
							"<th style='background-color: #eeeeee; text-align: center;'><a href='${contextPath}/main/qnaInto.do?qnaNum="+ data[i].qnaNum +"'>"+ data[i].title +"</a></th>" +
							"<th style='background-color: #eeeeee; text-align: center;'>"+ data[i].adminCheck +"</th>" +
						"</tr>";
						$("#qnaListArea").append(qnaVO);
                    	}
                    }); 
    	}
    	$(function(){
			unreadList();
			var contentElement = document.getElementById("messageArea");
			  <% if (application.getAttribute("message") != null) {%>
			  contentElement.innerHTML = "<%=application.getAttribute("message")%>";
			  <% }%>
        });
        function unreadList(){
        	var sessionEmail = '${sessionScope.email}';
        	if(sessionEmail != "admin@odetour.com" || sessionEmail == ""){
                $.ajax({
                    type:"post", 
                    dataType: "json",
                    mimeType: "application/json",
                    url:"${contextPath}/main/getInformList.do",
                    data:{"email" : sessionEmail},
                    success:function(data){
                    	showUnread(data.length);
                    	console.log(data);
                    	for(var i = 0 ; i < data.length ; i++){
        					var qnaVO = "";				
							if(data[i].adminCheck == "1") {
								data[i].adminCheck = 
									'<style>'
									+ '#replyAlarm'
									+ '@-webkit-keyframes flash {from, 50%, to {opacity: 1;} 25%, 75% {opacity: 0;}}'
									+ '@keyframes flash {from, 50%, to {opacity: 1;} 25%, 75% {opacity: 0;}}'
									+ '#replyAlarm {-webkit-animation: flash 2s 2s infinite linear alternate;'
									+   'animation: flash 2s 2s infinite linear alternate;' + 'animation-delay : 0s;}'
									+ '</style>' 	
									+ '<span id="replyAlarm">' + "답변완료 " + '<i class="fas fa-check fa-lg"></i>' + '</span>';	                    	
							}
                    	}
                    }
               }).done(function (data){
					$("#informReplyArea").empty();
					var alarmTitle = "" +
					"<tr>" +
						"<th text-align: center;'>" +"작성일"+ "</th>" +
						"<th text-align: center;'>" +"제 목"+ "</th>" +
						"<th text-align: center;'>" +"답변유무"+ "</th>" +
					"</tr>";
					$('#informReplyArea').append(alarmTitle);
                	for(var i = 0 ; i < data.length ; i++){
					var qnaVO = "" +
					"<tr>" +
						"<th style='background-color:#eeeeee; text-align: center;'>"+ data[i].writeDate +"</th>" +
						"<th style='background-color: #eeeeee; text-align: center;'><a href='${contextPath}/main/qnaInto.do?qnaNum="+ data[i].qnaNum +"'>"+ data[i].title +"</a></th>" +
						"<th style='background-color:#eeeeee; text-align: center;'>"+ data[i].adminCheck +"</th>" +
					"</tr>";
					$("#informReplyArea").append(qnaVO);
                	}
               }); 
        	}
        }
		function showUnread(result) {
  			$('#messageCount').html(result+"개");
		}
		// 반복적으로 서버한테 일정한 주기마다 현재 자신이 읽지 않은 메세지의 개수를 알려달라고 요청
		// 60초에 한번씩 getUnread()함수 실행
		setInterval(function() { 
			unreadList();	
		}, 60000); 	
		
		function postMessage() {
	        var xmlhttp = new XMLHttpRequest();
	        xmlhttp.open("POST", "http://localhost:8090/odetour0320/shoutServlet");
	        xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	        var messageText = document.getElementById("textMessage").value;
	        document.getElementById("textMessage").value = "";
	        xmlhttp.send('name='+'${sessionName}'+'&message='+messageText);
	    }
	    var messagesWaiting = false;
	    function getMessages(){
	        if(!messagesWaiting){
	            messagesWaiting = true;
	            var xmlhttp = new XMLHttpRequest();
	            xmlhttp.onreadystatechange=function(){
	                if (xmlhttp.readyState==4 && xmlhttp.status==200) {
	                    messagesWaiting = false;
	                    var contentElement = document.getElementById("messageArea");
	                    contentElement.innerHTML = xmlhttp.responseText + contentElement.innerHTML;
	                }
	            }
	            xmlhttp.open("GET", "http://localhost:8090/odetour0320/shoutServlet");
	            xmlhttp.send();
	        }
	    }
	    setInterval(getMessages, 100);
</script>
</head>

<body>
<!-- 로그인 회원가입 Modal-Login / Register Form --------------------------------------------------------------------- -->
<div class="modal fade" id="modalLRForm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog cascading-modal" role="document">
    <!--Content-->
    <div class="modal-content">
      <!--Modal cascading tabs-->
      <div class="modal-c-tabs">
        <!-- Nav tabs -->
        <ul class="nav nav-tabs md-tabs tabs-2 grey darken-0" role="tablist">
          <li class="nav-item">
            <a class="nav-link active shadow-lg" data-toggle="tab" href="#panel7" role="tab"><i class="fas fa-user-check mr-1"></i>
              Login</a>
          </li>
          <li class="nav-item">
            <a class="nav-link shadow-lg" data-toggle="tab" href="#panel8" role="tab"><i class="fas fa-user-plus mr-1"></i>
              Register</a>
          </li>
        </ul>
        <!-- Tab panels -->
        <div class="tab-content">
          <!--Panel 7-->
          <div class="tab-pane fade in show active" id="panel7" role="tabpanel">
            <!--Body-->
            <div class="modal-body mb-1">
              <div class="md-form form-sm mb-5">
                <i class="fas fa-envelope prefix"></i>
                <input type="text" id="modalLRInput10" class="form-control form-control-sm validate" name="email" placeholder=" EMAIL" >
              </div>
              <div class="md-form form-sm mb-4">
                <i class="fas fa-lock prefix"></i>
                <input type="password" id="modalLRInput11" class="form-control form-control-sm validate" name="pwd" placeholder=" PASSWORD">
              </div>
              <div class="text-center mt-0">
                <button class="btn btn-info active shadow-md" onclick="loginCheck();" id="btnLogin">Log IN<i class="fas fa-check ml-2"></i></button>
              </div>
            </div>
            <!--Footer-->
            <div class="modal-footer">
              <button type="button" class="btn btn-outline-info waves-effect ml-auto" data-dismiss="modal">Close</button>
            </div>
          </div>
          <!--/.Panel 7-->
          <!--Panel 8-->
          <div class="tab-pane fade" id="panel8" role="tabpanel">
            <!--Body-->
            <div class="modal-body">
              <div class="md-form form-sm mb-1 mt-0">
				<div class="input-group mb-1" id="emailAuthTotal">
	                <i class="fas fa-envelope prefix"></i>
	                <input type="text" id="email" class="form-control form-control-sm validate" placeholder=" EMAIL" onkeyup="spaceCheck(this);" />
				    <div class="input-group-append ml-1" id="inputGroupAppend">	
				  		<select class="custom-select" id="emailDomain">
					    	<option value="@naver.com">naver.com</option>
					    	<option value="@daum.net">daum.net</option>
					    	<option value="@google.com">google.com</option>
						</select>
				    </div>
					<div class="input-group-append">
						<input id="btnEmailCheck" type="button" class="btn btn-outline-primary btn-sm" onclick="emailTest();" value="이메일 중복체크" data-toggle="collapse" data-target="#emailAuthTag"/>
						<input id="btnEmailAuth" type="button" class="btn btn-outline-primary btn-sm" onclick="emailAuthTag();" value="이메일 인증" />
		   			</div>
		   		</div>
		   			<div id="emailAuthTag" class="collapse">
		              	<strong><span id="emailCheckResult"></span></strong>
			            <strong><span id="emailAuthCheckResult"></span></strong>
			        </div>
			  </div>      
              <div class="md-form form-sm mb-2 mt-5">
                <i class="fas fa-user prefix"></i>
                <input type="text" id="name" class="form-control form-control-sm validate" placeholder=" NAME" onkeyup="spaceCheck(this);">
              </div>
              <div class="md-form form-sm mb-2 mt-2">
                <i class="fas fa-lock prefix"></i>
                <input type="password" id="pwd1" class="form-control form-control-sm validate" placeholder=" PASSWORD">
              </div>
              <div class="md-form form-sm mb-0">
	                <i class="fas fa-lock prefix"></i>
	                <input type="password" id="pwd2" class="form-control form-control-sm validate" placeholder=" PASSWORD CHECK">
              </div>
              <div class="md-form form-sm mb-0">
				<div class="input-group mb-4 mt-0">
					<i class="fas fa-birthday-cake prefix"></i>
                	 <div class="input-group-append" id="birthSelectGroup">
	                    <select class="custom-select" id="year" onclick="appendYear();">
	                    	<option>2020</option>
						</select>
						<select class="custom-select" id="month" onclick="appendMonth();">
							<option>01</option>
						</select>
						<select class="custom-select" id="day" onclick="appendDay();">
							<option>01</option>
						</select>
					</div>
             	</div>
              </div>
       <!--  <input type="text" id="datepicker1" class="form-control form-control-sm validate" placeholder=" BIRTH" readonly> -->
               
              <div class="md-form form-sm mb-0 mt-0">
                <!-- <i class="fas fa-bell prefix"></i> -->
                <i class="fas fa-phone-alt prefix"></i>
                <input type="text" id="tel" class="form-control form-control-sm validate" placeholder=" TEL(Number)" onkeyup="spaceCheck(this);">
              </div>
              <div class="text-center form-sm mt-0">
                <button class="btn btn-info active shadow-md" onclick="allPassCheck();">Sign up<i class="fas fa-check ml-2"></i></button>
              </div>
            </div> <!-- bodyEnd -->
            <!--Footer-->
            <div class="modal-footer">
              <button type="button" class="btn btn-outline-info waves-effect ml-auto" data-dismiss="modal">Close</button>
            </div>
          </div>
          <!--/.Panel 8-->
        </div>
      </div>
    </div>
    <!--/.Content-->
  </div>
</div>
<!-- 로그인 회원가입 Modal-Login / Register Form --------------------------------------------------------------------- -->

<!-- 회원 정보 Modal-MemberInfo ------------------------------------------------------------------------------------ -->
<div class="modal fade" id="modalLRForm2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog cascading-modal" role="document">
    <!--Content-->
    <div class="modal-content">
      <!--Modal cascading tabs-->
      <div class="modal-c-tabs">
        <!-- Nav tabs -->
        <ul class="nav nav-tabs md-tabs tabs-2 light-blue darken-3 active shadow-lg" role="tablist" style="background-color: gray;">
          <li class="nav-item">
            <a class="nav-link active" data-toggle="tab" href="#panel7" role="tab">
            <i class="far fa-address-card mr-1 fa-lg"></i>
                        회원정보</a>
          </li>
        </ul>
        <!-- Tab panels -->
        <div class="tab-content">
          <!--Panel 7-->
          <div class="tab-pane fade in show active" id="panel7" role="tabpanel">
            <!--Body-->
            <div class="modal-body mb-1" id="mypageInfoTag">
              <div class="md-form form-sm mb-4">
                <i class="fas fa-envelope prefix"></i>
                <input type="text" id="memberEmail" class="form-control form-control-sm validate" value="" readonly>
              </div>
              <div class="md-form form-sm mb-4">
                <i class="fas fa-user prefix"></i>
                <input type="text" id="memberName" class="form-control form-control-sm validate" value="" readonly>
              </div>
              <div class="md-form form-sm mb-4">
                <i class="fas fa-birthday-cake prefix"></i>
                <input type="text" id="memberBirth" class="form-control form-control-sm validate" value="" readonly>
              </div>
              <div class="md-form form-sm mb-4">
                <i class="fas fa-phone-alt prefix"></i>
                <input type="text" id="memberTel" class="form-control form-control-sm validate" value="" readonly>
              </div>
              <div class="md-form form-sm mb-4">
                <i class="fas fa-wallet prefix"></i>
                <input type="text" id="memberPoint" class="form-control form-control-sm validate" value="" readonly>
              </div>
              <div class="text-center mt-2">
                <button class="btn btn-info active shadow-md" data-toggle="modal" data-target="#modalLRForm3">비밀번호 수정 <i class="fas fa-lock ml-1"></i></button>
                <button class="btn btn-info active shadow-md" data-toggle="modal" data-target="#modalDeleteCheck">회원탈퇴 <i class="fas fa-user-times ml-1"></i></button>
                <button class="btn btn-info active shadow-md" onclick="getUserQnaList();" data-toggle="modal" data-target="#modalLRForm4">문의내역 <i class="fas fa-user-edit ml-1"></i></button>
              </div>
            </div>
            <!--Footer-->
            <div class="modal-footer">
              <button type="button" class="btn btn-outline-info waves-effect ml-auto" data-dismiss="modal">Close</button>
            </div>
          </div>
          <!--/.Panel 7-->
          <!--Panel 8-->
          </div>
        </div>
      </div>
    </div>
  </div>
<!-- 비밀번호 수정 -->
<div class="modal fade" id="modalLRForm3" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog cascading-modal" role="document">
    <!--Content-->
    <div class="modal-content">
      <!--Modal cascading tabs-->
      <div class="modal-c-tabs">
        <!-- Nav tabs -->
        <ul class="nav nav-tabs md-tabs tabs-2 light-blue darken-3 active shadow-lg" role="tablist">
          <li class="nav-item">
            <a class="nav-link active" data-toggle="tab" href="#panel7" role="tab"><i class="fas fa-user-lock mr-1 fa-lg"></i>
              	비밀번호 수정</a>
          </li>
        </ul>
        <!-- Tab panels -->
        <div class="tab-content">
          <!--Panel 7-->
          <div class="tab-pane fade in show active" id="panel7" role="tabpanel">
            <!--Body-->
            <div class="modal-body mb-1" id="mypageInfoTag">
              <div class="md-form form-sm mb-5">
                <i class="fas fa-lock prefix"></i>
                <input type="password" id="rewritePwd1" class="form-control form-control-sm validate" placeholder=" PASSWORD" name="rewritePwd1">
              </div>
              <div class="md-form form-sm mb-4">
                <i class="fas fa-lock prefix"></i>
                <input type="password" id="rewritePwd2" class="form-control form-control-sm validate" placeholder=" PASSWORD CHECK" name="rewritePwd2">
              </div>
              <div class="text-center mt-2">
                <button class="btn btn-info active shadow-md" data-dismiss="modal" onclick="memberRewritePwd();">비밀번호 수정완료<i class="fas fa-check ml-2"></i></button>
              </div>
            </div>
            <!--Footer-->
            <div class="modal-footer">
              <button type="button" class="btn btn-outline-info waves-effect ml-auto" data-dismiss="modal">Close</button>
            </div>
          </div>
          <!--/.Panel 7-->
          <!--Panel 8-->
          </div>
        </div>
      </div>
    </div>
  </div>
<!-- 문의내역 리스트 -->
<div class="modal fade" id="modalLRForm4" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog cascading-modal" role="document">
    <!--Content-->
    <div class="modal-content">
      <!--Modal cascading tabs-->
      <div class="modal-c-tabs">
        <!-- Nav tabs -->
        <ul class="nav nav-tabs md-tabs tabs-2 light-blue darken-3 active shadow-lg" role="tablist">
          <li class="nav-item">
            <a class="nav-link active" data-toggle="tab" href="#panel7" role="tab"><i class="fas fa-user-edit mr-1 fa-lg"></i>
              	문의내역</a>
          </li>
        </ul>
        <!-- Tab panels -->
        <div class="tab-content">
          <!--Panel 7-->
          <div class="tab-pane fade in show active" role="tabpanel">
            <!--Body-->
			<table class="table" id="qnaListArea" style="text-align:center; border:1px solid #dddddd; "> 
			</table>
            <!--Footer-->
            <div class="modal-footer">
              <button type="button" class="btn btn-outline-info waves-effect ml-auto" data-dismiss="modal">Close</button>
            </div>
          </div>
          <!--/.Panel 7-->
          <!--Panel 8-->
          </div>
        </div>
      </div>
    </div>
  </div>
<!-- 회원 정보 Modal-MemberInfo ------------------------------------------------------------------------------------ -->  
  
<!-- 로그인 확인 Modal-modalLoginCheck --------------------------------------------------------------------------------- -->
<div class="modal fade" id="modalLoginCheck" role="dialog" aria-labelledby="myModalLabel"
  aria-hidden="true">
  <div class="modal-dialog modal-notify modal-info" role="document">
    <!--Content-->
    <div class="modal-content">
      <!--Header-->
      <div class="modal-header">
        <p class="heading lead">로그인 오류 메세지</p>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true" class="white-text">&times;</span>
        </button>
      </div>
      <!--Body-->
      <div class="modal-body">
        <div class="text-center">
          <i class="fas fa-user-times fa-4x mb-3"></i>
          	<p>이메일과 비밀번호를 확인해주세요</p>
        </div>
      </div>
      <!--Footer-->
      <div class="modal-footer justify-content-center">
        <a type="button" class="btn btn-outline-primary waves-effect" data-dismiss="modal">확 인</a>
      </div>
    </div>
    <!--/.Content-->
  </div>
</div>
<!-- 로그인 확인 Modal-modalLoginCheck --------------------------------------------------------------------------------- -->

<!-- 회원탈퇴 확인 Modal-MemberDeleteCheck ------------------------------------------------------------------------- -->
  <!-- Central Modal Medium Success -->
<div class="modal fade" id="modalDeleteCheck" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
  aria-hidden="true">
  <div class="modal-dialog modal-notify modal-danger" role="document">
    <!--Content-->
    <div class="modal-content">
      <!--Header-->
      <div class="modal-header">
        <p class="heading lead">회원탈퇴 메세지</p>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true" class="white-text">&times;</span>
        </button>
      </div>
      <!--Body-->
      <div class="modal-body">
        <div class="text-center">
          <i class="fas fa-user-times fa-4x mb-3"></i>
          <p>정말 탈퇴하시겠습니까?</p>
        </div>
      </div>
      <!--Footer-->
      <div class="modal-footer justify-content-center">
      	<a type="button" class="btn btn-outline-primary waves-effect" data-dismiss="modal">취소</a>
        <a type="button" class="btn btn-outline-danger waves-effect" data-dismiss="modal" onclick="memberDelete();">확인</a>
      </div>
    </div>
    <!--/.Content-->
  </div>
</div>
<!-- 회원탈퇴 확인 Modal-MemberDeleteCheck ------------------------------------------------------------------------- -->

<!-- 채팅 Modal-Chatting ------------------------------------------------------------------------------------------ -->
	<div class="modal fade" id="chatingForm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog cascading-modal modal-lg" role="document">
    <!--Content-->
    <div class="modal-content">
      <!--Modal cascading tabs-->
      <div class="modal-c-tabs">
        <!-- Nav tabs -->
        <ul class="nav nav-tabs md-tabs tabs-2 light-blue darken-3 active shadow-lg" role="tablist">
          <li class="nav-item">
            <a class="nav-link active" data-toggle="tab" href="#panel7" role="tab">
            <i class="fas fa-user-friends mr-1 fa-lg"></i>
              	채팅</a>
          </li>
        </ul>
        <!-- Tab panels -->
        <div class="tab-content">
          <!--Panel 7-->
          <div class="tab-pane fade in show active" id="panel7" role="tabpanel">
            <!--Body-->
            <!--Footer-->
            <div class="modal-footer">
               <div id="messageArea"></div>
            	<c:choose>
            		<c:when test="${sessionEmail != null}">
   						<div class="input-group mb-3">
							<input type="text" class="form-control" id="textMessage" name="textMessage" onkeyup="enterkey();">
					 		<div class="input-group-append">
					 			<input type="button" class="btn btn-outline-primary btn-sm" onclick="postMessage();" value="Submit">
							</div>
						</div>
            		</c:when>
            		<c:otherwise>
   					 <div class="input-group mb-3">
					 	<input type="text" class="form-control" placeholder=" 로그인 하여 주세요" disabled>
					 	<div class="input-group-append">
					 		<input type="button" class="btn btn-outline-primary btn-md active" id="" value="Submit" disabled >
						</div>
					</div>
            		</c:otherwise>
            	</c:choose>
              <button type="button" class="btn btn-outline-info waves-effect ml-auto" data-dismiss="modal">Close</button>
            </div>
          </div>
          <!--/.Panel 7-->
          <!--Panel 8-->
          </div>
        </div>
      </div>
    </div>
  </div>
<!-- 채팅 Modal-Chatting ------------------------------------------------------------------------------------------ -->

<!-- 메세지함 Modal-Inbox ------------------------------------------------------------------------------------------ -->
  <div class="modal fade" id="modalInbox" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog cascading-modal" role="document">
    <!--Content-->
    <div class="modal-content">
      <!--Modal cascading tabs-->
      <div class="modal-c-tabs">
        <!-- Nav tabs -->
        <ul class="nav nav-tabs md-tabs tabs-2 light-blue darken-3 active shadow-lg" role="tablist">
          <li class="nav-item">
            <a class="nav-link active" data-toggle="tab" href="#panel7" role="tab"><i class="far fa-envelope fa-lg mr-1"></i>
              	Message</a>
          </li>
        </ul>
        <!-- Tab panels -->
        <div class="tab-content">
          <!--Panel 7-->
          <div class="tab-pane fade in show active" role="tabpanel">
            <!--Body-->
			<table class="table" id="informReplyArea" style="text-align:center; border:1px solid #dddddd; "> 
			
			</table>
            <!--Footer-->
            <div class="modal-footer">
              <button type="button" class="btn btn-outline-info waves-effect ml-auto" data-dismiss="modal">Close</button>
            </div>
          </div>
          <!--/.Panel 7-->
          <!--Panel 8-->
          </div>
        </div>
      </div>
    </div>
  </div>
<!-- 메세지함 Modal-Inbox ------------------------------------------------------------------------------------------ -->  
	
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
	
<!-- 메세지 Modal-Message ------------------------------------------------------------------------------------------ -->
	<div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="vertical-alignment-helper">
			<div class="modal-dialog vertical-alignment-center">
				<div class="modal-content">
					<div class="modal-header panel-heading" style="background-color: #dddddd;">
						<h4 class="modal-title" style="font-family: sans-serif;">
						<i class='fas fa-user-check' style='font-size:25px; color: skyblue'></i>&nbsp;
							${messageType}
						</h4>
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">&times;</span>
							<span class="sr-only">Close</span>
						</button>
					</div>
					<div class="modal-body my-1 shadow-md" style='font-size:17px;'>
						${messageContent}
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-outline-primary mr-3 float-left" data-dismiss="modal">확 인</button>
					</div>
				</div>
			</div>
		</div>
	</div>
<!-- 메세지 Modal-Message ------------------------------------------------------------------------------------------ -->

<!-- 로그인 성공 Modal-Login Success --------------------------------------------------------------------------------- -->
	<div class="modal fade" id="modalLoginSuccess" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
	  aria-hidden="true">
	  <div class="modal-dialog modal-notify modal-info" role="document">
	    <!--Content-->
	    <div class="modal-content">
	      <!--Header-->
	      <div class="modal-header">
	        <p class="heading lead">${messageType}</p>
	
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true" class="white-text">&times;</span>
	        </button>
	      </div>
	      <!--Body-->
	      <div class="modal-body">
	        <div class="text-center">
	          <i class="fas fa-user-check fa-4x mb-3"></i>
	          	<p>${messageContent}</p>
	        </div>
	      </div>
	      <!--Footer-->
	      <div class="modal-footer justify-content-center">
	        <a type="button" class="btn btn-outline-primary waves-effect" data-dismiss="modal">확 인</a>
	      </div>
	    </div>
	    <!--/.Content-->
	  </div>
	</div>
<!-- 로그인 성공 Modal-Login Success --------------------------------------------------------------------------------- -->
	
	<script>
 		//$('#messageModal').modal("show");
		$('#modalLoginSuccess').modal("show");
	</script>
	<%	
		session.removeAttribute("messageContent");
		session.removeAttribute("messageType");
		}
	%>

  
  
  
</body>
</html>