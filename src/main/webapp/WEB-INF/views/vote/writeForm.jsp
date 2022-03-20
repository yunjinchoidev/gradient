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
							<h4 class="card-title">투표 만들기</h4>
						</div>
						<form class="form" action="/project5/projectWrite.do">
							<div class="card-content">
								<div class="card-body">

									<div class="row">
										<div class="col-md-6 col-12">
											<div class="form-group">
												<label for="first-name-column">투표 주제</label> <input
													type="text" id="first-name-column" class="form-control"
													placeholder="프로젝트 명" name="fname-column">
											</div>
										</div>
										<div class="col-md-6 col-12">
											<div class="form-group">
												<label for="last-name-column">작성자 : </label> <input
													type="text" id="last-name-column" class="form-control"
													placeholder="Last Name" name="lname-column">
											</div>
										</div>
										<div class="col-md-6 col-12">
											<div class="form-group">
												<label for="city-column">마감일</label> <input type="date"
													id="city-column" class="form-control" placeholder="City"
													name="city-column">
											</div>
										</div>
										<div class="col-md-6 col-12">
											<div class="form-group">
												<label for="country-floating">옵션</label> <select
													id="country-floating" class="form-control"
													name="voteAttribute">
													<option>익명투표</option>
													<option>실명투표</option>
													<option>과반시 투표 자동종료</option>
												</select>

											</div>
										</div>

									</div>


									<div class="rows">
										<div class="col-md-6 col-12" style="width: 100%">
											<div class="form-group">
												<label for="email-id-column">설명</label>
												<textarea class="form-control" name="contents"
													placeholder="Contents" rows="4"></textarea>
											</div>
										</div>
									</div>

									<div>
										<br> <br>
									</div>

									<div class="rows">
										<div class="col-md-6 col-12" style="margin: 0 auto">
											<div class="form-group">
												<label for="company-column">투표 항목</label> <input type="text"
													id="company-column" class="form-control"
													name="company-column" placeholder="Company"
													style="margin-bottom: 10px;"> <input type="text"
													id="company-column" class="form-control"
													name="company-column" placeholder="Company"
													style="margin-bottom: 10px;"> <input type="text"
													id="company-column" class="form-control"
													name="company-column" placeholder="Company"
													style="margin-bottom: 10px;"> <input type="text"
													id="company-column" class="form-control"
													name="company-column" placeholder="Company"
													style="margin-bottom: 10px;"> <input type="text"
													id="company-column" class="form-control"
													name="company-column" placeholder="Company"
													style="margin-bottom: 10px;">

											</div>

										</div>
									</div>

										
										<div>
										<br>
										<br>
										</div>






									<div class="col-12 d-flex justify-content-end">
										<button type="button"
											class="btn btn-danger btn-icon icon-left">
											<i class="fas fa-plane"></i> 뒤로가기
										</button>
										<a href="/project5/projectHome.do" class="btn btn-info">뒤로가기</a>
										<button type="submit" class="btn btn-primary me-1 mb-1">등록</button>
										<button type="reset" class="btn btn-light-secondary me-1 mb-1">초기화</button>
									</div>
								</div>

							</div>
						</form>
					</div>
				</div>
			</div>
		</section>
	</div>

</body>
</html>