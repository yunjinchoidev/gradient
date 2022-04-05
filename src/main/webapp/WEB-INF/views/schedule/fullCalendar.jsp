<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>캘린더</title>
<style>
#moveBtn a {
	width: 135px;
	margin-right: 10px;
	font-size: 20px;
	font-weight: bold;
}
</style>
<script src="/project5/a00_com/jquery.min.js"></script>
<script src="/project5/a00_com/jquery-ui.js"></script>
<script src="/project5/a00_com/popper.min.js"></script>
<script src="/project5/a00_com/bootstrap.min.js"></script>
<script src='/project5/a00_com/lib/main.js'></script>
<link rel="stylesheet" href="/project5/a00_com/jquery-ui.css">
<link rel="stylesheet" href="/project5/a00_com/bootstrap.min.css">
<link href='/project5/a00_com/lib/main.css' rel='stylesheet' />
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
    max-width: 1400px;
    margin: 0 auto;
  }

</style>


<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function() {
	
	
	var msg = "${msg}"
	
	if(msg=="insertCalendar"){
		location.href="/project5/calendar.do?projectkey=${project.projectkey}"
	}
	
	if(msg=="deleteCalendar"){
		location.href="/project5/calendar.do?projectkey=${project.projectkey}"
	}
	
	if(msg=="updateCalendar"){
		location.href="/project5/calendar.do?projectkey=${project.projectkey}"
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
    var calendarEl = document.getElementById('calendar');

    var calendar = new FullCalendar.Calendar(calendarEl, {
      headerToolbar: {
        left: 'prev,next today',
        center: 'title',
        right: 'dayGridMonth,timeGridWeek,timeGridDay'
      },
      initialDate: '2022-04-10',
      navLinks: true, // can click day/week names to navigate views
      selectable: true,
      selectMirror: true,
      select: function(arg) {
    	console.log("#일정등록시 속성 확인#")
    	console.log(arg)
    	$("#exampleModalLongTitle").text("일정등록");
    	$("#regBtn").show();
    	$("#uptBtn").hide();
    	$("#delBtn").hide();
    	$("#frm01")[0].reset(); // 상세데이터 확인 후, 다시 등록할 때, 초기화가 필요..
    	
    	
    	$("#modalBtn").click(); 
    	// 이벤트가 강제 수행하여 모달창이 로딩되도록 한다.

    	console.log("시작일:"+arg.start.toLocaleString())
    	console.log("마지막일:"+arg.end.toLocaleString())
    	console.log("종일여부:"+arg.allDay)
    	// 클릭시, 가져온 속성값을 화면에 기본적으로 로딩할 수 있게 처리..
    	//$("[name=start]").val(arg.start.toISOString().split("T")[0])
    	// fullcanlendar에서는 표준형식을 출력을 처리하게 한다.
    	$("[name=start]").val(arg.start.toISOString())
    	//$("[name=end]").val(arg.end.toISOString().split("T")[0])
    	$("[name=end]").val(arg.end.toISOString())
    	$("[name=allDay]").val(""+arg.allDay)
        /*
    	var title = prompt('일정등록:');
    	
        if (title) {
          calendar.addEvent({
            title: title, // 타이틀
            start: arg.start, // 시작일자
            end: arg.end,	// 마지막일짜
            allDay: arg.allDay // 종일여부
          })
        }
        */
        
        calendar.unselect()
      },
      
   		
      
      
      
      
      
      
      
      
      // 조회
      eventClick: function(arg) {
    	  console.log(arg.event)
		  formData(arg.event);	      
    	  $("#exampleModalLongTitle").text("일정상세");
    	  $("#regBtn").hide();
    	  $("#uptBtn").show();
    	  $("#delBtn").show();
    	  $("#modalBtn").click(); 
      },


      
      
      
      
      
      
      
      
      
      
      //  수정
      eventDrop:function(info){
    	  formData(info.event);
		  $("#frm01").attr("action","${path}/updateCalendar.do");
    	  $("#frm01").submit();
      },
      
      
      
      // 수정
      eventResize:function(info){
    	  formData(info.event);
		  $("#frm01").attr("action","${path}/updateCalendar.do");
    	  $("#frm01").submit();
      },	      
      editable: true,
      dayMaxEvents: true, // allow "more" link when too many events
      
      
      
      
      //리스트
      events: function(info, successCallback,failureCallback){
    	  // 서버에 있는 json 데이터 가져와서, fullcalenar 입력하기
    	  $.ajax({
    		  type:"post",
    		  url:"${path}/getCalendarListWithProjectkey.do?projectkey=${project.projectkey}",
    		  dataType:"json",
    		  success:function(data){
    			  console.log(data.calList)
    			  successCallback(data.calList);
    			  document.getElementById('script-warning').style.display = 'none';
    		  },
    		  error:function(err){
    			  console.log(err)
    			  failureCallback(err);
    			  document.getElementById('script-warning').style.display = 'block';
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
      loading: function(bool) {
          document.getElementById('loading').style.display =
            bool ? 'block' : 'none';
      }
    });
    calendar.setOption('themeSystem', "Bootstrap 5");
    calendar.render();
    
  });
  
  
  
  
  
  
  function formData(event){
      $("[name=id]").val(event.id)
      $("[name=title]").val(event.title)
      // 내용을 기본 속성이 아니기에 extendedProps에 들어가 있다.
      $("[name=content]").val(event.extendedProps.content)
      $("[name=start]").val(event.start.toISOString())
	  $("[name=end]").val(event.end.toISOString())
      $("[name=borderColor]").val(event.borderColor)
      $("[name=backgroundColor]").val(event.backgroundColor)
      $("[name=textColor]").val(event.textColor)
	  $("[name=allDay]").val(""+event.allDay)	  
  }

  
  
  
  
  
  

	$(document).ready(function(){
		$('[data-toggle="tooltip"]').tooltip();
		
		
		
		// 등록 버튼
		$("#regBtn").click(function(){
			if(confirm("일정등록하시겠습니까?")){
				$("#frm01").attr("action","${path}/insertCalendar.do");
				$("#frm01").submit();
			}		
		});
		
		
		
		
		// 수정 버튼
		$("#uptBtn").click(function(){
			if(confirm("일정수정하시겠습니까?")){
				$("#frm01").attr("action","${path}/updateCalendar.do");
				$("#frm01").submit();
			}		
		});	
		
		
		
		// 삭제 버튼
		$("#delBtn").click(function(){
			if(confirm("일정삭제하시겠습니까?")){
				$("#frm01").attr("action","${path}/deleteCalendar.do");
				$("#frm01").submit();
			}		
		});			
	});
</script>




</head>






<body>
	<%@ include file="../common/header.jsp"%>

	<div id="main">
		<div class="page-heading">
			<div class="page-title">
			
						<div class="buttons" id="moveBtn" style="padding: 20px;">
		<a href="/project5/dashBoard.do?projectkey=${project.projectkey }"
			class="btn btn-secondary" onclick="alert('${project.projectkey } : ${project.name } 이 유지됩니다.')">대시보드</a> 
			<a
			href="/project5/projectHome.do?projectkey=${project.projectkey }" class="btn btn-dark"
			 >프로젝트
			홈</a> 
			<a href="/project5/kanbanMain.do?projectkey=${project.projectkey }"
			class="btn btn-danger" >칸반보드</a> <a
			href="/project5/ganttMain.do?projectkey=${project.projectkey }"
			class="btn btn-warning" >간트차트</a> <a
			href="/project5/calendar.do?projectkey=${project.projectkey }"
			class="btn btn-success" >캘린더</a> <a
			href="/project5/cost.do?projectkey=${project.projectkey }"
			class="btn btn-primary">예산 관리</a> <a
			href="/project5/qualityList.do?projectkey=${project.projectkey }"
			class="btn btn-dark">품질 관리</a> <a
			href="/project5/attendanceMain.do?projectkey=${project.projectkey }"
			class="btn btn-secondary">팀 관리</a> <a
			href="/project5/minutes.do?method=list&projectkey=${project.projectkey }"
			class="btn btn-danger">회의록</a> <a
			href="/project5/chatting.do?projectkey=${project.projectkey }"
			class="btn btn-warning">채팅</a> <a
			href="/project5/output.do?projectkey=${project.projectkey }"
			class="btn btn-success">산출물 관리</a> <a
			href="/project5/risk.do?projectkey=${project.projectkey }"
			class="btn btn-primary">리스크 관리</a> <a
			href="/project5/procuSituationMain.do?projectkey=${project.projectkey }"
			class="btn btn-secondary">조달 관리</a>
	</div>
	<hr>
					<div class="col-12 col-md-6 order-md-1 order-last">
						<span style="font-size: 40px; font-weight: bolder; color: red;">[${project.name }]
						</span> <span style="font-size: 40px; font-weight: bolder; color: black;">캘린더</span>
						<p class="text-subtitle text-muted">캘린더를 확인하세요</p>
					</div>
					
					
					
								<section class="section">
								
									<div id='calendar' style="margin-top: 30px;"></div>
								
								</section>
				</div>
			</div>
		</div>
	



<div id='loading'>loading...</div>
<div id='script-warning'>
    <code>서버</code> must be running.
</div>  
<%--
	$("#modalBtn").click(); // 강제 수행하여 모달창이 로딩되도록 한다.
 --%>
<button id="modalBtn" data-toggle="modal" 
	data-target="#exampleModalCenter" style="display:none"></button>








<div class="modal fade" id="exampleModalCenter" 
	tabindex="-1" role="dialog" 
	aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">일정등록</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      
      
      
		<form id="frm01" class="form" method="post" enctype="multipart/form-data" >
		 <input type="hidden" name="id" value="0"/>
		 
	        <input type="hidden" name="projectkey" value="${project.projectkey}" >
	        <input type="hidden" class="form-control" placeholder="" name="memberkey" value="${member.memberkey }" >
	     
	     <div class="row">
	      <div class="col">
	        <input type="text" class="form-control" placeholder="${project.name }">
	      </div> 
	     </div>
	     
	     <div class="row">
	      <div class="col">
	        <input type="text" class="form-control" placeholder="제목" name="title">
	      </div> 
	     </div>
	     
	     <div class="row">	     
	      <div class="col">
	        <input type="text" class="form-control" 
	        	data-toggle="tooltip" data-placement="buttom" title="시작일"
	         name="start" readonly>
	      </div>
	      <div class="col">
	        <input type="text" class="form-control" 
	        	data-toggle="tooltip" data-placement="buttom" title="종료일"
	         name="end" readonly>
	      </div>
	      
	      
	      
	     </div>
	     <div class="row">	     
	      <div class="col">
	      	<textarea  class="form-control" name="content"
	      		 placeholder="내용" 
	      		 cols="10" rows="10"></textarea>
	      </div>
	     </div>
	     <div class="row">	  
	      <div class="col">
	        <input type="color"
	        	data-toggle="tooltip" data-placement="buttom" title="배경색상"  value="#0099cc"
	         		class="form-control" name="backgroundColor">
	      </div>

	      <div class="col">
	        <input type="color" class="form-control" 
	        	data-toggle="tooltip" data-placement="buttom" title="글자색상"  value="#ccffff"
	        name="textColor">
	      </div>
	     </div>
	     <div class="row">	
	      <div class="col">
	        <input type="color" class="form-control" 
	        	data-toggle="tooltip" data-placement="buttom" title="테두리색상" value="#4b0082"
	        name="borderColor">
	      </div>	       
	      <div class="col">
	      	<select name="allDay"  class="form-control" data-toggle="tooltip" data-placement="buttom" title="종일여부">
	      		<option value="true">종 일</option>
	      		<option value="false">시 간</option>
	      	</select>
	      </div>
	     </div>

						<div class="row">
							<div class="col-lg-12">
								<div class="panel panel-default">
								<br>
									<div class="panel-heading">File Attach</div>
									<!-- /.panel-heading -->
									<div class="panel-body">
										<div class="form-group uploadDiv">
											<input type="file" name='uploadFile' multiple>
										</div>
										<div class='uploadResult'>
											<ul>
											</ul>
										</div>
									</div>
									<!--  end panel-body -->
								</div>
								<!--  end panel-body -->
							</div>
							<!-- end panel -->
						</div>
						<!-- /.row -->

	    </form> 
	 	<script>
	      		
	    </script>   
      </div>
      <div class="modal-footer">

        <button type="button" id="regBtn" class="btn btn-primary">일정등록</button>
        <button type="button" id="uptBtn" class="btn btn-info">일정수정</button>
        <button type="button" id="delBtn" class="btn btn-danger">일정삭제</button>
         <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>       
      </div>
    </div>
  </div>
</div>

<div>
	<br><br><br><br><br><br><br><br>
</div>



























	</div>
</body>
</html>