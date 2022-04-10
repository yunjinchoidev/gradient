<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />
<!DOCTYPE html>
<%--


 --%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	$(document).ready(function() {
		
		var msg = "${msg}";
		
		if(msg!=''){
			alert(msg);
			location.href="${path}/qualityList.do";
		}
		
		// 한 화면에서 몇 개씩 볼 것인지 생각해봅시다.		
		var pageSize = "${qualitySch.pageSize}"
		$("[name=pageSize]").val(pageSize);

		$("[name=pageSize]").change(function() {
			$("[name=curPage]").val(1);
			$("#frm01").submit();
		});
	})

	
	
	
	function goPage(no) {
		// 현재 페이지에 입력한 no를 대입함으로써 페이지 이동 처리!
		$("[name=curPage]").val(no);
		$("#frm01").submit();
	}
	
	
	
</script>
<style>
#moveBtn a {
	width: 135px;
	margin-right: 10px;
	font-size: 20px;
	font-weight: bold;
}
</style>

<body>

	<%@ include file="../chatBot/chatBot.jsp"%>
	<%@ include file="../common/header.jsp"%>
	<div id="main">

		<div class="page-heading">
			<div class="page-title">
				<div class="row">

					
					<%@ include file="../projectHome/sort.jsp"%>

					<div class="col-12 col-md-6 order-md-1 order-last">
						<h3 onclick="location.href='/project5/qualityList.do'"
							style="cursor: pointer;">GRADIENT - 품질</h3>
						<p class="text-subtitle text-muted">For user to check they
							list</p>
					</div>
					<div class="col-12 col-md-6 order-md-2 order-first">
						<nav aria-label="breadcrumb"
							class="breadcrumb-header float-start float-lg-end">
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="index.html">Dashboard</a></li>
								<li class="breadcrumb-item active" aria-current="page">DataTable</li>
							</ol>
						</nav>
					</div>
				</div>
			</div>

			<section class="section">
				<div class="card">
					<div class="card-header">
						<a href="/project5/qualityList.do" class="btn btn-warning">품질
							건의</a> <a href="/project5/evalitem.do" class="btn btn-primary">품질
							평가 항목</a> <a href="#" class="btn btn-danger" data-bs-toggle="modal"
							data-bs-target="#evalModal">품질 평가</a> <a
							href="${path}/certiprj.do" class="btn btn-success">인증서 발급</a>
					</div>
					<div class="card-body">
						<div
							class="dataTable-wrapper dataTable-loading no-footer sortable searchable fixed-columns">







						
						<form id="frm01" class="form" action="${path}/qualityList.do"
							method="post">
							<div
								class="dataTable-wrapper dataTable-loading no-footer sortable searchable fixed-columns">
								<div class="dataTable-top">
									<div class="input-group-prepend">
										<input type="hidden" name="curPage" value="1" /> <span
											class="input-group-text">총 ${qualitySch.count}건</span>
									</div>

									<div class="dataTable-dropdown">
										<select class="dataTable-selector form-select" name="pageSize">
											<option value="3">3</option>
											<option value="5">5</option>
											<option value="10" selected="selected">10</option>
											<option value="15">15</option>
											<option value="20">20</option>
											<option value="25">25</option>
										</select><label>entries per page</label>
									</div>


									<script>
										$(document)
												.ready(
														function() {
															$(".searchbar")
																	.change(
																			function() {
																				alert("검색 종류를 변경합니다.");
																				$(
																						".searchWhat")
																						.attr(
																								"name",
																								this.value)
																				alert($(".searchWhat").value)
																			});

														});
									</script>



									<div class="dataTable-search" style="display: inline-block;">

										<div style="display: inline-block;">
											<select class="dataTable-selector form-select searchbar"
												name="searchbar" style="display: inline-block;">
												<option selected="selected">검색</option>
												<option value="title" selected="selected">title</option>
												<option value="contents">contents</option>
											</select>
										</div>

										<div style="display: inline-block;">
											<input style="display: inline-block;"
												class="dataTable-input searchWhat" placeholder="검색어를 입력"
												type="text" name="title">
											<button class="btn btn-info" type="submit">검색</button>
											<a href="/project5/qualityInsertFrom.do"
												class="btn btn-danger" style="text-align: right">글쓰기</a> 


										</div>
									</div>



								</div>
							</div>
						</form>









								</div>
								<div class="dataTable-container">
									<table class="table table-striped dataTable-table" id="table1">
										<thead>
											<tr>
												<th data-sortable="" style="width: 20%;"><a href="#"
													class="dataTable-sorter">품질평가</a></th>
												<th data-sortable="" style="width: 40%;"><a href="#"
													class="dataTable-sorter">프로젝트명</a></th>
												<th data-sortable="" style="width: 20%;"><a href="#"
													class="dataTable-sorter">작성일</a></th>
												<th data-sortable="" style="width: 20%;"><a href="#"
													class="dataTable-sorter">담당자</a></th>

											</tr>
										</thead>




										<tbody>
											<c:forEach var="list" items="${list}">
												<tr
													onclick="location.href='/project5/qualityGet.do?qualitykey='+${list.qualitykey}">
													<td>${list.qualitykey }</td>
													<td
														>${list.title }</td>
													<td>${list.writedate }</td>
													<td>${member.name}</td>
													<td><span class="badge bg-success">Active</span></td>
												</tr>
											</c:forEach>
									</table>
									</tbody>

								</div>




								<!-- class="page-item active" -->
							<ul class="pagination  justify-content-end">
								<li class="page-item"><a class="page-link"
									href="javascript:goPage(${qualitySch.startBlock!=1?qualitySch.startBlock-1:1})">Previous</a></li>
								<c:forEach var="cnt" begin="${qualitySch.startBlock}"
									end="${qualitySch.endBlock}">
									<li
										class="page-item ${cnt==qualitySch.curPage?'active':''}">
										<!-- 클릭한 현재 페이지 번호 --> <a class="page-link"
										href="javascript:goPage(${cnt})">${cnt}</a>
									</li>
									
								</c:forEach>
								<li class="page-item"><a class="page-link"
									href="javascript:goPage(${qualitySch.endBlock!=qualitySch.pageCount?qualitySch.endBlock+1:qualitySch.endBlock})">Next</a></li>
							</ul>
								
								
								
								
								
								
								
								
						</div>
					</div>
			</section>


		</div>

	</div>

	<!-- 품질평가 Modal ==장훈주 start== -->
	<div class="modal fade text-left" id="evalModal" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel33" aria-hidden="true">
		<div
			class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-lg"
			role="document">
			<div class="modal-content" style="overflow: auto;">
				<div class="modal-header">
					<h4 class="modal-title" id="myModalLabel33">품질평가</h4>
					<button type="button" class="close" data-bs-dismiss="modal"
						aria-label="Close">
						<i data-feather="x"></i>
					</button>
				</div>

				<!-- 모달 입력 요소 영역 -->
				<form id="qualityevalFrm" action="${path}/qualitypass.do"
					method="get">
					<div class="modal-body" style="margin: 10px;">
						<!-- 프로젝트 select box -->
						<div id="prjselect">
							<select class="form-select" style="text-align: center;"
								name="prjkey">
								<c:forEach var="prlist" items="${prjlist}">
									<option value="${prlist.prjkey}">${prlist.prjname}</option>
								</c:forEach>
							</select>
						</div>
						<!-- 품질 체크 항목 -->
						<div style="margin-top: 50px;">
							<!-- 1번문항 -->
							<c:forEach var="eval" items="${evallist}">
								<c:set var="i" value="${i+1}" />
								<c:set var="chk" value="${chk+1}" />
								<div style="margin-bottom: 20px;">
									<h5>${eval.evalkey}.${eval.evalcontent}</h5>
									<input type="radio" name="chk${chk}" class="form-check-input"
										id="flexRadioDefault${i}" value="10"> <label
										class="form-check-label" for="flexRadioDefault${i}">예</label>
									<input type="radio" name="chk${chk}" class="form-check-input"
										id="flexRadioDefault${i=i+1}" value="0"
										style="margin-left: 10px;"> <label
										class="form-check-label" for="flexRadioDefault${i}">아니오</label>
								</div>
							</c:forEach>
						</div>
					</div>
				</form>
				<!-- 버튼 영역 -->
				<div class="modal-footer">
					<button type="button" class="btn btn-light-secondary"
						data-bs-dismiss="modal">
						<i class="bx bx-x d-block d-sm-none"></i> <span
							class="d-none d-sm-block">닫기</span>
					</button>
					<button type="button" id="evalregBtn" class="btn btn-primary ml-1"
						data-bs-dismiss="modal">
						<i class="bx bx-check d-block d-sm-none"></i> <span
							class="d-none d-sm-block">등록</span>
					</button>
				</div>

			</div>
		</div>
	</div>
	<!-- ==장훈주 end== -->


</body>

<script>
	// 장훈주 추가 start
	$(document).ready(function() {

						var score = 0;
						var msg = "${msg}";

						if (msg == "합격처리되었습니다") {
							alert(msg)
							location.href = "${path}/qualityList.do"
						}

						if (msg == "인증되었습니다") {
							alert(msg)
							location.href = document.referrer;
						}

						$("#evalregBtn")
								.click(
										function() {

											if ($('input[name=chk1]').is(
													':checked') == false) {
												alert('1번 문항 품질 평가 항목을 확인해주세요');
												return
												

											} else if ($('input[name=chk2]')
													.is(':checked') == false) {
												alert('2번 문항 품질 평가 항목을 확인해주세요');
												return
												

											} else if ($('input[name=chk3]')
													.is(':checked') == false) {
												alert('3번 문항 품질 평가 항목을 확인해주세요');
												return
												

											} else if ($('input[name=chk4]')
													.is(':checked') == false) {
												alert('4번 문항 품질 평가 항목을 확인해주세요');
												return
												

											} else if ($('input[name=chk5]')
													.is(':checked') == false) {
												alert('5번 문항 품질 평가 항목을 확인해주세요');
												return
												

											} else if ($('input[name=chk6]')
													.is(':checked') == false) {
												alert('6번 문항 품질 평가 항목을 확인해주세요');
												return
												

											} else if ($('input[name=chk7]')
													.is(':checked') == false) {
												alert('7번 문항 품질 평가 항목을 확인해주세요');
												return
												

											} else if ($('input[name=chk8]')
													.is(':checked') == false) {
												alert('8번 문항 품질 평가 항목을 확인해주세요');
												return
												

											} else if ($('input[name=chk9]')
													.is(':checked') == false) {
												alert('9번 문항 품질 평가 항목을 확인해주세요');
												return
												

											} else if ($('input[name=chk10]')
													.is(':checked') == false) {
												alert('10번 문항 품질 평가 항목을 확인해주세요');
												return
												

											} else {
												for (var i = 1; i <= 10; i++) {
													score += parseInt($(
															'input[name=chk'
																	+ i
																	+ ']:checked')
															.val());
												}

												if (score != 100) {
													alert("불합격입니다");
													score = 0;
												} else {
													$("#qualityevalFrm")
															.submit();
												}

											}

										});

					});
	// 장훈주 추가 end
</script>

</html>