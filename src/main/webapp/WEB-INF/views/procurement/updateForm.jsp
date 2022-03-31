<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>


<script>
	$(document).ready(function() {
		var procurementkey = "${procurement.procurementkey}"
		console.log("procurementkey : " + procurementkey);
		$("#del").click(function() {
			confirm("정말 삭제하시겠습니까?");
			location.href = "/project5/procurementDelete.do?procurementkey=" + procurementkey;
		})

		var formObj = $("form")
		$("#update").click(function(e) {
			e.preventDefault();
			confirm("정말 수정하시겠습니까?");
			formObj.submit();
		})

	})
</script>



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
							<h4 class="card-title">조달 리스트</h4>
						</div>
						<form action="/project5/procurementUpdate.do">
						<input type="hidden" name="procurementkey" value="${procurement.procurementkey }">
						<div class="card-content">
							<div class="card-body">
								<div class="row">
				
										<div class="col-md-6 col-12">
											<div class="form-group">
												<label for="first-name-column">제목</label> <input
													type="text" id="first-name-column" class="form-control"
													placeholder="title" name="title" value="${get.title }"
													>
											</div>
										</div>								

										<div class="col-md-6 col-12">
											<div class="form-group">
												<label for="last-name-column">작성일</label> <input
													id="last-name-column" class="form-control"
													readonly="readonly" placeholder="writeDates"
												
													value='<fmt:formatDate type="both" value="${get.writedate}" />' />
											</div>
										</div>




										<div class="col-md-6 col-12">
											<div class="form-group">
												<label for="email-id-column">Contents</label>
												<textarea class="form-control" name="content"
													placeholder="content" rows="4" readonly="readonly">${get.contents }</textarea>
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
												class="btn btn-danger btn-icon icon-left"
												style="height: 90%;"
												onclick="location.href='/project5/procurementList.do'">
												<i class="fas fa-plane"></i> 목록으로
											</button>
											<button type="button" class="btn btn-primary me-1 mb-1"
												id="update">수정하기</button>
											<button type="button"
												class="btn btn-light-secondary me-1 mb-1" id="del">삭제하기</button>
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