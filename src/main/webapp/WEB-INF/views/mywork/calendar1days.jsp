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


	<%@ include file="../common/header.jsp"%>
	<div id="main">
		<header class="mb-3">
			<a href="#" class="burger-btn d-block d-xl-none"> <i
				class="bi bi-justify fs-3"></i>
			</a>
		</header>
		<div class="page-heading email-application">
			<div class="page-title">
				<div class="row">
					<div class="col-12 col-md-6 order-md-1 order-last">
						<h3>내 작업 목록</h3>
						<p class="text-subtitle text-muted">당신이 해야만 하는 일입니다.</p>
					</div>
					<div class="col-12 col-md-6 order-md-2 order-first">
						<nav aria-label="breadcrumb"
							class="breadcrumb-header float-start float-lg-end">
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="index.html">Dashboard</a></li>
								<li class="breadcrumb-item active" aria-current="page">Email
									Application</li>
							</ol>
						</nav>
					</div>
				</div>
			</div>
			<section class="section content-area-wrapper" style="height: 5000px;">
				<%@ include file="leftSide.jsp"%>
				<div class="content-right">
					<div class="content-overlay"></div>
					<div class="content-wrapper">
						<div class="content-header row"></div>
						<div class="content-body">
							<!-- email app overlay -->
							<div class="app-content-overlay"></div>
							<div class="email-app-area">
								<!-- Email list Area -->
								<div class="email-app-list-wrapper">
									<div class="email-app-list">
										<div class="email-action">
											<!-- action left start here -->
											<div class="action-left d-flex align-items-center">
												<!-- select All checkbox -->
												<div
													class="checkbox checkbox-shadow checkbox-sm selectAll me-3">
													<input type="checkbox" id="checkboxsmall"
														class="form-check-input"> <label
														for="checkboxsmall"></label>
												</div>
												<!-- delete unread dropdown -->
												<ul class="list-inline m-0 d-flex">
													<li class="list-inline-item mail-delete">
														<button type="button" class="btn btn-icon action-icon"
															data-toggle="tooltip">
															<span class="fonticon-wrap"> <svg class="bi"
																	width="1.5em" height="1.5em" fill="currentColor">
                                                            <use
																		xlink:href="/project5/resources/dist/assets/vendors/bootstrap-icons/bootstrap-icons.svg#trash"></use>
                                                        </svg>
															</span>
														</button>
													</li>
													<li class="list-inline-item mail-unread">
														<button type="button" class="btn btn-icon action-icon">
															<span class="fonticon-wrap d-inline"> <svg
																	class="bi" width="1.5em" height="1.5em"
																	fill="currentColor">
                                                            <use
																		xlink:href="/project5/resources/dist/assets/vendors/bootstrap-icons/bootstrap-icons.svg#envelope"></use>
                                                        </svg>
															</span>
														</button>
													</li>
													<li class="list-inline-item">
														<div class="dropdown">
															<button type="button"
																class="dropdown-toggle btn btn-icon action-icon"
																id="folder" data-toggle="dropdown" aria-haspopup="true"
																aria-expanded="false">
																<span class="fonticon-wrap"> <svg class="bi"
																		width="1.5em" height="1.5em" fill="currentColor">
                                                                <use
																			xlink:href="/project5/resources/dist/assets/vendors/bootstrap-icons/bootstrap-icons.svg#folder"></use>
                                                            </svg>
																</span>
															</button>
															<div class="dropdown-menu dropdown-menu-right"
																aria-labelledby="folder">
																<a class="dropdown-item" href="#"><i
																	class="bx bx-edit"></i> Draft</a> <a class="dropdown-item"
																	href="#"><i class="bx bx-info-circle"></i>Spam</a> <a
																	class="dropdown-item" href="#"><i
																	class="bx bx-trash"></i>Trash</a>
															</div>
														</div>
													</li>
													<li class="list-inline-item">
														<div class="dropdown">
															<button type="button"
																class="btn btn-icon dropdown-toggle action-icon"
																id="tag" data-toggle="dropdown" aria-haspopup="true"
																aria-expanded="false">
																<span class="fonticon-wrap"> <svg class="bi"
																		width="1.5em" height="1.5em" fill="currentColor">
                                                                <use
																			xlink:href="/project5/resources/dist/assets/vendors/bootstrap-icons/bootstrap-icons.svg#tag"></use>
                                                            </svg>
																</span>
															</button>
															<div class="dropdown-menu dropdown-menu-right"
																aria-labelledby="tag">
																<a href="#" class="dropdown-item align-items-center">
																	<span class="bullet bullet-success bullet-sm"></span> <span>Product</span>
																</a> <a href="#" class="dropdown-item align-items-center">
																	<span class="bullet bullet-primary bullet-sm"></span> <span>Work</span>
																</a> <a href="#" class="dropdown-item align-items-center">
																	<span class="bullet bullet-warning bullet-sm"></span> <span>Misc</span>
																</a> <a href="#" class="dropdown-item align-items-center">
																	<span class="bullet bullet-danger bullet-sm"></span> <span>Family</span>
																</a> <a href="#" class="dropdown-item align-items-center">
																	<span class="bullet bullet-info bullet-sm"></span> <span>
																		Design</span>
																</a>
															</div>
														</div>
													</li>
												</ul>
											</div>
											<!-- action left end here -->

											<!-- action right start here -->
											<div
												class="action-right d-flex flex-grow-1 align-items-center justify-content-around">
												<!-- search bar  -->
												<div class="email-fixed-search flex-grow-1">
													<div class="sidebar-toggle d-block d-lg-none">
														<i class="bx bx-menu"></i>
													</div>

													<div
														class="form-group position-relative  mb-0 has-icon-left">
														<input type="text" class="form-control"
															placeholder="Search email..">
														<div class="form-control-icon">
															<svg class="bi" width="1.5em" height="1.5em"
																fill="currentColor">
                                                        <use
																	xlink:href="assets/vendors/bootstrap-icons/bootstrap-icons.svg#search"></use>
                                                    </svg>
														</div>
													</div>
												</div>
												<!-- pagination and page count -->
												<span class="d-none d-sm-block">1-10 of 653</span>
												<button
													class="btn btn-icon email-pagination-prev d-none d-sm-block">
													<svg class="bi" width="1.5em" height="1.5em"
														fill="currentColor">
                                                <use
															xlink:href="/project5/resources/dist/assets/vendors/bootstrap-icons/bootstrap-icons.svg#chevron-left"></use>
                                            </svg>
												</button>
												<button
													class="btn btn-icon email-pagination-next d-none d-sm-block">
													<svg class="bi" width="1.5em" height="1.5em"
														fill="currentColor">
                                                <use
															xlink:href="/project5/resources/dist/assets/vendors/bootstrap-icons/bootstrap-icons.svg#chevron-right"></use>
                                            </svg>
												</button>
											</div>
										</div>
										<!-- / action right -->
























      	 

										<!-- email user list start -->
										<div class="email-user-list list-group ps ps--active-y"
											style="height: 5000px;">
											<ul class="users-list-wrapper media-list">


												<c:forEach var="list" items="${list }" varStatus="var">
													<li class="media mail-read"  onclick="window.open('/project5/myWorkModal.do?id=${list.id}','팝업창','width=500, height=610, left=400, top=200');">
														<div class="user-action">
															<div class="checkbox-con me-3">
																<div class="checkbox checkbox-shadow checkbox-sm">
																	<input type="checkbox" id="checkboxsmall1"
																		class="form-check-input"> <label
																		for="checkboxsmall1"></label>
																</div>
															</div>
															<span class="favorite text-warning"> <svg class="bi" width="1.5em" height="1.5em"
																	fill="currentColor">
                                                        	<use xlink:href="assets/vendors/bootstrap-icons/bootstrap-icons.svg#star-fill"></use></svg>
															</span>
														</div>
														
														
														
														
														<div class="pr-50" >
															<div class="avatar">
																<img
																	src="/project5/resources/dist/assets/images/faces/1.jpg"
																	alt="avtar img holder">
															</div>
														</div>

														<div class="media-body"      >
															<div class="user-details">
																
																<div class="mail-items">
																	<span class="list-group-item-text text-truncate">${list.title}</span>
																</div>
																
																<div class="mail-meta-item">
																	<span class="float-right"> <span
																		class="mail-date">4:14 AM</span>
																	</span>
																</div>
															</div>
															<div class="mail-message">
																<p class="list-group-item-text truncate mb-0">
																	${list.content }</p>
																<div class="mail-meta-item">
																	<span class="float-right"> <span
																		class="bullet bullet-success bullet-sm"></span>
																	</span>
																</div>
															</div>
														</div>
													</li>
												</c:forEach>
											</ul>
											<!-- email user list end -->



											<!-- no result when nothing to show on list -->
											<div class="no-results">
												<i class="bx bx-error-circle font-large-2"></i>
												<h5>No Items Found</h5>
											</div>






											<div class="ps__rail-x" style="left: 0px; bottom: 0px;">
												<div class="ps__thumb-x" tabindex="0"
													style="left: 0px; width: 0px;"></div>
											</div>
											<div class="ps__rail-y"
												style="top: 0px; height: 733px; right: 0px;">
												<div class="ps__thumb-y" tabindex="0"
													style="top: 0px; height: 567px;"></div>
											</div>



										</div>
									</div>
								</div>
								<!--/ Email list Area -->



							</div>
						</div>
					</div>
				</div>
			</section>
		</div>
	</div>


        





</body>
<script
	src="/project5/resources/dist/assets/vendors/perfect-scrollbar/perfect-scrollbar.min.js"></script>
<script src="/project5/resources/dist/assets/js/bootstrap.bundle.min.js"></script>
<script src="/project5/resources/dist/assets/js/main.js"></script>
</html>