
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
<title>GRADIENT - 고객 상담</title>
</head>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	$(document).ready(function() {

		
		
		
		var psc = $("psc")
		if(psc == "EmailSuccess"){
			alert("이메일 발송이 완료 되었습니다.")
		}
		
		
		
		$("#allCheck").click(function() {
			if ($("#allCheck").prop("checked")) {
				alert("전체 클릭합니다.")
				$("input[type=checkbox]").prop("checked", true);
			} else { //해당화면에 모든 checkbox들의 체크를해제시킨다. 
				alert("전체 클릭 해제합니다.")
				$("input[type=checkbox]").prop("checked", false);
			}
		})

		
		
		$("#groupBtn").click(function(e) {
			confirm("선택된 회원들을 단체 대화에 초대 하시겠습니까?")
			
			var array = new Array();
					$('input:checkbox[name=memberkey]:checked').each(function() {
						array.push(this.value);
						console.log(this.value);
					})
			alert("선택한 회원들 : "+array);
			location.href="/project5/groupInvitation.do?arrayParam="+array;
		})
		
		
	
		$("#individualBtn").click(function(e) {
				confirm("회원을 1:1 대화에 초대 하시겠습니까?")
				var choiceMemberkey =	$('input:checkbox[name=memberkey]:checked').val();
				location.href="/project5/individualInvitation.do?memberkey="+choiceMemberkey
		})
		
		

		
		
	});
</script>




<body>
	<%@ include file="../chatBot/chatBot.jsp"%>
	<%@ include file="../common/header.jsp"%>

	<div id="main">
		<header class="mb-3">
			<a href="#" class="burger-btn d-block d-xl-none"> <i
				class="bi bi-justify fs-3"></i>
			</a>
		</header>

		<div class="page-heading">
			<div class="page-title">
				<div class="row">
					<div class="col-12 col-md-6 order-md-1 order-last">
						<h3>채팅 초대 가능 회원 목록</h3>
						<p class="text-subtitle text-muted">채팅 초대 가능 회원 목록</p>
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
						둘 중 하나를 선택하세요<br> <br>
						<div class="buttons" style="margin-bottom: 10px; margin-top: 5px;">
							<a href="#" class="btn btn-danger" id="individualBtn">1:1 대화 초대하기</a> 
							<a href="#" class="btn btn-primary" id="groupBtn">단체 톡 만들기</a> 
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
													<td>${list.name}</td>
													<td>${list.email }</td>
													<td>${list.auth }</td>

												
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