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
<meta charset="UTF-8">
<title>풀 캘린더</title>

<link rel="stylesheet" href="${path}/a00_com/bootstrap.min.css">
<link rel="stylesheet" href="${path}/a00_com/jquery-ui.css">
<link href='${path}/a00_com/lib/main.css' rel='stylesheet' />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css"
	rel="stylesheet">

<style>
body {
	margin: 40px 10px;
	padding: 0;
	font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
	font-size: 14px;
}

#calendar {
	max-width: 1100px;
	margin: 0 auto;
}
</style>
<script src="${path}/a00_com/jquery.min.js"></script>
<script src="${path}/a00_com/popper.min.js"></script>
<script src="${path}/a00_com/bootstrap.min.js"></script>
<script src="${path}/a00_com/jquery-ui.js"></script>
<script src='${path}/a00_com/lib/main.js'></script>



<script type="text/javascript">
	document
			.addEventListener(
					'DOMContentLoaded',
					function() {
						var calendarEl = document.getElementById('calendar');

						var calendar = new FullCalendar.Calendar(
								calendarEl,
								{
									headerToolbar : {
										left : 'prev,next today',
										center : 'title',
										right : 'dayGridMonth,timeGridWeek,timeGridDay'
									},
									initialDate : '2022-03-17',
									navLinks : true, // can click day/week names to navigate views
									selectable : true,
									selectMirror : true,
									select : function(arg) {
										var title = prompt('일정등록:');
										if (title) {
											calendar.addEvent({
												title : title,
												start : arg.start,
												end : arg.end,
												allDay : arg.allDay
											})
										}
										calendar.unselect()
									},
									eventClick : function(arg) {
										if (confirm('Are you sure you want to delete this event?')) {
											arg.event.remove()
										}
									},
									editable : true,
									dayMaxEvents : true, // allow "more" link when too many events
									events : function(info, successCallback,
											failureCallback) {
										// 서버에 있는 json 데이터 가져와서, fullcalenar 입력하기
										$
												.ajax({
													type : "post",
													url : "${path}/calList.do",
													dataType : "json",
													success : function(data) {
														console
																.log(data.calList)
														successCallback(data.calList);
														document
																.getElementById('script-warning').style.display = 'none';
													},
													error : function(err) {
														console.log(err)
														failureCallback(err);
														document
																.getElementById('script-warning').style.display = 'block';
													}
												});
									},
									/*
									events: {
									  url: 'php/get-events.php', // controller에서 ajax데이터를 로딩하여 처리..
									    failure: function() {
									      document.getElementById('script-warning').style.display = 'block'
									    } 
									}, */
									loading : function(bool) {
										document.getElementById('loading').style.display = bool ? 'block'
												: 'none';
									}
								});
						calendar.setOption('themeSystem', "Bootstrap 5");
						calendar.render();
					});

	$(document)
			.ready(
					function() {
<%-- 
      events: {
        url: 'php/get-events.php',
        failure: function() {
          document.getElementById('script-warning').style.display = 'block'
        }
      },
      loading: function(bool) {
        document.getElementById('loading').style.display =
          bool ? 'block' : 'none';
      }
      //   <div id='loading'>loading...</div>
      /*
		  <div id='script-warning'>
		    <code>php/get-events.php</code> must be running.
		  </div>      
      */		
		--%>
	});
</script>
</head>

<body>

	<div id='calendar'></div>
	<div id='loading'>loading...</div>
	<div id='script-warning'>
		<code>서버</code>
		must be running.
	</div>

	<div class="modal fade" id="exampleModalCenter" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalCenterTitle"
		aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLongTitle">타이틀</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form id="frm02" class="form" method="post">
						<div class="row">
							<div class="col">
								<input type="text" class="form-control" placeholder="사원명 입력"
									name="ename">
							</div>
							<div class="col">
								<input type="text" class="form-control" placeholder="직책명 입력"
									name="job">
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary">Save changes</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>