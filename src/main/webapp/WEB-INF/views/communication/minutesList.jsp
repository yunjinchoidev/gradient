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
	<title>회의 | 리스트</title>
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script>
	$(document).ready(function() {
		$("#writeBtn").click(function() {
			location.href = "${path}/minutes.do?method=insertFrm";
		});
		var pageSize="${minutesSch.pageSize}"
			$("[name=pageSize]").val(pageSize);
			$("[name=pageSize]").change(function(){
				$("[name=curPage]").val(1);
				$("#frm01").submit();
			});
	});
	function detail(minuteskey) {
		location.href = "${path}/minutes.do?method=detail&minutesKey="+minuteskey;
	}
	function goPage(no){
		$("[name=curPage]").val(no);
		$("#frm01").submit();
	}	
	</script>
</head>

<body>
	<%@ include file="../common/header.jsp"%>
	<div id="main">

		<div class="page-heading">
			<div class="page-title">
				<div class="row">
					<div class="col-12 col-md-6 order-md-1 order-last">
						<h3>팀별 회의 공간</h3>
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
				<form id="frm01" action="${path}/minutes.do?method=list"  method="post">
					<div class="card">
						<div class="card-header">Simple Datatable</div>
						<div class="card-body">
							<div class="dataTable-wrapper dataTable-loading no-footer sortable searchable fixed-columns">
								<div class="dataTable-top">
									
									<input type="hidden" name="curPage" value="1"/>
									<div class="dataTable-dropdown">
										<select class="dataTable-selector form-select" name="pageSize">
											<option>5</option>
											<option>10</option>
											<option>15</option>
											<option>20</option>
											<option>25</option>
										</select>
									</div>
									<div class="dataTable-search">
										총 ${minutesSch.count}건
										<input type="text" class="dataTable-input" placeholder="Search..."
											name="topic" value="${minutesSch.topic}">
										<button class="btn btn-primary" type="submit">검색</button>
									</div>
								</div>
								<div class="dataTable-container">
									<table class="table table-striped dataTable-table" id="table1">
										<col width="5%">
									   	<col width="20%">
									   	<col width="10%">
									   	<col width="10%">
									   	<col width="10%">
									   	<col width="20%">
									   	<col width="10%">
										<thead>
											<tr>
												<th data-sortable="">No</th>
												<th data-sortable="">회의안건</th>
												<th data-sortable="">회의일시</th>
												<th data-sortable="">작성일자</th>
												<th data-sortable="">수정일자</th>
												<th data-sortable="">부서</th>
												<th data-sortable="">작성자</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="m" items="${mList}">
												<tr ondblclick="detail(${m.minutesKey})">
													<td>${m.minutesKey}</td>
													<td>${m.topic}</td>
													<td><fmt:formatDate value="${m.conferenceDate}" /></td>
													<td><fmt:formatDate value="${m.writeDate}" /></td>
													<td><fmt:formatDate value="${m.updateDate}" /></td>
													<td>${m.partname}</td>
													<td>${m.name}</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
								<input type="button" id="writeBtn" class="btn btn-primary" value="새 회의록"/>
	
								<div class="dataTable-bottom">
									<ul
										class="pagination pagination-primary float-end dataTable-pagination">
										<li class="page-item pager">
											<a href="javascript:goPage(${minutesSch.startBlock!=1?minutesSch.startBlock-1:1})" 
											class="page-link" data-page="1">‹</a>
										</li>
										<c:forEach var="cnt" begin="${minutesSch.startBlock}" end="${minutesSch.endBlock}">
											<li class="page-item active" ${cnt==minutesSch.curPage?'active':''}>
												<a href="javascript:goPage(${cnt})" class="page-link" data-page="1">${cnt}</a>
											</li>
										</c:forEach>
										<li class="page-item pager">
											<a href="javascript:goPage(${minutesSch.endBlock!=minutesSch.pageCount?minutesSch.endBlock+1:minutesSch.endBlock})" 
											class="page-link"	data-page="2">›</a>
										</li>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</form>
			</section>
		</div>

	</div>
</body>
</html>