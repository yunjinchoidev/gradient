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
		
		$("#uptbtn").click(function(){
			if(confirm("수정하시겠습니까?")){
				$('form').submit();
			}
					
		});
		
		$("#canclebtn").click(function(){
			location.href="${path}/risk.do";
		});
		
	});

</script>
</head>

<body>
	<%@ include file="../common/header.jsp"%>
	<div id="main">
	 <form action="${path}/uptrisk.do" method="post">
		<!-- 리스크 키 -->
		<input type="hidden" name="riskkey" value="${rdlist.riskkey}">
		<!-- 상세화면 -->
		<div id="mainform">
			<!-- 프로젝트 명 -->
			<select class="form-select" style="text-align:center;" name="prjkey">
                 <c:forEach var="prlist" items="${prjlist}">
                    <option value="${prlist.prjkey}" ${rdlist.prjkey eq prlist.prjkey  ? "selected" : ""}>${prlist.prjname}</option>
                 </c:forEach>
            </select>
			<!-- 중요도, 리스크명, 작성일 -->
			<div id="mainheader" style="margin-top:10px; display:flex;">
				<!-- 중요도 -->
				<div style="flex:1; margin-right: 15px;">
					 <!-- 중요도 select box -->
                    	<div id="importselect" style="flex:1;margin-right:5px;">
                    		<select class="form-select" name="importance" style="text-align:center; font-size: 20px;">
		                    	 <option value="중요" ${rdlist.importance eq "중요" ?  "selected" : ""}>중요</option>
	                             <option value="보통" ${rdlist.importance eq "보통" ?  "selected" : ""}>보통</option>
	                             <option value="낮음" ${rdlist.importance eq "낮음" ?  "selected" : ""}>낮음</option>
                    		</select>
                    	</div>
				</div>
				<!-- 리스크명 -->
				<div style="flex:3;margin-right: 15px;" >
					<input name="title" type="text" class="form-control" value="${rdlist.title}" 
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
				<textarea name="content" class="form-control" rows="15" cols="116"
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
					<select class="form-select" name="progress" style="font-size: 20px;">
	                    <option value="진행중">진행중</option>
	                    <option value="대기">대기</option>
	                    <option value="완료">완료</option>
                    </select>
				</div>
				<!-- 완료예정일 -->
				<div style="flex:1; margin-top: 10px;">
					<h5>완료예정일</h5>
				</div>
				
				<div style="flex:3;">
					<input name="comdate" type="date" class="form-control" value="${rdlist.comdate}"
						style="background-color: white; text-align: center; font-size: 20px;">
				</div>
			</div>
			<!-- 수정, 삭제,돌아가기 버튼 -->
			<div style="margin-top: 30px;align-content:right;float:right;">
				<!-- 수정버튼 -->
					<button class="btn btn-warning" id="uptbtn">수정</button>
				<!-- 돌아가기버튼 -->
					<button class="btn btn-primary" id="canclebtn">취소</button>
			
			</div>
		</div>
	 </form>
	</div>

</body>
</html>