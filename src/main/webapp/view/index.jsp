<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<html>
<head>
<title>홈 페이지</title>
</head>
<body>


	<%@ include file="chatBot/chatBot.jsp"%>
	<%@ include file="common/header.jsp"%>

	<div id="main">

		<div class="page-heading">
			<div class="page-title">
				<div class="row">
					<div class="col-12 col-md-6 order-md-1 order-last">
						<h1>
							<ul>
								<sec:authorize access="hasAuthority('USER_MANAGER')">
									<li><a href="<c:url value='/admin/usermanager/main' />">
											사용자 관리자</a></li>
								</sec:authorize>





								<sec:authorize access="hasAuthority('USER')">
									<li><a href="<c:url value='/member/main' />">회원메인</a></li>
								</sec:authorize>




								<sec:authorize access="!isAuthenticated()">
											<%--
											<li><a href="<c:url value='/spring_security_login' />">로그인</a></li>
											--%>
									<li><a href="<c:url value='/user/loginform' />">로그인</a></li>
									<li><a href="<c:url value='/user/join' />">회원가입</a></li>
								</sec:authorize>








								<sec:authorize access="isAuthenticated()">
									<li><a href="<c:url value='/user/logout' />">로그아웃</a></li>
								</sec:authorize>
							</ul>












						</h1>




					</div>
					<div class="col-12 col-md-6 order-md-2 order-first">
						<nav aria-label="breadcrumb"
							class="breadcrumb-header float-start float-lg-end"></nav>
					</div>
				</div>
			</div>



			<section class="section">
				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-header">
								<h1 class="card-title"></h1>
							</div>
							<div class="card-body"></div>
						</div>
					</div>
				</div>
			</section>
		</div>
	</div>












</body>
</html>
