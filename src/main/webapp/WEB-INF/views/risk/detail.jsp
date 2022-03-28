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
<style>
#mainform{
	width: 1000px;
	height: 650px;
	margin:0 auto;
}

#commlist{
	background-color: #D4E0FA;
	width: 1000px;
	height: 300px;
	margin:0 auto;
	overflow: auto;
}

#commwrite{
	width: 1000px;
	height: 300px;
	margin:0 auto;
	margin-top:30px;
}

#recommwrite{
	width: 1000px;
	height: 300px;
	margin:0 auto;
	margin-top:30px;
}

</style>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<script>
	$(document).ready(function(){
		
		var msg = "${msg}";
		var commmsg = "${commmsg}";
		var sessid = "${member.id}";
		var id = $("[name=id]").val();
		
		$('#recommwrite').hide();	
		
		// 수정 삭제 메시지
		if(msg!=""){
			alert(msg);
			location.href="${path}/risk.do";
		}
		
		// 댓글 메시지
		if(commmsg!=""){
			alert(commmsg);
			location.href = document.referrer;
		}
		
		/* 세션 없을 시 댓글 작성 영역 hide*/
		if(sessid == ""){
			$('#commwrite').hide();	
		}
		
		/* 작성자가 아닐 시 삭제, 수정*/
		if(sessid != id){
			$('#delbtn').hide();
			$('#uptbtn').hide();
		}
		
		$('#recancleBtn').click(function(){
			if(confirm('답글 작성을 취소하시겠습니까?')){
				$('#recommwrite').hide();
			}
		});
		
		$("#delbtn").click(function(){
			if(confirm("삭제하시겠습니까?")){
				location.href="${path}/delrisk.do?riskkey="+$("[name=riskkey]").val();
			}
					
		});
			
		$("#uptbtn").click(function(){
			if(confirm("수정하시겠습니까?")){
				location.href="${path}/riskuptdetail.do?riskkey="+$("[name=riskkey]").val();
			}
					
		});
		
		$("#backbtn").click(function(){
			location.href="${path}/risk.do";
		});
		
		$("#commregbtn").click(function(){
			if(confirm("댓글을 등록 하시겠습니까?")){
				$('#commform').submit();
			}
		});
		
		$("button[id^='comdelBtn']").click(function(){
			if(confirm('댓글을 삭제하시겠습니까?')){
				location.href="${path}/delriskcomm.do?rcommkey="+$("[name=rcommkey]").val();
			}
		});
		
		$("#recommregbtn").click(function(){
			if(confirm("답글을 등록 하시겠습니까?")){
				$('#recommform').submit();
			}
		});
		
		$("button[id^='recomdelBtn']").click(function(){
			if(confirm('답글을 삭제하시겠습니까?')){
				$("#recommFrm").submit();
			}
		});
		
	});
	
	function recomm(rcommkey){
		if(confirm('답글을 작성하시겠습니까?')){
			$('#recommwrite').show();
			$('[name=recommcontents]').focus();
			$('[name=refno]').val(rcommkey);
			$('[name=recommcontents]').val("RE:"+ rcommkey+" ) ");				
		}
	}

</script>
</head>

<body>
	<%@ include file="../common/header.jsp"%>
	<div id="main">
		<!-- 리스크 키 -->
		<input type="hidden" name="riskkey" value="${rdlist.riskkey}">
		<input type="hidden" name="id" value="${rdlist.id}">
		<!-- 상세화면 -->
		<div id="mainform">
			<!-- 프로젝트 명 -->
			<input type="text" class="form-control" value="${rdlist.prjname}" readonly="readonly" onfocus="this.blur();"
				style="background-color: white; text-align: center; font-size: 20px;">
			<!-- 중요도, 리스크명, 작성일 -->
			<div id="mainheader" style="margin-top:10px; display:flex;">
				<!-- 중요도 -->
				<div style="flex:1; margin-right: 15px;">
					<c:choose>
						<c:when test="${rdlist.importance eq '중요'}">
							<input type="text" class="form-control" value="${rdlist.importance}" readonly="readonly" onfocus="this.blur();"
								style="background-color: #C0392B; text-align: center; color:white; font-size: 20px;">
						</c:when>
						<c:when test="${rdlist.importance eq '보통'}">
							<input type="text" class="form-control" value="${rdlist.importance}" readonly="readonly" onfocus="this.blur();"
								style="background-color: #F2C40F; text-align: center; color:white; font-size: 20px;">
						</c:when>
						<c:when test="${rdlist.importance eq '낮음'}">
							<input type="text" class="form-control" value="${rdlist.importance}" readonly="readonly" onfocus="this.blur();"
								style="background-color: #3498FF; text-align: center; color:white; font-size: 20px;">
						</c:when>
					</c:choose>
				</div>
				<!-- 리스크명 -->
				<div style="flex:3;margin-right: 15px;" >
					<input type="text" class="form-control" value="${rdlist.title}" readonly="readonly" onfocus="this.blur();"
						style="background-color: white; text-align: center; font-size: 20px;">
				</div>
				<!-- 작성일 -->
				<div style="flex:1">
					<input type="text" class="form-control" value="${rdlist.writedates}" readonly="readonly" onfocus="this.blur();"
						style="background-color: white; text-align: center; font-size: 20px;">
				</div>
			</div>
			<!-- 상세내용 -->
			<div style="margin-top: 15px;">
				<textarea class="form-control" rows="15" cols="116" readonly="readonly" onfocus="this.blur();"
					style="background-color: white;">${rdlist.content}</textarea>
			</div>
			<!-- 담당자, 진행사항, 완료예정일 -->
			<div style="display:flex; margin-top: 15px;">
				<!-- 담당자 -->
				<div style="flex:1; margin-right: 15px;">
					<input type="text" class="form-control" name="name" value="${rdlist.name}" readonly="readonly" onfocus="this.blur();"
						style="background-color: white; text-align: center; font-size: 20px;">
				</div>
				<!-- 진행사항 -->
				<div style="flex:1; margin-right: 350px;">
					<c:choose>
						<c:when test="${rdlist.progress eq'진행중'}">
							<input type="text" class="form-control" value="${rdlist.progress}" readonly="readonly" onfocus="this.blur();"
								style="background-color: #F2C40F; color:white; text-align: center; font-size: 20px;">
						</c:when>
						<c:when test="${rdlist.progress eq'완료'}">
							<input type="text" class="form-control" value="${rdlist.progress}" readonly="readonly" onfocus="this.blur();"
								style="background-color: #16A085; color:white; text-align: center; font-size: 20px;">
						</c:when>
						<c:when test="${rdlist.progress eq'대기'}">
							<input type="text" class="form-control" value="${rdlist.progress}" readonly="readonly" onfocus="this.blur();"
								style="background-color: #3498FF; color:white; text-align: center; font-size: 20px;">
						</c:when>
					</c:choose>
				</div>
				<!-- 완료예정일 -->
				<div style="flex:1; margin-top: 10px;">
					<h5>완료예정일</h5>
				</div>
				
				<div style="flex:3;">
					<input type="text" class="form-control" value="${rdlist.comdate}" readonly="readonly" onfocus="this.blur();"
						style="background-color: white; text-align: center; font-size: 20px;">
				</div>
			</div>
			<!-- 수정, 삭제,돌아가기 버튼 -->
			<div style="margin-top: 30px;align-content:right;float:right;">
				<!-- 수정버튼 -->
					<button class="btn btn-warning" id="uptbtn">수정</button>
				<!-- 삭제버튼 -->
					<button class="btn btn-danger" id="delbtn">삭제</button>
				<!-- 돌아가기버튼 -->
					<button class="btn btn-primary" id="backbtn">뒤로가기</button>
			
			</div>
		</div>
		
		<hr>
		<!-- 댓글 목록 -->
		<div id="commlist">
			<table>
				<c:forEach var="rcomm" items="${commlist}">
					<tr>
					<th><input type="hidden" name="rcommkey" value="${rcomm.rcommkey}"></th>
					<th>${rcomm.rcommkey}</th>
					
					<th style="text-align: left">
					<c:forEach varStatus="sts" begin="1" end="${rcomm.level}">
						&nbsp;&nbsp;
    					<c:if test="${rcomm.level>1 and sts.last }">
    					
    				</c:if>
    				</c:forEach>
					${rcomm.name}</th>
					<td style="padding-left: 20px;">${rcomm.commcontent}</td>
					<th style="padding-left: 60px;"><fmt:formatDate type="both" value="${rcomm.commdate}"/></th>
					<td><button onclick="recomm(${rcomm.rcommkey})" class="btn btn-primary">답글</button></td>
					<!-- 작성자 미 일치시 삭제 버튼 비 활성화 -->
					<c:if test="${rcomm.id == member.id && rcomm.refno == 0}">
						<td><button id="comdelBtn" class="btn btn-danger">삭제</button></td>
					</c:if>
					<c:if test="${rcomm.id == member.id && rcomm.refno !=0}">
						<td>
							<form id="recommFrm" action="${path}/delriskrecomm.do" method="post">
								<input type="hidden" name="rrecommkey" value="${rcomm.rcommkey}">
								<button id="recomdelBtn" class="btn btn-danger">답글삭제</button>
							</form>
						</td>
					</c:if>
					</tr>
				</c:forEach>
			</table>
		</div>
		<!-- 댓글 작성 -->
		<div id="commwrite">
		 <form id="commform" method="post" action="${path}/insertcomm.do">
		 	<h5>댓글 작성</h5>
			<textarea name="commcontents" class="form-control" rows="8" cols="100%"></textarea>
			<input type="hidden" name="riskkey" value="${riskkey}">
			<input type="hidden" name="id" value="${member.id}">
			<button type="button" id="commregbtn" class="btn btn-primary"
			 style="float: right; margin-top: 10px;">등록</button>
		 </form>
		</div>
		
		<!-- 답글 작성 -->
		<div id="recommwrite">
		 <form id="recommform" method="post" action="${path}/insertrecomm.do">
			<hr>
			<h5>답글 작성</h5>
			<textarea rows="5" cols="100%" name="recommcontents" class="form-control"></textarea>
			<input type="hidden" name="riskkey" value="${riskkey}">
			<input type="hidden" name="id" value="${member.id}">
			<input type="hidden" name="refno">
			<div style="float:right;">
				<button type="button" id="recancleBtn" class="btn btn-primary">취소</button>
				<button type="button" id="recommregbtn" class="btn btn-primary">등록</button>
			</div>
		 </form>
		</div>
	     
	</div>
	
	

</body>
</html>