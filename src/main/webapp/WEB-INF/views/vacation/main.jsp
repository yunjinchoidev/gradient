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
<style>
.bg-light-secondary {
	width: 110px;
	height: 30px;
}
</style>
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


<script>
    $(document).ready(function(){
	
	$("#regbtn").click(function(){
		location.href="${path}/RegTeam.do";
	});
</script>
</head>

<!-- 팀관리 전체 조회  -->

<body>

	<%@ include file="../chatBot/chatBot.jsp" %>
	<%@ include file="../common/header.jsp"%>
	<div id="main">
		<div class="page-heading">
			<div class="page-title">
						<%@ include file="../projectHome/sort.jsp" %>



				<div class="row">
					<div class="col-12 col-md-6 order-md-1 order-last">
					<%@ include file="../attendance/sort.jsp" %>
						<h3>휴가 관리</h3>
							
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

			<br>
				

			<section class="section">
				<div class="card">
						<div class="card-header">
							여러 기능들이 있습니다.<br> <br>
							<div class="buttons" style="margin-bottom: 10px; margin-top: 5px;">
								<a href="#" class="btn btn-danger" id="mailSendBtn">휴가 계획서 </a> 
								
							</div>
						</div>
					
					
						<div
							class="dataTable-wrapper dataTable-loading no-footer sortable searchable fixed-columns">
							<form id="schform" action="${path}/team.do" method="post">
								<input type="hidden" name="curPage" value="1" />
								<div class="dataTable-top">
									<div class="dataTable-search">
										<input type="text" id="schFrm" name="sch"
											class="dataTable-input" placeholder="Search..." type="text">
											<a href="/project5/vacationWriteForm.do" class="btn btn-danger" >휴가 신청</a> 
									</div>
								</div>
							</form>
							<div class="dataTable-container">
								<table class="table table-striped dataTable-table" id="table1">
									<thead>
										<tr>
											<th data-sortable="" style="width: 10%;"><a href="#"
												class="dataTable-sorter">이름</a></th>
											<th data-sortable="" style="width: 10%;"><a href="#"
												class="dataTable-sorter">직급</a></th>
											<th data-sortable="" style="width: 35%;"><a href="#"
												class="dataTable-sorter">이메일</a></th>
											<th data-sortable="" style="width: 20%;"><a href="#"
												class="dataTable-sorter">담당프로젝트</a></th>
											<th data-sortable="" style="width: 20%;"><a href="#"
												class="dataTable-sorter">담당업무</a></th>
										</tr>
									</thead>

									<tbody>

										<c:forEach var="list" items="${projetList}">
											<tr onclick="TeamDetail(${list.projectkey})">
												<td>${list.name}</td>
												<c:if test="${list.progress eq '진행전'}">
													<td><span class="badge bg-primary">${list.progress}</span></td>
												</c:if>
												<c:if test="${list.progress eq '진행중'}">
													<td><span class="badge bg-warning">${list.progress}</span></td>
												</c:if>
												<c:if test="${list.progress eq '진행완료'}">
													<td><span class="badge bg-success">${list.progress}</span></td>
												</c:if>
											</tr>
										</c:forEach>
									</tbody>
								</table>

							</div>

						</div>
					</div>
				</div>

			</section>
		</div>

	</div>
	<!--  페이징 처리/ 프론트만 구현 -->
	<div class="dataTable-bottom">
		<div class="dataTable-info">전체 팀: ${TeamSch.count}</div>
		<nav aria-label="Page navigation example" style="margin-top: 15px;">
			<ul
				class="pagination pagination-primary float-end dataTable-pagination">
				<li class="page-item pager"><a class="page-link"
					href="javascript:goPage(${TeamSch.startBlock!=1?costSch.startBlock-1:1})">‹</a></li>
				<c:forEach var="cnt" begin="${TeamSch.startBlock}"
					end="${TeamSch.endBlock}">
					<li class="page-item ${cnt==TeamSch.curPage?'active':''}">
						<!-- 클릭한 현재 페이지 번호 --> <a class="page-link"
						href="javascript:goPage(${cnt})">${cnt}</a>
					</li>
				</c:forEach>
				<li class="page-item pager"><a class="page-link"
					href="javascript:goPage(${TeamSch.endBlock!=TeamSch.pageCount?TeamSch.endBlock+1:TeamSch.endBlock})">›</a></li>
			</ul>
	</div>
</body>
</html>