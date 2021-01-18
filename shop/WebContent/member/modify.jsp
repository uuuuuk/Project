<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>


<link href="../css/daily.css" rel="stylesheet" type="text/css">
<link href="../css/style.css" rel="stylesheet" type="text/css">

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js" type="text/javascript"></script>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
<![endif]-->
<!--[if IE 6]>
 <script src="../script/DD_belatedPNG_0.0.8a.js"></script>
 <script>
   /* EXAMPLE */
   DD_belatedPNG.fix('#wrap');
   DD_belatedPNG.fix('#main_img');   

 </script>
 <![endif]-->
 
 <script type="text/javascript">
 

 
 </script>
 
</head>
<body>
		<div id="background">
		<div id="page">
			<div id="header">
			<span id="connect">
					<a href="http://facebook.com/freewebsitetemplates" target="_blank" class="facebook"></a>
					<a href="http://twitter.com/fwtemplates" target="_blank" class="twitter"></a>
					<a href="http://www.youtube.com/fwtemplates" target="_blank" class="vimeo"></a>
    		   </span>
		
	
			<ul>
				<div id="infos">
				<a href="logout.jsp">로그아웃</a> | 
				<a href="../index.jsp">처음으로</a>
			</div>
			</ul>

		<div class="clear"></div>
			<!-- 로고들어가는 곳 -->
			<div id="logoo">
				<a href="../index.jsp"><img src="../images/logoo.png"></a>
			</div>
			<!-- 로고들어가는 곳 -->

		
		<%			
					String id = (String)session.getAttribute("id");
					String email = (String)session.getAttribute("email");
		%>
		
		
		
		
		<article>
			<h1>회원 정보 수정</h1>
			
			
			<form action="modifyPro.jsp" id="modify" method="post" name="fr">
				<fieldset>
					<legend>필수정보</legend>
			
		
		
			<label>E-MAIL</label> <input type="email" id="mail" name="email" value="<%=email %>" readonly> <br>	
			<label>ID</label> <input type="id" name="id" value=<%=id %> readonly> <br>
			<label>PW</label> <input type="password" name="passwd" id="passwd" class="form-control" required><br> 
			<label>Re PW</label> <input type="password" name="passwd2" id="passwd2" class="form-control" required> <br>
			
			<div class="success" id="success" style="color:#0100FF">비밀번호가 일치합니다.</div> 
			<div class="danger" id="danger"  style="color:#d92742">비밀번호가 일치하지 않습니다.</div>	
				
					
								
			<script type="text/javascript">	
			
			$(function(){ 
				$("#success").hide(); 
				$("#danger").hide();
				$("input").keyup(function(){ 
					var passwd=$("#passwd").val(); 
					var passwd2=$("#passwd2").val(); 
					if(passwd != "" || passwd2 != ""){ 
						if(passwd == passwd2){ 
							$("#success").show(); 
				$("#danger").hide(); 
				$("#submit").removeAttr("disabled");
			}else{ 
				$("#success").hide(); 
				$("#danger").show(); 
				$("#submit").attr("disabled", "disabled"); 
				} 
			} 
			}); 
			});
			
			</script>
			
			
			<label>Name</label> <input type="text" name="name"><br> 
			</fieldset>
				
			<fieldset>	
			<legend>추가정보</legend>		
					
					<input type="text" id="sample4_postcode" placeholder="우편번호" name="address">
	<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
	<input type="text" id="sample4_roadAddress" placeholder="도로명주소" name="address1">
	<input type="text" id="sample4_jibunAddress" placeholder="지번주소" name="address2">
	<span id="guide" style="color:#999;display:none"></span> <br>
	<input type="text" id="sample4_detailAddress" placeholder="상세주소" name="address3">
	<input type="text" id="sample4_extraAddress" placeholder="참고항목" name="address4">

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode;
                document.getElementById("sample4_roadAddress").value = roadAddr;
                document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("sample4_extraAddress").value = '';
                }

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }
</script>
					



				<br><label>Number</label> <input type="text" name="tel"><br>
					<label>Mobile Phone Number</label> <input type="text" name="mtel"><br>
				</fieldset>
				<div class="clear"></div>
				<div id="buttons">
					<input type="submit" value="수정완료" class="submit"> <input
						type="reset" value="취소" class="cancel">
				</div>
			</form>
		</article>
		<!-- 본문내용 -->
		<!-- 본문들어가는 곳 -->

		<div class="clear"></div>
		<!-- 푸터들어가는 곳 -->
		<jsp:include page="../inc/footer.jsp"/>
		<!-- 푸터들어가는 곳 -->
	
</body>
</html>