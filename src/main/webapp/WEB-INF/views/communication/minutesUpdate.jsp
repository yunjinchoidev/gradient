<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" 
	import="java.util.*"
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<fmt:requestEncoding value="utf-8"/>
<!DOCTYPE html>
<%--


 --%>
<html>
<head>
	<meta charset="UTF-8">
	<title>GRADIENT - 회의록 수정</title>
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<style>
		.dtl-button-box{display:flex;justify-content: space-between;}
		textarea{resize:none;}
	</style>
	<script>
		$(document).ready(function(){
			var msg = "${msg}";
			if (msg != "") {
				if (confirm(msg + "\n회의록 리스트로 이동할까요?")) {
					location.href = "${path}/minutes.do?method=list";
				}
			}
			
			$("[name=topic]").keyup(function(e){
				let content = $(this).val();
				
				$('.topicCount').text(content.length + '자 / 40자'); 
				
				if(content.length > 40){
					$(this).val($(this).val().substring(0,40));
					alert('회의안건은 20자 미만으로 입력해주세요.');
				};			
			});
			
			$("[name=content]").keyup(function(e){
				let content = $(this).val();
			
				$('.contentCount').text(content.length + '자 / 1000자'); 
				
				if(content.length > 1000){
					$(this).val($(this).val().substring(0,1000));
					alert('속기는 1000자 미만으로 입력해주세요.');
				};			
			});
			
			$("[name=shorthand]").keyup(function(e){
				let content = $(this).val();
				
				$('.shCount').text(content.length + '자 / 1000자'); 
				
				
				if(content.length > 1000){
					$(this).val($(this).val().substring(0,1000));
					alert('내용은 1000자 미만으로 입력해주세요.');
				};			
			});
			
			$("#goList").click(function(){
				location.href="${path}/minutes.do?method=list";
			});
			
			$("#uptBtn").click(function() {
				var hasSession="${member.id}";
				if(hasSession!=""){
					if (confirm("수정하시겠습니까?")) {
						if ($("[name=topic]").val() == "") {
							alert("회의안건을 필수로 입력하셔야합니다.");
							$("[name=topic]").focus();
							return;
						}
						if ($("[name=projectKey]").val() == 0){
							alert("프로젝트명을 필수로 선택하셔야합니다.");
							document.getElementsByName("projectKey")[0].focus();
							return;
						}
						if ($("[name=conferenceDateS]").val() == "") {
							alert("회의날짜를 필수로 선택하셔야합니다.");
							$("[name=conferenceDateS]").focus();
							return;
						}
						if ($("[name=deptKey]").val() == 0){
							alert("부서명을 필수로 선택하셔야합니다.");
							document.getElementsByName("deptKey")[0].focus();
							return;
						}
						if ($("[name=content]").val() == "") {
							alert("내용을 필수로 입력하셔야합니다.");
							$("[name=content]").focus();
							return;
						}
						$("form").attr("action", "${path}/minutes.do?method=update");
						$("form").submit();
					}
				}else{
					alert("세션이 만료되었습니다. 로그인 후 다시 이용해주세요.");
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
				<form action="#" method="post">
				<div>
	                <div class="card">
	                    <div class="card-header">
	                        <h4 class="card-title" align="center">게시글 수정</h4>
	                        <input type="hidden" name="minutesKey" value="${m.minutesKey}"/>
	                    </div>
	                    <table class="table mb-0 table-lg">
	                        <tr>
	                            <th>회의안건</th>
	                            <td colspan="3" >
	                            	<input type="text" class="form-control" id="basicInput" name="topic" value="${m.topic}"/>
	                            	<span class="topicCount"></span>
	                            </td>
	                        </tr>
	                        <tr>
	                        	<th>프로젝트명</th>
	                        	<td>
	                            	<select class="form-select" name="projectKey">
	                            		<option>프로젝트를 선택해주세요.</option>
			                    		<c:forEach var="prj" items="${prjList}">
			                    			<option value="${prj.projectKey}" ${prj.projectKey eq m.projectKey ? "selected" : ""}>${prj.pname}</option>
			                    		</c:forEach>
			                    	</select>
	                            </td>
	                        </tr>
	                        <tr>
	                            <th>참석자</th>
	                            <td colspan="3" >
	                            	<input type="text" class="form-control" id="basicInput" name="attendee" value="${m.attendee}"/>
	                            </td>
	                        </tr>
	                        <tr>
	                            <th>회의일자</th>
	                            <td>
	                            	<input type="date" class="form-control" id="basicInput" name="conferenceDateS" 
	                            	value='<fmt:formatDate value="${m.conferenceDate}" pattern="yyyy-MM-dd"/>'/>
	                            </td>
	                            <th>부서명</th>
	                            <td>
	                            	<select class="form-select" name="deptKey">
	                            		<option>부서명을 선택해주세요.</option>
			                    		<c:forEach var="dpt" items="${dptList}">
			                    			<option value="${dpt.deptKey}" ${dpt.deptKey eq m.deptKey ? "selected" : ""}>${dpt.dname}</option>
			                    		</c:forEach>
			                    	</select>
	                            </td>
	                        </tr>
	                        <tr>
	                            <th>회의내용</th>
	                            <td colspan="3">
	                            	<textarea class="form-control" id="exampleFormControlTextarea1" rows="14" name="content">${m.content}</textarea>
	                            	<span class="contentCount"></span>
	                            </td>
	                        </tr>
	                        <tr>
	                            <th>속기</th>
	                            <td colspan="3">
	                            	<textarea class="form-control" id="exampleFormControlTextarea1" rows="8" name="shorthand">${m.shorthand}</textarea>
	                            	<span class="shCount"></span>
	                            </td>
	                        </tr>
                       	</table>
	                </div>
	            </div>
	            </form>
			</section>
			<div class="dtl-button-box">
				<div>
					<input type="button" id="goList" class="btn btn-dark" value="목록으로"/>
				</div>
				<div>
					<input type="button" id="uptBtn" class="btn btn-info" value="수정완료"/>
				</div>
			</div>
			
			
			
		</div>

	</div>
</body>
</html>