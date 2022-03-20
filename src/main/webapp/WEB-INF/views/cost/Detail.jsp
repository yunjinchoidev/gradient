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

#prjInfo{
width:70%;
padding-bottom: 30px;
}

#maincard{
width:70%;
}

#sideseldiv{
position:absolute;
top: 15%;
left: 77%;
width:20%;
height:30%;
}

#sideinfodiv{
position: absolute;
top: 50%;
left: 77%;
width:20%;
height:40%;
}

</style>
<script>
	$(document).ready(function(){
		var msg = "${msg}";
		if(msg != ""){
			alert(msg);
			location.href = "${path}/cost.do";
		}
		
		
		var take = "${prjInfo.take}";
		var amountpay = "${amountpay}";
		var sum = take - amountpay;
		
		var sumS = numberWithCommas(sum);
		var amountpayEle = document.getElementById('amountpay');
		amountpayEle.innerHTML = sumS;
		
		$("#backbtn").click(function(){
			location.href = "${path}/cost.do"
		});
		
		$("#confirmbtn").click(function(){
			if(confirm("승인하시겠습니까?")){
				location.href = "${path}/uptcostassign.do?prjkey="+$("[name=prjkey]").val();
			}
		});
		
		$("#delbtn").click(function(){
			if(confirm("삭제하시겠습니까?")){
				location.href = "${path}/delCost.do?prjkey="+$("[name=prjkey]").val();
			}
		});
		
		
	});
	
	function numberWithCommas(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
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
						<h3>예산 관리</h3>
					</div>
				</div>
			</div>
			
			<section class="sectionMain">
				<!-- 프로젝트 정보 -->
				<div id="prjInfo">
				<!-- 프로젝트명, PM -->
					<div style="display: flex;">
						<input type="hidden" name="prjkey" value="${prjInfo.prjkey}">
				 		<input class="form-control" type="text" value="${prjInfo.name}" readonly="readonly"
				 			style="flex: 3; background-color:white;margin-right: 100px;text-align:center;">
				 		<input class="form-control" type="text" value="${prjInfo.manager}" readonly="readonly"
				 			style="flex: 1; background-color:white;text-align:center;">
				 	</div>
				 <!-- 회사명, 시작일,종료일 -->
				 	<div style="display: flex;margin-top:20px;">
				 		<input class="form-control" type="text" value="${prjInfo.company}" readonly="readonly"
				 			style="flex: 1; background-color:white;margin-right: 100px;text-align:center;">
				 		<input class="form-control" type="text" value="${prjInfo.startdateS} ~ ${prjInfo.lastdateS}" readonly="readonly"
				 			style="flex: 1; background-color:white;text-align:center;">
				 	</div>
				</div>
				<!-- 메인영역 -->
				<div class="card" id="maincard">
					<div class="card-body">
						<div class="dataTable-wrapper dataTable-loading no-footer sortable searchable fixed-columns">
						 
							<div class="dataTable-top">
							</div>
						 
							<div class="dataTable-container">
								<table class="table table-striped dataTable-table" id="maintable">
									<thead>
										<tr>
											<th style="width: 10%;text-align:center;"><a
												href="#" class="dataTable-sorter">NO</a></th>
											<th style="width: 20%;text-align:center;"><a
												href="#" class="dataTable-sorter">구분</a></th>
											<th style="width: 25%;text-align:center;"><a
												href="#" class="dataTable-sorter">예산내역</a></th>
											<th style="width: 20%;text-align:center;"><a
												href="#" class="dataTable-sorter">비고</a></th>
											<th style="width: 25%;text-align:center;"><a
												href="#" class="dataTable-sorter">예산금액</a></th>
										</tr>
									</thead>
									
									<tbody>
										<c:forEach var="cdlist" items="${cdlist}">
											<c:set var="i" value="${i+1}"/>
												<tr>
													<td>${i}</td>
													<td>${cdlist.csname}</td>
													<td>${cdlist.content}</td>
													<td>${cdlist.costnote}</td>
													<td><fmt:formatNumber value="${cdlist.costex}" pattern="#,###"/></td>
												</tr>
										</c:forEach>
									</tbody>						
								</table>
								<c:choose>
									<c:when test="${prjInfo.costassign eq '미승인'}">
										<input class="btn btn-danger rounded-pill" type="text" value="${prjInfo.costassign}"
											style="margin-top: 100px;">
									</c:when>
									<c:when test="${prjInfo.costassign eq '승인'}">
										<input class="btn btn-success rounded-pill" type="text" value="${prjInfo.costassign}"
											style="margin-top: 100px;">
									</c:when>
								</c:choose>													
							</div>
							
						</div>
					</div>
					
				</div>
			</section>
			
		</div>
		
	</div>

	<!-- 예산, 지출, 버튼 div -->
	<div class="card" id="sideinfodiv">
		<div class="card-body">
			<label class="col-form-label">예산</label>
			<h5><fmt:formatNumber  value="${prjInfo.take}" pattern="#,###"/></h5>
			<label class="col-form-label">지출</label>
			<h5><fmt:formatNumber  value="${amountpay}" pattern="#,###"/></h5>
			<hr>
			<label class="col-form-label">이익</label>
			<h5 id="amountpay"></h5>
			
			<div style="margin-top: 30px;">
				<button id="confirmbtn" class="btn btn-primary rounded-pill"
					style="margin-right:10px;margin-left: 30px;">승인</button>
				<button id="delbtn" class="btn btn-primary rounded-pill"
					style="margin-right:10px;margin-left: 0px;">삭제</button>
				<button id="regbtn" class="btn btn-primary rounded-pill"
					style="margin-right:10px;margin-left: 0px;">수정</button>
				<button id="backbtn" class="btn btn-primary rounded-pill"
					style="margin-right:10px;margin-left: 0px;">목록</button>
			</div>
		 
		</div>	
	</div>
</body>
</html>