<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	$(document)
			.ready(
					function() {

					})
</script>


<body>
<%@ include file="../chatBot/chatBot.jsp"%>
	<%@ include file="../common/header.jsp"%>
	<div id="main">
		<section id="multiple-column-form">
			<div class="row match-height">
				<div class="col-12">
					<div class="card">

						<div class="card-header">
							<h4 class="card-title">투표 결과</h4>
						</div>
						<input type="hidden" name="memberkey" value="${member.memberkey }">
						<div class="card-content">
							<div class="card-body">

								<div class="row">
									<div class="col-md-6 col-12">
										<div class="form-group">
											<label for="first-name-column">투표 주제</label> <input
												type="text" id="first-name-column" class="form-control"
												placeholder="프로젝트 명" name="title" value="${get.title}"
												readonly="readonly">
										</div>
									</div>
									<div class="col-md-6 col-12">
										<div class="form-group">
											<label for="last-name-column">작성자 : </label> <input
												type="text" id="last-name-column" class="form-control"
												placeholder="Last Name" value="${get.memberkey}"
												readonly="readonly">
										</div>
									</div>
									<div class="col-md-6 col-12">
										<div class="form-group">
											<label for="city-column">시작일</label> <input type="date"
												id="city-column" class="form-control" placeholder="City"
												name="writedateS" value="${get.writedate}"
												readonly="readonly">
										</div>
									</div>
									<div class="col-md-6 col-12">
										<div class="form-group">
											<label for="city-column">마감일</label> <input type="date"
												id="city-column" class="form-control" placeholder="City"
												name="enddateS" value="${get.enddate}" readonly="readonly">
										</div>
									</div>


									<div class="col-md-6 col-12">
										<div class="form-group">
											<label for="first-name-column">프로젝트</label> <input
												type="text" id="first-name-column" class="form-control"
												name="voteoption" value="${get.projectkey }"
												readonly="readonly">


										</div>

									</div>

									<div class="col-md-6 col-12">
										<div class="form-group">
											<label for="country-floating">옵션</label> <input type="text"
												id="country-floating" class="form-control" name="voteoption"
												value="${get.voteoption }" readonly="readonly">
										</div>
									</div>

								</div>


								<div class="rows">
									<div class="col-md-6 col-12" style="width: 100%">
										<div class="form-group">
											<label for="email-id-column">설명</label>
											<textarea class="form-control" name="contents"
												placeholder="Contents" rows="4" readonly="readonly">value="${get.contents}"</textarea>
										</div>
									</div>
								</div>

								<div>
									<br> <br>
								</div>

									<div>
										<br> <br>
									</div>






								<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
								    <script type="text/javascript">
								    
										var voteItem5 = parseInt("${get.voteItem5}");
								    
								      	google.charts.load("current", {packages:["corechart"]});
								     	 google.charts.setOnLoadCallback(drawChart);
									      function drawChart() {
									        var data = google.visualization.arrayToDataTable(
									       	[
									       	['Task', 'Hours per Day'],
									          [ '${get.item1}',  parseInt('${get.voteItem1}')],
									          [ '${get.item2}',  parseInt('${get.voteItem2}')],
									          [ '${get.item3}',  parseInt('${get.voteItem3}')],
									          [ '${get.item4}',  parseInt('${get.voteItem4}')],
									          [ '${get.item5}',  parseInt('${get.voteItem5}')],
									        ]);
									
									        var options = {
									          title: '투표 결과',
									          is3D: true,
									        };
									
									        var chart = new google.visualization.PieChart(document.getElementById('piechart_3d'));
									        chart.draw(data, options);
									      }
								    </script>
								    
								    
								    
								    
								    
									<div class="rows">
										<div class="col-md-6 col-12" style="margin-left: 400px; font-size: 35px;">
												 <div id="piechart_3d" style="width: 900px; height: 500px;"></div>
										</div>
									</div>


















									<div class="col-12 d-flex justify-content-end">
										<button type="button" class="btn btn-primary me-1 mb-1"
											id="voting">투표 하기</button>
										<button type="button" class="btn btn-danger me-1 mb-1"
											onclick="location.href='/project5/voteResult.do?votekey=${get.votekey}'">투표 결과</button>
										<button type="button" class="btn btn-info me-1 mb-1"
											onclick="location.href='/project5/projectHome.do?projectkey=1'">뒤로가기</button>
											<button type="button"
												class="btn btn-light-secondary me-1 mb-1">투표  삭제</button>
											<button type="button"
												class="btn btn-light-black me-1 mb-1">투표  수정</button>
									</div>
							</div>
						</div>

					</div>
				</div>
			</div>
		</section>
	</div>

</body>
</html>