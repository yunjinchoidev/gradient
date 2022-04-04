<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원가입</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
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

#myface img {
	height: 300px;
	width: 300px;
	border: 3px solid black;
}

.id_input{
	color: red;
	background: black;
}

</style>
</head>

<script>
$(document).ready(function() {
		
	// 비밀번호 일치 조사
	var pass =	$("input[name=pass]").val();
	var passRE =	$("input[name=passRE]").val();
	var data = {pass:pass, passRE, passRE};
	
	$("#notsame").hide();
	$("#same").hide();
	
	
	$("input[name=passRE]").keyup(function(){
		console.log("키보드 동작 성공")
		var pass =	$("input[name=pass]").val();
		var passRE =	$("input[name=passRE]").val();
		
		if(pass==passRE){
			$("#notsame").hide();
			$("#same").show();
		}else{
			$("#notsame").show();
			$("#same").hide();
		}
		
		
		
	})
	
	
	
	
	
	
	
				// 파일 용량  체크 
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
	  
	  
		
	

		  		var memberkey;
		  		console.log("memberkey"+memberkey);
				// ajax를 통한 파일 정보 불러오기 
				// 페이지 접속시 자동으로 실행
				var memberkeyValue =parseInt("${member.memberkey}");
				var data = { memberkey : memberkeyValue};
			    $.ajax({
			      url: '/project5/myfaceData.do',
			      data: data,
			      type: 'POST',
			      dataType:'json',
			        success: function(result){
			        console.log(result)
			          console.log(result.myfaceData[0]); 
			          console.log("파일 불러오기 완료")
					  showUploadResult2(result.myfaceData[0]);// 이곳에서 함수 호출 
			      },
			      error: function(result){
			    	  console.log(memberkey)
			          console.log("회원 이미지 정보 불러오기 실패");
			          console.log(result); 
			      }
			    }); //$.ajax
			    
			    
			    
				// 이미지 클라리언트 딴에 띄우는 합수
				// 외래키 없이 업로드 한 파일 결과 클라이언트 단으로 가져오기 함수
			  function showUploadResult2(obj){
				    		console.log("obj"+obj);
							var fileCallPath =  encodeURIComponent(obj.fname);
							console.log(fileCallPath);
							var go="/project5/display2.do?fileName="+fileCallPath;
							$("#not").attr("src",go)
				  }
			    
			    
			 // 화면단에서 업로드한 것을 바로 확인   
			// 에이젝스를 통한 파일 업로드
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
						
						
						
				// 화면단에서 바로 볼수 있게 하기 위해서 사용 + 파일저장
				$.ajax({
				url: '/project5/uploadAjaxAction.do',
				processData: false, 
				contentType: false,
				data:formData,
				type: 'POST',
				dataType:'json',
				success: function(result){
					  console.log("result"+result.list); 
					  console.log("result"+result.list[0]); 
					  showUploadResult(result.list[0]);//함수 호출
				},
				error: function(result){
					  console.log("파일 업로드 실패했습니다.");
					  console.log(result); 
				}
				}); //$.ajax
				
			});  
	  
			 
			 
			 
			// 파일 업로드 시 파일 정보 띄우기
			// 이미지 뷰단에 띄어주기 함수  
				function showUploadResult(obj){
						if(obj.image){
							var fileCallPath =  encodeURIComponent( obj.uploadPath+ "/"+obj.uuid +"_"+obj.fileName);
							var go = "/project5/display.do?fileName="+fileCallPath;
							$("#not").attr("src",go)
							console.log(fileCallPath)
						}else{
							var fileCallPath =  encodeURIComponent( obj.uploadPath+"/"+ obj.uuid +"_"+obj.fileName);			      
						    var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
							str2 = "<img src='/project5/resources/img/attach.png'>";
						}
									  
				}


			
			if ("${member.pricing}"=='0'){
				$("input[name=pricings]").val('플랜 : 기본')
			}else if("${member.pricing}"=='1'){
				$("input[name=pricings]").val('플랜 : 프로')
			}else {
				$("input[name=pricings]").val('플랜 :프리미엄')
			}
			
			
			$("#duplicateId").click(function(e){
				e.preventDefault();
				var inputId=$("input[name=id]").val();
				confirm("아이디 중복 검사를 하시겠습니까?")
				
				window.open("/project5/duplicateId.do?id="+inputId, "PopupWin", "width=500,height=400");
			})
			
			
			
			
						
						
						
						
						
});
						
</script>


<body>
<%@ include file="../chatBot/chatBot.jsp"%>
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
							<input type="text" class="form-control form-control-xl id_input" 
								placeholder="변경할 아이디" name="id" style="width: 85%; display: inline-block;">
							<div class="form-control-icon" style="display: inline-block;">
								<i class="bi bi-envelope"></i>
							</div>
									<button class="btn btn-danger" style="display: inline-block; height: 57.95px"
								id="duplicateId">중복검사</button>
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
							style="color: red; margin-top: -20px; margin-bottom: 10px; font-weight: bolder;">
							<span> 비밀번호가 서로 일치 하지 않습니다.</span>
						</div>
						<div id="same"
							style="color: red; margin-top: -20px; margin-bottom: 10px; font-weight: bolder;">
							<span> 비밀번호가 일치합니다.</span>
						</div>







						<div class="form-group position-relative has-icon-left mb-4">
							<input type="text" class="form-control form-control-xl"
								placeholder="이름" name="name" value="${member.name }">
							<div class="form-control-icon">
								<i class="bi bi-person"></i>
							</div>
						</div>

						<div class="form-group position-relative has-icon-left mb-4">
							<input type="text" class="form-control form-control-xl" readonly="readonly"
								placeholder="방문 수" name="visitcnts" value="방문 수: ${member.visitcnt }">
								<input type="hidden" name="visitcnt" value="${member.visitcnt }" >
							<div class="form-control-icon">
								<i class="bi bi-person"></i>
							</div>
						</div>
						<div class="form-group position-relative has-icon-left mb-4">
							<input type="text" class="form-control form-control-xl" readonly="readonly"
								placeholder="플랜 " name="pricings" value="">			
							<div class="form-control-icon">
								<i class="bi bi-person"></i>
							</div>
						</div>
						<input type="hidden" name="pricing" value="${member.pricing }" >

						<div class="form-group position-relative has-icon-left mb-4">
							<input type="email" class="form-control form-control-xl"
								placeholder="이메일" name="email" value="${member.email }">
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