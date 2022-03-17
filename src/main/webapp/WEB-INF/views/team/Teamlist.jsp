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
<title>팀 관리</title>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="/project5/resources/dist/assets/css/bootstrap.css">
<link rel="stylesheet"
	href="/project5/resources/dist/assets/vendors/perfect-scrollbar/perfect-scrollbar.css">
<link rel="stylesheet"
	href="/project5/resources/dist/assets/vendors/bootstrap-icons/bootstrap-icons.css">
<link rel="stylesheet"
	href="/project5/resources/dist/assets/css/app.css">
<link rel="stylesheet"
	href="/project5/resources/dist/assets/vendors/simple-datatables/style.css">
<link rel="shortcut icon"
	href="/project5/resources/dist/assets/images/favicon.svg"
	type="image/x-icon">

<script src="http://code.jquery.com/jquery-latest.min.js"></script>

</head>

<!-- 팀관리 전체 조회  -->

<body>
	<%@ include file="../common/header.jsp"%>
	<div id="main">
		<!-- 팀관리 목록 -->
		<div class="page-heading">
			<div class="page-title">
				<div class="row">
					<div class="col-12 col-md-6 order-md-1 order-last">
						<h3>인적 관리</h3>
						<p class="text-subtitle text-muted">For user to check their
							team members</p>
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
				<div style="margin-top: 30px; margin-left: 15px; align-content:right;float:left;">
				<button class="btn btn-primary" id="backbtn">팀원추가</button>
				</div>
					<div class="card-body">
						<div
							class="dataTable-wrapper dataTable-loading no-footer sortable searchable fixed-columns">
							<div class="dataTable-top">
								
								<div class="dataTable-search">
									<input class="dataTable-input" placeholder="Search..."
										type="text"> <a href="/project5/scheduleInsertForm.do"
										class="btn btn-primary" style="text-align: right">검색</a>
								</div>

							</div>
							<div class="dataTable-container">
								<table class="table table-striped dataTable-table" id="table1">
									<thead>
										<tr>
											<th data-sortable="" style="width: 12.0176%;"><a
												href="#" class="dataTable-sorter">이름</a></th>
											<th data-sortable="" style="width: 10.8049%;"><a
												href="#" class="dataTable-sorter">권한</a></th>
											<th data-sortable="" style="width: 18.0816%;"><a
												href="#" class="dataTable-sorter">부서명</a></th>
											<th data-sortable="" style="width: 16.3175%;"><a
												href="#" class="dataTable-sorter">프로젝트명</a></th>
												<th data-sortable="" style="width: 42.9989%;"><a
												href="#" class="dataTable-sorter">프로젝트 진행상황</a></th>
										</tr>
									</thead>
										<tbody>
											<c:forEach var="team" items="${teamList}">
												<td>${team.name}</td>
												<td>${team.auth}</td>
												<td>${team.dname}</td>
												<td>${team.projectname}</td>
												<td>${team.progress}</span></td>
												<td><a href="#" class="btn btn-sm btn-outline-primary">관리</a></td>
												<td><a href="#"><i
														class="badge-circle badge-circle-light-secondary font-medium-1"
														data-feather="mail"></i></a></td>
											</c:forEach>
										</tbody>
									</table>
								</div>
								<!--  페이징 처리/ 프론트만 구현 -->
										<div class="dataTable-bottom">
								<div class="dataTable-info">Showing 1 to 10 of 26 entries</div>
								<ul
									class="pagination pagination-primary float-end dataTable-pagination">
									<li class="page-item pager"><a href="#" class="page-link"
										data-page="1">‹</a></li>
									<li class="page-item active"><a href="#" class="page-link"
										data-page="1">1</a></li>
									<li class="page-item"><a href="#" class="page-link"
										data-page="2">2</a></li>
									<li class="page-item"><a href="#" class="page-link"
										data-page="3">3</a></li>
									<li class="page-item pager"><a href="#" class="page-link"
										data-page="2">›</a></li>
								</ul>
							</div>
							</div>
						</div>
					</div>
				</div>
			</section>
</body>
</html>