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
<style>

</style>
</head>

<body>
	<%@ include file="../common/header.jsp"%>
	<div id="main">
		<div class="page-heading">
			<div class="page-title">
				<div class="row">
					<div class="col-12 col-md-6 order-md-1 order-last">
						<h3>예산 관리</h3>
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
					<div class="card-body">
						<div class="dataTable-wrapper dataTable-loading no-footer sortable searchable fixed-columns">
						 <form>
							<div class="dataTable-top">
								<div class="dataTable-dropdown">
									<select class="dataTable-selector form-select">
										<option>5</option>
										<option>10</option>
										<option>15</option>
										<option>20</option>
										<option>25</option>
									</select>
									<label>게시글 수</label>
								</div>
								
								<div class="dataTable-search">
									<input class="dataTable-input" placeholder="Search..." type="text">
								</div>
							</div>
						  </form>
							<div class="dataTable-container">
								<table class="table table-striped dataTable-table" id="table1">
									<thead>
										<tr>
											<th data-sortable="" style="width: 5%;"><a
												href="#" class="dataTable-sorter">NO</a></th>
											<th data-sortable="" style="width: 33%;"><a
												href="#" class="dataTable-sorter">프로젝트명</a></th>
											<th data-sortable="" style="width: 10%;"><a
												href="#" class="dataTable-sorter">시작일</a></th>
											<th data-sortable="" style="width: 10%;"><a
												href="#" class="dataTable-sorter">종료일</a></th>
											<th data-sortable="" style="width: 25%;"><a
												href="#" class="dataTable-sorter">회사</a></th>
											<th data-sortable="" style="width: 7%;"><a
												href="#" class="dataTable-sorter">PM</a></th>
											<th data-sortable="" style="width: 10%;"><a
												href="#" class="dataTable-sorter">예산배정</a></th>
										</tr>
									</thead>

									<tbody>
										<c:forEach var="list" items="${list}">
											<tr>
												<td>Offenburg</td>
												<td>Offenburg</td>
												<td>Offenburg</td>
												<td>Offenburg</td>
												<td><span class="badge bg-success">Active</span></td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
								
								<button id="regbtn" class="btn btn-primary rounded-pill"
									style="margin: auto;display:block;">등록</button>								
							</div>

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