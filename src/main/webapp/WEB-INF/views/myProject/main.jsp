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
  <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="/project5/resources/dist/assets/js/pages/ui-chartjs.js"></script>
<script
	src="/project5/resources/dist/assets/vendors/perfect-scrollbar/perfect-scrollbar.min.js"></script>
<script
	src="/project5/resources/dist/assets/vendors/chartjs/Chart.min.js"></script>
<meta charset="UTF-8">
<title>나의 프로젝트</title>
<script>
	$(document).ready(function() {
		var psc = "${psc}";

		if (psc == "success") {
			alert("로그인 성공하셨습니다.");
		}

		if (psc == "logout") {
			alert("로그아웃 되었습니다.");
		}
	})
</script>

<style type="text/css">/* Chart.js */
@
keyframes chartjs-render-animation {
	from {opacity: .99
}

to {
	opacity: 1
}

}
.chartjs-render-monitor {
	animation: chartjs-render-animation 1ms
}

.chartjs-size-monitor, .chartjs-size-monitor-expand,
	.chartjs-size-monitor-shrink {
	position: absolute;
	direction: ltr;
	left: 0;
	top: 0;
	right: 0;
	bottom: 0;
	overflow: hidden;
	pointer-events: none;
	visibility: hidden;
	z-index: -1
}

.chartjs-size-monitor-expand>div {
	position: absolute;
	width: 1000000px;
	height: 1000000px;
	left: 0;
	top: 0
}

.chartjs-size-monitor-shrink>div {
	position: absolute;
	width: 200%;
	height: 200%;
	left: 0;
	top: 0
}
</style>
</head>


<script>
document.ready(function(){
	var memberkey = ${member.memberkey};
	
	if(memberkey==""){
		alert("미 로그인시 접근 불가합니다.")
	}
})

</script>

<body>

	<%@ include file="../common/header.jsp"%>


	<div id="main">

		<div class="page-heading">
			<div class="page-title">
				<div class="row">
					<div class="col-12 col-md-6 order-md-1 order-last">
						<h3>나의 모든 프로젝트</h3>
						<p class="text-subtitle text-muted">대시보드입니다.</p>
					</div>
					<div class="col-12 col-md-6 order-md-2 order-first">
						<nav aria-label="breadcrumb"
							class="breadcrumb-header float-start float-lg-end"></nav>
					</div>
				</div>
			</div>
			<section class="section">
				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-header">
								<h5 class="card-title">대시보드입니다.</h5>
							</div>
							<div class="card-body">
								대시보드입니다. <a href="https://github.com/yunjinchoidev/project5"
									target="_blank">대시보드입니다.<br> <br>
								</a>
							</div>
						</div>
					</div>
				</div>
			</section>
		</div>

		<div class="page-heading">
			<div class="page-title">
				<div class="row">
					<div class="col-12 col-md-6 order-md-1 order-last">
						<h3>나의 프로젝트</h3>
						<p class="text-subtitle text-muted">내가 참여중인 프로젝트가 여기 있습니다.</p>
					</div>
					<div class="col-12 col-md-6 order-md-2 order-first">
						<nav aria-label="breadcrumb"
							class="breadcrumb-header float-start float-lg-end">
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="index.html">Dashboard</a></li>
								<li class="breadcrumb-item active" aria-current="page">Card</li>
							</ol>
						</nav>
					</div>
				</div>

			</div>






			<!-- Basic card section start -->
			<section id="content-types"
				style="display: flex; flex-direction: row; flex-wrap: wrap;">
				<c:forEach var="list" items="${list }">
					<div class="card" style="margin-right: 40px; width: 470px; cursor: pointer;" onclick="location.href='/project5/projectHome.do?projectkey=${list.projectkey}'" >
						<div class="card-content">
							<img src="/project5/resources/image/project.png"
								class="card-img-top img-fluid" alt="singleminded">
							<div class="card-body">
								<h5 class="card-title" onclick="location.href='/project5/projectHome.do?projectkey=${list.projectkey}'">${list.name }</h5>
								<p class="card-text">${list.contents }</p>
							</div>
						</div>
						<ul class="list-group list-groue-flush">
							<li class="list-group-item">프로젝트</li>
							<li class="list-group-item">프로젝트</li>
							<li class="list-group-item">프로젝트</li>
							<li class="list-group-item" onClick="window.open('http://www.naver.com','네이버','width=800, height=700, toolbar=no, menubar=no, scrollbars=no, resizable=yes');return false;"
								>진행사항확인</li>
						</ul>
						  <div id="chart_div"></div>
					</div>
					
					<script>
						google.charts.load('current', {packages: ['corechart', 'bar']});
						google.charts.setOnLoadCallback(drawBasic);
						function drawBasic() {
						      var data = google.visualization.arrayToDataTable([
						        ['City', 'Project',],
						        ['Progress', 50]
						      ]);
			
						      var options = {
						        title: '프로젝트',
						        chartArea: {width: '50%'},
						        hAxis: {
						          title: '진행률 구분',
						          minValue: 0,
						          maxValue:100
						        },
						        vAxis: {
						          title: 'Progress'
						        }
						      };
			
						      var chart = new google.visualization.BarChart(document.getElementById('chart_div'));
			
						      chart.draw(data, options);
						    }
						</script>
					
				</c:forEach>
			</section>
			
			
			
			
			
			









		</div>
	</div>

</body>
</html>