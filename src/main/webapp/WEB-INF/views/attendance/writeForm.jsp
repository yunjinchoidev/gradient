
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
.uploadResult {
	width: 100%;
	background-color: gray;
}

.uploadResult ul {
	display: flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
}

.uploadResult ul li {
	list-style: none;
	padding: 10px;
}

.uploadResult ul li img {
	width: 100px;
}
</style>

<style>
.bigPictureWrapper {
	position: absolute;
	display: none;
	justify-content: center;
	align-items: center;
	top: 0%;
	width: 100%;
	height: 100%;
	background-color: gray;
	z-index: 100;
}

.bigPicture {
	position: relative;
	display: flex;
	justify-content: center;
	align-items: center;
}
</style>


</head>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	$(document).ready(function() {

		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		var maxSize = 5242880; //5MB

		function checkExtension(fileName, fileSize) {
			if (fileSize >= maxSize) {
				alert("파일 사이즈 초과");
				return false;
			}
			if (regex.test(fileName)) {
				alert("해당 종류의 파일은 업로드할 수 없습니다.");
				return false;
			}
			return true;
		}

		var memberkey;
		console.log("memberkey" + memberkey);
		// ajax를 통한 파일 정보 불러오기 
		// 페이지 접속시 자동으로 실행
		var memberkeyValue = parseInt("${get.memberkey}");
		console.log("memberkeyValue" + memberkeyValue);

		var data = {
			memberkey : memberkeyValue
		};
		$.ajax({
			url : '/project5/myfaceData.do',
			data : data,
			type : 'POST',
			dataType : 'json',
			success : function(result) {
				console.log(result)
				console.log(result.myfaceData[0]);
				console.log("파일 불러오기 완료")
				showUploadResult2(result.myfaceData[0]);// 이곳에서 함수 호출 
			},
			error : function(result) {
				console.log(memberkey)
				console.log("회원 이미지 정보 불러오기 실패");
				console.log(result);
			}
		}); //$.ajax

		// 이미지 클라리언트 딴에 띄우는 합수
		// 외래키 없이 업로드 한 파일 결과 클라이언트 단으로 가져오기 함수
		function showUploadResult2(obj) {
			console.log("obj" + obj);
			var fileCallPath = encodeURIComponent(obj.fname);
			console.log(fileCallPath);
			var go = "/project5/display2.do?fileName=" + fileCallPath;
			$("#not").attr("src", go)
		}

		
		
		
		
		var total=0;
		$("#regBtn2").click(function(){
			$("input[name=score]:checked").each(function(){
				total +=parseInt($(this).val())
				console.log($(this).val())
				console.log(total)
			})
			
			alert(total)
			location.href="/project5/attendanceWrite.do?memberkey="+${get.memberkey}+"&score="+total;
			
		})
		
		

		
		
		$.ajax({
			url:'/project5/memberInfoByMemberKey.do',
			type:'POST',
			data:data,
			dataType:'json',
			success:function(result){
				$("input[name=name]").val(result.memberInfoByMemberKey.name)
			}
		})
		
		
		
	})
	
	
	
	
	
	
</script>



<body>
	<%@ include file="../chatBot/chatBot.jsp"%>
	<%@ include file="../common/header.jsp"%>
	<div id="main">
		<section id="multiple-column-form">
			<div class="row match-height">
				<div class="col-12">
					<div class="card">

						<div class="card-header">
							<h4 class="card-title">근태 평가서</h4>
						</div>

						<div class="card-content">
							<div class="card-body">
							
									<input type="hidden" name="memberkey" value="${get.memberkey }">
									
									
									<div class="row">
										<div class="col-md-12 col-12">
											<div class="form-group">
											<img scr="$" id="not" style="width: 300px; height: 300px; margin-left: 550px;">
											</div>
										</div>
									</div>
									
									
									<div class="row">
										
										<div class="col-md-6 col-12">
											<div class="form-group">
												<label for="first-name-column">피평가자 회원 번호</label> <input
													type="text" id="first-name-column" class="form-control"
													placeholder="memberkey" name="memberkey" value="${get.memberkey }" readonly="readonly">
											</div>
										</div>
										<div class="col-md-6 col-12">
											<div class="form-group">
												<label for="first-name-column">피평가자 이름</label> <input
													type="text" id="first-name-column" class="form-control"
													placeholder="name" name="name" value="${get.name }" readonly="readonly">
											</div>
										</div>


										<div class="col-md-6 col-12">
											<div class="form-group">
												<label for="last-name-column">작성일</label> <input type="date"
													id="last-name-column" class="form-control"
													placeholder="writeDate" name="writeDateS">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-12 col-12">
											<div class="form-group">
												<label for="email-id-column">상기 위 사람에 대한 짤막한 평가</label>
												<textarea class="form-control" name="content"
													placeholder="content" rows="4" ></textarea>
											</div>
										</div>
									</div>


									<div class="card-content">
										<div class="card-body">
											<p>아래 항목을 체크하십시오</p>
											<ul class="list-group">
												<li class="list-group-item">
												<input
													class="form-check-input me-1" type="checkbox" 
													aria-label="..." name="score" value="3"> 주간 작업 량이 얼마나 됩니까</li>
													
													
												<li class="list-group-item" >
												<input
													class="form-check-input me-1" type="checkbox" 
													aria-label="..." name="score" value="3"> 정시 출근을 합니까?</li>
													
													
												<li class="list-group-item">
												<input
													class="form-check-input me-1" type="checkbox" 
													aria-label="..." name="score" value="3"> 주변 동료들의 평가는 어떱니까?</li>
													
													
												<li class="list-group-item">
												<input
													class="form-check-input me-1" type="checkbox" 
													aria-label="..." name="score" value="3"> 인사성이 밝습니까?</li>
													
													
												<li class="list-group-item"><input
													class="form-check-input me-1" type="checkbox"
													aria-label="..." name="score" value="3"> 코드를 얼마나 잘 짭니까?</li>
													
													
												<li class="list-group-item"><input
													class="form-check-input me-1" type="checkbox"
													aria-label="..." name="score" value="3">동료를 잘 도와줍니까?</li>
													
													
												<li class="list-group-item"><input
													class="form-check-input me-1" type="checkbox"
													aria-label="..." name="score" value="3">근무지에서 태도는 어떠합니까?</li>
											</ul>
										</div>
									</div>




									<div class="row">
										<div class="col-lg-12">
											<div class="panel panel-default">

												<div class="panel-heading">File Attach</div>
												<!-- /.panel-heading -->
												<div class="panel-body">
													<div class="form-group uploadDiv">
														<input type="file" name='uploadFile' multiple>
													</div>

													<div class='uploadResult'>
														<ul>

														</ul>
													</div>


												</div>
												<!--  end panel-body -->

											</div>
											<!--  end panel-body -->
										</div>
										<!-- end panel -->
									</div>
									<!-- /.row -->




									<div class="form-group col-12">
										<div class="form-check">
											<div class="checkbox">
												<input type="checkbox" id="checkbox5"
													class="form-check-input" checked=""> <label
													for="checkbox5">Remember Me</label>
											</div>
										</div>
									</div>







									<div class="col-12 d-flex justify-content-end">
										<button type="button"
											class="btn btn-danger btn-icon icon-left" style="height: 90%"
											onclick="location.href='/project5/attendanceMain.do'">
											<i class="fas fa-plane"></i> 뒤로가기
										</button>
										<button type="button" class="btn btn-primary me-1 mb-1" id="regBtn2">등록</button>
										<button type="reset" class="btn btn-light-secondary me-1 mb-1">초기화</button>
										
									</div>
							</div>

						</div>
					</div>
				</div>
			</div>
	</div>
	</section>
	</div>


</body>

</html>




<script>
$(document).ready(function(){
	
					
						var memberkey;
					var memberkeyValue =parseInt("${get.memberkey}");
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



			function showUploadResult2(obj){
			    		console.log("obj"+obj);
						var fileCallPath =  encodeURIComponent(obj.fname);
						console.log(fileCallPath);
						var go="/project5/display2.do?fileName="+fileCallPath;
						$("#not").attr("src",go)
			  }
})
  </script>











