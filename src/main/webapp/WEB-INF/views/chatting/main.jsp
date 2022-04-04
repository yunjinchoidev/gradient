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
<title>Gradient 채팅 서비스</title>


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
		var memName ="${member.name}"
		var myMemberkey ="${member.memberkey}"
		$.ajax({
			url :'/project5/chattingMListbyRoomkey.do',
			type:'POST',
			data : data,
			dataType:'json',
			success:function(result){
					console.log("success")
					if(result.MessageListbyRoomkey[0]==null){
						alert("채팅 메시지가 없네요")
					}else{
						$("#chatMessageArea").text("");
						alert("채팅을 출력합니다.")
					console.log(result.MessageListbyRoomkey.legth)
					for(var i=0; i<result.MessageListbyRoomkey.length; i++){
						if(result.MessageListbyRoomkey[i].memberkey==myMemberkey){
								var str = "";
								str += "<div class='media w-50 ml-auto mb-3'>"
								str += "<div class='media-body'>"
								str += " <div class='bg-primary rounded py-2 px-3 mb-2'>"
								str += "<p class='text-small mb-0 text-white'>"+result.MessageListbyRoomkey[i].contents+"</p></div>"
								str += " <p class='small text-muted'>"+today.toLocaleDateString()+"["+memName+"]"+"<br>"+today.toLocaleTimeString() +"</p>"
								str += "	</div></div>"
								console.log(str);
								wsocket.send("msg:" + str);
						}else{
							// 상대방이 보낸 메시지
							var str2 = "";
							str2 += 	"<div class='media w-50 mb-3'><img src='https://bootstrapious.com/i/snippets/sn-chat/avatar.svg' alt='user' width='50' class='rounded-circle'>"
							str2 += "      <div class='media-body ml-3'>"
							str2 +=  "       <div class='bg-light rounded py-2 px-3 mb-2'>"
							str2 +=   "        <p class='text-small mb-0 text-muted'>"+result.MessageListbyRoomkey[i].contents+"</p></div>"
						    str2 +="         <p class='small text-muted'>"+result.MessageListbyRoomkey[i].writedateS+"[ 작성자 :"+result.MessageListbyRoomkey[i].memberkey+"]"+"</p></div></div>"
							console.log(str);
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
			$("#newChatBtn").click(function(){
			confirm("1:1 대화를 하시겠습니까?")
			location.href="/project5/invitationList.do?memberkey="+memberkey
			})
			
			$("#newGroupChatBtn").click(function(){
			confirm("그룹 대화를 하시겠습니까?")
			location.href="/project5/invitationList.do?memberkey="+memberkey
			})
		
		
		
							// 화면 로딩 되자 마자 상담 목록을 모조리 불러온다
							$.ajax({
								url : '/project5/chattingRoomList.do',
								type:'POST',
								dataType:'json',
								success:function(result){
									console.log("chattingRoomList=========================");
									console.log(result);
									console.log(result.chatRoomList)
									
									var consultChatList = $("#chattingRoomList");
									for(var i=0; i<result.chatRoomList.length; i++){
											var str="";
											str +=" <a class='list-group-item list-group-item-action active text-white rounded-0' onclick='MessageListFunc(this)' style='cursor:pointer;'>"+"["+result.chatRoomList[i].roomkey +"]번방 &nbsp : "
											str +="   <div class='media'><img src='https://bootstrapious.com/i/snippets/sn-chat/avatar.svg' alt='user' width='50' class='rounded-circle'>"
											str +="    <div class='media-body ml-4'>"
											str +="        <div class='d-flex align-items-center justify-content-between mb-1'>"
							                str +="         <h6 class='mb-0' style='color:white'> 방 이름 : <br>"+result.chatRoomList[i].name+"</h6><small class='small font-weight-bold'>"+result.chatRoomList[i].makedateS+"</small> </div>"
						                	str +="         <p class='font-italic mb-0 text-small'></p></div></div></a>"
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

		
					
								
					
					
					

						//////////////////////////////////////////////////////////////////////////////

						// 연결
						$("#enterBtn").click(function() {
							conn();
						});


						// 접속 종료를 처리했을 시
							$("#exitBtn").click(function() {
								wsocket.close();
							});
						
							$("#exitBtn2").click(function() {
								sendMsgEnd();
							});
						
							
							$("#groupChatRoom").click(function(){
								confirm("단체 톡을 시작하겠습니까?")
							})

						
						
						//////////////////////////////////////////////////////////////////////////////
						// 엔터로 메시지 보내기
						$("#msg").keyup(function() {
							var roomkey2;
							roomkey2 = currentRoomkey;
							if (event.keyCode == 13) {
								var contents = $("#msg").val();
								var memberkey = "${member.memberkey}"
								var data = {contents : contents,
													memberkey : memberkey,
													roomkey : 1
									};
								$.ajax({
									url:'/project5/chattingCreateMessage.do',
									method:'POST',
									data : data,
									dataType:'json',
									success:function(result){
										console.log("대화 DB에 넣기 완료")
										sendMsg();
									},
									error:function(result){
										console.log("대화 DB에 넣기 실패")
										alert("대화 전송에 실패했습니다.")
									}
								})
							
							}
						});
						
						// 전송 버튼을 눌렀을 때
						$("#sendBtn").click(function() {
							var contents = $("#msg").val();
							var memberkey = parseInt("${member.memberkey}");
							var data = {contents : contents,
												memberkey : memberkey,
												roomkey : 1
								};
							$.ajax({
								url:'/project5/chattingCreateMessage.do',
								method:'POST',
								data : data,
								success:function(result){
									console.log("대화 DB에 넣기 완료")
									sendMsg();
								},
								error:function(result){
									console.log("대화 DB에 넣기 실패")
									alert("대화 전송에 실패했습니다.")
								}
							})
							
						});

						
							
							
							
						// 화면에 메시지 출력
						function sendMsg() {
							var id = "${member.name}"
							var msg = $("#msg").val();
							var str = "";
							str += "<div class='media w-50 ml-auto mb-3'>"
							str += "<div class='media-body'>"
							str += " <div class='bg-primary rounded py-2 px-3 mb-2'>"
							str += "<p class='text-small mb-0 text-white'>"+msg+"</p></div>"
							str += " <p class='small text-muted'>"+today.toLocaleDateString()+"["+id+"]"+"<br>"+today.toLocaleTimeString() +"</p>"
							str += "	</div></div>"
						
							//console.log("메시지 보내기 :::::::::::::::" + str);
							wsocket.send("msg:" + str);
							$("#msg").val("");
							$("#msg").focus();
						}
						
							
							// 채팅 종료시 출력할 정보
							function sendMsgEnd() {
								var id = "${member.name}"
								var str = "";
								str += "<div class='media w-50 ml-auto mb-3'>"
								str += "<div class='media-body'>"
								str += " <div class='bg-primary rounded py-2 px-3 mb-2'>"
								str += "<p class='text-small mb-0 text-white'>채팅을 종료합니다.</p></div>"
								str += " <p class='small text-muted'>"+today.toLocaleDateString()+"["+id+"]"+"<br>"+today.toLocaleTimeString() +"</p>"
								str += "	</div></div>"
								wsocket.send("msg:" + str);
								
								$("#msg").val("");
								$("#msg").focus();
							}
							
							
							
							
							// 이미지 보내기
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
		
		wsocket = new WebSocket("ws:/@106.10.16.155:7080/${path}/chat-ws.do");
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
    <p class="text-white lead mb-0" style="font-weight: bolder;">더 자유롭게, 더 빠르게, 더 정확하게</p>
    <h1 class="display-4 text-white" style="font-weight: bolder;">Gradient 채팅 서비스</h1>
    <hr>
	    <a href="#" class="btn btn-primary"  id="enterBtn">채팅 ON</a>
	    <a href="#" class="btn btn-danger"   id="exitBtn">채팅 OFF</a>
	    <a href="#" class="btn btn-primary"   id="exitBtn2">방 나가기</a>
	    <a href="#" class="btn btn-success" id="newChatBtn" >1:1 대화</a>
	    <a href="#" class="btn btn-warning" id="newGroupChatBtn">단체 대화</a>
	    <a href="#" class="btn btn-dark" id="voteBtn">투표</a>
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
        <!--  채팅 방 목록 가져오는 곳 -->
          <div class="list-group rounded-0" id="chattingRoomList">
          </div>
        </div>
      </div>
    </div>
    
    
    
    
    
    
    <!--  채팅 공간 -->
    <div class="col-7 px-0"  id="chatArea"> 
      <div class="px-4 py-5 chat-box bg-white" id="chatMessageArea">

        <!-- Message-->



        <!--  Message-->


      </div>

      <!-- Typing area -->
      <form action="#" class="bg-light">
        <div class="input-group">
          <input type="text" placeholder="Type a message" aria-describedby="button-addon2"
           class="form-control rounded-0 border-0 py-4 bg-light" id="msg" >
          <div class="input-group-append">
          <!--  전송 버튼 -->
            <button  type="button" class="btn btn-link"  id="sendBtn">
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