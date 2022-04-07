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
	$(document).ready(
			function() {

				var msg = "${msg}";
				var memberprojectkey = "${tlist.memberprojectkey}";
				var memberprojectkey = "${memberprojectkey}";

				if (msg != "") {
					alert(msg);
					location.href = "${path}/uptTeam.do?memberprojectkey=" + memberprojectkey;
				}

				$("#uptbtn").click(function() {

					if ($('[name=email]').val() == "") {
						alert('이메일을 입력해주세요');
					} else {
						if (confirm("수정하시겠습니까?")) {
							$('form').submit();
						}
					}
				});

				$("#backbtn").click(function() {
					location.href = "${path}/teamlist.do";
				});
				$("#delbtn").click(
						function() {
							if (confirm("삭제하시겠습니까?")) {
								location.href = "${path}/delTeam.do?memberprojectkey="
										+ $("[name=memberprojectkey]").val()
										+ "&projectkey=" + prjkey;
							}

						});
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
						<h3>팀원 배정</h3>
						<p class="text-subtitle text-muted">For user to assign their
							team</p>
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
				<form action="#" method="post">
					<div>
						<div class="card" style="width: 850px;">
							<div class="card-header">
								<h4 class="card-title" align="center">팀원배정</h4>
								<input type="hidden" name="memberkey" value="${m.memberkey}">
							</div>
							<table class="table mb-0 table-lg">
								<tr>
									<th style="text-aligned: center;">회원명</th>
									<td><select class="form-select" name="memberkey">
											<option>회원의 이름을 선택해주세요.</option>
											<c:forEach var="m" items="${MemList}">
												<option value="${m.memberkey}">${m.name}</option>
											</c:forEach>
									</select></td>
								</tr>
								<th>부서명</th>
								<td><select class="form-select" name="deptKey">
										<option>부서명을 선택해주세요.</option>
										<c:forEach var="dpt" items="${dptList}">
											<option value="${dpt.deptno}">${dpt.dname}</option>
										</c:forEach>
								</select></td>
								<tr>
									<th>직급</th>
									<td><select class="form-select" name="auth">
											<option>직급을 선택해주세요.</option>
											<option value="admin">admin</option>
											<option value="pm">pm</option>
											<option value="ceo">ceo</option>
									</select></td>
								</tr>
								<tr>
									<th>프로젝트명</th>
									<td><select class="form-select" name="projectKey">
											<option>프로젝트를 선택해주세요.</option>
											<c:forEach var="prj" items="${prjList}">
												<option value="${prj.projectkey}">${prj.pname}</option>
											</c:forEach>
									</select></td>
								</tr>
								<tr>
									<th>이메일</th>
									<td colspan="3"><input type="text" class="form-control"
										id="basicInput" name="email" placeholder="이메일주소를 입력해주세요." /></td>
								</tr>
								<tr>
									<th>배정여부 선택</th>
									<td><select class="form-select" name="status">
											<option>배정여부를 선택해주세요.</option>
											<option value="assigned">배정</option>
											<option value="notassigned">미배정</option>
									</select></td>
								</tr>


							</table>
						</div>
					</div>
				</form>
			</section>
			<div style="margin-top: 30px; align-content: right; float: right;">
				<!-- 수정버튼 -->
				<button class="btn btn-warning" id="uptbtn">수정</button>
				<!-- 삭제버튼 -->
				<button class="btn btn-danger" id="delbtn">삭제</button>
				<!-- 돌아가기버튼 -->
				<button class="btn btn-primary" id="backbtn">뒤로가기</button>

			</div>



		</div>

	</div>
</body>
</html>