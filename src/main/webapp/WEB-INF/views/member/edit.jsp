<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원가입</title>
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
	
	<style>
		/* 중복아이디 존재하지 않는경우 */
	.id_input_re_1{
		color : green;
		display : none;
	}
	/* 중복아이디 존재하는 경우 */
	.id_input_re_2{
		color : red;
		display : none;
	}
	</style>
</head>
<script>
	$(document).ready(function() {
		
	});	
</script>

<body>

	<%@ include file="../common/header.jsp"%>
	<div id="auth"  style="margin-left: 350px;">
		<div class="row h-100" style="width: 900px; ">
			<div class="col-lg-5 col-12">
				<div id="auth-left" style="width: 900px; ">
					<h1 class="auth-title">정보 수정</h1>
					<p class="auth-subtitle mb-5">변경할 정보를 입력하십시오</p>


					<form action="/project5/memberRegister.do" method="post">
						<div class="form-group position-relative has-icon-left mb-4">
							<input type="text" class="form-control form-control-xl"
								placeholder="사원번호" name="id">
							<div class="form-control-icon">
								<i class="bi bi-envelope"></i>
							</div>
						</div>
						
						<div class="form-group position-relative has-icon-left mb-4">
							<input type="email" class="form-control form-control-xl"
								placeholder="이메일" name="email">
							<div class="form-control-icon">
								<i class="bi bi-person"></i>
							</div>
						</div>



						<div class="form-group position-relative has-icon-left mb-4">
							<input type="text" class="form-control form-control-xl"
								placeholder="auth" name="auth">
							<div class="form-control-icon">
								<i class="bi bi-shield-lock"></i>
							</div>
						</div>



						<button class="btn btn-primary btn-block btn-lg shadow-lg mt-5">임시 아이디/비밀번호 발급받기</button>
					</form>
					
					
					
					
					<button class="btn btn-primary btn-block btn-lg shadow-lg mt-5"
						onclick="location.href='/project5/main.do'">메인으로</button>
					<div class="text-center mt-5 text-lg fs-4">
						<p class='text-gray-600'>
							이미 계정이 있습니까? <a href="/project5/login.do" class="font-bold">로그인</a>.
						</p>
					</div>
				</div>
			</div>
		</div>

	</div>
</body>

</html>