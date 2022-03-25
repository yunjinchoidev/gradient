<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title id='Description'>Kanban Board.</title>
<link rel="stylesheet"
	href="/project5/jqwidgets-ver13.2.0/jqwidgets/styles/jqx.base.css"
	type="text/css" />
<script type="text/javascript"
	src="/project5/jqwidgets-ver13.2.0/scripts/jquery-1.11.1.min.js"></script>
<script type="text/javascript"
	src="/project5/jqwidgets-ver13.2.0/jqwidgets/jqxcore.js"></script>
<script type="text/javascript"
	src="/project5/jqwidgets-ver13.2.0/jqwidgets/jqxsortable.js"></script>
<script type="text/javascript"
	src="/project5/jqwidgets-ver13.2.0/jqwidgets/jqxkanban.js"></script>
<script type="text/javascript"
	src="/project5/jqwidgets-ver13.2.0/jqwidgets/jqxdata.js"></script>
<script type="text/javascript">
	$(document).ready(function() {

	});
</script>
</head>
<body>
<%@ include file="../chatBot/chatBot.jsp"%>
	<%@ include file="../common/header.jsp"%>

	<div id="main">
		<div class="page-heading">
			<div class="page-title">
				<div class="row">
					<%@ include file="../projectHome/sort.jsp"%>
					<%@ include file="main2.jsp"%>
				</div>
			</div>
		</div>

	</div>


</body>
</html>