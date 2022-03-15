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
<title>Insert title here</title>
<style>
td{
text-align: center;
}

#maincard{
border: solid red;
width:70%;
}

#sideseldiv{
position:absolute;
top: 15%;
left: 77%;
border: solid red;
width:20%;
height:30%;
}

#sideinfodiv{
position: absolute;
border: solid red;
top: 60%;
left: 77%;
width:20%;
height:30%;
margin
}

</style>
<script>
	$(document).ready(function(){
		
		var currentPosition = parseInt($("#sideinfodiv").css("top"));
		$(window).scroll(function() {
			var position = $(window).scrollTop();
			$("#sideinfodiv").stop().animate({"top":position+currentPosition+"px"},1000);
			
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
						<h3>예산 관리</h3>
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
			
			<section class="sectionMain">
				<!-- 메인영역 -->
				<div class="card" id="maincard">
					<div class="card-body">
						<div class="dataTable-wrapper dataTable-loading no-footer sortable searchable fixed-columns">
						 <form>
							<div class="dataTable-top">
							</div>
						  </form>
							<div class="dataTable-container">
								<table class="table table-striped dataTable-table" id="table1">
									<thead>
										<tr>
											<th data-sortable="" style="width: 10%;text-align:center;"><a
												href="#" class="dataTable-sorter">NO</a></th>
											<th data-sortable="" style="width: 20%;text-align:center;"><a
												href="#" class="dataTable-sorter">구분</a></th>
											<th data-sortable="" style="width: 25%;text-align:center;"><a
												href="#" class="dataTable-sorter">예산내역</a></th>
											<th data-sortable="" style="width: 20%;text-align:center;"><a
												href="#" class="dataTable-sorter">비고</a></th>
											<th data-sortable="" style="width: 25%;text-align:center;"><a
												href="#" class="dataTable-sorter">예산금액</a></th>
										</tr>
									</thead>

									<tbody>
										
									</tbody>
								</table>
								
								<button id="addbtn" class="btn btn-primary rounded-pill"
									style="margin: auto;display:block;margin-top:100px;">예산항목추가</button>								
							</div>
							
						</div>
					</div>
					
				</div>
			</section>
			
		</div>
		
	</div>
	<!-- 프로젝트 셀렉트 박스 div -->
	<div class="card" id="sideseldiv">
		<div class="card-body">
			<h4 style="text-align:center;">프로젝트 선택</h4>
			<select style="text-align:center;" class="form-select">
			<c:forEach var="plist" items="${prjlist}">
				<option value="${plist.prjkey}">${plist.prjname}</option>
			</c:forEach>
		</select>
		</div>	
	</div>
	<!-- 예산, 지출, 버튼 div -->
	<div class="card" id="sideinfodiv">
		<div class="card-body">
			<h5>예산&nbsp;&nbsp;&nbsp;&nbsp;원</h5>
			<h5>지출&nbsp;&nbsp;&nbsp;&nbsp;원</h5>
			
			<hr>
			<h5>이익&nbsp;&nbsp;&nbsp;&nbsp;원</h5>
			
			<div style="margin-top: 70px;">
				<button id="canclebtn" class="btn btn-primary rounded-pill"
					style="margin-right:10px;margin-left: 100px;">취소</button>
				<button id="regbtn" class="btn btn-primary rounded-pill">저장</button>
			</div>
		</div>	
	</div>
</body>
</html>