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
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<script>
	$(document).ready(function() {
						$("#pjList").change(
										function() {
											var selectedval = $(this).val();
											console.log(selectedval);
											location.href = "/project5/projectHome.do?projectkey="
													+ selectedval;
										})


		var psc = "${psc}"
		if(psc=="voteSuccess"){
			alert("성공적으로 투표하였습니다.")
		}
	
	})
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
	<%@ include file="../common/header.jsp"%>



	<div id="main">

		<div class="page-heading">
			<div class="page-title">
				<div class="row">

					<%@ include file="sort.jsp"%>






					<div class="col-12 col-md-6 order-md-1 order-last">
						<span style="font-size: 40px; font-weight: bolder; color: red;">[${project.name }]
						</span> <span style="font-size: 40px; font-weight: bolder; color: black;">홈</span>
						<p class="text-subtitle text-muted">공지를 확인하십시오.</p>
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
					<div class="card-header">프로젝트 공지사항</div>
					<div class="card-body">
						<div
							class="dataTable-wrapper dataTable-loading no-footer sortable searchable fixed-columns">



							<div class="dataTable-top">
								<div class="dataTable-dropdown" style="width: 30%;">
									<select class="dataTable-selector form-select"><option
											value="5">5</option>
										<option value="10" selected="">10</option>
										<option value="15">15</option>
										<option value="20">20</option>
										<option value="25">25</option></select><label>entries per page</label>
								</div>
								<div class="dataTable-search">
									<input class="dataTable-input" placeholder="Search..."
										type="text"> <a
										href="/project5/projectHomeWriteForm.do"
										class="btn btn-danger" style="text-align: right">글쓰기</a> <a
										href="/project5/voteWriteForm.do" class="btn btn-info"
										style="text-align: right">투표만들기</a> <a
										href="/project5/voteWriteForm.do" class="btn btn-secondary"
										style="text-align: right">진행중인 투표</a> <a
										href="/project5/voteWriteForm.do" class="btn btn-warning"
										style="text-align: right">투표 결과</a>
								</div>
							</div>





							<div class="dataTable-container">
								<table class="table table-striped dataTable-table" id="table1">
									<thead>
										<tr>
											<th data-sortable="" style="width: 12.0176%;"><a
												href="#" class="dataTable-sorter">번호</a></th>
											<th data-sortable="" style="width: 42.9989%;"><a
												href="#" class="dataTable-sorter">제목</a></th>
											<th data-sortable="" style="width: 18.0816%;"><a
												href="#" class="dataTable-sorter">작성날짜</a></th>
											<th data-sortable="" style="width: 16.3175%;"><a
												href="#" class="dataTable-sorter">작업구분</a></th>
											<th data-sortable="" style="width: 10.8049%;"><a
												href="#" class="dataTable-sorter">중요도</a></th>
										</tr>
									</thead>




									<tbody>

										<c:forEach var="list" items="${voteList }">
											<tr>
												<td>${list.votekey }</td>
												<td style="color: red; cursor:pointer" onclick="location.href='/project5/voteGet.do?votekey=${list.votekey}'" >[[투표]][${project.name }]
													${list.title }</td>
												<td><fmt:formatDate value="${list.writedate }" /></td>
												<td><fmt:formatDate value="${list.enddate }" /></td>
												<td>${list.voteoption}</td>
											</tr>
										</c:forEach>


										<c:forEach var="list" items="${list }">
											<tr>
												<td>${list.projectHomekey }</td>
												<td>[${project.name }][${list.workSortTitle}]
													${list.title }</td>
												<td><fmt:formatDate value="${list.writedate }" /></td>
												<td>${list.workSortTitle}</td>

												<td><c:if test="${list.importance==1 }">
														<span class="badge bg-success">최하</span>
													</c:if> <c:if test="${list.importance==2 }">
														<span class="badge bg-info">하</span>
													</c:if> <c:if test="${list.importance==3 }">
														<span class="badge bg-secondary">중</span>
													</c:if> <c:if test="${list.importance==4 }">
														<span class="badge bg-warning">상</span>
													</c:if> <c:if test="${list.importance==5 }">
														<span class="badge bg-danger">최상</span>
													</c:if></td>
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