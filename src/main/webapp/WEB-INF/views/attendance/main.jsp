
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

		
		
		$("#ManageBtn").click(function() {
			confirm("이 회원을 관리하시겠습니까?")
		})

		
		
		$("#exileBtn").click(function() {
			confirm("회원을 추방 하시겠습니까?")
		})

		
		
		$("#assessBtn").click(function() {
			confirm("회원을 평가 하시겠습니까?")
		})
		
		
		
	
		$("#mailSendBtn").click(function(e) {
			confirm("경고장을 발송하시겠습니까?")
			var array = new Array();
			var theMember=$('input:checkbox[name=memberkey]:checked').val()
			alert(theMember)
			location.href="/project5/warningLetter.do?memberkey="+theMember
			
		})
		
		
	});
</script>




<body>
	<%@ include file="../chatBot/chatBot.jsp" %>
	<%@ include file="../common/header.jsp"%>
	<div id="main">
		<div class="page-heading">
			<div class="page-title">

									<div class="buttons" id="moveBtn" style="padding: 20px;">
		<a href="/project5/dashBoard.do?projectkey=${project.projectkey }"
			class="btn btn-secondary">대시보드</a> 
			<a
			href="/project5/projectHome.do?projectkey=${project.projectkey }" class="btn btn-dark"
			 >프로젝트
			홈</a> 
			<a href="/project5/kanbanMain.do?projectkey=${project.projectkey }"
			class="btn btn-danger" >칸반보드</a> <a
			href="/project5/ganttMain.do?projectkey=${project.projectkey }"
			class="btn btn-warning" >간트차트</a> <a
			href="/project5/calendar.do?projectkey=${project.projectkey }"
			class="btn btn-success" >캘린더</a> <a
			href="/project5/cost.do?projectkey=${project.projectkey }"
			class="btn btn-primary">예산 관리</a> <a
			href="/project5/qualityList.do?projectkey=${project.projectkey }"
			class="btn btn-dark">품질 관리</a> <a
			href="/project5/attendanceMain.do?projectkey=${project.projectkey }"
			class="btn btn-secondary">팀 관리</a> <a
			href="/project5/minutes.do?method=list&projectkey=${project.projectkey }"
			class="btn btn-danger">회의록</a> <a
			href="/project5/chatting.do?projectkey=${project.projectkey }"
			class="btn btn-warning">채팅</a> <a
			href="/project5/output.do?projectkey=${project.projectkey }"
			class="btn btn-success">산출물 관리</a> <a
			href="/project5/risk.do?projectkey=${project.projectkey }"
			class="btn btn-primary">리스크 관리</a> <a
			href="/project5/procuSituationMain.do?projectkey=${project.projectkey }"
			class="btn btn-secondary">조달 관리</a>
			
			<hr>
			
				<div class="row">
					<div class="col-12 col-md-6 order-md-1 order-last">
						<h3>근태 관리</h3>

						<a href="/project5/addmem.do" class="badge bg-secondary">팀
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
				<



			<section class="section">
				<div class="card">
					<div class="card-header">
						여러 기능들이 있습니다.<br> <br>
						<div class="buttons" style="margin-bottom: 10px; margin-top: 5px;">
							<a href="#" class="btn btn-danger" id="mailSendBtn">경고장 발송</a> 
							<a href="#" class="btn btn-success" id="NonComplete" onclick="location.href='/project5/attendanceMain.do'">평가완료</a> 
							<a href="#" class="btn btn-warning" id="Complete" onclick="location.href='/project5/attendanceMain2.do'">미평가자</a> 
							
						</div>
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
														class="badge bg-info">${list.score }</span>
														</td>
														<td><span class="badge bg-dark" id="assessBtn"
														style="cursor: pointer;">평가 완료</span></td>
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

		<footer>
			<div class="footer clearfix mb-0 text-muted">
				<div class="float-start">
					<p>2021 © Mazer</p>
				</div>
				<div class="float-end">
					<p>
						Crafted with <span class="text-danger"><i
							class="bi bi-heart"></i></span> by <a href="http://ahmadsaugi.com">A.
							Saugi</a>
					</p>
				</div>
			</div>
		</footer>
	</div>
</body>
</html>