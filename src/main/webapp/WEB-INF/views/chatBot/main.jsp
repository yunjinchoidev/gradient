<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
</style>

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="/project5/resources/dist/assets/css/bootstrap.css">

    <link rel="stylesheet" href="/project5/resources/dist/assets/css/widgets/chat.css">

    <link rel="stylesheet" href="/project5/resources/dist/assets/vendors/perfect-scrollbar/perfect-scrollbar.css">
    <link rel="stylesheet" href="/project5/resources/dist/assets/vendors/bootstrap-icons/bootstrap-icons.css">
    <link rel="stylesheet" href="/project5/resources/dist/assets/css/app.css">
    <link rel="shortcut icon" href="/project5/resources/dist/assets/images/favicon.svg" type="image/x-icon">
    
</head>

<body>
<%@ include file="../common/header.jsp" %>

<div id="main" style="width: 80% ">
            <header class="mb-3">
                <a href="#" class="burger-btn d-block d-xl-none">
                    <i class="bi bi-justify fs-3"></i>
                </a>
            </header>

            <div class="page-heading"  style="margin-left: 300px; ">
                <div class="page-title">
                    <div class="row">
                        <div class="col-12 col-md-6 order-md-1 order-last">
                            <h3>Chatbox</h3>
                            <p class="text-subtitle text-muted">For user to check they list</p>
                        </div>
                        <div class="col-12 col-md-6 order-md-2 order-first">
                            <nav aria-label="breadcrumb" class="breadcrumb-header float-start float-lg-end">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="index.html">Dashboard</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Chatbox</li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                </div>
                <section class="section"  style="margin-left: 300px; height: 1000px;">
                    <div class="row">
                        <div class="col-md-6"  style="margin-left: 300px; ">
                            <div class="card">
                                <div class="card-header">
                                    <div class="media d-flex align-items-center">
                                        <div class="avatar me-3">
                                            <img src="assets/images/faces/1.jpg" alt="" srcset="">
                                            <span class="avatar-status bg-success"></span>
                                        </div>
                                        <div class="name flex-grow-1">
                                            <h6 class="mb-0">Fred</h6>
                                            <span class="text-xs">Online</span>
                                        </div>
                                        <button class="btn btn-sm">
                                            <i data-feather="x"></i>
                                        </button>
                                    </div>
                                </div>
                                <div class="card-body pt-4 bg-grey">
                                    <div class="chat-content">
                                        <div class="chat">
                                            <div class="chat-body">
                                                <div class="chat-message">Hi Alfy, how can i help you?</div>
                                            </div>
                                        </div>
                                        <div class="chat chat-left">
                                            <div class="chat-body">
                                                <div class="chat-message">I'm looking for the best admin dashboard
                                                    template</div>
                                                <div class="chat-message">With bootstrap certainly</div>
                                            </div>
                                        </div>
                                        <div class="chat">
                                            <div class="chat-body">
                                                <div class="chat-message">I recommend you to use Mazer Dashboard</div>
                                            </div>
                                        </div>
                                        <div class="chat chat-left">
                                            <div class="chat-body">
                                                <div class="chat-message">That"s great! I like it so much :)</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-footer">
                                    <div class="message-form d-flex flex-direction-column align-items-center">
                                        <a href="http://" class="black"><i data-feather="smile"></i></a>
                                        <div class="d-flex flex-grow-1 ml-4">
                                            <input type="text" class="form-control" placeholder="Type your message..">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
            </div>

        </div>



</body>