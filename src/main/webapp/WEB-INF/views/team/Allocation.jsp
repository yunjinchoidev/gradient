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
</style>
<meta charset="UTF-8">
<title>프로젝트 할당</title>
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
	
</script>
</head>

<body>

	<%@ include file="../common/header.jsp"%>
	<div id="main">

		<div class="modal fade text-left" id="inlineForm" tabindex="-1"
			role="dialog" aria-labelledby="myModalLabel33" aria-hidden="true">
			<div
				class="modal-dialog modal-dialog-centered modal-dialog-scrollable"
				role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title" id="myModalLabel33">프로젝트 할당</h4>
						<button type="button" class="close" data-bs-dismiss="modal"
							aria-label="Close">
							<i data-feather="x"></i>
						</button>
					</div>
					<form id="frm01" class="form"
						action="${path}/allocation.do" method="post">
						<div class="modal-body">
							<label for="feedback4" class="form-select">프로젝트명</label> <select
								name="prjlist" class="form-control">
								<c:forEach var="prjlist" items="${prjlist}">
									<option selected value="${idx.index+1}">${idx.index+1}:${prjlist.name}</option>
								</c:forEach>
							</select>
						</div>
						</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary ml-1"
						data-bs-dismiss="modal">
						<i class="bx bx-check d-block d-sm-none"></i> <span
							class="d-none d-sm-block">할당</span>
					</button>
					<button type="button" class="btn btn-light-secondary"
						data-bs-dismiss="modal">
						<i class="bx bx-x d-block d-sm-none"></i> <span
							class="d-none d-sm-block">취소</span>
					</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>