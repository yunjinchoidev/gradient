<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
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







<style>
*{ margin: 0; padding: 0; }
 
.chat_wrap .header { font-size: 14px; padding: 15px 0; background: #F18C7E; color: white; text-align: center;  }
 
.chat_wrap .chat { padding-bottom: 80px; }
.chat_wrap .chat ul { width: 100%; list-style: none; }
.chat_wrap .chat ul li { width: 100%; }
.chat_wrap .chat ul li.left { text-align: left; }
.chat_wrap .chat ul li.right { text-align: right; }
 
.chat_wrap .chat ul li > div { font-size: 13px;  }
.chat_wrap .chat ul li > div.sender { margin: 10px 20px 0 20px; font-weight: bold; }
.chat_wrap .chat ul li > div.message { display: inline-block; word-break:break-all; margin: 5px 20px; max-width: 75%; border: 1px solid #888; padding: 10px; border-radius: 5px; background-color: #FCFCFC; color: #555; text-align: left; }
 
.chat_wrap .input-div { position: fixed; bottom: 0; width: 100%; background-color: #FFF; text-align: center; border-top: 1px solid #F18C7E; }
.chat_wrap .input-div > textarea { width: 100%; height: 80px; border: none; padding: 10px; }
.chat_wrap .input-div > textarea:focus {outline:none; background: ivory;}
 
.format { display: none; }


</style>
<script>
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
	// wsocket = new WebSocket("ws:/106.10.16.155:7080/${path}/chat-ws.do");
	// local에서 다른 브라우저로 실행시 처리할 내용..
	wsocket = new WebSocket("ws:/@localhost:7080/${path}/chat-ws.do");
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
	}
	
}
</script>


</head>
<body>

	<%@ include file="../common/header.jsp"%>

	<div class="chat_wrap" style="margin-left: 300px;">
	    <div class="header">
	        CHAT
	    </div>
	    <div class="chat">
	    	<input type="text" id="id" name="id" value="${member.id}"/>
	        <div id="chatArea" class="input-group-append">
				<div id="chatMessageArea"></div>
			</div>
	    </div>
	    <div>
	    	<input type="button" class="btn btn-info" value="채팅입장" id="enterBtn"/>	
			<input type="button" class="btn btn-success" value="나가기" id="exitBtn"/>	
	    </div>
	    <div class="input-div">
	        <textarea id="msg" placeholder="Press Enter for send message."></textarea>
	        <input type="button" class="btn btn-info" value="전송" id="sendBtn"/>	
	    </div>
	    
	</div>


</body>
</html>