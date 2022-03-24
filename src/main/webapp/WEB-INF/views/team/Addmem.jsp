<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />
<!DOCTYPE html>
<%--

  팀원 추가 프론트 화면
 --%>
<html>
<head>
<meta charset="UTF-8">
<title>팀원 배치</title>
</head>
<script>
	var selectedval = 4;
	$(document)
			.ready(
					function() {

						$("#pjList")
								.change(
										function() {
											selectedval = $(this).val();
											console.log(selectedval);
											location.href = "/project5/projectHome.do?projectkey="
													+ selectedval;

											console.log(selectedval)

											$(
													"#pjList option:eq(selectedval-1)")
													.prop('selected', true)
										})

					})
</script>
<body>
	<%@ include file="../common/header.jsp"%>
	<div id="main">
		<div class="card">
			<div class="card-content">
				<div class="card-body">
					<h4 class="card-title">팀원추가</h4>
					<p class="card-text">프로젝트를 함께 진행할 팀원을 등록하세요.</p>
					<form class="form" method="post">
						<div class="form-body">
							<div class="form-group">
								<label for="feedback1" class="sr-only">이름</label> <input
									type="text" id="feedback1" class="form-control"
									placeholder="Name" name="name" value="${member.name}">
							</div>
							<div class="form-group">
								<label for="feedback2" class="sr-only">이메일</label> <input
									type="email" id="feedback2" class="form-control"
									placeholder="Email" name="email" value="${member.email}">
							</div>
							<div class="form-group">
								<label for="feedback4" class="form-select">프로젝트명</label> <select
									name="prjlist" class="form-control">
									<c:forEach var="prjlist" items="${prjlist}">
										<option selected value="${idx.index+1}">${idx.index+1}:${prjlist.name}</option>
									</c:forEach>
								</select>
							</div>
							<div class="form-group">
								<label for="feedback4" class="sr-only">직급</label> <select
									name="auth" class="form-control">
									<c:forEach var="auth" items="${auth}">
										<option selected value="${idx.index+1}">${idx.index+1}:${auth.auth}</option>
									</c:forEach>
								</select>
							</div>
							<div class="form-group">
								<label for="feedback4" class="sr-only">부서</label> <select
									name="dname" class="form-control">
									<c:forEach var="dname" items="${dname}">
										<option selected value="${idx.index+1}">${idx.index+1}:{$dname.dname}</option>
									</c:forEach>
								</select>
							</div>
							<div class="form-group form-label-group">
								<textarea class="form-control" id="label-textarea" rows="3"
									placeholder="기타사항"></textarea>
								<label for="label-textarea"></label>
							</div>
						</div>
						<div class="form-actions d-flex justify-content-end">
							<button type="submit" class="btn btn-primary me-1">추가</button>
							<button type="reset" class="btn btn-light-primary" >취소</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>