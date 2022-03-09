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

<script>
	$(document).ready(function(){
		$("#regBtn").click(function(){
			$("#regForm").submit();
		});
	});
</script>
</head>

<body>
	<%@ include file="../common/header.jsp"%>
	<div id="main">

		<div class="page-heading">
			<div class="page-title">
				<div class="row">
					<div class="col-12 col-md-6 order-md-1 order-last">
						<h3>리스크 관리</h3>
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
						<div class="dataTable-wrapper dataTable-loading no-footer sortable searchable fixed-columns">
							<div class="dataTable-top">
								<div class="dataTable-dropdown">
									<select class="dataTable-selector form-select">
										<option value="5">5</option>
										<option value="10">10</option>
										<option value="15">15</option>
										<option value="20">20</option>
										<option value="25">25</option>
									</select>
									<label>entries per page</label>	
								</div>
								
								<div class="dataTable-search">
									<input class="dataTable-input" placeholder="Search..." type="text">			
								</div>

							</div>
							<div class="dataTable-container">
								<table class="table table-striped dataTable-table" id="table1">
									<thead>
										<tr>
											<th data-sortable="" style="width: 20%;"><a
												href="#" class="dataTable-sorter">리스크</a></th>
											<th data-sortable="" style="width: 30%;"><a
												href="#" class="dataTable-sorter">프로젝트</a></th>
											<th data-sortable="" style="width: 10%;"><a
												href="#" class="dataTable-sorter">작성일</a></th>
											<th data-sortable="" style="width: 10%;"><a
												href="#" class="dataTable-sorter">완료예정일</a></th>
											<th data-sortable="" style="width: 10%;"><a
												href="#" class="dataTable-sorter">중요도</a></th>
											<th data-sortable="" style="width: 10%;"><a
												href="#" class="dataTable-sorter">진행사항</a></th>
											<th data-sortable="" style="width: 10%;"><a
												href="#" class="dataTable-sorter">담당자</a></th>
										</tr>
									</thead>

									<tbody>
                        				<tr>
				                            <td>버튼 이슈</td>
				                            <td>정부지원 4차 프로젝트</td>
				                            <td>2022-03-09</td>
				                            <td>2022-03-10</td>
				                            <td>
                               				<span class="badge bg-primary">낮음</span>
                            				</td>
                            				<td>
                               				<span class="badge bg-warning">진행중</span>
                            				</td>
                            				<td>김민수</td>
                       					 </tr>
                       					 
                       					 <tr>
				                            <td>버튼 이슈2</td>
				                            <td>정부지원 4차 프로젝트</td>
				                            <td>2022-03-09</td>
				                            <td>2022-03-10</td>
				                            <td>
                               				<span class="badge bg-danger">중요</span>
                            				</td>
                            				<td>
                               				<span class="badge bg-success">완료</span>
                            				</td>
                            				<td>김철수</td>
                       					 </tr>
                       					 
                       					 <tr>
				                            <td>버튼 이슈3</td>
				                            <td>정부지원 4차 프로젝트</td>
				                            <td>2022-03-09</td>
				                            <td>2022-03-10</td>
				                            <td>
                               				<span class="badge bg-warning">보통</span>
                            				</td>
                            				<td>
                               				<span class="badge bg-primary">대기</span>
                            				</td>
                            				<td>김진수</td>
                       					 </tr>
                       					 	                       					 
									</tbody>

								</table>
								
								<button style="margin: auto;display:block;" 
								class="btn btn-primary rounded-pill" data-bs-toggle="modal" data-bs-target="#regForm">등록</button>
								
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

	</div>
	
	<!-- 등록 Modal -->
  	<div class="modal fade text-left" id="regForm" tabindex="-1" role="dialog"
       	aria-labelledby="myModalLabel33" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myModalLabel33">리스크 등록</h4>
                <button type="button" class="close" data-bs-dismiss="modal"
                    aria-label="Close">
                    <i data-feather="x"></i>
                </button>
            </div>
            <form id="regForm">
            	<!-- 모달 입력 요소 영역 -->
                <div class="modal-body" style="margin:10px;">
                	<!-- 프로젝트 select box -->
                	<div id="prjselect">
                    	<select class="form-select">
                    		<option>프로젝트1</option>
                    		<option>프로젝트2</option>
                    	</select>
                    </div>
                    
                    <!-- 중요도, 제목 공통 영역 -->
                    <div id="headerdiv" style="display:flex;margin-top: 10px;">
                    <!-- 중요도 select box -->
                    	<div id="importselect" style="flex:1;margin-right:5px;">
                    		<select class="form-select" name="importance">
	                    		<option value="중요">중요</option>
	                    		<option value="보통">보통</option>
	                    		<option value="낮음">낮음</option>
                    		</select>
                    	</div>
                    <!-- 제목 -->
                    	<div id="title" style="flex:4;">
                    		<input class="form-control" type="text" name="title" placeholder="제목을 입력하세요">
                    	</div>
                    </div>
                    
                    <!-- 상세내용 -->
                    <div id="detailcontent" style="margin-top: 10px;">
                    	<textarea name="content" placeholder="상세 내용" class="form-control" rows="5" cols="5"></textarea>
                    </div>
                    
                    <!-- 진행사항, 완료 예정일 영역 -->
                    <div id="footerdiv" style="display:flex; margin-top: 10px;">
                    <!-- 진행사항 -->
                    	<div id="importselectdiv" style="flex:3; margin-right:150px;">
                    		<select class="form-select" name="progress">
	                    		<option value="진행중">진행중</option>
	                    		<option value="대기">대기</option>
	                    		<option value="완료">완료</option>
                    		</select>
                    	</div>
                    <!-- 완료예정일 -->
                    	<div id="comdatediv" style="flex:1; margin-top:5px;">
                    		<input type=date name="comdate">
                    	</div>
                    </div>
                        
                </div>
                <!-- 버튼 영역 -->
                <div class="modal-footer">
                    <button type="button" class="btn btn-light-secondary"
                        data-bs-dismiss="modal">
                        <i class="bx bx-x d-block d-sm-none"></i>
                        <span class="d-none d-sm-block">닫기</span>
                    </button>
                    <button type="button" id="regBtn" class="btn btn-primary ml-1"
                        data-bs-dismiss="modal">
                        <i class="bx bx-check d-block d-sm-none"></i>
                        <span class="d-none d-sm-block">등록</span>
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- 상세화면 Modal -->

</body>
</html>