<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />





<!DOCTYPE html>
<html lang="en">





<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>쌍용 5조 PMBOK</title>

<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="/project5/resources/dist/assets/css/bootstrap.css">
<link rel="stylesheet"
	href="/project5/resources/dist/assets/vendors/perfect-scrollbar/perfect-scrollbar.css">
<link rel="stylesheet"
	href="/project5/resources/dist/assets/vendors/bootstrap-icons/bootstrap-icons.css">
<link rel="stylesheet"
	href="/project5/resources/dist/assets/css/app.css">
<link rel="stylesheet"
	href="/project5/resources/dist/assets/vendors/simple-datatables/style.css">
<link rel="shortcut icon"
	href="/project5/resources/dist/assets/images/favicon.svg"
	type="image/x-icon">

<script src="http://code.jquery.com/jquery-latest.min.js"></script>



</head>

<script>
	$(document).ready(function() {
		var auth = "${member.auth}";
		var memberName = "${member.name}";
		var memberkey = "${member.memberkey}";
		console.log("memberName : " + memberName);
		console.log("auth : " + auth);
		console.log("memberkey : " + memberkey);

		
		/*나의 프로젝트 접근 권한 처리*/
		$("#myProject").click(function() {
			if (memberName == "") {
				alert("미 로그인시 접근 불가합니다.")
				location.href="/project5/main.do"
			}else{
				location.href="/project5/myProject.do?memberkey="+memberkey
			}
		})
		
		
		/*대시보드 접근 권한 처리*/
		$("#dashBoard").click(function() {
			if (memberName == "") {
				alert("미 로그인시 접근 불가합니다.")
				location.href="/project5/main.do"
			}else{
				location.href="/project5/dashBoard.do?projectkey=1&memberkey="+memberkey
			}
		})
		
							
		$("#kanbanss").click(function() {
			if (memberName == "") {
				alert("미 로그인시 접근 불가합니다.")
				location.href="/project5/main.do"
			}else{
				location.href="/project5/kanbanMain.do?projectkey=1"
			}
		})
		
		
		
		$("#projectHome").click(function() {
			if (memberName == "") {
				alert("미 로그인시 접근 불가합니다.")
				location.href="/project5/main.do"
			}else{
				location.href=" /project5/projectHome.do?projectkey=1"
			}
		})
		
		
		$("#gantt").click(function() {
			if (memberName == "") {
				alert("미 로그인시 접근 불가합니다.")
				location.href="/project5/main.do"
			}else{
				location.href="/project5/ganttMain.do?projectkey=1"
			}
		})
		
		
		$("#output").click(function() {
			if (memberName == "") {
				alert("미 로그인시 접근 불가합니다.")
				location.href="/project5/main.do"
			}else{
				location.href="/project5/output.do?projectkey=1"
			}
		})
		
		
					
		
		$("#cost").click(function() {
			if (memberName == "") {
				alert("미 로그인시 접근 불가합니다.")
				location.href="/project5/main.do"
			}else{
				location.href="/project5/cost.do?projectkey=1"
			}
		})
		$("#quality").click(function() {
			if (memberName == "") {
				alert("미 로그인시 접근 불가합니다.")
				location.href="/project5/main.do"
			}else{
				location.href="/project5/qualityList.do?projectkey=1"
			}
		})
		$("#procu").click(function() {
			if (memberName == "") {
				alert("미 로그인시 접근 불가합니다.")
				location.href="/project5/main.do"
			}else{
				location.href="/project5/procurementList.do?projectkey=1"
			}
		})
		$("#team").click(function() {
			if (memberName == "") {
				alert("미 로그인시 접근 불가합니다.")
				location.href="/project5/main.do"
			}else{
				location.href="/project5/teamlist.do?projectkey=1"
			}
		})
		$("#risk").click(function() {
			if (memberName == "") {
				alert("미 로그인시 접근 불가합니다.")
				location.href="/project5/main.do"
			}else{
				location.href="/project5/risk.do?projectkey=1"
			}
		})
		
		
		$("#mywork").click(function() {
			if (memberName == "") {
				alert("미 로그인시 접근 불가합니다.");
				location.href="/project5/main.do"
			}else{
				location.href="/project5/myWork1.do?memberkey="+memberkey
			}
		})
		
							$("#projectMange").click(function() {
								if (auth == "") {
									alert("PM만 접근 가능합니다.");
								} else {
									location.href="/project5/projectManageMain.do"
								}
							});
						$("#MemberAnaysis").click(function() {
							if (auth == "") {
								alert("관리자만 접근 가능합니다.");
							} else {
								 window.open("https://analytics.google.com/analytics/web/?hl=ko&pli=1#/p309149054/reports/intelligenthome",
										"PopupWin", "width=1000,height=800");
							}
						});
						$("#EmailBtn").click(function() {
							if (auth == "") {
								alert("관리자만 접근 가능합니다.");
							} else {
								location.href = "/project5/mailFrm.do"
							}
						});

						$("#MemberListBtn").click(function() {
							if (auth == "") {
								alert("관리자만 접근 가능합니다.");
							} else {
								location.href = "/project5/memberList.do"
							}
						});

					})
					
					
					
					
					
</script>




<body>
	<div id="app">
		<div id="sidebar" class="active">
			<div class="sidebar-wrapper active">
				<div class="sidebar-header">
					<div class="d-flex justify-content-between">
						<div class="logo">
							<a href="/project5/main.do"><img
								src="/project5/resources/logo.png" alt="Logo" srcset=""
								style="width: 100%; height: 100%;"></a>
						</div>
						<div class="toggler">
							<a href="#" class="sidebar-hide d-xl-none d-block"><i
								class="bi bi-x bi-middle"></i></a>
						</div>
					</div>
				</div>
				<div class="sidebar-menu">
					<ul class="menu">
						<li class="sidebar-title">	<spring:message code="menu"/></span></li>


						<script>
							/* gnb_area 로그아웃 버튼 작동 */
							$("#gnb_logout_button").click(function() {
								$.ajax({
									type : "POST",
									url : "/project5/logout.do",
									success : function(data) {
										alert("로그아웃 성공");
										document.location.reload();
									}
								}); // ajax 
							});
						</script>
						
						<c:if test="${ empty member.id}">
							<li class="sidebar-item  "><a href="/project5/loginForm.do"
								class='sidebar-link'> <i class="bi bi-person-badge-fill"></i> <span>
								
								<spring:message code="login"/></span>
							</a></li>
						</c:if>

						<c:if test="${not empty member.id}">
							<li class="sidebar-item  "><a
								href="/project5/memberEdit.do?memberkey=${member.memberkey }"
								class='sidebar-link'> <i class="bi bi-person-badge-fill"></i> <span>${member.id }님</span>
							</a></li>


							<li class="sidebar-item  "><a href="/project5/logout.do"
								class='sidebar-link' onclick="confirm('정말 로그아웃하시겠습니까?')"> <i class="bi bi-person-badge-fill"></i>
								 <span><spring:message code="logout"/></span>
							</a></li>
						</c:if>





						<li class="sidebar-item  "><a href="/project5/allProject.do"
							class='sidebar-link'> <i class="bi bi-grid-fill"></i> <span>
									<spring:message code="allProject"/></span>
						</a></li>
						<li class="sidebar-item " id="myProject"><a
							href="#"  id="myProjectA" class='sidebar-link' > <i class="bi bi-grid-fill"></i> <span>
									<spring:message code="myProject"/></span>
						</a></li>




<!-- 
						<li class="sidebar-item  has-sub"><a
																			href="#" class='sidebar-link'> <i
																				class="bi bi-stack"></i> <span>프로젝트</span>
																		</a>
										<ul class="submenu ">
										
											<li class="submenu-item ">
												<a href="#" id="dashBoard">대시보드 </a>
											</li>
											
											<li class="submenu-item "><a
												href="#" id="projectHome">프로젝트 홈 </a>
											</li>
											
											<li class="submenu-item ">
												<a href="#" id="kanbanss">칸반보드 </a>
											</li>
										
													
											<li class="submenu-item ">
												<a href="#" id="gantt">간트차트</a>
											</li>
											
												
											<li class="submenu-item ">
												<a href="#" id="kanbanss">캘린더 </a>
											</li>
											
											<li class="submenu-item ">
												<a href="#" id="cost">예산 관리</a>
											</li>
											
											<li class="submenu-item ">
												<a href="#" id="quality">품질 관리</a>
											</li>
											
											<li class="submenu-item ">
												<a href="#" id="team">팀 관리</a>
											</li>
											
											<li class="submenu-item ">
												<a href="#" id="output">산출물 관리 </a>
											</li>
											
											<li class="submenu-item ">
												<a href="#" id="risk">리스크 관리</a>
											</li>
											
											
											<li class="submenu-item ">
												<a href="#" id="procu">조달 관리</a>
											</li>
											
											
											
											
										</ul>
							</li>
							
 -->




						<li class="sidebar-item  "><a
							href="/project5/myCalendar.do?memberkey=${member.memberkey}"
							class='sidebar-link'> 
							<svg style="width: 16px; height: 16px;"  class="svg-inline--fa fa-calendar-alt fa-w-14 fa-fw select-all" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="calendar-alt" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" data-fa-i2svg=""><path fill="currentColor" d="M0 464c0 26.5 21.5 48 48 48h352c26.5 0 48-21.5 48-48V192H0v272zm320-196c0-6.6 5.4-12 12-12h40c6.6 0 12 5.4 12 12v40c0 6.6-5.4 12-12 12h-40c-6.6 0-12-5.4-12-12v-40zm0 128c0-6.6 5.4-12 12-12h40c6.6 0 12 5.4 12 12v40c0 6.6-5.4 12-12 12h-40c-6.6 0-12-5.4-12-12v-40zM192 268c0-6.6 5.4-12 12-12h40c6.6 0 12 5.4 12 12v40c0 6.6-5.4 12-12 12h-40c-6.6 0-12-5.4-12-12v-40zm0 128c0-6.6 5.4-12 12-12h40c6.6 0 12 5.4 12 12v40c0 6.6-5.4 12-12 12h-40c-6.6 0-12-5.4-12-12v-40zM64 268c0-6.6 5.4-12 12-12h40c6.6 0 12 5.4 12 12v40c0 6.6-5.4 12-12 12H76c-6.6 0-12-5.4-12-12v-40zm0 128c0-6.6 5.4-12 12-12h40c6.6 0 12 5.4 12 12v40c0 6.6-5.4 12-12 12H76c-6.6 0-12-5.4-12-12v-40zM400 64h-48V16c0-8.8-7.2-16-16-16h-32c-8.8 0-16 7.2-16 16v48H160V16c0-8.8-7.2-16-16-16h-32c-8.8 0-16 7.2-16 16v48H48C21.5 64 0 85.5 0 112v48h448v-48c0-26.5-21.5-48-48-48z"></path></svg>
							<span>
									<spring:message code="myCalendar"/></span>
						</a></li>



						<li class="sidebar-item  "><a
							href="/project5/chatting.do"
							class='sidebar-link'> 
							<i class="bi bi-chat-dots-fill"></i>
							<span>
									<spring:message code="chatting"/></span>
							</a>
						</li>



					<!-- 
						<li class="sidebar-item  has-sub"><a href="#"
							class='sidebar-link'> <i class="bi bi-chat-dots-fill"></i> <span>의사소통</span>
						</a>

							<ul class="submenu ">
								<li class="submenu-item "><a
									href="/project5/minutes.do?method=list">회의</a></li>
								<li class="submenu-item "><a href="/project5/chatting.do">채팅</a>
								</li>
							</ul></li>
								 -->



						<li class="sidebar-item  " id="mywork"><a
							href="#"
							class='sidebar-link'> <i class="bi bi-puzzle"></i></i> <span>
									<spring:message code="myWork"/></span>
						</a></li>


						<li class="sidebar-item  "><a href="/project5/notice.do"
							class='sidebar-link'>
							<svg style="height: 16px; width:16px;"  class="svg-inline--fa fa-check fa-w-16 fa-fw select-all" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="check" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" data-fa-i2svg=""><path fill="currentColor" d="M173.898 439.404l-166.4-166.4c-9.997-9.997-9.997-26.206 0-36.204l36.203-36.204c9.997-9.998 26.207-9.998 36.204 0L192 312.69 432.095 72.596c9.997-9.997 26.207-9.997 36.204 0l36.203 36.204c9.997 9.997 9.997 26.206 0 36.204l-294.4 294.401c-9.998 9.997-26.207 9.997-36.204-.001z"></path></svg>
							<span><spring:message code="notice"/></span> </a>
						</li>


						<li class="sidebar-item  has-sub">
								<a href="/project5/customerChat.do" class='sidebar-link'> 
								
									<svg style="height: 16px; width:16px;"  class="svg-inline--fa fa-cube fa-w-16 fa-fw select-all" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="cube" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" data-fa-i2svg=""><path fill="currentColor" d="M239.1 6.3l-208 78c-18.7 7-31.1 25-31.1 45v225.1c0 18.2 10.3 34.8 26.5 42.9l208 104c13.5 6.8 29.4 6.8 42.9 0l208-104c16.3-8.1 26.5-24.8 26.5-42.9V129.3c0-20-12.4-37.9-31.1-44.9l-208-78C262 2.2 250 2.2 239.1 6.3zM256 68.4l192 72v1.1l-192 78-192-78v-1.1l192-72zm32 356V275.5l160-65v133.9l-160 80z"></path></svg>
									 <span><spring:message code="customManage"/></span>
								 </a>
							<ul class="submenu">
								<li class="submenu-item "><a href="/project5/customerChat.do">채팅 상담</a></li>
								<li class="submenu-item "><a href="/project5/pricing.do">플랜 </a></li>
							</ul>
						</li>
						
						<li class="sidebar-item  "><a href="/project5/aboutUs.do"
							class='sidebar-link'> 
<svg style="width: 16px; height: 16px;" class="svg-inline--fa fa-trademark fa-w-20 fa-fw select-all" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="trademark" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512" data-fa-i2svg=""><path fill="currentColor" d="M260.6 96H12c-6.6 0-12 5.4-12 12v43.1c0 6.6 5.4 12 12 12h85.1V404c0 6.6 5.4 12 12 12h54.3c6.6 0 12-5.4 12-12V163.1h85.1c6.6 0 12-5.4 12-12V108c.1-6.6-5.3-12-11.9-12zM640 403l-24-296c-.5-6.2-5.7-11-12-11h-65.4c-5.1 0-9.7 3.3-11.3 8.1l-43.8 127.1c-7.2 20.6-16.1 52.8-16.1 52.8h-.9s-8.9-32.2-16.1-52.8l-43.8-127.1c-1.7-4.8-6.2-8.1-11.3-8.1h-65.4c-6.2 0-11.4 4.8-12 11l-24.4 296c-.6 7 4.9 13 12 13H360c6.3 0 11.5-4.9 12-11.2l9.1-132.9c1.8-24.2 0-53.7 0-53.7h.9s10.7 33.6 17.9 53.7l30.7 84.7c1.7 4.7 6.2 7.9 11.3 7.9h50.3c5.1 0 9.6-3.2 11.3-7.9l30.7-84.7c7.2-20.1 17.9-53.7 17.9-53.7h.9s-1.8 29.5 0 53.7l9.1 132.9c.4 6.3 5.7 11.2 12 11.2H628c7 0 12.5-6 12-13z"></path></svg>
 <span><spring:message code="aboutUs"/></span> </a>
						</li>
						
						
						
						<li class="sidebar-item  has-sub"><a href="#" class='sidebar-link'> 
						<svg style="height: 16px; width:16px;"  class="svg-inline--fa fa-lock fa-w-14 fa-fw select-all" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="lock" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" data-fa-i2svg=""><path fill="currentColor" d="M400 224h-24v-72C376 68.2 307.8 0 224 0S72 68.2 72 152v72H48c-26.5 0-48 21.5-48 48v192c0 26.5 21.5 48 48 48h352c26.5 0 48-21.5 48-48V272c0-26.5-21.5-48-48-48zm-104 0H152v-72c0-39.7 32.3-72 72-72s72 32.3 72 72v72z"></path></svg>
						<span>
									<spring:message code="pmPage"/></span></a>
							<ul class="submenu ">
								<li class="submenu-item " id="projectMange"><a href="#">프로젝트 관리 </a></li>
							</ul>
						</li>




						<li class="sidebar-item  has-sub"><a href="#" class='sidebar-link'> 
						<svg style="height: 16px; width:16px;"  class="svg-inline--fa fa-lock fa-w-14 fa-fw select-all" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="lock" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" data-fa-i2svg=""><path fill="currentColor" d="M400 224h-24v-72C376 68.2 307.8 0 224 0S72 68.2 72 152v72H48c-26.5 0-48 21.5-48 48v192c0 26.5 21.5 48 48 48h352c26.5 0 48-21.5 48-48V272c0-26.5-21.5-48-48-48zm-104 0H152v-72c0-39.7 32.3-72 72-72s72 32.3 72 72v72z"></path></svg>
						<span>
									<spring:message code="adminPage"/></span></a>
							<ul class="submenu ">
								<li class="submenu-item "><a href="#" id="MemberAnaysis">메인 (사용자 분석)</a></li>
								<li class="submenu-item "><a href="#" id="EmailBtn">이메일 발송 </a></li>
								<li class="submenu-item "><a href="#" id="MemberListBtn">사용자 리스트 </a></li>
							</ul>
						</li>
					
						
						
						
						
						
						
						
					</ul>
					
					
					

					
					
					
				</div>
				
				
				

				<button class="sidebar-toggler btn x">
					<i data-feather="x"></i>
				</button>
			</div>
		</div>
		<div id="main">
			<header class="mb-3">
				<a href="#" class="burger-btn d-block d-xl-none"> <i
					class="bi bi-justify fs-3"></i>
				</a>
			</header>
		</div>
	</div>
	<script
		src="/project5/resources/dist/assets/vendors/perfect-scrollbar/perfect-scrollbar.min.js"></script>
	<script
		src="/project5/resources/dist/assets/js/bootstrap.bundle.min.js"></script>
	<script
		src="/project5/resources/dist/assets/vendors/simple-datatables/simple-datatables.js"></script>
	<script src="/project5/resources/dist/assets/js/main.js"></script>


</body>

</html>
