<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <style>
    /* Modal-MemberIntroude(Footer) Position */
	#KBS, #SYS, #JBD, #JUS, #NYH, #JHJ, #KSR, #JMY {top: 10%;}
    .footer-heading {font-family: sans-serif; font-size: 32px;}
    #aboutUs, #introduceMember, #subscribe, #footerList li {font-family: sans-serif; font-size: 20px;}
    .footerMenu {color:#000000 !important;}
    h2 {cursor:pointer;}
    a:hover {color:#0000cc !important; text-decoration: underline !important;}
    a {cursor:pointer;}
    </style>
    
    <footer class="site-footer bg-light p-5">
      <div class="container mt-5">
        <div class="row">
          <div class="col-md-8">
            <div class="row">
              <div class="col-md-7">
                <h2 id="aboutUs" class="footer-heading mb-3">About Us</h2>
                <p id="introduceCompany">
                	항공기 예약 서비스를 제공하는 <br>
                	ODE TOUR 입니다.
                </p>
              </div>
              <div class="col-me-3 mr-5">
              	<h2 id="introduceMember" class="footer-heading mb-3">Member Introduce</h2>
                  <a class="mr-4" data-toggle="modal" data-target="#KBS">KBS </a>
                  <a class="mr-4" data-toggle="modal" data-target="#SYS">SYS </a>
                  <a data-toggle="modal" data-target="#JBD">JBD </a><br><br>
                  <a class="mr-4" data-toggle="modal" data-target="#JUS">JUS </a>
                  <a class="mr-4" data-toggle="modal" data-target="#NYH">NYH </a>
                  <a data-toggle="modal" data-target="#JHJ">JHJ </a><br><br>
                  <a class="mr-4" data-toggle="modal" data-target="#KSR">KSR </a>
                  <a data-toggle="modal" data-target="#JMY">JMY </a>
              </div>
            </div>
          </div>
          <div class="col-md-4 ml-auto">
            <div class="mb-5 mr-0 ml-5">
              <h2 id="subscribe" class="footer-heading mb-4">Subscribe to Newsletter</h2>
              <form action="#" method="post" class="footer-suscribe-form">
                <div class="input-group mb-3">
                  <input type="text" class="form-control rounded-0 border-secondary text-white bg-transparent" placeholder="Enter Email" aria-label="Enter Email" aria-describedby="button-addon2">
                  <div class="input-group-append">
                    <button class="btn btn-info active text-white" type="button" id="button-addon2">Subscribe</button>
                  </div>
                </div>
            </div>
            </form>
          </div>
        </div>
        <div class="row pt-1 mt-1 text-center">
          <div class="col-md-12">
            <div class="pt-5">
              <p class="footerMenu">
	Copyright &copy;<script>var date = new Date(); document.write(date.getFullYear()+"."+(date.getMonth()+1)+"."+date.getDate());</script>
            <i class="icon-plane text-primary" aria-hidden="true"></i> by <a class="footerMenu" href="#">ODE TOUR</a>
            </p>
            </div>
          </div>

        </div>
      </div>
    
	<!-- 멤버소개와 소감 MODAL-MEMBER INTRODUCE.1 KBS ---------------------------------------------------------------------- -->
	<div class="modal fade" id="KBS" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-notify modal-info" role="document">
	    <div class="modal-content text-center">
	      <div class="modal-header d-flex justify-content-center">
	        <p class="heading">ODE TOUR&nbsp;&nbsp;&nbsp;멤버 소개&nbsp;&nbsp;|&nbsp;&nbsp;프로젝트 소감</p>
	      </div>
	      <div class="modal-body">
	        <i class="fas fa-user fa-4x animated fadeIn mr-2"></i>KANG BS<br><br>
	        <!-- 자기소개 -->
	        <p>FRONT-END&nbsp;&nbsp;|&nbsp;&nbsp;회원관리<br></p>
	      </div>
	      <!-- 프로젝트 소감 -->
	      <p class="text-left ml-4 mb-2"><strong><i class="far fa-check-circle fa-lg mr-2"></i>프로젝트 소감</strong></p>
	      <div class="md-form mt-0 mx-4">
	        <p style="text-align: left;">
	        	여러 감정이 왔다갔다 한 것 같네요...<br>
	        	처음에는 부담스러웠지만...<br>
	        	팀원들과 같이 하면서 서로 채워나가는 팀플에 대해 느끼고...<br>
	        	한편으로는 부족한 스스로에 대해<br> 
	        	아쉬운 생각도 참 많이 한 것 같네요.<br>
	        	모자람을 채워주는 팀원들과 같이 하면서 재미있었고...<br>
	        	저의 새로운 방향성을 찾아준 좋은 기회가 된 것 같습니다... 
	        </p>
	      </div>
	      <div class="modal-footer flex-center">
	      	<a type="button" class="btn btn-outline-info active waves-effect mr-4" data-dismiss="modal">c l o s e</a></div>
	    </div>
	  </div>
	</div>
	<!-- 멤버소개와 소감 MODAL-MEMBER INTRODUCE.2 SYS ---------------------------------------------------------------------- -->
	<div class="modal fade" id="SYS" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-notify modal-info" role="document">
	    <div class="modal-content text-center">
	      <div class="modal-header d-flex justify-content-center">
	        <p class="heading">ODE TOUR&nbsp;&nbsp;&nbsp;멤버 소개&nbsp;&nbsp;|&nbsp;&nbsp;프로젝트 소감</p>
	      </div>
	      <div class="modal-body">
	        <i class="fas fa-user fa-4x animated fadeIn mr-2"></i>SON YS<br><br>
	        <!-- 자기소개 -->
	        <p>FRONT-END&nbsp;&nbsp;|&nbsp;&nbsp;API, 항공 관리<br></p>
	      </div>
	      <!-- 프로젝트 소감 -->
	      <p class="text-left ml-4 mb-2"><strong><i class="far fa-check-circle fa-lg mr-2"></i>프로젝트 소감</strong></p>
	      <div class="md-form mt-0 mx-4">
	        <p style="text-align: left;">
	        	api 건드려보니 재미있네요.<br>
	        	다들 취업 잘하시고 자주 연락하고 지내요 ~
	        </p>
	      </div>
	      <div class="modal-footer flex-center">
	      	<a type="button" class="btn btn-outline-info active waves-effect mr-4" data-dismiss="modal">c l o s e</a></div>
	    </div>
	  </div>
	</div>
	<!-- 멤버소개와 소감 MODAL-MEMBER INTRODUCE.3 JBD ---------------------------------------------------------------------- -->
	<div class="modal fade" id="JBD" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-notify modal-info" role="document">
	    <div class="modal-content text-center">
	      <div class="modal-header d-flex justify-content-center">
	        <p class="heading">ODE TOUR&nbsp;&nbsp;&nbsp;멤버 소개&nbsp;&nbsp;|&nbsp;&nbsp;프로젝트 소감</p>
	      </div>
	      <div class="modal-body">
	        <i class="fas fa-user fa-4x animated fadeIn mr-2"></i>JUNG BD<br><br>
	        <!-- 자기소개 -->
	        <p>BACK-END&nbsp;&nbsp;|&nbsp;&nbsp;API, 게시판 관리<br></p>
	      </div>
	      <!-- 프로젝트 소감 -->
	      <p class="text-left ml-4 mb-2"><strong><i class="far fa-check-circle fa-lg mr-2"></i>프로젝트 소감</strong></p>
	      <div class="md-form mt-0 mx-4">
	        <p style="text-align: left;">
	        	재미없당...재미있당...재미없당...재미있당...
	        </p>
	      </div>
	      <div class="modal-footer flex-center">
	      	<a type="button" class="btn btn-outline-info active waves-effect mr-4" data-dismiss="modal">c l o s e</a></div>
	    </div>
	  </div>
	</div>
	<!-- 멤버소개와 소감 MODAL-MEMBER INTRODUCE.4 JUS ---------------------------------------------------------------------- -->
	<div class="modal fade" id="JUS" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-notify modal-info" role="document">
	    <div class="modal-content text-center">
	      <div class="modal-header d-flex justify-content-center">
	        <p class="heading">ODE TOUR&nbsp;&nbsp;&nbsp;멤버 소개&nbsp;&nbsp;|&nbsp;&nbsp;프로젝트 소감</p>
	      </div>
	      <div class="modal-body">
	        <i class="fas fa-user fa-4x animated fadeIn mr-2"></i>JUNG US<br><br>
	        <!-- 자기소개 -->
	        <p>BACK-END&nbsp;&nbsp;|&nbsp;&nbsp;게시판 관리<br></p>
	      </div>
	      <!-- 프로젝트 소감 -->
	      <p class="text-left ml-4 mb-2"><strong><i class="far fa-check-circle fa-lg mr-2"></i>프로젝트 소감</strong></p>
	      <div class="md-form mt-0 mx-4">
	        <p style="text-align: left;">
	        	재미없당...재미있당...재미없당...재미있당...
	        </p>
	      </div>
	      <div class="modal-footer flex-center">
	      	<a type="button" class="btn btn-outline-info active waves-effect mr-4" data-dismiss="modal">c l o s e</a></div>
	    </div>
	  </div>
	</div>
	<!-- 멤버소개와 소감 MODAL-MEMBER INTRODUCE.5 NYH ---------------------------------------------------------------------- -->
	<div class="modal fade" id="NYH" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-notify modal-info" role="document">
	    <div class="modal-content text-center">
	      <div class="modal-header d-flex justify-content-center">
	        <p class="heading">ODE TOUR&nbsp;&nbsp;&nbsp;멤버 소개&nbsp;&nbsp;|&nbsp;&nbsp;프로젝트 소감</p>
	      </div>
	      <div class="modal-body">
	        <i class="fas fa-user fa-4x animated fadeIn mr-2"></i>NAM YH<br><br>
	        <!-- 자기소개 -->
	        <p>FRONT-END&nbsp;&nbsp;|&nbsp;&nbsp;API, 항공, CHAT 관리<br></p>
	      </div>
	      <!-- 프로젝트 소감 -->
	      <p class="text-left ml-4 mb-2"><strong><i class="far fa-check-circle fa-lg mr-2"></i>프로젝트 소감</strong></p>
	      <div class="md-form mt-0 mx-4">
	        <p style="text-align: left;">
	        	재미없당...재미있당...재미없당...재미있당...
	        </p>
	      </div>
	      <div class="modal-footer flex-center">
	      	<a type="button" class="btn btn-outline-info active waves-effect mr-4" data-dismiss="modal">c l o s e</a></div>
	    </div>
	  </div>
	</div>
	<!-- 멤버소개와 소감 MODAL-MEMBER INTRODUCE.6 JHJ ---------------------------------------------------------------------- -->
	<div class="modal fade" id="JHJ" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-notify modal-info" role="document">
	    <div class="modal-content text-center">
	      <div class="modal-header d-flex justify-content-center">
	        <p class="heading">ODE TOUR&nbsp;&nbsp;&nbsp;멤버 소개&nbsp;&nbsp;|&nbsp;&nbsp;프로젝트 소감</p>
	      </div>
	      <div class="modal-body">
	        <i class="fas fa-user fa-4x animated fadeIn mr-2"></i>JUNG HJ<br><br>
	        <!-- 자기소개 -->
	        <p>BACK-END&nbsp;&nbsp;|&nbsp;&nbsp;회원, 메인 시스템 관리 <br></p>
	      </div>
	      <!-- 프로젝트 소감 -->
	      <p class="text-left ml-4 mb-2"><strong><i class="far fa-check-circle fa-lg mr-2"></i>프로젝트 소감</strong></p>
	      <div class="md-form mt-0 mx-4">
	        <p style="text-align: left;">
	        	팀 프로젝트를 하면서<br> 
	        	협업하는 능력과 부족한 부분들을 많이 배우게 된 것 같습니다.<br>
	        	이런 소중한 기회 주셔서 감사합니다
	        </p>
	      </div>
	      <div class="modal-footer flex-center">
	      	<a type="button" class="btn btn-outline-info active waves-effect mr-4" data-dismiss="modal">c l o s e</a></div>
	    </div>
	  </div>
	</div>
	<!-- 멤버소개와 소감 MODAL-MEMBER INTRODUCE.7 KSR ---------------------------------------------------------------------- -->
	<div class="modal fade" id="KSR" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-notify modal-info" role="document">
	    <div class="modal-content text-center">
	      <div class="modal-header d-flex justify-content-center">
	        <p class="heading">ODE TOUR&nbsp;&nbsp;&nbsp;멤버 소개&nbsp;&nbsp;|&nbsp;&nbsp;프로젝트 소감</p>
	      </div>
	      <div class="modal-body">
	        <i class="fas fa-user fa-4x animated fadeIn mr-2"></i>KIM SR<br><br>
	        <!-- 자기소개 -->
	        <p>FRONT-END&nbsp;&nbsp;|&nbsp;&nbsp;API, 항공 관리<br></p>
	      </div>
	      <!-- 프로젝트 소감 -->
	      <p class="text-left ml-4 mb-2"><strong><i class="far fa-check-circle fa-lg mr-2"></i>프로젝트 소감</strong></p>
	      <div class="md-form mt-0 mx-4">
	        <p style="text-align: left;">
	        	재미없당...재미있당...재미없당...재미있당...
	        </p>
	      </div>
	      <div class="modal-footer flex-center">
	      	<a type="button" class="btn btn-outline-info active waves-effect mr-4" data-dismiss="modal">c l o s e</a></div>
	    </div>
	  </div>
	</div>
	<!-- 멤버소개와 소감 MODAL-MEMBER INTRODUCE.8 JMY ---------------------------------------------------------------------- -->
	<div class="modal fade" id="JMY" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-notify modal-info" role="document">
	    <div class="modal-content text-center">
	      <div class="modal-header d-flex justify-content-center">
	        <p class="heading">ODE TOUR&nbsp;&nbsp;&nbsp;멤버 소개&nbsp;&nbsp;|&nbsp;&nbsp;프로젝트 소감</p>
	      </div>
	      <div class="modal-body">
	        <i class="fas fa-user fa-4x animated fadeIn mr-2"></i>JO MY<br><br>
	        <!-- 자기소개 -->
	        <p>BACK-END&nbsp;&nbsp;|&nbsp;&nbsp;게시판 관리<br></p>
	      </div>
	      <!-- 프로젝트 소감 -->
	      <p class="text-left ml-4 mb-2"><strong><i class="far fa-check-circle fa-lg mr-2"></i>프로젝트 소감</strong></p>
	      <div class="md-form mt-0 mx-4">
	        <p style="text-align: left;">
	        	재미없당...재미있당...재미없당...재미있당...
	        </p>
	      </div>
	      <div class="modal-footer flex-center">
	      	<a type="button" class="btn btn-outline-info active waves-effect mr-4" data-dismiss="modal">c l o s e</a></div>
	    </div>
	  </div>
	</div>
	
	  
    </footer>