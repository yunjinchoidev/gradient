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

<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<script>
	$(document).ready(function(){
		
		var msg = "${msg}";
		
		if(msg!=""){
			alert(msg);
			if(msg=="등록되었습니다"){
				location.href="${path}/risk.do";
			}
		}
		
		$("#regBtn").click(function(){
			if(confirm('등록 하시겠습니까?')){
				$('#regForm').submit();
			}
		});
		
		
	});
	
	function goDetail(){
		$("#detailModal").modal('show');
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
									
									<c:forEach var="rlist" items="${risklist}">
                        				<tr onclick="goDetail()">
				                            <td>${rlist.title}</td>
				                            <td>${rlist.prjname}</td>
				                            <td>${rlist.writedates}</td>
				                            <td>${rlist.comdate}</td>
				                            <td>
				                            <!-- 중요도 값에 따라 색 변경 -->
				                            <c:choose>
				                            	<c:when test="${rlist.importance eq'낮음'}">
                               						<span class="badge bg-primary">${rlist.importance}</span>
                               					</c:when>
                               					<c:when test="${rlist.importance eq'보통'}">
                               						<span class="badge bg-warning">${rlist.importance}</span>
                               					</c:when>
                               					<c:when test="${rlist.importance eq'중요'}">
                               						<span class="badge bg-danger">${rlist.importance}</span>
                               					</c:when>
                               				</c:choose>
                            				</td>
                            				<td>
                            				<!-- 진행사항 값에 따라 생 변경 -->
                            				<c:choose>
                            					<c:when test="${rlist.progress eq'진행중'}">
                               						<span id="prog" class="badge bg-warning">${rlist.progress}</span>
                               					</c:when>
                               					<c:when test="${rlist.progress eq'대기'}">
                               						<span id="prog" class="badge bg-primary">${rlist.progress}</span>
                               					</c:when>
                               					<c:when test="${rlist.progress eq'완료'}">
                               						<span id="prog" class="badge bg-success">${rlist.progress}</span>
                               					</c:when>
                               				</c:choose>
                            				</td>
                            				<td>${rlist.name}</td>
                       					 </tr>
                       				</c:forEach>
                       					                 					 	                       					 
									</tbody>

								</table>
								
								<button style="margin: auto;display:block;" 
								class="btn btn-primary rounded-pill" data-bs-toggle="modal" data-bs-target="#regModal">등록</button>
								
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
  	<div class="modal fade text-left" id="regModal" tabindex="-1" role="dialog"
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
            <form id="regForm" action="${path}/insertrisk.do" method="post">
            	<!-- 모달 입력 요소 영역 -->
                <div class="modal-body" style="margin:10px;">
                	<!-- 프로젝트 select box -->
                	<div id="prjselect">
                    	<select class="form-select" style="text-align:center;" name="prjkey">
                    		<c:forEach var="prlist" items="${prjlist}">
                    			<option value="${prlist.prjkey}">${prlist.prjname}</option>
                    		</c:forEach>
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
                    <div id="regcontent" style="margin-top: 10px;">
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
<div class="modal fade text-left" id="detailModal" tabindex="-1" role="dialog"
       	aria-labelledby="myModalLabel33" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myModalLabel33">리스크 상세화면</h4>
                <button type="button" class="close" data-bs-dismiss="modal"
                    aria-label="Close">
                    <i data-feather="x"></i>
                </button>
            </div>
            <form id="detailForm">
            	<!-- 모달 상세정보 영역 -->
                <div class="modal-body">
                <!-- 날짜 영역 -->
                	<div id="writedatediv" style="margin-left:360px; ">
                		2022-03-10
                	</div>
                <!-- 프로젝트 영역 -->
                	<div id="detailprj">
                		<input class="form-control" type="text" value="프로젝트1" readonly="readonly"
                			style="background-color:white; color:black;text-align: center;"  >
                	</div>
                	<!-- 중요도, 리스크명 영역  -->
                	<!-- 중요도 -->
                	<div id="detailheader" style="display:flex;margin-top: 10px;">
                		<div id="detailimport" style="flex:1;margin-right:5px;">
                			<input class="form-control" type="text" value="중요" readonly="readonly"
                				style="background-color: #C0392B; color: white; text-align:center;" >
                		</div>
                	<!-- 제목 -->
                		<div id="detailtitle" style="flex:4;">
                			<input class="form-control" type="text" value="버튼 이슈" readonly="readonly"
                				style="background-color: white; color:black; text-align:center;" >
                		</div>          
                	</div>
                	<!-- 리스크 상세 내용 -->
                	<div id="detailcontent" style="margin-top: 10px;">
                    	<textarea name="content" class="form-control" rows="5" cols="5" readonly="readonly"
                    		style="background-color: white; color:black;">상세내용 입니다</textarea>
                    </div>
                    <!-- 담당자, 진행사항, 완료 예정일 -->
                    <div id="detailfooter" style="display:flex; margin-top:10px;">
                   	<!-- 담당자 -->
                    	<div id="manager" style="flex:1;margin-right: 10px;">
                    		<input class="form-control" type="text" value="김철수" readonly="readonly"
                				style="background-color: white; color:black; text-align:center;" >
                    	</div>
                    <!-- 진행사항 -->
                    	<div id="detailprogress" style="flex:1">
                    		<input class="form-control" type="text" value="진행중" readonly="readonly"
                				style="background-color: #F1C40F; color:white; text-align:center;" >
                    	</div>
					<!-- 완료 예정일 text -->
						<div id="comdateText" style="flex:1;margin-left:50px;margin-top:7px;">
							완료예정일
						</div>
                    <!-- 완료예정일 -->
                    	<div id="detailcomdate" style="flex:2;">                
                    		<input class="form-control" type="text" value="2022-03-10" readonly="readonly"
                				style="background-color: white; color:black; text-align:center;"
                				data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-original-title="완료예정일" >
                    	</div>                    	
                    	
                    </div>
                	   
                </div>
                <!-- 버튼 영역 -->
                <div class="modal-footer">
                
                	<button type="button" id="delBtn" class="btn btn-danger ml-1"
                        data-bs-dismiss="modal">
                        <i class="bx bx-check d-block d-sm-none"></i>
                        <span class="d-none d-sm-block">삭제</span>
                    </button>
                    
                    <button type="button" id="uptBtn" class="btn btn-warning ml-1"
                        data-bs-dismiss="modal">
                        <i class="bx bx-check d-block d-sm-none"></i>
                        <span class="d-none d-sm-block">수정</span>
                    </button>
                
                    <button type="button" class="btn btn-light-secondary"
                        data-bs-dismiss="modal">
                        <i class="bx bx-x d-block d-sm-none"></i>
                        <span class="d-none d-sm-block">닫기</span>
                    </button>
                    
                </div>
            </form>
        </div>
    </div>
</div>

<!-- 수정 Modal -->


</body>
</html>