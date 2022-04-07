<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	$(document).ready(function(){
		var outputkey = parseInt("${get.outputkey}")
		$("[name=outputkey]").val(outputkey)
		
		$("#assessBtn").click(function(){
			if("${member.auth}" == "pm"){
				confirm("평가하시겠습니까?")
			}else{
				"pm 외에는 평가 불가합니다."
			}			
		})


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
							<h4 class="card-title">산출물 조회  
								<span class="badge bg-warning" style="cursor: pointer;" data-bs-toggle="modal"  data-bs-target="#inlineForm" id="assessBtn" value="${list.outputkey }"
													>평가하기</span>
													<span>${get.evaluation }</span>
							</h4>
						</div>

						<div class="card-content">
							<div class="card-body">

								<form class="form" action="/project5/projectHomeWrite.do">
									<input type="hidden" name="memberkey"
										value="${member.memberkey }">
									<div class="row">


										<div class="col-md-6 col-12">
											<div class="form-group">
												<label for="last-name-column">제목</label> <input type="text"
													id="last-name-column" class="form-control"
													placeholder="Last Name" name="title" value="${get.title }"
													>
											</div>
										</div>



										<div class="col-md-6 col-12">
											<div class="form-group">
												<label for="first-name-column">프로젝트</label> <input
													type="text" value="${get.pname }" id="first-name-column"
													class="form-control" name="pname" >
											</div>
										</div>

										<div class="col-md-6 col-12">
											<div class="form-group">
												<label for="first-name-column">작업 구분</label> <input
													type="text" value="${get.worksortTitle }"
													id="first-name-column" class="form-control"
													name="workSortkey" >
											</div>
										</div>

										<div class="col-md-6 col-12">
											<div class="form-group">
												<label for="first-name-column">부서 구분</label> <input
													type="text" value="${get.dname }" id="first-name-column"
													class="form-control" name="dname" >
											</div>
										</div>







										<div class="col-md-6 col-12">
											<div class="form-group">
												<label for="first-name-column">상황</label> <input type="text"
													value="${get.status }" id="first-name-column"
													class="form-control" name="status" >
											</div>
										</div>


										<div class="col-md-6 col-12">
											<div class="form-group">
												<label for="city-column">작성일 ${get.writedate}</label> <input
													type="text" id="city-column" class="form-control"
													placeholder="writedateS" name="writeDateS"
													value='<fmt:formatDate value="${get.writedate }" />'
													>
											</div>
										</div>







										<div class="col-md-6 col-12">
											<div class="form-group">
												<label for="email-id-column">버전</label> <input type="text"
													id="email-id-column" class="form-control"
													placeholder="memberkey" name="version"
													value="${get.version }" >
											</div>
										</div>


										<div class="col-md-6 col-12">
											<div class="form-group">
												<label for="email-id-column">작성자</label> <input type="text"
													id="email-id-column" class="form-control"
													placeholder="memberkey" value="${member.name }"
													>
											</div>
										</div>



									</div>
									<div class="row">
										<div class="col-md-6 col-12" style="width: 100%">
											<div class="form-group">
												<label for="email-id-column">Contents</label>
												<textarea class="form-control" name="contents"
													placeholder="Contents" rows="6" >
													${get.contents }
													</textarea>
											</div>
										</div>
									</div>


										
											<c:forEach var="fname" items="${get.fnames }">
											<div class="input-group mb-3 fileCls">
												<div class="input-group-prepend">
													<span class="input-group-text" 
														onclick="downFile('${fname}')">첨부 파일(다운로드)</span>
														<span onclick="downFile('${fname}')" > ${fname}</span>
												</div>
											</div> 	 
											</c:forEach>
			
											<script>
											function downFile(fname){
												if(confirm("다운로드할 파일:"+fname)){
													location.href="${path}/download.do?fname="+fname;
												}
											}
											</script>








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
										<button type="submit" class="btn btn-primary me-1 mb-1">수정하기</button>
										<button type="reset" class="btn btn-light-secondary me-1 mb-1">삭제하기</button>
										<button type="button" class="btn btn-danger me-1 mb-1"
											onclick="location.href='${path}/output.do?projectkey=1'">뒤로가기</button>
									</div>
								</form>


							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
	</div>
	
	
	
	
	
	<form action="/project5/outputEvaluation.do">
		<div class="modal fade text-left" id="inlineForm" tabindex="-1"
			role="dialog" aria-labelledby="myModalLabel33" aria-hidden="true">
			<div
				class="modal-dialog modal-dialog-centered modal-dialog-scrollable"
				role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title" id="myModalLabel33">평가하기</h4>
						<button type="button" class="close" data-bs-dismiss="modal"
							aria-label="Close">
							<i data-feather="x"></i>
						</button>
					</div>

					<div class="modal-body">
				
					<label>outputkey: </label>
					<div class="form-group">
						<input type="text" name="outputkey" class="form-control">
					</div>

					<label>평가점수 : </label>
						<div class="form-group">
							<select class="form-control" name="evaluation" >
								<option value="1">1</option>
								<option value="2">2</option>
								<option value="3">3</option>
								<option value="4">4</option>
								<option value="5">5</option>
								<option value="6">6</option>
								<option value="7">7</option>
								<option value="8">8</option>
								<option value="9">9</option>
								<option value="10">10</option>
							</select>
						</div>
					</div>


					<div class="modal-footer">
						<button type="button" class="btn btn-light-secondary"
							data-bs-dismiss="modal">
							<i class="bx bx-x d-block d-sm-none"></i> <span
								class="d-none d-sm-block">닫기</span>
						</button>
						<button type="submit" class="btn btn-danger ml-2">
							<i class="bx bx-check d-block d-sm-none"></i> <span
								class="d-none d-sm-block">수정</span>
						</button>
					</div>

				</div>
			</div>
		</div>
</form>	
	
	
</body>
</html>