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
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>

<script>
	$(document).ready(function() {
		$(".gantt_add").click(function() {
			alert("추가 창을 엽니다.r");
			
		})
	})
</script>
</head>
<body>
	<h2 id="addBtn">추가</h2>
	<h2 id="delBtn">삭제</h2>
	<div id="gantt_here" style='width: 100%; height: 1000px;'></div>


	<script>
	$(document).click(function(){
		
		$("#addBtn").click(function(){
			confirm("정말 추가하시겠습니까?")
			var taskId2 = gantt.addTask({
			id : 15,
			text : "Task #77ggggggggggggggggggggggggggggg",
			start_date : "02-09-2013",
			duration : 28
		}, "project_2", 1);
		})
		
		$("#delBtn").click(function(){
			confirm("정말 삭제하시겠습니까?")
			// 삭제 D
			gantt.deleteTask(3);
		
		});
		
		
		
		
	})
	
	
	
	
	
	</script>

	



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

	

		// 추가 // 모달창 띄우기 C
		/*
		var taskId = gantt.createTask({
			id : 12,
			text : "Task #99999",
			start_date : "02-09-2013",
			duration : 28
		}, "project_2", 2);
		 */
		
		 $(".gantt_save_btn_set").click(function(){
				 console.log("정말 추가하시겠습니까?")
				gantt.message("The task is updated");
			 })

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

		// 싹다 불러오기 R///////////////////////////////////////////////////////////////////
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