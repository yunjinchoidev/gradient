
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />


<!DOCTYPE html>
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
						 <form action="${path}/uptevallist.do" method="post">
							<div class="card-body">
								<!-- 품질 평가 항목 -->
								<c:forEach var="eval" items="${evallist}">
									<c:set var="i" value="${i+1}" />
									<div class="input-group mb-3">
										<span class="input-group-text" id="basic-addon${i}">${eval.evalkey}</span>
										<input type="hidden" name="list[${i-1}].evalkey" value="${eval.evalkey}">
										<input type="text" class="form-control" name="list[${i-1}].evalcontent" aria-describedby="basic-addon${i}"
											value="${eval.evalcontent}">
									</div>
								</c:forEach>
							 
								<div style="float: right; margin-top: 20px; margin-bottom: 20px;">
									<button type="button" class="btn btn-primary" id="backbtn">뒤로가기</button>
									<button type="button" class="btn btn-primary" id="uptbtn">수정</button>
								</div>
							</div>
						  </form>
						</div>
					</div>
				</div>
			</div>
		</section>
	</div>


</body>

<script>
	$(document).ready(function(){
		
		var msg = "${msg}";
		
		if(msg!=""){
			alert(msg);
			location.href="${path}/qualityList.do";
		}
		
		$("#uptbtn").click(function(){
			$('form').submit();
		});
		
		$("#backbtn").click(function(){
			location.href="${path}/qualityList.do";
		});
		
		
		
	});
	
</script>

</html>