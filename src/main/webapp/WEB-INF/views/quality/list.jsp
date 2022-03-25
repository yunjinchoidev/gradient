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
	<%@ include file="../common/header.jsp"%>
	<div id="main">

		<div class="page-heading">
			<div class="page-title">
				<div class="row">
					<div class="col-12 col-md-6 order-md-1 order-last">
						<h3>품질 관리</h3>
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
					<div class="card-header">Simple Datatable</div>
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
											
											onclick="location.href='/project5/qualityGet.do?qualitykey='+${list.qualitykey}"
												>
												<td>${list.qualitykey }</td>
												<td onclick="locaion.href='/project5/qualityGet.do?qualitykey='+${list.qualitykey}">${list.qualityManagement }</td>
												<td>${list.writedate }</td>
												<td>${list.qualityEvaluation }</td>
												<td><span class="badge bg-success">Active</span></td>
											</tr>
										</c:forEach>
								</table>
									</tbody>

										<div style=text-align:center>
										<a href="/project5/qualityInsertFrom.do" class="btn btn-primary"
											id="write" style="text-align: right">등록</a>
										</div>
									
							</div>

















							<div class="dataTable-bottom">
								<div class="dataTable-info">전체 품질: ${qualitySch.count}</div>
								<ul
									class="pagination pagination-primary float-end dataTable-pagination">
									<li class="page-item pager"><a class="page-link"
										href="javascript:goPage(${qualitySch.startBlock!=1?qualitySch.startBlock-1:1})">‹</a></li>
									<c:forEach var="cnt" begin="${qualitySch.startBlock}"
										end="${qualitySch.endBlock}">
										<li class="page-item ${cnt==qualitySch.curPage?'active':''}">
											<!-- 클릭한 현재 페이지 번호 --> <a class="page-link"
											href="javascript:goPage(${cnt})">${cnt}</a>
										</li>
									</c:forEach>
									<li class="page-item pager"><a class="page-link"
										href="javascript:goPage(${qualitySch.endBlock!=qualitySch.pageCount?qualitySch.endBlock+1:qualitySch.endBlock})">›</a></li>
								</ul>

							</div>
						</div>
					</div>
				</div>

			</section>


		</div>

	</div>

	<!-- 등록 Modal -->
	<div class="modal fade text-left" id="regModal" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel33" aria-hidden="true">
		<div
			class="modal-dialog modal-dialog-centered modal-dialog-scrollable"
			role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="myModalLabel33">품질 등록</h4>
					<button type="button" class="close" data-bs-dismiss="modal"
						aria-label="Close">
						<i data-feather="x"></i>
					</button>
				</div>
				<form id="regForm" action="${path}/insertrisk.do" method="post">
					<!-- 모달 입력 요소 영역 -->
					<div class="modal-body" style="margin: 10px;">
						<!-- 프로젝트 select box -->
						<div id="prjselect">
							<select class="form-select" style="text-align: center;"
								name="prjkey">
								<c:forEach var="prlist" items="${prjlist}">
									<option value="${prlist.prjkey}">${prlist.prjname}</option>
								</c:forEach>
							</select>
						</div>
						<!-- 중요도, 제목 공통 영역 -->
						<div id="headerdiv" style="display: flex; margin-top: 10px;">

							<!-- 제목 -->
							<div id="title" style="flex: 4;">
								<input class="form-control" type="text" name="title"
									placeholder="제목을 입력하세요">
							</div>
						</div>

						<!-- 상세내용 -->
						<div id="regcontent" style="margin-top: 10px;">
							<textarea name="content" placeholder="상세 내용" class="form-control"
								rows="5" cols="5"></textarea>
						</div>


						<!-- 버튼 영역 -->
						<div class="modal-footer">
							<button type="button" class="btn btn-light-secondary"
								data-bs-dismiss="modal">
								<i class="bx bx-x d-block d-sm-none"></i> <span
									class="d-none d-sm-block">닫기</span>
							</button>
							<button type="button" id="regBtn" class="btn btn-primary ml-1"
								data-bs-dismiss="modal">
								<i class="bx bx-check d-block d-sm-none"></i> <span
									class="d-none d-sm-block">등록</span>
							</button>
						</div>
				</form>
			</div>
		</div>
	</div>
	
	
</body>
</html>