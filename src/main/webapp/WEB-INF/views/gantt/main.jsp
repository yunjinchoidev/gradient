<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
<meta http-equiv="Content-type" content="text/html; charset=utf-8">
<title>GRADIENT - 간트차트</title>
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
		<div class="row">
		<div class="col-12 col-md-6 order-md-1 order-last">
						<span style="font-size: 40px; font-weight: bolder; color: red;">[${project.name }]
						</span> <span style="font-size: 40px; font-weight: bolder; color: black;">간트 차트</span>
						<p class="text-subtitle text-muted">진행중인 간트를 확인하세요</p>
					</div>
						</div>
					
					
					<div class="row">
					<%@ include file="main2.jsp"%>
					</div>
					
					
				</div>
			</div>
		</div>
	</div>
	
	
</body>