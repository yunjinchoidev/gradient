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
<style>
#mainform{
	width: 1000px;
	height: 800px;
	margin:0 auto;
}

</style>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<script>
	$(document).ready(function(){
		
		var msg = "${msg}";
		
		if(msg!=""){
			alert(msg);
			location.href="${path}/risk.do";
		}
		
		$("#delbtn").click(function(){
			if(confirm("삭제하시겠습니까?")){
				location.href="${path}/delrisk.do?riskkey="+$("[name=riskkey]").val();
			}
					
		});
			
		$("#uptbtn").click(function(){
			if(confirm("수정하시겠습니까?")){
				location.href="${path}/riskuptdetail.do?riskkey="+$("[name=riskkey]").val();
			}
					
		});
		
		$("#backbtn").click(function(){
			location.href="${path}/risk.do";
		});
		
	});

</script>
</head>

<body>
	<%@ include file="../common/header.jsp"%>
	<div id="main">
		<!-- 리스크 키 -->
		<input type="hidden" name="riskkey" value="${rdlist.riskkey}">
		<!-- 상세화면 -->
		<div id="mainform">
			<!-- 프로젝트 명 -->
			<input type="text" class="form-control" value="${rdlist.prjname}" readonly="readonly" onfocus="this.blur();"
				style="background-color: white; text-align: center; font-size: 20px;">
			<!-- 중요도, 리스크명, 작성일 -->
			<div id="mainheader" style="margin-top:10px; display:flex;">
				<!-- 중요도 -->
				<div style="flex:1; margin-right: 15px;">
					<c:choose>
						<c:when test="${rdlist.importance eq '중요'}">
							<input type="text" class="form-control" value="${rdlist.importance}" readonly="readonly" onfocus="this.blur();"
								style="background-color: #C0392B; text-align: center; color:white; font-size: 20px;">
						</c:when>
						<c:when test="${rdlist.importance eq '보통'}">
							<input type="text" class="form-control" value="${rdlist.importance}" readonly="readonly" onfocus="this.blur();"
								style="background-color: #F2C40F; text-align: center; color:white; font-size: 20px;">
						</c:when>
						<c:when test="${rdlist.importance eq '낮음'}">
							<input type="text" class="form-control" value="${rdlist.importance}" readonly="readonly" onfocus="this.blur();"
								style="background-color: #3498FF; text-align: center; color:white; font-size: 20px;">
						</c:when>
					</c:choose>
				</div>
				<!-- 리스크명 -->
				<div style="flex:3;margin-right: 15px;" >
					<input type="text" class="form-control" value="${rdlist.title}" readonly="readonly" onfocus="this.blur();"
						style="background-color: white; text-align: center; font-size: 20px;">
				</div>
				<!-- 작성일 -->
				<div style="flex:1">
					<input type="text" class="form-control" value="${rdlist.writedates}" readonly="readonly" onfocus="this.blur();"
						style="background-color: white; text-align: center; font-size: 20px;">
				</div>
			</div>
			<!-- 상세내용 -->
			<div style="margin-top: 15px;">
				<textarea class="form-control" rows="15" cols="116" readonly="readonly" onfocus="this.blur();"
					style="background-color: white;">${rdlist.content}</textarea>
			</div>
			<!-- 담당자, 진행사항, 완료예정일 -->
			<div style="display:flex; margin-top: 15px;">
				<!-- 담당자 -->
				<div style="flex:1; margin-right: 15px;">
					<input type="text" class="form-control" value="${rdlist.name}" readonly="readonly" onfocus="this.blur();"
						style="background-color: white; text-align: center; font-size: 20px;">
				</div>
				<!-- 진행사항 -->
				<div style="flex:1; margin-right: 350px;">
					<c:choose>
						<c:when test="${rdlist.progress eq'진행중'}">
							<input type="text" class="form-control" value="${rdlist.progress}" readonly="readonly" onfocus="this.blur();"
								style="background-color: #F2C40F; color:white; text-align: center; font-size: 20px;">
						</c:when>
						<c:when test="${rdlist.progress eq'완료'}">
							<input type="text" class="form-control" value="${rdlist.progress}" readonly="readonly" onfocus="this.blur();"
								style="background-color: #16A085; color:white; text-align: center; font-size: 20px;">
						</c:when>
						<c:when test="${rdlist.progress eq'대기'}">
							<input type="text" class="form-control" value="${rdlist.progress}" readonly="readonly" onfocus="this.blur();"
								style="background-color: #3498FF; color:white; text-align: center; font-size: 20px;">
						</c:when>
					</c:choose>
				</div>
				<!-- 완료예정일 -->
				<div style="flex:1; margin-top: 10px;">
					<h5>완료예정일</h5>
				</div>
				
				<div style="flex:3;">
					<input type="text" class="form-control" value="${rdlist.comdate}" readonly="readonly" onfocus="this.blur();"
						style="background-color: white; text-align: center; font-size: 20px;">
				</div>
			</div>
			<!-- 수정, 삭제,돌아가기 버튼 -->
			<div style="margin-top: 30px;align-content:right;float:right;">
				<!-- 수정버튼 -->
					<button class="btn btn-warning" id="uptbtn">수정</button>
				<!-- 삭제버튼 -->
					<button class="btn btn-danger" id="delbtn">삭제</button>
				<!-- 돌아가기버튼 -->
					<button class="btn btn-primary" id="backbtn">뒤로가기</button>
			
			</div>
		</div>
	</div>

</body>
</html>