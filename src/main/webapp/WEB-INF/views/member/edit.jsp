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

<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<style>
/* 중복아이디 존재하지 않는경우 */
.id_input_re_1 {
	color: green;
	display: none;
}
/* 중복아이디 존재하는 경우 */
.id_input_re_2 {
	color: red;
	display: none;
}
</style>
</head>
<script>
	$(document).ready(function() {

	});
</script>

<body>

	<%@ include file="../common/header.jsp"%>
	<div id="auth" style="margin-left: 350px;">
		<div class="row h-100" style="width: 900px;">
			<div class="col-lg-5 col-12">
				<div id="auth-left" style="width: 900px;">
					<h1 class="auth-title">회원 정보 수정</h1>
					<p class="auth-subtitle mb-5">변경할 정보를 입력하십시오</p>
						
						
						
					<div class="form-group position-relative has-icon-left mb-4">
						<input type="text" class="form-control form-control-xl"
							placeholder="임시 아이디" name="id" value="${member.id }" >
						<div class="form-control-icon">
							<i class="bi bi-envelope"></i>
						</div>
					</div>
					<div class="form-group position-relative has-icon-left mb-4">
						<input type="password" class="form-control form-control-xl"
							placeholder="임시 비밀번호" name="pass" value="${member.pass }">
						<div class="form-control-icon">
							<i class="bi bi-envelope"></i>
						</div>
					</div>
					
					
					
					
					<form action="/project5/memberEdit.do" method="post">
						
						
						<input type="hidden" value="${member.memberkey }" name="memberkey">
						
						
						<div class="form-group position-relative has-icon-left mb-4">
							<input type="text" class="form-control form-control-xl"
								placeholder="회원 번호 : ${member.memberkey }" readonly="readonly">
							<div class="form-control-icon">
								<i class="bi bi-envelope"></i>
							</div>
						</div>
						
						
						<div class="form-group position-relative has-icon-left mb-4">
							<input type="text" class="form-control form-control-xl"
								placeholder="변경할 아이디" name="id">
							<div class="form-control-icon">
								<i class="bi bi-envelope"></i>
							</div>
						</div>
						
						
						
						<div class="form-group position-relative has-icon-left mb-4">
							<input type="text" class="form-control form-control-xl"
								placeholder="변경할 비밀번호" name="pass">
							<div class="form-control-icon">
								<i class="bi bi-envelope"></i>
							</div>
						</div>
						<div class="form-group position-relative has-icon-left mb-4">
							<input type="password" class="form-control form-control-xl"
								placeholder="비밀번호 재확인">
							<div class="form-control-icon">
								<i class="bi bi-envelope"></i>
							</div>
						</div>

						<div class="form-group position-relative has-icon-left mb-4">
							<input type="text" class="form-control form-control-xl"
								placeholder="이름" name="name">
							<div class="form-control-icon">
								<i class="bi bi-person"></i>
							</div>
						</div>



						<div class="form-group position-relative has-icon-left mb-4">
							<select class="form-control form-control-xl" name="auth"><option
									value="" selected>직급</option>
								<option value="pm">PM</option>
								<option value="teamleader">팀장</option>
								<option value="developer">개발자</option></select>
							<div class="form-control-icon">
								<i class="bi bi-shield-lock"></i>
							</div>
						</div>

						<div class="form-group position-relative has-icon-left mb-4">
							<select class="form-control form-control-xl" name="deptno"><option
									value="" selected>소속 부서</option>
								<option value="1">기획</option>
								<option value="2">pm</option>
								<option value="3">프론트</option>
								<option value="4">백엔드</option>
								<option value="5">고객 관리</option></select>
							<div class="form-control-icon">
								<i class="bi bi-shield-lock"></i>
							</div>
						</div>


						<button class="btn btn-primary btn-block btn-lg shadow-lg mt-5">회원정보수정하기</button>
					</form>




					<button class="btn btn-primary btn-block btn-lg shadow-lg mt-5"
						onclick="location.href='/project5/main.do'">메인으로</button>

					<div class="text-center mt-5 text-lg fs-4">
						<p class='text-gray-600'>
							이미 계정이 있습니까? <a href="/project5/login.do" class="font-bold">로그인</a>.
						</p>
						<p class='text-gray-600'>
							PMS가 더 이상 필요 없으십니까? <a href="/project5/memberDeleteForm.do" class="font-bold">회원탈퇴</a>.
						</p>
					</div>
				</div>
			</div>
		</div>

	</div>
</body>

</html>