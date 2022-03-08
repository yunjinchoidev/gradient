<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<link rel="shortcut icon"
	href="/project5/resources/dist/assets/images/favicon.svg"
	type="image/x-icon">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>

<script>
	$(document).ready(function() {

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
								src="/project5/resources/a.png" alt="Logo" srcset=""></a>
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




						<c:if test="${member.id eq null}">
							<li class="sidebar-item  "><a href="/project5/login.do"
								class='sidebar-link'> <i class="bi bi-grid-fill"></i> <span>로그인</span>
							</a></li>
						</c:if>

						<c:if test="${member.id ne null}">
							<li class="sidebar-item  "><a href="#" class='sidebar-link'
								onclick="confirm('정말 로그아웃하시겠습니까?')"> <i
									class="bi bi-grid-fill"></i> <span>${member.id }님 로그인</span>
							</a></li>
							<li class="sidebar-item  "><a href="/project5/logout.do"
								class='sidebar-link' onclick="confirm('정말 로그아웃하시겠습니까?')"> <i
									class="bi bi-grid-fill"></i> <span>로그아웃</span>
							</a></li>
						</c:if>







						<li class="sidebar-item  has-sub"><a href="#"
							class='sidebar-link'> <i class="bi bi-stack"></i> <span>프로젝트[세부]</span>
						</a>

							<ul class="submenu ">
								<li class="submenu-item "><a href="/project5/rangeKanban.do">범위 관리 1(칸반)
										 </a></li>
								<li class="submenu-item "><a href="/project5/wbs.do">범위 관리 2(WBS)
										 </a></li>
								<li class="submenu-item "><a href="/project5/output.do">산출물
										관리 </a></li>
								<li class="submenu-item "><a href="/project5/cost.do">원가 관리</a>
								</li>
								<li class="submenu-item "><a href="/project5/quality.do">품질 관리</a>
								</li>
								<li class="submenu-item "><a href="/project5/resource.do">자원/인적 관리</a>
								</li>
								<li class="submenu-item "><a href="/project5/risk.do">리스크</a>
								</li>
								<li class="submenu-item "><a href="/project5/support.do">조달</a>
								</li>
							</ul></li>




						<li class="sidebar-item  has-sub"><a href="#"
							class='sidebar-link'> <i class="bi bi-stack"></i> <span>통합[프로젝트
									총괄]</span>
						</a>

							<ul class="submenu ">
								<li class="submenu-item "><a href="/project5/unifyList.do">프로젝트
										계획</a></li>
								<li class="submenu-item "><a href="/project5/unifyindex.do">프로젝트
										수주</a></li>
								<li class="submenu-item "><a href="/project5/unifyManage.do">프로젝트
										관리</a></li>
								<li class="submenu-item "><a href="/project5/unify/start.do">프로젝트
										시작</a></li>
								<li class="submenu-item "><a href="/project5/unifyEnd.do">프로젝트
										종료</a></li>
							</ul></li>





						<li class="sidebar-item  has-sub"><a href="#"
							class='sidebar-link'> <i class="bi bi-stack"></i> <span>일정 관리</span>
						</a>

							<ul class="submenu ">
								<li class="submenu-item "><a href="component-alert.html">간트차트</a>
								</li>

								<li class="submenu-item "><a href="/project5/calendar.do">캘린더</a>
								</li>
								<li class="submenu-item "><a href="/project5/scheduleList.do">일정관리
										계획</a></li>
								<li class="submenu-item "><a href="/project5/todayItodo.do">Today I to do
										</a></li>
										
							</ul></li>



						<li class="sidebar-item  has-sub"><a href="#"
							class='sidebar-link'> <i class="bi bi-stack"></i> <span>의사소통</span>
						</a>

							<ul class="submenu ">
								<li class="submenu-item "><a href="/project5/communicationList.do">회의공간</a>
								</li>

								<li class="submenu-item "><a href="component-alert.html">채팅</a>
								</li>
								<li class="submenu-item "><a href="component-badge.html">소통
										계획</a></li>
							</ul></li>
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

	<script src="/project5/resources/dist/assets/js/main.js"></script>
</body>

</html>
