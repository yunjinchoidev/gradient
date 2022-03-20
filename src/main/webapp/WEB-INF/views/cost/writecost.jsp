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
margin
}

</style>
<script>
	$(document).ready(function(){
		
		var cnt = 2;
		var i = 1;
		var prjkey = "${prjkey}";
		var prjcost = "${prjcost}";
		var msg = "${msg}";
		
		if(msg!=""){
			alert(msg);
			location.href="${path}/cost.do";
		}
		
		var currentPosition = parseInt($("#sideinfodiv").css("top"));
		$(window).scroll(function() {
			var position = $(window).scrollTop();
			$("#sideinfodiv").stop().animate({"top":position+currentPosition+"px"},1000);
			
		});
		
		$("#addbtn").click(function(){
			$('#maintable > tbody:last').append('<tr><td>'+cnt+'</td>'+
					
					'<td><select class="form-select" name="list['+i+'].cskey">'+
						<c:forEach var="cslist" items="${cslist}">
						 '<option value="${cslist.cskey}">${cslist.cscontent}</option>'+
						</c:forEach>
						'</select></td>'+
					'<td><input class="form-control" type="text" name="list['+i+'].costcontent"></td>'+
					'<td><input class="form-control" type="text" name="list['+i+'].costnote"></td>'+
					'<td><input class="form-control costex" type="number" id="costex" name="list['+i+'].costex"></td>'+
					'<td><input class="form-control" type="hidden" name="list['+i+'].no" value="${prjkey}"></td></tr>');
			cnt+=1;
			i+=1;
		});
		
		$("#delbtn").click(function(){
			$('#maintable > tbody > tr:last').remove();
			cnt-=1;
			i-=1;
		});
		
		$("#canclebtn").click(function(){
			location.href="${path}/cost.do";
		});
		
		var prjkeyS = $('[name=prjkey]').val();
		
		$("#prjsel").change(function(){
			$("#prjselfrm").submit();
		});
		
		$('#prjsel').val(prjkey).prop("selected", true);
		
		$("#calbtn").click(function(){
			doSum();
		});
		
		$("#regbtn").click(function(){
			$("#inscostform").submit();	
		});

		
	});
	
	function doSum(){
		var exsum = 0;
		var prsum = 0;
		var prjcost = ${prjcost};
		
		$('.costex').each(function(){
			if(!isNaN($(this).val())){
				exsum += parseInt($(this).val());
				var exsumS = numberWithCommas(exsum);
				var exsumEle = document.getElementById('exsum');
				exsumEle.innerHTML = exsumS;
				
				prjcost = parseInt(prjcost);
				prsum = parseInt(prjcost-exsum);
				var prsumS = numberWithCommas(prsum);
				var prsumEle = document.getElementById('prsum');
				prsumEle.innerHTML = prsumS;
				
			}
				
		});
		
		$("input[name=exsum]").val(exsum);
		$("input[name=prsum]").val(prsum);
	}
	
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
						 
							<div class="dataTable-top">
							</div>
						 
							<div class="dataTable-container">
								<form id="inscostform" action="${path}/insertcost.do" method="post">
								<input type="hidden" name=prjkey value="${prjkey}">
								<table class="table table-striped dataTable-table" id="maintable">
									<thead>
										<tr>
											<th style="width: 5%;text-align:center;"><a
												href="#" class="dataTable-sorter">NO</a></th>
											<th style="width: 20%;text-align:center;"><a
												href="#" class="dataTable-sorter">구분</a></th>
											<th style="width: 25%;text-align:center;"><a
												href="#" class="dataTable-sorter">예산내역</a></th>
											<th style="width: 20%;text-align:center;"><a
												href="#" class="dataTable-sorter">비고</a></th>
											<th style="width: 25%;text-align:center;"><a
												href="#" class="dataTable-sorter">예산금액</a></th>
											<th style="width: 5%;text-align:center;"><a
												href="#" class="dataTable-sorter"></a></th>
										</tr>
									</thead>
									
									<tbody>
										<tr>
											<td>1</td>
											<td>
												<select class="form-select" name="list[0].cskey">
													<c:forEach var="cslist" items="${cslist}">
						 								<option value="${cslist.cskey}">${cslist.cscontent}</option>
													</c:forEach>
												</select>
											</td>
						
											<td><input class="form-control" type="text" name="list[0].costcontent"></td>
											<td><input class="form-control" type="text" name="list[0].costnote"></td>
											<td><input class="form-control costex" type="number" id="costex" name="list[0].costex"></td>
											<td><input class="form-control" type="hidden" name="list[0].no" value="${prjkey}"></td>
										</tr>
									</tbody>									
								</table>
								</form>
								
								
									
						
								
								<!-- 예산항목추가, 예산항목삭제 버튼 -->
								<div style="margin-top: 150px;">
									<button type="button" id="delbtn" class="btn btn-primary rounded-pill"
										style="margin-left:400px;">예산항목삭제</button>
									<button type="button" id="addbtn" class="btn btn-primary rounded-pill"
										style="margin-left:50px;">예산항목추가</button>
								</div>
																	
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
			<form id="prjselfrm">
			<select style="text-align:center;" id="prjsel" name="prjkeyS" class="form-select">
				<option>--프로젝트를 선택해주세요--</option>
				<c:forEach var="plist" items="${prjlist}">
					<option value="${plist.prjkey}">${plist.prjname}</option>
				</c:forEach>
			</select>
			</form>
		</div>	
	</div>
	<!-- 예산, 지출, 버튼 div -->
	<div class="card" id="sideinfodiv">
		<div class="card-body">
			<label class="col-form-label">예산</label>
			<h5><fmt:formatNumber  value="${prjcost}" pattern="#,###"/></h5>
			<label class="col-form-label">지출</label>
			<h5 id="exsum"></h5>
			<hr>
			<label class="col-form-label">이익</label>
			<h5 id="prsum"></h5>
			
			<div style="margin-top: 30px;">
				<button id="calbtn" class="btn btn-primary rounded-pill"
					style="margin-right:10px;margin-left: 70px;">계산</button>
				<button id="canclebtn" class="btn btn-primary rounded-pill"
					style="margin-right:10px;margin-left: 0px;">취소</button>
				<button id="regbtn" class="btn btn-primary rounded-pill"
					style="margin-right:10px;margin-left: 0px;">저장</button>
			</div>
		 
		</div>	
	</div>
</body>
</html>