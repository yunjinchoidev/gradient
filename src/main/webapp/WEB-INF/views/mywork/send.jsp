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










  <!-- Detailed Email View -->
                        <div class="email-app-details">
                            <!-- email detail view header -->
                            <div class="email-detail-header">
                                <div class="email-header-left d-flex align-items-center mb-1">
                                    <span class="go-back me-3">
                                        <span class="fonticon-wrap d-inline">
                                            <i class="fas fa-chevron-left"></i>
                                        </span>
                                    </span>
                                    <h5 class="email-detail-title font-weight-normal mb-0">
                                        Advertising Internet Online
                                        <span class="badge badge-light-danger badge-pill ms-1">PRODUCT</span>
                                    </h5>
                                </div>
                                <div class="email-header-right mb-1 ml-2 pl-1">
                                    <ul class="list-inline m-0">
                                        <li class="list-inline-item">
                                            <button class="btn btn-icon action-icon">
                                                <span class="fonticon-wrap">
                                                    <i class="fas fa-trash"></i>
                                                </span>
                                            </button>
                                        </li>
                                        <li class="list-inline-item">
                                            <button class="btn btn-icon action-icon">
                                                <span class="fonticon-wrap">
                                                    <svg class="bi" width="1.5em" height="1.5em" fill="currentColor">
                                                        <use xlink:href="assets/vendors/bootstrap-icons/bootstrap-icons.svg#envelope"></use>
                                                    </svg>
                                                </span>
                                            </button>
                                        </li>
                                        <li class="list-inline-item">
                                            <div class="dropdown">
                                                <button class="btn btn-icon dropdown-toggle action-icon" id="open-mail-menu" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                    <span class="fonticon-wrap">
                                                        <i class="fas fa-folder"></i>
                                                    </span>
                                                </button>
                                                <div class="dropdown-menu dropdown-menu-right" aria-labelledby="open-mail-menu">
                                                    <a class="dropdown-item" href="#"><i class="bx bx-edit"></i>
                                                        Draft</a>
                                                    <a class="dropdown-item" href="#"><i class="bx bx-info-circle"></i>
                                                        Spam</a>
                                                    <a class="dropdown-item" href="#"><i class="bx bx-trash"></i>
                                                        Trash</a>
                                                </div>
                                            </div>
                                        </li>
                                        <li class="list-inline-item">
                                            <div class="dropdown">
                                                <button class="btn btn-icon dropdown-toggle action-icon" id="open-mail-tag" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                    <span class="fonticon-wrap">
                                                        <i class="fas fa-tag"></i>
                                                    </span>
                                                </button>
                                                <div class="dropdown-menu dropdown-menu-right" aria-labelledby="open-mail-tag">
                                                    <a href="#" class="dropdown-item align-items-center">
                                                        <span class="bullet bullet-success bullet-sm"></span>
                                                        Product
                                                    </a>
                                                    <a href="#" class="dropdown-item align-items-center">
                                                        <span class="bullet bullet-primary bullet-sm"></span>
                                                        Work
                                                    </a>
                                                    <a href="#" class="dropdown-item align-items-center">
                                                        <span class="bullet bullet-warning bullet-sm"></span>
                                                        Misc
                                                    </a>
                                                    <a href="#" class="dropdown-item align-items-center">
                                                        <span class="bullet bullet-danger bullet-sm"></span>
                                                        Family
                                                    </a>
                                                    <a href="#" class="dropdown-item align-items-center">
                                                        <span class="bullet bullet-info bullet-sm"></span>
                                                        Design
                                                    </a>
                                                </div>
                                            </div>
                                        </li>
                                        <li class="list-inline-item">
                                            <span class="no-of-list d-none d-sm-block ms-1">1-10 of 653</span>
                                        </li>
                                        <li class="list-inline-item">
                                            <button class="btn btn-icon email-pagination-prev action-icon">
                                                <i class="bx bx-chevron-left"></i>
                                            </button>
                                        </li>
                                        <li class="list-inline-item">
                                            <button class="btn btn-icon email-pagination-next action-icon">
                                                <i class="bx bx-chevron-right"></i>
                                            </button>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            
                            <!-- email detail view header end-->
                            <div class="email-scroll-area ps ps--active-y">
                                <!-- email details  -->
                                <div class="row">
                                    <div class="col-12">
                                        <div class="collapsible email-detail-head">
                                            <div class="card collapse-header" role="tablist">
                                                <div id="headingCollapse5" class="card-header d-flex justify-content-between align-items-center" data-toggle="collapse" role="tab" data-target="#collapse5" aria-expanded="false" aria-controls="collapse5">
                                                    <div class="collapse-title media">
                                                        <div class="pr-1">
                                                            <div class="avatar mr-75">
                                                                <img src="/project5/resources/dist/assets/images/faces/18.jpg" alt="avtar img holder" width="30" height="30">
                                                            </div>
                                                        </div>
                                                        <div class="media-body mt-25">
                                                            <span class="text-primary">Elnora Reese</span>
                                                            <span class="d-sm-inline d-none">
                                                                &lt;elnora@gmail.com&gt;</span>
                                                            <small class="text-muted d-block">to Lois Jimenez</small>
                                                        </div>
                                                    </div>
                                                    <div class="information d-sm-flex d-none align-items-center">
                                                        <small class="text-muted me-3">15 Jul 2019, 10:30</small>
                                                        <span class="favorite">
                                                            <i class="bx bx-star me-3"></i>
                                                        </span>
                                                        <div class="dropdown">
                                                            <a href="#" class="dropdown-toggle" id="fisrt-open-submenu" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                                <i class="bx bx-dots-vertical-rounded mr-0"></i>
                                                            </a>
                                                            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="fisrt-open-submenu">
                                                                <a href="#" class="dropdown-item mail-reply">
                                                                    <i class="bx bx-share"></i>
                                                                    Reply
                                                                </a>
                                                                <a href="#" class="dropdown-item">
                                                                    <i class="bx bx-redo"></i>
                                                                    Forward
                                                                </a>
                                                                <a href="#" class="dropdown-item">
                                                                    <i class="bx bx-info-circle"></i>
                                                                    Report Spam
                                                                </a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div id="collapse5" role="tabpanel" aria-labelledby="headingCollapse5" class="collapse">
                                                    <div class="card-content">
                                                        <div class="card-body py-1">
                                                            <p class="text-bold-500">Greetings!</p>
                                                            <p>
                                                                Lorem Ipsum is simply dummy text of the printing and
                                                                typesetting industry. Lorem Ipsum has been
                                                                the industry's standard dummy text ever since the 1500s,
                                                                when an unknown printer took a galley of
                                                                type and scrambled it to make a type specimen book.
                                                            </p>
                                                            <p>
                                                                It has survived not only five centuries, but also the
                                                                leap into electronic typesetting, remaining
                                                                essentially unchanged.
                                                            </p>
                                                            <p class="mb-0">Sincerely yours,</p>
                                                            <p class="text-bold-500">Envato Design Team</p>
                                                        </div>
                                                        <div class="card-footer pt-0 border-top">
                                                            <label class="sidebar-label">Attached Files</label>
                                                            <ul class="list-unstyled mb-0">
                                                                <li class="cursor-pointer pb-25">
                                                                    <img src="../../../app-assets/images/icon/psd.png" alt="psd.png" height="30">
                                                                    <small class="text-muted ms-1 attchement-text">uikit-design.psd</small>
                                                                </li>
                                                                <li class="cursor-pointer">
                                                                    <img src="../../../app-assets/images/icon/sketch.png" alt="sketch.png" height="30">
                                                                    <small class="text-muted ms-1 attchement-text">uikit-design.sketch</small>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="card collapse-header" role="tablist">
                                                <div id="headingCollapse6" class="card-header d-flex justify-content-between align-items-center" data-toggle="collapse" role="tab" data-target="#collapse6" aria-expanded="false" aria-controls="collapse6">
                                                    <div class="collapse-title media">
                                                        <div class="pr-1">
                                                            <div class="avatar mr-75">
                                                                <img src="/project5/resources/dist/assets/images/faces/19.jpg" alt="avtar img holder" width="30" height="30">
                                                            </div>
                                                        </div>
                                                        <div class="media-body mt-25">
                                                            <span class="text-primary">Lois Jimenez </span>
                                                            <span class="d-sm-inline d-none">
                                                                &lt;lois_jim@gmail.com&gt;</span>
                                                            <small class="text-muted d-block">to Elnora Reese</small>
                                                        </div>
                                                    </div>
                                                    <div class="information d-sm-flex d-none align-items-center">
                                                        <i class="bx bx-paperclip me-3"></i>
                                                        <small class="text-muted me-3">10 Jul 2019, 10:30</small>
                                                        <span class="favorite">
                                                            <i class="bx bx-star me-3"></i>
                                                        </span>
                                                        <div class="dropdown">
                                                            <a href="#" class="dropdown-toggle" id="second-open-submenu" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                                <i class="bx bx-dots-vertical-rounded mr-0"></i>
                                                            </a>
                                                            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="second-open-submenu">
                                                                <a href="#" class="dropdown-item mail-reply">
                                                                    <i class="bx bx-share"></i>
                                                                    Reply
                                                                </a>
                                                                <a href="#" class="dropdown-item">
                                                                    <i class="bx bx-redo"></i>
                                                                    Forward
                                                                </a>
                                                                <a href="#" class="dropdown-item">
                                                                    <i class="bx bx-info-circle"></i>
                                                                    Report Spam
                                                                </a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div id="collapse6" role="tabpanel" aria-labelledby="headingCollapse7" class="collapse">
                                                    <div class="card-content">
                                                        <div class="card-body py-1">
                                                            <p class="text-bold-500">Greetings!</p>
                                                            <p>
                                                                Successful businesses have many things in common, today
                                                                we’ll look at the big ‘R’of recognition
                                                                and how a digital advertising network may help.
                                                                Recognition can be illustrated by two individuals
                                                                entering a crowded room at a party. Both walk to the far
                                                                side of the room, one of them slips
                                                                through the crowd easily and unnoticed as they reach the
                                                                far side.
                                                            </p>
                                                            <p>
                                                                Gummies sweet tart marzipan lemon drops donut pie.
                                                                Chocolate cake gingerbread jujubes gingerbread
                                                                chocolate cake tart bear claw apple pie jelly-o.
                                                                Gummies biscuit brownie marshmallow oat cake tootsie
                                                                roll bear claw topping. Oat cake sesame snaps
                                                                icing cupcake wafer tiramisu jelly-o sugar plum carrot
                                                                cake
                                                            </p>
                                                            <p class="mb-0">Sincerely yours,</p>
                                                            <p class="text-bold-500">Envato Design Team</p>
                                                        </div>
                                                        <div class="card-footer pt-0 border-top">
                                                            <label class="sidebar-label">Attached Files</label>
                                                            <ul class="list-unstyled mb-0">
                                                                <li class="cursor-pointer pb-25">
                                                                    <img src="../../../app-assets/images/icon/psd.png" alt="psd.png" height="30">
                                                                    <small class="text-muted ms-1 attchement-text">uikit-design.psd</small>
                                                                </li>
                                                                <li class="cursor-pointer">
                                                                    <img src="../../../app-assets/images/icon/sketch.png" alt="sketch.png" height="30">
                                                                    <small class="text-muted ms-1 attchement-text">uikit-design.sketch</small>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="card collapse-header open" role="tablist">
                                                <div id="headingCollapse7" class="card-header d-flex justify-content-between align-items-center" data-toggle="collapse" role="tab" data-target="#collapse7" aria-expanded="false" aria-controls="collapse7">
                                                    <div class="collapse-title media">
                                                        <div class="pr-1">
                                                            <div class="avatar mr-75">
                                                                <img src="/project5/resources/dist/assets/images/faces/18.jpg" alt="avtar img holder" width="30" height="30">
                                                            </div>
                                                        </div>
                                                        <div class="media-body mt-25">
                                                            <span class="text-primary">Elnora Reese</span>
                                                            <span class="d-sm-inline d-none">&lt;elnora@gmail.com&gt;</span>
                                                            <small class="text-muted d-block">to Lois Jimenez</small>
                                                        </div>
                                                    </div>
                                                    <div class="information d-sm-flex d-none align-items-center">
                                                        <small class="text-muted me-3">05 Jul 2019, 10:30</small>
                                                        <span class="favorite text-warning">
                                                            <svg class="bi" width="1.5em" height="1.5em" fill="currentColor">
                                                                <use xlink:href="/project5/resources/dist/assets/vendors/bootstrap-icons/bootstrap-icons.svg#star-fill"></use>
                                                            </svg>
                                                        </span>
                                                        <div class="dropdown">
                                                            <a href="#" class="dropdown-toggle" id="third-open-menu" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                                <i class="bx bx-dots-vertical-rounded mr-0"></i>
                                                            </a>
                                                            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="second-open-submenu">
                                                                <a href="#" class="dropdown-item mail-reply">
                                                                    <i class="bx bx-share"></i>
                                                                    Reply
                                                                </a>
                                                                <a href="#" class="dropdown-item">
                                                                    <i class="bx bx-redo"></i>
                                                                    Forward
                                                                </a>
                                                                <a href="#" class="dropdown-item">
                                                                    <i class="bx bx-info-circle"></i>
                                                                    Report Spam
                                                                </a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div id="collapse7" role="tabpanel" aria-labelledby="headingCollapse7" class="collapse show">
                                                    <div class="card-content">
                                                        <div class="card-body py-1">
                                                            <p class="text-bold-500">Greetings!</p>
                                                            <p>
                                                                It is a long established fact that a reader will be
                                                                distracted by the readable content of a page
                                                                when looking at its layout.The point of using Lorem
                                                                Ipsum is that it has a more-or-less normal
                                                                distribution of letters, as opposed to using 'Content
                                                                here, content here',making it look like
                                                                readable English.
                                                            </p>
                                                            <p>
                                                                There are many variations of passages of Lorem Ipsum
                                                                available, but the majority have suffered
                                                                alteration in some form, by injected humour, or
                                                                randomised words which don't look even slightly
                                                                believable.
                                                            </p>
                                                            <p class="mb-0">Sincerely yours,</p>
                                                            <p class="text-bold-500">Envato Design Team</p>
                                                        </div>
                                                        <div class="card-footer pt-0 border-top">
                                                            <label class="sidebar-label">Attached Files</label>
                                                            <ul class="list-unstyled mb-0">
                                                                <li class="cursor-pointer pb-25">
                                                                    <img src="../../../app-assets/images/icon/psd.png" alt="psd.png" height="30">
                                                                    <small class="text-muted ms-1 attchement-text">uikit-design.psd</small>
                                                                </li>
                                                                <li class="cursor-pointer">
                                                                    <img src="../../../app-assets/images/icon/sketch.png" alt="sketch.png" height="30">
                                                                    <small class="text-muted ms-1 attchement-text">uikit-design.sketch</small>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- email details  end-->
                                <div class="row px-2 mb-4">
                                    <!-- quill editor for reply message -->
                                    <div class="col-12 px-0">
                                        <div class="card shadow-none border rounded">
                                            <div class="card-body quill-wrapper">
                                                <span>Reply to Lois Jimenez</span>
                                                <div class="snow-container" id="detail-view-quill">
                                                    <div class="detail-view-editor ql-container ql-snow">
                                                        <div class="ql-editor ql-blank" data-gramm="false" data-placeholder="Type something....." contenteditable="true">
                                                            <p><br></p>
                                                        </div>
                                                        <div class="ql-clipboard" tabindex="-1" contenteditable="true">
                                                        </div>
                                                        <div class="ql-tooltip ql-hidden"><a class="ql-preview" target="_blank" href="about:blank"></a><input type="text" data-formula="e=mc^2" data-link="https://quilljs.com" data-video="Embed URL"><a class="ql-action"></a><a class="ql-remove"></a></div>
                                                    </div>
                                                    <div class="d-flex justify-content-end">
                                                        <div class="detail-quill-toolbar ql-toolbar ql-snow">
                                                            <span class="ql-formats me-3">
                                                                <button class="ql-bold" type="button"><svg viewBox="0 0 18 18">
                                                                        <path class="ql-stroke" d="M5,4H9.5A2.5,2.5,0,0,1,12,6.5v0A2.5,2.5,0,0,1,9.5,9H5A0,0,0,0,1,5,9V4A0,0,0,0,1,5,4Z">
                                                                        </path>
                                                                        <path class="ql-stroke" d="M5,9h5.5A2.5,2.5,0,0,1,13,11.5v0A2.5,2.5,0,0,1,10.5,14H5a0,0,0,0,1,0,0V9A0,0,0,0,1,5,9Z">
                                                                        </path>
                                                                    </svg></button>
                                                                <button class="ql-italic" type="button"><svg viewBox="0 0 18 18">
                                                                        <line class="ql-stroke" x1="7" x2="13" y1="4" y2="4"></line>
                                                                        <line class="ql-stroke" x1="5" x2="11" y1="14" y2="14"></line>
                                                                        <line class="ql-stroke" x1="8" x2="10" y1="14" y2="4"></line>
                                                                    </svg></button>
                                                                <button class="ql-underline" type="button"><svg viewBox="0 0 18 18">
                                                                        <path class="ql-stroke" d="M5,3V9a4.012,4.012,0,0,0,4,4H9a4.012,4.012,0,0,0,4-4V3">
                                                                        </path>
                                                                        <rect class="ql-fill" height="1" rx="0.5" ry="0.5" width="12" x="3" y="15"></rect>
                                                                    </svg></button>
                                                                <button class="ql-link" type="button"><svg viewBox="0 0 18 18">
                                                                        <line class="ql-stroke" x1="7" x2="11" y1="7" y2="11"></line>
                                                                        <path class="ql-even ql-stroke" d="M8.9,4.577a3.476,3.476,0,0,1,.36,4.679A3.476,3.476,0,0,1,4.577,8.9C3.185,7.5,2.035,6.4,4.217,4.217S7.5,3.185,8.9,4.577Z">
                                                                        </path>
                                                                        <path class="ql-even ql-stroke" d="M13.423,9.1a3.476,3.476,0,0,0-4.679-.36,3.476,3.476,0,0,0,.36,4.679c1.392,1.392,2.5,2.542,4.679.36S14.815,10.5,13.423,9.1Z">
                                                                        </path>
                                                                    </svg></button>
                                                                <button class="ql-image" type="button"><svg viewBox="0 0 18 18">
                                                                        <rect class="ql-stroke" height="10" width="12" x="3" y="4"></rect>
                                                                        <circle class="ql-fill" cx="6" cy="7" r="1">
                                                                        </circle>
                                                                        <polyline class="ql-even ql-fill" points="5 12 5 11 7 9 8 10 11 7 13 9 13 12 5 12">
                                                                        </polyline>
                                                                    </svg></button>
                                                            </span>
                                                        </div>
                                                        <button class="btn btn-primary send-btn">
                                                            <i class="bx bx-send me-3"></i>
                                                            <span class="d-none d-sm-inline"> Send</span>
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="ps__rail-x" style="left: 0px; bottom: 0px;">
                                    <div class="ps__thumb-x" tabindex="0" style="left: 0px; width: 0px;"></div>
                                </div>
                                <div class="ps__rail-y" style="top: 0px; height: 736px; right: 0px;">
                                    <div class="ps__thumb-y" tabindex="0" style="top: 0px; height: 626px;"></div>
                                </div>
                            </div>
                        </div>
                        <!--/ Detailed Email View -->




























































                      
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>

            <footer>
                <div class="footer clearfix mb-0 text-muted">
                    <div class="float-start">
                        <p>2021 © Mazer</p>
                    </div>
                    <div class="float-end">
                        <p>Crafted with <span class="text-danger"><i class="bi bi-heart"></i></span> by <a href="http://ahmadsaugi.com">A. Saugi</a></p>
                    </div>
                </div>
            </footer>
        </div>
</body>
<script src="/project5/resources/dist/assets/vendors/perfect-scrollbar/perfect-scrollbar.min.js"></script>
<script src="/project5/resources/dist/assets/js/bootstrap.bundle.min.js"></script>
<script src="/project5/resources/dist/assets/js/main.js"></script>
</html>