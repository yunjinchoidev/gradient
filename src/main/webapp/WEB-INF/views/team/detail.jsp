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
		var msg = "${msg}";
		if(msg!=""){
			if(confirm(msg+"\n메인화면으로 이동할까요?")){
				location.href="${path}/teamlist.do";
			}
		}

		$("#allCheck").click(function() {
			if ($("#allCheck").prop("checked")) {
				alert("전체 클릭합니다.")
				$("input[type=checkbox]").prop("checked", true);
			} else { //해당화면에 모든 checkbox들의 체크를해제시킨다. 
				alert("전체 클릭 해제합니다.")
				$("input[type=checkbox]").prop("checked", false);
			}
		})


$("#uptBtn").click(function(){
	if(confirm("수정하시겠습니까?")){
		location.href="${path}/updateTeam.do?memberprojectkey="+$("[name=memberprojectkey]").val();
	}
});
$("#backbtn").click(function(){
	location.href="${path}/detail.do";
});	

	});
	
</script>
</head>

<!-- 팀 배정 목록  -->

<body>
	<%@ include file="../common/header.jsp"%>
	<div id="main">
		<div class="page-heading">
			<div class="page-title">

				<%@ include file="../projectHome/sort.jsp"%>






				<div class="row">
					<div class="col-12 col-md-6 order-md-1 order-last">
						<h3>팀 배정 목록</h3>

						<a href="/project5/insertTeam.do" class="badge bg-light-secondary"
							data-bs-toggle="modal" data-bs-target="#regModal">팀 배정</a> <a
							href="/project5/teamdetail.do" class="badge bg-light-secondary">배정
							목록 </a> <a
							href="/project5/output.do?projectkey=${project.projectkey }"
							class="badge bg-light-secondary">휴가 관리</a> <a
							href="/project5/minutes.do?method=list&projectkey=${project.projectkey }"
							class="badge bg-light-secondary">근태 관리</a>


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

			<br> <input type="hidden" name="projectkey"
				value="${tdlist.projectkey}">
			<section class="section">
				<div class="card">
					<div class="card-body">
						<div
							class="dataTable-wrapper dataTable-loading no-footer sortable searchable fixed-columns">
							<input type="hidden" name="curPage" value="1" />
							<div class="dataTable-top">
								<div class="dataTable-search">
									<input type="text" id="schFrm" name="sch"
										class="dataTable-input" placeholder="Search..." type="text">

								</div>
							</div>
							<div class="dataTable-container">
								<table class="table table-striped dataTable-table" id="table1">
									<thead>
										<tr>
											<th data-sortable="" style="width: 8%;"><a href="#"
												class="dataTable-sorter" style="text-align: center;">이름</a></th>
											<th data-sortable="" style="width: 10%;"><a href="#"
												class="dataTable-sorter" style="text-align: center;">직급</a></th>
											<th data-sortable="" style="width: 10%;"><a href="#"
												class="dataTable-sorter" style="text-align: center;">부서명</a></th>
											<th data-sortable="" style="width: 20%;"><a href="#"
												class="dataTable-sorter" style="text-align: center;">이메일</a></th>
											<th data-sortable="" style="width: 25%;"><a href="#"
												class="dataTable-sorter" style="text-align: center;">프로젝트명</a></th>
											<th data-sortable="" style="width: 15%;"><a href="#"
												class="dataTable-sorter" style="text-align: center;">프로젝트
													배정상태</a></th>
											<th data-sortable="" style="width: 8%; text-align: center;"><span
												class="dataTable-sorter">선택&nbsp;&nbsp;&nbsp; <input
													type="checkbox"
													class="form-check-input form-check-info chk"
													name="cbx_chkAll" style="border: 1px solid black"
													id="allCheck">
											</span></th>
										</tr>
									</thead>

									<tbody>

										<c:forEach var="tdlist" items="${tdlist}">
											<tr onclick="detail(${tdlist.memberprojectkey})"
												data-toggle="modal" data-target="#exampleModalCenter">
												<td style="text-align: center;">${tdlist.name}</td>
												<td style="text-align: center;">${tdlist.auth}</td>
												<td style="text-align: center;">${tdlist.dname}</td>
												<td style="text-align: center;">${tdlist.email}</td>
												<td style="text-align: center;">${tdlist.projectname}</td>
												<td><c:choose>
														<c:when test="${tdlist.status eq '배정'}">
															<span class="badge bg-success"
																style="text-align: center;">${tdlist.status}</span>
														</c:when>
														<c:when test="${tdlist.status eq '미배정'}">
															<span class="badge bg-danger">${tdlist.status}</span>
														</c:when>
													</c:choose></td>
												<td>
													<div style="margin-left: 30px;">
														<input type="hidden" name="arrayParam" id="arrayParam">
														<input type="checkbox"
															class="form-check-input form-check-info chk" name="email"
															value="${tdlist.email }"
															style="border: 1px solid black; margin: 0 auto">
													</div>
												</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
								</form>
								<div
									style="margin-top: 30px; align-content: right; float: right;">
									<!-- 수정버튼 -->
									<button class="btn btn-warning" id="uptbtn">수정</button>
									<!-- 삭제버튼 -->
									<button class="btn btn-danger" id="delbtn">삭제</button>
									<!-- 돌아가기버튼 -->
									<button class="btn btn-primary" id="backbtn">뒤로가기</button>

								</div>
							</div>
						</div>
					</div>
				</div>

			</section>
		</div>

	</div>
</body>
</html>