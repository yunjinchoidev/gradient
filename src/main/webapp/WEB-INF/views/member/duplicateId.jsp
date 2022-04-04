<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="/project5/resources/dist/assets/css/bootstrap.css">
<link rel="stylesheet"
	href="/project5/resources/dist/assets/vendors/perfect-scrollbar/perfect-scrollbar.css">
<link rel="stylesheet"
	href="/project5/resources/dist/assets/vendors/bootstrap-icons/bootstrap-icons.css">
<link rel="stylesheet"
	href="/project5/resources/dist/assets/css/app.css">
<link rel="stylesheet"
	href="/project5/resources/dist/assets/vendors/simple-datatables/style.css">
<link rel="shortcut icon"
	href="/project5/resources/dist/assets/images/favicon.svg"
	type="image/x-icon">



</head>

<script>

	$(document).ready(function() {
		$("#can").hide()
		$("#already").hide()
		
		
		var getId = "${id}"
		var data = {
			id : getId
		}
	
		$.ajax({
			url : '/project5/duplicateIdCheck.do',
			type : 'POST',
			dataType : 'json',
			data : data,
			success : function(result) {
				if (result.duplicateId == "can") {
					$("#can").show()
					$("#already").hide()
				} else {
					$("#can").hide()
					$("#already").show()
				}
			}

		})

	})
</script>
<body>
	<div id="main">
	<div style="margin-top: 100px;">
	<h2 id="can" style="color:red">사용 가능한 아이디 입니다	</h2>
	<h2 id="already" style="color:red">사용 불가 합니다.</h2>
	</div>
	</div>
</body>
</html>