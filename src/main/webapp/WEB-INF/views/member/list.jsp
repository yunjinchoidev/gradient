
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>

<script>
	$(document)
			.ready(
					function() {

						var psc = $("psc")
						if (psc == "EmailSuccess") {
							alert("이메일 발송이 완료 되었습니다.")
						}

						$("#allCheck").click(
								function() {
									if ($("#allCheck").prop("checked")) {
										alert("전체 클릭합니다.")
										$("input[type=checkbox]").prop(
												"checked", true);
									} else { //해당화면에 모든 checkbox들의 체크를해제시킨다. 
										alert("전체 클릭 해제합니다.")
										$("input[type=checkbox]").prop(
												"checked", false);
									}
								})

						$("#ManageBtn").click(function() {
							confirm("이 회원을 가입 승인 하시겠습니까?")
						})

						$("#passRE").click(function() {
							confirm("이 회원에게 새로운 비밀번호를 발급 하시겠습니까?")
						})

						$("#exileBtn").click(function() {
							confirm("회원을 추방 하시겠습니까?")
						})

						$("#assessBtn").click(function() {
							confirm("회원을 평가 하시겠습니까?")

						})

						$("#mailSendBtn")
								.click(
										function(e) {
											confirm("메일을 발송하시겠습니까?")
											var array = new Array();
											$(
													'input:checkbox[name=email]:checked')
													.each(
															function() {
																array
																		.push(this.value);
																console
																		.log(this.value);
																alert(this.value);
															})
											alert(array);
											location.href = "/project5/memberChkSendMail.do?arrayParam="
													+ array;
										})

						var pageSize = "${memberSch.pageSize}"
						$("[name=pageSize]").val(pageSize);
						$("[name=pageSize]").change(function() {
							$("[name=curPage]").val(1);
							$("#frm01").submit();
						});

						var msg = "${msg}";
						if (msg != "") {
							if (confirm(msg + "\n메인화면으로 이동할까요?")) {
								location.href = "${path}/memberList.do";
							}
						}

					});

	function goPage(no) {
		$("[name=curPage]").val(no);
		$("#frm01").submit();
	}
</script>


<body>
	<%@ include file="../chatBot/chatBot.jsp"%>
	<%@ include file="../common/header.jsp"%>

	<div id="main">
		<header class="mb-3">
			<a href="#" class="burger-btn d-block d-xl-none"> <i
				class="bi bi-justify fs-3"></i>
			</a>
		</header>

		<div class="page-heading">
			<div class="page-title">
				<div class="row">
					<div class="col-12 col-md-6 order-md-1 order-last">
						<h1 style="color: red">
							(security)어드민(연결 계정:
							<sec:authentication property="name" />
							)
						</h1>
						<h3>회원관리</h3>
						<p class="text-subtitle text-muted">이곳에서 회원을 관리하십시오</p>
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
						여러 기능들이 있습니다.<br> <br>
						<div class="buttons" style="margin-bottom: 10px; margin-top: 5px;">
							<a href="#" class="btn btn-info" id="mailSendBtn">메일발송</a>
						</div>
					</div>


					<div class="card-body">

						<form id="frm01" class="form" action="${path}/memberList.do"
							method="post">
							<div
								class="dataTable-wrapper dataTable-loading no-footer sortable searchable fixed-columns">
								<div class="dataTable-top">
									<div class="input-group-prepend">
										<input type="hidden" name="curPage" value="1" /> <span
											class="input-group-text">총 ${memberSch.count}건</span>
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
												<option value="name" selected="selected">title</option>
												<option value="email">contents</option>
											</select>
										</div>

										<div style="display: inline-block;">
											<input style="display: inline-block;"
												class="dataTable-input searchWhat" placeholder="검색어를 입력"
												type="text" name="title" value="${memberSch.name}">
											<button class="btn btn-info" type="submit">검색</button>
										</div>
									</div>



								</div>
							</div>
						</form>





















						<div class="dataTable-container">
							<table class="table table-striped dataTable-table" id="table1">
								<thead>
									<tr>
										<th data-sortable="" style="width: 4.8185%;"><a href="#"
											class="dataTable-sorter">번호</a></th>
										<th data-sortable="" style="width: 13.9018%;"><a href="#"
											class="dataTable-sorter">이름</a></th>

										<th data-sortable="" style="width: 25.8021%;"><a href="#"
											class="dataTable-sorter">이메일</a></th>

										<th data-sortable="" style="width: 12.423%;"><a href="#"
											class="dataTable-sorter">직급</a></th>
										<th data-sortable="" style="width: 12.423%;"><a href="#"
											class="dataTable-sorter">상황</a></th>

										<th data-sortable="" style="width: 15.051%;"><a href="#"
											class="dataTable-sorter">관리</a></th>


										<th data-sortable="" style="width: 12.051%;"><span
											class="dataTable-sorter">전체 선택&nbsp;&nbsp;&nbsp; <input
												type="checkbox" class="form-check-input form-check-info chk"
												name="cbx_chkAll" style="border: 1px solid black"
												id="allCheck">
										</span></th>

									</tr>
								</thead>

								<tbody>

									<c:forEach var="list" items="${list }">
										<input type="hidden" name="memberkey"
											value="${list.memberkey }">
										<tr>
											<td><span class="badge bg-secondary">[${list.memberkey}]</span></td>
											<td>${list.name}</td>
											<td>${list.email }</td>
											<td>${list.auth }</td>


											<td style="cursor: pointer;"><c:if
													test="${list.status == 0}">
													<span class="badge bg-dark">비활성화</span>
												</c:if> <c:if test="${list.status == 1}">
													<span class="badge bg-danger nowRequesting" id="ManageBtn"
														onclick="location.href='/project5/memberRegister.do?memberkey=${list.memberkey}'">요청
														중</span>
												</c:if> <c:if test="${list.status == 2}">
													<span class="badge bg-primary">발급 완료</span>
												</c:if> <c:if test="${list.status == 3}">
													<span class="badge bg-warning" id="passRE"
														onclick="location.href='/project5/memberPassFind.do?memberkey=${list.memberkey}'">비밀번호
														<br>재발급 신청
													</span>
												</c:if></td>


											<td><span class="badge bg-success" id="assessBtn"
												style="cursor: pointer;">평가 하기</span> <span
												class="badge bg-danger" id="exileBtn"
												style="cursor: pointer;"
												onclick="location.href='/project5/memberDelete2.do?memberkey=${list.memberkey}'">강제
													추방</span></td>


											<td>
												<div style="margin-left: 30px;">
													<input type="hidden" name="arrayParam" id="arrayParam">
													<input type="checkbox"
														class="form-check-input form-check-info chk" name="email"
														value="${list.email }"
														style="border: 1px solid black; margin: 0 auto">
												</div>
											</td>

										</tr>
									</c:forEach>
							</table>
						</div>


						<script>
							/*
									$(document).ready(function(){
										var i=0;
										setInterval(function() {
											i++;
											if(i%2==0){
												$(".nowRequesting").show()
											}else{
												$(".nowRequesting").hide()
											}
										}, 1000);

									})
							 */
						</script>






						<div class="dataTable-bottom">
							<div class="dataTable-info">Showing 1 to 10 of 26 entries</div>
							<ul class="pagination  justify-content-end">
								<li class="page-item"><a class="page-link"
									href="javascript:goPage(${memberSch.startBlock!=1?memberSch.startBlock-1:1})">Previous</a></li>
								<c:forEach var="cnt" begin="${memberSch.startBlock}"
									end="${memberSch.endBlock}">
									<li class="page-item ${cnt==memberSch.curPage?'active':''}">
										<!-- 클릭한 현재 페이지 번호 --> <a class="page-link"
										href="javascript:goPage(${cnt})">${cnt}</a>
									</li>
								</c:forEach>
								<li class="page-item"><a class="page-link"
									href="javascript:goPage(${memberSch.endBlock!=memberSch.pageCount?memberSch.endBlock+1:memberSch.endBlock})">Next</a></li>
							</ul>
						</div>
					</div>
				</div>
		</div>

		</section>
	</div>

	</div>
</body>
</html>