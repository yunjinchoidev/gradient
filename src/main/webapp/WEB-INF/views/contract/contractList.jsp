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
	<title>Insert title here</title>
</head>

<body>
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script>
	$(document).ready(function() {
		$("#writeBtn").click(function() {
			var hasSession="${member.id}";
			if(hasSession!=""){
				location.href = "${path}/contract.do?method=insertFrm";
			}else{
				alert("로그인 후 이용가능합니다.");
			}
		});
	});
	</script>
	<%@ include file="../chatBot/chatBot.jsp"%>
	<%@ include file="../common/header.jsp"%>

	<div id="main">
		<div class="page-heading">
			<div class="page-title">
				<div class="row">
					<%@ include file="../projectHome/sort.jsp"%>
					<div class="col-12 col-md-6 order-md-1 order-last">
						<h3>계약서 관리</h3>
						<p class="text-subtitle text-muted">For user to check they
							list</p>
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
			<section class="section">
				<div class="card">


					<div class="card-header">
						<a href="#" class="btn btn-dark">조달 요구서</a> 
						<a href="/project5/contractMain.do" class="btn btn-info">계약서</a>
					 	<a href="/project5/procuSituationMain.do" class="btn btn-danger">조달상황</a> 
						<a href="/project5/bidMain.do" class="btn btn-success">입찰</a>
					</div>
					
					
					
					<div class="card-body">
						<div
							class="dataTable-wrapper dataTable-loading no-footer sortable searchable fixed-columns">
							<div class="dataTable-top">
								<div class="dataTable-dropdown">
									<select class="dataTable-selector form-select"><option
											value="5">5</option>
										<option value="10" selected="">10</option>
										<option value="15">15</option>
										<option value="20">20</option>
										<option value="25">25</option></select><label>게시글 수</label>
								</div>
								<div class="dataTable-search">
									<input class="dataTable-input" placeholder="Search..."
										type="text"> <a href="/project5/scheduleInsertForm.do"
										class="btn btn-danger" style="text-align: right">글쓰기</a>
								</div>

							</div>
							<div class="dataTable-container">
								<table class="table table-striped dataTable-table" id="table1">
									<thead>
										<tr>
											<th data-sortable="" style="width: 20%;"><a href="#"
												class="dataTable-sorter">품질평가</a></th>
											<th data-sortable="" style="width: 40%;"><a href="#"
												class="dataTable-sorter">프로젝트명</a></th>
											<th data-sortable="" style="width: 20%;"><a href="#"
												class="dataTable-sorter">작성일</a></th>
											<th data-sortable="" style="width: 20%;"><a href="#"
												class="dataTable-sorter">담당자</a></th>

										</tr>
									</thead>




									<tbody>
										<c:forEach var="list" items="${list}">
											<tr
												onclick="location.href='/project5/procurementGet.do?procurementkey='+${list.procurementkey}">
												<td>${list.procurementkey }</td>
												<td
													onclick="locaion.href='/project5/procurementGet.do?procurementkey='+${list.procurementkey}">${list.procurementManagement }</td>
												<td>${list.writedate }</td>
												<td>${list.procurementEvaluation }</td>
												<td><span class="badge bg-success">Active</span></td>
											</tr>
										</c:forEach>
								</table>
								</tbody>

								<input type="button" id="writeBtn" class="btn btn-primary" value="계약서 작성"/>

							</div>
						</div>
					</div>
				</div>

			</section>

		</div>
	</div>
</body>
</html>