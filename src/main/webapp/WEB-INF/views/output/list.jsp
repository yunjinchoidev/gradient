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
<style>
#moveBtn a {
	width: 135px;
	margin-right: 10px;
	font-size: 20px;
	font-weight: bold;
}
</style>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	$(document).ready(function() {
		
		var projectkey = "${project.projectkey}"
		var psc = "${psc}";
		alert(psc)
		
		if(psc == "outputDelete"){
			location.href= "/project5/output.do?projectkey="+projectkey
		}
		
		
		
		var mname = "${output.name}";
		$("#WriteFormBtn").click(function() {
			if (mname == "") {
				alert("권한이 없습니다.")
			}
		})

		var pageSize = "${outputSch.pageSize}"
		$("[name=pageSize]").val(pageSize);
		$("[name=pageSize]").change(function() {
			$("[name=curPage]").val(1);
			$("#frm01").submit();
		});

	})

	function goPage(no) {
		$("[name=curPage]").val(no);
		$("#frm01").submit();
	}
</script>

<body>
	<%@ include file="../chatBot/chatBot.jsp"%>
	<%@ include file="../common/header.jsp"%>
	<div id="main">

		<div class="page-heading">
			<div class="page-title">
				<div class="row">


			<%@ include file="../projectHome/sort.jsp"%>




					<div class="col-12 col-md-6 order-md-1 order-last">
						<h3>
							<span style="color: red">[${project.name }]</span> 산출물 관리
						</h3>
						<p class="text-subtitle text-muted">이곳에서 산출물을 관리하세요</p>
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

						<form id="frm01" class="form" action="${path}/output.do"
							method="post">
							<div
								class="dataTable-wrapper dataTable-loading no-footer sortable searchable fixed-columns">
								<div class="dataTable-top">
									<div class="input-group-prepend">
										<input type="hidden" name="curPage" value="1" /> <span
											class="input-group-text">총 ${outputSch.count}건</span>
									</div>

									<div class="dataTable-dropdown">
										<select class="dataTable-selector form-select" name="pageSize">
											<option value="3">3</option>
											<option value="5">5</option>
											<option value="10" selected="selected">10</option>
											<option value="15">15</option>
											<option value="20">20</option>
											<option value="25">25</option>
										</select><label>entries per page</label>
									</div>

									<script>
										$(document)
												.ready(
														function() {
															$(".searchbar")
																	.change(
																			function() {
																				alert("검색 종류를 변경합니다.");
																				$(
																						".searchWhat")
																						.attr(
																								"name",
																								this.value)
																				alert($(".searchWhat").value)
																			});

														});
									</script>


									<div class="dataTable-search" style="display: inline-block;">

										<div style="display: inline-block;">
											<select class="dataTable-selector form-select searchbar"
												name="searchbar" style="display: inline-block;">
												<option selected="selected">검색</option>
												<option value="title" selected="selected">title</option>
												<option value="contents">contents</option>
											</select>
										</div>

										<div style="display: inline-block;">
											<input style="display: inline-block;"
												class="dataTable-input searchWhat" placeholder="검색어를 입력"
												type="text" name="title" value="${outputSch.title}">
											<button class="btn btn-info" type="submit">검색</button>
											<a class="btn btn-danger" style="text-align: right"
												href="/project5/outputWriteForm.do?projectkey=${project.projectkey }">글
												쓰기</a>
										</div>
									</div>

								</div>
							</div>
						</form>







						<div class="dataTable-container">
							<table class="table table-striped dataTable-table" id="table1">
								<thead>
									<tr>
										<th data-sortable="" style="width: 12.0176%;"><a href="#"
											class="dataTable-sorter">번호</a></th>
										<th data-sortable="" style="width: 42.9989%;"><a href="#"
											class="dataTable-sorter">작업구분/제목/버전</a></th>
										<th data-sortable="" style="width: 18.0816%;"><a href="#"
											class="dataTable-sorter">부서</a></th>
										<th data-sortable="" style="width: 16.3175%;"><a href="#"
											class="dataTable-sorter">작성자</a></th>
										<th data-sortable="" style="width: 10.8049%;"><a href="#"
											class="dataTable-sorter">상태</a></th>
									</tr>
								</thead>




								<tbody>
									<c:forEach var="list" items="${list}">
										<tr>
											<td style="cursor: pointer;">${list.outputkey }<span
												class="badge bg-warning">진행중</span>
											</td>
											<td><span
												onclick="location.href='${path}/outputGet.do?outputkey=${list.outputkey}'"
												style="cursor: pointer;">[ ${list.worksortTitle}
													]${list.title } < 버전 ${list.version }> [${list.pname}]
													&nbsp </span><span class="badge bg-danger"
												onclick="location.href='/project5/outputDelete.do?outputkey=${list.outputkey}&projectkey=${project.projectkey }'"
												style="cursor: pointer;">삭제</span></td>
											<td>${list.dname }<fmt:formatDate
													value="${list.writedate }" />
											</td>
											<td>${list.mname }</td>
											<td><c:if test="${list.status eq '2'}">
													<span class="badge bg-primary">완료</span>
												</c:if> <c:if test="${list.status eq '1'}">
													<span class="badge bg-primary">진행중</span>
												</c:if></td>
										</tr>
									</c:forEach>
								</tbody>




							</table>

						</div>




						<div class="dataTable-bottom">
							<div class="dataTable-info">Showing 1 to 10 of 26 entries</div>
							<ul class="pagination  justify-content-end">
								<li class="page-item"><a class="page-link"
									href="javascript:goPage(${outputSch.startBlock!=1?outputSch.startBlock-1:1})">Previous</a></li>
								<c:forEach var="cnt" begin="${outputSch.startBlock}"
									end="${outputSch.endBlock}">
									<li class="page-item ${cnt==outputSch.curPage?'active':''}">
										<!-- 클릭한 현재 페이지 번호 --> <a class="page-link"
										href="javascript:goPage(${cnt})">${cnt}</a>
									</li>
								</c:forEach>
								<li class="page-item"><a class="page-link"
									href="javascript:goPage(${outputSch.endBlock!=outputSch.pageCount?outputSch.endBlock+1:outputSch.endBlock})">Next</a></li>
							</ul>
						</div>
					</div>
				</div>
		</div>

		</section>
	</div>
	</div>







</body>
</html>