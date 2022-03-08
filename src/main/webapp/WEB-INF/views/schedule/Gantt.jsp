<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"
   "http://www.w3.org/TR/html4/strict.dtd">

<html lang="en">
<head>
	<link rel="stylesheet" type="text/css" href="/project5/jquery.ganttView-master/lib/jquery-ui-1.8.4.css" />
	<link rel="stylesheet" type="text/css" href="/project5/jquery.ganttView-master/example/reset.css" />
	<link rel="stylesheet" type="text/css" href="/project5/jquery.ganttView-master/jquery.ganttView.css" />
	<style type="text/css">
		body {
			font-family: tahoma, verdana, helvetica;
			font-size: 0.8em;
			padding: 10px;
		}
	</style>
	<title>jQuery Gantt</title>
</head>
<body>


	<%@ include file="../common/header.jsp"%>

	<div id="ganttChart" style="margin-left: 300px;"></div>
	<br/><br/>
	<div id="eventMessage"></div>

	<script type="text/javascript" src="/project5/jquery.ganttView-master/lib/jquery-1.4.2.js"></script>
	<script type="text/javascript" src="/project5/jquery.ganttView-master/lib/date.js"></script>
	<script type="text/javascript" src="/project5/jquery.ganttView-master/lib/jquery-ui-1.8.4.js"></script>
	<script type="text/javascript" src="/project5/jquery.ganttView-master/jquery.ganttView.js"></script>
	<script type="text/javascript" src="/project5/jquery.ganttView-master/example/data.js"></script>
	<script type="text/javascript">
		$(function () {
			$("#ganttChart").ganttView({ 
				data: ganttData,
				slideWidth: 900,
				behavior: {
					onClick: function (data) { 
						var msg = "You clicked on an event: { start: " + data.start.toString("M/d/yyyy") + ", end: " + data.end.toString("M/d/yyyy") + " }";
						$("#eventMessage").text(msg);
					},
					onResize: function (data) { 
						var msg = "You resized an event: { start: " + data.start.toString("M/d/yyyy") + ", end: " + data.end.toString("M/d/yyyy") + " }";
						$("#eventMessage").text(msg);
					},
					onDrag: function (data) { 
						var msg = "You dragged an event: { start: " + data.start.toString("M/d/yyyy") + ", end: " + data.end.toString("M/d/yyyy") + " }";
						$("#eventMessage").text(msg);
					}
				}
			});
			
			// $("#ganttChart").ganttView("setSlideWidth", 600);
		});
	</script>

</body>
</html>
