<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
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
	
	
	//$("#progress").click(function(){
	//	alert("프로젝트 진행 상태를 바꾸시겠습니까?");
	//})
	
		var memberkey;
		// ajax를 통한 파일 정보 불러오기 
		// 페이지 접속시 자동으로 실행
		var memberkeyValue ="${member.memberkey}";
		  console.log(memberkey);
		 var data = { memberkey : memberkeyValue};
		 // 업로드 파일 결과 가져오기
	    $.ajax({
	      url: '/project5/aaaa.do',
	      data: data,
	      type: 'POST',
	      dataType:'json',
	        success: function(result){
	          console.log(result); 
	          console.log("파일 불러오기 완료")
			  showUploadResult2(result.get[0]);//////////////////////////////////////////////////////////////////////// 이곳에서 함수 호출 
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
					str += "<img src='/project5/display2.do?fileName="+fileCallPath+"'>";
					console.log("str : "+str)
				})
		    uploadUL.append(str);
		  }
	///////////////////////////////////////////////////////////////
	
		var pageSize="${projectSch.pageSize}"
			$("[name=pageSize]").val(pageSize);
			$("[name=pageSize]").change(function(){
				$("[name=curPage]").val(1);
				$("#frm01").submit();
			});	
			
			
			var msg = "${msg}";
			if(msg!=""){
				if(confirm(msg+"\n메인화면으로 이동할까요?")){
					location.href="${path}/projectList.do";
				}
			}
	
	
})

	function goPage(no){
		$("[name=curPage]").val(no);
		$("#frm01").submit();
	}
</script>


<body>
<%@ include file="../chatBot/chatBot.jsp"%>
	<%@ include file="../common/header.jsp"%>

	<div id="main">
			<header class="mb-3">
				<a href="#" class="burger-btn d-block d-xl-none"> <i
					class="bi bi-justify fs-3"></i>
				</a>
			</header>

			<div class="page-heading" id="ok">
					<h1 style="color:red">
						(Security)안녕하세요? <br>
						PM 페이지 입니다<br>
						매니저PM(연결 계정: <sec:authentication property="name"/>) 님의 <br>
						메인 화면입니다.<br><br><br>
					</h1>
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
						
					
							<script>
							$(document).ready(function(){
								
							})
							
							</script>

							<div class="card" style="border : 3px solid gold">
								<div class="card-header"><h4>프로젝트 시작과 종료</h4></div>
								<div class="card-body">
										<form id="frm01" class="form" action="${path}/projectManageMain.do" 	method="post">
									<div class="dataTable-wrapper dataTable-loading no-footer sortable searchable fixed-columns">
											<div class="dataTable-top">
												<div class="input-group-prepend">
													<input type="hidden" name="curPage" value="1" /> <span
														class="input-group-text">총 ${projectSch.count}건</span>
												</div>
							
												<div class="dataTable-dropdown">
													<select class="dataTable-selector form-select" name="pageSize">
														<option value="3">3</option>
														<option value="5">5</option>
														<option value="10" selected="selected">10</option>
														<option value="15">15</option>
														<option value="20">20</option>
														<option value="25">25</option>
													</select><label>entries per page</label>
												</div>
						
						
												<script>
												$(document).ready(function(){
													$( ".searchbar" ).change(function() {
														  alert( "검색 종류를 변경합니다." );
														  $(".searchWhat").attr("name", this.value)
														  alert($(".searchWhat").value)
												 });
												
												});
												
												</script>
						
						
						
													<div class="dataTable-search" style="display: inline-block; ">
														
														<div style="display: inline-block;" >
															<select class="dataTable-selector form-select searchbar" 
															name="searchbar" style="display: inline-block; ">
																	<option selected="selected">검색</option>
																	<option value="name" selected="selected">name</option>
																	<option value="contents">contents</option>
															</select>
															</div>
															
															<div style="display: inline-block;" >
															<input style="display: inline-block; " class="dataTable-input searchWhat" placeholder="검색어를 입력" type="text"
																name="name" value="${projectSch.name}"> 
															  <button class="btn btn-info" type="submit">검색</button>
															<a class="btn btn-danger" style="text-align: right"
															data-bs-toggle="modal" data-bs-target="#inlineForm">메모 쓰기</a>
															</div>
													</div>
						
						
											
										</div>
										</div>
								</form>

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
															<td id="progress" style="cursor: pointer;" data-bs-toggle="modal"  data-bs-target="#inlineForm">
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
													<ul class="pagination  justify-content-end">
														<li class="page-item"><a class="page-link"
															href="javascript:goPage(${projectSch.startBlock!=1?projectSch.startBlock-1:1})">Previous</a></li>
														<c:forEach var="cnt" begin="${projectSch.startBlock}"
															end="${projectSch.endBlock}">
															<li class="page-item ${cnt==projectSch.curPage?'active':''}">
																<!-- 클릭한 현재 페이지 번호 --> <a class="page-link"
																href="javascript:goPage(${cnt})">${cnt}</a>
															</li>
														</c:forEach>
														<li class="page-item"><a class="page-link"
															href="javascript:goPage(${projectSch.endBlock!=projectSch.pageCount?projectSch.endBlock+1:projectSch.endBlock})">Next</a></li>
													</ul>
										</div>
									</div>
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
								<div class="avatar avatar-xl" id="myface">
								</div>
								<div class="ms-3 name">
									<h5 class="font-bold">${project.name } 님</h5>
									<h6 class="text-muted mb-0">직책 : ${project.auth } <br>${project.email} </h6>
								</div>
							</div>
						</div>
					</div>
					
					
					
					
					<div class="card">
						<div class="card-header">
							<h4>최근 온 메시지</h4>
						</div>
						<div class="card-content pb-4">
						
						<!-- 
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
							-->
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
						
						      //  chart.draw(data, options);
						      }
						    </script>
						    <!-- 
						<div id="chart_div2"></div>
						 -->
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
								
								        //chart.draw(data, options);
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

        //chart.draw(data, options);
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

	<form action="/project5/projectProgressUpdate.do" id="frm01">
		<div class="modal fade text-left" id="inlineForm" tabindex="-1"
			role="dialog" aria-labelledby="myModalLabel33" aria-hidden="true">
			<div
				class="modal-dialog modal-dialog-centered modal-dialog-scrollable"
				role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title" id="myModalLabel33">프로젝트 상태 변경</h4>
						<button type="button" class="close" data-bs-dismiss="modal"
							aria-label="Close">
							<i data-feather="x"></i>
						</button>
					</div>

					<div class="modal-body">
						<label>project : </label>
						<div class="form-group">
							<select class="form-control" name="projectkey">
								<c:forEach var="list" items="${list }" varStatus="idx">
									<option value="${idx.index+1 }">${idx.index+1}:
										${list.name}</option>
								</c:forEach>
							</select>
						</div>


						<label>progress: </label>
						<div class="form-group">
							<select class="form-control" name="progress">
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
							<i class="bx bx-x d-block d-sm-none"></i> <span
								class="d-none d-sm-block">닫기</span>
						</button>
						<button type="submit" class="btn btn-danger ml-2">
							<i class="bx bx-check d-block d-sm-none"></i> <span
								class="d-none d-sm-block">수정</span>
						</button>
					</div>

				</div>
			</div>
		</div>

	</form>













</body>






    

</html>