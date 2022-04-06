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
$(document).ready(function() {
	var proc = "${proc}";
	if(proc!=""){
		alert(proc);
		if(proc=="배정되었습니다!")
		location.href="${path}/teamlist.do";
	}
	$("#regBtn").click(function(){
		if(confirm("배정하시겠습니까?")){
			$("#frm02").submit();
		}
	});

$("#uptBtn").click(function(){
	if(confirm("수정하시겠습니까?")){
		$("#frm02").attr("action","${path}/updateTeam.do");
		$("#frm02").submit();
	}
});		
});
function regFun(){
$("#frm02")[0].reset(); // 초기화 처리.
$("#regBtn").show();$("#uptBtn").hide();$("#delBtn").hide();		
}
function detail(name, auth, email, dname, projectname, status){
console.log(name);
console.log(auth);
console.log(email);
console.log(dname);
console.log(projectname);
console.log(status);
	
// 각각의 form에 데이터 할당.
$("#frm02 [name=name]").val(name);
$("#frm02 [name=auth]").val(auth);
$("#frm02 [name=email]").val(email);
$("#frm02 [name=dname]").val(dname);
$("#frm02 [name=projectname]").val(projectname);
$("#frm02 [name=status]").val(status);
}

	
</script>
</head>

<!-- 팀관리 전체 조회  -->

<body>
	<%@ include file="../common/header.jsp"%>
	<div id="main">
		<div class="page-heading">
			<div class="page-title">

				<%@ include file="../projectHome/sort.jsp"%>






				<div class="row">
					<div class="col-12 col-md-6 order-md-1 order-last">
						<h3>팀 관리</h3>

						<a href="/project5/insertTeam.do" class="badge bg-light-secondary"
							data-bs-toggle="modal" data-bs-target="#regModal">팀 할당</a> <a
							href="/project5/Allocation.do" class="badge bg-light-secondary">프로젝트
							할당</a> <a
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

			<br>

			<section class="section">
				<div class="card">
					<div class="card-body">
						<div
							class="dataTable-wrapper dataTable-loading no-footer sortable searchable fixed-columns">
							<form id="schform" action="${path}/teamlist.do" method="post">
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
											<th data-sortable="" style="width: 10%;"><a href="#"
												class="dataTable-sorter">이름</a></th>
											<th data-sortable="" style="width: 10%;"><a href="#"
												class="dataTable-sorter">직급</a></th>
											<th data-sortable="" style="width: 10%;"><a href="#"
												class="dataTable-sorter">부서명</a></th>
											<th data-sortable="" style="width: 25%;"><a href="#"
												class="dataTable-sorter">이메일</a></th>
											<th data-sortable="" style="width: 25%;"><a href="#"
												class="dataTable-sorter">프로젝트명</a></th>
											<th data-sortable="" style="width: 25%;"><a href="#"
												class="dataTable-sorter">프로젝트 배정상태</a></th>
										</tr>
									</thead>

									<tbody>

										<c:forEach var="tlist" items="${tlist}">
											<tr
												onclick="detail(${tlist.name},'${tlist.auth}','${tlist.dname}','${tlist.email}',
												'${tlist.projectname},'${tlist.status}')"
												data-toggle="modal" data-target="#exampleModalCenter">
												<td>${tlist.name}</td>
												<td>${tlist.auth}</td>
												<td>${tlist.dname}</td>
												<td>${tlist.email}</td>
												<td>${tlist.projectname}</td>
												<td>${tlist.status}</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>

							</div>
							<!--  모달창  -->
							<div class="modal fade" id="regModal" tabindex="-1" role="dialog"
								aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
								<div class="modal-dialog modal-dialog-centered" role="document">
									<div class="modal-content">
										<div class="modal-header">
											<h5 class="modal-title" id="exampleModalLongTitle">팀원 배정</h5>
											<button type="button" class="reg" data-dismiss="modal"
												aria-label="Close">
												<i data-feather="x"></i>
											</button>
										</div>



										<div class="modal-body">
											<form id="frm02" class="form" method="get"
												action="${path}/insertTeam.do">
												<div class="row">
													<div class="projectselect">
														프로젝트명 <select class="form-select"
															style="text-align: center;" name="projectkey">
															<c:forEach var="projectlist" items="${prjList}">
																<option value="${projectlist.projectkey}">${projectlist.projectname}</option>
															</c:forEach>
														</select>
													</div>
													<div class="row">
														<div class="dnameselect">
															회원정보 <select class="form-select"
																style="text-align: center;" name="memberkey">
																<c:forEach var="m" items="${MemList}">
																	<option value="${m.memberkey}">${m.name}</option>
																</c:forEach>
															</select>
														</div>
													</div>
													<div class="auth">
														직급<select class="form-select" name="auth">
															<option value="developer">developer</option>
															<option value="pm">pm</option>
															<option value="ceo">ceo</option>
														</select>
													</div>
													<div class="row">
														<div class="dnameselect">
															부서정보 <select class="form-select"
																style="text-align: center;" name="dpt">
																<c:forEach var="dpt" items="${dptList}">
																	<option value="${dpt.deptno}">${dpt.dname}</option>
																</c:forEach>
															</select>
														</div>
													</div>
													<div class="email">
														<label>이메일</label> <input type="email"
															class="form-control" id="email" name="email"
															placeholder="이메일을 입력해주세요." />
													</div>
												</div>
											</form>
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-primary"
												data-bs-dismiss="modal" data-bs-target="#regModal"
												id="regBtn">배정</button>
											<button type="button" class="btn btn-info" id="uptBtn">수정</button>
											<button type="button" class="btn btn-danger" id="delBtn">취소</button>
										</div>
									</div>
								</div>
							</div>


						</div>
					</div>
				</div>

			</section>
		</div>

	</div>
	<!--  페이징 처리/ 프론트만 구현 -->
	<div class="dataTable-bottom">
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
		</nav>
	</div>
</body>
</html>