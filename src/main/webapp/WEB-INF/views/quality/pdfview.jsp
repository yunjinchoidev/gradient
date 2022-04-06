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
2022-03-29
장훈주
인증서 출력 화면
 --%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<body>
<%@ include file="../common/header.jsp"%>
<!-- <iframe src="report\project55.pdf" style="width:100%;height:1200px;border:0px;top:0px;left:0px;"></iframe> -->

 <div>
 	<button class="btn btn-primary" id="mainbtn"
 		 style="float:right;margin-bottom: 20px; margin-right: 20px;">메인</button>
 	<button class="btn btn-primary" id="qualbtn"
 		 style="float:right;margin-bottom: 20px; margin-right: 20px;">품질</button>
 </div>
 <div id="example1" style="height:50rem;"></div>
    <script src="${path}/a00_com/pdfobject.js"></script>
   <!--  <script>PDFObject.embed("report/project55.pdf", "#example1");</script> --> 


</body>

<script>
	$(document).ready(function(){
		
		PDFObject.embed("report/project55.pdf", "#example1");
		
		$("#mainbtn").click(function(){
			if(confirm('메인페이지로 이동 하시겠습니까?')){
				location.href="${path}/main.do";
			}
		});
					
		$("#qualbtn").click(function(){
			if(confirm('품질페이지로 이동 하시겠습니까?')){
				location.href="${path}/qualityList.do";
			}
		});

	});
</script>
</html>