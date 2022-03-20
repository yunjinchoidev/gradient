<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	   <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
</head>




<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
$(document).ready(function(){
	
	$("#progress").click(function(){
		alert("프로젝트 진행 상태를 바꾸시겠습니까?");
		$(".modal").modal('show');
		
	})
	
	
	
})

</script>


<body>

	<%@ include file="../common/header.jsp"%>

	<div id="main">
		<header class="mb-3">
			<a href="#" class="burger-btn d-block d-xl-none"> <i
				class="bi bi-justify fs-3"></i>
			</a>
		</header>

		<div class="page-heading">
			<h3>프로젝트 관리 </h3>
			<h5><span style="color: red">"${member.name }${member.auth }"</span>님 어서오십시오.</h5>
			<h5>오직 PM만을 위해 제공하는 정보가 여기 있습니다. </h5>
		</div>
		
		
		<div class="page-content">
			<section class="row">
				<div class="col-12 col-lg-9">
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
											<h6 class="text-muted font-semibold">이메일 보내기</h6>
											<h6 class="font-extrabold mb-0">이메일 보내기</h6>
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
											<h6 class="text-muted font-semibold">직원 조회</h6>
											<h6 class="font-extrabold mb-0">직원 조회</h6>
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
											<h6 class="text-muted font-semibold">고객처 조회</h6>
											<h6 class="font-extrabold mb-0">고객처 조회</h6>
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
											<h6 class="text-muted font-semibold">알림 메시지</h6>
											<h6 class="font-extrabold mb-0">알림 메시지</h6>
										</div>
									</div>
								</div>
							</div>
						</div>
						
					</div>
					<div class="row">
						<div class="col-12">
						
					
  										
  										
  										
  										
  										
  										
  										
  										
  										
							









							<div class="card">
								<div class="card-header"><h4>프로젝트 시작과 종료</h4></div>
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
													type="text"> <a
													href="/project5/scheduleInsertForm.do"
													class="btn btn-danger" style="text-align: right">새 프로젝트 만들기</a>
											</div>

										</div>
										<div class="dataTable-container">
											<table class="table table-striped dataTable-table"
												id="table1">
												<thead>
													<tr>
														<th data-sortable="" style="width: 12.0176%;"><a
															href="#" class="dataTable-sorter">프로젝트 번호</a></th>
														<th data-sortable="" style="width: 42.9989%;"><a
															href="#" class="dataTable-sorter">프로젝트 명</a></th>
														<th data-sortable="" style="width: 18.0816%;"><a
															href="#" class="dataTable-sorter">수주액</a></th>
														<th data-sortable="" style="width: 16.3175%;"><a
															href="#" class="dataTable-sorter">중요도</a></th>
														<th data-sortable="" style="width: 10.8049%;"><a
															href="#" class="dataTable-sorter">상태</a></th>
													</tr>
												</thead>
												<tbody>
													<c:forEach var="list" items="${list}">
														<tr >
															<td>${list.projectkey}</td>
															<td style="cursor: pointer;" onclick="location.href='/project5/projectManageGet.do?projectkey=${list.projectkey}'">${list.name }</td>
															<td>
															<fmt:formatNumber>${list.take }</fmt:formatNumber>
															</td>
															<td>
															
																<c:if test="${list.importance eq '하'}">
															<span class="badge bg-primary">하</span>
															</c:if>
															<c:if test="${list.importance eq '중'}">
															<span class="badge bg-secondary">중</span>
															</c:if>
															<c:if test="${list.importance eq '상'}">
															<span class="badge bg-danger">상</span>
															</c:if>
															
															</td>
															
															
															
															
															
															<td id="progress" style="cursor: pointer;" data-toggle="modal" data-target= "#inlineForm">

															
															<c:if test="${list.progress eq '대기'}">
															<span class="badge bg-primary">대기</span>
															</c:if>
															<c:if test="${list.progress eq '초기'}">
															<span class="badge bg-secondary">초기</span>
															</c:if>
															<c:if test="${list.progress eq '중기'}">
															<span class="badge bg-success">중기</span>
															</c:if>
															<c:if test="${list.progress eq '말기'}">
															<span class="badge bg-danger">말기</span>
															</c:if>
															<c:if test="${list.progress eq '종료'}">
															<span class="badge bg-dark">종료</span>
															</c:if>
															
															
															
															</td>
															
															
														</tr>
													</c:forEach>
												</tbody>
											</table>
										</div>
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
									<h4>작업 스케쥴</h4>
								</div>
								<div class="card-body">
								
  								<div id="chart_div"></div>
     							 <!-- 막대 차트 -->
								<script>
								google.charts.load('current', {packages: ['corechart', 'bar']});
								google.charts.setOnLoadCallback(drawBasic);

								function drawBasic() {

								      var data = new google.visualization.DataTable();
								      data.addColumn('timeofday', 'Time of Day');
								      data.addColumn('number', 'Motivation Level');

								      data.addRows([
								        [{v: [8, 0, 0], f: '8 am'}, 1],
								        [{v: [9, 0, 0], f: '9 am'}, 2],
								        [{v: [10, 0, 0], f:'10 am'}, 3],
								        [{v: [11, 0, 0], f: '11 am'}, 4],
								        [{v: [12, 0, 0], f: '12 pm'}, 5],
								        [{v: [13, 0, 0], f: '1 pm'}, 6],
								        [{v: [14, 0, 0], f: '2 pm'}, 7],
								        [{v: [15, 0, 0], f: '3 pm'}, 8],
								        [{v: [16, 0, 0], f: '4 pm'}, 9],
								        [{v: [17, 0, 0], f: '5 pm'}, 10],
								      ]);

								      var options = {
								        title: '작업 스케쥴',
								        hAxis: {
								          title: 'Time of Day',
								          format: 'h:mm a',
								          viewWindow: {
								            min: [7, 30, 0],
								            max: [17, 30, 0]
								          }
								        },
								        vAxis: {
								          title: 'Rating (scale of 1-10)'
								        }
								      };

								      var chart = new google.visualization.ColumnChart(
								        document.getElementById('chart_div'));

								      chart.draw(data, options);
								    }
								</script>
      
									
								</div>
							</div>





						<div class="card">
								<div class="card-header">
									<h4>작업량 분석</h4>
								</div>
								
								<div class="card-body">
									 <!--  커밋 차트 -->
								
									    <script type="text/javascript">
									      google.charts.load("current", {packages:["calendar"]});
									      google.charts.setOnLoadCallback(drawChart);
									
									   function drawChart() {
									       var dataTable = new google.visualization.DataTable();
									       dataTable.addColumn({ type: 'date', id: 'Date' });
									       dataTable.addColumn({ type: 'number', id: 'Won/Loss' });
									       dataTable.addRows([
									          [ new Date(2012, 3, 13), 37032 ],
									          [ new Date(2012, 3, 14), 38024 ],
									          [ new Date(2012, 3, 15), 38024 ],
									          [ new Date(2012, 3, 16), 38108 ],
									          [ new Date(2012, 3, 17), 38229 ],
									          // Many rows omitted for brevity.
									          [ new Date(2013, 9, 4), 38177 ],
									          [ new Date(2013, 9, 5), 38705 ],
									          [ new Date(2013, 9, 12), 38210 ],
									          [ new Date(2013, 9, 13), 38029 ],
									          [ new Date(2013, 9, 19), 38823 ],
									          [ new Date(2013, 9, 23), 38345 ],
									          [ new Date(2013, 9, 24), 38436 ],
									          [ new Date(2013, 9, 30), 38447 ]
									        ]);
									
									       var chart = new google.visualization.Calendar(document.getElementById('calendar_basic'));
									
									       var options = {
									         title: "Red Sox Attendance",
									         height: 350,
									       };
									
									       chart.draw(dataTable, options);
									   }
									    </script>
  								<div id="calendar_basic" style="width: 1000px; height: 100%; margin-left: 40px;"></div>
  								
     						
      
									
								</div>
							</div>
							
							
							
							
							
							
							
							
							
							








						</div>
					</div>
					<div class="row">
						<div class="col-12 col-xl-4">
							<div class="card">
								<div class="card-header">
									<h4>Profile Visit</h4>
								</div>
								<div class="card-body">
									<div class="row">
										<div class="col-6">
											<div class="d-flex align-items-center">
												<svg class="bi text-primary" width="32" height="32"
													fill="blue" style="width: 10px">
                                                        <use
														xlink:href="/project5/resources/dist/assets/vendors/bootstrap-icons/bootstrap-icons.svg#circle-fill" />
                                                    </svg>
												<h5 class="mb-0 ms-3">Europe</h5>
											</div>
										</div>
										<div class="col-6">
											<h5 class="mb-0">862</h5>
										</div>
										<div class="col-12">
											<div id="chart-europe"></div>
										</div>
									</div>
									<div class="row">
										<div class="col-6">
											<div class="d-flex align-items-center">
												<svg class="bi text-success" width="32" height="32"
													fill="blue" style="width: 10px">
                                                        <use
														xlink:href="/project5/resources/dist/assets/vendors/bootstrap-icons/bootstrap-icons.svg#circle-fill" />
                                                    </svg>
												<h5 class="mb-0 ms-3">America</h5>
											</div>
										</div>
										<div class="col-6">
											<h5 class="mb-0">375</h5>
										</div>
										<div class="col-12">
											<div id="chart-america"></div>
										</div>
									</div>
									<div class="row">
										<div class="col-6">
											<div class="d-flex align-items-center">
												<svg class="bi text-danger" width="32" height="32"
													fill="blue" style="width: 10px">
                                                        <use
														xlink:href="assets/vendors/bootstrap-icons/bootstrap-icons.svg#circle-fill" />
                                                    </svg>
												<h5 class="mb-0 ms-3">Indonesia</h5>
											</div>
										</div>
										<div class="col-6">
											<h5 class="mb-0">1025</h5>
										</div>
										<div class="col-12">
											<div id="chart-indonesia"></div>
										</div>
									</div>
								</div>
							</div>





						</div>
						<div class="col-12 col-xl-8">
							<div class="card">
								<div class="card-header">
									<h4>Latest Comments</h4>
								</div>
								<div class="card-body">
									<div class="table-responsive">
										<table class="table table-hover table-lg">
											<thead>
												<tr>
													<th>Name</th>
													<th>Comment</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td class="col-3">
														<div class="d-flex align-items-center">
															<div class="avatar avatar-md">
																<img
																	src="/project5/resources/dist/assets/images/faces/5.jpg">
															</div>
															<p class="font-bold ms-3 mb-0">Si Cantik</p>
														</div>
													</td>
													<td class="col-auto">
														<p class=" mb-0">Congratulations on your graduation!</p>
													</td>
												</tr>
												<tr>
													<td class="col-3">
														<div class="d-flex align-items-center">
															<div class="avatar avatar-md">
																<img
																	src="/project5/resources/dist/assets/images/faces/2.jpg">
															</div>
															<p class="font-bold ms-3 mb-0">Si Ganteng</p>
														</div>
													</td>
													<td class="col-auto">
														<p class=" mb-0">Wow amazing design! Can you make
															another tutorial for this design?</p>
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
				<div class="col-12 col-lg-3">
					<div class="card">
						<div class="card-body py-4 px-5">
							<div class="d-flex align-items-center">
								<div class="avatar avatar-xl">
									<img src="/project5/resources/dist/assets/images/faces/1.jpg"
										alt="Face 1">
								</div>
								<div class="ms-3 name">
									<h5 class="font-bold">${member.name } 님</h5>
									<h6 class="text-muted mb-0">직책 : ${member.auth } <br>${member.email} </h6>
								</div>
							</div>
						</div>
					</div>
					<div class="card">
						<div class="card-header">
							<h4>최근 메시지</h4>
						</div>
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
					</div>
					<div class="card">
						<div class="card-header">
							<h4>예산 분석</h4>
						</div>
						<div class="card-body">
						 <script type="text/javascript">
   							   google.charts.load('current', {'packages':['corechart']});
						      google.charts.setOnLoadCallback(drawChart);
						
						      function drawChart() {
						        var data = google.visualization.arrayToDataTable([
						          ['Director (Year)',  'Rotten Tomatoes', 'IMDB'],
						          ['Alfred Hitchcock (1935)', 8.4,         7.9],
						          ['Ralph Thomas (1959)',     6.9,         6.5],
						          ['Don Sharp (1978)',        6.5,         6.4],
						          ['James Hawes (2008)',      4.4,         6.2]
						        ]);
						
						        var options = {
						          title: 'The decline of \'The 39 Steps\'',
						          vAxis: {title: 'Accumulated Rating'},
						          isStacked: true
						        };
						
						        var chart = new google.visualization.SteppedAreaChart(document.getElementById('chart_div2'));
						
						        chart.draw(data, options);
						      }
						    </script>
						<div id="chart_div2"></div>
						</div>
					</div>
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					<div class="card">
						<div class="card-header">
							<h4>프로젝트 별 작업속도 분석</h4>
						</div>
						<div class="card-body">
							 <div id="curve_chart"></div>
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
						</div>
					</div>
					
					
					
					
					<div class="card">
						<div class="card-header">
							<h4>현재 진행중인 프로젝트</h4>
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

        var chart = new google.visualization.PieChart(document.getElementById('piechart'));

        chart.draw(data, options);
      }
    </script>
    
							<div id="piechart"></div>
						</div>
					</div>
				</div>
			</section>
		</div>

	</div>















  <!--login form Modal -->
                                            <div class="modal fade text-left" id="inlineForm" tabindex="-1"
                                                role="dialog" aria-labelledby="myModalLabel33" aria-hidden="true">
                                                <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable"
                                                    role="document">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h4 class="modal-title" id="myModalLabel33">프로젝트 상태 변경 </h4>
                                                            <button type="button" class="close" data-bs-dismiss="modal"
                                                                aria-label="Close">
                                                                <i data-feather="x"></i>
                                                            </button>
                                                        </div>
                                                        <form action="/project5/progressUpdate.do?" id="frm01">
                                                        <input type="hidden" name="projectkey" value="2">
                                                            <div class="modal-body">
                                                                <label>progress: </label>
                                                                <div class="form-group">
                                                                        <select  class="form-control" name="progress">
                                                                        	<option value="대기">대기</option>
                                                                        	<option value="초기">초기</option>
                                                                        	<option value="중기">중기</option>
                                                                        	<option value="말기">말기</option>
                                                                        	<option value="종료">종료</option>
                                                                        </select>
                                                                </div>
                                                            </div>
                                                            
                                                            
                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-light-secondary"
                                                                    data-bs-dismiss="modal">
                                                                    <i class="bx bx-x d-block d-sm-none"></i>
                                                                    <span class="d-none d-sm-block">닫기</span>
                                                                </button>
                                                                <button type="submit" class="btn btn-danger ml-2 update"
                                                                    data-bs-dismiss="modal" id="updateItem" onclick="alert('변경합니다')">
                                                                    <i class="bx bx-check d-block d-sm-none"></i>
                                                                    <span class="d-none d-sm-block">수정</span>
                                                                </button>
                                                                <input type="submit" value="수정">
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>















</body>






    

</html>