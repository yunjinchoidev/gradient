<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

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

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script
	src="/project5/resources/dist/assets/vendors/perfect-scrollbar/perfect-scrollbar.min.js"></script>
<script src="/project5/resources/dist/assets/js/bootstrap.bundle.min.js"></script>
<script
	src="/project5/resources/dist/assets/vendors/simple-datatables/simple-datatables.js"></script>
<script src="/project5/resources/dist/assets/js/main.js"></script>

<body>

	<div class="compose-new-mail-sidebar ps">
		<div class="card shadow-none quill-wrapper p-0">
			<div class="card-header">
				<h1 class="card-title" id="emailCompose">
					<span style="color: red">[#${get.id }]</span>일정 조회
				</h1>
			</div>


			<!-- form start -->
			<form action="#" id="compose-form">
				<div class="card-content">
					<div class="card-body pt-0">
						<br>
						<div class="form-group pb-50">
							<label for="emailfrom">일정 명</label> <input type="text"
								id="emailfrom" class="form-control"
								placeholder="user@example.com" disabled="" value="${get.title }">
						</div>
						<div class="form-group pb-50">
							<label for="emailfrom">시작일</label> <input type="text"
								id="emailfrom" class="form-control"
								placeholder="user@example.com" disabled="" value="${get.start }">
						</div>
						<div class="form-group pb-50">
							<label for="emailfrom">종료일</label> <input type="text"
								id="emailfrom" class="form-control"
								placeholder="user@example.com" disabled="" value="${get.end }">
						</div>


						<div class="form-group pb-50">
							<label for="emailfrom">종일 여부</label> <input type="text"
								id="emailfrom" class="form-control"
								placeholder="user@example.com" disabled=""
								value="${get.allDay }">
						</div>
						<div class="form-group pb-50">
							<label for="emailfrom">내용</label>
							<textarea rows="" cols="" id="emailfrom" class="form-control"
								readonly="readonly">
							${get.allDay }
							</textarea>
						</div>



















						<div class="form-group mt-2">
							<div class="custom-file">
								<label class="custom-file-label" for="emailAttach">Attach
									File</label><br> <input type="file" class="custom-file-input"
									id="emailAttach" name="uploadFile">

							</div>
						</div>

						<br>
					</div>
				</div>




				<div class="card-footer d-flex justify-content-end pt-0">
					<button type="reset"
						class="btn btn-light-secondary cancel-btn mr-1">
						<i class="bx bx-x me-3"></i> <span>Cancel</span>
					</button>
					<button type="submit" class="btn-send btn btn-primary">
						<i class="bx bx-send me-3"></i> <span>Send</span>
					</button>
				</div>
			</form>
			<!-- form start end-->



		</div>
		<div class="ps__rail-x" style="left: 0px; bottom: 0px;">
			<div class="ps__thumb-x" tabindex="0" style="left: 0px; width: 0px;"></div>
		</div>
		<div class="ps__rail-y" style="top: 0px; right: 0px;">
			<div class="ps__thumb-y" tabindex="0" style="top: 0px; height: 0px;"></div>
		</div>
	</div>
</body>
</html>