<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<fmt:requestEncoding value="utf-8"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>채팅</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.js"></script>
<link rel="stylesheet" href="${path}/a00_com/bootstrap.min.css" >
<link rel="stylesheet" href="${path}/a00_com/jquery-ui.css" >
<style>
	#chatArea{
		width:80%;height:200px;overflow-y:auto;text-align:left;
		border:1px solid green;
	}
	*{ margin: 0; padding: 0; }
	.chat_wrap .header { display: flex; justify-content: space-between; font-size: 14px; padding: 20px 30px; background: #25396f; color: white; align-items: center;}

	.chat_wrap .input-div { position: fixed; display: flex; bottom: 0; width: 100%; height: 120px; background-color: #FFF; text-align: center; border-top: 1px solid #25396f; }
	.chat_wrap .input-div > textarea { width: 100%; height: 100%; border: none; resize: none; padding: 10px; }
	.chat_wrap .input-div > textarea:focus {outline:none; background: #E6E6FA;}
	 
	.format { display: none; }
	
	.chatArea{
	    width: 100%;
	    height: 600px;
	    overflow-y: auto;
	    text-align: left;
	 }
	 .infoBox{
	 	text-align: center; 
	 	color: white;
	 	background:gray;
	 	border-radius: 5px;
	 	padding: 1px;
	 }
	 .chatBox{
	 	margin: -15px 0px;
	 }
	 
	 .nameBox{
	 	margin: 10px;
	 }
	 .msgBox{
	 	color:#555;
	    background: white;
	    border: 1px solid #25396f;
	    border-radius: 0 20px 20px 20px;
	    margin: 0 10px;
    	padding: 20px;
	 }
	 .timeBox{
	 	font-size:12px;
	 	text-align: right;
    	margin: 0px 30px;
	 }
</style>
<script src="${path}/a00_com/jquery.min.js"></script>
<script src="${path}/a00_com/popper.min.js"></script>
<script src="${path}/a00_com/bootstrap.min.js"></script>
<script src="${path}/a00_com/jquery-ui.js"></script>

<script>
var wsocket;
conn();
var currentTime = function(){
    var date = new Date();
    var hh = date.getHours();
    var mm = date.getMinutes();
    var ss = date.getSeconds();
    var apm = hh >12 ? "오후":"오전";
    if(hh<10){
        hh = "0"+hh;
    }
    if(mm<10){
        mm = "0"+mm;
    }
    if(ss<10){
        ss = "0"+ss;
    }
    var ct = apm + " "+hh+":"+mm+":"+ss;
    return ct;
}
$(document).ready(function(){
	// 1. 웹 소켓 클라이언트를 통해 웹 서버 연결하기.
	$("#id").keyup(function(){
		if(event.keyCode==13){
			conn();
		}
	})
	$("#msg").keyup(function(){
		if(event.keyCode==13) sendMsg();
	});
	$("#sendBtn").click(function(){
		if($("#msg").val()!=""){
			sendMsg();
		}
	});
	// 접속 종료를 처리했을 시
	$("#exitBtn").click(function(){
		wsocket.send("msg:<div class='infoBox'>[퇴장메시지] "+$("#name").val()+"("+$("#auth").val()+")님이 채팅방을 나갔습니다.</div>");
		wsocket.close();
	});
	// 메시지는 보내는 기능 메서드
	function sendMsg(){
		var id = $("#id").val();
		var name = $("#name").val();
		var auth = $("#auth").val();
		var msg = $("#msg").val();
		// message를 보내는 처리..서버의 handler의  handleTextMessage()와 연동
		wsocket.send("msg:<div class='chatBox'><div class='nameBox'>"+name+"("+auth+")</div><div class='msgBox'>"+msg+"</div><div class='timeBox'>"+currentTime()+"</div></div>");
		$("#msg").val(""); $("#msg").focus();
	}
	
	<%-- 
	
	--%>	
});
function conn(){
	//  원격 접속시에는 고정 ip 할당 받아서 처리..
	// local에서 다른 브라우저로 실행시 처리할 내용..
	// wsocket = new WebSocket("ws:/106.10.16.155:7080/${path}/chat-ws.do");
	wsocket = new WebSocket("ws:/@localhost:7080/${path}/chat-ws.do");
	// handler :afterConnectionEstablished(WebSocketSession session)와 연결
	wsocket.onopen=function(evt){ 
		console.log(evt);
		wsocket.send("msg:<div class='infoBox'>[입장메시지] "+$("#name").val()+"("+$("#auth").val()+")님이 채팅방에 입장했습니다.</div>");
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
			$(".chatArea").scrollTop(mx);
		}
	}
	// handler의 afterConnectionClose와 연동
	wsocket.onclose=function(){
		alert($("#id").val()+'접속 종료합니다.')
		$("#chatMessageArea").text("");
		window.close();
	}
	
}
</script>


</head>
<body>
	<div class="chat_wrap">
	    <div class="header">
	        실시간 채팅 서비스
	        <input type="button" style="align:rignt;" class="btn btn-danger" value="나가기" id="exitBtn"/>
	    </div>
	    <div class="chat">
	    	<input type="hidden" id="id" name="id" value="${member.id}"/>
	    	<input type="hidden" id="name" name="name" value="${member.name}"/>
	    	<input type="hidden" id="auth" name="auth" value="${member.auth}"/>
	        <div class="chatArea">
				<div id="chatMessageArea"></div>
			</div>
	    </div>
	    <div class="input-div">
	        <textarea id="msg" placeholder="메시지를 입력해주세요."></textarea>
	        <input type="button" class="btn btn-primary" style="background: #25396f;border:none; width:100px;" value="전송" id="sendBtn"/>	
	    </div>
	</div>


</body>
</html>