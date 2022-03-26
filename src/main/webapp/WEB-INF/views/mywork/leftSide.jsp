<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script scr="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&amp;display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="/project5/resources/dist/assets/css/bootstrap.css">
<link rel="stylesheet"
	href="/project5/resources/dist/assets/css/pages/email.css">
<link rel="stylesheet"
	href="/project5/resources/dist/assets/vendors/perfect-scrollbar/perfect-scrollbar.css">
<link rel="stylesheet"
	href="/project5/resources/dist/assets/vendors/bootstrap-icons/bootstrap-icons.css">
<link rel="stylesheet"
	href="/project5/resources/dist/assets/css/app.css">
<link rel="shortcut icon"
	href="/project5/resources/dist/assets/images/favicon.svg"
	type="image/x-icon">


</head>





<body>



	<div class="sidebar-left" style="height: 5000px;">
		<div class="sidebar" style="height: 5000px;">
			<div class="sidebar-content email-app-sidebar d-flex">
				<!-- sidebar close icon -->
				<span class="sidebar-close-icon"> <i class="bx bx-x"></i>
				</span>
				<!-- sidebar close icon -->
				<div class="email-app-menu" style="height: 5000px;">
					<div class="form-group form-group-compose">
						<!-- compose button  -->
						<button type="button"
							class="btn btn-primary btn-block my-4 compose-btn">
							<i class="bx bx-plus"></i> 구분
						</button>
					</div>


					<div class="sidebar-menu-list ps">
						<!-- sidebar menu  -->
						<div class="list-group list-group-messages">




							<a href="/project5/myworkCalendar.do?memberkey=${member.memberkey }" class="list-group-item"
								style="font-size: 20px; font-weight: bolder;">
								<div class="fonticon-wrap d-inline me-3">

									<svg class="bi" width="1.5em" height="1.5em"
										fill="currentColor">
                                            <use
											xlink:href="/project5/resources/dist/assets/vendors/bootstrap-icons/bootstrap-icons.svg#star"></use>
                                        </svg>
								</div> 일정 전체 조회
							</a> 
							
							
							
							
							
							<a href="/project5/myworkKanban.do?memberkey=${member.memberkey }" class="list-group-item"
								style="font-size: 20px; font-weight: bolder;">
								<div class="fonticon-wrap d-inline me-3">
									<svg class="bi" width="1.5em" height="1.5em" fill="currentColor" >
											<use xlink:href="/project5/resources/dist/assets/vendors/bootstrap-icons/bootstrap-icons.svg#star"></use>
                                    </svg>
								</div> 
								진행중인 칸반
							</a> 
							
							
							
							
							<a href="/project5/myworkGantt.do?memberkey=${member.memberkey }" class="list-group-item"
								style="font-size: 20px; font-weight: bolder;">
								<div class="fonticon-wrap d-inline me-3">

									<svg class="bi" width="1.5em" height="1.5em"
										fill="currentColor">
                                            <use
											xlink:href="/project5/resources/dist/assets/vendors/bootstrap-icons/bootstrap-icons.svg#star"></use>
                                        </svg>
								</div> 진행중인 간트
							</a> 
							
							
							
							
							
							<a href="/project5/myworkCalendar7days.do?memberkey=${member.memberkey }" class="list-group-item"
								style="font-size: 20px; font-weight: bolder;">
								<div class="fonticon-wrap d-inline me-3">

									<svg class="bi" width="1.5em" height="1.5em"
										fill="currentColor">
                                            <use
											xlink:href="/project5/resources/dist/assets/vendors/bootstrap-icons/bootstrap-icons.svg#star"></use>
                                        </svg>
								</div> 7일전
							</a> 
							
							
							<a href="/project5/myworkCalendar3days.do?memberkey=${member.memberkey }" class="list-group-item"
								style="font-size: 20px; font-weight: bolder;">
								<div class="fonticon-wrap d-inline me-3">

									<svg class="bi" width="1.5em" height="1.5em"
										fill="currentColor">
                                            <use
											xlink:href="/project5/resources/dist/assets/vendors/bootstrap-icons/bootstrap-icons.svg#star"></use>
                                        </svg>
								</div> <strong>3일전</strong>
							</a>
							
							
							
							 <a href="/project5/myworkCalendar1days.do?memberkey=${member.memberkey }" class="list-group-item"
								style="font-size: 20px; font-weight: bolder;">
								<div class="fonticon-wrap d-inline me-3">

									<svg class="bi" width="1.5em" height="1.5em"
										fill="currentColor">
                                            <use
											xlink:href="/project5/resources/dist/assets/vendors/bootstrap-icons/bootstrap-icons.svg#star"></use>
                                        </svg>
								</div> 1일전
							</a> 
							
							
							
							<a href="#" class="list-group-item"
								style="font-size: 20px; font-weight: bolder;">
								<div class="fonticon-wrap d-inline me-3">

									<svg class="bi" width="1.5em" height="1.5em"
										fill="currentColor">
                                            <use
											xlink:href="/project5/resources/dist/assets/vendors/bootstrap-icons/bootstrap-icons.svg#star"></use>
                                        </svg>
								</div> 중요
							</a> 
							
							
							
							<a href="#" class="list-group-item"
								style="font-size: 20px; font-weight: bolder;">
								<div class="fonticon-wrap d-inline me-3">

									<svg class="bi" width="1.5em" height="1.5em"
										fill="currentColor">
                                            <use
											xlink:href="/project5/resources/dist/assets/vendors/bootstrap-icons/bootstrap-icons.svg#archive"></use>
                                        </svg>
								</div> 시급
							</a> 
							
							
							
							<a href="#" class="list-group-item"
								style="font-size: 20px; font-weight: bolder;">
								<div class="fonticon-wrap d-inline me-3">

									<svg class="bi" width="1.5em" height="1.5em"
										fill="currentColor">
                                            <use
											xlink:href="/project5/resources/dist/assets/vendors/bootstrap-icons/bootstrap-icons.svg#pencil"></use>
                                        </svg>
								</div> 완료
							</a> 
							
							
							
							<a href="/project5/myWorkFileBox.do?memberkey=${member.memberkey }" class="list-group-item"
								style="font-size: 20px; font-weight: bolder;">
								<div class="fonticon-wrap d-inline me-3">

									<svg class="bi" width="1.5em" height="1.5em"
										fill="currentColor">
                                            <use
											xlink:href="/project5/resources/dist/assets/vendors/bootstrap-icons/bootstrap-icons.svg#star"></use>
                                        </svg>
								</div> 파일함
							</a>
							
							
							
							
							 <a href="/project5/myWorkFileBox.do?memberkey=${member.memberkey }" class="list-group-item"
								style="font-size: 20px; font-weight: bolder;">
								<div class="fonticon-wrap d-inline me-3">
									<svg class="bi" width="1.5em" height="1.5em"
										fill="currentColor">
                                            <use
											xlink:href="/project5/resources/dist/assets/vendors/bootstrap-icons/bootstrap-icons.svg#info-circle"></use>
                                        </svg>
								</div> 이미지 모아 보기 <span
								class="badge badge-light-danger badge-pill badge-round float-right mt-50">3</span>
							</a> 
							
							
							<a href="#" class="list-group-item"
								style="font-size: 20px; font-weight: bolder;">
								<div class="fonticon-wrap d-inline me-3">
									<svg class="bi" width="1.5em" height="1.5em"
										fill="currentColor">
                                            <use
											xlink:href="/project5/resources/dist/assets/vendors/bootstrap-icons/bootstrap-icons.svg#trash"></use>
                                        </svg>
								</div> 이메일 모음
							</a>
							
							
							
							 <a href="#" class="list-group-item"
								style="font-size: 20px; font-weight: bolder;">
								<div class="fonticon-wrap d-inline me-3">
									<svg class="bi" width="1.5em" height="1.5em"
										fill="currentColor">
                                            <use
											xlink:href="/project5/resources/dist/assets/vendors/bootstrap-icons/bootstrap-icons.svg#trash"></use>
                                        </svg>
								</div> 코멘트
							</a> 
							
							
							
							<a href="#" class="list-group-item"
								style="font-size: 20px; font-weight: bolder;">
								<div class="fonticon-wrap d-inline me-3">
									<svg class="bi" width="1.5em" height="1.5em"
										fill="currentColor">
                                            <use
											xlink:href="/project5/resources/dist/assets/vendors/bootstrap-icons/bootstrap-icons.svg#trash"></use>
                                        </svg>
								</div> 휴가 관리
							</a>
						</div>
						<!-- sidebar menu  end-->

						<!-- sidebar label end -->
						<div class="ps__rail-x" style="left: 0px; bottom: 0px;">
							<div class="ps__thumb-x" tabindex="0"
								style="left: 0px; width: 0px;"></div>
						</div>
						<div class="ps__rail-y" style="top: 0px; right: 0px;">
							<div class="ps__thumb-y" tabindex="0"
								style="top: 0px; height: 0px;"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


</body>
<script
	src="/project5/resources/dist/assets/vendors/perfect-scrollbar/perfect-scrollbar.min.js"></script>
<script src="/project5/resources/dist/assets/js/bootstrap.bundle.min.js"></script>
<script src="/project5/resources/dist/assets/js/main.js"></script>
</html>