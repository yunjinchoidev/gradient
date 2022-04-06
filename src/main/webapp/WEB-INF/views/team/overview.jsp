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
</script>
</head>


<body>
	<%@ include file="../common/header.jsp"%>
	<div id="main">
		<%@ include file="../projectHome/sort.jsp"%>
		<section id="groups">
			<div class="row match-height">
				<div class="col-12 mt-3 mb-1">
					<h4 class="section-title text-uppercase">팀원 조회</h4>
				</div>
			</div>
			<div class="row match-height" style="text-align: center;">
				<div class="col-12">
					<div class="card-group">
						<!--  개인 프로필  나열 -->
						<div class="card">
							<div class="card-content">
								<img class="card-img-top img-fluid" src="user.png"
									style="width: 70px; height: 70px;" alt="Card image cap">
								<div class="card-body">
									<h4 class="card-title">이름 : 홍길동</h4>
									<p class="card-text">부서 : 개발</p>
									<p class="card-text">직급 : 과장</p>
									<p class="card-text">이메일 : gildong1@gmail.com</p>
									<small class="text-muted">Last updated 3 mins ago</small>
								</div>
							</div>
						</div>
						<div class="card">
							<div class="card-content">
								<img class="card-img-top img-fluid" src="user.png"
									style="width: 70px; height: 70px;" alt="Card image cap" />
								<div class="card-body">
									<h4 class="card-title">이름 : 김길동</h4>
									<p class="card-text">부서 : 기획</p>
									<p class="card-text">직급 : 대리</p>
									<p class="card-text">이메일 : kim123@gmail.com</p>
									<small class="text-muted">Last updated 3 mins ago</small>
								</div>
							</div>
						</div>
						<div class="card">
							<div class="card-content">
								<img class="card-img-top img-fluid" src="user.png"
									style="width: 70px; height: 70px;" alt="Card image cap">
								<div class="card-body">
									<h4 class="card-title">이름 : 김길동</h4>
									<p class="card-text">부서 : 기획</p>
									<p class="card-text">직급 : 대리</p>
									<p class="card-text">이메일 : kim123@gmail.com</p>
									<small class="text-muted">Last updated 3 mins ago</small>
								</div>
							</div>
						</div>
						<div class="card">
							<div class="card-content">
								<img class="card-img-top img-fluid" src="user.png"
									style="width: 70px; height: 70px;" alt="Card image cap">
								<div class="card-body">
									<h4 class="card-title">이름 : 김길동</h4>
									<p class="card-text">부서 : 기획</p>
									<p class="card-text">직급 : 대리</p>
									<p class="card-text">이메일 : kim123@gmail.com</p>
									<small class="text-muted">Last updated 3 mins ago</small>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="row match-height" style="text-align: center;">
				<div class="col-12">
					<div class="card-group">
						<div class="card">
							<div class="card-content">
								<img class="card-img-top img-fluid" src="user.png"
									style="width: 70px; height: 70px;" alt="Card image cap">
								<div class="card-body">
									<h4 class="card-title">이름 : 김길동</h4>
									<p class="card-text">부서 : 기획</p>
									<p class="card-text">직급 : 대리</p>
									<p class="card-text">이메일 : kim123@gmail.com</p>
									<small class="text-muted">Last updated 3 mins ago</small>
								</div>
							</div>
						</div>
						<div class="card">
							<div class="card-content">
								<img class="card-img-top img-fluid" src="user.png"
									style="width: 70px; height: 70px;" alt="Card image cap" />
								<div class="card-body">
									<h4 class="card-title">이름 : 김길동</h4>
									<p class="card-text">부서 : 기획</p>
									<p class="card-text">직급 : 대리</p>
									<p class="card-text">이메일 : kim123@gmail.com</p>
									<small class="text-muted">Last updated 3 mins ago</small>
								</div>
							</div>
						</div>
						<div class="card">
							<div class="card-content">
								<img class="card-img-top img-fluid" src="user.png"
									style="width: 70px; height: 70px;" alt="Card image cap">
								<div class="card-body">
									<h4 class="card-title">이름 : 김길동</h4>
									<p class="card-text">부서 : 기획</p>
									<p class="card-text">직급 : 대리</p>
									<p class="card-text">이메일 : kim123@gmail.com</p>
									<small class="text-muted">Last updated 3 mins ago</small>
								</div>
							</div>
						</div>
						<div class="card">
							<div class="card-content">
								<img class="card-img-top img-fluid" src="user.png"
									style="width: 70px; height: 70px;" alt="Card image cap">
								<div class="card-body">
									<h4 class="card-title">이름 : 김길동</h4>
									<p class="card-text">부서 : 기획</p>
									<p class="card-text">직급 : 대리</p>
									<p class="card-text">이메일 : kim123@gmail.com</p>
									<small class="text-muted">Last updated 3 mins ago</small>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!--  페이징 처리/ 프론트만 구현 -->
			<nav aria-label="Page navigation example" style="margin-top: 15px;">
				<ul class="pagination pagination-primary  justify-content-center">
					<li class="page-item disabled"><a class="page-link" href="#"
						tabindex="-1" aria-disabled="true">Previous</a></li>
					<li class="page-item active"><a class="page-link" href="#">1</a></li>
					<li class="page-item"><a class="page-link" href="#">2</a></li>
					<li class="page-item"><a class="page-link" href="#">3</a></li>
					<li class="page-item"><a class="page-link" href="#">Next</a></li>
				</ul>
			</nav>
		</section>
	</div>
	<!--  사용자 추가 모달  -->
	<div class="modal fade text-left" id="addMember" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel1" aria-hidden="true">
		<div class="modal-dialog modal-dialog-scrollable" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="myModalLabel1"
						style="margin-bottom: 10px;">사용자 추가</h5>
					<button type="button" class="close rounded-pill"
						data-bs-dismiss="modal" aria-label="Close">
						<i data-feather="x"></i>
					</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>