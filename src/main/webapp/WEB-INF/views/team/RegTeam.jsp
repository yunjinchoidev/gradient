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
		<div class="page-heading">
			<div class="page-title">
				<div class="row">
					<div class="col-12 col-md-6 order-md-1 order-last">
						<h3>팀원 추가</h3>
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
			<section class="sectionMain">
				<!-- 메인영역 -->

	<form action="/project5/teamInsert"> 
				<div class="card" id="maincard">
					<div class="card-body">
						<div
							class="dataTable-wrapper dataTable-loading no-footer sortable searchable fixed-columns">

							<div class="dataTable-top"></div>

							<div class="dataTable-container">
								<form id="inscostform" action="${path}/insertteam.do"
									method="post">
									<input type="hidden" name=prjkey value="${prjkey}">
									<table class="table table-striped dataTable-table"
										id="maintable">
										<thead>
											<tr>
												<th style="width: 10%; text-align: center;"><a href="#"
													class="dataTable-sorter">No.</a></th>
												<th style="width: 25%; text-align: center;"><a href="#"
													class="dataTable-sorter">이름</a></th>
												<th style="width: 25%; text-align: center;"><a href="#"
													class="dataTable-sorter">부서</a></th>
												<th style="width: 40%; text-align: center;"><a href="#"
													class="dataTable-sorter">이메일</a></th>
											</tr>
										</thead>

										<tbody>
											<tr>
												<td>1</td>
												<td><input class="form-control" type="text"
													name="list[0].name" value="memberkey">
													
													</td>
													<td>
														<input class="form-control" type="text"
														name="list[0].dname">
													</td>
													
													
													
													<td><select class="form-select" name="list[0].teamkey">
														<c:forEach var="telist" items="${telist}">
															<option value="${telist.teamkey}">${telist.dname}</option>
														</c:forEach>
												</select></td>
												
												
												
												<td><input class="form-control" type="text"
													name="list[0].email"></td>
											</tr>
										</tbody>
									</table>
								</form>
								
									<div style="margin-top: 150px;">
									<button type="submit" id="addbtn" class="btn btn-primary rounded-pill"
										style="margin-left:50px;">팀원추가</button>
									<button type="button" id="delbtn" class="btn btn-primary rounded-pill"
										style="margin-left:400px;">팀원삭제</button>
									<button type="button"  class="btn btn-success rounded-pill"
										style="margin-left:400px;"onclick="location.href='/project5/teamlist.do'">뒤로가기</button>
				</form>
								</div>

							</div>
						</div>
</body>
</html>