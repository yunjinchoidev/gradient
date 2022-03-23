<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.*"
    %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<fmt:requestEncoding value="utf-8"/>     
<!DOCTYPE html>
<%--


 --%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.js"></script>
<link rel="stylesheet" href="${path}/a00_com/bootstrap.min.css" >
<link rel="stylesheet" href="${path}/a00_com/jquery-ui.css" >
<style>
	.input-group-text{width:100%;font-weight:bolder;}
	.input-group-prepend{width:20%;}
	#chatArea{
		width:80%;height:200px;overflow-y:auto;text-align:left;
		border:1px solid green;
	}
</style>
<script src="${path}/a00_com/jquery.min.js"></script>
<script src="${path}/a00_com/popper.min.js"></script>
<script src="${path}/a00_com/bootstrap.min.js"></script>
<script src="${path}/a00_com/jquery-ui.js"></script>
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
		//  원격 접속시에는 고정 ip 할당 받아서 처리..106.10.16.155
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
<style>
body{margin-top:20px;}

.chat-online {
    color: #34ce57
}

.chat-offline {
    color: #e4606d
}

.chat-messages {
    display: flex;
    flex-direction: column;
    max-height: 800px;
    overflow-y: scroll
}

.chat-message-left,
.chat-message-right {
    display: flex;
    flex-shrink: 0
}

.chat-message-left {
    margin-right: auto
}

.chat-message-right {
    flex-direction: row-reverse;
    margin-left: auto
}
.py-3 {
    padding-top: 1rem!important;
    padding-bottom: 1rem!important;
}
.px-4 {
    padding-right: 1.5rem!important;
    padding-left: 1.5rem!important;
}
.flex-grow-0 {
    flex-grow: 0!important;
}
.border-top {
    border-top: 1px solid #dee2e6!important;
}
</style>
</head>

<body>

<%@ include file="../common/header.jsp"%>



	<div id="main">

		<div class="page-heading">
			<div class="page-title">
				<div class="row">

					<%@ include file="../projectHome/sort.jsp"%>






					<div class="col-12 col-md-6 order-md-1 order-last">
						<span style="font-size: 40px; font-weight: bolder; color: red;">고객 상담
						</span> <span style="font-size: 40px; font-weight: bolder; color: black;">홈</span>
						<p class="text-subtitle text-muted">고객 상담을 확인하십시오.</p>
					</div>

					<div class="col-12 col-md-6 order-md-2 order-first">
						<nav aria-label="breadcrumb"
							class="breadcrumb-header float-start float-lg-end">
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="index.html">Dashboard</a></li>
								<li class="breadcrumb-item active" aria-current="page">DataTable</li>
							</ol>
						</nav>
					</div>

				</div>






			</div>
			<section class="section">
				<div class="card">
					<div class="card-header">프로젝트 공지사항</div>
					<div class="card-body">
						<div
							class="dataTable-wrapper dataTable-loading no-footer sortable searchable fixed-columns">



							<div class="dataTable-top">
								<div class="dataTable-dropdown" style="width: 30%;">
									<select class="dataTable-selector form-select"><option
											value="5">5</option>
										<option value="10" selected="">10</option>
										<option value="15">15</option>
										<option value="20">20</option>
										<option value="25">25</option></select><label>entries per page</label>
								</div>
								<div class="dataTable-search">
									<input class="dataTable-input" placeholder="${member.name }님" value="${member.name }님" type="text"  id="id"> 
										<a class="btn btn-danger" style="text-align: right" id="enterBtn">입장하기</a> 
										<a href="/project5/voteWriteForm.do" class="btn btn-info"
										style="text-align: right" id="exitBtn" >종료</a> 
								</div>
							</div>

							<div class="dataTable-container">
							
											

<main class="content" style="border: 1px solid black">
    <div class="container p-0">

		<h1 class="h3 mb-3">고객상담</h1>

		<div class="card">
			<div class="row g-0">
				<div class="col-12 col-lg-5 col-xl-3 border-right">

					<div class="px-4 d-none d-md-block">
						<div class="d-flex align-items-center">
							<div class="flex-grow-1">
								<input type="text" class="form-control my-3" placeholder="Search...">
							</div>
						</div>
					</div>

					<a href="#" class="list-group-item list-group-item-action border-0">
						<div class="badge bg-success float-right">5</div>
						<div class="d-flex align-items-start">
							<img src="https://bootdey.com/img/Content/avatar/avatar5.png" class="rounded-circle mr-1" alt="Vanessa Tucker" width="40" height="40">
							<div class="flex-grow-1 ml-3">
								Vanessa Tucker
								<div class="small"><span class="fas fa-circle chat-online"></span> Online</div>
							</div>
						</div>
					</a>
					
					
				
					
					
				
				
				
					
					
					

					<hr class="d-block d-lg-none mt-1 mb-0">
				</div>
				<div class="col-12 col-lg-7 col-xl-9">
				
					<div class="py-2 px-4 border-bottom d-none d-lg-block">
						<div class="d-flex align-items-center py-1">
							<div class="position-relative">
								<img src="https://bootdey.com/img/Content/avatar/avatar3.png" class="rounded-circle mr-1" alt="Sharon Lessman" width="40" height="40">
							</div>
							<div class="flex-grow-1 pl-3">
								<strong>상담원1</strong>
								<div class="text-muted small"><em>Typing...</em></div>
							</div>
							<div>
								<button class="btn btn-primary btn-lg mr-1 px-3"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-phone feather-lg"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"></path></svg></button>
								<button class="btn btn-info btn-lg mr-1 px-3 d-none d-md-inline-block"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-video feather-lg"><polygon points="23 7 16 12 23 17 23 7"></polygon><rect x="1" y="5" width="15" height="14" rx="2" ry="2"></rect></svg></button>
								<button class="btn btn-light border btn-lg px-3"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-more-horizontal feather-lg"><circle cx="12" cy="12" r="1"></circle><circle cx="19" cy="12" r="1"></circle><circle cx="5" cy="12" r="1"></circle></svg></button>
							</div>
						</div>
					</div>




					<div class="position-relative">
						<div class="chat-messages p-4" id="chatMessageArea">
							<div class="chat-message-right pb-4">
								<div>
									<img src="https://bootdey.com/img/Content/avatar/avatar1.png" class="rounded-circle mr-1" alt="Chris Wood" width="40" height="40">
									<div class="text-muted small text-nowrap mt-2">2:33 am</div>
								</div>
								<div class="flex-shrink-1 bg-light rounded py-2 px-3 mr-3">
									<div class="font-weight-bold mb-1">You</div>
									Lorem ipsum dolor sit amet, vis erat denique in, dicunt prodesset te vix.
								</div>
							</div>
							<div class="chat-message-left pb-4">
								<div>
									<img src="https://bootdey.com/img/Content/avatar/avatar3.png" class="rounded-circle mr-1" alt="Sharon Lessman" width="40" height="40">
									<div class="text-muted small text-nowrap mt-2">2:34 am</div>
								</div>
								<div class="flex-shrink-1 bg-light rounded py-2 px-3 ml-3">
									<div class="font-weight-bold mb-1">Sharon Lessman</div>
									Sit meis deleniti eu, pri vidit meliore docendi ut, an eum erat animal commodo.
								</div>
							</div>
						</div>
					</div>
					
					
					
					

					<div class="flex-grow-0 py-3 px-4 border-top">
						<div class="input-group">
							<input type="text" class="form-control" placeholder="Type your message" id="msg" >
							<button class="btn btn-primary"  id="sendBtn">전송</button>
						</div>
					</div>

				</div>
			</div>
		</div>
	</div>
</main>
	

							










							</div>






						</div>
					</div>
				</div>
			</section>
		</div>

	</div>


</body>
</html>