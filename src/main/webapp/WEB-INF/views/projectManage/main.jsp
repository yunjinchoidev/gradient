<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
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

						
						
						
						//$("#progress").click(function(){
						//	alert("프로젝트 진행 상태를 바꾸시겠습니까?");
						//})

						var memberkey;
						// ajax를 통한 파일 정보 불러오기 
						// 페이지 접속시 자동으로 실행
						var memberkeyValue = "${member.memberkey}";
						console.log(memberkey);
						var data = {
							memberkey : memberkeyValue
						};
						// 업로드 파일 결과 가져오기
						$.ajax({
							url : '/project5/aaaa.do',
							data : data,
							type : 'POST',
							dataType : 'json',
							success : function(result) {
								console.log(result);
								console.log("파일 불러오기 완료")
								showUploadResult2(result.get[0]);//////////////////////////////////////////////////////////////////////// 이곳에서 함수 호출 
							},
							error : function(result) {
								console.log(memberkey)
								console.log("회원 이미지 정보 불러오기 실패");
								console.log(result);
							}
						}); //$.ajax

						// 이미지 클라리언트 딴에 띄우는 합수
						// 외래키 없이 업로드 한 파일 결과 클라이언트 단으로 가져오기 함수
						function showUploadResult2(uploadResultArr) {
							if (!uploadResultArr || uploadResultArr.length == 0) {
								return;
							}
							var uploadUL = $("#myface");
							var str = "";
							$(uploadResultArr)
									.each(
											function(i, obj) {
												console.log("obj" + obj);
												var fileCallPath = encodeURIComponent(obj.fname);
												console.log(fileCallPath);
												str += "<img src='/project5/display2.do?fileName="
														+ fileCallPath + "' style='width:100px; height:80px; margin-left:30px;'>";
												console.log("str : " + str)
											})
							uploadUL.append(str);
						}
						///////////////////////////////////////////////////////////////

						var pageSize = "${projectSch.pageSize}"
						$("[name=pageSize]").val(pageSize);
						$("[name=pageSize]").change(function() {
							$("[name=curPage]").val(1);
							$("#frm01").submit();
						});

						var msg = "${msg}";
						if (msg != "") {
							if (confirm(msg + "\n메인화면으로 이동할까요?")) {
								location.href = "/project5/projectManageMain.do";
							}
						}

					})

	function goPage2(no) {
		$("[name=curPage]").val(no);
		$("#frm01").submit();
	}
	
	
	
	
	
	
</script>




<body>

	<%@ include file="../chatBot/chatBot.jsp"%>
	<%@ include file="../../../view/common/header.jsp"%>

	<div id="main">
		<header class="mb-3">
			<a href="#" class="burger-btn d-block d-xl-none"> <i
				class="bi bi-justify fs-3"></i>
			</a>
		</header>

		<div class="page-heading" id="ok">
			<h1 style="color: red">
				<sec:authentication property="name" />
				 님, 안녕하세요?<br>
			</h1>
			<h2>프로젝트 관리 페이지 </h2>
			<h3>오직 PM만을 위해 제공하는 정보가 여기 있습니다.</h2>
		</div>




		<div class="page-content">
		
		
			<section class="row">
				<div class="col-12 col-lg-12">
				<!-- 
					<div class="row">
						
						<div class="col-6 col-lg-6 col-md-6">

							<div class="card">
								<div class="card-body px-3 py-4-5">
									<div class="row">
										<div class="col-md-4" id="myface">
										</div>
										<div class="col-md-8">
											<h6 class="text-muted font-semibold">${member.name }</h6>
											<h6 class="font-extrabold mb-0">${member.auth }</h6>
											<h6 class="font-extrabold mb-0">${member.email }</h6>
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
											<h6 class="text-muted font-semibold">Followers</h6>
											<h6 class="font-extrabold mb-0">183.000</h6>
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
											<h6 class="text-muted font-semibold">Following</h6>
											<h6 class="font-extrabold mb-0">80.000</h6>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
-->



					<script>
						$(document).ready(
								function() {
									var z = 0;

									setInterval(function() {
										z++;
										if (z % 2 == 0) {
											$("#projectManage").css("border",
													"5px solid red")
										} else {
											$("#projectManage").css("border",
													"")
										}
									}, 500);

								})
					</script>

					<div class="row">
						<div class="col-12">
							<div class="card" style="border: 3px solid gold"
								id="projectManage">
								<div class="card-header">
									<h4>프로젝트 시작과 종료</h4>
								</div>
								<div class="card-body">
									<form id="frm01" class="form"
										action="${path}/projectManageMain.do" method="post">
										<div
											class="dataTable-wrapper dataTable-loading no-footer sortable searchable fixed-columns">
											<div class="dataTable-top">
												<div class="input-group-prepend">
													<input type="hidden" name="curPage" value="1" /> 
													<input type="hidden" name="projectkey" value="30001" />
													<span
														class="input-group-text">총 ${projectSch.count}건</span>
												</div>

												<div class="dataTable-dropdown">
													<select class="dataTable-selector form-select"
														name="pageSize">
														<option value="3">3</option>
														<option value="5">5</option>
														<option value="10" >10</option>
														<option value="15" selected="selected">15</option>
														<option value="20">20</option>
														<option value="25">25</option>
													</select><label>entries per page</label>
												</div>


												<script>
													$(document)
															.ready(
																	function() {
																		$(
																				".searchbar")
																				.change(
																						function() {
																							alert("검색 종류를 변경합니다.");
																							$(
																									".searchWhat")
																									.attr(
																											"name",
																											this.value)
																							alert($(".searchWhat").value)
																						});

																	});
												</script>



												<div class="dataTable-search" style="display: inline-block;">

													<div style="display: inline-block;">
														<select class="dataTable-selector form-select searchbar"
															name="searchbar" style="display: inline-block;">
															<option selected="selected">검색</option>
															<option value="name" selected="selected">name</option>
															<option value="contents">contents</option>
														</select>
													</div>

													<div style="display: inline-block;">
														<input style="display: inline-block;"
															class="dataTable-input searchWhat" placeholder="검색어를 입력"
															type="text" name="name" value="${projectSch.name}">
														<button class="btn btn-info" type="submit">검색</button>
														<a class="btn btn-danger" style="text-align: right"
															href="/project5/projectManageInsertForm.do"
															>프로젝트 만들기
															</a>
															
															
															
														<a class="btn btn-primary" style="text-align: right"
															data-bs-toggle="modal" data-bs-target="#inlineForm">상태 변경
															</a>
															
	
													</div>
												</div>



											</div>
										</div>
									</form>

									<div class="dataTable-container">
										<table class="table table-striped dataTable-table" id="table1">
											<thead>
												<tr>
													<th data-sortable="" style="width: 15.0176%;"><a
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
													<tr>
														<td>${list.projectkey}</td>
														<td style="cursor: pointer;"
															onclick="location.href='/project5/projectManageGet.do?projectkey=${list.projectkey}'">${list.name }</td>
														<td><fmt:formatNumber>${list.take }</fmt:formatNumber>
														</td>
														<td><c:if test="${list.importance eq '하'}">
																<span class="badge bg-primary">하</span>
															</c:if> <c:if test="${list.importance eq '중'}">
																<span class="badge bg-secondary">중</span>
															</c:if> <c:if test="${list.importance eq '상'}">
																<span class="badge bg-danger">상</span>
															</c:if></td>
														<td id="progress" style="cursor: pointer;"
															data-bs-toggle="modal" data-bs-target="#inlineForm">
															<c:if test="${list.progress eq '대기'}">
																<span class="badge bg-primary">대기</span>
															</c:if>
															 <c:if test="${list.progress eq '초기'}">
																<span class="badge bg-secondary">초기</span>
															</c:if> 
															<c:if test="${list.progress eq '중기'}">
																<span class="badge bg-success">중기</span>
															</c:if> 
															<c:if test="${list.progress eq '후기'}">
																<span class="badge bg-danger">후기</span>
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
												href="javascript:goPage2(${projectSch.startBlock!=1?projectSch.startBlock-1:1})">Previous</a></li>
											<c:forEach var="cnt" begin="${projectSch.startBlock}"
												end="${projectSch.endBlock}">
												<li class="page-item ${cnt==projectSch.curPage?'active':''}">
													<!-- 클릭한 현재 페이지 번호 --> <a class="page-link"
													href="javascript:goPage2(${cnt})">${cnt}</a>
												</li>
											</c:forEach>
											<li class="page-item"><a class="page-link"
												href="javascript:goPage2(${projectSch.endBlock!=projectSch.pageCount?projectSch.endBlock+1:projectSch.endBlock})">Next</a></li>
										</ul>
									</div>
								</div>
							</div>
						</div>
					</div>












					<script>
						$(document)
								.ready(
										function() {
											$
													.ajax({
														url : '/project5/crawling.do',
														type : 'POST',
														dataType : 'json',
														success : function(
																result) {
															console
																	.log("크롤링 성공")
															console
																	.log(result.elem)
															console
																	.log(result.elem
																			.split('\.'))
															var words = result.elem
																	.split('\.');
															console.log(words)
															var crawlingHTML = $("#crawling")
															for (var i = 0; i < words.length; i++) {
																crawlingHTML
																		.append('<h5><span style="color:red">['
																				+ i
																				+ ']</span>'
																				+ words[i]
																				+ '<br></h5>')
															}

														},
														error : function(result) {
															console
																	.log("크롤링 실패")
															console.log(result)
														}
													})

											$("#basicInput")
													.change(
															function() {
																var temp = $(
																		"[name=thedate]")
																		.val()
																		.split(
																				"-");
																var datedata4 = temp[0]
																		+ temp[1]
																		+ temp[2];
																var datedata = temp[0]
																		+ temp[1]
																		+ temp[2];
																alert("데이터를 가져옵니다."
																		+ datedata);
																var datedata = {
																	datedata : datedata
																}
																$
																		.ajax({
																			url : '/project5/crawling2.do',
																			type : 'POST',
																			data : datedata,
																			dataType : 'json',
																			success : function(
																					result) {
																				console
																						.log("크롤링 성공")
																				console
																						.log(result.elem)
																				console
																						.log(result.elem
																								.split('\.'))
																				var words = result.elem
																						.split('\.');
																				console
																						.log(words)
																				var crawlingHTML = $("#crawling")
																				crawlingHTML
																						.empty();
																				crawlingHTML
																						.append('<h2 style="color:red">'
																								+ datedata4
																								+ '. 일자<br><br> 주요 IT 뉴스</h2>')
																				for (var i = 0; i < words.length; i++) {
																					crawlingHTML
																							.append('<h5><span style="color:red">['
																									+ i
																									+ ']</span>'
																									+ words[i]
																									+ '<br></h5>')
																				}
																			},
																			error : function(
																					result) {
																				console
																						.log("크롤링 실패")
																				console
																						.log(result)
																			}
																		})
															})
										})
					</script>

					<div class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-header">
									<h1>뉴스 브리핑 서비스</h1>
									<p>최신 뉴스를 한눈에</p>
									<form>
										<input type="date" class="form-control" id="basicInput"
											placeholder="Enter email" style="font-size: 30px;"
											name="thedate">
									</form>
								</div>
								<div class="card-body" style="position: relative;" id="crawling">
								</div>
							</div>
						</div>
					</div>




<!-- 
					<div class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-header">
									<h4>회원 프로젝트 배정</h4>
					
									
								</div>
							</div>
						</div>
					</div>
					
		 -->			
					
					
					
					
					
					
					<div class="row"  >
						<div class="col-12">
							<div class="card">
								<div class="card-header">
									<h4>근태 평가
									<a href="#"  class="btn btn-danger" id="goDetail">상세 화면으로 </a> 
									</h4>
								
													<select id="go" class="dataTable-selector form-select"  style="width: 30%">
													<c:forEach items="${pjList }" var="list">
														<option value="${list.projectkey }">${list.projectkey } : ${list.name}</option>
													</c:forEach>
													</select>
													<script>
													$(document).ready(function(){
														var A;
															$("#go").change(function(){
																console.log("변경")
																console.log($("#go option:selected").val())
																A =  $("#go option:selected").val();
																$("#goDetail").attr("href","/project5/attendanceMainComplete.do?projectkey="+A );
															})
													})
													</script>
								<%@ include file="../attendance/forPM.jsp" %>
								
								</div>
							</div>
						</div>
					</div>
				</div>




				
			</section>
		</div>

	</div>
	
	
	
	
	
	
<!-- 등록 Modal -->
  	<div class="modal fade text-left" id="inlineForm" tabindex="-1" role="dialog"
       	aria-labelledby="myModalLabel33" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myModalLabel33">프로젝트 상태 변경</h4>
                <button type="button" class="close" data-bs-dismiss="modal"
                    aria-label="Close">
                    <i data-feather="x"></i>
                </button>
            </div>
            <form id="updateProjectProgress" action="/project5/updateProjectProgress.do">
            	<!-- 모달 입력 요소 영역 -->
                <div class="modal-body" style="margin:10px;">
                <div id="title" style="flex:4;">
                    		<input class="form-control" type="text" name="title" placeholder="상태 변경합니다" readonly="readonly">
                    	</div>
                	<!-- 프로젝트 select box -->
                	<div id="prjselect">
                    	<select class="form-select" style="text-align:center;" name="projectkey">
                    		<c:forEach var="prlist" items="${pjList}">
                    			<option value="${prlist.projectkey}">${prlist.projectkey} : ${prlist.name}</option>
                    		</c:forEach>
                    	</select>
                    </div>
                    
                    <!-- 중요도, 제목 공통 영역 -->
                    <div id="headerdiv" style="display:flex;margin-top: 10px;">
                    <!-- 중요도 select box -->
                    	<div id="importselect" style="flex:1;margin-right:5px;">
                    		<select class="form-select" name="progress">
	                    		<option value="대기">대기</option>
	                    		<option value="초기">초기</option>
	                    		<option value="중기">중기</option>
	                    		<option value="후기">후기</option>
	                    		<option value="종료">종료</option>
                    		</select>
                    	</div>
                    <!-- 제목 -->
                    </div>
                    
                </div>
                <!-- 버튼 영역 -->
                <div class="modal-footer">
                    <button type="button" class="btn btn-light-secondary"
                        data-bs-dismiss="modal">
                        <i class="bx bx-x d-block d-sm-none"></i>
                        <span class="d-none d-sm-block">닫기</span>
                    </button>
                    
                    
                    <button type="button" id="regBtns" class="btn btn-primary ml-1"
                        data-bs-dismiss="modal">
                        <i class="bx bx-check d-block d-sm-none"></i>
                        <span class="d-none d-sm-block">등록</span>
                    </button>
                    
                </div>
                
                <script>
                $(document).ready(function(){
                	$("#regBtns").click(function(e){
                		if(confirm("정말 수정하시겠습니까?")){
                			$("#updateProjectProgress").submit()
                		}else{
                			e.preventDefault()
                		}
                	})
                })
                </script>
                
            </form>
        </div>
    </div>
</div>
	
	
	
	
	
	
	
	
	
	
	
	
	
	

</body>
</html>