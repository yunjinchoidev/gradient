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
<link rel="stylesheet" href="${path}/a00_com/bootstrap.min.css" >
<link rel="stylesheet" href="${path}/a00_com/jquery-ui.css" >
<style>
	.input-group-text{width:100%;
		text-align:center;background-color:#cfffdf;color:black;font-weight:bolder;}
	.input-group-prepend{width:20%;}
</style>
<script src="${path}/a00_com/jquery.min.js"></script>
<script src="${path}/a00_com/popper.min.js"></script>
<script src="${path}/a00_com/bootstrap.min.js"></script>
<script src="${path}/a00_com/jquery-ui.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://developers.google.com/web/ilt/pwa/working-with-the-fetch-api" type="text/javascript"></script>
<script type="text/javascript">
	$(document).ready(function(){
		
		var msg = "${msg}";
		if(msg!=""){
			alert(msg);
		}
		
		
	});
</script>
</head>











<body>
<%@ include file="../chatBot/chatBot.jsp"%>
<%@ include file="../common/header.jsp"%>



<div id="main">
<div class="jumbotron text-center">
  <h2 data-toggle="modal" data-target="#exampleModalCenter">메일발송</h2>
</div>



<div class="container">
	<form method="post" action="/project5/mailsend.do">
	
	<div class="input-group mb-3">	
		<div class="input-group-prepend ">
			<span class="input-group-text ">수신자</span>
		</div>
		<input name="reciever" class="form-control" placeholder="수신자 입력하세요" values="안녕하세요? 쌍용 5조 PMBOK입니다."/>	
	</div>	
	
	
	<div class="input-group mb-3">	
		<div class="input-group-prepend ">
			<span class="input-group-text"  >발신자</span>
		</div>
		<input name="sender" class="form-control"  reaonly
				 value="qmwmemrmaa@gmail.com"  placeholder="발신자 입력하세요" />	
	</div>	
	
	<div class="input-group mb-3">	
		<div class="input-group-prepend ">
			<span class="input-group-text ">제목</span>
		</div>
		<input name="title" type="text"  placeholder="제목입력하세요" class="form-control" />
	</div>		
	
	<div class="input-group mb-3">	
		<div class="input-group-prepend ">
			<span class="input-group-text ">내용</span>
		</div>
		<textarea cols="10" rows="10" name="content" class="form-control" placeholder="내용입력하세요"></textarea>	
	</div>	
	
	
	<div style="text-align:right;">
		<input type="submit" class="btn btn-success" value="메일발송" id="sendMailBtn"/>
	</div>	
	</form>	
    
    </div>
    
    
    
    
    
    
    
    
</div>
</body>
</html>