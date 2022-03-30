<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
	<title>권한 없음</title>
</head>
<body>





	<%@ include file="../chatBot/chatBot.jsp"%>
	<%@ include file="../common/header.jsp"%>

	<div id="main">

		<div class="page-heading">
			<div class="page-title">
				<div class="row">
					<div class="col-12 col-md-6 order-md-1 order-last">
						<h1>
						요청한 페이지에 <br>
						접근 권한이 없습니다.
						<br/><br/><br/>
						<a href="<c:url value='/index'/>">[/index로 가기]</a>




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
