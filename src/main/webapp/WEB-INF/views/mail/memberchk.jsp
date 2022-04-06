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
	text-align: center;
	background-color: #cfffdf;
	color: black;
	font-weight: bolder;
}

.input-group-prepend {
	width: 20%;
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
	$(document)
			.ready(
					function() {
						var list = "${list}";
						var email = "${list.email }";
						var results = "${results }";
						var psc = "${psc }";
						console.log("${list }");
						console.log(list)
						console.log(list.length)
						console.log(results)

						if (psc == "success") {
							alert("단체 메일을 발송 하였습니다!")
						}

									$("#sendMailBtn").click(function(e) {
											confirm("메일을 발송하시겠습니까?")
											var title = $("input[name=title]").val()
											var content = $("input[name=content]").val()
											var sender = $("input[name=sender]").val()
											var array = new Array();
											
											<c:forEach var="email" items="${results }">
											array.push("${email}");
											</c:forEach>

											location.href = "/project5/mailsend3.do?arrayParam="+ array	+ "&title="
											+ title+ "&content="+ content	+ "&sender=" + sender;
												
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
					<h3 class="card-title" id="emailCompose">새 이메일</h3>
					<button type="button" class="close close-icon">
						<i class="bx bx-x"></i>
					</button>
				</div>
					<div class="card-content">
						<div class="card-body pt-0">
							<br>
							<div class="form-group pb-50">
								<label for="emailfrom">발신자</label> <input type="text"
									id="emailfrom" class="form-control" name="sender" value="qmwmemrmaa@gmail.com" 
									placeholder="user@example.com" readonly>
							</div>
							<br>
							<div class="form-label-group">
								<label for="emailTo">수신자</label> 
								<c:forEach var="email" items="${results }">
								<input type="email" name="reciever"
									id="emailTo" class="form-control" placeholder="To"  style="color: red"
										value="${email }" 
									>
									</c:forEach>
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
									placeholder="content" rows="4"  ></textarea>
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
							<i class="bx bx-send me-3"></i> <span class="d-sm-inline d-none">보내기</span>
						</button>
						<button type="reset"
							class="btn btn-light-secondary cancel-btn mr-1">
							<i class="bx bx-x me-3"></i> <span class="d-sm-inline d-none">취소</span>
						</button>
					</div>
					
				
				<!-- form start end-->
			</div>
		</div>
	</div>
</body>
</html>