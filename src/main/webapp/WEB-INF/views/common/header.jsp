<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
		console.log("auth : " + auth);
		$("#check").click(function() {
			if (auth != "pm") {
				alert("권한이 없습니다.");
				location.href = "/project5/main.do";
			} else {
				console.log("승인");
				window.location = "www.naver.com";
			}
		});

		var memberName = "${member.name}";
		console.log("memberName : " + memberName);
		$("#myProject").click(function() {
			if (memberName == "") {
				alert("미 로그인시 접근 불가합니다.")
				history.back(-2);
			}
		})
		$("#mywork").click(function() {
			if (memberName == "") {
				alert("미 로그인시 접근 불가합니다.")
				history.back(-2);
			}
		})

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
						<li class="sidebar-title">Menu</li>


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
							<li class="sidebar-item  "><a href="/project5/login.do"
								class='sidebar-link'> <i class="bi bi-grid-fill"></i> <span>로그인</span>
							</a></li>
						</c:if>

						<c:if test="${not empty member.id}">
							<li class="sidebar-item  "><a
								href="/project5/memberEdit.do?memberkey=${member.memberkey }"
								class='sidebar-link'> <i class="bi bi-grid-fill"></i> <span>${member.id }님</span>
							</a></li>


							<li class="sidebar-item  "><a href="/project5/logout.do"
								class='sidebar-link' onclick="confirm('정말 로그아웃하시겠습니까?')"> <i
									class="bi bi-grid-fill"></i> <span>로그아웃</span>
							</a></li>
						</c:if>





						<li class="sidebar-item  "><a href="/project5/allProject.do"
							class='sidebar-link'> <i class="bi bi-grid-fill"></i> <span>
									공개된 모든 프로젝트</span>
						</a></li>
						<li class="sidebar-item " id="myProject"><a
							href="/project5/myProject.do?memberkey=${member.memberkey }"
							class='sidebar-link'> <i class="bi bi-grid-fill"></i> <span>
									나의 프로젝트</span>
						</a></li>





						<li class="sidebar-item  has-sub"><a
							href="/project5/projectHome.do" class='sidebar-link'> <i
								class="bi bi-stack"></i> <span>프로젝트</span>
						</a>
							<ul class="submenu ">
							<li class="submenu-item "><a
									href="/project5/dashBoard.do?projectkey=1">대시보드 </a>
								<li class="submenu-item "><a
									href="/project5/projectHome.do?projectkey=1">홈 </a></li>
								<li class="submenu-item "><a href="/project5/kanbanMain.do">칸반
										보드 </a></li>
								<li class="submenu-item "><a href="/project5/ganttMain.do">간트차트
								</a></li>
								<li class="submenu-item "><a href="/project5/output.do">산출물
										관리 </a></li>
								<li class="submenu-item "><a href="/project5/cost.do">예산
										관리</a></li>
								<li class="submenu-item "><a
									href="/project5/qualityList.do">품질 관리</a></li>
								<li class="submenu-item "><a
									href="/project5/procurementList.do">조달 관리</a></li>
								<li class="submenu-item "><a href="/project5/team.do">인적
										관리</a></li>
								<li class="submenu-item "><a href="/project5/risk.do">리스크
										관리</a></li>
							</ul></li>

						<li class="sidebar-item  "><a
							href="/project5/calendar.do?memberkey=${member.memberkey}"
							class='sidebar-link'> <i class="bi bi-grid-fill"></i> <span>
									일정관리</span>
						</a></li>

						<li class="sidebar-item  has-sub"><a href="#"
							class='sidebar-link'> <i class="bi bi-stack"></i> <span>의사소통</span>
						</a>

							<ul class="submenu ">
								<li class="submenu-item "><a
									href="/project5/minutes.do?method=list">회의</a></li>
								<li class="submenu-item "><a href="/project5/chat.do">채팅</a>
								</li>
							</ul></li>

						<li class="sidebar-item  " id="mywork"><a
							href="/project5/mywork.do?memberkey=${member.memberkey }"
							class='sidebar-link'> <i class="bi bi-grid-fill"></i> <span>내
									작업 목록 / 작업물</span>
						</a></li>


						<li class="sidebar-item  "><a href="/project5/notice.do"
							class='sidebar-link'> <i class="bi bi-grid-fill"></i> <span>공지사항</span> </a>
						</li>

						<li class="sidebar-item  has-sub"><a href="#" class='sidebar-link'> <i class="bi bi-stack"></i> <span>
									관리자 페이지 [PM]</span></a>
							<ul class="submenu " id="check">
								<li class="submenu-item "><a href="/project5/projectManageMain.do">프로젝트 관리 </a></li>
								<li class="submenu-item "><a href="/project5/mailFrm.do">이메일 발송 </a></li>
								<li class="submenu-item "><a href="/project5/memberList.do">사용자 리스트 </a></li>
							</ul>
						</li>

						<li class="sidebar-item  has-sub">
								<a href="/project5/customerChat.do" class='sidebar-link'> 
								<i class="bi bi-stack"></i> <span>고객 관리</span></a>
							<ul class="submenu " id="check">
								<li class="submenu-item "><a href="#" onclick="window.open('/project5/customerChat.do','팝업창','width=1000, height=1000 top=100, left=200');">채팅 상담</a></li>
								<li class="submenu-item "><a href="#" onclick="window.open('/project5/chatBot.do','팝업창','width=1000, height=1000, left=400');">챗봇 </a></li>
								<li class="submenu-item "><a href="/project5/plan.do">플랜 </a></li>
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
