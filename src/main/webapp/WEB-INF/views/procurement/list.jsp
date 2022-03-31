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

<%@ include file="../chatBot/chatBot.jsp"%>
	<%@ include file="../common/header.jsp"%>
	<div id="main">

		<div class="page-heading">
			<div class="page-title">
				<div class="row">

					<%@ include file="../projectHome/sort.jsp" %>


					<div class="col-12 col-md-6 order-md-1 order-last">
						<h3>조달 리스트</h3>
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
					<a href="/project5/procurementList.do" class="btn btn-warning">조달 요구서</a>
					<a href="#" class="btn btn-primary">계약서</a>
					<a href="#" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#evalModal">조달 상황</a>
					<a href="#" class="btn btn-success">입찰</a>	
					</div>
					<div class="card-body">
						<div
							class="dataTable-wrapper dataTable-loading no-footer sortable searchable fixed-columns">
							<form id="frm01" class="form" action="/project5/procurement.do">
							<div class="dataTable-top">
								<div class="dataTable-dropdown">
									<span class="input-group-text">총 ${procurementSch.count}건</span> <span
											class="input-group-text">페이지 크기</span> <select
											class="dataTable-selector form-select" name="pageSize"><option
												value="5">5</option>
											<option value="10" selected>10</option>
											<option value="15">15</option>
											<option value="20">20</option>
											<option value="25">25</option></select><label>entries per page</label>
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
											onclick="location.href='/project5/procurementGet.do?procurementkey='+${list.procurementkey}"
												>
												<td>${list.procurementkey }</td>
												<td onclick="locaion.href='/project5/procurementGet.do?procurementkey='+${list.procurementkey}">${list.title}</td>
												<td>${list.writedate }</td>
												<td>${member.name}</td>
												<td><span class="badge bg-success">Active</span></td>
											</tr>
										</c:forEach>
								</table>
									</tbody>

										<div style=text-align:center>
										<a href="/project5/procurementInsertFrom.do" class="btn btn-primary"
											id="write" style="text-align: right">등록</a>
										</div>
									
							</div>




	<!-- class="page-item active" -->
				<ul class="pagination  justify-content-end">
					<li class="page-item"><a class="page-link"
						href="javascript:goPage(${procurementSch.startBlock!=1?procurementSch.startBlock-1:1})"">Previous</a></li>
					<c:forEach var="cnt" begin="${procurementSch.startBlock}"
						end="${procurementSch.endBlock}">
						<li class="page-item ${cnt==procurementSch.curPage?'active':''}">
							<!-- 클릭한 현재 페이지 번호 --> <a class="page-link"
							href="javascript:goPage(${cnt})">${cnt}</a>
						</li>
					</c:forEach>
					<li class="page-item"><a class="page-link"
						href="javascript:goPage(${procurementSch.endBlock!=procurementSch.pageCount?procurementSch.endBlock+1:procurementSch.endBlock})">Next</a></li>
					<!-- 다음 block의 리스트는 현재 블럭의 마지막 번호 +1 
	  	   마지막 블럭이 총페이지수일 때는 다음 블럭이 없기 때문에 그대로 두고
	  	   다음 블럭이 있을 때만 카운트 되게 
	  -->
				</ul>













					
					</div>
				</div>

			</section>


		</div>

	</div>

</script>

</html>