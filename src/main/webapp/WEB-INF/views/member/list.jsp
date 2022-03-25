
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




<script  src="http://code.jquery.com/jquery-latest.min.js"></script>

</head>

<script>
$(document).ready(function(){
	formObj = $("form");
	

	
	 var delchk = []; // key 값을 담을 배열
	 $("#sendMail").click(function(e){
			var checked =$('input:checkbox[id="memberkey"]:checked').val();
		 $('input:checkbox[id="memberkey"]:checked').each(function(){
		        delchk.push($(this).val());
		   	 console.log(this)  ;
		 });
		 console.log("delchk : "+delchk);
		 console.log("checked : "+checked);
		 confirm("정말 메일을 발송하시겠습니까?");
		 //confirm(delchk);
		 e.preventDefault();

		 
		 formObj.submit();
		 
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
						<h3>회원관리</h3>
						<p class="text-subtitle text-muted">이곳에서 회원을 관리하십시오</p>
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
						당신을 위한 여러 기능들이 준비되어 있습니다.<br><br>


						<div class="buttons" style="margin-bottom: 10px; margin-top: 5px;">
							<a href="" class="btn btn-dark" id="sendMail">메일발송</a>
							<a href="#" class="btn btn-danger">추방</a> <a href="#"
								class="btn btn-primary">평가</a> 
								
								
								<!-- 
								<a href="#"
								class="btn btn-secondary">일정관리</a> <a href="#"
								class="btn btn-info">회의록</a> <a href="#" class="btn btn-warning">채팅</a>
							<a href="#" class="btn btn-danger">예산 관리</a> <a href="#"
								class="btn btn-success">품질 관리</a> <a href="#"
								class="btn btn-light">리스크 관리</a>
								 -->
								
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
										<option value="25">25</option></select><label>entries per page</label>
								</div>
								<div class="dataTable-search">
									<input class="dataTable-input" placeholder="Search..."
										type="text">
								</div>
							</div>
							<div class="dataTable-container">
								<table class="table table-striped dataTable-table" id="table1">
									<thead>
										<tr>
											<th data-sortable="" style="width: 11.8185%;"><a
												href="#" class="dataTable-sorter">이름</a></th>
											<th data-sortable="" style="width: 35.9018%;"><a
												href="#" class="dataTable-sorter">Email</a></th>
											<th data-sortable="" style="width: 13.8021%;"><a
												href="#" class="dataTable-sorter">직급</a></th>
											<th data-sortable="" style="width: 16.423%;"><a href="#"
												class="dataTable-sorter">담당 프로젝트</a></th>
											<th data-sortable="" style="width: 12%;"><a href="#"
												class="dataTable-sorter">소속 부서</a></th>
											<th data-sortable="" style="width: 11.051%;"><a href="#"
												class="dataTable-sorter">관리</a></th>
											<th data-sortable="" style="width: 11.051%;"><a href="#"
												class="dataTable-sorter">선택</a></th>
										</tr>
									</thead>
									<tbody>

										<c:forEach var="list" items="${list }">
											<tr>
												<td>${list.memberkey}:${list.name }</td>
												<td>${list.email}</td>
												<td>${list.auth }</td>
												<td>${list.projectkey }</td>
												<td>${list.deptno }</td>
												<td><span class="badge bg-success">Active</span></td>
												<td>
												
												
												<form action="/project5/mailFrm2.do" method="post">
                                                <div class="form-check">
                                                    <div class="custom-control custom-checkbox">
                                                        <input type="checkbox" class="form-check-input form-check-info chk" name="memberkey" value="${list.memberkey }" id="memberkey">
                                                        <label class="form-check-label" for="customColorCheck5">Info</label>
                                                    </div>
                                                </div>
                                                </form>
                                           
                                           
                                           
                                           
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