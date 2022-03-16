<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
<meta http-equiv="Content-type" content="text/html; charset=utf-8">
<title>Basic initialization</title>
<script src="/project5/gantt/codebase/dhtmlxgantt.js?v=7.1.9"></script>
<link rel="stylesheet"
	href="/project5/gantt/codebase/dhtmlxgantt.css?v=7.1.9">
<style>
#gantt_here {
	
}
</style>
</head>
<body>


	<h3>간트차트</h3>
	<p class="text-subtitle text-muted">For user to check they list</p>
	<div id="gantt_here"
		style='margin-left: 50px; margin-top: 100px; height: 1000px; width: 80%;'>
	</div>


	<script>
		gantt.init("gantt_here");

		gantt.parse({
			data : [ {
				id : 1,
				text : "Project #2",
				start_date : "01-04-2018",
				duration : 18,
				progress : 0.4,
				open : true
			}, {
				id : 2,
				text : "Task #1",
				start_date : "02-04-2018",
				duration : 8,
				progress : 0.6,
				parent : 1
			}, {
				id : 3,
				text : "Task #2",
				start_date : "11-04-2018",
				duration : 8,
				progress : 0.6,
				parent : 1
			} ],
			links : [ {
				id : 1,
				source : 1,
				target : 2,
				type : "1"
			}, {
				id : 2,
				source : 2,
				target : 3,
				type : "0"
			} ]
		});
	</script>
</body>