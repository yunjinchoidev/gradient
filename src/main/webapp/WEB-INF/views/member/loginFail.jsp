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


	<%@ include file="../common/header.jsp"%>

	<div id="auth" style="margin-left: 350px;" >
		<div class="row h-100" style="width: 900px; ">
			<div class="col-lg-5 col-12" style="width: 900px;">
				<div id="auth-left" style="width: 900px;">
					<h1 class="auth-title">로그인 실패</h1>
					<p class="auth-subtitle mb-5">
						일치하는 정보가 없습니다.
						다시 로그인 하십시오.
					</p>

						<button class="btn btn-primary btn-block btn-lg shadow-lg mt-5" onclick="location.href='/project5/main.do'">메인으로 </button>
						<button class="btn btn-primary btn-block btn-lg shadow-lg mt-5" onclick="location.href='/project5/login.do'">로그인 화면으로</button>
						<button class="btn btn-primary btn-block btn-lg shadow-lg mt-5" onclick="location.href='/project5/memberRegisterForm.do'">회원가입</button>
				</div>
			</div>
		</div>

	</div>
	
</body>

</html>