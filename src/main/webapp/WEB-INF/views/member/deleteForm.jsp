<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>

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
$(documnet).ready(function(){
	var psc = "${psc}";
	if(psc=="fail"){
		alert("아이디 비밀번호가 맞지 않습니다.");
	}
})
</script>



<body>

<%@ include file="../chatBot/chatBot.jsp"%>
	<%@ include file="../common/header.jsp"%>

	<div id="auth" style="margin-left: 350px;" >
		<div class="row h-100" style="width: 900px; ">
			<div class="col-lg-5 col-12" style="width: 900px;">
				<div id="auth-left" style="width: 900px;">
					<h1 class="auth-title">회원 탈퇴</h1>
					<p class="auth-subtitle mb-5">
						아이디와 비밀번호를 정확히 입력하시오
					</p>

					<form action="/project5/memberDelete.do" method="post">
						<input type="hidden" name="memberkey" value="${member.memberkey }">
						<div class="form-group position-relative has-icon-left mb-4">
							<input type="text" class="form-control form-control-xl"
								placeholder="id" name="id">
							<div class="form-control-icon">
								<i class="bi bi-person"></i>
							</div>
						</div>
						<div class="form-group position-relative has-icon-left mb-4">
							<input type="password" class="form-control form-control-xl"
								placeholder="pass" name="pass">
							<div class="form-control-icon">
								<i class="bi bi-shield-lock"></i>
							</div>
						</div>
						<div class="form-check form-check-lg d-flex align-items-end">
							<input class="form-check-input me-2" type="checkbox" value=""
								id="flexCheckDefault"> <label
								class="form-check-label text-gray-600" for="flexCheckDefault">
								Keep me logged in </label>
						</div>
						<button class="btn btn-primary btn-block btn-lg shadow-lg mt-5">회원탈퇴</button>
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