<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title id='Description'>Kanban Board.</title>
<link rel="stylesheet"
	href="/project5/jqwidgets-ver13.2.0/a/jqx.base.css"
	type="text/css" />
<script type="text/javascript"
	src="/project5/jqwidgets-ver13.2.0/scripts/jquery-1.11.1.min.js"></script>
<script type="text/javascript"
	src="/project5/jqwidgets-ver13.2.0/a/jqxcore.js"></script>
<script type="text/javascript"
	src="/project5/jqwidgets-ver13.2.0/a/jqxsortable.js"></script>
<script type="text/javascript"
	src="/project5/jqwidgets-ver13.2.0/a/jqxkanban.js"></script>
<script type="text/javascript"
	src="/project5/jqwidgets-ver13.2.0/a/jqxdata.js"></script>
<script type="text/javascript">
	$(document).ready(function() {

	});
</script>
<style>
#moveBtn a {
	width: 135px;
	margin-right: 10px;
	font-size: 20px;
	font-weight: bold;
}
</style>
</head>
<body>
<%@ include file="../chatBot/chatBot.jsp"%>
	<%@ include file="../common/header.jsp"%>

	<div id="main">
		<div class="page-heading">
			<div class="page-title">
				
				<div class="row">
					<%@ include file="../projectHome/sort.jsp"%>
				<div class="col-12 col-md-6 order-md-1" style="margin-top: 30px;">
						<span style="font-size: 40px; font-weight: bolder; color: red;">[${project.name }]
						</span> <span style="font-size: 40px; font-weight: bolder; color: black;">칸반보드</span>
						<p class="text-subtitle text-muted">진행중인 칸반을 확인하세요</p>
					</div>
	</div>

		
					
					<section class="section">
					
					<%@ include file="main2.jsp"%>
					
					</section>
					
					
					
				</div>
			</div>
		</div>
		
		
	</div>


</body>
</html>