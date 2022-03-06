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
<script type="text/javascript">
</script>
</head>

<body>
	<%@ include file="../common/header.jsp"%>
	<div">
		<h2>타이틀</h2>
	</div>
	<div>
		<table>
			<col width="33%">
			<thead>

				<tr>
					<th>부서번호</th>
					<th>부서이름</th>
					<th>부서지역</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="list" items="${list}">
					<tr>
						<td>${list.deptno }</td>
						<td>${list.dname }</td>
						<td>${list.loc }</td>
					</tr>
				</c:forEach>

			</tbody>
		</table>

	</div>
</body>
</html>