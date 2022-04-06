
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
.uploadResult {
	width: 100%;
	background-color: gray;
}

.uploadResult ul {
	display: flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
}

.uploadResult ul li {
	list-style: none;
	padding: 10px;
}

.uploadResult ul li img {
	width: 100px;
}
</style>

<style>
.bigPictureWrapper {
	position: absolute;
	display: none;
	justify-content: center;
	align-items: center;
	top: 0%;
	width: 100%;
	height: 100%;
	background-color: gray;
	z-index: 100;
}

.bigPicture {
	position: relative;
	display: flex;
	justify-content: center;
	align-items: center;
}
</style>


</head>
<script>



</script>




<body>
	<%@ include file="../common/header.jsp"%>
	<div id="main">
		<section id="multiple-column-form">
			<div class="row match-height">
				<div class="col-12">
					<div class="card">

						<div class="card-header">
							<h4 class="card-title">조달 요구서 작성</h4>
						</div>
					
                            
                            
                            
						<div class="card-content">
							<div class="card-body">
							
								<form class="form" action="/project5/procurementInsert.do"	method="post">
									<input type="hidden" name="memberkey" value="${member.memberkey }">
									<input type="hidden" name="projectkey" value="1">
									<div class="row">
										<div class="col-md-6 col-12">
											<div class="form-group">
												<label for="first-name-column">제목</label> <input
													type="text" id="first-name-column" class="form-control"
													placeholder="title" name="title">
											</div>
										</div>
										<div class="col-md-6 col-12">
											<div class="form-group">
												<label for="last-name-column">작성일</label> <input type="date"
													id="last-name-column" class="form-control"
													placeholder="writeDate" name="writeDateS">
											</div>
										</div>
										<div class="col-md-6 col-12">
											<div class="form-group">
												<label for="email-id-column">Contents</label>
												<textarea class="form-control" name="contents"
													placeholder="content" rows="4"></textarea>
											</div>
										</div>






										<div class="row">
											<div class="col-lg-12">
												<div class="panel panel-default">

													<div class="panel-heading">File Attach</div>
													<!-- /.panel-heading -->
													<div class="panel-body">
														<div class="form-group uploadDiv">
															<input type="file" name='uploadFile' multiple>
														</div>
														<div class='uploadResult'>
															<ul>
															</ul>
														</div>
													</div>
													<!--  end panel-body -->

												</div>
												<!--  end panel-body -->
											</div>
											<!-- end panel -->
										</div>
										<!-- /.row -->


















										<div class="form-group col-12">
											<div class="form-check">
												<div class="checkbox">
													<input type="checkbox" id="checkbox5"
														class="form-check-input" checked=""> <label
														for="checkbox5">Remember Me</label>
												</div>
											</div>
										</div>












										<div class="col-12 d-flex justify-content-end">
											<button type="button"
												class="btn btn-danger btn-icon icon-left"
												style="height: 90%"
												onclick="location.href='/project5/procurementList.do'">
												<i class="fas fa-plane"></i> 뒤로가기
											</button>
											<button type="submit" class="btn btn-primary me-1 mb-1">등록</button>
											<button type="reset"
												class="btn btn-light-secondary me-1 mb-1">초기화</button>
										</div>
									</div>
								</form>





							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
	</div>


</body>

</html>




<script>

$(document).ready(function(e){


  
});

</script>


