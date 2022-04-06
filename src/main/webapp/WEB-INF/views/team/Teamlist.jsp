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
<title>팀 관리</title>
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
		
		if(id == ""){
			alert("접근 권한이 없습니다");
			location.href = "${path}/main.do";
		}
		
		if("msg" != "") {
			alert(msg);
			if(msg="배정되었습니다.")
			location.href = "${path}/teamlist.do";
		}
		$("#regBtn").click(function() {
			if (confirm("배정하시겠습니까?")) {
				$("#frm02").submit();
			}
		});

	});
	$(document).ready(function() {
		var pageSize = "${TeamSch.pageSize}"
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
	<%@ include file="../common/header.jsp"%>

	<div id="main">
		<div class="page-heading">
			<div class="page-title">

				<%@ include file="../projectHome/sort.jsp"%>


				<div class="row">
					<div class="col-12 col-md-6 order-md-1 order-last">
						<h3>팀 관리</h3>

						<a href="/project5/insertTeam.do" class="badge bg-light-secondary">팀 배정</a> <a
							href="/project5/teamdetail.do" class="badge bg-light-secondary">배정
							목록 </a> <a
							href="/project5/output.do?projectkey=${project.projectkey }"
							class="badge bg-light-secondary">휴가 관리</a> <a
							href="/project5/minutes.do?method=list&projectkey=${project.projectkey }"
							class="badge bg-light-secondary">근태 관리</a>
					</div>
				</div>
				<section class="section">
					<div class="card">
						<div class="card-body">
							<div
								class="dataTable-wrapper dataTable-loading no-footer sortable searchable fixed-columns">
								<form id="frm02" action="${path}/teamlist.do" method="post">
									<input type="hidden" name="curPage" value="1" /> <span
										class="input-group-text">총 ${TeamSch.count}건</span>


									<div class="dataTable-dropdown">
										<select name="pageSize" class="dataTable-selector form-select">
											<option>5</option>
											<option>10</option>
											<option>15</option>
											<option>20</option>
											<option>25</option>
										</select> <label>게시글 수</label>
									</div>

									<div class="dataTable-search">
										<input type="text" id="schFrm" name="sch"
											class="dataTable-input" placeholder="Search" type="text"
											value="${TeamSch.status}">
										<button class="btn btn-info" type="submit">검색</button>
									</div>

								</form>
								<div class="dataTable-container">
									<table class="table table-striped dataTable-table" id="table1">
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
												<tr
													onclick="location.href='/project5/insertTeam.do?memberprojectkey='+${tlist.memberprojectkey}">
													<td style="text-align: center;">${tlist.name}</td>
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


									<button style="margin: auto; display: block;" id="regBtn"
										class="btn btn-primary" data-bs-toggle="modal"
										data-bs-target="#regModal">배정</button>

								</div>

								<div class="dataTable-bottom">
									<ul
										class="pagination pagination-primary float-end dataTable-pagination">
										<li class="page-item"><a class="page-link"
											href="javascript:goPage(${TeamSch.startBlock!=1?TeamSch.startBlock-1:1})">‹</a></li>
										<c:forEach var="cnt" begin="${TeamSch.startBlock}"
											end="${TeamSch.endBlock}">
											<li class="page-item ${cnt==TeamSch.curPage?'active':''}">
												<!-- 클릭한 현재 페이지 번호 --> <a class="page-link"
												href="javascript:goPage(${cnt})">${cnt}</a>
											</li>

										</c:forEach>
										<li class="page-item"><a class="page-link"
											href="javascript:goPage(${TeamSch.endBlock!=TeamSch.pageCount?TeamSch.endBlock+1:TeamSch.endBlock})">›</a></li>
									</ul>
								</div>
							</div>
						</div>
					</div>

				</section>


			</div>

			<br>

		</div>


	</div>
</body>
</html>