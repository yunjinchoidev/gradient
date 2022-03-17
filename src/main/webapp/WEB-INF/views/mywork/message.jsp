<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.*"
    %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script scr="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&amp;display=swap" rel="stylesheet">
<link rel="stylesheet" href="/project5/resources/dist/assets/css/bootstrap.css">
<link rel="stylesheet" href="/project5/resources/dist/assets/css/pages/email.css">
<link rel="stylesheet" href="/project5/resources/dist/assets/vendors/perfect-scrollbar/perfect-scrollbar.css">
<link rel="stylesheet" href="/project5/resources/dist/assets/vendors/bootstrap-icons/bootstrap-icons.css">
<link rel="stylesheet" href="/project5/resources/dist/assets/css/app.css">
<link rel="shortcut icon" href="/project5/resources/dist/assets/images/favicon.svg" type="image/x-icon">


</head>
<body>


<%@ include file="../common/header.jsp"%>
<div id="main">
            <header class="mb-3">
                <a href="#" class="burger-btn d-block d-xl-none">
                    <i class="bi bi-justify fs-3"></i>
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
                <nav aria-label="breadcrumb" class="breadcrumb-header float-start float-lg-end">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="index.html">Dashboard</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Email Application</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>
    <section class="section content-area-wrapper">
    
    
    
    
    
        <div class="sidebar-left">
            <div class="sidebar">
                <div class="sidebar-content email-app-sidebar d-flex">
                    <!-- sidebar close icon -->
                    <span class="sidebar-close-icon">
                        <i class="bx bx-x"></i>
                    </span>
                    <!-- sidebar close icon -->
                    <div class="email-app-menu">
                        <div class="form-group form-group-compose">
                            <!-- compose button  -->
                            <button type="button" class="btn btn-primary btn-block my-4 compose-btn">
                                <i class="bx bx-plus"></i>
                                기능
                            </button>
                        </div>
                        <div class="sidebar-menu-list ps">
                            <!-- sidebar menu  -->
                            <div class="list-group list-group-messages">
                            
                            
                            
                             
                              <a href="#" class="list-group-item" style="font-size: 20px; font-weight: bolder;">
                                    <div class="fonticon-wrap d-inline me-3">

                                        <svg class="bi" width="1.5em" height="1.5em" fill="currentColor">
                                            <use xlink:href="/project5/resources/dist/assets/vendors/bootstrap-icons/bootstrap-icons.svg#star"></use>
                                        </svg>
                                    </div>
                                    전체
                                </a>
                                
                                
                                
                              <a href="#" class="list-group-item" style="font-size: 20px; font-weight: bolder;">
                                    <div class="fonticon-wrap d-inline me-3">

                                        <svg class="bi" width="1.5em" height="1.5em" fill="currentColor">
                                            <use xlink:href="/project5/resources/dist/assets/vendors/bootstrap-icons/bootstrap-icons.svg#star"></use>
                                        </svg>
                                    </div>
                                    7일전
                                </a>
                            
                              <a href="#" class="list-group-item" style="font-size: 20px; font-weight: bolder;">             
                                    <div class="fonticon-wrap d-inline me-3">

                                        <svg class="bi" width="1.5em" height="1.5em" fill="currentColor">
                                            <use xlink:href="/project5/resources/dist/assets/vendors/bootstrap-icons/bootstrap-icons.svg#star"></use>
                                        </svg>
                                    </div>
                                    <strong>3일전</strong> 
                                </a>
                                
                                
                                  <a href="#" class="list-group-item" style="font-size: 20px; font-weight: bolder;">
                                    <div class="fonticon-wrap d-inline me-3">

                                        <svg class="bi" width="1.5em" height="1.5em" fill="currentColor">
                                            <use xlink:href="/project5/resources/dist/assets/vendors/bootstrap-icons/bootstrap-icons.svg#star"></use>
                                        </svg>
                                    </div>
                                    1일전 
                                </a>
                                
                                
                            
                            
                              <a href="#" class="list-group-item" style="font-size: 20px; font-weight: bolder;">
                                    <div class="fonticon-wrap d-inline me-3">

                                        <svg class="bi" width="1.5em" height="1.5em" fill="currentColor">
                                            <use xlink:href="/project5/resources/dist/assets/vendors/bootstrap-icons/bootstrap-icons.svg#star"></use>
                                        </svg>
                                    </div>
                                    중요 
                                </a>
                            
                                
                                
                                
                                
                                <a href="#" class="list-group-item" style="font-size: 20px; font-weight: bolder;">
                                    <div class="fonticon-wrap d-inline me-3">

                                        <svg class="bi" width="1.5em" height="1.5em" fill="currentColor">
                                            <use xlink:href="/project5/resources/dist/assets/vendors/bootstrap-icons/bootstrap-icons.svg#archive"></use>
                                        </svg>
                                    </div>
                                    시급
                                </a>
                                
                                
                                
                                <a href="#" class="list-group-item" style="font-size: 20px; font-weight: bolder;">
                                    <div class="fonticon-wrap d-inline me-3">

                                        <svg class="bi" width="1.5em" height="1.5em" fill="currentColor">
                                            <use xlink:href="/project5/resources/dist/assets/vendors/bootstrap-icons/bootstrap-icons.svg#pencil"></use>
                                        </svg>
                                    </div> 완료
                                </a>
                                
                                
                                
                                <a href="#" class="list-group-item" style="font-size: 20px; font-weight: bolder;">
                                    <div class="fonticon-wrap d-inline me-3">

                                        <svg class="bi" width="1.5em" height="1.5em" fill="currentColor">
                                            <use xlink:href="/project5/resources/dist/assets/vendors/bootstrap-icons/bootstrap-icons.svg#star"></use>
                                        </svg>
                                    </div>
                                    파일함
                                </a>
                                
                                
                                
                                
                                
                                <a href="#" class="list-group-item" style="font-size: 20px; font-weight: bolder;">
                                    <div class="fonticon-wrap d-inline me-3">
                                        <svg class="bi" width="1.5em" height="1.5em" fill="currentColor">
                                            <use xlink:href="/project5/resources/dist/assets/vendors/bootstrap-icons/bootstrap-icons.svg#info-circle"></use>
                                        </svg>
                                    </div>
                                    이미지 모아 보기
                                    <span class="badge badge-light-danger badge-pill badge-round float-right mt-50">3</span>
                                </a>
                                
                                
                                
                                
                                <a href="#" class="list-group-item" style="font-size: 20px; font-weight: bolder;">
                                    <div class="fonticon-wrap d-inline me-3">
                                        <svg class="bi" width="1.5em" height="1.5em" fill="currentColor">
                                            <use xlink:href="/project5/resources/dist/assets/vendors/bootstrap-icons/bootstrap-icons.svg#trash"></use>
                                        </svg>
                                    </div>
                                   이메일 모음
                                </a>
                                
                                
                                
                                
                                <a href="#" class="list-group-item" style="font-size: 20px; font-weight: bolder;">
                                    <div class="fonticon-wrap d-inline me-3">
                                        <svg class="bi" width="1.5em" height="1.5em" fill="currentColor">
                                            <use xlink:href="/project5/resources/dist/assets/vendors/bootstrap-icons/bootstrap-icons.svg#trash"></use>
                                        </svg>
                                    </div>
                                    코멘트
                                </a>
                                
                                
                                
                                
                                <a href="#" class="list-group-item" style="font-size: 20px; font-weight: bolder;">
                                    <div class="fonticon-wrap d-inline me-3">
                                        <svg class="bi" width="1.5em" height="1.5em" fill="currentColor">
                                            <use xlink:href="/project5/resources/dist/assets/vendors/bootstrap-icons/bootstrap-icons.svg#trash"></use>
                                        </svg>
                                    </div>
                                    휴가 관리
                                </a>
                            </div>
                            <!-- sidebar menu  end-->










							
							
                            <!-- sidebar label start -->
                            <!-- 
                            <label class="sidebar-label">Labels</label>
                            <div class="list-group list-group-labels">
                                <a href="#" class="list-group-item d-flex justify-content-between align-items-center">
                                    Product
                                    <span class="bullet bullet-success bullet-sm"></span>
                                </a>
                                <a href="#" class="list-group-item d-flex justify-content-between align-items-center">
                                    Work
                                    <span class="bullet bullet-primary bullet-sm"></span>
                                </a>
                                <a href="#" class="list-group-item d-flex justify-content-between align-items-center">
                                    Misc
                                    <span class="bullet bullet-warning bullet-sm"></span>
                                </a>
                                <a href="#" class="list-group-item d-flex justify-content-between align-items-center">
                                    Family
                                    <span class="bullet bullet-danger bullet-sm"></span>
                                </a>
                                <a href="#" class="list-group-item d-flex justify-content-between align-items-center">
                                    Design
                                    <span class="bullet bullet-info bullet-sm"></span>
                                </a>
                            </div>
                             -->
                            
                            
                            
                            <!-- sidebar label end -->
                            <div class="ps__rail-x" style="left: 0px; bottom: 0px;">
                                <div class="ps__thumb-x" tabindex="0" style="left: 0px; width: 0px;"></div>
                            </div>
                            <div class="ps__rail-y" style="top: 0px; right: 0px;">
                                <div class="ps__thumb-y" tabindex="0" style="top: 0px; height: 0px;"></div>
                            </div>
                        </div>
                    </div>
                </div>
                
                
                
                
                
                <!-- User new mail right area -->
                <!-- 
                <div class="compose-new-mail-sidebar ps">
                    <div class="card shadow-none quill-wrapper p-0">
                        <div class="card-header">
                            <h3 class="card-title" id="emailCompose">New Message</h3>
                            <button type="button" class="close close-icon">
                                <i class="bx bx-x"></i>
                            </button>
                        </div>
                        
                        
                        
                        <!-- form start -->
                        <!-- 
                        <form action="#" id="compose-form">
                            <div class="card-content">
                                <div class="card-body pt-0">
                                    <div class="form-group pb-50">
                                        <label for="emailfrom">from</label>
                                        <input type="text" id="emailfrom" class="form-control" placeholder="user@example.com" disabled="">
                                    </div>
                                    <div class="form-label-group">
                                        <input type="email" id="emailTo" class="form-control" placeholder="To" required="">
                                        <label for="emailTo">To</label>
                                    </div>
                                    <div class="form-label-group">
                                        <input type="text" id="emailSubject" class="form-control" placeholder="Subject">
                                        <label for="emailSubject">Subject</label>
                                    </div>
                                    <div class="form-label-group">
                                        <input type="text" id="emailCC" class="form-control" placeholder="CC">
                                        <label for="emailCC">CC</label>
                                    </div>
                                    <div class="form-label-group">
                                        <input type="text" id="emailBCC" class="form-control" placeholder="BCC">
                                        <label for="emailBCC">BCC</label>
                                    </div>
                                    <!-- Compose mail Quill editor -->
                                    <!-- 
                                    <div class="snow-container border rounded p-50">
                                        <div class="compose-editor mx-75 ql-container ql-snow">
                                            <div class="ql-editor ql-blank" data-gramm="false" data-placeholder="Type something....." contenteditable="true">
                                                <p><br></p>
                                            </div>
                                            <div class="ql-clipboard" tabindex="-1" contenteditable="true"></div>
                                            <div class="ql-tooltip ql-hidden"><a class="ql-preview" target="_blank" href="about:blank"></a><input type="text" data-formula="e=mc^2" data-link="https://quilljs.com" data-video="Embed URL"><a class="ql-action"></a><a class="ql-remove"></a></div>
                                        </div>
                                        <div class="d-flex justify-content-end">
                                            <div class="compose-quill-toolbar pb-0 ql-toolbar ql-snow">
                                                <span class="ql-formats mr-0">
                                                    <button class="ql-bold" type="button"><svg viewBox="0 0 18 18">
                                                            <path class="ql-stroke" d="M5,4H9.5A2.5,2.5,0,0,1,12,6.5v0A2.5,2.5,0,0,1,9.5,9H5A0,0,0,0,1,5,9V4A0,0,0,0,1,5,4Z">
                                                            </path>
                                                            <path class="ql-stroke" d="M5,9h5.5A2.5,2.5,0,0,1,13,11.5v0A2.5,2.5,0,0,1,10.5,14H5a0,0,0,0,1,0,0V9A0,0,0,0,1,5,9Z">
                                                            </path>
                                                        </svg></button>
                                                    <button class="ql-italic" type="button"><svg viewBox="0 0 18 18">
                                                            <line class="ql-stroke" x1="7" x2="13" y1="4" y2="4"></line>
                                                            <line class="ql-stroke" x1="5" x2="11" y1="14" y2="14">
                                                            </line>
                                                            <line class="ql-stroke" x1="8" x2="10" y1="14" y2="4">
                                                            </line>
                                                        </svg></button>
                                                    <button class="ql-underline" type="button"><svg viewBox="0 0 18 18">
                                                            <path class="ql-stroke" d="M5,3V9a4.012,4.012,0,0,0,4,4H9a4.012,4.012,0,0,0,4-4V3">
                                                            </path>
                                                            <rect class="ql-fill" height="1" rx="0.5" ry="0.5" width="12" x="3" y="15"></rect>
                                                        </svg></button>
                                                    <button class="ql-link" type="button"><svg viewBox="0 0 18 18">
                                                            <line class="ql-stroke" x1="7" x2="11" y1="7" y2="11">
                                                            </line>
                                                            <path class="ql-even ql-stroke" d="M8.9,4.577a3.476,3.476,0,0,1,.36,4.679A3.476,3.476,0,0,1,4.577,8.9C3.185,7.5,2.035,6.4,4.217,4.217S7.5,3.185,8.9,4.577Z">
                                                            </path>
                                                            <path class="ql-even ql-stroke" d="M13.423,9.1a3.476,3.476,0,0,0-4.679-.36,3.476,3.476,0,0,0,.36,4.679c1.392,1.392,2.5,2.542,4.679.36S14.815,10.5,13.423,9.1Z">
                                                            </path>
                                                        </svg></button>
                                                    <button class="ql-image" type="button"><svg viewBox="0 0 18 18">
                                                            <rect class="ql-stroke" height="10" width="12" x="3" y="4">
                                                            </rect>
                                                            <circle class="ql-fill" cx="6" cy="7" r="1"></circle>
                                                            <polyline class="ql-even ql-fill" points="5 12 5 11 7 9 8 10 11 7 13 9 13 12 5 12">
                                                            </polyline>
                                                        </svg></button>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group mt-2">
                                        <div class="custom-file">
                                            <input type="file" class="custom-file-input" id="emailAttach">
                                            <label class="custom-file-label" for="emailAttach">Attach File</label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="card-footer d-flex justify-content-end pt-0">
                                <button type="reset" class="btn btn-light-secondary cancel-btn mr-1">
                                    <i class="bx bx-x me-3"></i>
                                    <span class="d-sm-inline d-none">Cancel</span>
                                </button>
                                <button type="submit" class="btn-send btn btn-primary">
                                    <i class="bx bx-send me-3"></i> <span class="d-sm-inline d-none">Send</span>
                                </button>
                            </div>
                        </form>
                        <!-- form start end-->
                        <!-- 
                    </div>
                    <div class="ps__rail-x" style="left: 0px; bottom: 0px;">
                        <div class="ps__thumb-x" tabindex="0" style="left: 0px; width: 0px;"></div>
                    </div>
                    <div class="ps__rail-y" style="top: 0px; right: 0px;">
                        <div class="ps__thumb-y" tabindex="0" style="top: 0px; height: 0px;"></div>
                    </div>
                </div>
                -->
                <!--/ User Chat profile right area -->
            </div>
        </div>
        
        
        
        
        
        
        
        
        <div class="content-right">
            <div class="content-overlay"></div>
            <div class="content-wrapper">
                <div class="content-header row">
                </div>
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
                                        <div class="checkbox checkbox-shadow checkbox-sm selectAll me-3">
                                            <input type="checkbox" id="checkboxsmall" class="form-check-input">
                                            <label for="checkboxsmall"></label>
                                        </div>
                                        <!-- delete unread dropdown -->
                                        <ul class="list-inline m-0 d-flex">
                                            <li class="list-inline-item mail-delete">
                                                <button type="button" class="btn btn-icon action-icon" data-toggle="tooltip">
                                                    <span class="fonticon-wrap">
                                                        <svg class="bi" width="1.5em" height="1.5em" fill="currentColor">
                                                            <use xlink:href="/project5/resources/dist/assets/vendors/bootstrap-icons/bootstrap-icons.svg#trash"></use>
                                                        </svg>
                                                    </span>
                                                </button>
                                            </li>
                                            <li class="list-inline-item mail-unread">
                                                <button type="button" class="btn btn-icon action-icon">
                                                    <span class="fonticon-wrap d-inline">

                                                        <svg class="bi" width="1.5em" height="1.5em" fill="currentColor">
                                                            <use xlink:href="/project5/resources/dist/assets/vendors/bootstrap-icons/bootstrap-icons.svg#envelope"></use>
                                                        </svg>
                                                    </span>
                                                </button>
                                            </li>
                                            <li class="list-inline-item">
                                                <div class="dropdown">
                                                    <button type="button" class="dropdown-toggle btn btn-icon action-icon" id="folder" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                        <span class="fonticon-wrap">

                                                            <svg class="bi" width="1.5em" height="1.5em" fill="currentColor">
                                                                <use xlink:href="/project5/resources/dist/assets/vendors/bootstrap-icons/bootstrap-icons.svg#folder"></use>
                                                            </svg>
                                                        </span>
                                                    </button>
                                                    <div class="dropdown-menu dropdown-menu-right" aria-labelledby="folder">
                                                        <a class="dropdown-item" href="#"><i class="bx bx-edit"></i>
                                                            Draft</a>
                                                        <a class="dropdown-item" href="#"><i class="bx bx-info-circle"></i>Spam</a>
                                                        <a class="dropdown-item" href="#"><i class="bx bx-trash"></i>Trash</a>
                                                    </div>
                                                </div>
                                            </li>
                                            <li class="list-inline-item">
                                                <div class="dropdown">
                                                    <button type="button" class="btn btn-icon dropdown-toggle action-icon" id="tag" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                        <span class="fonticon-wrap">

                                                            <svg class="bi" width="1.5em" height="1.5em" fill="currentColor">
                                                                <use xlink:href="/project5/resources/dist/assets/vendors/bootstrap-icons/bootstrap-icons.svg#tag"></use>
                                                            </svg>
                                                        </span>
                                                    </button>
                                                    <div class="dropdown-menu dropdown-menu-right" aria-labelledby="tag">
                                                        <a href="#" class="dropdown-item align-items-center">
                                                            <span class="bullet bullet-success bullet-sm"></span>
                                                            <span>Product</span>
                                                        </a>
                                                        <a href="#" class="dropdown-item align-items-center">
                                                            <span class="bullet bullet-primary bullet-sm"></span>
                                                            <span>Work</span>
                                                        </a>
                                                        <a href="#" class="dropdown-item align-items-center">
                                                            <span class="bullet bullet-warning bullet-sm"></span>
                                                            <span>Misc</span>
                                                        </a>
                                                        <a href="#" class="dropdown-item align-items-center">
                                                            <span class="bullet bullet-danger bullet-sm"></span>
                                                            <span>Family</span>
                                                        </a>
                                                        <a href="#" class="dropdown-item align-items-center">
                                                            <span class="bullet bullet-info bullet-sm"></span>
                                                            <span> Design</span>
                                                        </a>
                                                    </div>
                                                </div>
                                            </li>
                                        </ul>
                                    </div>
                                    <!-- action left end here -->

                                    <!-- action right start here -->
                                    <div class="action-right d-flex flex-grow-1 align-items-center justify-content-around">
                                        <!-- search bar  -->
                                        <div class="email-fixed-search flex-grow-1">
                                            <div class="sidebar-toggle d-block d-lg-none">
                                                <i class="bx bx-menu"></i>
                                            </div>

                                            <div class="form-group position-relative  mb-0 has-icon-left">
                                                <input type="text" class="form-control" placeholder="Search email..">
                                                <div class="form-control-icon">
                                                    <svg class="bi" width="1.5em" height="1.5em" fill="currentColor">
                                                        <use xlink:href="assets/vendors/bootstrap-icons/bootstrap-icons.svg#search"></use>
                                                    </svg>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- pagination and page count -->
                                        <span class="d-none d-sm-block">1-10 of 653</span>
                                        <button class="btn btn-icon email-pagination-prev d-none d-sm-block">
                                            <svg class="bi" width="1.5em" height="1.5em" fill="currentColor">
                                                <use xlink:href="/project5/resources/dist/assets/vendors/bootstrap-icons/bootstrap-icons.svg#chevron-left"></use>
                                            </svg>
                                        </button>
                                        <button class="btn btn-icon email-pagination-next d-none d-sm-block">
                                            <svg class="bi" width="1.5em" height="1.5em" fill="currentColor">
                                                <use xlink:href="/project5/resources/dist/assets/vendors/bootstrap-icons/bootstrap-icons.svg#chevron-right"></use>
                                            </svg>
                                        </button>
                                    </div>
                                </div>
                                <!-- / action right -->






















                                <!-- email user list start -->
                                <div class="email-user-list list-group ps ps--active-y" >
                                    <ul class="users-list-wrapper media-list">
                                    
                                    
                                    <c:forEach var="list" items="${list }" varStatus="var"> 
                                        <li class="media mail-read">
                                            <div class="user-action">
                                                <div class="checkbox-con me-3">
                                                    <div class="checkbox checkbox-shadow checkbox-sm">
                                                        <input type="checkbox" id="checkboxsmall1" class="form-check-input">
                                                        <label for="checkboxsmall1"></label>
                                                    </div>
                                                </div>
                                                
                                                
                                                <span class="favorite text-warning">
                                                    <svg class="bi" width="1.5em" height="1.5em" fill="currentColor">
                                                        <use xlink:href="assets/vendors/bootstrap-icons/bootstrap-icons.svg#star-fill"></use>
                                                    </svg>
                                                </span>
                                            </div>
                                            
                                            
                                            <div class="pr-50">
                                                <div class="avatar">
                                                    <img src="/project5/resources/dist/assets/images/faces/1.jpg" alt="avtar img holder">
                                                </div>
                                            </div>
                                            
                                            
                                            
                                            <div class="media-body">
                                                <div class="user-details">
                                                    <div class="mail-items">
                                                        <span class="list-group-item-text text-truncate">${list.title}</span>
                                                    </div>
                                                    <div class="mail-meta-item">
                                                        <span class="float-right">
                                                            <span class="mail-date">4:14 AM</span>
                                                        </span>
                                                    </div>
                                                </div>
                                                <div class="mail-message">
                                                    <p class="list-group-item-text truncate mb-0">
                                                        ${list.content }
                                                    </p>
                                                    <div class="mail-meta-item">
                                                        <span class="float-right">
                                                            <span class="bullet bullet-success bullet-sm"></span>
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
                                        <div class="ps__thumb-x" tabindex="0" style="left: 0px; width: 0px;"></div>
                                    </div>
                                    <div class="ps__rail-y" style="top: 0px; height: 733px; right: 0px;">
                                        <div class="ps__thumb-y" tabindex="0" style="top: 0px; height: 567px;"></div>
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
<script src="/project5/resources/dist/assets/vendors/perfect-scrollbar/perfect-scrollbar.min.js"></script>
<script src="/project5/resources/dist/assets/js/bootstrap.bundle.min.js"></script>
<script src="/project5/resources/dist/assets/js/main.js"></script>
</html>