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
<title>프로젝트 홈</title>
</head>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<script>
</script>
<style>
#moveBtn a {
	width: 100px;
	margin-right: 10px;
	font-size: 13px;
	font-weight: bold;
}
</style>


<body>



	<!-- 
	<div class="input-group mb-3">
		<label class="input-group-text" for="inputGroupSelect01">프로젝트
			선택</label> <select class="form-select" id="pjList">
			<c:forEach var="pjList" items="${pjList}" varStatus="idx">
				<option seleted value="${idx.index+1 }">${idx.index+1}:
					${pjList.name }</option>
			</c:forEach>
		</select>
	</div>
 -->
		<div class="buttons" id="moveBtn" style="padding: 20px;">
						<a href="/project5/dashBoard.do?projectkey=${project.projectkey }"
							class="btn btn-secondary">대시보드</a> <a
							href="/project5/projectHome.do"
							class="btn btn-dark">프로젝트 홈</a> <a
							href="/project5/kanbanMain.do"
							class="btn btn-danger">칸반보드</a> <a
							href="/project5/ganttMain.do"
							class="btn btn-warning">간트차트</a> <a
							href="/project5/calendar.do"
							class="btn btn-success">캘린더</a> <a
							href="/project5/cost.do"
							class="btn btn-primary">예산 관리</a> <a
							href="/project5/qualityList.do"
							class="btn btn-dark">품질 관리</a> <a
							href="/project5/attendanceMain.do"
							class="btn btn-secondary">팀 관리</a> <a
							href="/project5/teamlist.do"
							class="btn btn-danger">회의록</a> <a
							href="/project5/chatting.do"
							class="btn btn-warning">채팅</a> <a
							href="/project5/output.do"
							class="btn btn-success">산출물 관리</a> <a
							href="/project5/risk.do"
							class="btn btn-primary">리스크 관리</a> <a
							href="/project5/procuSituationMain.do"
							class="btn btn-secondary">조달 관리</a>
					</div>
					<hr>











</body>
</html>