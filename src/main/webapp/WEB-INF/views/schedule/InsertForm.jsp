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
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>File Uploader - Mazer Admin Dashboard</title>

<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&amp;display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="/project5/resources/dist/assets/css/bootstrap.css">

<link rel="stylesheet"
	href="/project5/resources/dist/assets/vendors/toastify/toastify.css">
<link href="https://unpkg.com/filepond/dist/filepond.css"
	rel="stylesheet">
<link
	href="https://unpkg.com/filepond-plugin-image-preview/dist/filepond-plugin-image-preview.css"
	rel="stylesheet">

<link rel="stylesheet"
	href="/project5/resources/dist/assets/vendors/perfect-scrollbar/perfect-scrollbar.css">
<link rel="stylesheet"
	href="/project5/resources/dist/assets/vendors/bootstrap-icons/bootstrap-icons.css">
<link rel="stylesheet"
	href="/project5/resources/dist/assets/css/app.css">
<link rel="shortcut icon"
	href="/project5/resources/dist/assets/images/favicon.svg"
	type="image/x-icon">
</head>

<body>
	<%@ include file="../common/header.jsp"%>

	<div id="main">
		<div class="page-heading">
			<div class="page-title">
				<div class="row">
					<div class="col-12 col-md-6 order-md-1 order-last">
						<h3>File Uploader</h3>
						<p class="text-subtitle text-muted">File uploader that makes
							user easier to upload their files</p>
					</div>
					<div class="col-12 col-md-6 order-md-2 order-first">
						<nav aria-label="breadcrumb"
							class="breadcrumb-header float-start float-lg-end">
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="index.html">Dashboard</a></li>
								<li class="breadcrumb-item active" aria-current="page">File
									Uploader</li>
							</ol>
						</nav>
					</div>
				</div>
			</div>

			<section class="section">
				<div class="row">
					<div class="col-12 col-md-12">
						<div class="card">
							<div class="card-header">
								<h5 class="card-title">Multiple Files</h5>
							</div>
							<div class="card-content">
								<div class="card-body">
									<p class="card-text">
										Using the basic table up, upload here to see how
										<code>.multiple-files-filepond</code>
										-based basic file uploader look. You can use
										<code>allowMultiple</code>
										or
										<code>multiple</code>
										attribute too to implement multiple upload.
									</p>
									<!-- File uploader with multiple files upload -->
									<div
										class="filepond--root multiple-files-filepond filepond--hopper"
										data-style-button-remove-item-position="left"
										data-style-button-process-item-position="right"
										data-style-load-indicator-position="right"
										data-style-progress-indicator-position="right"
										data-style-button-remove-item-align="false"
										style="height: 76px;">
										<input class="filepond--browser" type="file"
											id="filepond--browser-4sulntkey" name="filepond"
											aria-controls="filepond--assistant-4sulntkey"
											aria-labelledby="filepond--drop-label-4sulntkey" accept=""
											multiple=""><a class="filepond--credits"
											aria-hidden="true" href="https://pqina.nl/" target="_blank"
											rel="noopener noreferrer"
											style="transform: translateY(68px);">Powered by PQINA</a>
										<div class="filepond--drop-label"
											style="transform: translate3d(0px, 0px, 0px); opacity: 1;">
											<label for="filepond--browser-4sulntkey"
												id="filepond--drop-label-4sulntkey" aria-hidden="true">Drag
												&amp; Drop your files or <span
												class="filepond--label-action" tabindex="0">Browse</span>
											</label>
										</div>
										<div class="filepond--list-scroller"
											style="transform: translate3d(0px, 60px, 0px);">
											<ul class="filepond--list" role="list"></ul>
										</div>
										<div class="filepond--panel filepond--panel-root"
											data-scalable="true">
											<div class="filepond--panel-top filepond--panel-root"></div>
											<div class="filepond--panel-center filepond--panel-root"
												style="transform: translate3d(0px, 8px, 0px) scale3d(1, 0.6, 1);"></div>
											<div class="filepond--panel-bottom filepond--panel-root"
												style="transform: translate3d(0px, 68px, 0px);"></div>
										</div>
										<span class="filepond--assistant"
											id="filepond--assistant-4sulntkey" role="status"
											aria-live="polite" aria-relevant="additions"></span>
										<div class="filepond--drip"></div>
										<fieldset class="filepond--data"></fieldset>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>
		</div>

	</div>
</body>
</html>