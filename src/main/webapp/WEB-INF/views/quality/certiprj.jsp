
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />


<!DOCTYPE html>
<%--  
2022-03-29
장훈주
인증서 발급
--%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<body>
<%@ include file="../chatBot/chatBot.jsp"%>
	<%@ include file="../common/header.jsp"%>
	
	<div id="main">
		<section id="multiple-column-form">
			<div class="row match-height">
				<div class="col-12">
					<div class="card">

						<div class="card-header">
							<h4 class="card-title">품질 평가 항목</h4>
						</div>
						    
						<div class="card-content">

							<div class="card-body">
								<!-- 합격 프로젝트 목록 -->
								<form action="${path}/jasper.do">
									<div>
										<select name="prjkeyS" class="form-control">
											<c:forEach var="plist" items="${prjlist}">
												<option style="text-align:center;" value="${plist.prjkey}">${plist.prjname}</option>
											</c:forEach>
										</select>
									</div>
								</form>
								<!-- 버튼 -->
								<div>
									<button id="printbtn" class="btn btn-primary">출력</button>
								</div>
							</div>
	
						</div>
					</div>
				</div>
			</div>
		</section>
	</div>


</body>

<script>
	$(document).ready(function(){
				
		$("#printbtn").click(function(){
			$('form').submit();
		});
		
	});
	
</script>

</html>