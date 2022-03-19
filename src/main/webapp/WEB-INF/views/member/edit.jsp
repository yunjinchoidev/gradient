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
			
		var pass =	$("input[name=pass]").val();
		var passRE =	$("input[name=passRE]").val();
		var data = {pass:pass, passRE, passRE};
		
		$("#notsame").hide();
		$("#same").hide();
		
	});
</script>


<script>
$(document).ready(function() {

	
	
	  var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	  var maxSize = 5242880; //5MB
  
	  function checkExtension(fileName, fileSize){
	    if(fileSize >= maxSize){
	      alert("파일 사이즈 초과");
	      return false;
	    }
	    if(regex.test(fileName)){
	      alert("해당 종류의 파일은 업로드할 수 없습니다.");
	      return false;
	    }
	    return true;
	  }
	  
	  
	  
	  
	  
	  
		var memberkey=2;
		  
		  
							  
							  function showUploadResult2(uploadResultArr){
								    if(!uploadResultArr || uploadResultArr.length == 0){ return; }
								    var uploadUL = $("#myface");
								    var str ="";
								    $(uploadResultArr).each(function(i, obj){
								    		console.log(obj);
								    		console.log(obj.pathinfo);
								    		console.log(obj.fname);
								    		console.log(obj);
											var fileCallPath =  encodeURIComponent(obj.fname);
											console.log(fileCallPath);
											str = "<img src='/project5/display2.do?fileName="+fileCallPath+"'>";
											console.log(str)
											$("#not").hide()
										})
								    uploadUL.append(str);
								    console.lo
								  }
		
		
		  

										var memberkeyValue ="${member.memberkey}";
										  console.log(memberkey);
										 // 파일 불러올때  
									    $.ajax({
									      url: '/project5/aaaa.do',
									      processData: false, 
									      contentType: false,
									      data: {memberkey : memberkeyValue },
									      type: 'POST',
									      dataType:'json',
									        success: function(result){
									        	alert(result)
									          console.log(result); 
									          console.log("파일 불러오기 완료")
											  showUploadResult2(result);//////////////////////////////////////////////////////////////////////// 이곳에서 함수 호출 
									      },
									      error: function(result){
									    	  console.log(memberkey)
									          console.log("회원 이미지 정보 불러오기 실패");
									          console.log(result); 
									      }
									    }); //$.ajax
								  
									    
									    
									    
									    

														// 파일 업로드 처리
														$("input[type='file']").change(function(e){
																	var formData = new FormData();
																	var inputFile = $("input[name='uploadFile']");
																	var files = inputFile[0].files;
																	for(var i = 0; i < files.length; i++){
																	if(!checkExtension(files[i].name, files[i].size) ){
																		return false;
																}
																	formData.append("uploadFile", files[i]);
																}
															// 로컬 폴더에 파일 저장 처리
															$.ajax({
															url: '/project5/uploadAjaxAction.do',
															processData: false, 
															contentType: false,data: 
															formData,type: 'POST',
															dataType:'json',
															success: function(result){
																  console.log(result); 
																  showUploadResult(result);//////////////////////////////////////////////////////////////////////// 이곳에서 함수 호출 
															},
															error: function(result){
																  console.log("파일 업로드 실패했습니다.");
																  console.log(result); 
															}
															}); //$.ajax
														});  
	  
	  


					
										// 이미지 뷰단에 띄어주기
											function showUploadResult(uploadResultArr){
											  if(!uploadResultArr || uploadResultArr.length == 0){ return; }
											  var uploadUL = $("#myface");
											  var str ="";
											  $(uploadResultArr).each(function(i, obj){
													if(obj.image){
														var fileCallPath =  encodeURIComponent( obj.uploadPath+ "/"+obj.uuid +"_"+obj.fileName);
														str = "<img src='/project5/display.do?fileName="+fileCallPath+"'>";
														console.log(fileCallPath)
														console.log(str)
														$("#not").hide()
														
													}else{
														var fileCallPath =  encodeURIComponent( obj.uploadPath+"/"+ obj.uuid +"_"+obj.fileName);			      
													    var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
														str += "<img src='/project5/resources/img/attach.png'>";
														$("#not").hide()
													}
											  });
											  uploadUL.append(str);
											}


						
						
						
						
						
						
						
						
						
});
						
</script>

<style>
#myface img {
	height: 300px;
	width: 300px;
	border: 3px solid black;
}
</style>

<body>








	<%@ include file="../common/header.jsp"%>
	<div id="auth" style="margin-left: 350px;">
		<div class="row h-100" style="width: 900px;">
			<div class="col-lg-5 col-12">
				<div id="auth-left" style="width: 900px;">
					<h1 class="auth-title">회원 정보 수정</h1>
					<p class="auth-subtitle mb-5">변경할 정보를 입력하십시오</p>

					<form action="/project5/memberEdit.do" method="post"
						enctype="multipart/form-data">
						<input type="hidden" name="fno" value="${member.memberkey }">

						<div class="form-group position-relative has-icon-left mb-4">
						
						
							<div class="avatar avatar-xl me-3" id="myface"
								style="border: 1px solid black">
								<img src="/project5/resources/image/user.png" alt="" srcset=""
									style="" id="not">
							</div>
							
							
							
							
							
							
							
							
							<input type="file" name="uploadFile" multiple>
						</div>

						<div class="form-group position-relative has-icon-left mb-4">
							<input type="text" class="form-control form-control-xl"
								placeholder="임시 아이디" value="${member.id }" readonly="readonly">
							<div class="form-control-icon">
								<i class="bi bi-envelope"></i>
							</div>
						</div>




						<div class="form-group position-relative has-icon-left mb-4">
							<input type="password" class="form-control form-control-xl"
								placeholder="임시 비밀번호" value="${member.pass }"
								readonly="readonly">
							<div class="form-control-icon">
								<i class="bi bi-envelope"></i>
							</div>
						</div>






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
								placeholder="비밀번호 재확인" name="passRE">


							<div class="form-control-icon">
								<i class="bi bi-envelope"></i>
							</div>



						</div>
						<div id="notsame"
							style="color: red; margin-top: -20px; margin-bottom: 10px;">
							<span> 비밀번호가 서로 일치 하지 않습니다.</span>
						</div>
						<div id="same"
							style="color: red; margin-top: -20px; margin-bottom: 10px;">
							<span> 비밀번호가 일치합니다.</span>
						</div>







						<div class="form-group position-relative has-icon-left mb-4">
							<input type="text" class="form-control form-control-xl"
								placeholder="이름" name="name">
							<div class="form-control-icon">
								<i class="bi bi-person"></i>
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
							PMS가 더 이상 필요 없으십니까? <a href="/project5/memberDeleteForm.do"
								class="font-bold">회원탈퇴</a>.
						</p>
					</div>
				</div>
			</div>
		</div>

	</div>
</body>

</html>