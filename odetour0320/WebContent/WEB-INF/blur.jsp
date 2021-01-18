<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
<script>
// 다음API를 이용한 주소검색
 function execDaumPostcode() {
     new daum.Postcode({
         oncomplete: function(data) {
             // 도로명 주소를 roadAddr 변수에 저장
             var roadAddr = data.address; // 도로명 주소 변수

             // 우편번호와 주소 정보를 input태그에 넣는다.
             document.getElementById('postcode').value = data.zonecode;
             document.getElementById('address').value = roadAddr;
         }
     }).open();
 }

// 아이디 정규식
var idJ = /^[a-z0-9]{4,12}$/;
// 비밀번호 정규식
var pwJ = /^[A-Za-z0-9]{4,12}$/; 
// 이름 정규식
var nameJ = /^[가-힣]{2,6}$/;
// 이메일 검사 정규식
var emailJ = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
// 휴대폰 번호 정규식
var telJ = /^((01[1|6|7|8|9])[1-9]+[0-9]{6,7})|(010[1-9][0-9]{7})$/;
      
$(function(){
   
   // 공백이 있을 경우 알림
   function checkNull() {
      
      if($('#id').value == null){
         alert("ID공백!");
      }
   }
   
   // 아이디 유효성 검사 및 ajax로 중복확인 처리
   $('#id').blur(function() {
      var id = $('#id').val();
      
      $.ajax({
         
         type: 'get',
         dataType: 'text',
         async: false,
         url: '/KIMP/mem?id=' + id,
         success: function(data, textStatus) {
            
            if(idJ.test($('#id').val())){
               if(data == 'usable'){   // 사용할 수 있는 ID
                  $('#id_check').text('');
                  $('#id').attr('class', 'form-control is-valid');
               }else{               // DB에 존재하는 ID
                  $('#id_check').text('이미 사용중인 아이디입니다.');
                  $('#id').attr('class', 'form-control is-invalid');
               }
            }else{
               $('#id_check').text('아이디를 확인해주세요(4~12자의 영문,숫자 입력)');
               $('#id').attr('class', 'form-control is-invalid');
            }
         },
         error: function(e) {
            console.log(e);
            alert("통신실패!");
         }
         
      });
      
   });

   // 비밀번호 유효성 검사
   $('#passwd').blur(function() {
      if(pwJ.test($(this).val())){
         $('#passwd_check').text('');
         $('#passwd').attr('class', 'form-control mt-3 is-valid');
      }else{
         $('#passwd_check').text('※비밀번호를 확인해주세요(4~12자의 영문,숫자 입력)');
         $('#passwd').attr('class', 'form-control mt-3 is-invalid').focus();
      }
   });
   
   // 비밀번호 일치 확인
   $('#passwd2').blur(function() {
      if($('#passwd').val() == $(this).val()){
         $('#passwd2_check').text('');
         $('#passwd2').attr('class', 'form-control mt-3 is-valid');
      }else{
         $('#passwd2_check').text('※비밀번호가 일치하지 않습니다');
         $('#passwd2').attr('class', 'form-control mt-3 is-invalid').focus();
      }
   });
   
   // 이름 유효성 검사
   $('#name').blur(function() {
      if (nameJ.test($(this).val())) {
         $('#name_check').text('');
         $('#name').attr('class', 'form-control mt-3 is-valid');
      }else {
         $('#name_check').text('※ 이름을 확인해주세요');
         $('#name').attr('class', 'form-control mt-3 is-invalid').focus();
      }
   });
   
   $('#address').blur(function() {
      if($('#address').val() == ""){
         $('#address_check').text('주소가 입력되지 않았습니다.');
         $('#address').attr('class', 'form-control mt-3 is-invalid').focus();
      }else{
         $('#address_check').text('');
         $('#address').attr('class', 'form-control mt-3 is-valid');
      }
   });
   
   $('#address2').blur(function() {
      if($('#address2').val() == ""){
         $('#address2_check').text('상세주소가 입력되지 않았습니다.');
         $('#address2').attr('class', 'form-control mt-3 is-invalid').focus();
      }else{
         $('#address2_check').text('');
         $('#address2').attr('class', 'form-control mt-3 is-valid');
      }
   });
   
   // 휴대전화 유효성 검사
   $('#tel').blur(function() {
      if(telJ.test($(this).val())){
         $('#tel_check').text('');
         $('#tel').attr('class', 'form-control mt-3 is-valid');
      }else{
         $('#tel_check').text('※ 휴대전화를 확인해주세요');
         $('#tel').attr('class', 'form-control mt-3 is-invalid').focus();
      }
   });
   
   // 이메일 유효성 검사
   $('#email').blur(function() {
      if(emailJ.test($(this).val())){
         $('#email_check').text('');
         $('#email').attr('class', 'form-control mt-3 is-valid');
      }else{
         $('#email_check').text('※ 이메일을 확인해주세요');
         $('#email').attr('class', 'form-control mt-3 is-invalid').focus();
      }
   });
   
});
</script>
</script>
</head>
<body>

</body>
</html>