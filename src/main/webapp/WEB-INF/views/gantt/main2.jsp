<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
<meta http-equiv="Content-type" content="text/html; charset=utf-8">
<title>Basic initialization</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
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
</head>
<body>

	<script>
		$(document).ready(function() {
									var list;

									// 간트차트 리스트 불러오기
									$.ajax({type : "post",
										url : "/project5/ganttList.do",
										async : false,
										dataType : "json",
										success : function(result) {
											console.log("간트 차트 리스트를 불러오는 데 성공했습니다.");
											list = result.list;
										},
										error : function(result) {
											console.log("간트 차트 리스트를 불러오는 데 실패했습니다.");
										}
									})

									console.log("list : " + list)
									for (idx in list) {
										console.log(idx + ": " + list[idx].id + ", "+ list[idx].text);
									}

									// 간트 차트 불러오기
									gantt.init("gantt_here");
									gantt.parse({
										data : list
									});

									$(".gantt_add").click(function() {
										alert("추가 창을 엽니다.");
									})
		
									$("#addBtn").click(function() {
										alert("정말 추가하시겠습니까?")
										$(".modal").modal('show');
										$("#addItem").show();
										$("#removeItem").hide();
										$("#updateItem").hide();
		
									})

									$("#addItem").click(function() {
										confirm("정말 추가하시겠습니까?")
										$("#frm01").attr("action","/project5/ganttInsert.do");
										$("#frm01").submit();
									});

									$("#removeItem").click(function() {
										confirm("정말 삭제하시겠습니까?")
										$("#frm01").attr("action","/project5/ganttDelete.do");
										$("#frm01").submit();
									});

									$("#updateItem").click(function() {
										confirm("정말 수정하시겠습니까?")
										$("#frm01").attr("action","/project5/ganttUpdate.do");
										$("#frm01").submit();
									});

							gantt.attachEvent("onTaskDblClick",
									function(id, e) {
										alert("간트 하나 더블 클릭")
										return true;
									});

											gantt.attachEvent("onTaskClick",function(id, e) {
												alert("간트 하나 클릭")
												console.log(id);
												console.log(e);
												$("[name=id]").val(gantt.getTask(id).id);
												$("[name=text]").val(gantt.getTask(id).text);
												$("[name=start_date]").val(	formatDate(gantt.getTask(id).start_date));
												$("[name=duration]").val(gantt.getTask(id).duration);
												$("#addItem").hide();
												$("#removeItem").show();
												$("#updateItem").show();
												$(".modal").modal('show');
												return true;
											});
							
							

							function formatDate(date) {

								var d = new Date(date),

								month = '' + (d.getMonth() + 1), day = ''
										+ d.getDate(), year = d.getFullYear();

								if (month.length < 2)
									month = '0' + month;
								if (day.length < 2)
									day = '0' + day;

								return [ year, month, day ].join('-');

							}

											// 간트 드래그 이동
											gantt.attachEvent("onTaskDrag",
											function(id, mode, task, original) {
												console.log("-------------");
												console.log(id);
												$("[name=id]").val(gantt.getTask(id).id);
												$("[name=text]").val(gantt.getTask(id).text);
												$("[name=start_date]").val(formatDate(gantt.getTask(id).start_date));
												$("[name=duration]").val(gantt.getTask(id).duration);
												$("#frm01").attr("action","/project5/ganttUpdate.do");
												$("#frm01").submit();
											});

							var psc = "${psc}";
							if (psc == "add") {
								alert("성공적으로 추가 되었습니다.")
							}
							;
							if (psc == "update") {
								alert("성공적으로 수정 되었습니다.")
							}
							;
							if (psc == "move") {
								alert("성공적으로 이동 되었습니다.")
							}
							;
							if (psc == "delete") {
								alert("성공적으로 삭제되었습니다.")
							}
							;
						})
	</script>


	<a href="#" class="btn btn-danger" id="addBtn">추가 </a>
	<a href="#" class="btn btn-danger" id="getItems">모든 정보 얻기</a>
	<br>
	<br>
	<div id="gantt_here" style="width: 100%; height: 1000px; margin-top: 40px;"></div>






	<!-- 모달 -->
	<div class="modal fade text-left" id="inlineForm" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel33" aria-hidden="true">
		<div
			class="modal-dialog modal-dialog-centered modal-dialog-scrollable"
			role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="myModalLabel33">간트 차트</h4>
					<button type="button" class="close" data-bs-dismiss="modal"
						aria-label="Close">
						<i data-feather="x"></i>
					</button>
				</div>


				<form action="#" id="frm01">
				
					<input type="hidden" name="projectkey" value="1"> <input
						type="hidden" name="memberkey" value="1">
						
					<div class="modal-body">

						<label>id </label>
						<div class="form-group">
							<input type="number" name="id" class="form-control">
						</div>

						<label>text(내용): </label>
						<div class="form-group">
							<input type="text" name="text" class="form-control">
						</div>

						<label>start_date: </label>
						<div class="form-group">
							<input type="date" name="start_date" class="form-control">
						</div>


						<label>duration: </label>
						<div class="form-group">
							<input type="number" name="duration" class="form-control">
						</div>
					</div>














					<div class="modal-footer">
						<button type="button" class="btn btn-light-secondary"
							data-bs-dismiss="modal">
							<i class="bx bx-x d-block d-sm-none"></i> <span
								class="d-none d-sm-block">Close</span>
						</button>
						<button type="button" class="btn btn-primary ml-1 add"
							data-bs-dismiss="modal" id="addItem">
							<i class="bx bx-check d-block d-sm-none"></i> <span
								class="d-none d-sm-block">추가</span>
						</button>
						<button type="button" class="btn btn-danger ml-2 update"
							data-bs-dismiss="modal" id="updateItem">
							<i class="bx bx-check d-block d-sm-none"></i> <span
								class="d-none d-sm-block">수정</span>
						</button>
						<button type="button" class="btn btn-warning ml-2 delete"
							data-bs-dismiss="modal" id="removeItem">
							<i class="bx bx-check d-block d-sm-none"></i> <span
								class="d-none d-sm-block">삭제</span>
						</button>
					</div>
				</form>
			</div>
		</div>
	</div>








</body>



































