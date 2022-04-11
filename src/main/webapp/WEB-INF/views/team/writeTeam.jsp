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
<title>팀원 배정</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<style>
.dtl-button-box {
	display: flex;
	justify-content: space-between;
}

textarea {
	resize: none;
}
</style>
<script>
	$(document)
			.ready(
					function() {

						var sessid = "${member.id}";
						var id = $("[name=id]").val();

						var msg = "${msg}";
						if (msg != "") {
							if (confirm(msg + "\n팀관리 목록으로 이동할까요?")) {
								location.href = "${path}/teamlist.do?projectkey=${project.projectkey}";
							}
						}

						$("#goList")
								.click(
										function() {
											location.href = "${path}/teamlist.do?projectkey=${project.projectkey}";
										});

						$("#regBtn")
								.click(
										function() {
											if (confirm("배정하시겠습니까?")) {
												if ($("[name=name]").val() == ""
														|| $("[name=email]")
																.val() == "") {
													alert("필수항목을 입력해주세요");
													return;
												}
												$("form")
														.attr("action",
																"${path}/insertTeam.do");
												$("form").submit();
											}
										});
					});
	if (sessid != id) {
		$('#delbtn').hide();
		$('#uptbtn').hide();
	}
	$("#delbtn").click(function() {
		if (confirm("취소하시겠습니까?")) {
			location.href = "${path}/teamlist.do";
		}

	});
</script>
</head>

<body>
	<%@ include file="../common/header.jsp"%>
	<div id="main">
		<%@ include file="../projectHome/sort.jsp"%>
		<div class="page-heading">
			<div class="page-title">
				<div class="row">
					<div class="col-12 col-md-6 order-md-1 order-last">
						<h1>
							<span style="color: red">[${project.name }]</span> <br>프로젝트
							배정 인원
						</h1>
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
				<form action="${path}/insertTeam.do" method="post">
					<div>
						<div class="card" style="">
							<div class="card-header">
								<h1 class="card-title" align="center">

								</h1>
							</div>

							<div class="dataTable-container">
								<table class="table dataTable-table" id="table1" style="width: 55%; margin-left: 100px;">
									<thead>
										<tr>
											<th data-sortable="" style="width: 20%;"><a href="#"
												class="dataTable-sorter" style="text-align: center;">구분</a></th>
											<th data-sortable="" style="width: 80%;"><a href="#"
												class="dataTable-sorter" style="text-align: left; padding-left: 100px;">선택</a></th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>회원명</td>
											<td><select class="form-select" name="memberkey" style="width: 50%">
													<option>회원의 이름을 선택해주세요.</option>
													<c:forEach var="m" items="${MemList}">
														<option value="${m.memberkey}">${m.name}</option>
													</c:forEach>
											</select></td>
										</tr>

										<tr>
											<td>부서명</td>
											<td><select class="form-select" name="deptno" style="width: 50%">
													<option>부서명을 선택해주세요.</option>
													<c:forEach var="dpt" items="${dptList}">
														<option value="${dpt.deptno}">${dpt.dname}</option>
													</c:forEach>
											</select></td>
										</tr>
										<tr>
											<td>직급</td>
											<td><select class="form-select" name="auth" style="width: 50%">
													<option>직급을 선택해주세요.</option>
													<option value="admin">admin</option>
													<option value="pm">pm</option>
													<option value="developer">developer</option>
											</select></td>
										</tr>
										<tr>
											<td>프로젝트명</td>
											<td><select class="form-select" name="projectkey" style="width: 50%">
													<option>프로젝트를 선택해주세요.</option>
													<c:forEach var="prj" items="${prjList}">
														<option value="${prj.projectkey}">${prj.projectkey}
															: ${prj.projectname }</option>
													</c:forEach>
											</select></td>
										</tr>
										<tr>
											<td>배정여부 선택</td>
											<td><select class="form-select" name="status" style="width: 50%">
													<option>배정여부를 선택해주세요.</option>
													<option value="배정" selected="selected">배정</option>
													<option value="미배정">미배정</option>
											</select></td>
										</tr>
										<tr>
											<td></td>
											<td>
												<button class="btn btn-warning" id="regbtn">등록</button>
												<button class="btn btn-danger" id="delbtn">취소</button>
											</td>
										</tr>
									</tbody>
								</table>


							</div>
						</div>
					</div>
				</form>
			</section>
		</div>
	</div>
</body>
</html>