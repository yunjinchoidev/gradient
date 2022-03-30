<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />

<!DOCTYPE html>
<html class="no-js">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="/project5/resources/dist/assets/css/bootstrap.css">
    <link rel="stylesheet" href="/project5/resources/dist/assets/css/widgets/chat.css">
    <link rel="stylesheet" href="/project5/resources/dist/assets/vendors/perfect-scrollbar/perfect-scrollbar.css">
    <link rel="stylesheet" href="/project5/resources/dist/assets/vendors/bootstrap-icons/bootstrap-icons.css">
    <link rel="stylesheet" href="/project5/resources/dist/assets/css/app.css">
    <link rel="shortcut icon" href="/project5/resources/dist/assets/images/favicon.svg" type="image/x-icon">
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<script>
var wsocket;

$(document).ready(function(){
	
	
			/*메시지 전송*/
			$("#msg").keyup(function(){
				if(event.keyCode==13) {
					var msg = $("#msg").val();
					console.log(msg);
					
					var data = {inputdata : msg}
					$.ajax({
						url : '/project5/getbyInputData.do',
						method : 'POST',
						async : false,
						data : data,
						dataType : 'json',
						success : function(result) {
							console.log(result)
							if(result.answer == null){
								sendMsgChatBot("올바르지 않은 명령어입니다. 명령어를 다시 입력해주세요");
								sendMsgChatBotReply();
							}else{
								sendMsgChatBot(result.answer.contents)
							}
						}
					})
				}
					
			});
	
			// 버튼을 직접 클릭 했을 때
			$("#sendBtn").click(function(){
				sendMsg();
				
				var msg = $("#msg").val();
				var data = {inputdata : msg}
				$.ajax({
					url : '/project5/getbyInputData.do',
					method : 'POST',
					async : false,
					data : data,
					dataType : 'json',
					success : function(result) {
						console.log(result)
						if(result.answer == null){
							sendMsgChatBot("올바르지 않은 명령어입니다. 명령어를 다시 입력해주세요");
							sendMsgChatBotReply();
						}else{
							sendMsgChatBot(result.answer.contents)
						}
					}
				})
			});
	
			// 종료 버튼 클릭 시
			$("#exitBtn").click(function(){
				wsocket.send("msg:접속 종료 했습니다!");
				wsocket.close();
			});
			

	
	
			// 사람이 메시지 보내기
			function sendMsg(){
				var msg = $("#msg").val();
				var str = "";
				str +="<div class='chat'>"
					str +="<div class='chat-body'>"
					str +="<div class='chat-message'>"+msg+"</div>"
					str +="</div></div>"
				wsocket.send("msg:"+str);
				$("#msg").val(""); 
				$("#msg").focus();
			}
			
			
		});




		
		// 챗봇이 보내는 메시지
		function sendMsgChatBot(data){
			var str = "";
			str +="<div class='chat chat-left'>"
				str +="<div class='chat-body'>"
				str +="<div class='chat-message'>"+data+"</div>"
				str +="</div></div>"
			wsocket.send("msg:"+str);
			$("#msg").val(""); 
			$("#msg").focus();
		}

		
		
		



		// 맨 처음 실행되는 메시지
		function sendMsgInit(){
			var str = "";
			var str2 = "";
			var str3 = "";
			str +="<div class='chat chat-left'>"
			str +="<div class='chat-body'>"
			str +="<div class='chat-message'>챗봇을 연결합니다.</div>"
			str +="</div></div>"
			str2 += "<div class='chat chat-left' style='color:red'>"
			str2 += "<div class='chat-body' style='color:red'>"
			str2 += "<div class='chat-message'>환영합니다. <br> 무엇을 도와드릴까요? <br>사용 가능한 명령어가 있습니다.<br><br> 1. 그래디언트가 뭐야 <br>2. 그래디언트 사용법<br>3. 가입 방법<br>4. 회원 탈퇴<br>5. 파일 첨부법 <br><br><br><br> 하단 버튼을 눌러보세요</div> "
			str2 += "<div class='chat-message' style='color:red'><a href='#' class='btn btn-danger chatAuto' onclick='fnc(this); return false;' >그래디언트</a>"
			str2 += "<a href='#' class='btn btn-danger chatAuto' onclick='fnc(this); return false;'>회원탈퇴</a>"
			str2 += "<a href='#' class='btn btn-danger chatAuto' id='g' onclick='fnc(this); return false;'>파일첨부</a></div> "
			str2 += "</div> </div>"
			wsocket.send("msg:" + str);
			wsocket.send("msg:" + str2);
			$("#msg").val("");
			$("#msg").focus();
		}

	
	
		function sendMsgChatBotReply(){
			var str2 = "";
			str2 += "<div class='chat chat-left' style='color:red'>"
			str2 += " <div class='chat-body' style='color:red'>"
			str2 += "<div class='chat-message'>더 도움이 필요하세요 ? <br>사용 가능한 명령어가 있습니다.<br><br> 1. 그래디언트가 뭐야 <br>2. 그래디언트 사용법<br>3. 가입 방법<br>4. 회원 탈퇴<br>5. 파일 첨부법 <br><br><br><br> 하단 버튼을 눌러보세요</div> "
			str2 += "<div class='chat-message' style='color:red'><a href='#' class='btn btn-danger chatAuto' onclick='fnc(this); return false;' >그래디언트</a>"
			str2 += "<a href='#' class='btn btn-danger chatAuto' onclick='fnc(this); return false;'>회원탈퇴</a>"
			str2 += "<a href='#' class='btn btn-danger chatAuto' id='g' onclick='fnc(this); return false;'>파일첨부</a></div> "
			str2 += "</div> </div>"
			wsocket.send("msg:" + str2);
			$("#msg").val("");
			$("#msg").focus();
		}
	
	
	
	
	
	
		// 도우미 버튼을 클릭 했을 때
		var fnc = function(what) {
			var inputdata = $(what).text();
			var data = {
				inputdata : inputdata
			}
			console.log(data);
			$.ajax({
				url : '/project5/getbyInputData.do',
				method : 'POST',
				async : false,
				data : data,
				dataType : 'json',
				success : function(result) {
					console.log(result)
					console.log(result.answer.contents)
					sendMsgChatBot(result.answer.contents)
					//준비된 재응답 메시지
					sendMsgChatBotReply();
				}
			})
		}

	
	
		
		
		
		
		
	
		// 연결
		function conn() {
//			wsocket = new WebSocket("ws:/106.10.16.155:7080/${path}/chat-ws.do");
			wsocket = new WebSocket("ws:/@localhost.155:7080/${path}/chat-ws.do");
			wsocket.onopen = function(evt) {
				console.log(evt);
				sendMsgInit();
			}
			wsocket.onmessage = function(evt) {
				var msg = evt.data;
				if (msg.substring(0, 4) == "msg:") {
					var revMsg = msg.substring(4)
					$("#chatMessageArea").append(revMsg + "<br>");
					var mx = parseInt($("#chatMessageArea").height())
					$("#chatArea").scrollTop(mx);
				}
			}
			
			wsocket.onclose = function() {
				alert("접속 종료합니다.")
				$("#chatMessageArea").text("");
				$("#id").val("");
				$("#id").focus();
			}
		}
</script>














<script>
	$(document).ready(function() {
		$('html').removeClass('no-js');
		
		$("#layer").hide();
		
		$("#chatBot").click(function() {
			toggle_layer();
		})
		
		function toggle_layer() {
			if($("#layer").css("display") == "none"){
				$("#layer").show();
				conn();
			}else{
				$("#layer").hide();
				wsocket.send("msg:"+$("#id").val()+":접속 종료 했습니다!");
				wsocket.close();
			}
		}
		
	})
</script>



<style>

.no-js{
	display:none;
}
#chatBot {
	position: fixed;
	top: 800px;
	right: 5px;
	z-index: 99
}

#layer{
	position: fixed;
	top: 230px;
	right:100px;
	z-index: 98;
}


</style>
</head>


<body>
	<!-- 챗봇 이미지 -->
	<img src="/project5/resources/robot.png"
		style="width: 100px; height: 100px; cursor: pointer;"
		id="chatBot">
		
                            <div class="card" id="layer" style="height: 670px; width: 500px; overflow: auto">
                                <div class="card-header">
                                    <div class="media d-flex align-items-center">
                                        <div class="avatar me-3">
                                            <img src="/project5/resources/robot.png" alt="" srcset="">
                                            <span class="avatar-status bg-success"></span>
                                        </div>
                                        <div class="name flex-grow-1">
                                            <h6 class="mb-0">그래DO</h6>
                                            <span class="text-xs">챗봇</span>
                                        </div>
                                        <input type="button" class="btn btn-danger" value="종료" id="exitBtn" />
                                    </div>
                                </div>
                                
                                <div class="card-body pt-4 bg-grey"  id="chatArea">
                                    <div class="chat-content" id="chatMessageArea">
                                    </div>
                                </div>
                                
                                
                                <div class="card-footer">
                                    <div class="message-form d-flex flex-direction-column align-items-center">
                                        <a href="http://" class="black"><i data-feather="smile"></i></a>
                                        <div class="d-flex flex-grow-1 ml-4" style="width:100%">
                                            <input type="text" class="form-control" placeholder="Type your message.."  id="msg">
                                            	<input type="button" class="btn btn-info" value="전송" id="sendBtn"/>	
                                        </div>
                                    </div>
                                </div>
                            </div>
		
    					<script src="/project5/resources/dist/assets/js/bootstrap.bundle.min.js"></script>
		
		
</body>
</html>