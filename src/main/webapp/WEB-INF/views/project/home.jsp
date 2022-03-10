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
<title>프로젝트 홈</title>
</head>

<body>
	<%@ include file="../common/header.jsp"%>
	
	
	
	<div id="main">
	
		<div class="page-heading">
			<div class="page-title">
				<div class="row">
					<div class="col-12 col-md-6 order-md-1 order-last">
						<h3>프로젝트 홈</h3>
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
				<div class="buttons" style="margin-bottom: 10px; margin-top: 5px;">
                                        <a href="#" class="btn btn-primary">WBS [간트차트]</a>
                                        <a href="#" class="btn btn-secondary">일정관리[풀캘린더]</a>
                                        <a href="#" class="btn btn-info">회의록</a>
                                        <a href="#" class="btn btn-warning">프로젝트 채팅 방</a>
                                        <a href="#" class="btn btn-danger">예산 관리</a>
                                        <a href="#" class="btn btn-success">품질 관리</a>
                                        <a href="#" class="btn btn-light">리스크 관리</a>
                                        <a href="#" class="btn btn-dark">조달 관리</a>
                                    </div>
			</div>
			<section class="section">
				<div class="card">
					<div class="card-header">프로젝트 공지사항</div>
					<div class="card-body">
						<div
							class="dataTable-wrapper dataTable-loading no-footer sortable searchable fixed-columns">
							
							
							
							<div class="dataTable-top">
								<div class="dataTable-dropdown" style="width:30%;">
									<select class="dataTable-selector form-select" ><option
											value="5">5</option>
										<option value="10" selected="">10</option>
										<option value="15">15</option>
										<option value="20">20</option>
										<option value="25">25</option></select><label>entries per page</label>
								</div>
								<div class="dataTable-search">
									<input class="dataTable-input" placeholder="Search..."
										type="text">
										<a href="/project5/projectWriteForm.do" class="btn btn-danger" style="text-align: right">글쓰기</a>
								</div>
							</div>
							
							
							
							
							
							<div class="dataTable-container">
								<table class="table table-striped dataTable-table" id="table1">
									<thead>
										<tr>
											<th data-sortable="" style="width: 12.0176%;"><a
												href="#" class="dataTable-sorter">Name</a></th>
											<th data-sortable="" style="width: 42.9989%;"><a
												href="#" class="dataTable-sorter">Email</a></th>
											<th data-sortable="" style="width: 18.0816%;"><a
												href="#" class="dataTable-sorter">Phone</a></th>
											<th data-sortable="" style="width: 16.3175%;"><a
												href="#" class="dataTable-sorter">City</a></th>
											<th data-sortable="" style="width: 10.8049%;"><a
												href="#" class="dataTable-sorter">Status</a></th>
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