<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.*"
    %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<fmt:requestEncoding value="utf-8"/>     
<!DOCTYPE html>
<%--


 --%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${path}/a00_com/bootstrap.min.css" >
<link rel="stylesheet" href="${path}/a00_com/jquery-ui.css" >
<style>
	.input-group-text{width:100%;font-weight:bolder;}
	.input-group-prepend{width:20%;}
</style>
<script src="${path}/a00_com/jquery.min.js"></script>
<script src="${path}/a00_com/popper.min.js"></script>
<script src="${path}/a00_com/bootstrap.min.js"></script>
<script src="${path}/a00_com/jquery-ui.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://developers.google.com/web/ilt/pwa/working-with-the-fetch-api" type="text/javascript"></script>
<script type="text/javascript">
	$(document).ready(function(){
		<%-- 
		
		# select 옵션에 의해서 
		선택되었을 때, 언어의 변경 처리하는 controller 호출 및 처리된 결과 확인..
		
		--%>
		$("#selectLan").val("${param.lang}")
		$("#selectLan").change(function(){
			if($(this).val()!=""){
				location.href="${path}/choiceLan.do?lang="+$(this).val();
			}
		});
		
		
	});
<%-- 
multilang=multi language
welcome=welcome!
id=id
reg=register
pwd=password
greet=hi!!
regmem=register member!
search=search
chlange=choice language
ko=korean
en=english
--%>	
</script>
</head>

<body>
<div class="jumbotron text-center">
  <h2 data-toggle="modal" data-target="#exampleModalCenter">
  	<spring:message code="multilang"/>
  </h2>
  <!-- 언어 선택 -->
  <select class="form-control" id="selectLan">
  	<option value=""><spring:message code="chlange"/></option>
  	<option value="korean"><spring:message code="korean"/></option>
  	<option value="english"><spring:message code="english"/></option>
  	<option value="japanese"><spring:message code="japanese"/></option>
  	<option value="german"><spring:message code="german"/></option>
  	<option value="french"><spring:message code="french"/></option>
  	<option value="chinese"><spring:message code="chinese"/></option>
  	<option value="spanish"><spring:message code="spanish"/></option>
  </select>
</div>



<div class="container">
	<h3 align="center"><spring:message code="regmem"/></h3>
	<div class="input-group mb-3">	
		<div class="input-group-prepend ">
			<span class="input-group-text  justify-content-center">
				<spring:message code="id"/>
			</span>
		</div>
		<input name="id" class="form-control" 
			placeholder="
			<spring:message code='id'/> <spring:message code='reg'/>
			" />	
	</div>	
	<div class="input-group mb-3">	
		<div class="input-group-prepend ">
			<span class="input-group-text  justify-content-center">
				<spring:message code="pwd"/>
			</span>
		</div>
		<input name="pass" class="form-control" 
			placeholder="
			<spring:message code='pwd'/> <spring:message code='reg'/>
			" />	
	</div>	

</div>













</body>
</html>