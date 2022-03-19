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
<title>팀원 상세정보</title>
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

</head>

<!-- 팀관리 전체 조회  -->

<body>
	<%@ include file="../common/header.jsp"%>
	<div id="main">
		<div class="card">
			<div class="card-content">
				<div class="card-body">
					<h4 class="card-title">Feedback Form</h4>
					<p class="card-text">Gummies bonbon apple pie fruitcake icing
						biscuit apple pie jelly-o sweet roll. Toffee sugar plum sugar plum
						jelly-o jujubes bonbon dessert carrot cake.</p>
					<form class="form" method="post">
						<div class="form-body">
							<div class="form-group">
								<label for="feedback1" class="sr-only">Name</label> <input
									type="text" id="feedback1" class="form-control"
									placeholder="Name" name="name">
							</div>
							<div class="form-group">
								<label for="feedback4" class="sr-only">Last Game</label> <input
									type="text" id="feedback4" class="form-control"
									placeholder="Last Name" name="LastName">
							</div>
							<div class="form-group">
								<label for="feedback2" class="sr-only">Email</label> <input
									type="email" id="feedback2" class="form-control"
									placeholder="Email" name="email">
							</div>
							<div class="form-group">
								<select name="reason" class="form-control">
									<option value="Inquiry">Inquiry</option>
									<option value="Complain">complaints</option>
									<option value="Quotation">Quotation</option>
								</select>
							</div>
							<div class="form-group form-label-group">
								<textarea class="form-control" id="label-textarea" rows="3"
									placeholder="Suggestion"></textarea>
								<label for="label-textarea"></label>
							</div>
						</div>
						<div class="form-actions d-flex justify-content-end">
							<button type="submit" class="btn btn-primary me-1">Submit</button>
							<button type="reset" class="btn btn-light-primary">Cancel</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>