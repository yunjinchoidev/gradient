
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>

<script>
	$(document).ready(function() {

		$("#allCheck").click(function() {
			
			if ($("#allCheck").prop("checked")) {
				alert("전체 클릭합니다.")
				$("input[type=checkbox]").prop("checked", true);
			} else { //해당화면에 모든 checkbox들의 체크를해제시킨다. 
				alert("전체 클릭 해제합니다.")
				$("input[type=checkbox]").prop("checked", false);
			}
		})
		
		

		
		
	});
</script>




<body>
	<%@ include file="../chatBot/chatBot.jsp" %>
	<%@ include file="../common/header.jsp"%>
	<div id="main">
		<div class="page-heading">
			<div class="page-title">

				<%@ include file="../projectHome/sort.jsp"%>
			
				<div class="row">
					<div class="col-12 col-md-6 order-md-1 order-last">
						<h3>근태 관리</h3>

						<a href="/project5/teamlist.do" class="badge bg-secondary">팀
							할당</a> 
							<a
							href="/project5/Allocation.do"
							class="badge bg-secondary">프로젝트 할당</a> <a
							href="/project5/vacationMain.do"
							class="badge bg-secondary">휴가 관리</a> <a
							href="/project5/attendanceMain.do"
							class="badge bg-secondary">근태 관리</a>
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

			<br>




			<section class="section">
				<div class="card">
					<div class="card-header">
						여러 기능들이 있습니다.<br> <br>
						<div class="buttons" style="margin-bottom: 10px; margin-top: 5px;">
							<a href="#" class="btn btn-danger" id="mailSendBtn">경고장 발송</a> 
							<a href="#" class="btn btn-success" id="NonComplete" onclick="location.href='/project5/attendanceMain.do'">평가완료</a> 
							<a href="#" class="btn btn-warning" id="Complete" onclick="location.href='/project5/attendanceMain2.do'">미평가자</a> 
							
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
										<option value="25">25</option></select><label>페이지당 글 개수</label>
								</div>
								<div class="dataTable-search">
									<input class="dataTable-input" placeholder="Search..."
										type="text"> <a href="#" class="btn btn-danger">검색</a>
								</div>
							</div>





							<form id="form">
								<div class="dataTable-container">
									<table class="table table-striped dataTable-table" id="table1">
										<thead>
											<tr>
												<th data-sortable="" style="width: 4.8185%;"><a
													href="#" class="dataTable-sorter">번호</a></th>
												<th data-sortable="" style="width: 13.9018%;"><a
													href="#" class="dataTable-sorter">이름</a></th>

												<th data-sortable="" style="width: 25.8021%;"><a
													href="#" class="dataTable-sorter">이메일</a></th>

												<th data-sortable="" style="width: 12.423%;"><a
													href="#" class="dataTable-sorter">직급</a></th>
												<th data-sortable="" style="width: 12.423%;"><a
													href="#" class="dataTable-sorter">평가점수</a></th>

												<th data-sortable="" style="width: 15.051%;"><a
													href="#" class="dataTable-sorter">관리</a></th>
													

												<th data-sortable="" style="width: 12.051%;"><span class="dataTable-sorter">전체
														선택&nbsp;&nbsp;&nbsp; <input type="checkbox"
														class="form-check-input form-check-info chk"
														name="cbx_chkAll" style="border: 1px solid black"
														id="allCheck">
												</span></th>

											</tr>
										</thead>

										<tbody>

											<c:forEach var="list" items="${list }">
												<input type="hidden" name="memberkey" value="${list.memberkey }">
												<tr>
													<td><span class="badge bg-secondary">[${list.memberkey}]</span></td>
													<td>${list.name} </td>
													<td>${list.email }</td>
													<td>${list.auth }</td>
													<td style="cursor: pointer;" id="ManageBtn"><span
														class="badge bg-info">0</span>
													<td style="cursor: pointer;" id="ManageBtn"><span
														class="badge bg-danger">평가필요</span>
														</td>
														<td>
														 <span
															class="badge bg-success" id="assessBtn" style="cursor: pointer;"
															onclick="location.href='/project5/attendanceWriteForm.do?memberkey=${list.memberkey}'">근태 평가 하기</span>
														</td>
													<td>
														<div style="margin-left: 30px;">
															<input type="hidden" name="arrayParam" id="arrayParam">
															<input type="checkbox"
																class="form-check-input form-check-info chk"
																name="memberkey" value="${list.memberkey }"
																style="border: 1px solid black; margin: 0 auto">
														</div>
													</td>
												</tr>
											</c:forEach>
									</table>
								</div>


							</form>







							<div class="dataTable-bottom">
								<div class="dataTable-info">Showing 1 to 10 of 26 entries</div>
								<ul
									class="pagination pagination-primary float-end dataTable-pagination">
									<li class="page-item pager"><a href="#" class="page-link"
										data-page="1">‹</a></li>
									<li class="page-item active"><a href="#" class="page-link"
										data-page="1">1</a></li>
									<li class="page-item"><a href="#" class="page-link"
										data-page="2">2</a></li>
									<li class="page-item"><a href="#" class="page-link"
										data-page="3">3</a></li>
									<li class="page-item pager"><a href="#" class="page-link"
										data-page="2">›</a></li>
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