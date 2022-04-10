<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
	<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
	
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
					<div class="col-12 col-md-12 order-md-1 order-last">
						<h1>
										<sec:authorize access="isAuthenticated()">
												<h1>	[<sec:authentication property="name"/>]님, 안녕하세요?</h1><br><br>
												</sec:authorize>

									<sec:authorize access="hasAuthority('ROLE_ADMIN')">
											<a href="<c:url value='/admin/usermanager/main' />"> ()ADMIN) 관리자페이지 바로가기</a>
								</sec:authorize>

								<sec:authorize access="hasAuthority('ROLE_USER')">
								<h1>권한이 ROLE_User 일 경우에만 보입니다.</h1><br><br>
									<li><a href="<c:url value='/member/main' />">(USER)회원메인</a></li>
								</sec:authorize>

								<sec:authorize access="!isAuthenticated()">
										<h2> 미 인증 상태입니다.</h2>
									<a href="<c:url value='/user/loginform' />">(미인증)로그인</a>
									<a href="<c:url value='/user/join' />">(미인증)회원가입 </a>
								</sec:authorize>

								<sec:authorize access="isAuthenticated()">
									<li><a href="<c:url value='/user/logout' />">로그아웃</a></li>
								</sec:authorize>








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
