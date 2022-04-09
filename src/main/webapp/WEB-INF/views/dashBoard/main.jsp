<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
</head>


<style>
</style>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
$(document).ready(function(){
	
	var ch = "${member.memberkey}";
	if (ch==""){
		alert("미 로그인 시 접근 불가합니다.")
		location.href="/project5/main.do"
	}
	
	$("#progress").click(function(){
		alert("프로젝트 진행 상태를 바꾸시겠습니까?");
		$(".modal").modal('show');
		
	})
	
		var memberkey;
	// ajax를 통한 파일 정보 불러오기 
	// 페이지 접속시 자동으로 실행
	var memberkeyValue =parseInt("${member.memberkey}");
	  console.log(memberkey);
	 var data = { memberkey : memberkeyValue};
	 // 업로드 파일 결과 가져오기
    $.ajax({
      url: '/project5/myfaceData.do',
      data: data,
      type: 'POST',
      dataType:'json',
        success: function(result){
          console.log(result); 
          console.log("파일 불러오기 완료")
          console.log(result.myfaceData[0]); 
		  showUploadResult2(result.myfaceData[0]);//이곳에서 함수 호출 
      },
      error: function(result){
    	  console.log(memberkey)
          console.log("회원 이미지 정보 불러오기 실패");
          console.log(result); 
      }
    }); //$.ajax
    
    
    
    
	// 이미지 클라리언트 딴에 띄우는 합수
	// 외래키 없이 업로드 한 파일 결과 클라이언트 단으로 가져오기 함수
  function showUploadResult2(uploadResultArr){
	    if(!uploadResultArr || uploadResultArr.length == 0){ return; }
	    var uploadUL = $("#myface");
	    var str ="";
	    $(uploadResultArr).each(function(i, obj){
	    		console.log("obj"+obj);
				var fileCallPath =  encodeURIComponent(obj.fname);
				console.log(fileCallPath);
				str = "<img src='/project5/display2.do?fileName="+fileCallPath+"'>";
				console.log("str"+str)
			})
	    uploadUL.append(str); // 추가해주기
	  }
///////////////////////////////////////////////////////////////
	
	
	
	console.log("${member.pricing}")
	if ("${member.pricing}"=='0'){
			$("#openbox1").hide();
			$("#openbox2").hide();
			$("#openbox3").hide();
	}else if("${member.pricing}"=='1'){
		$("#openbox1").show();
		$("#openbox2").hide();
		$("#openbox3").hide();
	}else {
		$("#openbox1").show();
		$("#openbox2").show();
		$("#openbox3").show();
	}
	
	
	
	
})

</script>


<body>

	<%@ include file="../chatBot/chatBot.jsp"%>
	<%@ include file="../common/header.jsp"%>

	<div id="main">


		<div class="page-heading">
			<div class="page-title">
				<div class="row">
					
						<%@ include file="../projectHome/sort.jsp"%>
					
					
					
					<!--  
					<div class="col-12 col-md-6 order-md-1 order-last">
						<span style="font-size: 40px; font-weight: bolder; color: red;">[${project.name }]
						</span> <span style="font-size: 40px; font-weight: bolder; color: black;">대시보드</span>
						<p class="text-subtitle text-muted"></p>
					</div>
					-->
				</div>
			</div>
		</div>





		<header class="mb-3">
			<a href="#" class="burger-btn d-block d-xl-none"> <i
				class="bi bi-justify fs-3"></i>
			</a>
		</header>

		<div class="page-heading">
			<h3>
				<span style="color: red;"> [${project.name }] </span> 대시보드
			</h3>
			<h5>
				<span style="color: red">"${member.name }${member.auth }"</span>님
				어서오십시오.
			</h5>
			<h5>이곳에서 프로젝트 진행사항을 전반적으로 점검하십시오.</h5>
		</div>


		<div class="page-content">
		
			<section class="row">
				<div class="col-12 col-lg-8">
					<div class="row">
						<div class="col-6 col-lg-3 col-md-6">
							<div class="card">
								<div class="card-body px-3 py-4-5">
									<div class="row">
										<div class="col-md-4">
											<div class="stats-icon purple">
												<i class="iconly-boldShow"></i>
											</div>
										</div>
										<div class="col-md-8">
											<h6 class="text-muted font-semibold">나의 작업물 수</h6>
											<h6 class="font-extrabold mb-0">${outputCnt }건</h6>
										</div>
									</div>
								</div>
							</div>
						</div>

						<div class="col-6 col-lg-3 col-md-6">
							<div class="card">
								<div class="card-body px-3 py-4-5">
									<div class="row">
										<div class="col-md-4">
											<div class="stats-icon blue">
												<i class="iconly-boldProfile"></i>
											</div>
										</div>
										<div class="col-md-8">
											<h6 class="text-muted font-semibold">오늘 해야할 일</h6>
											<h6 class="font-extrabold mb-0">${calendarCountBelongTodayCnt}
												건</h6>
										</div>
									</div>
								</div>
							</div>
						</div>

						<div class="col-6 col-lg-3 col-md-6">
							<div class="card">
								<div class="card-body px-3 py-4-5">
									<div class="row">
										<div class="col-md-4">
											<div class="stats-icon green">
												<i class="iconly-boldAdd-User"></i>
											</div>
										</div>
										<div class="col-md-8">
											<h6 class="text-muted font-semibold">프로젝트 종료일</h6>
											<h6 class="font-extrabold mb-0" id="go">
												<fmt:formatDate value="${project.lastdate }" />
											</h6>
											<script>
											$(document).ready(function(){
												var i=0;
												
												
												setInterval(function() {
													i++;
														if(i%2==0){
															  $("#go").css("color","red");
														}else{
															 $("#go").css("color","black");
														}
												}, 1000);

											})
											</script>

										</div>
									</div>
								</div>
							</div>
						</div>

						<div class="col-6 col-lg-3 col-md-6">
							<div class="card">
								<div class="card-body px-3 py-4-5">
									<div class="row">
										<div class="col-md-4">
											<div class="stats-icon red">
												<i class="iconly-boldBookmark"></i>
											</div>
										</div>
										<div class="col-md-8">
											<h6 class="text-muted font-semibold">가장 긴급한 일</h6>
											<h6 class="font-extrabold mb-0">${EmergencyCalendarTask.title}</h6>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-6 col-lg-3 col-md-6">
							<div class="card">
								<div class="card-body px-3 py-4-5">
									<div class="row">
										<div class="col-md-4">
											<div class="stats-icon red">
												<i class="iconly-boldBookmark"></i>
											</div>
										</div>
										<div class="col-md-8">
											<h6 class="text-muted font-semibold">현 프로젝트 단계</h6>
											<h6 class="font-extrabold mb-0" id="progress">${project.progress}</h6>
											<script>
											$(document).ready(function(){
												var i=0;
												setInterval(function() {
													i++;
														if(i%2==0){
															  $("#progress").css("color","blue");
														}else{
															 $("#progress").css("color","black");
														}
												}, 500);

											})
											</script>
										</div>
									</div>
								</div>
							</div>
						</div>



						<div class="col-6 col-lg-3 col-md-6 " id="openbox1">
							<div class="card">
								<div class="card-body px-3 py-4-5">
									<div class="row">
										<div class="col-md-4">
											<div class="stats-icon red">
												<i class="iconly-boldBookmark"></i>
											</div>
										</div>
										<div class="col-md-8" style="cursor: pointer;"
										onclick='window.open("/project5/memoList.do", 
												"PopupWin","width=800,height=800");'>
											<h6 class="text-muted font-semibold">메모장 열기</h6>
											<h6 class="font-extrabold mb-0">클릭시 오픈</h6>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-6 col-lg-3 col-md-6" id="openbox2">
							<div class="card">
								<div class="card-body px-3 py-4-5">
									<div class="row">
										<div class="col-md-4">
											<div class="stats-icon red">
												<i class="iconly-boldBookmark"></i>
											</div>
										</div>
										<div class="col-md-8">
											<h6 class="text-muted font-semibold">개방2</h6>
											<h6 class="font-extrabold mb-0">개방2</h6>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-6 col-lg-3 col-md-6" id="openbox3">
							<div class="card">
								<div class="card-body px-3 py-4-5">
									<div class="row">
										<div class="col-md-4">
											<div class="stats-icon red">
												<i class="iconly-boldBookmark"></i>
											</div>
										</div>
										<div class="col-md-8">
											<h6 class="text-muted font-semibold">개방3</h6>
											<h6 class="font-extrabold mb-0">개방3</h6>
										</div>
									</div>
								</div>
							</div>
						</div>








					</div>






					<div class="row">
						<div class="col-12">
							

							<div class="card">
								<div class="card-header">
									<h4>산출물 분포 상황</h4>
								</div>
								<div class="card-body">
									<div id="chart_div" style="height: 400px;"></div>
								</div>
							</div>

							<!-- 막대 차트 -->
							<script>
									$(document).ready(function(){
									// 산출물	
											var outputSortCnt = [] 
											var outputSortCntByMemberkey = [] 
											var worksortList = [] 
											var memberkey = "${member.memberkey}"
											var data = {memberkey : memberkey};
											
											$.ajax({
												      url: '/project5/outputSortCnt.do',
												      type: 'POST',
												      async:false,
												      data : data,
												      dataType:'json',
												        success: function(result){
												         console.log("==============================")
												         console.log(result)
												         console.log("outputSortCntByMemberkey")
												         console.log("==============================")
												        	for(var i=0; i<11; i++){
												        	  if(result.outputSortCnt[i] ==null){
												        		  outputSortCnt[i] = 0
												        	  }else{
												        		  outputSortCnt[i] = result.outputSortCnt[i].count;
												        	  }
												         }
												          
												          for(var i=0; i<11; i++){
												        	  if(result.outputSortCntByMemberkey[i] == null){
												        		  outputSortCntByMemberkey[i] = 0
												        	  }else{
												        		  outputSortCntByMemberkey[i] =result.outputSortCntByMemberkey[i].count;
												        	  }
												          }
												          
												          for(var i=0; i<11; i++){
												        	  worksortList[i] = result.worksortList[i].title;
												          }
												          console.log(" outputSortCnt 완료")
												      },
												      error: function(result){
												          console.log("outputSortCnt 실패");
												          console.log(result); 
												      }
												    }); //$.ajax			
												    
												    
												    console.log("outputSortCnt : :::::=====" +outputSortCnt)
												    console.log("workSortList : ::::=====" +worksortList)
												    console.log("outputSortCntByMemberkey : ::::=====" +outputSortCntByMemberkey)
												 
												    
												  google.charts.load('current', {'packages':['corechart']});
										    	  google.charts.setOnLoadCallback(drawChart);
									
											      function drawChart() {
											        var data = google.visualization.arrayToDataTable([
											          ['Director (Year)',  'Rotten Tomatoes', 'IMDB'],
											          [worksortList[0],outputSortCnt[0],         outputSortCntByMemberkey[0]],
											          [worksortList[1],outputSortCnt[1],         outputSortCntByMemberkey[1]],
											          [worksortList[2],outputSortCnt[2],         outputSortCntByMemberkey[2]],
											          [worksortList[3],outputSortCnt[3],         outputSortCntByMemberkey[3]],
											          [worksortList[4],outputSortCnt[4],         outputSortCntByMemberkey[4]],
											          [worksortList[5],outputSortCnt[5],         outputSortCntByMemberkey[5]],
											          [worksortList[6],outputSortCnt[6],         outputSortCntByMemberkey[6]],
											          [worksortList[7],outputSortCnt[7],         outputSortCntByMemberkey[7]],
											          [worksortList[8],outputSortCnt[8],         outputSortCntByMemberkey[8]],
											          [worksortList[9],outputSortCnt[9],         outputSortCntByMemberkey[9]],
											          [worksortList[10],outputSortCnt[10],         outputSortCntByMemberkey[10]]
											        ]);
											        var options = {
											          title: '전체 산출물, 개인 산출물',
											          vAxis: {title: '작업 분류'},
											          isStacked: true
											        };
											        var chart = new google.visualization.SteppedAreaChart(document.getElementById('chart_div'));
											
											        chart.draw(data, options);
											      }
											     
									})
								</script>






							<div class="card">
								<div class="card-header">
									<h4>리스크 분석</h4>
								</div>
								<div class="card-body">
									<div id="chart_div2"
										style="width: 900px; height: 500px; margin: 0 auto;"></div>
								</div>
							</div>



							<script>
												$(document).ready(function(){
												
																	var importance = []
																	var count = []
																    $.ajax({
																      url: '/project5/riskDashBoardData.do',
																      type: 'POST',
																      async:false, 
																      dataType:'json',
																        success: function(result){
																          console.log(" riskDashBoardData 일단 성공")
																          console.log(result);
																          console.log(result.get);
																          console.log(result.get[0]);
																          console.log(result.get[0].importance);
																          console.log(result.get[0].count);
																          importance[0] = result.get[0].importance
																          importance[1] = result.get[1].importance
																          importance[2] = result.get[2].importance
																          count[0] = result.get[0].count
																          count[1] = result.get[1].count
																          count[2] = result.get[2].count
																          console.log(" riskDashBoardData 완료")
																      },
																      error: function(result){
																    	  console.log(memberkey)
																          console.log("riskDashBoardData 실패");
																          console.log(result); 
																      }
																    }); //$.ajax					
																    console.log("count2222 ::::::::::::::::::: "+count)
																    
																    
															google.charts.load('current', {packages: ['corechart', 'bar']});
															google.charts.setOnLoadCallback(drawBasic);
															
															function drawBasic() {
															      var data = google.visualization.arrayToDataTable([
															        ['리스크 구분', '개수', { role: 'style' }],
															        [importance[0], count[0], '#b87333'],
															        [importance[1], count[1],'silver'],
															        [importance[2], count[2],'gold']
															      ]);
															
															      var options = {
															        title: '리스크 분석',
															        chartArea: {width: '50%'},
															        hAxis: {
															          title: 'Total Population',
															          minValue: 0
															        },
															        vAxis: {
															          title: 'City'
															        }
															      };
															
															      var chart = new google.visualization.BarChart(document.getElementById('chart_div2'));
															
															      chart.draw(data, options);
															    }
																											})
												</script>
						</div>
					</div>






					<div class="card">
						<div class="card-header">
							<h4>프로젝트 참여율 분석</h4>
						</div>
						<div class="card-body">
							<div id="calendar_basic"
								style="width: 1000px; height: 330px; margin: 0 auto; margin-top: 50px;"></div>
						</div>
					</div>
			
					<script type="text/javascript">
						 $.ajax({
							 url : '/project5/TotalOutputCntByDayList.do',
							 dataType:'json',
							 success:function(result){
								 console.log("하루 하루작업량 업로드 성공")
								 console.log(result)
								 console.log(result.TotalOutputCntByDayList)
								 console.log(result.TotalOutputCntByDayList[0].writedate)
								 console.log(result.TotalOutputCntByDayList[0].count)
								 for(var i=0; i<result.TotalOutputCntByDayList.length; i++){
									 commitdata.push ([
										 new Date(result.TotalOutputCntByDayList[i].writedate.substr(0,4),
								        		  result.TotalOutputCntByDayList[i].writedate.substr(4,2), 
								        		  result.TotalOutputCntByDayList[i].writedate.substr(6,2)),
								        		  result.TotalOutputCntByDayList[i].count
									 ]);
									 console.log(i);
								 }
							 }
						 })
							var commitdata=[];
						      google.charts.load("current", {packages:["calendar"]});
						      google.charts.setOnLoadCallback(drawChart);
						   function drawChart() {
						       var dataTable = new google.visualization.DataTable();
						       dataTable.addColumn({ type: 'date', id: 'Date' });
						       dataTable.addColumn({ type: 'number', id: 'Won/Loss' });
						       dataTable.addRows(commitdata);
						       var chart = new google.visualization.Calendar(document.getElementById('calendar_basic'));
						       var options = {
						         title: "일일 프로젝트 참여 분석",
						         height: 400,
						       };
						
						       chart.draw(dataTable, options);
						   }
						    </script>




							<div class="card">
											<div class="card-header">
													<h4>산출물 평가 점수 분석</h4>
											</div>
												<div class="card-body">
														<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
															       <select id="format-select">
																      <option value="">none</option>
																      <option value="decimal" selected>decimal</option>
																      <option value="scientific">scientific</option>
																      <option value="percent">percent</option>
																      <option value="currency">currency</option>
																      <option value="short">short</option>
																      <option value="long">long</option>
															    </select>
										    
													    <div id="number_format_chart" style="margin-left: 300px; height: 500px;">
														</div>
												</div>
										</div>

					<script>
					$.ajax({
						url : '/project5/outputEvaluationDayByDay.do',
						type:'POST',
						dataType:'json',
						success:function(result){
							console.log("'/project5/outputEvaluationDayByDay.do")
							console.log(result.list)
							console.log(result.list.length)
							console.log(result.list[0].writedate)
							console.log(result.list[0].evaluation)
							data4 =[
					              [result.list[0].writedate, result.list[0].evaluation],
					              [result.list[1].writedate,  result.list[1].evaluation],
					              [result.list[2].writedate,  result.list[2].evaluation]
					            ]
						},
						error:function(result){
							alert("실패")
						}
					})
					var data4;
					google.charts.load('current', {packages:['corechart']});
      google.charts.setOnLoadCallback(drawStuff);

			        function drawStuff() {
			            var data = new google.visualization.DataTable();
			            data.addColumn('string', 'Country');
			            data.addColumn('number', 'GDP');
			            data.addRows(data4);

			           var options = {
			             title: '산출물 평가 점수',
			             width: 500,
			             height: 300,
			             legend: 'none',
			             bar: {groupWidth: '95%'},
			             vAxis: { gridlines: { count: 4 } }
			           };

			           var chart = new google.visualization.ColumnChart(document.getElementById('number_format_chart'));
			           chart.draw(data, options);

			           document.getElementById('format-select').onchange = function() {
			             options['vAxis']['format'] = this.value;
			             chart.draw(data, options);
			           };
			        };
					</script>





				</div>










				<div class="col-12 col-lg-4">
					<div class="card">
						<div class="card-body py-4 px-5">
							<div class="d-flex align-items-center">
								<div class="avatar avatar-xl" id="myface">
									<!--  로그인 한 회원의 이미지 정보 img  
									<img src="/project5/resources/dist/assets/images/faces/1.jpg"
										alt="Face 1">
										-->
								</div>
								<div class="ms-3 name">
									<h5 class="font-bold">[${member.name }] 님</h5>
									<h6 class="text-muted mb-0">
										직책 : ${member.auth } <br>${member.email}
									</h6>
								</div>
							</div>
						</div>
					</div>








					<div class="card">
						<div class="card-header">
							<h4>예산 지출 상황</h4>
						</div>
						<div class="card-body">
						 <div id="chart_div3" style="width: 100%; height: 700px;"></div>
						</div>
					</div>
					
						<script type="text/javascript">
							  var no = parseInt("${project.projectkey}");
							  var data = {no : no};
							  console.log("no " +no);
							  console.log("data"+data);
							  
							  $.ajax({
								  url : '/project5/dashCostDetailGet.do',
								  method : 'POST',
								  data : data,
								  dataType:'json',
								  success:function(result){
									  console.log("예산 지출 상황---------------------------------------------")
									  console.log(result)
									  console.log(result.get)
									  console.log(result.get[1].costex)
									  mydata = [
										  ['Year', '예산', '지출'],
										  ['개발자',  parseInt("${project.take}"),      result.get[0].costex ],
								          ['식비',  parseInt("${project.take}"),      result.get[1].costex ],
								          ['사무용품',  parseInt("${project.take}"),       result.get[2].costex ],
								          ['복지비',  parseInt("${project.take}"),       result.get[3].costex ]
									  ];
								  },
								  error:function(result){
									  console.log("예산 데이터 받아오기 실패")
								  }
							  })
							  
						
						      google.charts.load('current', {'packages':['corechart']});
						      google.charts.setOnLoadCallback(drawChart);
						
						      
						      
						      var mydata;
						         
						       
						        
						      function drawChart() {
						        var data = google.visualization.arrayToDataTable(mydata);
						        var options = {
						          title: '예산 지출 현황',
						          hAxis: {title: 'Year',  titleTextStyle: {color: '#333'}},
						          vAxis: {minValue: 0}
						        };
						        var chart = new google.visualization.AreaChart(document.getElementById('chart_div3'));
						        chart.draw(data, options);
						      }
						    </script>


























					<!--  휴가자 근무 가능자 -->
					<div class="card">
						<div class="card-header">
							<h4>프로젝트 근무 가능자 / 휴가 인원 </h4>
						</div>
						<div class="card-body">
							 <div id="curve_chart" style="height: 500px;"></div>
						</div>
					</div>
					<script type="text/javascript">
					
					
									var projectkey = parseInt("${project.projectkey}");
									var pvc = {projectkey : projectkey}
									$.ajax({
										url : '/project5/projectVacationCnt.do',
										method : 'POST',
										data : pvc,
										dataType : 'json',
										success:function(result){
											console.log("====================")
											console.log(result)
											console.log(result.yesterdayCanCnt)
											console.log(result.tommorwCanCnt)
											console.log(result.todayCanCnt)
											console.log(result.projectTotalCnt)
											go = [
										          ['Year', '휴가자', '근무 가능 인원 '],
										          ['어제',  result.yesterdayCanCnt,result.projectTotalCnt-result.yesterdayCanCnt],
										          ['오늘',  result.todayCanCnt,result.projectTotalCnt-result.todayCanCnt],
										          ['내일',  result.tommorwCanCnt,result.projectTotalCnt-result.tommorwCanCnt]
										        ]
										},
										error:function(result){
											console.log("휴가인원 불러오기 실패")
										}
									})
									
										var go = []
									
					
								      google.charts.load('current', {'packages':['corechart']});
								      google.charts.setOnLoadCallback(drawChart);
								
								      function drawChart() {
								        var data = google.visualization.arrayToDataTable(go);
								
								        var options = {
								          title: '근무 가능 인원',
								          curveType: 'function',
								          legend: { position: 'bottom' }
								        };
								
								      	 var chart = new google.visualization.LineChart(document.getElementById('curve_chart'));
								
								        chart.draw(data, options);
								      }
								    </script>


















				





					<div class="card">
						<div class="card-header">
							<h4>프로젝트 조직 분석	</h4>
						</div>
						<div class="card-body">
							<div id="piechart1" style="width: 100%; height: 400px;"></div>
						</div>
					</div>
					
					<script type="text/javascript">
									var projectkey;
									var projectkeyRe = "${project.projectkey}";
									
									var dataRe = {projectkey : projectkeyRe}
									
									var cntList = []
								 	$.ajax({
										url : '/project5/teamCnt.do',
										type : 'POST',
										data : dataRe,
										async:false, 
										dataType:'json',
										success : function(result){
											console.log("프로젝트 조직 분석 데이터 불러오기 성공")
											cntList[0] = result.teamCntByProject1
											cntList[1] = result.teamCntByProject2
											cntList[2] = result.teamCntByProject2
										},
										error : function(result){
											alert("로젝트 조직 분석 데이터 불러오기 실패")
										}
								 	})
								 console.log("cntList::::::::::::::::::::::::::::::"+cntList)
								 
												google.charts.load('current', {'packages':['corechart']});
										      google.charts.setOnLoadCallback(drawChart);
																		
										      function drawChart() {
										          var data1 = google.visualization.arrayToDataTable([
										            ['Task', 'Hours per Day'],
										            ['기획팀',     cntList[0]],
										            ['개발팀',     cntList[1]],
										            ['고객전담팀',     cntList[2]],
										          ]);
										          var options = {
										            title: '조직 분포'
										          };
										          var chart = new google.visualization.PieChart(document.getElementById('piechart1'));
										          chart.draw(data1, options);
										        }
							    </script>



				
				
				
				
				
			</section>
		</div>

	</div>















	<!--login form Modal -->
	<div class="modal fade text-left" id="inlineForm" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel33" aria-hidden="true">
		<div
			class="modal-dialog modal-dialog-centered modal-dialog-scrollable"
			role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="myModalLabel33">메모 쓰기</h4>
					<button type="button" class="close" data-bs-dismiss="modal"
						aria-label="Close">
						<i data-feather="x"></i>
					</button>
				</div>
				<form action="/project5/memoInsert.do" id="frm01" method="post">
					<input type="hidden" name="memberkey" value="${member.memberkey }">
					<input type="hidden" name="projectkey" value="1">
					<div class="modal-body">

						<label>중요도: </label>
						<div class="form-group">
							<select class="form-control" name="importance">
								<option value="상">상</option>
								<option value="중">중</option>
								<option value="하">하</option>
							</select>
						</div>

						<label>제목: </label>
						<div class="form-group">
							<input type="text" name="title" class="form-control">
						</div>

						<label>내용: </label>
						<div class="form-group">
							<input type="text" name="contents" class="form-control">
						</div>
					</div>

					<div class="modal-footer">
						<button type="button" class="btn btn-light-secondary"
							data-bs-dismiss="modal">
							<i class="bx bx-x d-block d-sm-none"></i> <span
								class="d-none d-sm-block">닫기</span>
						</button>
						<button type="submit" class="btn btn-danger ml-2">
							<i class="bx bx-check d-block d-sm-none"></i> <span
								class="d-none d-sm-block">작성완료</span>
						</button>
					</div>
				</form>
			</div>
		</div>
	</div>



</body>

</html>