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
<script type="text/javascript">
	var wsocket;
	$(document).ready(function(){
		// 1. 웹 소켓 클라이언트를 통해 웹 서버 연결하기.
		
		$("#enterBtn").click(function(){
			conn();
		});
		$("#id").keyup(function(){
			if(event.keyCode==13){
				conn();
			}
		})
		$("#msg").keyup(function(){
			if(event.keyCode==13) sendMsg();
		});
		$("#sendBtn").click(function(){
			sendMsg();
		});
		// 접속 종료를 처리했을 시
		$("#exitBtn").click(function(){
			wsocket.send("msg:"+$("#id").val()+":접속 종료 했습니다!");
			wsocket.close();
		});
		// 메시지는 보내는 기능 메서드
		function sendMsg(){
			var id = $("#id").val();
			var msg = $("#msg").val();
			// message를 보내는 처리..서버의 handler의  handleTextMessage()와 연동
			wsocket.send("msg:"+id+":"+msg);
			$("#msg").val(""); $("#msg").focus();
		}
		
		<%-- 
		
		--%>	
	});
	function conn(){
		//  원격 접속시에는 고정 ip 할당 받아서 처리..
		// wsocket = new WebSocket("ws:/106.10.23.227:7080/${path}/chat-ws.do");
		// local에서 다른 브라우저로 실행시 처리할 내용..
		wsocket = new WebSocket("ws:/106.10.16.155:7080/${path}/chat-ws.do");
		// handler :afterConnectionEstablished(WebSocketSession session)와 연결
		wsocket.onopen=function(evt){ 
			console.log(evt);
			wsocket.send("msg:"+$("#id").val()+":연결 접속했습니다!");
		}
		// handler의  handleTextMessage()
		// 연결되어 있으면 메시지를 push형식으로 서버에서 받을 수 있다.
		// ex) wsocket.send("msg:"+$("#id").val()+":연결 접속했습니다!");
		// push 방식으로 서버에서 전달되어 온 데이터를 받게 처리..
		wsocket.onmessage=function(evt){
			// 받은 데이터
			var msg = evt.data;
			// msg 내용 삭제 후, 처리
			if(msg.substring(0,4)=="msg:"){
				// 메시지 내용만 전달
				// 메시지 내용 scrolling 처리..
				var revMsg = msg.substring(4)
				$("#chatMessageArea").append(revMsg+"<br>");
				// 1. 전체 chatMessageArea의 입력된 최대 높이 구하기..
				var mx = parseInt($("#chatMessageArea").height())
				// 2. 포함하고 있는 div의 scrollTop을 통해 최하단의 내용으로 scrolling 하기..
				//    chatArea
				$("#chatArea").scrollTop(mx);
			}
		}
		// handler의 afterConnectionClose와 연동
		wsocket.onclose=function(){

			alert($("#id").val()+'접속 종료합니다.')
			$("#chatMessageArea").text("");
			$("#id").val("");
			$("#id").focus();
		}
		
	}
	
	
	
</script>
<body>
<%@ include file="../common/header.jsp" %>

<div id="main" style="width: 80%; height: 800px; ">
            <header class="mb-3">
                <a href="#" class="burger-btn d-block d-xl-none">
                    <i class="bi bi-justify fs-3"></i>
                </a>
            </header>

            <div class="page-heading"  style="margin-left: 300px; height: 800px; ">
                <div class="page-title">
                    <div class="row">
                        <div class="col-12 col-md-6 order-md-1 order-last">
                            <h3>챗봇</h3>
                            <p class="text-subtitle text-muted">챗봇에게 도움을 청하십시오</p>
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
                <section class="section" >
                    <div class="row">
                        <div class="col-md-6" >
                            <div class="card">
                                <div class="card-header">
                                    <div class="media d-flex align-items-center">
                                        <div class="avatar me-3">
                                            <img src="/project5/resources/assets/images/faces/1.jpg" alt="" srcset="">
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