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
				
						<%@ include file="../projectHome/sort.jsp"%>
				
				
									<div class="col-12 col-md-6 order-md-1 order-last">
										<span style="font-size: 40px; font-weight: bolder; color: red;">[${project.name }]
										</span> <span style="font-size: 40px; font-weight: bolder; color: black;">조달 관리</span>
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
			
			
									
										<iframe src="/project5/procuSituationList.do?projectkey=${project.projectkey }"
										style="width:100%; height: 500px;"
										></iframe>
				
				
				
				
			
		</div>

</body>
</html>