<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<fmt:requestEncoding value="utf-8"/>     




<!DOCTYPE html>
<html lang="en">

<head>
<!--  구글 api 로그인 -->
<meta name ="google-signin-client_id" content=828794941459-g78m89jn9pbv4o7h40jfn6nau33hs1h4.apps.googleusercontent.com>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login - Mazer Admin Dashboard</title>
<link
	href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="/project5/resources/dist/assets/css/bootstrap.css">
<link rel="stylesheet"
	href="/project5/resources/dist/assets/vendors/bootstrap-icons/bootstrap-icons.css">
<link rel="stylesheet"
	href="/project5/resources/dist/assets/css/app.css">
<link rel="stylesheet"
	href="/project5/resources/dist/assets/css/pages/auth.css">
	<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
	
	
	
</head>


<script>


$(document).ready(function(){
	
	$("#selectLan").val("${param.lang}")
	$("#selectLan").change(function(){
		if($(this).val()!=""){
			location.href="${path}/choiceLan.do?lang="+$(this).val();
		}
	});
	
	
	var psc = "${psc}"
	console.log("psc : "+psc)
	if(psc == "fail"){
		alert("아이디 비밀번호가 맞지 않습니다.");
	}else{
		console.log("성공입니다.")
	}
	
	frmObj = $("form");
	
	$("#loginbtn").click(function(e){
		e.preventDefault();
		confirm("로그인 하시겠습니까?")
		frmObj.submit();
	});
})

</script>


<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>

<!--  카카오를 위해서 -->

<!-- 카카오 스크립트 -->
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script>
	
	$(document).ready(function(){
		

	})
	
	
</script>

<body>

 	<%@ include file="../common/header.jsp"%>
 	<%@ include file="../chatBot/chatBot.jsp"%>


	<div id="auth" style="margin-left: 350px;" >
		<div class="row h-100" style="width: 1000px; ">
			<div class="col-lg-5 col-12" style="width: 1000px;">
				<div id="auth-left" style="width: 1000px;">
						<div style="margin-bottom: 40px;">
						<h2 style="display: inline-block;">  <spring:message code="multilang"/></h2>
						<select class="form-control" id="selectLan" style="width: 30%; display: inline-block;">
						  	<option value=""><spring:message code="chlange"/></option>
						  	<option value="korean" selected="selected"><spring:message code="korean"/></option>
						  	<option value="english"><spring:message code="english"/></option>
						  	<option value="japanese"><spring:message code="japanese"/></option>
						  	<option value="chinese"><spring:message code="chinese"/></option>
						  </select>
						  </div>
						  
						  
						  <div style="margin-bottom: 40px;">  
					<h1 class="auth-title">
					Gradient
					<button class="btn btn-primary"  
						onclick="location.href='/project5/user/loginform'"> 
						<spring:message code="securityLogin"/>
						</button>
					</h1>
					<h1 class="auth-title">
					<spring:message code="login"/>
					</h1>
							</div>




					<form action="/project5/login.do" method="post">
						<div class="form-group position-relative has-icon-left mb-4">
							<input type="text" class="form-control form-control-xl"
								placeholder="<spring:message code="id"/>" name="id">
							<div class="form-control-icon">
								<i class="bi bi-person"></i>
							</div>
						</div>
						
						<div class="form-group position-relative has-icon-left mb-4">
							<input type="password" class="form-control form-control-xl"
								placeholder="<spring:message code="pwd"/>" name="pass">
							<div class="form-control-icon">
								<i class="bi bi-shield-lock"></i>
							</div>
						</div>

						<div style="margin-top: -40px;">
							<button class="btn btn-primary btn-block btn-lg shadow-lg mt-5"
								id="loginbtn" ><spring:message code="login"/>
							</button>
						</div>
						<!-- 
						<div class="form-check form-check-lg d-flex align-items-end">
							<input class="form-check-input me-2" type="checkbox" value=""
								id="flexCheckDefault"> <label
								class="form-check-label text-gray-600" for="flexCheckDefault">
								Keep me logged in </label> 
						</div>-->
						
					
						


						<div >
							<a href="javascript:kakaoLogin();"
							style="display: inline-block;"
							> <img
								src="/project5/resources/login/kakaoLogin.png" alt="카카오계정 로그인"
								style="width:235px; height: 50px; margin-top: 10px; margin-left:10px;  display: inline-block;" />
							</a> 
							<a href="javascript:void(0)"
							style="display: inline-block;"
							> <img
								src="/project5/resources/login/naverLogin.png" alt="네이버 로그인"
								style="width:235px; height: 50px; margin-top: 10px;  margin-left:10px; display: inline-block;" id="naverIdLogin_loginButton" />
							</a>
							<a href="javascript:void(0)"
							style="display: inline-block;"
							> <img
								src="/project5/resources/login/googleLogin.png" alt="구글 로그인"
								style="width:235px;  height: 50px; margin-top: 10px;  margin-left:10px; display: inline-block;" id="GgCustomLogin" />
							</a>
						</div>
						
					</form>
					
					<div class="text-center mt-5 text-lg fs-4">
						<p class="text-gray-600">
							<spring:message code="noAccout"/>
							<a href="/project5/memberRegisterForm.do" class="font-bold">
							<spring:message code="reg"/>
							</a>
						</p>
						<p>
							<a class="font-bold" href="/project5/memberFindForm.do">
							<spring:message code="forget"/></a>
						</p>
					</div>
				</div>
			</div>
			<!-- 
			<div class="col-lg-7 d-none d-lg-block">
				<div id="auth-right"></div>
			</div>
			 -->

			 
			 
			 
		</div>

	</div>
						
						
						
						<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
    <script>
        window.Kakao.init('9b27ef068ae5af77a894af32a4f1ee80');

        function kakaoLogin() {
            window.Kakao.Auth.login({
                scope: 'profile_nickname, profile_image, account_email', //동의항목 페이지에 있는 개인정보 보호 테이블의 활성화된 ID값을 넣습니다.
                success: function(response) {
                    console.log(response) // 로그인 성공하면 받아오는 데이터
                    window.Kakao.API.request({ // 사용자 정보 가져오기 
                        url: '/v2/user/me',
                        success: (res) => {
                            const kakao_account = res.kakao_account;
                            console.log(kakao_account)
                            console.log(kakao_account.profile)
                            console.log(kakao_account.profile.nickname)
                            console.log(kakao_account.email)
                            alert("접속합니다.")
                         	var nameValue=kakao_account.profile.nickname; //이름
                    		var emailValue=kakao_account.email; // 이메일
                    		var data = {name:nameValue,
                    						email:emailValue}
                        	$.ajax({
                    			url:'/project5/insertMemberAjax.do',
                    			type:'POST',
                    			data : data,
                    			dataType:'json',
                    			success:function(result){
                    				alert("카카오 로그인 성공")
                    				location.href="/project5/main.do"
                    			},
                    			error:function(result){
                    				alet("카카오 로그인 실패")
                    			}
                    		})
                            
                            
	                            
	                            
	                            
                            
                        }
                    });
                     //window.location.href='/project5/main.do' //리다이렉트 되는 코드
                },
                fail: function(error) {
                    console.log(error);
                }
            });
        }
    </script>
				
							



<!--  네이버 api -->
<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>


<script>
var naverLogin = new naver.LoginWithNaverId(
		{
			clientId: "p9XWUSBuHjHd2RP1xTQP", //내 애플리케이션 정보에 cliendId를 입력해줍니다.
			callbackUrl: "http://106.10.16.155:7080/project5/loginForm.do", // 내 애플리케이션 API설정의 Callback URL 을 입력해줍니다.
			isPopup: false,
			callbackHandle: true
		}
	);	

naverLogin.init();

window.addEventListener('load', function () {
	naverLogin.getLoginStatus(function (status) {
		if (status) {
			var email = naverLogin.user.getEmail(); // 필수로 설정할것을 받아와 아래처럼 조건문을 줍니다.
			console.log(naverLogin.user); 
			console.log(naverLogin.user.name); 
			console.log(naverLogin.user.email); 
    		
            if( email == undefined || email == null) {
				alert("이메일은 필수정보입니다. 정보제공을 동의해주세요.");
				naverLogin.reprompt();
				return;
			}
        	var nameValue=naverLogin.user.name; // 이름
    		var emailValue=naverLogin.user.email; // 이메일
    		var data = {name:nameValue,
    						email:emailValue}
	        	$.ajax({
	    			url:'/project5/insertMemberAjax.do',
	    			type:'POST',
	    			data : data,
	    			dataType:'json',
	    			success:function(result){
	    				alert("네이버 로그인 성공")
	    				//location.href="/project5/main.do"
	    			},
	    			error:function(result){
	    				alert("네이버 로그인 실패")
	    			}
	    		})
            
            
            
            
            
            alert("성공")
		} else {
			console.log("callback 처리에 실패하였습니다.");
		}
	});
});


var testPopUp;
function openPopUp() {
    testPopUp= window.open("https://nid.naver.com/nidlogin.logout", "_blank", "toolbar=yes,scrollbars=yes,resizable=yes,width=1,height=1");
}
function closePopUp(){
    testPopUp.close();
}

function naverLogout() {
	openPopUp();
	setTimeout(function() {
		closePopUp();
		}, 1000);
}
</script>





<script>

//처음 실행하는 함수
function init() {
	gapi.load('auth2', function() {
		gapi.auth2.init();
		options = new gapi.auth2.SigninOptionsBuilder();
		options.setPrompt('select_account');
        // 추가는 Oauth 승인 권한 추가 후 띄어쓰기 기준으로 추가
		options.setScope('email profile openid https://www.googleapis.com/auth/user.birthday.read');
        // 인스턴스의 함수 호출 - element에 로그인 기능 추가
        // GgCustomLogin은 li태그안에 있는 ID, 위에 설정한 options와 아래 성공,실패시 실행하는 함수들
		gapi.auth2.getAuthInstance().attachClickHandler('GgCustomLogin', options, onSignIn, onSignInFailure);
	})
}

		function onSignIn(googleUser) {
			var access_token = googleUser.getAuthResponse().access_token
			$.ajax({
				url: 'https://people.googleapis.com/v1/people/me'
				, data: {personFields:'birthdays', key:'AIzaSyBLU93r5-XQDjB-58ZU7LRiG1l_93AkYtU', 'access_token': access_token}
				, method:'GET'
			})
			
			.done(function(e){
		        //프로필을 가져온다.
				var profile = googleUser.getBasicProfile();
				console.log(profile)
				console.log(profile.zv)
				console.log(profile.sf)
				var nameValue=profile.sf; // 이름
				var emailValue=profile.zv; // 이메일
				
				var data = {name:nameValue,
								email:emailValue}
				
				$.ajax({
					url:'/project5/insertMemberAjax.do',
					type:'POST',
					data : data,
					dataType:'json',
					success:function(result){
						alert("구글 로그인 성공")
						location.href="/project5/main.do"
					},
					error:function(result){
						alert("구글 로그인 실패")
					}
				})
				
			})
	.fail(function(e){
		console.log(e);
	})
}
function onSignInFailure(t){		
	console.log(t);
}
</script>
<!--  구글 api 사용을 위한 스크립트-->
<script src="https://apis.google.com/js/platform.js?onload=init" async defer></script>






<!-- 페이스북 -->

						<script async defer crossorigin="anonymous"
							src="https://connect.facebook.net/ko_KR/sdk.js#xfbml=1&version=v13.0&appId=282186027273418&autoLogAppEvents=1"
							nonce="lPx2leFM"></script>
							<!-- 
							<ul>
							 <li onclick="fnFbCustomLogin();">
							  <a href="javascript:void(0)">
							   <span>Login with Facebook</span>
							  </a>
							 </li>
							</ul>
							 -->
						

						<script>

//기존 로그인 상태를 가져오기 위해 Facebook에 대한 호출
function statusChangeCallback(res){
	statusChangeCallback(response);
}

function fnFbCustomLogin(){
	FB.login(function(response) {
		if (response.status === 'connected') {
			FB.api('/me', 'get', {fields: 'name,email'}, function(r) {
				console.log(r);
				
				
				
				
				
			})
		} else if (response.status === 'not_authorized') {
			// 사람은 Facebook에 로그인했지만 앱에는 로그인하지 않았습니다.
			alert('앱에 로그인해야 이용가능한 기능입니다.');
		} else {
			// 그 사람은 Facebook에 로그인하지 않았으므로이 앱에 로그인했는지 여부는 확실하지 않습니다.
			alert('페이스북에 로그인해야 이용가능한 기능입니다.');
		}
	}, {scope: 'public_profile,email'});
}

window.fbAsyncInit = function() {
	FB.init({
		appId      : '282186027273418', // 내 앱 ID를 입력한다.
		cookie     : true,
		xfbml      : true,
		version    : 'v10.0'
	});
	FB.AppEvents.logPageView();   
};
</script>





</body>




</html>