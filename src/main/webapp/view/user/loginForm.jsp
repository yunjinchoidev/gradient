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
					<h1>
					
					
					
					<c:if test="${param.error == 'true'}">
					<strong>아이디와 암호가 일치하지 않습니다.</strong>
					</c:if>
					
					<form action="<c:url value='/user/login'/>" method="post">
					    <label for="name">사용자ID</label>:
					    <input type="text" name="userid" /> 
					    <br/>
					    
					    <label for="password">암호</label>:
					    <input type="password" name="password" /> 
					    <br/>
					    
					    <input type="submit" value="로그인" />
					</form>					
					
					
					
							<a href="/project5/loginForm.do">/project5/loginForm.do 바로가기</a><br>
					
					
					
					
					
					</h1>
					</div>
					<div class="col-12 col-md-6 order-md-2 order-first">
						<nav aria-label="breadcrumb"
							class="breadcrumb-header float-start float-lg-end"></nav>
					</div>
				</div>
			</div>
			
			
			
			<section class="section">
				<div class="row" >
					<div class="col-12">
						<div class="card">
							<div class="card-header">
								<h1 class="card-title"></h1>
							</div>
							<div class="card-body">
							</div>
						</div>
					</div>
				</div>
			</section>
		</div>
	</div>









</body>
</html>