<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.*"
    %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%
      pageContext.setAttribute("crcn", "\r\n");  
      pageContext.setAttribute("br", "<br/>"); 
    
%> 



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
		
		// 메일 성공여부 확인장치
		var msg = "${msg}";
		if(msg!=""){
			alert(msg);
		}
		
		
		$("#sendMailBtn").click(function(e) {
			e.preventDefault()
			confirm("메일을 발송하시겠습니까?")
			$("form").submit()
		})
		
		
		
		
	});
</script>
</head>











<body>
<%@ include file="../chatBot/chatBot.jsp"%>
<%@ include file="../common/header.jsp"%>


  	<div id="main">
		<div class="compose-new-mail-sidebar ps" style="margin: 0 auto; width: 60%">
			<div class="card shadow-none quill-wrapper p-0"  style="margin: 0 auto;">
				<div class="card-header">
					<h1 class="card-title" id="emailCompose" style="color: red">경고장 발송</h1>
					<button type="button" class="close close-icon">
						<i class="bx bx-x"></i>
					</button>
				</div>
				
				
					<form method="post" action="/project5/mailsend.do">
					<div class="card-content">
						<div class="card-body pt-0">
							<br>
							<div class="form-group pb-50">
								<label for="emailfrom">발신자</label> <input type="text"
									id="emailfrom" class="form-control" name="sender" value="qmwmemrmaa@gmail.com" 
									placeholder="발신자 이메일을 입력하세요" readonly>
							</div>
							<br>
							<div class="form-label-group">
								<label for="emailTo">수신자</label> 
								<input type="email" name="reciever"
									id="emailTo" class="form-control" placeholder="To"  style="color: red"
									value="${member.email }"
									>
							</div>
							<br>
							<div class="form-label-group">
								<label for="emailSubject">제목</label> <input type="text"  name="title" 
									id="emailSubject" class="form-control" placeholder="제목"
								>
							</div>
							<br>
							<div class="form-label-group" >
								<label for="emailSubject">내용</label>
								<textarea class="form-control" name="content"
									placeholder="content" rows="4"  >
									 안녕하세요? 
									회원님의 근무 상태가 불량하여 경고장을 발송하오니
									주의해 주시기 바랍니다.

									</textarea>
							</div>


							<div class="form-group mt-2">
								<div class="custom-file">
									<input type="file" class="custom-file-input" id="emailAttach">
									<label class="custom-file-label" for="emailAttach">Attach
										File</label>
								</div>
							</div>

						</div>
					</div>
								<br>


					<div class="card-footer" style="margin-top: 20px;">
						<br>
						<button type="submit" class="btn-send btn btn-danger" id="sendMailBtn">
							 <span class="d-sm-inline d-none">보내기</span>
						</button>
						<button type="reset"
							class="btn btn-light-secondary cancel-btn mr-1">
							<i class="bx bx-x me-3"></i> <span class="d-sm-inline d-none">취소</span>
						</button>
					</div>
						</form>	
				
				<!-- form start end-->
			</div>
		</div>
	</div>  
    
    
    
    
    
    
    
</div>
</body>
</html>