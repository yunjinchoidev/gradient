<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>로그인</title>
</head>
<body>


<%@ include file="../chatBot/chatBot.jsp"%>
	<%@ include file="../common/header.jsp"%>

	<div id="main">

		<div class="page-heading">
			<div class="page-title">
				<div class="row">
					<div class="col-12 col-md-6 order-md-1 order-last">
					
					<h1 style="color : red">Security 로그인</h1>
					<h1 style="color : red">admin]]]]] admin/asdf</h1>
					<h1 style="color : red">manager]]]]] manager/qwer</h1>
					<h1 style="color : red">user]]]] himan/7777 로그인</h1>
					<h1>
					
					
					
					<c:if test="${param.error == 'true'}">
						<strong>아이디와 암호가 일치하지 않습니다.</strong>
					</c:if>
					
							<form action="<c:url value='/user/login'/>" method="post">
							    <label for="name">사용자ID</label>:
							    <input type="text" name="userid" /> 
							    <br/>
							    
							    <label for="password">암  &nbsp&nbsp&nbsp&nbsp호</label>:
							    <input type="password" name="password" /> 
							    <br/>
							    
							    <input type="submit" value="로그인" />
							</form>					
					
					
					</h1>
					</div>
					<div class="col-12 col-md-6 order-md-2 order-first">
						<nav aria-label="breadcrumb"
							class="breadcrumb-header float-start float-lg-end"></nav>
					</div>
				</div>
			</div>
			
		</div>
	</div>









</body>
</html>