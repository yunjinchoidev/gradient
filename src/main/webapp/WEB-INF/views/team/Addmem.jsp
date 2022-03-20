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
									placeholder="Name" name="name">
							</div>
							<div class="form-group">
								<label for="feedback2" class="sr-only">이메일</label> <input
									type="email" id="feedback2" class="form-control"
									placeholder="Email" name="email">
							</div>
							<div class="form-group">
								<label for="feedback4" class="sr-only">프로젝트명</label> <select
									name="projectname" class="form-control">
									<option value="project1">프로젝트명1</option>
									<option value="project2">프로젝트명2</option>
									<option value="project3">프로젝트명3</option>
								</select>
							</div>
							<div class="form-group">
								<label for="feedback4" class="sr-only">권한</label> <select
									name="reason" class="form-control">
									<option value="staff">실무진</option>
									<option value="project2">PM</option>
									<option value="project3">CEO</option>
								</select>
							</div>
							<div class="form-group">
								<label for="feedback4" class="sr-only">부서</label> <select
									name="projectname" class="form-control">
									<option value="develop">개발부</option>
									<option value="planning">기획부</option>
									<option value="sales">영업부</option>
									<option value="pr">인사부</option>
									<option value="marketing">마케팅부</option>
									<option value="accounting">회계부</option>
								</select>
							</div>
							<div class="form-group form-label-group">
								<textarea class="form-control" id="label-textarea" rows="3"
									placeholder="기타사항"></textarea>
								<label for="label-textarea"></label>
							</div>
						</div>
						<div class="form-actions d-flex justify-content-end">
							<button type="submit" class="btn btn-primary me-1">등록</button>
							<button type="reset" class="btn btn-light-primary">취소</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>