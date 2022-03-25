<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="../chatBot/chatBot.jsp"%>
	<%@ include file="../common/header.jsp"%>
	<div id="main">
		<section id="multiple-column-form">
			<div class="row match-height">
				<div class="col-12">
					<div class="card">

						<div class="card-header">
							<h4 class="card-title">투표 만들기</h4>
						</div>
						<form class="form" action="/project5/voteWrite.do">
							<input type="hidden" name="memberkey" value="${member.memberkey }">
							<div class="card-content">
								<div class="card-body">

									<div class="row">
										<div class="col-md-6 col-12">
											<div class="form-group">
												<label for="first-name-column">투표 주제</label> <input
													type="text" id="first-name-column" class="form-control"
													placeholder="투표 주제를 입력해주세요" name="title" >
											</div>
										</div>
										<div class="col-md-6 col-12">
											<div class="form-group">
												<label for="last-name-column">작성자 : </label> <input
													type="text" id="last-name-column" class="form-control"
													placeholder="Last Name" >
											</div>
										</div>
										<div class="col-md-6 col-12">
											<div class="form-group">
												<label for="city-column">시작일</label> <input type="date"
													id="city-column" class="form-control" placeholder="City"
													name="writedateS">
											</div>
										</div>
										<div class="col-md-6 col-12">
											<div class="form-group">
												<label for="city-column">마감일</label> <input type="date"
													id="city-column" class="form-control" placeholder="City"
													name="enddateS">
											</div>
										</div>
										
										
										<div class="col-md-6 col-12">
											<div class="form-group">
												<label for="first-name-column">프로젝트</label> <select
													id="first-name-column" class="form-control"
													name="projectkey">
													<c:forEach var="pjList" items="${pjList}" varStatus="idx">
														<option value="${idx.count }">${idx.count }:
															${pjList.name }</option>
													</c:forEach>
												</select>
											</div>
										
										</div>
										
										<div class="col-md-6 col-12">
											<div class="form-group">
												<label for="country-floating">옵션</label> <select
													id="country-floating" class="form-control"
													name="voteoption">
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
										<div class="col-md-6 col-12" style="margin: 0 auto;" >
											<div class="form-group">
												<label for="company-column">투표 항목</label> <input type="text"
													id="company-column" class="form-control"
													name="item1" placeholder="item1"
													style="margin-bottom: 10px;"> <input type="text"
													id="company-column" class="form-control"
													name="item2" placeholder="item2"
													style="margin-bottom: 10px;"> <input type="text"
													id="company-column" class="form-control"
													name="item3" placeholder="item3"
													style="margin-bottom: 10px;"> <input type="text"
													id="company-column" class="form-control"
													name="item4" placeholder="item4"
													style="margin-bottom: 10px;"> <input type="text"
													id="company-column" class="form-control"
													name="item5" placeholder="item5"
													style="margin-bottom: 10px;">
											</div>

										</div>
									</div>

										
										<div>
										<br>
										<br>
										</div>






									<div class="col-12 d-flex justify-content-end">
										<button type="button" class="btn btn-info me-1 mb-1" onclick="location.href='/project5/projectHome.do'">뒤로가기</button>
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