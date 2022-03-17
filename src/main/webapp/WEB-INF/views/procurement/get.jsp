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
#mainform {
	width: 1000px;
	height: 650px;
	margin: 0 auto;
}

#commlist {
	background-color: #D4E0FA;
	width: 1000px;
	height: 300px;
	margin: 0 auto;
	overflow: auto;
}

#commwrite {
	width: 1000px;
	height: 300px;
	margin: 0 auto;
	margin-top: 30px;
}

#recommwrite {
	width: 1000px;
	height: 300px;
	margin: 0 auto;
	margin-top: 30px;
}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<script>
	$(document)
			.ready(
					function() {

						var msg = "${msg}";
						var commmsg = "${commmsg}";
						var sessid = "${member.id}";
						var id = $("[name=id]").val();

						$('#recommwrite').hide();

						// 수정 삭제 메시지
						if (msg != "") {
							alert(msg);
							location.href = "${path}/risk.do";
						}

						// 댓글 메시지
						if (commmsg != "") {
							alert(commmsg);
							location.href = document.referrer;
						}

						/* 세션 없을 시 댓글 작성 영역 hide*/
						if (sessid == "") {
							$('#commwrite').hide();
						}

						/* 작성자가 아닐 시 삭제, 수정*/
						if (sessid != id) {
							$('#delbtn').hide();
							$('#uptbtn').hide();
						}

						$('#recancleBtn').click(function() {
							if (confirm('답글 작성을 취소하시겠습니까?')) {
								$('#recommwrite').hide();
							}
						});

						$("#delbtn")
								.click(
										function() {
											if (confirm("삭제하시겠습니까?")) {
												location.href = "${path}/delrisk.do?riskkey="
														+ $("[name=riskkey]")
																.val();
											}

										});

						$("#uptbtn")
								.click(
										function() {
											if (confirm("수정하시겠습니까?")) {
												location.href = "${path}/riskuptdetail.do?riskkey="
														+ $("[name=riskkey]")
																.val();
											}

										});

						$("#backbtn").click(function() {
							location.href = "${path}/risk.do";
						});

						$("#commregbtn").click(function() {
							if (confirm("댓글을 등록 하시겠습니까?")) {
								$('#commform').submit();
							}
						});

						$("button[id^='comdelBtn']")
								.click(
										function() {
											if (confirm('댓글을 삭제하시겠습니까?')) {
												location.href = "${path}/delriskcomm.do?rcommkey="
														+ $("[name=rcommkey]")
																.val();
											}
										});

						$("#recommregbtn").click(function() {
							if (confirm("답글을 등록 하시겠습니까?")) {
								$('#recommform').submit();
							}
						});

						$("button[id^='recomdelBtn']").click(function() {
							if (confirm('답글을 삭제하시겠습니까?')) {
								$("#recommFrm").submit();
							}
						});

					});

	function recomm(rcommkey) {
		if (confirm('답글을 작성하시겠습니까?')) {
			$('#recommwrite').show();
			$('[name=recommcontents]').focus();
			$('[name=refno]').val(rcommkey);
			$('[name=recommcontents]').val("RE:" + rcommkey + " ) ");
		}
	}
</script>
</head>

<body>
	<%@ include file="../common/header.jsp"%>





	<div id="main">
		<div id="mainform">
			<input type="text" class="form-control"
				value="${get.qualityManagement}" readonly="readonly"
				onfocus="this.blur();"
				style="background-color: white; text-align: center; font-size: 20px;">
			<!-- 중요도, 리스크명, 작성일 -->
			<div id="mainheader" style="margin-top: 10px; display: flex;">
				<!-- 중요도 -->
				<div style="flex: 1; margin-right: 15px;">
					<c:choose>
						<c:when test="${rdlist.importance eq '중요'}">
							<input type="text" class="form-control"
								value="${rdlist.importance}" readonly="readonly"
								onfocus="this.blur();"
								style="background-color: #C0392B; text-align: center; color: white; font-size: 20px;">
						</c:when>
						<c:when test="${rdlist.importance eq '보통'}">
							<input type="text" class="form-control"
								value="${rdlist.importance}" readonly="readonly"
								onfocus="this.blur();"
								style="background-color: #F2C40F; text-align: center; color: white; font-size: 20px;">
						</c:when>
						<c:when test="${rdlist.importance eq '낮음'}">
							<input type="text" class="form-control"
								value="${rdlist.importance}" readonly="readonly"
								onfocus="this.blur();"
								style="background-color: #3498FF; text-align: center; color: white; font-size: 20px;">
						</c:when>
					</c:choose>
				</div>
				<!-- 리스크명 -->
				<div style="flex: 3; margin-right: 15px;">
					<input type="text" class="form-control"
						value="${get.qualityManagement}" readonly="readonly"
						onfocus="this.blur();"
						style="background-color: white; text-align: center; font-size: 20px;">
				</div>
				<!-- 작성일 -->
				<div style="flex: 1">
					<input type="text" class="form-control" value="${get.writedate}"
						readonly="readonly" onfocus="this.blur();"
						style="background-color: white; text-align: center; font-size: 20px;">
				</div>
			</div>
			<!-- 상세내용 -->
			<div style="margin-top: 15px;">
				<textarea class="form-control" rows="15" cols="116"
					readonly="readonly" onfocus="this.blur();"
					style="background-color: white;"></textarea>
			</div>
			<!-- 담당자, 진행사항, 완료예정일 -->
			<div style="display: flex; margin-top: 15px;">
				<!-- 담당자 -->
				<div style="flex: 1; margin-right: 15px;">
					<input type="text" class="form-control" name="name"
						value="" readonly="readonly" onfocus="this.blur();"
						style="background-color: white; text-align: center; font-size: 20px;">
				</div>
				<!-- 수정, 삭제,돌아가기 버튼 -->
				<div style="margin-top: 30px; align-content: right; float: right;">
					<!-- 수정버튼 -->
					<button class="btn btn-warning" id="uptbtn">수정</button>
					<!-- 삭제버튼 -->
					<button class="btn btn-danger" id="delbtn">삭제</button>
					<!-- 돌아가기버튼 -->
					<button class="btn btn-primary" id="backbtn">뒤로가기</button>

				</div>
			</div>

			<hr>
		</div>

	</div>



</body>
</html>