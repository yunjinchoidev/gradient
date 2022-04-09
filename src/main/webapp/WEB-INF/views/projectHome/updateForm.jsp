<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ include file="../common/header.jsp"%>
	<div id="main">
		<section id="multiple-column-form">
			<div class="row match-height">
				<div class="col-12">
					<div class="card">

						<div class="card-header">
							<h4 class="card-title">프로젝트 공지사항</h4>
						</div>

						<div class="card-content">
							<div class="card-body">

								<form class="form" action="/project5/projectHomeWrite.do">
									<input type="hidden" name="memberkey"
										value="${member.memberkey }"> 
									<div class="row">
										<div class="col-md-6 col-12">
											<div class="form-group">
												<label for="first-name-column">프로젝트</label>
												
												 <select
													id="projectkey" class="form-control"
													name="projectkey" >
													<c:forEach var="pjList" items="${pjList}" varStatus="idx">
														<option value="${pjList.projectkey }">${pjList.projectkey } : ${pjList.name }</option>
													</c:forEach>
												</select>
											</div>
										</div>
										
										<script>
											$(document).ready(function(){
												$("#projectkey option:eq(${get.projectkey})").attr("selected", "selected");
											})
											
											
											
											
										</script>
										

										<div class="col-md-6 col-12">
											<div class="form-group">
												<label for="first-name-column">작업 구분</label> <select
													id="first-name-column" class="form-control"
													name="workSortkey">
													<c:forEach var="workSort" items="${workSort}" varStatus="idx">
														<option value="${idx.count }">${idx.count } : ${workSort.title }</option>
													</c:forEach>
												</select>
											</div>
										</div>
										
										
										
										
										<div class="col-md-6 col-12">
											<div class="form-group">
												<label for="first-name-column">중요도</label> <select
													id="first-name-column" class="form-control"
													name="importance">
														<option value="1">최하</option>
														<option value="2">하</option>
														<option value="3">중</option>
														<option value="4">상</option>
														<option value="5">최상</option>
												</select>
											</div>
										</div>






										<div class="col-md-6 col-12">
											<div class="form-group">
												<label for="last-name-column">title</label> <input
													type="text" id="last-name-column" class="form-control"
													placeholder="Last Name" name="title">
											</div>
										</div>


										<div class="col-md-6 col-12">
											<div class="form-group">
												<label for="city-column">작성일</label> <input type="date"
													id="city-column" class="form-control"
													placeholder="writedateS" name="writeDateS">
											</div>
										</div>

										<div class="col-md-6 col-12">
											<div class="form-group">
												<label for="email-id-column">작성자</label> <input type="text"
													id="email-id-column" class="form-control"
													 placeholder="memberkey"
													value="${member.name }">
											</div>
										</div>

									</div>
									<div class="row">
										<div class="col-md-6 col-12" style="width: 100%">
											<div class="form-group">
												<label for="email-id-column">Contents</label>
												<textarea class="form-control" name="contents"
													placeholder="Contents" rows="6"></textarea>
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
										<button class="btn btn-danger me-1 mb-1"
											onclick="location.href='/project/projectHome.do?projectkey=1}'">뒤로가기</button>
										<button type="submit" class="btn btn-primary me-1 mb-1">등록</button>
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