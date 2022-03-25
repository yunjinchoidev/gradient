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
	
	
	
	
	
	
	
})

</script>


<body>

	<%@ include file="../chatBot/chatBot.jsp"%>
	<%@ include file="../common/header.jsp"%>

	<div id="main">


		<div class="page-heading">
			<div class="page-title">
				<div class="row">
					<%@include file="../projectHome/sort.jsp"%>
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
											<h6 class="text-muted font-semibold">프리미엄시 개방</h6>
											<h6 class="font-extrabold mb-0">프리미엄시 개방</h6>
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
											<h6 class="text-muted font-semibold">프리미엄시 개방</h6>
											<h6 class="font-extrabold mb-0">프리미엄시 개방</h6>
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
											<h6 class="text-muted font-semibold">프리미엄시 개방</h6>
											<h6 class="font-extrabold mb-0">프리미엄시 개방</h6>
										</div>
									</div>
								</div>
							</div>
						</div>

					</div>






					<div class="row">
						<div class="col-12">
							<!--  메모장 -->
							<div class="card">
								<div class="card-header">
									<h4>
										[<span style="color: red">${member.name } </span>]님 만을 위한 메모장
									</h4>
								</div>
								<div class="card-body">
									<div
										class="dataTable-wrapper dataTable-loading no-footer sortable searchable fixed-columns">
										<div class="dataTable-top">
											<div class="dataTable-dropdown">
												<select class="dataTable-selector form-select"><option
														value="5">5</option>
													<option value="10" selected="">10</option>
													<option value="15">15</option>
													<option value="20">20</option>
													<option value="25">25</option></select><label>entries per
													page</label>
											</div>
											<div class="dataTable-search">
												<input class="dataTable-input" placeholder="Search..."
													type="text"> <a class="btn btn-danger"
													style="text-align: right" data-bs-toggle="modal"
													data-bs-target="#inlineForm">메모 쓰기</a>
											</div>
										</div>


										<div class="dataTable-container">
											<table class="table table-striped dataTable-table"
												id="table1">
												<thead>
													<tr>
														<th data-sortable="" style="width: 12.0176%;"><a
															href="#" class="dataTable-sorter">메모 번호</a></th>
														<th data-sortable="" style="width: 18.9989%;"><a
															href="#" class="dataTable-sorter">메모 명</a></th>
														<th data-sortable="" style="width: 42.0816%;"><a
															href="#" class="dataTable-sorter">메모내용</a></th>
														<th data-sortable="" style="width: 16.3175%;"><a
															href="#" class="dataTable-sorter">작성일</a></th>
														<th data-sortable="" style="width: 10.8049%;"><a
															href="#" class="dataTable-sorter">중요도</a></th>
													</tr>
												</thead>

												<tbody>
													<c:forEach var="list" items="${memoList}">
														<tr>
															<td>${list.memokey}</td>
															<td style="cursor: pointer;" id="delBtn"
																onclick="location.href='location.href='/project5/memoDelete.do?memokey=${list.memokey}'">${list.title }
																<span class="badge bg-danger">삭제</span>
															</td>
															<td>${list.contents }</td>
															<td><fmt:formatDate value="${list.writedate }" /></td>
															<td style="cursor: pointer;"><c:if
																	test="${list.importance eq '하'}">
																	<span class="badge bg-primary importance22">하</span>
																</c:if> <c:if test="${list.importance eq '중'}">
																	<span class="badge bg-secondary importance22">중</span>
																</c:if> <c:if test="${list.importance eq '상'}">
																	<span class="badge bg-danger importance22">상</span>
																</c:if></td>
														</tr>
													</c:forEach>
												</tbody>
											</table>
										</div>

										<script>
										$(document).ready(function(){
											$("#delBtn").click(function(){
												confirm("정말 삭제 하시겠습니까?")
											})
											 var a=0;
											
											 setInterval(function() {
												 a++;
													if(a%2==0){
														$(".importance22").css("display","none");
													}else{
														$(".importance22").css("display","");
													}
											}, 1000);
											
										})
										
										
										</script>




										<div class="dataTable-bottom">
											<div class="dataTable-info">Showing 1 to 10 of 26
												entries</div>
											<ul
												class="pagination pagination-primary float-end dataTable-pagination">
												<li class="page-item pager"><a href="#"
													class="page-link" data-page="1">‹</a></li>
												<li class="page-item active"><a href="#"
													class="page-link" data-page="1">1</a></li>
												<li class="page-item"><a href="#" class="page-link"
													data-page="2">2</a></li>
												<li class="page-item"><a href="#" class="page-link"
													data-page="3">3</a></li>
												<li class="page-item pager"><a href="#"
													class="page-link" data-page="2">›</a></li>
											</ul>
										</div>
									</div>
								</div>
							</div>










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
												         
												        	for(var i=0; i<11; i++){
												        	  if(result.outputSortCnt[i] ==null){
												        		  outputSortCnt[i] = 0
												        	  }else{
												        		  outputSortCnt[i] = result.outputSortCnt[i].count;
												        	  }
												         }
												          
												          for(var i=0; i<11; i++){
												        	  if(outputSortCntByMemberkey[i] == null){
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
							<h4>프로젝트 조직 분석</h4>
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
											alert("실패")
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























					<div class="row">
						<div class="col-12 col-xl-8">
							<div class="card">
								<div class="card-header">
									<h4></h4>
								</div>
								<div class="card-body"></div>
							</div>
						</div>

						<div class="col-12 col-xl-4">
							<div class="card">
								<div class="card-header">
									<h4></h4>
								</div>
								<div class="card-body">
									<div class="table-responsive">
										<table class="table table-hover table-lg">
											<thead>
												<tr>
													<th></th>
													<th></th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td class="col-3">
														<div class="d-flex align-items-center">
															<div class="avatar avatar-md">
																<!-- 
																<img
																	src="/project5/resources/dist/assets/images/faces/5.jpg"> -->
															</div>
															<p class="font-bold ms-3 mb-0"></p>
														</div>
													</td>
													<td class="col-auto">
														<p class=" mb-0"></p>
													</td>
												</tr>
												<tr>
													<td class="col-3">
														<div class="d-flex align-items-center">
															<div class="avatar avatar-md">
																<!-- 
																<img
																	src="/project5/resources/dist/assets/images/faces/2.jpg"> -->
															</div>
															<p class="font-bold ms-3 mb-0"></p>
														</div>
													</td>
													<td class="col-auto">
														<p class=" mb-0"></p>
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>
					</div>



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
							<h4>최근 프로젝트 참여자</h4>
						</div>

						<!-- 
						<div class="card-content pb-4">
							<div class="recent-message d-flex px-4 py-3">
								<div class="avatar avatar-lg">
									<img src="/project5/resources/dist/assets/images/faces/4.jpg">
								</div>
								<div class="name ms-4">
									<h5 class="mb-1">개발자 1</h5>
									<h6 class="text-muted mb-0">@홍길동</h6>
								</div>
							</div>
							<div class="recent-message d-flex px-4 py-3">
								<div class="avatar avatar-lg">
									<img src="/project5/resources/dist/assets/images/faces/5.jpg">
								</div>
								<div class="name ms-4">
									<h5 class="mb-1">마케터 2</h5>
									<h6 class="text-muted mb-0">@김철수</h6>
								</div>
							</div>
							<div class="recent-message d-flex px-4 py-3">
								<div class="avatar avatar-lg">
									<img src="/project5/resources/dist/assets/images/faces/1.jpg">
								</div>
								<div class="name ms-4">
									<h5 class="mb-1">인사과 1</h5>
									<h6 class="text-muted mb-0">@김영희</h6>
								</div>
							</div>
							<div class="px-4">
								<button
									class='btn btn-block btn-xl btn-light-primary font-bold mt-3'
									onclick="window.open('/project5/chatTEST.do', 'PopupWin', 'width=1000,height=1200');"
									>채팅 시작
									</button>
							</div>
						</div>
						 -->

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
									  console.log("-------------------------------------")
									  console.log(result)
									  console.log(result.get)
									  console.log(result.get[0])
									  mydata = [
										  ['Year', '예산', '지출'],
										  ['개발자',  parseInt("${project.take}"),      result.get[0].costex ],
								          ['식비',  parseInt("${project.take}"),      result.get[1].costex ],
								          ['사무용품',  parseInt("${project.take}"),       result.get[2].costex ],
								          ['기타',  parseInt("${project.take}"),      result.get[3].costex ]
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
								      google.charts.load('current', {'packages':['corechart']});
								      google.charts.setOnLoadCallback(drawChart);
								
								      function drawChart() {
								        var data = google.visualization.arrayToDataTable([
								          ['Year', 'Sales', 'Expenses'],
								          ['2004',  1000,      400],
								          ['2005',  1170,      460],
								          ['2006',  660,       1120],
								          ['2007',  1030,      540]
								        ]);
								
								        var options = {
								          title: '작업속도',
								          curveType: 'function',
								          legend: { position: 'bottom' }
								        };
								
								      	 var chart = new google.visualization.LineChart(document.getElementById('curve_chart'));
								
								        chart.draw(data, options);
								      }
								    </script>























					<div class="card">
						<div class="card-header">
							<h4></h4>
						</div>
						<div class="card-body">

							<script type="text/javascript">
						      google.charts.load('current', {'packages':['corechart']});
						      google.charts.setOnLoadCallback(drawChart);
						
						      function drawChart() {
						
						        var data = google.visualization.arrayToDataTable([
						          ['Task', 'Hours per Day'],
						          ['Work',     11],
						          ['Eat',      2],
						          ['Commute',  2],
						          ['Watch TV', 2],
						          ['Sleep',    7]
						        ]);
						
						        var options = {
						          title: '분류'
						        };
						
						        //var chart = new google.visualization.PieChart(document.getElementById('piechart'));
						
						        //chart.draw(data, options);
						      }
						    </script>
							<!-- 
							<div id="piechart"></div>
							 -->
						</div>
					</div>
				</div>
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