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
html, body {
	height: 1000px;
	padding: 0px;
	margin: 0px;
}
</style>
<script>
	$(document).ready(function() {
		$(".gantt_add").click(function() {
			alert("ddd");
		})
	})
</script>
</head>
<body>
	<div id="gantt_here" style='width: 100%; height: 1000px;'></div>





	<script>
		var tasks = {
			data : [ {
				id : "p_1",
				text : "Project #1",
				start_date : "01-04-2013",
				duration : 18,
				open : true
			}, {
				id : "t_1",
				text : "Task #1",
				start_date : "02-04-2013",
				duration : 8,
				parent : "p_1"
			}, {
				id : "t_2",
				text : "Task #2",
				start_date : "11-04-2013",
				duration : 8,
				parent : "p_1"
			} ]
		};

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

		// 삭제 D
		gantt.deleteTask(3);

		// 추가 // 모달창 띄우기 C
		/*
		var taskId = gantt.createTask({
			id : 12,
			text : "Task #99999",
			start_date : "02-09-2013",
			duration : 28
		}, "project_2", 2);
		 */
		var taskId2 = gantt.addTask({
			id : 10,
			text : "Task #77",
			start_date : "02-09-2013",
			duration : 28
		}, "project_2", 1);

		//추가 작업 C
		gantt.addTask({
			id : 7,
			text : "Task #6",
			start_date : "02-09-2013",
			duration : 28
		}, "pr_2");

		//조회 R
		console.log("조회" + gantt.getTask(7));

		// 싹다 불러오기 R
		console.log("리스트 뽑아오기")
		gantt.eachTask(function(task) {
			console.log(task.text);
		})

		// U //없데이트
		var task7777 = {
			id : 7,
			text : 'New task text gggggggggggggggggggggg',
			start_date : new Date(2022, 03, 02),
			end_date : new Date(2022, 03, 11),
			$source : 1,
			$target : 2
		}
		gantt.updateTask(7, task7777);
	</script>
</body>