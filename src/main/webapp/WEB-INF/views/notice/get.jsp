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
							<h4 class="card-title">공지사항</h4>
						</div>
						
						<div class="card-content">
							<div class="card-body">
								<form class="form" action="/project5/noticeWrite.do" method="get">
									<div class="row">
										<div class="col-md-6 col-12">
											<div class="form-group">
												<label for="first-name-column">공지 제목</label> <input
													type="text" id="first-name-column" class="form-control"
													placeholder="title" name="title" value="${notice.title }" readonly="readonly">
											</div>
										</div>
										<div class="col-md-6 col-12">
											<div class="form-group">
												<label for="last-name-column">작성일</label> <input
													type="date" id="last-name-column" class="form-control"
													placeholder="writeDate" name="writeDate" value="${notice.writeDate }">
											</div>
										</div>
										<div class="col-md-6 col-12">
											<div class="form-group">
												<label for="city-column">City</label> <input type="text"
													id="city-column" class="form-control" placeholder="City"
													name="city-column">
											</div>
										</div>
										<div class="col-md-6 col-12">
											<div class="form-group">
												<label for="country-floating">Country</label> <input
													type="text" id="country-floating" class="form-control"
													name="country-floating" placeholder="Country">
											</div>
										</div>
										<div class="col-md-6 col-12">
											<div class="form-group">
												<label for="company-column">Company</label> <input
													type="text" id="company-column" class="form-control"
													name="company-column" placeholder="Company">
											</div>
										</div>
										<div class="col-md-6 col-12">
											<div class="form-group">
												<label for="email-id-column">Email</label> <input
													type="email" id="email-id-column" class="form-control"
													name="email-id-column" placeholder="Email">
											</div>
										</div>
										<div class="col-md-6 col-12">
											<div class="form-group">
												<label for="email-id-column">Contents</label> <textarea
													 class="form-control"
													name="content" placeholder="content" rows="4" readonly="readonly">${notice.content }</textarea>
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
										<button type="button" class="btn btn-danger btn-icon icon-left" style="height: 90%;" onclick="location.href='/project5/notice.do'">
                                            <i class="fas fa-plane"></i> 목록으로
                                        </button>
											<button type="submit" class="btn btn-primary me-1 mb-1">수정하기</button>
											<button type="reset"
												class="btn btn-light-secondary me-1 mb-1">삭제하기</button>
										</div>
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