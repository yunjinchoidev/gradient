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
<title>프로젝트 홈</title>
</head>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<script>
	$(document).ready(function() {


		var psc = "${psc}"
		if(psc=="voteSuccess"){
			alert("성공적으로 투표하였습니다.")
		}
	
		
		
		
						var pageSize="${projectHomeSch.pageSize}"
							$("[name=pageSize]").val(pageSize);
							$("[name=pageSize]").change(function(){
								$("[name=curPage]").val(1);
								$("#frm01").submit();
							});	
							
							
							
	})
	
	
	
		function goPage(no){
			$("[name=curPage]").val(no);
			$("#frm01").submit();
		}
		
	
	
</script>
<style>
#moveBtn a {
	width: 135px;
	margin-right: 10px;
	font-size: 20px;
	font-weight: bold;
}
</style>


<body>
	<%@ include file="../chatBot/chatBot.jsp"%>
	<%@ include file="../common/header.jsp"%>



	<div id="main">

		<div class="page-heading">
			<div class="page-title">
				<div class="row">

						<div class="buttons" id="moveBtn" style="padding: 20px;">
		<a href="/project5/dashBoard.do?projectkey=${project.projectkey }"
			class="btn btn-secondary" >대시보드</a> 
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
	</div>
	<hr>






					<div class="col-12 col-md-6 order-md-1 order-last">
						<span style="font-size: 40px; font-weight: bolder; color: red;">[${project.name }]
						</span> <span style="font-size: 40px; font-weight: bolder; color: black;">홈</span>
						<p class="text-subtitle text-muted">공지를 확인하십시오.</p>
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
					<div class="card-header">프로젝트 공지사항</div>
					<div class="card-body">
					
			<form id="frm01" class="form" action="${path}/projectHome.do"
				method="post">
				<div class="dataTable-wrapper dataTable-loading no-footer sortable searchable fixed-columns">
					<div class="dataTable-top">
						<div class="input-group-prepend">
							<input type="hidden" name="curPage" value="1" /> <span
								class="input-group-text">총 ${projectHomeSch.count}건</span>
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
						$(document).ready(function(){
							$( ".searchbar" ).change(function() {
								  alert( "검색 종류를 변경합니다." );
								  $(".searchWhat").attr("name", this.value)
								  alert($(".searchWhat").value)
						 });
						
						});
						
						</script>
						
						
						
						<div class="dataTable-search" style="display: inline-block; ">
							
							<div style="display: inline-block;" >
								<select class="dataTable-selector form-select searchbar" 
								name="searchbar" style="display: inline-block; ">
										<option selected="selected">검색</option>
										<option value="title" selected="selected">title</option>
										<option value="contents">contents</option>
								</select>
								</div>
								
								<div style="display: inline-block;" >
								<input style="display: inline-block; " class="dataTable-input searchWhat" placeholder="검색어를 입력" type="text"
									name="title" value="${projectHomeSch.title}"> 
								  <button class="btn btn-info" type="submit">검색</button>
 <a
										href="/project5/projectHomeWriteForm.do"
										class="btn btn-danger" style="text-align: right">글쓰기</a> <a
										href="/project5/voteWriteForm.do" class="btn btn-info"
										style="text-align: right">투표만들기</a> <a
										href="/project5/voteWriteForm.do" class="btn btn-secondary"
										style="text-align: right">진행중인 투표</a> <a
										href="/project5/voteWriteForm.do" class="btn btn-warning"
										style="text-align: right">투표 결과</a>




								</div>
						</div>
						
						
						
					</div>
					</div>
			</form>
			



							<div class="dataTable-container">
								<table class="table table-striped dataTable-table" id="table1">
									<thead>
										<tr>
											<th data-sortable="" style="width: 12.0176%;"><a
												href="#" class="dataTable-sorter">번호</a></th>
											<th data-sortable="" style="width: 42.9989%;"><a
												href="#" class="dataTable-sorter">제목</a></th>
											<th data-sortable="" style="width: 18.0816%;"><a
												href="#" class="dataTable-sorter">작성날짜</a></th>
											<th data-sortable="" style="width: 16.3175%;"><a
												href="#" class="dataTable-sorter">작업구분</a></th>
											<th data-sortable="" style="width: 10.8049%;"><a
												href="#" class="dataTable-sorter">중요도</a></th>
										</tr>
									</thead>




									<tbody>

										<c:forEach var="list" items="${voteList }">
											<tr>
												<td>${list.votekey }</td>
												<td style="color: red; cursor:pointer" onclick="location.href='/project5/voteGet.do?votekey=${list.votekey}'" >[[투표]][${list.pname }]
													${list.title } 작성자[${list.mname }]</td>
												<td><fmt:formatDate value="${list.writedate }" /></td>
												<td><fmt:formatDate value="${list.enddate }" /></td>
												<td>${list.voteoption}</td>
											</tr>
										</c:forEach>


										<c:forEach var="list" items="${list }">
											<tr>
												<td>${list.projectHomekey }</td>
												<td>[${project.name }][${list.workSortTitle}]
													${list.title } 	<span class="badge bg-danger" id="delBtn" style="cursor: pointer;" onclick="location.href='/project5/projectHomeDelete.do?projectHomekey=${list.projectHomekey }'; return false;">삭제</span></td>
												<td><fmt:formatDate value="${list.writedate }" /></td>
												<td>${list.workSortTitle}</td>
												<td><c:if test="${list.importance==1 }">
														<span class="badge bg-success">최하</span>
													</c:if> <c:if test="${list.importance==2 }">
														<span class="badge bg-info">하</span>
													</c:if> <c:if test="${list.importance==3 }">
														<span class="badge bg-secondary">중</span>
													</c:if> <c:if test="${list.importance==4 }">
														<span class="badge bg-warning">상</span>
													</c:if> <c:if test="${list.importance==5 }">
														<span class="badge bg-danger">최상</span>
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
						href="javascript:goPage(${projectHomeSch.startBlock!=1?projectHomeSch.startBlock-1:1})">Previous</a></li>
					<c:forEach var="cnt" begin="${projectHomeSch.startBlock}"
						end="${projectHomeSch.endBlock}">
						<li class="page-item ${cnt==projectHomeSch.curPage?'active':''}">
							<!-- 클릭한 현재 페이지 번호 --> <a class="page-link"
							href="javascript:goPage(${cnt})">${cnt}</a>
						</li>
					</c:forEach>
					<li class="page-item"><a class="page-link"
						href="javascript:goPage(${projectHomeSch.endBlock!=projectHomeSch.pageCount?projectHomeSch.endBlock+1:projectHomeSch.endBlock})">Next</a></li>
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