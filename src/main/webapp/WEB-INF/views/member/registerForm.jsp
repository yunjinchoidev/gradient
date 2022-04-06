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
var vali;
	$(document).ready(function() {

		$("#make").click(function(e){
				if(vali==1){
					e.preventDefault();
					alert("이메일을 다시 확인하십시오.")
				}else{
					confirm("정말 가입하시겠습니까?")
					alert("계정 발급 신청 완료 되었습니다.\n 관리자 승인후, 입력한 이메일로\n임시아이디/비밀번호가 발급될 예정입니다.")
				}
		})
		
		
		$.ajax({
			url:'/project5/reginum.do',
			type:'POST',
			dataType:'json',
			success:function(result){
				console.log(result.reginum)
				$("[name=memberkey]").val(result.reginum)
			}
		})
		
		
		$("#already").hide();
		$("#can").hide();
		
		$("input[name=email]").keyup(function(){
			var inputData = $("input[name=email]").val();
			var data = {email:inputData}
			$.ajax({
				url:'/project5/duplicateEmail.do',
				type:'POST',
				data:data,
				dataType:'json',
				success:function(result){
					console.log("검사 성공");
					console.log(result.duplicateEmail);
					if(result.duplicateEmail=="can"){
						vali=0
						$("#can").show();
						$("#already").hide();
					}else{
						vali=1
						$("#can").hide();
						$("#already").show();
					}
				}
			})
			
			
		})
		
		
		
		
		
	});	
</script>

<body>
<%@ include file="../chatBot/chatBot.jsp"%>
	<%@ include file="../common/header.jsp"%>
	<div id="auth"  style="margin-left: 350px;">
		<div class="row h-100" style="width: 900px; ">
			<div class="col-lg-5 col-12">
				<div id="auth-left" style="width: 900px;">
					<h1 class="auth-title">처음 오셨습니까?</h1>
					<p class="auth-subtitle mb-5" >이메일을 입력하시오</p>
					<p class="auth-subtitle mb-5" >관리자 승인후, 입력한 이메일로 <br>임시아이디/비밀번호가 발급될 예정입니다.</p>
					
					
					
					<form action="/project5/memberRegisterApplyFirst.do" method="post">
					
					
					
						<div class="form-group position-relative has-icon-left mb-4">
						
							<input type="text" class="form-control form-control-xl"
								 name="memberkey" readonly="readonly" id="memberkey" name="memberkey">
							<div class="form-control-icon"><i class="bi bi-envelope"></i></div>
						</div>
						
						
						<div class="form-group position-relative has-icon-left mb-4">
							<input type="email" class="form-control form-control-xl"
								placeholder="이메일" name="email" >
							<div class="form-control-icon"><i class="bi bi-person"></i></div>
							<span id="already" style="color:red">이미 등록된 이메일이 있습니다.</span>
							<span id="can" style="color:red">사용 가능한 이메일입니다.</span>
						</div>
							
						<div class="form-group position-relative has-icon-left mb-4">
							<input type="text" class="form-control form-control-xl"
								placeholder="이름" name="name" >
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
						<button class="btn btn-primary btn-block btn-lg shadow-lg mt-5" id="make">계정 발급 신청</button>
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