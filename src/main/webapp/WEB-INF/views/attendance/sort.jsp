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
</style>


<body>


<div class="buttons" style="margin-bottom: 10px; margin-top: 5px;">
								<a href="#" class="btn btn-dark" id="" onclick="location.href='/project5/attendanceMainComplete.do'">근태 관리 </a> 
								<a href="#" class="btn btn-dark" id="" onclick="location.href='/project5/teamlist.do?projectkey=${project.projectkey}'">프로젝트 할당</a> 
								<a href="#" class="btn btn-dark" id="" onclick="location.href='/project5/vacationMain.do'">휴가 관리</a> 
							</div>









</body>
</html>