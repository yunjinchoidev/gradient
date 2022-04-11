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

<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<meta charset="UTF-8">
<title>GRADIENT - 예산</title>
<style>
td{
text-align: center;
}

</style>
<style>
#moveBtn a {
	width: 135px;
	margin-right: 10px;
	font-size: 20px;
	font-weight: bold;
}
</style>

<script>
	$(document).ready(function(){
		
		var auth = "${member.auth}";
		
		var msg = "${msg}";
		
		if(msg!=""){
			alert(msg);
			location.href="${path}/cost.do";
		}
		
			var securityName = '<sec:authentication property="name"/>'
			
			if (securityName == "") {
				alert("접근 권한이 없습니다");
				location.href = "/project5/user/loginform";
			}
		
		/*
		if(auth != 'pm' && auth != 'admin'){
			alert("접근 권한이 없습니다");
			location.href="${path}/main.do";
		}
		*/
		
		$("#regbtn").click(function(){
			location.href="${path}/writecost.do";
		});
		
		var pageSize="${costSch.pageSize}"
			$("[name=pageSize]").val(pageSize);
			$("[name=pageSize]").change(function(){
				$("[name=curPage]").val(1);
				$("#schform").submit();
			});
		
	});
	
	function goDetail(prjkey){
		location.href="${path}/detailcost.do?prjkey="+prjkey;
	}
	
	function goPage(costkey){
		$("[name=curPage]").val(costkey);
		$("#schform").submit();
	}
</script>

</head>

<body>
	<%@ include file="../common/header.jsp"%>
	<div id="main">
		<div class="page-heading">
			<div class="page-title">
				<div class="row">
					<%@ include file="../projectHome/sort.jsp"%>
					<div class="col-12 col-md-6 order-md-1 order-last">
						<h3>예산 관리</h3>
					</div>
					
				</div>
			</div>
			
			<section class="section">
				<div class="card">
					<div class="card-body">
						<div class="dataTable-wrapper dataTable-loading no-footer sortable searchable fixed-columns">
						<form id="schform" action="${path}/cost.do" method="post">
						  	<input type="hidden" name="curPage" value="1"/>
							<div class="dataTable-top">
								<div class="dataTable-dropdown">
									<select name="pageSize" class="dataTable-selector form-select">
										<option>5</option>
										<option>10</option>
										<option>15</option>
										<option>20</option>
										<option>25</option>
									</select>
									<label>게시글 수</label>	
								</div>
								
								<div class="dataTable-search">
									<input type="text" id="schFrm" name="sch" class="dataTable-input" placeholder="Search..." type="text">
								</div>
							</div>
						  </form>
							<div class="dataTable-container">
								<table class="table table-striped dataTable-table" id="table1">
									<thead>
										<tr>
											<th style="width: 5%;text-align:center;">NO</th>
											<th style="width: 33%;text-align:center;">프로젝트명</th>
											<th style="width: 10%;text-align:center;">시작일</th>
											<th style="width: 10%;text-align:center;">종료일</th>
											<th style="width: 25%;text-align:center;">회사</th>
											<th style="width: 7%;text-align:center;">PM</th>
											<th style="width: 10%;text-align:center;">예산배정</th>
										</tr>
									</thead>

									<tbody>
										<c:forEach var="clist" items="${costlist}">
											<tr onclick="goDetail(${clist.prjkey})" style="cursor:pointer;"
												onmouseover="this.style.color='#2B65EC'" onmouseout="this.style.color='#607080'">
												<td>${clist.costkey}</td>
												<td>${clist.prjname}</td>
												<td>${clist.startdate}</td>
												<td>${clist.lastdate}</td>
												<td>${clist.company}</td>
												<td>${clist.pm}</td>
												<c:if test="${clist.costassign eq '승인'}">
													<td><span class="badge bg-success">${clist.costassign}</span></td>
												</c:if>
												<c:if test="${clist.costassign eq '미승인'}">
													<td><span class="badge bg-danger">${clist.costassign}</span></td>
												</c:if>
											</tr>
										</c:forEach>
									</tbody>
								</table>
								
								<button id="regbtn" class="btn btn-primary rounded-pill"
									style="margin: auto;display:block;">등록</button>								
							</div>

							<div class="dataTable-bottom">
								<div class="dataTable-info">전체 예산: ${costSch.count}</div>
								<ul class="pagination pagination-primary float-end dataTable-pagination">
									<li class="page-item pager"><a class="page-link"
										href="javascript:goPage(${costSch.startBlock!=1?costSch.startBlock-1:1})">‹</a></li>
									<c:forEach var="cnt" begin="${costSch.startBlock}" end="${costSch.endBlock}">
	  									<li class="page-item ${cnt==costSch.curPage?'active':''}"> <!-- 클릭한 현재 페이지 번호 -->
	  									<a class="page-link" href="javascript:goPage(${cnt})">${cnt}</a></li>
	 								</c:forEach>
									<li class="page-item pager"><a class="page-link"
										href="javascript:goPage(${costSch.endBlock!=costSch.pageCount?costSch.endBlock+1:costSch.endBlock})">›</a></li>
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