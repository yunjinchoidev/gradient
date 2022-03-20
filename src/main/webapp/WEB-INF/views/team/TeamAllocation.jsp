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
<body>
	<%@ include file="../common/header.jsp"%>
	<div id="main">
		<div class="card">
			<div class="card-content">
				<div class="card-body">
					<h4 class="card-title">프로젝트할당</h4>
					<p class="card-text"></p>
					<form class="form" method="post">
						<div class="form-body">
							<label for="feedback2" class="sr-only">프로젝트명</label> <select
								name="allocation" class="form-control">
								<option value="project1">프로젝트1</option>
								<option value="project2">프로젝트2</option>
								<option value="project3">프로젝트3</option>
							</select>
						</div>
					</form>
					
					<!-- 팀원추가 multiple choices with remove button 이용해서 구현
					하고 싶은데 ..적용이 안되고 있음  -->
					<div class="col-md-6 mb-4">
								<h6>팀원추가</h6>
								<div class="form-group">
									<select class="choices form-select multiple-remove"
										multiple="multiple">
										<optgroup label="Figures">
											<option value="romboid">Romboid</option>
											<option value="trapeze" selected>Trapeze</option>
											<option value="triangle">Triangle</option>
											<option value="polygon">Polygon</option>
										</optgroup>
										<optgroup label="Colors">
											<option value="red">Red</option>
											<option value="green">Green</option>
											<option value="blue" selected>Blue</option>
											<option value="purple">Purple</option>
										</optgroup>
									</select>
								</div>
							</div>
						</div>
				</div>
				<div class="form-actions d-flex justify-content-end">
					<button type="submit" class="btn btn-primary me-1">할당하기</button>
					<button type="reset" class="btn btn-light-primary">취소하기</button>
				</div>
			</div>
		</div>
</body>
</html>