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
<title>캘린더</title>
<script src="/project5/a00_com/jquery.min.js"></script>
<script src="/project5/a00_com/jquery-ui.js"></script>
<script src="/project5/a00_com/popper.min.js"></script>
<script src="/project5/a00_com/bootstrap.min.js"></script>
<script src='/project5/a00_com/lib/main.js'></script>
<link rel="stylesheet" href="/project5/a00_com/jquery-ui.css">
<link rel="stylesheet" href="/project5/a00_com/bootstrap.min.css">
<link href='/project5/a00_com/lib/main.css' rel='stylesheet' />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css"
	rel="stylesheet">
</head>
<body>

	<%@ include file="../common/header.jsp"%>
	<div id="main">
		<%@ include file="fullCalendar2.jsp"%>
	</div>
</body>
</html>