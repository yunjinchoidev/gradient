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
  <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="/project5/resources/dist/assets/js/pages/ui-chartjs.js"></script>
<script
	src="/project5/resources/dist/assets/vendors/perfect-scrollbar/perfect-scrollbar.min.js"></script>
<script
	src="/project5/resources/dist/assets/vendors/chartjs/Chart.min.js"></script>
<meta charset="UTF-8">
<title>쌍용 5조 PMBOK 메인 페이지</title>
<script>
	$(document).ready(function() {
		var psc = "${psc}";

		if (psc == "success") {
			alert("로그인 성공하셨습니다.");
		}

		if (psc == "logout") {
			alert("로그아웃 되었습니다.");
		}
	})
</script>

<style type="text/css">/* Chart.js */
@
keyframes chartjs-render-animation {
	from {opacity: .99
}

to {
	opacity: 1
}

}
.chartjs-render-monitor {
	animation: chartjs-render-animation 1ms
}

.chartjs-size-monitor, .chartjs-size-monitor-expand,
	.chartjs-size-monitor-shrink {
	position: absolute;
	direction: ltr;
	left: 0;
	top: 0;
	right: 0;
	bottom: 0;
	overflow: hidden;
	pointer-events: none;
	visibility: hidden;
	z-index: -1
}

.chartjs-size-monitor-expand>div {
	position: absolute;
	width: 1000000px;
	height: 1000000px;
	left: 0;
	top: 0
}

.chartjs-size-monitor-shrink>div {
	position: absolute;
	width: 200%;
	height: 200%;
	left: 0;
	top: 0
}
</style>
</head>

<body>

	<%@ include file="../common/header.jsp"%>


	<div id="main">

		<div class="page-heading">
			<div class="page-title">
				<div class="row">
					<div class="col-12 col-md-6 order-md-1 order-last">
						<h3>공개된 모든 프로젝트</h3>
						<p class="text-subtitle text-muted">대시보드입니다.</p>
					</div>
					<div class="col-12 col-md-6 order-md-2 order-first">
						<nav aria-label="breadcrumb"
							class="breadcrumb-header float-start float-lg-end"></nav>
					</div>
				</div>
			</div>
			<section class="section">
				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-header">
								<h5 class="card-title">대시보드입니다.</h5>
							</div>
							<div class="card-body">
								대시보드입니다. <a href="https://github.com/yunjinchoidev/project5"
									target="_blank">대시보드입니다.<br> <br>
								</a>
							</div>
						</div>
					</div>
				</div>
			</section>
		</div>

		<div class="page-heading">
			<div class="page-title">
				<div class="row">
					<div class="col-12 col-md-6 order-md-1 order-last">
						<h3>공개된 모든 프로젝트</h3>
						<p class="text-subtitle text-muted">공개된 모든 프로젝트가 여기 있습니다.</p>
					</div>
					<div class="col-12 col-md-6 order-md-2 order-first">
						<nav aria-label="breadcrumb"
							class="breadcrumb-header float-start float-lg-end">
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="index.html">Dashboard</a></li>
								<li class="breadcrumb-item active" aria-current="page">Card</li>
							</ol>
						</nav>
					</div>
				</div>

			</div>





		<script>
			$(document).ready(function() {
				
				<c:forEach var="list" items="${list}">
								var projectkey = "${list.projectkey}";
								console.log("projectkey"+projectkey);
								 var data = { projectkey : projectkey};
								
								 // 프로젝트 데이터 가져오기
								 $.ajax({
							      url: '/project5/projectData.do',
							      data: data,
							      type: 'POST',
							      dataType:'json',
							        success: function(result){
							        console.log("=================")
							          console.log("프로젝트 데이터 불러오기완료")
							          console.log("프로젝트 이미지 파일 데이터 불러오기완료")
							          	console.log(result)
										console.log(result.projectInfo.name)
										console.log(result.fileInfo)
										console.log(result.fileInfo[0].fname)
									  showProjectCard(result.projectInfo, result.fileInfo[0].fname);             // 함수 호출
									  console.log("=================")
									  
							      },
							      error: function(result){
							          console.log("불러오기 실패");
							          console.log(result);
							      }
							    }); //$.ajax
							    
							    
							    $.ajax({
							      url: '/project5/projectImg.do',
							      data: data,
							      type: 'POST',
							      dataType:'json',
							        success: function(result){
							          console.log("프로젝트 이미지 파일 불러오기 완료")
									  //showUploadResult2(result.get[0]);// 함수 호출 
							      },
							      error: function(result){
							          console.log("불러오기 실패");
							          console.log(result); 
							      }
							    }); //$.ajax
			    </c:forEach>
							    
							    
							    
				
			  function showProjectCard(obj, fname){
				    var uploadUL = $("#content-types");
				    var str ="";
				    		console.log("obj"+obj);
							var fileCallPath =  encodeURIComponent(fname);
							console.log(fileCallPath);
								str += "<div class='card' style='margin-right: 40px; width: 470px; cursor: pointer;' >"
									str += "<div class='card-content' id='prjImg'>"
										str += "<img src='/project5/display2.do?fileName="+fileCallPath+"' class='card-img-top img-fluid' alt='singleminded' style='width:100%; height:400px' >";
										str += "<div class='card-body'>"
												str += "<h5 class='card-title' onclick='location.href='/project5/dashBoard.do?projectkey="  + obj.projectkey +  " ''>"+obj.name+"</h5>"
												str += "<p class='card-text'>"+obj.contents+"</p>"
											str += "</div></div>"
											str += "<ul class='list-group list-groue-flush'>"
												str += "<li class='list-group-item'> 타이틀 : ["+obj.projectkey+"]"+obj.name+"</li>"
												str += "<li class='list-group-item'> 수주액 : "+obj.take+"</li>"
												str += "<li class='list-group-item'> 설명 : "+obj.contents+"</li>"
												str += "<li class='list-group-item'> 진행 정도 : "+obj.progress+"</li>"
										str += "</ul>"
								str += "</div>"
							console.log("str"+str)
				    uploadUL.append(str);
				  }
						
				// 파일 다운로드		
				function downFile(fname){
					if(confirm("다운로드할 파일:"+fname)){
						location.href="${path}/download.do?fname="+fname;
					}
				}
			
			
		});
		</script>



			<section id="content-types" style="display: flex; flex-direction: row; flex-wrap: wrap;">
			</section>
			

		</div>
	</div>

</body>
</html>