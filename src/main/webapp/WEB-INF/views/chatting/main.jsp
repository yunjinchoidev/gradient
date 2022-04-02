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


<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.js"></script>
<link rel="stylesheet" href="${path}/a00_com/bootstrap.min.css" >
<link rel="stylesheet" href="${path}/a00_com/jquery-ui.css" >
<style>
	.input-group-text{width:100%;font-weight:bolder;}
	.input-group-prepend{width:20%;}
</style>
<script src="${path}/a00_com/jquery.min.js"></script>
<script src="${path}/a00_com/popper.min.js"></script>
<script src="${path}/a00_com/bootstrap.min.js"></script>
<script src="${path}/a00_com/jquery-ui.js"></script>



<script type="text/javascript">
	var wsocket;
	var theSrc;
	var myFaceData;
	var theSrc;
	var today=new Date(); 
	
	var roomkey;
	var currentRoomkey;
	
	
	function MessageListFunc(data){
		console.log("MessageListFunc");
		console.log(data);
		if (parseInt($(data).text().substr(1,3)) >= 100){
			roomkey = parseInt($(data).text().substr(1,2));
		}else if (parseInt($(data).text().substr(1,2)) >= 10){
			roomkey = parseInt($(data).text().substr(1,2));
		}else if (parseInt($(data).text().substr(1,1)) < 10){
			roomkey = parseInt($(data).text().substr(1,1));
		}
		
			
			currentRoomkey = roomkey
			alert("채팅방번호:"+roomkey)
		var data ={roomkey:roomkey};
		$.ajax({
			url :'/project5/MessageListbyRoomkey.do',
			type:'POST',
			data : data,
			dataType:'json',
			success:function(result){
					console.log("success")
					if(result.MessageListbyRoomkey[0]==null){
						alert("채팅 메시지가 없네요")
					}else{
					console.log(result.MessageListbyRoomkey.legth)
					for(var i=0; i<result.MessageListbyRoomkey.length; i++){
						if(result.MessageListbyRoomkey[i].memberkey==2){
							var str = "";
							str += "<div class='chat-message-right pb-4' onclick='likeCntFun(this)'>"
							str += "<div>"
							str += "<img src='#' class='rounded-circle mr-1 myFace' alt='Chris Wood' width='40' height='40' id='likecntBtn2'>"
							str += "<div class='text-muted small text-nowrap mt-2'><p style='color:red;'>["+result.MessageListbyRoomkey[i].messagekey+"]좋아요 :"+result.MessageListbyRoomkey[i].likecnt+" </p>"+today.toLocaleDateString()+"<br>"+today.toLocaleTimeString() +"</div>"
							str += "</div>"
							str += "<div class='flex-shrink-1 bg-light rounded py-2 px-3 mr-3'>"
							str += "<div class='font-weight-bold mb-1'>" + $("#id").val()+ "</div>"
							str += result.MessageListbyRoomkey[i].message
							str += "</div>"
							str += "</div>"
							console.log(str);
							wsocket.send("msg:" + str);
	
						}else{
							// 상담원
							var str2 = "";
							str2 += "<div class='chat-message-left pb-4'>"
							str2 += "<div>"
							str2 += "<img src='https://bootdey.com/img/Content/avatar/avatar3.png' class='rounded-circle mr-1' alt='Chris Wood' width='40' height='40'>"
							str2 += "<div class='text-muted small text-nowrap mt-2'>"+today.toLocaleDateString()+"<br>"+today.toLocaleTimeString() +"</div>"
							str2 += "</div>"
							str2 += "<div class='flex-shrink-1 bg-light rounded py-2 px-3 mr-3'>"
							str2 += "<div class='font-weight-bold mb-1'>상담원 A</div>"
							str2 += "<br>안녕하세요?<br><br>" + $("#id").val() + "<br> 무엇을 도와드릴까요?"
							str2 += "</div>"
							str2 += "</div>"
							wsocket.send("msg:" + str2);
									}
							}
						}
								
					}	
			})
		
		
		
		
	}
	
	
	
	
	
	function likeCntFun(data){
		alert("좋아요를 누룹니다")
		console.log("data"+data)
		console.log("data : "+$(data).text())
		var data2 = $(data).text()
		var pos = data2.indexOf(']');
		var pos1 = data2.substring(1,pos)
		console.log(pos1)
		
		var messagekey=pos1;
		var data = {messagekey:messagekey}
		$.ajax({
			url:'/project5/plusLikeCnt.do',
			type:'POST',
			data:data,
			dataType:'json',
			success:function(result){
				alert("좋아요를 눌렀습니다.")
			}
		})
	}

	
	
	
	
	
	$(document).ready(function(){
		// 1:1 대화
	
		
			var memberkey = "${memberk.memberkey}"
			$("#personalChatRoom").click(function(){
			confirm("1:1 대화를 하시겠습니까?")
			location.href="/project5/invitationList.do?memberkey="+memberkey
			})
			
			
			$("#groupChatRoom").click(function(){
			confirm("그룹 대화를 하시겠습니까?")
			location.href="/project5/invitationList.do?memberkey="+memberkey
			})
		
		
		
		// 화면 로딩 되자 마자 상담 목록을 모조리 불러온다
		$.ajax({
			url : '/project5/chatRoomList.do',
			type:'POST',
			dataType:'json',
			success:function(result){
				console.log("chatRoomList=========================");
				console.log(result);
				console.log(result.chatRoomList)
				
				var consultChatList = $("#consultChatList");
				for(var i=0; i<result.chatRoomList.length; i++){
					var str="";
					str +="<a href='#' class='list-group-item list-group-item-action border-0 consult' onclick='MessageListFunc(this)' >"
					str +="["+result.chatRoomList[i].roomkey +"]번방 &nbsp : "+result.chatRoomList[i].createDateS+"일 생성<div class='badge bg-success float-right consult'></div>"
					str +="<div class='badge bg-success float-right consult'></div>"
					str +="<div class='d-flex align-items-start consult'>"
					str +="<img src='https://bootdey.com/img/Content/avatar/avatar3.png' class='rounded-circle mr-1 consult' alt='Vanessa Tucker' width='40' height='40'>"
					str +="<div class='flex-grow-1 ml-3 consult'> 방 명 : "+result.chatRoomList[i].name
					str +="<div class='small'><span class='fas fa-circle chat-online consult'></span> </div>"
					str +="</div></div></a>"
					consultChatList.append(str);
				}
			}
		})
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
						// 얼굴을 바꾸기 위해서
						playAlert = setInterval(function() {
							//console.log("10초마다 반복")
							theSrc(myFaceData.fname)
						}, 100);

						console.log(today.toLocaleString());
		
							var theSrc =  function showImg2(fname){
							    var uploadUL = $(".myFace");
							    var fileCallPath =  encodeURIComponent(fname);
							    var theSrc = '/project5/display2.do?fileName='+fileCallPath
							    $(".myFace").attr("src",theSrc)
							  }
		
		
		
		
					
								var memberkey = parseInt("${member.memberkey}");
								var data = {memberkey : memberkey}
								$.ajax({
									url : '/project5/myfaceData.do',
									method : 'POST',
									async:false,
									data : data,
									dataType:'json',
									success:function(result){
										console.log(result)
										console.log(result.myfaceData)
										console.log(result.myfaceData[0].fname)
										console.log("myfaceData 불러오기 성공")
										//showImg(result.myfaceData[0].fname)
										myFaceData = result.myfaceData[0];
										theSrc(myFaceData.fname)
									},
									error:function(result){
										console.log("myfaceData 불러오기 실패")
									}
								})
					
									console.log("====================")
					
								  function showImg(fname){
								    var uploadUL = $(".myFace");
								    var fileCallPath =  encodeURIComponent(fname);
								    var theSrc = '/project5/display2.do?fileName='+fileCallPath
								    $(".myFace").attr("src",theSrc)
								  }
								//theSrc(myFaceData.fname)

		
					
								
								
								
								
								
								
								
					
					// 새 상담 만들기
					$("#newConsult").click(function(){
						alert("새 상담을 시작합니다.")
						var consultChatList = $("#consultChatList");
						var str="";
						str +="<a href='#' class='list-group-item list-group-item-action border-0 consult' >"
						str +="<div class='badge bg-success float-right consult'></div>"
						str +="<div class='d-flex align-items-start consult'>"
						str +="<img src='https://bootdey.com/img/Content/avatar/avatar3.png' class='rounded-circle mr-1 consult' alt='Vanessa Tucker' width='40' height='40'>"
						str +="<div class='flex-grow-1 ml-3 consult'>상담사 A "
						str +="<div class='small'><span class='fas fa-circle chat-online consult'></span> </div>"
						str +="</div></div></a>"
						consultChatList.append(str);
						$.ajax({
							url : '/project5/createChat.do',
							success : function(result){
								alert("새 상담이 정상적으로 만들어졌습니다.")
								sendMsgEnd();
							}
						})
						
					})
					
					
					
					// 채팅 로드
					$(".consult").click(function(){
						alert("채팅을 로드합니다.")
						$("#chatMessageArea").text("");
					})
					
					
					$("#eraseBtn").click(function(){
						alert("내용을 모두 지웁니다.")
						$("#chatMessageArea").text("");
					})
					
						
						
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					

						//////////////////////////////////////////////////////////////////////////////

						// 1. 웹 소켓 클라이언트를 통해 웹 서버 연결하기.
						$("#enterBtn").click(function() {
							conn();
						});

						$("#id").keyup(function() {
							if (event.keyCode == 13) {
								conn();
							}
						})

						
						
						
						//////////////////////////////////////////////////////////////////////////////
						// 메시지 보내기
						$("#msg").keyup(function() {
							var roomkey2;
							roomkey2 = currentRoomkey;
							if (event.keyCode == 13) {
								var message = $("#msg").val();
								var memberkey = "${member.memberkey}"
								var data = {message : message,
													memberkey : memberkey,
													roomkey : roomkey2
									};
								$.ajax({
									url:'/project5/createMessage.do',
									method:'POST',
									data : data,
									dataType:'json',
									success:function(result){
										console.log("대화 DB에 넣기 완료")
									},
									error:function(result){
										console.log("대화 DB에 넣기 실패")
									}
								})
								sendMsg();
							}
						});
						
						
						
						
						
						
						
						// 전송 버튼을 눌렀을 때
						$("#sendBtn").click(function() {
							var message = $("#msg").val();
							console.log("message ::::::::::::::::::::: "+ message);
							sendMsg();
							var memberkey = parseInt("${member.memberkey}");
							var data = {message : message,
												memberkey : memberkey,
												roomkey : currentRoomkey
								};
							$.ajax({
								url:'/project5/createMessage.do',
								method:'POST',
								data : data,
								success:function(result){
									console.log("대화 DB에 넣기 완료")
								},
								error:function(result){
									console.log("대화 DB에 넣기 실패")
								}
							})
							
						});

						
						
						
						
							// 접속 종료를 처리했을 시
							$("#exitBtn").click(
								function() {
									wsocket.send("msg:" + $("#id").val()
											+ ":접속 종료 했습니다!");
									sendMsgEnd();
									wsocket.close();
								});
							
							
							$("#groupChatRoom").click(function(){
								confirm("단체 톡을 시작하겠습니까?")
							})

							
							
							
							
							
						////////////////////////////////////////////////////////////////////////
						// 메시지는 보내는 기능 메서드
						function sendMsg() {
							var id = $("#id").val();
							var msg = $("#msg").val();
							// message를 보내는 처리..서버의 handler의  handleTextMessage()와 연동
							//wsocket.send("msg:"+id+":"+msg);
							var str = "";
							str += "<div class='chat-message-right pb-4'>"
							str += "<div>"
							str += "<img src='https://bootdey.com/img/Content/avatar/avatar1.png' class='rounded-circle mr-1 myFace' alt='Chris Wood' width='40' height='40'>"
							str += "<div class='text-muted small text-nowrap mt-2'> <p style='color:red;'>좋아요 : 0</p>"+today.toLocaleDateString()+"<br>"+today.toLocaleTimeString() +"</div>"
							str += "</div>"
							str += "<div class='flex-shrink-1 bg-light rounded py-2 px-3 mr-3'>"
							str += "<div class='font-weight-bold mb-1'>"	+ $("#id").val() + "</div>"
							str += msg
							str += "</div>"
							str += "</div>"
							//console.log("메시지 보내기 :::::::::::::::" + str);
							wsocket.send("msg:" + str);
							$("#msg").val("");
							$("#msg").focus();
							
							
						}
						
						
							
							
							
							
							
						function sendMsgImg(obj) {
							if(obj.image){
								var fileCallPath =  encodeURIComponent( obj.uploadPath+ "/"+obj.uuid +"_"+obj.fileName);
								var go = "/project5/display.do?fileName="+fileCallPath;
								console.log(fileCallPath)
							}else{
								var fileCallPath =  encodeURIComponent( obj.uploadPath+"/"+ obj.uuid +"_"+obj.fileName);			      
							    var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
								var go2 = "<img src='/project5/resources/img/attach.png'>";
							}
							
							
							
							
							
							var id = $("#id").val();
							var msg = $("#msg").val();
							// message를 보내는 처리..서버의 handler의  handleTextMessage()와 연동
							//wsocket.send("msg:"+id+":"+msg);
							var str = "";
							str += "<div class='chat-message-right pb-4'>"
							str += "<div>"
							str += "<img src='https://bootdey.com/img/Content/avatar/avatar1.png' class='rounded-circle mr-1 myFace' alt='Chris Wood' width='40' height='40'>"
							str += "<div class='text-muted small text-nowrap mt-2'>"+today.toLocaleDateString()+"<br>"+today.toLocaleTimeString() +"</div>"
							str += "</div>"
							str += "<div class='flex-shrink-1 bg-light rounded py-2 px-3 mr-3'>"
							str += "<div class='font-weight-bold mb-1'>"	+ $("#id").val() + "</div>"
							str += "이미지를 전송합니다.<br><div style='margin : 0 auto'>"
							str += "<img src='"+go+"' style='width:50px; height:50px;'></div>"
							str += "</div>"
							str += "</div>"
							//console.log("메시지 보내기 :::::::::::::::" + str);
							wsocket.send("msg:" + str);
							$("#msg").val("");
							$("#msg").focus();
						}
						
						
						// 상담 종료
						function sendMsgEnd() {
							var str = "";
							str += "<div class='chat-message-left pb-4'>"
							str += "<div>"
							str += "<img src='https://bootdey.com/img/Content/avatar/avatar3.png' class='rounded-circle mr-1 myFace' alt='Chris Wood' width='40' height='40'>"
							str += "<div class='text-muted small text-nowrap mt-2'>"+today.toLocaleDateString()+"<br>"+today.toLocaleTimeString() +"</div>"
							str += "</div>"
							str += "<div class='flex-shrink-1 bg-light rounded py-2 px-3 mr-3'>"
							str += "<div class='font-weight-bold mb-1'>"+today.toLocaleDateString()+"<br>"+today.toLocaleTimeString() +"</div>상담을 종료합니다"
							str += "<br>================"
							str += "<br>================"
							str += "<br>================"
							str += "<br>================"
							str += "</div>"
							str += "</div>"
							wsocket.send("msg:" + str);
							$("#msg").val("");
							$("#msg").focus();
						}
						
						
						
						
						
						
						  var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
						  var maxSize = 5242880; //5MB
					  
						  function checkExtension(fileName, fileSize){
						    if(fileSize >= maxSize){
						      alert("파일 사이즈 초과");
						      return false;
						    }
						    if(regex.test(fileName)){
						      alert("해당 종류의 파일은 업로드할 수 없습니다.");
						      return false;
						    }
						    return true;
						  }
						
						$("input[type='file']").change(function(e){
							var formData = new FormData();
							var inputFile = $("input[name='fileInfo']");
							var files = inputFile[0].files;
							
							for(var i = 0; i < files.length; i++){
							if(!checkExtension(files[i].name, files[i].size) ){
								return false;
							}
								formData.append("uploadFile", files[i]);
							}
							
										// 화면단에서 바로 볼수 있게 하기 위해서 사용 + 파일저장
										$.ajax({
										url: '/project5/uploadAjaxAction.do',
										processData: false, 
										contentType: false,
										data:formData,
										type: 'POST',
										dataType:'json',
										success: function(result){
											  console.log("result"+result.list); 
											  console.log("result"+result.list[0]); 
											  // 함수 호출
											  showUploadResult(result.list[0]);//함수 호출
											  
										},
										error: function(result){
											  console.log("파일 업로드 실패했습니다.");
											  console.log(result); 
										}
										}); //$.ajax
										
										
										
										
										

								});  




									// 파일 업로드 시 파일 정보 띄우기
									// 이미지 뷰단에 띄어주기 함수  
									function showUploadResult(obj){
											if(obj.image){
												var fileCallPath =  encodeURIComponent( obj.uploadPath+ "/"+obj.uuid +"_"+obj.fileName);
												var go = "/project5/display.do?fileName="+fileCallPath;
												$("#not").attr("src",go)
												console.log(fileCallPath)
												sendMsgImg(obj);
											}else{
												var fileCallPath =  encodeURIComponent( obj.uploadPath+"/"+ obj.uuid +"_"+obj.fileName);			      
											    var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
												var go2 = "<img src='/project5/resources/img/attach.png'>";
												$("#not").attr("src",go2)
											}
											
											
											
											
											
											
											
											
											
											
									}
						
					});

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	function conn() {
		
		wsocket = new WebSocket("ws:/@localhost:7080/${path}/chat-ws.do");
		wsocket.onopen = function(evt) {
			console.log(evt);
			var str = "";
			str += "<div class='media w-50 ml-auto mb-3'>"
			str += "<div class='media-body'>"
			str += " <div class='bg-primary rounded py-2 px-3 mb-2'>"
			str += "<p class='text-small mb-0 text-white'>Test which is a new approach to have all solutions</p></div>"
			str += " <p class='small text-muted'>"+today.toLocaleDateString()+"<br>"+today.toLocaleTimeString() +"</p></div></div>"
			wsocket.send("msg:" + str);
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

		
		// handler의 afterConnectionClose와 연동
		wsocket.onclose = function() {
			alert($("#id").val() + '접속 종료합니다.')
			$("#chatMessageArea").text("");
			$("#id").val("");
			$("#id").focus();
		}

	}
	
	
</script>


<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
</head>

<body>
<%@ include file="../common/header.jsp"%>
	<div id="main" >
	
	<div class="container py-5 px-4">
  <!-- For demo purpose-->
  <header class="text-center">
    <h1 class="display-4 text-white" style="font-weight: bolder;">Gradient 채팅 서비스</h1>
    <p class="text-white lead mb-0" style="font-weight: bolder;">더 자유롭게, 더 빠르게, 더 정확하게</p>
    <hr>
    <a href="#" class="btn btn-primary"  id="enterBtn">채팅입장</a>
    <a href="#" class="btn btn-danger"   id="exitBtn">나가기</a>
    <a href="#" class="btn btn-danger"  >1:1 대화</a>
    <a href="#" class="btn btn-danger" >단체 대화</a>
    <a href="#" class="btn btn-danger"  >냉무</a>
    <a href="#" class="btn btn-danger"  >냉무</a>
    <a href="#" class="btn btn-danger" >냉무</a>
    <a href="#" class="btn btn-danger" >투표</a>
    <p class="text-white lead mb-4">
    </p>
  </header>

  <div class="row rounded-lg overflow-hidden shadow">
    <!-- Users box-->
    <div class="col-5 px-0">
      <div class="bg-white">

        <div class="bg-gray px-4 py-2 bg-light">
          <p class="h5 mb-0 py-1">최근 대화</p>
        </div>

        <div class="messages-box" >
          <div class="list-group rounded-0">
          
          
            <a class="list-group-item list-group-item-action active text-white rounded-0">
              <div class="media"><img src="https://bootstrapious.com/i/snippets/sn-chat/avatar.svg" alt="user" width="50" class="rounded-circle">
                <div class="media-body ml-4">
                  <div class="d-flex align-items-center justify-content-between mb-1">
                    <h6 class="mb-0">Jason Doe</h6><small class="small font-weight-bold">25 Dec</small>
                  </div>
                  <p class="font-italic mb-0 text-small">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore.</p>
                </div>
              </div>
            </a>


          </div>
        </div>
      </div>
    </div>
    
    
    
    
    
    
    <!--  채팅 공간 -->
    <div class="col-7 px-0"  id="chatArea"> 
      <div class="px-4 py-5 chat-box bg-white" id="chatMessageArea">

        <!-- Sender Message-->
        <!--  사대 -->
        <div class="media w-50 mb-3"><img src="https://bootstrapious.com/i/snippets/sn-chat/avatar.svg" alt="user" width="50" class="rounded-circle">
          <div class="media-body ml-3">
            <div class="bg-light rounded py-2 px-3 mb-2">
              <p class="text-small mb-0 text-muted">Test which is a new approach all solutions</p>
            </div>
            <p class="small text-muted">12:00 PM | Aug 13</p>
          </div>
        </div>

        <!-- Reciever Message-->
        <div class="media w-50 ml-auto mb-3">
          <div class="media-body">
            <div class="bg-primary rounded py-2 px-3 mb-2">
              <p class="text-small mb-0 text-white">Test which is a new approach to have all solutions</p>
            </div>
            <p class="small text-muted">12:00 PM | Aug 13</p>
          </div>
        </div>


      </div>

      <!-- Typing area -->
      <form action="#" class="bg-light">
        <div class="input-group">
          <input type="text" placeholder="Type a message" aria-describedby="button-addon2"
           class="form-control rounded-0 border-0 py-4 bg-light" id="msg" >
          <div class="input-group-append">
          <!--  전송 버튼 -->
            <button id="button-addon2" type="button" class="btn btn-link"  id="sendBtn">
             <i class="fa fa-paper-plane"></i></button>
          </div>
        </div>
      </form>
    </div>
    
    
    
    
    
    
    
  </div>
</div>
	
</div>
<script>
// 업로드한 파일 이미지 처리를 위해서
$(document).ready(function(){
	
})
</script>

</body>


















<style>
/*
*
* ==========================================
* FOR DEMO PURPOSES
* ==========================================
*
*/
body {
  background-color: #74EBD5;
  background-image: linear-gradient(90deg, #74EBD5 0%, #9FACE6 100%);

  min-height: 100vh;
}

::-webkit-scrollbar {
  width: 5px;
}

::-webkit-scrollbar-track {
  width: 5px;
  background: #f5f5f5;
}

::-webkit-scrollbar-thumb {
  width: 1em;
  background-color: #ddd;
  outline: 1px solid slategrey;
  border-radius: 1rem;
}

.text-small {
  font-size: 0.9rem;
}

.messages-box,
.chat-box {
  height: 510px;
  overflow-y: scroll;
}

.rounded-lg {
  border-radius: 0.5rem;
}

input::placeholder {
  font-size: 0.9rem;
  color: #999;
}
</style>
</html>