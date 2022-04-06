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
	<title>회의록 | 작성</title>
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<style>
		.dtl-button-box{display:flex;justify-content: space-between;}
		textarea{
			resize:none;
		}
	</style>
	<script>
		$(document).ready(function(){
			var msg = "${msg}";
			if (msg != "") {
				if (confirm(msg + "\n회의록 리스트로 이동할까요?")) {
					location.href = "${path}/contract.do?method=list";
				}
			}
			
			$("#goList").click(function(){
				location.href="${path}/contract.do?method=list";
			});
			

			$("#regBtn").click(function() {
				var hasSession="${member.id}";
				if(hasSession!=""){
					if (confirm("등록하시겠습니까?")) {
						$("form").attr("action", "${path}/contract.do?method=insert");
						$("form").submit();
					}
				}else{
					alert("세션이 만료되었습니다. 로그인 후 다시 이용해주세요.");
				}
			});
	    });
	</script>
	<style>
		input[type=text]{
			border:none;
		}
	</style>
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
	                        <h4 class="card-title" align="center">근로 계약서 작성</h4>
	                        <input type="hidden" name="id" value="${member.id}">
	                    </div>
	                    <table class="table mb-0 table-lg">
	                        <tr>
	                        	<td>
	                        		<input type="text"/>(이하 “사업주”라 함)과(와) <input type="text"/>(이하 “근로자”라 함)은 다음과 같이 근로계약을 체결한다.
	                        	</td>
	                        </tr>
	                        <tr>
	                        	<td>
	                        		1. 근로계약기간 :<input type="date"/>부터 <input type="date"/>까지<br>
  									※ 근로계약기간을 정하지 않는 경우에는 “근로개시일”만 기재
	                        	</td>
	                        </tr>
	                        <tr>
	                        	<td>
	                        		2. 근 무 장 소 : <input type="text"/>
	                        	</td>
	                        </tr>
	                        <tr>
	                            <td>
	                        		3. 업무의 내용 : 
	                        			<textarea></textarea>
	                        	</td>
	                        </tr>
	                        <tr>
	                        	<td>
	                        		4. 소정근로시간 :     <input type="text" placeholder="   시   분"/>부터   <input type="text" placeholder="   시   분"/>까지
	                        	</td>
	                        </tr>
	                        <tr>
	                            <td>
	                        		5. 근무일/휴일 : 매주 <input type="text"/>일(또는 매일단위)근무, 주휴일 매주 요일
	                        	</td>
	                        </tr>
	                        <tr>
	                            <td>
	                        		6. 임 금<br>
									  - 
									  <select>
									  	<option>월</option>
									  	<option>일</option>
									  	<option>시간</option>
									  </select>급 : ________________ 원<br>
									  - 상여금 : ________________ 원<br>
									  - 임금지급일 : 
									  <select>
									  	<option>매월</option>
									  	<option>매주</option>
									  	<option>매일</option>
									  </select><input type="text"/>일(휴일의 경우는 전일 지급)
	                        	</td>
	                        </tr>
	                        <tr>
	                            <td>
	                        	
	                        	</td>
	                        </tr>
	                        <tr>
	                            <td>
	                        	
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
					<input type="button" id="regBtn" class="btn btn-success" value="작성완료"/>
				</div>
			</div>
			
			
			
		</div>

	</div>
</body>
</html>