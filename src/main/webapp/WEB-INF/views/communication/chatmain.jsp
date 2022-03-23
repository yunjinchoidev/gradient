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
	.chat_wrap .header { font-size: 14px; padding: 15px 0; background: #25396f;; color: white; text-align: center;  }
</style>
<script src="${path}/a00_com/jquery.min.js"></script>
<script src="${path}/a00_com/popper.min.js"></script>
<script src="${path}/a00_com/bootstrap.min.js"></script>
<script src="${path}/a00_com/jquery-ui.js"></script>

<script>
var wsocket;
$(document).ready(function(){
	// 1. 웹 소켓 클라이언트를 통해 웹 서버 연결하기.
	
	$("#enterBtn").click(function(){
		window.open("${path}/chatroom.do", "채팅", "width=600, height=800");
	});
});

</script>
</head>
<body>

	<%@ include file="../common/header.jsp"%>

	<div class="chat_wrap" style="margin-left: 300px;">
	    <div class="header">
	        CHAT
	    </div>
	    <input type="hidden" id="id" name="id" value="${member.id}"/>
	    <input type="button" class="btn btn-info" value="채팅입장" id="enterBtn"/>	
	</div>

</body>
</html>