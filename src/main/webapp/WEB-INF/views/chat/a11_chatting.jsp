<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />
<!DOCTYPE html>
<%--


 --%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${path}/a00_com/bootstrap.min.css">
<link rel="stylesheet" href="${path}/a00_com/jquery-ui.css">
<style>
.input-group-text {
	width: 100%;
	background-color: linen;
	color: black;
	font-weight: bolder;
}

.input-group-prepend {
	width: 20%;
}

#chatArea {
	width: 80%;
	height: 200px;
	overflow-y: auto;
	text-align: left;
	border: 1px solid green;
}
</style>
<script src="${path}/a00_com/jquery.min.js"></script>
<script src="${path}/a00_com/popper.min.js"></script>
<script src="${path}/a00_com/bootstrap.min.js"></script>
<script src="${path}/a00_com/jquery-ui.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script
	src="https://developers.google.com/web/ilt/pwa/working-with-the-fetch-api"
	type="text/javascript"></script>
<script type="text/javascript">
	$(document).ready(
			function() {

				// 1. 웹 소켓 클라이언트를 통해 웹 서버 연결하기
				var wsoket;
				$("#enterBtn").click(function() {
					alert("접속합니다");
					conn();
				});

				function conn() {
					wsocket = new WebSocket(
							"ws:/106.10.16.155/:7080/${path}/chat-ws.do");
					
					
					wsocket.onopen = function(evt) {
						//============================================================
						console.log(evt);
						wsocket.send("msg:" + $("#id").val() + ":연결 접속했습니다!");
					}
					wsocket.onmessage=function(evt){
						//받은 데이터
						var msg = evt.data;
						
					}
				}
<%-- 
		--%>
	});
</script>
</head>

















<body>
	<div class="jumbotron text-center">
		<h2>채팅처리</h2>
	</div>
	<div class="container">
		<div class="input-group mb-3">
			<div class="input-group-prepend ">
				<span class="input-group-text ">아이디</span>
			</div>
			<input name="id" class="form-control" placeholder="접속할 아이디를 입력하세요" />
			<input type="button" class="btn btn-info" value="채팅입장" id="enterBtn" />
			<input type="button" class="btn btn-success" value="나가기" id="exitBtn" />
		</div>
		<div class="input-group mb-3">
			<div class="input-group-prepend ">
				<span class="input-group-text ">내용</span>
			</div>
			<div id="chatArea" class="input-group-append">
				<div id="chatMessageArea"></div>
			</div>
		</div>
		<div class="input-group mb-3">
			<div class="input-group-prepend ">
				<span class="input-group-text ">메시지</span>
			</div>
			<input name="msg" class="form-control" placeholder="보낼 메시지 입력하세요" />
			<input type="button" class="btn btn-info" value="전송" id="sendBtn" />
		</div>
	</div>
</body>
</html>