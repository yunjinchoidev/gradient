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
						<h3>팀원 관리</h3>
					</div>
				</div>
			</div>
			</div>
			<section class="sectionMain">
				<!-- 프로젝트 정보 -->
				<div id="prjInfo">
					<!-- 프로젝트명, PM -->
					<div style="display: flex;">
						<input type="hidden" name="prjkey" value="${prjInfo.prjkey}">
						<input class="form-control" type="text" value="${prjInfo.name}"
							readonly="readonly"
							style="flex: 3; background-color: white; margin-right: 100px; text-align: center;">
						<input class="form-control" type="text" value="${prjInfo.manager}"
							readonly="readonly"
							style="flex: 1; background-color: white; text-align: center;">
					</div>
					</div>

					<div class="card" id="maincard">
						<div class="card-body">
							<div
								class="dataTable-wrapper dataTable-loading no-footer sortable searchable fixed-columns">

								<div class="dataTable-top"></div>

								<div class="dataTable-container">
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
											<c:forEach var="tdlist" items="${tdlist}">
												<c:set var="i" value="${i+1}" />
												<tr>
													<td>${i}</td>
													<td>${tdlist.name}</td>
													<td>${tdlist.dname}</td>
													<td>${tdlist.email}</td>
												</tr>
											</c:forEach>
										</tbody>
										</table>
								</div>
								</div>
								</div>
								
								<!-- 인적관리 리스트 화면으로 돌아가는 버튼 -->
								<button id="backbtn" class="btn btn-primary rounded-pill"
									style="margin-right: 10px; margin-left: 0px;" onclick="location.href='/project5/teamlist.do'">목록</button>
						</div>
						</section>	
						</div>		
</body>
</html>