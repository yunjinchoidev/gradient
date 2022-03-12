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
		<div class="row h-100" style="width: 1100px; ">
			<div class="col-lg-5 col-12">
				<div id="auth-left" style="width: 1100px; ">
					<h1 class="auth-title">회원 정보가 수정되었습니다.<br> 다시 로그인 하십시오</h1>
					<p class="auth-subtitle mb-5">부주의로 인한 피해는 본사에서 책임지지 않습니다.</p>


					
					<button class="btn btn-primary btn-block btn-lg shadow-lg mt-5"
						onclick="location.href='/project5/login.do'">로그인 하기</button>
					<button class="btn btn-primary btn-block btn-lg shadow-lg mt-5"
						onclick="location.href='/project5/main.do'">메인으로</button>
					<div class="text-center mt-5 text-lg fs-4">
						<p class='text-gray-600'>
							메일이 오지 않습니까? <a href="/project5/main.do" class="font-bold">고객센터</a>
						</p>
					</div>
				</div>
			</div>
		</div>

	</div>
</body>

</html>