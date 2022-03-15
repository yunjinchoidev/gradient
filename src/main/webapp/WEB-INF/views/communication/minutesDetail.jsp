<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8"/>   
<!DOCTYPE html>
<%--


 --%>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<style>
		.dtl-button-box{display:flex;justify-content: space-between;}
	</style>
	<script>
		$(document).ready(function(){
		    var msg = "${msg}";
			if(msg!=""){
				if(msg=="수정되었습니다."){
					if(confirm(msg+"\n게시판으로 이동하시겠습니까?")){
						location.href="${path}/minutes.do?method=list";
					}	
				}
				if(msg=="삭제되었습니다."){
					alert(msg+"\n게시판으로 이동됩니다.")
					location.href="${path}/minutes.do?method=list";
				}
			}
			
			$("#goList").click(function(){
				location.href="${path}/minutes.do?method=list";
			});
			
			$("#delBtn").click(function(){
				if(confirm("삭제하시겠습니까?")){
					location.href="${path}/minutes.do?method=delete&minutesKey="+${m.minutesKey};
				}
			});
			$("#uptBtn").click(function(){
				if(confirm("수정하시겠습니까?")){
					location.href="${path}/minutes.do?method=updateFrm&minutesKey="+${m.minutesKey};
				}
			});
	    });
	</script>
</head>

<body>
	<%@ include file="../common/header.jsp"%>
	<div id="main">

		<div class="page-heading">
			<div class="page-title">
				<div class="row">
					<div class="col-12 col-md-6 order-md-1 order-last">
						<h3>팀별 회의 공간</h3>
						<p class="text-subtitle text-muted">For user to check they
							list</p>
					</div>
					<div class="col-12 col-md-6 order-md-2 order-first">
						<nav aria-label="breadcrumb"
							class="breadcrumb-header float-start float-lg-end">
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="index.html">Dashboard</a></li>
								<li class="breadcrumb-item active" aria-current="page">DataTable</li>
							</ol>
						</nav>
					</div>
				</div>
			</div>
			<section class="section">
				<div>
	                <div class="card">
	                    <div class="card-header">
	                        <h4 class="card-title" align="center">${m.topic}</h4>
	                        <input type="hidden" name="minutesKey" value="${m.minutesKey}"/>
	                    </div>
	                    <table class="table mb-0 table-lg">
                    		<col width="20%">
						   	<col width="30%">
						   	<col width="20%">
						   	<col width="30%">
	                        <tr>
	                            <th>참석자</th><td colspan="3" >${m.attendee}</td>
	                        </tr>
	                        <tr>
	                            <th>회의일자</th><td><fmt:formatDate value="${m.conferenceDate}"/></td>
	                            <th>작성일자</th><td><fmt:formatDate value="${m.writeDate}"/></td>
	                        </tr>
	                        <tr>
	                            <th>작성자</th><td>${m.name}</td>
	                            <th>부서명</th><td>${m.partname}</td>
	                        </tr>
	                        <tr>
	                            <th>회의내용</th><td colspan="3">${m.content}</td>
	                        </tr>
	                        <tr>
	                            <th>속기</th><td colspan="3">${m.shorthand}</td>
	                        </tr>
                       	</table>
	                </div>
	            </div>
			</section>
			<div class="dtl-button-box">
				<div>
					<input type="button" id="goList" class="btn btn-dark" value="목록으로"/>
				</div>
				<div>
					<input type="button" id="uptBtn" class="btn btn-info" value="수정"/>
					<input type="button" id="delBtn" class="btn btn-danger" value="삭제"/>
				</div>
			</div>
			
			
			
		</div>

	</div>
</body>
</html>