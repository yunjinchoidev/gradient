<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />
<!DOCTYPE html>
<%--


 --%>
<html>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<head>

<!-- 구글 어닐리틱스 -->
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-SKC411JKMD"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'G-SKC411JKMD');
</script>


<meta charset="UTF-8">
<title>GRADIENT</title>
<script type="text/javascript">
	$(document).ready(function() {
		var psc = "${psc}";
		console.log("psc : " + psc);
		if (psc == "success") {
			alert("로그인 성공하셨습니다.");
		}

		if (psc == "logout") {
			alert("로그아웃 되었습니다.");
		}
		
			$("#selectLan").val("${param.lang}")
			$("#selectLan").change(function(){
				if($(this).val()!=""){
					location.href="${path}/choiceLan2.do?lang="+$(this).val();
				}else{
					location.href="${path}/choiceLan2.do?lang=korean"
				}
			});
	})
</script>
  <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
      
</head>

<body>
	<%@ include file="chatBot/chatBot.jsp"%>
	<%@ include file="common/header.jsp"%>
<div id="main">
            <header class="mb-3">
                <a href="#" class="burger-btn d-block d-xl-none">
                    <i class="bi bi-justify fs-3"></i>
                </a>
            </header>

            <div class="page-heading">
                <h1>Gradient 메인 페이지</h1>
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
                                                <h6 class="text-muted font-semibold">나의 정보</h6>
                                                <h6 class="font-extrabold mb-0"><span style="color:red; cursor: pointer;"
                                                onclick="location.href='/project5/memberEdit.do?memberkey=${member.memberkey }'">
                                                바로가기</span></h6>
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
                                                <h6 class="text-muted font-semibold">나의 캘린더</h6>
                                                <h6 class="font-extrabold mb-0"><span style="color:red; cursor: pointer;"
                                                onclick="location.href='/project5/myCalendar.do?memberkey=${member.memberkey }'">
                                                바로가기</span></h6>
                                            
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
                                                <h6 class="text-muted font-semibold">나의 프로젝트</h6>
                                                <h6 class="font-extrabold mb-0"><span style="color:red; cursor: pointer;"
                                                onclick="location.href='/project5/myProject.do?memberkey=${member.memberkey }'">
                                                바로가기</span></h6>
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
                                                <h6 class="text-muted font-semibold">나의 작업</h6>
                                                <h6 class="font-extrabold mb-0"><span style="color:red; cursor: pointer;"
                                                onclick="location.href='/project5/myWork1.do?memberkey=${member.memberkey }'">
                                                바로가기
                                                </span></h6>
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
                                        <h3>프로젝트 별 팀원 수</h3>
                                    </div>
                                    <div class="card-body" style="position: relative; width: 800px; height: 500px;" >
                                     <div id="columnchart_values" style="width: 800px; height: 500px;"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        
                        
				                        <script>
				                     	$(document).ready(function(){
			                           		$.ajax({
			                           			url:'/project5/projectTeamCnt.do',
			                           			type:'POST',
			                           			dataType:'json',
			                           			success:function(result){
			                           				console.log("projectTeamCnt.do 성공")
			                           				console.log(result)
			                           				console.log(result.projectTeamCnt[0].count)
			                           				console.log(result.projectTeamCnt[0].projectkey)
			                           				D = [
												        ["Element", "Density", { role: "style" } ],
												        [result.projectTeamCnt[0].projectkey, result.projectTeamCnt[0].count, "#b87333"],
												        [result.projectTeamCnt[1].projectkey, result.projectTeamCnt[1].count, "#b87333"],
												        [result.projectTeamCnt[2].projectkey, result.projectTeamCnt[2].count, "#b87333"],
												        [result.projectTeamCnt[3].projectkey, result.projectTeamCnt[3].count, "#b87333"],
												        [result.projectTeamCnt[4].projectkey, result.projectTeamCnt[4].count, "#b87333"],
												        [result.projectTeamCnt[5].projectkey, result.projectTeamCnt[5].count, "#b87333"],
												        [result.projectTeamCnt[6].projectkey, result.projectTeamCnt[6].count, "#b87333"],
												        [result.projectTeamCnt[7].projectkey, result.projectTeamCnt[7].count, "#b87333"]
												      ]
			                           			},
			                           			error:function(result){
			                           				console.log("projectTeamCnt.do 실패")
			                           			}
			                           		})
				                        google.charts.load("current", {packages:['corechart']});
									    google.charts.setOnLoadCallback(drawChart);
									    var D;
									    function drawChart() {
									      var data = google.visualization.arrayToDataTable(D);
									
									      var view = new google.visualization.DataView(data);
									      view.setColumns([0, 1,
									                       { calc: "stringify",
									                         sourceColumn: 1,
									                         type: "string",
									                         role: "annotation" },
									                       2]);
									
									      var options = {
									        title: "프로젝트 별 팀원 수 차트",
									        width: 1000,
									        height: 400,
									        bar: {groupWidth: "95%"},
									        legend: { position: "none" },
									      };
									      var chart = new google.visualization.ColumnChart(document.getElementById("columnchart_values"));
									      chart.draw(view, options);
									  }
										
										
				                     	});
										</script>       
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        <div class="row">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h3>회원 방문수 분석</h3>
                                    </div>
                                    <div class="card-body" style="position: relative;">
                                    <div id="chart_div4" style="width: 900px; height: 500px;"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                           <script type="text/javascript">
                           	$(document).ready(function(){
                           		$.ajax({
                           			url:'/project5/visitCount.do',
                           			type:'POST',
                           			dataType:'json',
                           			success:function(result){
                           				console.log("visitCount.do 성공")
                           				console.log(result)
                           				console.log(result.visitCount1)
                           				A = [
									        [10, result.visitCount1],   [100, result.visitCount2],
									        [300, result.visitCount3],  [1000, result.visitCount4]
									      ]
                           			},
                           			error:function(result){
                           				console.log("projectTeamCnt.do 실패")
                           			}
                           		})
                           	
                           		
                           			var A;
                           		
									     google.charts.load('current', {packages: ['corechart', 'line']});
												google.charts.setOnLoadCallback(drawBackgroundColor);
												
												function drawBackgroundColor() {
												      var data = new google.visualization.DataTable();
												      data.addColumn('number', 'X');
												      data.addColumn('number', '방문 수 별 회원 수');
												
												      data.addRows(A);
												
												      var options = {
												        hAxis: {
												          title: '회원 수'
												        },
												        vAxis: {
												          title: '방문수'
												        },
												        backgroundColor: ''
												      };
												
												      var chart = new google.visualization.LineChart(document.getElementById('chart_div4'));
												      chart.draw(data, options);
												    }
                           	})
									    </script>
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        <div class="row">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h3>프로젝트 상태 별 프로젝트 수 차트</h3>
                                    </div>
                                    <div class="card-body" style="position: relative;">
                                       <div id="curve_chart" style="width: 800px; height: 500px"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
					                         <script type="text/javascript">
					                         $(document).ready(function(){
					                           		$.ajax({
					                           			url:'/project5/progressCnt.do',
					                           			type:'POST',
					                           			dataType:'json',
					                           			success:function(result){
					                           				console.log("progressCnt.do 성공")
					                           				console.log(result.progressCnt)
					                           				B = [
														          ['프로젝트', '팀원 수'],
														          [result.progressCnt[0].progress,  result.progressCnt[0].count],
														          [result.progressCnt[1].progress,  result.progressCnt[1].count],
														          [result.progressCnt[2].progress,  result.progressCnt[2].count],
														          [result.progressCnt[3].progress,  result.progressCnt[3].count],
														          [result.progressCnt[4].progress,  result.progressCnt[4].count]
														        ]
					                           			},
					                           			error:function(result){
					                           				console.log("progressCnt.do 실패")
					                           			}
					                           		})
											      google.charts.load('current', {'packages':['corechart']});
											      google.charts.setOnLoadCallback(drawChart);
											var B
											      function drawChart() {
											        var data = google.visualization.arrayToDataTable(B);
											
											        var options = {
											          title: 'Company Performance',
											          curveType: 'function',
											          legend: { position: 'bottom' }
											        };
											
											        var chart = new google.visualization.LineChart(document.getElementById('curve_chart'));
											
											        chart.draw(data, options);
											      }
											      
					                         });
											    </script>
                        
                        
                        
                        
                    </div>
                    
                    
                    
                    
                    
                    
                    
                    <script>
                    $(document).ready(function(){
                 		var memberkey;
        		  		console.log("memberkey"+memberkey);
        				// ajax를 통한 파일 정보 불러오기 
        				// 페이지 접속시 자동으로 실행
        				var memberkeyValue =parseInt("${member.memberkey}");
        				var data = { memberkey : memberkeyValue};
        			    $.ajax({
        			      url: '/project5/myfaceData.do',
        			      data: data,
        			      type: 'POST',
        			      dataType:'json',
        			        success: function(result){
        			        console.log(result)
        			          console.log(result.myfaceData[0]); 
        			          console.log("파일 불러오기 완료")
        			          
        			          if(result.myfaceData[0].fname == 1){
        			        	  console.log("눌입니다.")
        			          }else{
            					  showUploadResult2(result.myfaceData[0]);// 이곳에서 함수 호출         			        	
        			          }
        			          

        			      },
        			      error: function(result){
        			    	  console.log(memberkey)
        			          console.log("회원 이미지 정보 불러오기 실패");
        			          console.log(result); 
        			      }
        			    }); //$.ajax
        			    
        			    
        			    
        				// 이미지 클라리언트 딴에 띄우는 합수
        				// 외래키 없이 업로드 한 파일 결과 클라이언트 단으로 가져오기 함수
        			  function showUploadResult2(obj){
        				    		console.log("obj"+obj);
        							var fileCallPath =  encodeURIComponent(obj.fname);
        							console.log(fileCallPath);
        							var go="/project5/display2.do?fileName="+fileCallPath;
        							$("#not").attr("src",go)
        				  }
                    })
                    
                    </script>
                    
                    
                    <div class="col-12 col-lg-4">
                        <div class="card">
                            <div class="card-body py-4 px-5">
                                <div class="d-flex align-items-center">
                                    <div class="avatar avatar-xl">
                                        <img src="/project5/resources/user.png" id="not" >
                                    </div>
                                    <div class="ms-3 name">
                                    <c:if test="${empty  member.name}">
	                                    <h5 class="font-bold">미 로그인 상태입니다</h5>
	                                    <h6 class="text-muted mb-0"></h6>
                                    </c:if>
                                    
                                    <c:if test="${not empty  member.name}">
                                        <h5 class="font-bold">${member.name }</h5>
                                        <h6 class="text-muted mb-0">${member.email }</h6>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        
                        
                        
                        <script>
                        $(document).ready(function(){
                    		var memberkey = parseInt(${member.memberkey})
							var godata = {memberkey : memberkey}
								// 화면 로딩 되자 마자 목록을 모조리 불러온다
								$.ajax({
									url : '/project5/chattingRoomList.do',
									type:'POST',
									data : godata,
									dataType:'json',
									success:function(result){
										console.log(result);
										console.log(result.chatRoomList)
										
										var consultChatList = $("#chattingRoomList");
										for(var i=0; i<result.chatRoomList.length; i++){
												var str="";
												str+="  <div class='recent-message d-flex px-4 py-3'>"
												str+="    <div class='avatar avatar-lg'>"
												str+="         <img src='/project5/resources/dist/assets/images/faces/1.jpg'></div>"
												str+="    <div class='name ms-4'>"
												str+="        <h6 class='mb-1'>"+result.chatRoomList[i].name+"</h6>"
												str+="        <h6 class='text-muted mb-0'></h6>"
												str+="    </div></div>"
													consultChatList.append(str);
				                                
												
												/*
												str +=" <a class='list-group-item list-group-item-action active text-white rounded-0' onclick='MessageListFunc(this)' style='cursor:pointer;'>"+"["+result.chatRoomList[i].roomkey +"]번방 &nbsp  "
												str +="   <div class='media'><img src='https://bootstrapious.com/i/snippets/sn-chat/avatar.svg' alt='user' width='50' class='rounded-circle'>"
												str +="    <div class='media-body ml-4'>"
												str +="        <div class='d-flex align-items-center justify-content-between mb-1'>"
								                str +="         <h4 class='mb-0' style='color:white'>"+result.chatRoomList[i].name+"</h4><small class='small font-weight-bold'>"+result.chatRoomList[i].makedateS+"</small> </div>"
							                	str +="         <p class='font-italic mb-0 text-small'></p></div></div></a>"
							                	*/
										
										}
									}
								})
                        	
                        	
                        })
                        
                        </script>
                        
                        
                        
                        
                        <div class="card">
                            <div class="card-header">
                                <h3>나의 참여 채팅</h3>
                            </div>
                            <div class="card-content pb-4" >
                                <div id="chattingRoomList">
                                
                                </div>
                                
                                
                                <div class="px-4">
                                    <button class="btn btn-block btn-xl btn-light-primary font-bold mt-3"
                                    onclick="location.href='/project5/chatting.do?memberkey=${member.memberkey}'">채팅 바로 가기</button>
                                </div>
                            </div>
                            
                        </div>
                        
                        
                        <div class="card">
                            <div class="card-header">
                                <h3>회원 권한 분포 차트</h3>
                            </div>
                            <div class="card-body" style="position: relative;">
                             <div id="piechart_3d" style="width: 100%; height: 600px;"></div>
                            </div>
                        </div>
                        
                        
                        
                        <script type="text/javascript">
                        $(document).ready(function(){
                       		$.ajax({
                       			url:'/project5/authCount.do',
                       			type:'POST',
                       			dataType:'json',
                       			success:function(result){
                       				console.log("authCount.do 성공")
                       				console.log(result.authCount[0])
                       				C =[
          					          ['Task', 'Hours per Day'],
        					          [result.authCount[0].auth,     result.authCount[0].count],
        					          [result.authCount[1].auth,     result.authCount[1].count],
        					          [result.authCount[2].auth,     result.authCount[2].count],
        					          [result.authCount[3].auth,     result.authCount[3].count]
        					        ]
                       			},
                       			error:function(result){
                       				console.log("progressCnt.do 실패")
                       			}
                       		})
					      google.charts.load("current", {packages:["corechart"]});
					      google.charts.setOnLoadCallback(drawChart);
					      var C;
					      function drawChart() {
					        var data = google.visualization.arrayToDataTable(C);
					
					        var options = {
					          title: '회원 권한 분포',
					          is3D: true,
					        };
					
					        var chart = new google.visualization.PieChart(document.getElementById('piechart_3d'));
					        chart.draw(data, options);
					      }
					      
                        });
					    </script>
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                    </div>
                </section>
            </div>

        </div>




</body>

</html>