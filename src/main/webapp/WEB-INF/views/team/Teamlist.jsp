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
		location.href="${path}/teamlist.do";
	}
	$("#regBtn").click(function(){
		if(confirm("배정하시겠습니까")){
			$("#frm02").submit();
		}
	});
		
});
function regFun(){
	$("#exampleModalLongTitle").text("팀원 배정");
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
	// 타이틀 변경
	$("#exampleModalLongTitle").text("배정목록(수정/삭제)");
	// 버튼 활성화 비활성화 처리
	$("#regBtn").hide();$("#uptBtn").show();$("#delBtn").show();		
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

			<br>
			<section class="section">
				<form id="schform" action="${path}/teamlist.do" method="post">
					<div class="card">
						<div class="card-header">Simple Datatable</div>
						<div class="card-body">
							<div
								class="dataTable-wrapper dataTable-loading no-footer sortable searchable fixed-columns">
								<div class="dataTable-top">
									<input type="hidden" name="curPage" value="1" />
									<div class="dataTable-dropdown">
										<select class="dataTable-selector form-select" name="pageSize">
											<option>5</option>
											<option>10</option>
											<option>15</option>
											<option>20</option>
											<option>25</option>
										</select>
									</div>
									<div class="dataTable-search">
										<input type="text" class="dataTable-input"
											placeholder="Search..." name="topic">
										<button class="btn btn-primary" type="submit">Search</button>
									</div>
								</div>


								<div class="dataTable-container">
									<table class="table table-striped dataTable-table" id="table1">
										<thead>
											<tr>
												<th data-sortable="" style="width: 10%;"><a href="#"
													class="dataTable-sorter" style="text-align: center;">이름</a></th>
												<th data-sortable="" style="width: 10%;"><a href="#"
													class="dataTable-sorter" style="text-align: center;">직급</a></th>
												<th data-sortable="" style="width: 10%;"><a href="#"
													class="dataTable-sorter" style="text-align: center;">부서명</a></th>
												<th data-sortable="" style="width: 25%;"><a href="#"
													class="dataTable-sorter" style="text-align: center;">이메일</a></th>
												<th data-sortable="" style="width: 25%;"><a href="#"
													class="dataTable-sorter" style="text-align: center;">프로젝트명</a></th>
												<th data-sortable="" style="width: 25%;"><a href="#"
													class="dataTable-sorter" style="text-align: center;">프로젝트
														배정상태</a></th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="mp" items="${tlist}">
												<tr
													onclick="detail(${mp.name},'${mp.auth}','${mp.dname}','${mp.email}','${mp.projectname}','${mp.status}')"
													data-toggle="modal" data-target="#exampleModalCenter">
													<td style="text-align: center;">${mp.name}</td>
													<td style="text-align: center;">${mp.auth}</td>
													<td style="text-align: center;">${mp.dname}</td>
													<td style="text-align: center;">${mp.email}</td>
													<td style="text-align: center;">${mp.projectname}</td>
													<td style="text-align: center;"><c:choose>
															<c:when test="${mp.status eq '배정'}">
																<span class="badge bg-success"
																	style="text-align: center;">${mp.status}</span>
															</c:when>
															<c:when test="${mp.status eq '미배정'}">
																<span class="badge bg-danger">${mp.status}</span>
															</c:when>
														</c:choose></td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
									<button data-toggle="modal" onclick="regFun()"
										data-target="#exampleModalCenter" class="btn btn-primary"
										type="button">배정</button>
								</div>
								<div class="dataTable-bottom">
									<ul
										class="pagination pagination-primary float-end dataTable-pagination">
										<li class="page-item pager"><a
											href="javascript:goPage(${TeamSch.startBlock!=1?TeamSch.startBlock-1:1})"
											class="page-link" data-page="1">‹</a></li>
										<c:forEach var="cnt" begin="${TeamSch.startBlock}"
											end="${TeamSch.endBlock}">
											<li class="page-item ${cnt==TeamSch.curPage?'active':''}"><a
												href="javascript:goPage(${cnt})" class="page-link">${cnt}</a></li>
										</c:forEach>
										<li class="page-item pager"><a
											href="javascript:goPage(${TeamSch.endBlock!=TeamSch.pageCount?TeamSch.endBlock+1:TeamSch.endBlock})"
											class="page-link" data-page="2">›</a></li>
									</ul>
								</div>

							</div>
						</div>
					</div>
				</form>
			</section>
		</div>

		<div class="modal fade" id="exampleModalCenter" tabindex="-1"
			role="dialog" aria-labelledby="exampleModalCenterTitle"
			aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLongTitle">팀원배정</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<form id="frm02" class="form" method="post"
							action="${path}/insertTeam.do">

							<div class="row">
								<div id="prjselect">
									프로젝트명 <select class="form-select" name="projectkey">
										<option>프로젝트를 선택해주세요.</option>
										<c:forEach var="prj" items="${prjList}">
											<option value="${prj.projectKey}">${prj.pname}</option>
										</c:forEach>
									</select>
								</div>
							</div>

							<div class="row">
								<div id="memselect">
									<select class="form-select" name="memberkey">
										<option>회원을 선택해주세요.</option>
										<c:forEach var="m" items="${MemList}">
											<option value="${m.memberkey}">${m.name}</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="row">
								<div id="dptselect">
									<select class="form-select" name="deptno">
										<option>부서를 선택해주세요.</option>
										<c:forEach var="dpt" items="${dptList}">
											<option value="${dpt.deptno}">${dpt.dname}</option>
										</c:forEach>
									</select>
								</div>
								<div class="row">
									<div id="authselect">
										<select class="form-select" name="auth">
											<option>직급을 선택해주세요.</option>
											<option value="admin">admin</option>
											<option value="pm">pm</option>
											<option value="ceo">ceo</option>
										</select>
									</div>
								</div>
								<div class="row">
									<div id="statusselect">
										<select class="form-select" name="status">
											<option>배정여부를 선택해주세요.</option>
											<option value="assigned">배정</option>
											<option value="notassigned">미배정</option>
										</select>
									</div>
								</div>
								<div class="row">
									<div id="email">
										<input class="form-control" type="text" name="email"
											placeholder="이메일을 입력하세요.">
									</div>
								</div>
							</div>
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">Close</button>
						<button type="button" class="btn btn-primary" id="regBtn">배정</button>
						<button type="button" class="btn btn-danger" id="delBtn">취소</button>
					</div>
				</div>
			</div>
		</div>
</body>
</html>
