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
<style>
.bg-light-secondary {
	width: 110px;
	height: 30px;
}
</style>
<meta charset="UTF-8">
<title>Gradient - 팀 관리</title>
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


<script>
	$(document).ready(function() {
		var msg = "${msg}";
		var memberprojectkey = "${memberprojectkey}";
		var id = "${member.id}";
		var securityName = '<sec:authentication property="name"/>'
		if (securityName == "") {
			alert("접근 권한이 없습니다");
			location.href = "/project5/index";
		}

		if (msg == "delTeam") {
			alert("팀 배정 취소가 완료 되었습니다. \n  배정 인원 리스트로 이동하시겠습니까?")
			location.href = "/project5/teamlist.do?projectkey=${project.projectkey}"
		}

		$("#regBtn").click(function() {
			if (confirm("배정하러 가시겠습니까?")) {
				location.href="${path}/teamInsertForm.do?projectkey=${project.projectkey}";
			//	$("#frm02").submit();
			}
		});

	
	
		var pageSize = "${teamSch.pageSize}"
		$("[name=pageSize]").val(pageSize);
		$("[name=pageSize]").change(function() {
			$("[name=curPage]").val(1);
			$("#frm02").submit();
		});
		
		
	})
	
	
	
	
	
	function goPage(memberprojectkey) {
		$("[name=curPage]").val(memberprojectkey);
		$("#frm02").submit();
	}
</script>
</head>

<!-- 팀관리 전체 조회  -->

<body>
						<section class="section">
					<div class="card">
						<div class="card-header">
							<h1>배정 인원 리스트</h1>
						</div>
						<div class="card-body">
							<div	class="dataTable-wrapper dataTable-loading no-footer sortable searchable 
							fixed-columns">

							<!--  이곳에서 한 화면에서 몇 페이지를 볼 지 보내줍니다. -->
							<form id="frm02" class="form" action="/project5/pmPageTeamlist.do">
							<input type="hidden" name="projectkey" value="${project.projectkey }">
							<input type="hidden" name="curPage" value="1" />
								<div class="dataTable-top">
									<div class="dataTable-dropdown">
										<span class="input-group-text" style="margin-right: 10px;">총
											${teamSch.count}건</span> <span class="input-group-text">페이지
											크기</span> <select class="dataTable-selector form-select"
											name="pageSize">
											<option value="3" selected>3</option>
											<option value="5">5</option>
											<option value="10" >10</option>
											<option value="15">15</option>
											<option value="20">20</option>
											<option value="25">25</option>
										</select><label>한 화면당 페이지 수</label>
									</div>
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
												type="text" name="title" value="">
											<button class="btn btn-info" type="submit">검색</button>
											
										</div>
									</div>
								</div>
							</form>
							
							
							
							
							
							
							
							
										<div class="dataTable-container">
											<table class="table table-striped dataTable-table"
												id="table1">
												<thead>
													<tr>
														<th data-sortable="" style="width: 10%;"><a href="#"
															class="dataTable-sorter" style="text-align: center;">이름</a></th>
														<th data-sortable="" style="width: 10%;"><a href="#"
															class="dataTable-sorter" style="text-align: center;">직급</a></th>
														<th data-sortable="" style="width: 10%;"><a href="#"
															class="dataTable-sorter" style="text-align: center;">부서명</a></th>
														<th data-sortable="" style="width: 25%;"><a href="#"
															class="dataTable-sorter" style="text-align: center;">이메일</a></th>
														<th data-sortable="" style="width: 25%;"><a href="#"
															class="dataTable-sorter" style="text-align: center;">프로젝트명</a></th>
														<th data-sortable="" style="width: 25%;"><a href="#"
															class="dataTable-sorter" style="text-align: center;">프로젝트
																배정상태</a></th>
													</tr>
												</thead>
												<tbody>
													<c:forEach var="tlist" items="${tlist}">
														<tr style="cursor: pointer;">
															<td style="text-align: center;">[${tlist.member_project_key }]${tlist.name}<br>
																<span class="badge bg-danger"
																onclick="location.href='/project5/deleteTeam.do?memberprojectkey=${tlist.member_project_key }'"
																>배정 취소하기</span>
															</td>
															<td style="text-align: center;">${tlist.auth}</td>
															<td style="text-align: center;">${tlist.dname}</td>
															<td style="text-align: center;">${tlist.email}</td>
															<td style="text-align: center;">${tlist.projectname}</td>
															<td style="text-align: center;"><c:choose>
																	<c:when test="${tlist.status eq '배정'}">
																		<span class="badge bg-success"
																			style="text-align: center;">${tlist.status}</span>
																	</c:when>
																	<c:when test="${tlist.status eq '미배정'}">
																		<span class="badge bg-danger">${tlist.status}</span>
																	</c:when>
																</c:choose></td>
														</tr>
													</c:forEach>
												</tbody>
											</table>



										</div>

										<div class="dataTable-bottom">
											<ul
												class="pagination pagination-primary float-end dataTable-pagination">
												<li class="page-item pager"><a
													href="javascript:goPage(${teamSch.startBlock!=1?teamSch.startBlock-1:1})"
													class="page-link" data-page="1">‹</a></li>
												<c:forEach var="cnt" begin="${teamSch.startBlock}"
													end="${teamSch.endBlock}">
													<li class="page-item ${cnt==teamSch.curPage?'active':''}">
														<!-- 클릭한 현재 페이지 번호 --> <a class="page-link"
														href="javascript:goPage(${cnt})">${cnt}</a>
													</li>
												</c:forEach>
												<li class="page-item pager">
											<a href="javascript:goPage(${teamSch.endBlock!=teamSch.pageCount?teamSch.endBlock+1:teamSch.endBlock})" 
											class="page-link"	data-page="2">›</a>
										</li>
											</ul>
										</div>
											</form>
									</div>
								</div>
							</div>
				
				</section>



</body>
</html>