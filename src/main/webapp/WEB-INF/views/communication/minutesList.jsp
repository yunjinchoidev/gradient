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
	<title>회의 | 리스트</title>
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script>
	$(document).ready(function() {
		$("#writeBtn").click(function() {
			location.href = "${path}/minutes.do?method=insertFrm";
		});
	});
	function detail(minuteskey) {
		location.href = "${path}/minutes.do?method=detail&minutesKey="+minuteskey;
	}
	</script>
</head>

<body>
	<%@ include file="../common/header.jsp"%>
	<div id="main">

		<div class="page-heading">
			<div class="page-title">
				<div class="row">
					<div class="col-12 col-md-6 order-md-1 order-last">
						<h3>팀별 회의 공간</h3>
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
					<div class="card-header">Simple Datatable</div>
					<div class="card-body">
						<div
							class="dataTable-wrapper dataTable-loading no-footer sortable searchable fixed-columns">
							<div class="dataTable-top">
								<div class="dataTable-dropdown">
									<select class="dataTable-selector form-select"><option
											value="5">5</option>
										<option value="10" selected="">10</option>
										<option value="15">15</option>
										<option value="20">20</option>
										<option value="25">25</option></select><label>entries per page</label>
								</div>
								<div class="dataTable-search">
									<input class="dataTable-input" placeholder="Search..."
										type="text">
										<a href="#" class="btn btn-danger" style="text-align: right">검색</a>
								</div>
								
							</div>
							<div class="dataTable-container">
								<table class="table table-striped dataTable-table" id="table1">
									<col width="5%">
								   	<col width="20%">
								   	<col width="10%">
								   	<col width="10%">
								   	<col width="10%">
								   	<col width="20%">
								   	<col width="10%">
									<thead>
										<tr>
											<th data-sortable="">No</th>
											<th data-sortable="">회의안건</th>
											<th data-sortable="">회의일시</th>
											<th data-sortable="">작성일자</th>
											<th data-sortable="">수정일자</th>
											<th data-sortable="">부서</th>
											<th data-sortable="">작성자</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="m" items="${mList}">
											<tr ondblclick="detail(${m.minutesKey})">
												<td>${m.minutesKey}</td>
												<td>${m.topic}</td>
												<td><fmt:formatDate value="${m.conferenceDate}" /></td>
												<td><fmt:formatDate value="${m.writeDate}" /></td>
												<td><fmt:formatDate value="${m.updateDate}" /></td>
												<td>${m.partname}</td>
												<td>${m.memberKey}</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
							<input type="button" id="writeBtn" class="btn btn-primary" value="새 회의록"/>

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

			</section>
		</div>

	</div>
</body>
</html>