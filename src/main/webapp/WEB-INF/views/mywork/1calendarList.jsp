<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GRADIENT-나의 작업</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script scr="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&amp;display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="/project5/resources/dist/assets/css/bootstrap.css">
<link rel="stylesheet"
	href="/project5/resources/dist/assets/css/pages/email.css">
<link rel="stylesheet"
	href="/project5/resources/dist/assets/vendors/perfect-scrollbar/perfect-scrollbar.css">
<link rel="stylesheet"
	href="/project5/resources/dist/assets/vendors/bootstrap-icons/bootstrap-icons.css">
<link rel="stylesheet"
	href="/project5/resources/dist/assets/css/app.css">
<link rel="shortcut icon"
	href="/project5/resources/dist/assets/images/favicon.svg"
	type="image/x-icon">


</head>


<script>
	$(document).ready(function() {

		var pageSize = "${calendarSch.pageSize}"
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
		<div class="page-heading email-application">
			<div class="page-title">
				<div class="row">
					<div class="col-12 col-md-6 order-md-1 order-last">
						<h3>내 작업 목록</h3>
						<p class="text-subtitle text-muted">당신이 해야만 하는 일입니다.</p>
					</div>
					<div class="col-12 col-md-6 order-md-2 order-first">
						<nav aria-label="breadcrumb"
							class="breadcrumb-header float-start float-lg-end">
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="index.html">Dashboard</a></li>
								<li class="breadcrumb-item active" aria-current="page">Email
									Application</li>
							</ol>
						</nav>
					</div>
				</div>
			</div>


			<section class="section content-area-wrapper" style="height: 5000px;">
				<%@ include file="leftSide.jsp"%>




				<div class="content-right">
					<div class="content-overlay"></div>
					<div class="content-wrapper">
						<div class="content-header row"></div>
						<div class="content-body">
							<!-- email app overlay -->
							<div class="app-content-overlay"></div>
							<div class="email-app-area">
								<!-- Email list Area -->
								<div class="email-app-list-wrapper">
									<div class="email-app-list">
										<div class="email-action">
											<!-- action left start here -->
											<div class="action-left d-flex align-items-center">
												<!-- select All checkbox -->


												<form id="frm01" class="form"
													action="${path}/myWork1.do?memberkey=${member.memberkey}"
													method="post">
													<div
														class="dataTable-wrapper dataTable-loading no-footer sortable searchable fixed-columns">
														<div class="dataTable-top">
															<div class="input-group-prepend">
																<input type="hidden" name="curPage" value="1" /> <span
																	class="input-group-text">총 ${calendarSch.count}건</span>
															</div>

															<div class="dataTable-dropdown">
																<select class="dataTable-selector form-select"
																	name="pageSize">
																	<option value="3">3</option>
																	<option value="5">5</option>
																	<option value="10" selected="selected">10</option>
																	<option value="15">15</option>
																	<option value="20">20</option>
																	<option value="25">25</option>
																</select>
															</div>


															<script>
																$(document)
																		.ready(
																				function() {
																					$(
																							".searchbar")
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



															<div class="dataTable-search"
																style="display: inline-block;">

																<div style="display: inline-block;">
																	<select
																		class="dataTable-selector form-select searchbar"
																		name="searchbar" style="display: inline-block;">
																		<option selected="selected">검색</option>
																		<option value="name" selected="selected">title</option>
																		<option value="email">contents</option>
																	</select>
																</div>

																<div style="display: inline-block;">
																	<input style="display: inline-block;"
																		class="dataTable-input searchWhat"
																		placeholder="검색어를 입력" type="text" name="title"
																		value="${calendarSch.title}">
																	<button class="btn btn-info" type="submit">검색</button>
																	<a class="btn btn-danger" style="text-align: right"
																		data-bs-toggle="modal" data-bs-target="#inlineForm">메모
																		쓰기</a>
																</div>
															</div>



														</div>
													</div>
												</form>


											</div>
											<!-- action left end here -->

											<!-- action right start here -->
											<div
												class="action-right d-flex flex-grow-1 align-items-center justify-content-around">
												<!-- search bar  -->
												<div class="email-fixed-search flex-grow-1">
													<div class="sidebar-toggle d-block d-lg-none">
														<i class="bx bx-menu"></i>
													</div>
												</div>
												<!-- pagination and page count -->

												<div class="dataTable-bottom">
													<ul class="pagination  justify-content-end">
														<li class="page-item"><a class="page-link"
															href="javascript:goPage(${calendarSch.startBlock!=1?calendarSch.startBlock-1:1})">Previous</a></li>
														<c:forEach var="cnt" begin="${calendarSch.startBlock}"
															end="${calendarSch.endBlock}">
															<li
																class="page-item ${cnt==calendarSch.curPage?'active':''}">
																<!-- 클릭한 현재 페이지 번호 --> <a class="page-link"
																href="javascript:goPage(${cnt})">${cnt}</a>
															</li>
														</c:forEach>
														<li class="page-item"><a class="page-link"
															href="javascript:goPage(${calendarSch.endBlock!=calendarSch.pageCount?calendarSch.endBlock+1:calendarSch.endBlock})">Next</a></li>
													</ul>
												</div>

											</div>
										</div>
										<!-- / action right -->


























										<!-- email user list start -->
										<div class="email-user-list list-group ps ps--active-y"
											style="height: 5000px;">
											<ul class="users-list-wrapper media-list">


												<c:forEach var="list" items="${list }" varStatus="var">
													<li class="media mail-read"
														onclick="window.open('/project5/myWorkCalendarGet.do?id=${list.id}','팝업창','width=500, height=610, left=400, top=200');">
														<div class="user-action">
															<div class="checkbox-con me-3">
																<div class="checkbox checkbox-shadow checkbox-sm">
																	<input type="checkbox" id="checkboxsmall1"
																		class="form-check-input"> <label
																		for="checkboxsmall1"></label>
																</div>
															</div>
															<span class="favorite text-warning"> <svg
																	class="bi" width="1.5em" height="1.5em"
																	fill="currentColor">
                                                        	<use
																		xlink:href="assets/vendors/bootstrap-icons/bootstrap-icons.svg#star-fill"></use></svg>
															</span>
														</div>




														<div class="pr-50">
															<div class="avatar">
																<img
																	src="/project5/resources/dist/assets/images/faces/1.jpg"
																	alt="avtar img holder">
															</div>
														</div>

														<div class="media-body">
															<div class="user-details">

																<div class="mail-items">
																	<span class="list-group-item-text text-truncate">[${list.id}]${list.title}</span>
																</div>

																<div class="mail-meta-item">
																	<span class="float-right"> <span
																		class="mail-date">${list.start1 }</span>
																	</span>
																</div>

															</div>

															<div class="mail-message">
																<p class="list-group-item-text truncate mb-0">
																	${list.content }</p>
																<div class="mail-meta-item">
																	<span class="float-right"> <span
																		class="bullet bullet-success bullet-sm">${list.end1 }</span>
																	</span>
																</div>
															</div>
														</div>
													</li>
												</c:forEach>
											</ul>
											<!-- email user list end -->



											<!-- no result when nothing to show on list -->
											<div class="no-results">
												<i class="bx bx-error-circle font-large-2"></i>
												<h5>No Items Found</h5>
											</div>






											<div class="ps__rail-x" style="left: 0px; bottom: 0px;">
												<div class="ps__thumb-x" tabindex="0"
													style="left: 0px; width: 0px;"></div>
											</div>
											<div class="ps__rail-y"
												style="top: 0px; height: 733px; right: 0px;">
												<div class="ps__thumb-y" tabindex="0"
													style="top: 0px; height: 567px;"></div>
											</div>



										</div>
									</div>
								</div>
								<!--/ Email list Area -->



							</div>
						</div>
					</div>
				</div>
			</section>
		</div>
	</div>








</body>
<script
	src="/project5/resources/dist/assets/vendors/perfect-scrollbar/perfect-scrollbar.min.js"></script>
<script src="/project5/resources/dist/assets/js/bootstrap.bundle.min.js"></script>
<script src="/project5/resources/dist/assets/js/main.js"></script>
</html>