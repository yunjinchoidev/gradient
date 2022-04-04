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
						$("#pjList").change(
										function() {
											var selectedval = $(this).val();
											console.log(selectedval);
											location.href = "/project5/projectHome.do?projectkey="
													+ selectedval;
										})


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
			class="btn btn-secondary" onclick="alert('${project.projectkey } : ${project.name } 이 유지됩니다.')">대시보드</a> 
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
				
				
							</div>
			
			
			
			
							
							<section class="section">
								<div class="card">
									<div class="card-header">프로젝트 공지사항</div>
									<div class="card-body">
									
										<%@include file="detail.html" %>
				
				
										</div>
									</div>
							</section>
			
			
			
		</div>

</body>
</html>