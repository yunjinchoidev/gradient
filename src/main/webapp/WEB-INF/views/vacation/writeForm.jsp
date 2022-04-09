<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<script>
$(document).ready(function(){

	var msg = "${msg}";
	if(msg!=""){
		if(confirm(msg+"\n메인화면으로 이동할까요?")){
			location.href="${path}/output.do";
		}
	}
	
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
							<h4 class="card-title">휴가 계획서 작성</h4>
						</div>

						<div class="card-content">
							<div class="card-body">

								<form class="form" action="/project5/vacationWrite.do"
									method="post" enctype="multipart/form-data">
									
									<input type="hidden" name="memberkey"
										value="${member.memberkey }">
									<div class="row">


										<div class="col-md-6 col-12" style="width: 100%">
											<div class="form-group">
												<label for="last-name-column">제목</label> <input type="text"
													id="last-name-column" class="form-control"
													name="title"
													placeholder="Last Name" name="title">
											</div>
										</div>
									</div>

									<div class="row">
										<div class="col-md-6 col-12">
											<div class="form-group">
												<label for="first-name-column">휴가 종류</label> <select
													id="first-name-column" class="form-control"
													name="sort">
														<option value="regular">연차</option>
														<option value="sick">병가</option>
														<option value="public">공가</option>
														<option value="family">경조사</option>
												</select>
											</div>
										</div>

										<div class="col-md-6 col-12">
											<div class="form-group">
												<label for="first-name-column">작성자</label> <input
													id="first-name-column" class="form-control"
													value="${member.name }">
											</div>
										</div>
										
										
										<div class="col-md-6 col-12">
											<div class="form-group">
												<label for="first-name-column">프로젝트</label> 
												
												<select
													id="first-name-column" class="form-control"
													value="${project.name }" name="projectkey">
													
														<c:forEach var="list" items="${projectList }">
															<option value="${list.projectkey }">${list.projectkey }:${list.name }</option>
														</c:forEach>
														
													</select>
											</div>
										</div>


										<div class="col-md-6 col-12">
											<div class="form-group">
												<label for="city-column">시작일 </label> <input
													type="date" id="city-column" class="form-control"
													placeholder="startdateS" name="startdateS">
											</div>
										</div>







										<div class="col-md-6 col-12">
											<div class="form-group">
												<label for="first-name-column">휴가 종류</label> <select
													id="first-name-column" class="form-control"
													name="duration">
														<option value="1">1일</option>
														<option value="2">2일</option>
														<option value="3">3일</option>
														<option value="4">4일<option>
														<option value="5">5일</option>
												</select>
											</div>
										</div>







									</div>
									<div class="row">
										<div class="col-md-6 col-12" style="width: 100%">
											<div class="form-group">
												<label for="email-id-column">상세내용</label>
												<textarea class="form-control" name="contents"
													placeholder="Contents" rows="6"></textarea>
												<br>
											</div>
										</div>
									</div>



									<div class="row">
										<div class="col-md-6 col-12" style="width: 100%">
											<div class="form-group">
												<label for="email-id-column">휴가 계획서 파일 업로드</label> <input
													class="form-control form-control-lg" id="uploadFile" name="uploadFile"
													type="file" multiple="multiple"> <br>
											</div>
										</div>
									</div>





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
										<button type="button" class="btn btn-danger me-1 mb-1"
											onclick="location.href='/project5/output.do'">뒤로가기</button>

										<button type="submit" class="btn btn-primary me-1 mb-1" >등록</button>
										<button type="reset" class="btn btn-light-secondary me-1 mb-1">초기화</button>
									</div>


								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
	</div>
</body>
</html>