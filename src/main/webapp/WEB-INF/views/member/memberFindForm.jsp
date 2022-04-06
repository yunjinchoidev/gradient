<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />





<!DOCTYPE html>
<html lang="en">

<head>
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
	var gg = "${psc}"
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



<body>
<%@ include file="../chatBot/chatBot.jsp"%>

	<%@ include file="../common/header.jsp"%>

	<div id="auth" style="margin-left: 350px;" >
		<div class="row h-100" style="width: 900px; ">
			<div class="col-lg-5 col-12" style="width: 900px;">
				<div id="auth-left" style="width: 900px;">
					<h1 class="auth-title">아이디 찾기</h1>
					<p class="auth-subtitle mb-5">
						가입할 때 입력했던 <br> 이름과 이메일을 입력하세요
					</p>

					<form action="/project5/memberIdFind.do" method="post">
						<div class="form-group position-relative has-icon-left mb-4">
							<input type="text" class="form-control form-control-xl"
								placeholder="name" name="name">
							<div class="form-control-icon">
								<i class="bi bi-person"></i>
							</div>
						</div>
						<div class="form-group position-relative has-icon-left mb-4">
							<input type="text" class="form-control form-control-xl"
								placeholder="email" name="email">
							<div class="form-control-icon">
								<i class="bi bi-person"></i>
							</div>
						</div>
						<button class="btn btn-primary btn-block btn-lg shadow-lg mt-5" id="loginbtn">아이디 찾기</button>
					</form>

					<br><br><br><br><br><br>
					<h1 class="auth-title">비밀번호 찾기</h1>
					<p class="auth-subtitle mb-5">
						가입할 때 입력했던 <br>이름, 이메일, 아이디를 입력하세요
						<br> 관리자 승인 후 이메일로 임시 비밀번호를 보내겠습니다.
					</p>

					<form action="/project5/memberPassFindApply.do" method="post">
						<input type="hidden" name="status" value="3">
						<div class="form-group position-relative has-icon-left mb-4">
							<input type="text" class="form-control form-control-xl"
								placeholder="name" name="name">
							<div class="form-control-icon">
								<i class="bi bi-person"></i>
							</div>
						</div>
						<div class="form-group position-relative has-icon-left mb-4">
							<input type="text" class="form-control form-control-xl"
								placeholder="email" name="email">
							<div class="form-control-icon">
								<i class="bi bi-person"></i>
							</div>
						</div>
						<div class="form-group position-relative has-icon-left mb-4">
							<input type="text" class="form-control form-control-xl"
								placeholder="id" name="id">
							<div class="form-control-icon">
								<i class="bi bi-person"></i>
							</div>
						</div>
						<button class="btn btn-primary btn-block btn-lg shadow-lg mt-5" id="loginbtn">비밀번호 찾기</button>
					</form>
					
					
					
					
					
					
					<div class="text-center mt-5 text-lg fs-4">
						<p class="text-gray-600">
							계정이 없습니까? <a href="/project5/memberRegisterForm.do" class="font-bold">회원가입
							</a>
						</p>
						<p>
							<a class="font-bold" href="/project5/memberfind.do">비밀번호가
								생각나지 않습니까?</a>
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