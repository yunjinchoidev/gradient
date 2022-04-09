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
							<h4 class="card-title">프로젝트 홈 조회</h4>
						</div>

						<div class="card-content">
							<div class="card-body">

									<input type="hidden" name="memberkey"
										value="${member.memberkey }"> 
									<div class="row">
										<div class="col-md-6 col-12">
											<div class="form-group">
												<label for="first-name-column">제목</label> <input type="text"
													id="first-name-column" class="form-control"
													name="projectkey" readonly="readonly" value="${get.title }">
											</div>
										</div>

										<div class="col-md-6 col-12">
											<div class="form-group">
												<label for="first-name-column">중요도	
												
												</label> 
												<input type="text"
													id="first-name-column" class="form-control"
													name="projectkey" readonly="readonly" value="${get.importance }"
													>
												
											</div>
										</div>






										<div class="col-md-6 col-12">
											<div class="form-group">
												<label for="last-name-column">title</label> <input
													type="text" id="last-name-column" class="form-control"
													placeholder="Last Name" name="title" value="${get.title }"
													readonly="readonly">
											</div>
										</div>


										<div class="col-md-6 col-12">
											<div class="form-group">
												<label for="city-column">작성일</label> <input type="text"
													id="city-column" class="form-control"
													value='<fmt:formatDate value="${get.writedate }"/>' readonly="readonly">
											</div>
										</div>

										<div class="col-md-6 col-12">
											<div class="form-group">
												<label for="email-id-column">작성자</label> <input type="text"
													id="email-id-column" class="form-control"
													 placeholder="memberkey"
													value="${member.name }" readonly="readonly">
											</div>
										</div>

									</div>
									<div class="row">
										<div class="col-md-6 col-12" style="width: 100%">
											<div class="form-group">
												<label for="email-id-column">Contents</label>
												<textarea class="form-control" name="contents"
													placeholder="Contents" rows="6" readonly="readonly">${get.contents }</textarea>
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
										<button class="btn btn-danger me-1 mb-1" type="button"
											onclick="location.href='/project5/projectHome.do'">뒤로가기</button>
										<button type="button" class="btn btn-primary me-1 mb-1"
										onclick="location.href='/project5/projectHomeUpdateForm.do?projectHomekey=${get.projectHomekey}'">수정하기</button>
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