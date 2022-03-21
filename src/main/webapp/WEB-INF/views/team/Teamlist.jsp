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


<script>
$(document).ready(function(){
	
	var msg = "${msg}";
				
	if(msg!=""){
		alert(msg);
		if(msg=="팀원배정이 완료되었습니다"){
			location.href="${path}/team.do";
		}
	}
	$("#regBtn").click(function(){
		if(confirm("팀원을 배정하시겠습니까?')){
			$('#regForm').submit();
		}
	});

</script>
</head>

<!-- 팀관리 전체 조회  -->

<body>
	<%@ include file="../common/header.jsp"%>
	<div id="main">
		<div class="page-heading">
			<div class="page-title">
				<div class="row">
					<div class="col-12 col-md-6 order-md-1 order-last">
						<h3>인적 관리</h3>
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
						<div
							class="dataTable-wrapper dataTable-loading no-footer sortable searchable fixed-columns">
							<form id="schform" action="${path}/team.do" method="post">
								<input type="hidden" name="curPage" value="1" />
								<div class="dataTable-top">
									<div class="dataTable-search">
										<input type="text" id="schFrm" name="sch"
											class="dataTable-input" placeholder="Search..." type="text">
									</div>
								</div>
							</form>
							<div class="dataTable-container">
								<table class="table table-striped dataTable-table" id="table1">
									<thead>
										<tr>
											<th data-sortable="" style="width: 20%;"><a href="#"
												class="dataTable-sorter">이름</a></th>
											<th data-sortable="" style="width: 20%;"><a href="#"
												class="dataTable-sorter">부서명</a></th>
											<th data-sortable="" style="width: 20%;"><a href="#"
												class="dataTable-sorter">권한</a></th>
											<th data-sortable="" style="width: 20%;"><a href="#"
												class="dataTable-sorter">프로젝트명</a></th>
											<th data-sortable="" style="width: 20%;"><a href="#"
												class="dataTable-sorter">진행사항</a></th>
										</tr>
									</thead>

									<tbody>

										<c:forEach var="teamlist" items="${teamlist}">
											<tr onclick="TeamDetail(${teamlist.teamkey})">
												<td>${teamlist.name}</td>
												<td>${teamlist.dname}</td>
												<td>${teamlist.auth}</td>
												<td>${teamlist.projectname}</td>
												<td>${teamlist.progress}</td>
											</tr>
										</c:forEach>

									</tbody>

								</table>

								<button style="margin: auto; display: block;" id="teamregbtn"
									class="btn btn-primary rounded-pill" data-bs-toggle="modal"
									data-bs-target="regModal">팀원배정</button>

							</div>

						</div>
					</div>
				</div>

			</section>
		</div>

	</div>
	<!-- 팀원배정 Modal -->
	<div class="modal fade text-left" id="regModal" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel33" aria-hidden="true">
		<div
			class="modal-dialog modal-dialog-centered modal-dialog-scrollable"
			role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="myModalLabel33">팀원 배정</h4>
					<button type="button" class="close" data-bs-dismiss="modal"
						aria-label="Close">
						<i data-feather="x"></i>
					</button>
				</div>
				<form id="regForm" action="${path}/insertTeam.do" method="post">
					<!-- 모달 입력 요소 영역 -->
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
													<!-- 팀원 이름 -->
							<div id="name" style="flex: 4;">
								<input class="form-control" type="text" name="name">
							</div>

						<!-- 중요도, 제목 공통 영역 -->
						<div id="headerdiv" style="display: flex; margin-top: 10px;">
							<!-- 부서명 -->
							<div id="dname" style="flex: 1; margin-right: 5px;">
								<select class="form-select" name="dname">
									<option value="기획">기획</option>
									<option value="회계">회계</option>
									<option value="인사">인사</option>
									<option value="마케팅">마케팅</option>
									<option value="front">front</option>
									<option value="backend">backend</option>
									<option value="custom">custom</option>
								</select>
							</div>
							<!-- 권한 -->
							<div id="auth" style="flex: 1; margin-right: 5px;">
								<select class="form-select" name="auth">
									<option value="pm">pm</option>
									<option value="CEO">CEO</option>
									<option value="staff">staff</option>
								</select>
							</div>
							
						</div>
						<!-- 진행사항, 완료 예정일 영역 -->
						<div id="footerdiv" style="display: flex; margin-top: 10px;">
							<!-- 진행사항 -->
							<div id="importselectdiv" style="flex: 3; margin-right: 150px;">
								<select class="form-select" name="progress">
									<option value="진행중">진행중</option>
									<option value="대기">대기</option>
									<option value="완료">완료</option>
								</select>
							</div>
						</div>

					</div>
					<!-- 버튼 영역 -->
					<div class="modal-footer">
						<button type="button" class="btn btn-light-secondary"
							data-bs-dismiss="modal">
							<i class="bx bx-x d-block d-sm-none"></i> <span
								class="d-none d-sm-block">닫기</span>
						</button>
						<button type="button" id="regBtn" class="btn btn-primary ml-1"
							data-bs-dismiss="modal">
							<i class="bx bx-check d-block d-sm-none"></i> <span
								class="d-none d-sm-block">배정완료</span>
						</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!--  페이징 처리/ 프론트만 구현 -->
	<nav aria-label="Page navigation example" style="margin-top: 15px;">
		<ul class="pagination pagination-primary  justify-content-center">
			<li class="page-item disabled"><a class="page-link" href="#"
				tabindex="-1" aria-disabled="true">Previous</a></li>
			<li class="page-item active"><a class="page-link" href="#">1</a></li>
			<li class="page-item"><a class="page-link" href="#">2</a></li>
			<li class="page-item"><a class="page-link" href="#">3</a></li>
			<li class="page-item"><a class="page-link" href="#">Next</a></li>
		</ul>
	</nav>
</body>
</html>