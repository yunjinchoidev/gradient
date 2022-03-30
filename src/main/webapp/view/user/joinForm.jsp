<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<title>회원 가입</title>
</head>
<body>

	<form:form method="post" command="newUser">
		<label for="name">사용자이름</label>:
    <form:input path="name" />
		<form:errors path="name" />
		<br />

		<label for="password">암호</label>:
    <form:password path="password" />
		<form:errors path="password" />
		<br />

		<label for="confirm">암호 확인</label>:
    <form:password path="confirm" />
		<form:errors path="confirm" />
		<br />

		<input type="submit" value="가입" />
	</form:form>

</body>
</html>