<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="/project5/resources/dist/assets/css/bootstrap.css">
<link rel="stylesheet"
	href="/project5/resources/dist/assets/vendors/perfect-scrollbar/perfect-scrollbar.css">
<link rel="stylesheet"
	href="/project5/resources/dist/assets/vendors/bootstrap-icons/bootstrap-icons.css">
<link rel="stylesheet"
	href="/project5/resources/dist/assets/css/app.css">
<link rel="stylesheet"
	href="/project5/resources/dist/assets/vendors/simple-datatables/style.css">
<link rel="shortcut icon"
	href="/project5/resources/dist/assets/images/favicon.svg"
	type="image/x-icon">

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script
	src="/project5/resources/dist/assets/vendors/perfect-scrollbar/perfect-scrollbar.min.js"></script>
<script src="/project5/resources/dist/assets/js/bootstrap.bundle.min.js"></script>
<script
	src="/project5/resources/dist/assets/vendors/simple-datatables/simple-datatables.js"></script>
<script src="/project5/resources/dist/assets/js/main.js"></script>

<body>

	<div class="compose-new-mail-sidebar ps">
		<div class="card shadow-none quill-wrapper p-0">
			<div class="card-header">
				<h1 class="card-title" id="emailCompose">
					<span style="color: red">[#${get.id }]</span>일정 조회
				</h1>
			</div>


			<!-- form start -->
			<form action="#" id="compose-form">
				<div class="card-content">
					<div class="card-body pt-0">
						<br>
						<div class="form-group pb-50">
							<label for="emailfrom">일정 명</label> <input type="text"
								id="emailfrom" class="form-control"
								placeholder="user@example.com" disabled="" value="${get.title }">
						</div>
						<div class="form-group pb-50">
							<label for="emailfrom">시작일</label> <input type="text"
								id="emailfrom" class="form-control"
								placeholder="user@example.com" disabled="" value="${get.start }">
						</div>
						<div class="form-group pb-50">
							<label for="emailfrom">종료일</label> <input type="text"
								id="emailfrom" class="form-control"
								placeholder="user@example.com" disabled="" value="${get.end }">
						</div>


						<div class="form-group pb-50">
							<label for="emailfrom">종일 여부</label> <input type="text"
								id="emailfrom" class="form-control"
								placeholder="user@example.com" disabled=""
								value="${get.allDay }">
						</div>
						<div class="form-group pb-50">
							<label for="emailfrom">내용</label>
							<textarea rows="" cols="" id="emailfrom" class="form-control"
								readonly="readonly">
							${get.allDay }
							</textarea>
						</div>





			<script>
			$(document).ready(function() {
				// ajax를 통한 파일 정보 불러오기 
				// 페이지 접속시 자동으로 실행
				var id ="${get.id}";
				console.log(id);
				console.log("id"+id);
				 var data = { id : id};
				 // 업로드 파일 결과 가져오기
			    $.ajax({
			      url: '/project5/calImg.do',
			      data: data,
			      type: 'POST',
			      dataType:'json',
			        success: function(result){
			          console.log(result); 
			          console.log(result.get); 
			          console.log(result.get[0]); 
			          console.log(result.get[0].fname); 
			          console.log("파일 불러오기 완료")
					  showUploadResult2(result.get[0]);//////////////////////////////////////////////////////////////////////// 이곳에서 함수 호출 
					  console.log(result.fname)
			      },
			      error: function(result){
			    	  console.log(memberkey)
			          console.log("회원 이미지 정보 불러오기 실패");
			          console.log(result); 
			      }
			    }); //$.ajax
			    
				// 이미지 클라리언트 딴에 띄우는 합수
				// 외래키 없이 업로드 한 파일 결과 클라이언트 단으로 가져오기 함수
			  function showUploadResult2(uploadResultArr){
				    if(!uploadResultArr || uploadResultArr.length == 0){ return; }
				    var uploadUL = $("#myface");
				    var str ="";
				    $(uploadResultArr).each(function(i, obj){
				    		console.log("obj"+obj);
							var fileCallPath =  encodeURIComponent(obj.fname);
							console.log(fileCallPath);
							str = "<img src='/project5/display2.do?fileName="+fileCallPath+"' id='mymy' style='width:300px; height: 300px;'>";
							console.log("str"+str)
							$("#not").hide()
							$("#mymy").show()
						})
				    uploadUL.append(str);
				  }
			///////////////////////////////////////////////////////////////
			
				function downFile(fname){
					if(confirm("다운로드할 파일:"+fname)){
						location.href="${path}/download.do?fname="+fname;
					}
				}
			
			
		});
		</script>










						<div class="form-group mt-2" style="width:300px; height: 300px;">
							<div class="custom-file" style="width:300px; height: 300px;">
								<label class="custom-file-label" for="emailAttach">Attach
									File</label><br> <input type="file" class="custom-file-input"
									id="emailAttach" name="uploadFile">
										
										<div id="myface" style="width:300px; height: 300px;">
										
										</div>
										
										
							</div>
						</div>




						<br>
					</div>
				</div>




				<div class="card-footer d-flex justify-content-end pt-0">
					<button type="reset"
						class="btn btn-light-secondary cancel-btn mr-1">
						<span>닫기</span>
					</button>
					<button type="submit" class="btn-send btn btn-primary">
						<span>Send</span>
					</button>
				</div>
			</form>
			<!-- form start end-->



		</div>
		<div class="ps__rail-x" style="left: 0px; bottom: 0px;">
			<div class="ps__thumb-x" tabindex="0" style="left: 0px; width: 0px;"></div>
		</div>
		<div class="ps__rail-y" style="top: 0px; right: 0px;">
			<div class="ps__thumb-y" tabindex="0" style="top: 0px; height: 0px;"></div>
		</div>
	</div>
</body>
</html>