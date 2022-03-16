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
<link rel="stylesheet" href="/project5/resources/dist/assets/css/app.css">
<link rel="stylesheet"
	href="/project5/resources/dist/assets/vendors/simple-datatables/style.css">
<link rel="shortcut icon"
	href="/project5/resources/dist/assets/images/favicon.svg"
	type="image/x-icon">

<script src="http://code.jquery.com/jquery-latest.min.js"></script>

</head>

<!-- 팀관리 전체 조회  -->

<body>
    <div id="main">
     <%@ include file="../common/header.jsp"%>
    </div>
    
	<!-- 팀관리 목록 -->
	<section class="section">
		<div class="row" id="table-hover-row">
			<div class="col-12">
				<div class="card">
					<div class="card-header">
						<h4 class="card-title">팀 관리</h4>
						<p>팀 프로젝트에 참여중인 사용자를 확인하실 수 있습니다.</p>
					</div>
					<div class="card-content">
						<!-- 테이블 위의 상단탭 (정상/중지 탭) -->
						<ul class="nav nav-tabs" id="myTab" role="tablist">
							<li class="nav-item" role="presentation"><a
								class="nav-link active" id="normal-tab" data-bs-toggle="tab"
								href="#normal" role="tab" aria-controls="normal"
								aria-selected="true">정상</a></li>
							<li class="nav-item" role="presentation"><a class="nav-link"
								id="stop-tab" data-bs-toggle="tab" href="#stop" role="tab"
								aria-controls="stop" aria-selected="false">중지</a></li>
						</ul>
						<!--  검색 기능 추가 -->
						<div class="search" style="text-align:right;">
						<input type="text" name="keyword" value=""></input>
						<input type="button" onclick="#" class="btn btn-outline-primary mr-2" value="검색"></input>
						</div>
						<!-- table hover -->
						<div class="table-responsive">
							<table class="table table-hover mb-0">
								<thead>
									<tr>
									    <th>No.</th>
										<th>이름</th>
										<th>권한</th>
										<th>부서명</th>
										<th>프로젝트명</th>
										<th>프로젝트 진행상황</th>
									</tr>
								</thead>
									<tbody>
									    <c:forEach var="team" items="${teamList}">
									    <!-- 숫자 증가처리? -->
									    <td></td>
										<td class="text-bold-500">${team.name}</td>
										<td>${team.auth}</td>
										<td class="text-bold-500">${team.dname}</td>
										<td>${team.projectname}</td>
										<td><span class="badge bg-success">${team.progress}</span></td>
										<td><a href="#" class="btn btn-sm btn-outline-primary">관리</a></td>
										<td><a href="#"><i
												class="badge-circle badge-circle-light-secondary font-medium-1"
												data-feather="mail"></i></a></td>
										</c:forEach>
								</tbody>
							</table>
						</div>
						<!--  페이징 처리/ 프론트만 구현 -->
						<nav aria-label="Page navigation example"
							style="margin-top: 15px;">
							<ul class="pagination pagination-primary  justify-content-center">
								<li class="page-item disabled"><a class="page-link"
									href="#" tabindex="-1" aria-disabled="true">Previous</a></li>
								<li class="page-item active"><a class="page-link" href="#">1</a></li>
								<li class="page-item"><a class="page-link" href="#">2</a></li>
								<li class="page-item"><a class="page-link" href="#">3</a></li>
								<li class="page-item"><a class="page-link" href="#">Next</a></li>
							</ul>
						</nav>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Hoverable rows end -->
</body>
</html>