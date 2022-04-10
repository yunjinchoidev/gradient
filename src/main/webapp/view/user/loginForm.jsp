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

<%@ include file="../chatBot/chatBot.jsp"%> 
 	<%@ include file="../common/header.jsp"%>


	<div id="auth" style="margin-left: 350px;" >
		<div class="row h-100" style="width: 900px; ">
			<div class="col-lg-5 col-12" style="width: 900px;">
				<div id="auth-left" style="width: 900px;">
					<h1 class="auth-title" >
					Gradient
					<button class="btn btn-primary" type="submit"
					onclick="location.href='/project5/loginForm.do'">일반 로그인<br> 페이지로</button>
					</h1>
					<h2 class="auth-title" style="color : red; margin-bottom: 50px;">
					관리자 로그인
					</h2>
					
						
					<c:if test="${param.error == 'true'}">
					<h2 style="color:blue"><strong>아이디와 암호가 일치하지 않습니다.</strong></h2>
					</c:if>
					
							<form action="<c:url value='/user/login'/>" method="post">
							  <input type="text" class="form-control form-control-xl"
								placeholder="userid" name="userid">
								<br>
							    <input type="password" class="form-control form-control-xl"
								placeholder="password" name="password">
							   
							    
								<div class="form-check form-check-lg d-flex align-items-end" style="margin-top: 10px;">
									<input class="form-check-input me-2" type="checkbox" value="" name="remember-me"
										id="flexCheckDefault"> <label
										class="form-check-label text-gray-600" for="flexCheckDefault" >
										자동 로그인 </label>
								</div>
								
								 <button class="btn btn-primary btn-block btn-lg shadow-lg mt-5" type="submit"><spring:message code="login"/></button>
					</form>	
								
					<div class="text-center mt-5 text-lg fs-4">
						<p class="text-gray-600">
							계정이 없습니까? <a href="/project5/memberRegisterForm.do" class="font-bold"><spring:message code="reg"/>
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
</body>




</html>