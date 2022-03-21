<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	$(document).ready(function() {
		var whatVote;
		
		var voteItem1="${get.voteItem1}";
		var voteItem2="${get.voteItem2}";
		var voteItem3="${get.voteItem3}";
		var voteItem4="${get.voteItem4}";
		var voteItem5="${get.voteItem5}";
		
		if(whatVote==1){
			voteItem1+=1;
		}else if(whatVote==2){
			voteItem2+=1;
		}else if(whatVote==3){
			voteItem3+=1;
		}else if(whatVote==4){
			voteItem4+=1;
		}else{
			voteItem5+=1;
		}
		
		formObj = $("form")
		$("#voting").click(function(e) {
			e.preventDefault();
			whatVote = $("[name=item]:checked").val();
			confirm("정말 투표하시겠습니까? : " + whatVote);
			console.log("whatVote : " + whatVote);
			//formObj.submit();
		
			var data = {voteItem1 : voteItem1};
			
			$.ajax({
				url : '/project5/voting.do',
				data : data,
				type : 'post',
				success : function(result){
					alert("성공")
				},
				error : function(result){
					alert("실패")
				}
			})
		
		
		})
		
		
		
		
		
		
	})
</script>


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
							<input type="hidden" name="memberkey"
								value="${member.memberkey }">
							<div class="card-content">
								<div class="card-body">

									<div class="row">
										<div class="col-md-6 col-12">
											<div class="form-group">
												<label for="first-name-column">투표 주제</label> <input
													type="text" id="first-name-column" class="form-control"
													placeholder="프로젝트 명" name="title" value="${get.title}"
													readonly="readonly">
											</div>
										</div>
										<div class="col-md-6 col-12">
											<div class="form-group">
												<label for="last-name-column">작성자 : </label> <input
													type="text" id="last-name-column" class="form-control"
													placeholder="Last Name" value="${get.memberkey}"
													readonly="readonly">
											</div>
										</div>
										<div class="col-md-6 col-12">
											<div class="form-group">
												<label for="city-column">시작일</label> <input type="date"
													id="city-column" class="form-control" placeholder="City"
													name="writedateS" value="${get.writedate}"
													readonly="readonly">
											</div>
										</div>
										<div class="col-md-6 col-12">
											<div class="form-group">
												<label for="city-column">마감일</label> <input type="date"
													id="city-column" class="form-control" placeholder="City"
													name="enddateS" value="${get.enddate}" readonly="readonly">
											</div>
										</div>


										<div class="col-md-6 col-12">
											<div class="form-group">
												<label for="first-name-column">프로젝트</label> <input
													type="text" id="first-name-column" class="form-control"
													name="voteoption" value="${get.projectkey }"
													readonly="readonly">


											</div>

										</div>

										<div class="col-md-6 col-12">
											<div class="form-group">
												<label for="country-floating">옵션</label> <input type="text"
													id="country-floating" class="form-control"
													name="voteoption" value="${get.voteoption }"
													readonly="readonly">
											</div>
										</div>

									</div>


									<div class="rows">
										<div class="col-md-6 col-12" style="width: 100%">
											<div class="form-group">
												<label for="email-id-column">설명</label>
												<textarea class="form-control" name="contents"
													placeholder="Contents" rows="4" readonly="readonly">value="${get.contents}"</textarea>
											</div>
										</div>
									</div>

									<div>
										<br> <br>
									</div>



									<form action="/project5/voting.do">
										<div class="rows">
											<div class="col-md-6 col-12"
												style="margin-left: 550px; font-size: 35px;">
												<div class="form-group">
													<label for="company-column">투표 항목</label> <br>
												</div>

												<ul class="list-unstyled mb-0">
													<li class="d-inline-block me-2 mb-1">
														<div class="form-check">
															<div class="custom-control custom-checkbox">
																<input type="checkbox"
																	class="form-check-input form-check-primary" checked=""
																	name="item" id="customColorCheck1" value="1"> <label
																	class="form-check-label" for="customColorCheck1">1
																	: ${get.item1} : 득표수 : ${get.voteItem1} </label>
															</div>
														</div>
													</li>
													<br>
													<li class="d-inline-block me-2 mb-1">
														<div class="form-check">
															<div class="custom-control custom-checkbox">
																<input type="checkbox"
																	class="form-check-input form-check-secondary"
																	name="item" id="customColorCheck2" value="2"> <label
																	class="form-check-label" for="customColorCheck2">2
																	: ${get.item2}  : 득표수 : ${get.voteItem2} </label>
															</div>
														</div>
													</li>
													<br>
													<li class="d-inline-block me-2 mb-1">
														<div class="form-check">
															<div class="custom-control custom-checkbox">
																<input type="checkbox"
																	class="form-check-input form-check-success" name="item"
																	id="customColorCheck3" value="3"> <label
																	class="form-check-label" for="customColorCheck3">3
																	: ${get.item3} : 득표수 : ${get.voteItem3} </label>
															</div>
														</div>
													</li>
													<br>
													<li class="d-inline-block me-2 mb-1">
														<div class="form-check">
															<div class="custom-control custom-checkbox">
																<input type="checkbox"
																	class="form-check-input form-check-danger" name="item"
																	id="customColorCheck4" value="4"> <label
																	class="form-check-label" for="customColorCheck4">4
																	: ${get.item4} : 득표수 : ${get.voteItem4}</label>
															</div>
														</div>
													</li>
													<br>
													<li class="d-inline-block me-2 mb-1">
														<div class="form-check">
															<div class="custom-control custom-checkbox">
																<input type="checkbox"
																	class="form-check-input form-check-info" name="item"
																	id="customColorCheck5" value="5"> <label
																	class="form-check-label" for="customColorCheck5">5
																	: ${get.item5} : 득표수 : ${get.voteItem5}</label>
															</div>
														</div>
													</li>
													<br>
												</ul>
											</div>
										</div>


										<div>
											<br> <br>
										</div>






										<div class="col-12 d-flex justify-content-end">
											<button type="button" class="btn btn-danger me-1 mb-1"
												id="voting">투표하기</button>
											<button type="button" class="btn btn-info me-1 mb-1"
												onclick="location.href='/project5/projectHome.do?projectkey=1'">뒤로가기</button>
											<!-- 
											<button type="submit" class="btn btn-primary me-1 mb-1">등록</button>
											<button type="reset"
												class="btn btn-light-secondary me-1 mb-1">초기화</button>
												 -->
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