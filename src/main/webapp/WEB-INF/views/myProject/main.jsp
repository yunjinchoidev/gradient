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
<title>나의 프로젝트</title>
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


<script>
$(document).ready(function(){
	var memberkey = "${member.memberkey}";
	if(memberkey==""){
		alert("미 로그인시 접근 불가합니다.")
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
					<div class="col-12 col-md-6 order-md-1 order-last">
						<h3>나의 모든 프로젝트</h3>
						<p class="text-subtitle text-muted">
						내가 참여하고 있는 프로젝트 입니다.
						</p>
					</div>
					<div class="col-12 col-md-6 order-md-2 order-first">
						<nav aria-label="breadcrumb"
							class="breadcrumb-header float-start float-lg-end"></nav>
					</div>
				</div>
			</div>
			
			<!-- 
			<section class="section">
				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-header">
								<h5 class="card-title">대시보드입니다.</h5>
							</div>
							<div class="card-body">나의 프로젝트 나의 프로젝트 나의 프로젝트 나의 프로젝트 나의 프로젝트 나의
								프로젝트 나의 프로젝트 나의 프로젝트 나의 프로젝트 나의 프로젝트 나의 프로젝트 나의 프로젝트 나의 프로젝트 나의
								프로젝트 나의 프로젝트 나의 프로젝트 나의 프로젝트 나의 프로젝트 나의 프로젝트 나의 프로젝트 나의 프로젝트 나의
								프로젝트 나의 프로젝트 나의 프로젝트 나의 프로젝트 나의 프로젝트 나의 프로젝트 나의 프로젝트 나의 프로젝트 나의
								프로젝트</div>
						</div>
					</div>
				</div>
			</section>
			 -->
		</div>


		<div class="page-heading">
			<div class="page-title">
				<div class="row">
					<div class="col-12 col-md-6 order-md-1 order-last">
						<h3>나의 프로젝트</h3>
						<p class="text-subtitle text-muted" onclick="location.href='/project5/dashBoard.do?projectkey=1'">내가 참여중인 프로젝트가 여기 있습니다.</p>
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
			function gogo(data,key){
				console.log(key)
				location.href="/project5/dashBoard.do?projectkey="+key
			}
			
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
							        console.log("성공")
										console.log(result.projectInfo.name)
										console.log(result.fileInfo[0].fname)
									  showProjectCard(result.projectInfo, result.fileInfo[0].fname);             // 함수 호출
							      },
							      error: function(result){
							          console.log("불러오기 실패");
							          console.log(result);
							      }
							    }); //$.ajax
							    
							    
			    </c:forEach>
							    
							    
							    
			
					
			  function showProjectCard(obj, fname){
				  console.log("!!!")
				  console.log(obj.projectkey)
				    var uploadUL = $("#content-types");
				    var str ="";
				    		console.log("obj"+obj);
							var fileCallPath =  encodeURIComponent(fname);
							console.log(fileCallPath);
								str += "<div class='card' style='margin-right:40px; width: 470px; cursor:pointer;' id='go' onclick='gogo(this,"+obj.projectkey+")'>"
									str += "<div class='card-content' id='prjImg'>"
										str += "<div class='card-body'>"
											str += "<h5 class='card-title' >"+obj.name+"</h5>"
											str += "<p class='card-text' style='display:inline-block'>"+obj.contents+"</p>"
											str += "<a href='#' class='btn btn-danger rounded-pill progressBtn' style='display:inline-block; margin-left:20px;'>"+obj.progress+"</a>"
											str += "</div><hr>"
											str += "<img src='/project5/display2.do?fileName="+fileCallPath+"' class='card-img-top img-fluid' alt='singleminded' style='width:100%; height:400px' >";
											str += "<ul class='list-group list-groue-flush'>"
											str += "<li class='list-group-item'> 타이틀 : ["+obj.projectkey+"]"+obj.name+"</li>"
											str += "<li class='list-group-item'> 수주액 : "+obj.take+"</li>"
											str += "<li class='list-group-item'> 설명 : "+obj.contents+"</li>"
											str += "<li class='list-group-item'> 진행 정도 : "+obj.progress+"</li>"
									str += "</div>"
									str += "</div>"
									
									
									console.log("str : "+str)
						    		uploadUL.append(str);
									console.log("uploadUL : "+uploadUL)
				  }
			
			
			  var i=0;
			setInterval(function(){
				i++;
				if(i%2==0){
					  $(".progressBtn").hide()					
				}else{
					  $(".progressBtn").show()			
				}
			}, 1000)


			  
			  
			  
						
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