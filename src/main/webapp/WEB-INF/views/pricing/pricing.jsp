<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
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
<link rel="shortcut icon"
	href="/project5/resources/dist/assets/images/favicon.svg"
	type="image/x-icon">
<script
	src="/project5/resources/dist/assets/vendors/perfect-scrollbar/perfect-scrollbar.min.js"></script>
<script src="/project5/resources/dist/assets/js/bootstrap.bundle.min.js"></script>

<script src="/project5/resources/dist/assets/js/main.js"></script>
</head>

<script>
$(document).ready(function(){
	console.log("${member.visitcnt}");
	$("#premium").click(function(){
			confirm("정말 프리미엄으로 바꾸시겠습니까?")
		if(parseInt("${member.visitcnt}") >= 500 ){
			location.href='/project5/updatePricing.do?memberkey=${member.memberkey}&pricing=2'	
		}else{
			alert("불가합니다.")
		}
	})
	$("#pro").click(function(){
			confirm("정말 프리미엄으로 바꾸시겠습니까?")
		if(parseInt("${member.visitcnt}")>=200 ){
				location.href='/project5/updatePricing.do?memberkey=${member.memberkey}&pricing=1'								
		}else{
			alert("불가합니다.")
		}
	})
})
</script>

<body>


<%@ include file="../chatBot/chatBot.jsp"%>
	<%@include file="../common/header.jsp"%>






	<div id="main">
		<header class="mb-3">
			<a href="#" class="burger-btn d-block d-xl-none"> <i
				class="bi bi-justify fs-3"></i>
			</a>
		</header>

		<div class="page-heading">
			<div class="page-title">
				<div class="row">
					<div class="col-12 col-md-6 order-md-1 order-last">
						<h3>Pricing</h3>
						<p class="text-subtitle text-muted">당신에 맞는 플랜을 선택하세요</p>
					</div>
					<div class="col-12 col-md-6 order-md-2 order-first">
						<nav aria-label="breadcrumb"
							class="breadcrumb-header float-start float-lg-end">
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="index.html">Dashboard</a></li>
								<li class="breadcrumb-item active" aria-current="page">Pricing</li>
							</ol>
						</nav>
					</div>
				</div>
			</div>

			<section class="section">
				<div class="row">
					<div class="col-12 col-md-8 offset-md-2">
						<div class="pricing">
							<div class="row align-items-center">
								<div class="col-md-4 px-0">
									<div class="card">
										<div class="card-header text-center">
											<h4 class="card-title">기본</h4>
											<p class="text-center">A standart features you can get</p>
										</div>
										<h1 class="price">무료</h1>
										<ul>
											<li><i class="bi bi-check-circle"></i>Lorem ipsum dolor
												sit amet</li>
											<li><i class="bi bi-check-circle"></i>Lorem ipsum dolor
												sit</li>
											<li><i class="bi bi-check-circle"></i>Lorem ipsum dolor
												amet</li>
											<li><i class="bi bi-check-circle"></i>Lorem ipsum dolor
												sit amet</li>
											<li><i class="bi bi-check-circle"></i>Lorem ipsum sit
												amet</li>
											<li><i class="bi bi-check-circle"></i>Lorem dolor sit
												amet</li>
										</ul>
										<div class="card-footer">
											<button class="btn btn-primary btn-block">바꾸기</button>
										</div>
									</div>
								</div>
								<div class="col-md-4 px-0">
									<div class="card card-highlighted">
										<div class="card-header text-center">
											<h4 class="card-title" >프리미엄</h4>
											<p></p>
										</div>
										<h1 class="price text-white">방문수 <br>500회</h1>
										<ul>
											<li><i class="bi bi-check-circle"></i>Lorem ipsum kolor
												sit amet</li>
											<li><i class="bi bi-check-circle"></i>Lorem ipsum dolor
												sit amet</li>
											<li><i class="bi bi-check-circle"></i>Lorem ipsum kolor
												sit amet</li>
											<li><i class="bi bi-check-circle"></i>Lorem ipsum dolor
												sit amet</li>
											<li><i class="bi bi-check-circle"></i>Lorem ipsum kolor
												sit amet</li>
											<li><i class="bi bi-check-circle"></i>Lorem ipsum dolor
												sit amet</li>
											<li><i class="bi bi-check-circle"></i>Lorem ipsum kolor
												sit amet</li>
											<li><i class="bi bi-check-circle"></i>Lorem ipsum dolor
												sit amet</li>
											<li><i class="bi bi-check-circle"></i>Lorem ipsum kolor
												sit amet</li>
										</ul>
										<div class="card-footer">
											<button class="btn btn-outline-white btn-block" id="premium">바꾸기</button>
										</div>
									</div>
								</div>
								<div class="col-md-4 px-0">
									<div class="card">
										<div class="card-header text-center">
											<h4 class="card-title"
											>프로</h4>
											<p class="text-center">A higher features you will need</p>
										</div>
										<h1 class="price">방문 수 <br>200회</h1>
										<ul>
											<li><i class="bi bi-check-circle"></i>Lorem ipsum dolor
												sit amet</li>
											<li><i class="bi bi-check-circle"></i>Lorem ipsum dolor
												sit</li>
											<li><i class="bi bi-check-circle"></i>Lorem ipsum dolor
												amet</li>
											<li><i class="bi bi-check-circle"></i>Lorem ipsum dolor
												sit amet</li>
											<li><i class="bi bi-check-circle"></i>Lorem ipsum sit
												amet</li>
											<li><i class="bi bi-check-circle"></i>Lorem dolor sit
												amet</li>
										</ul>
										<div class="card-footer">
											<button class="btn btn-primary btn-block" id="pro">바꾸기</button>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>
		</div>

		<footer>
			<div class="footer clearfix mb-0 text-muted">
				<div class="float-start">
					<p>2021 © Mazer</p>
				</div>
				<div class="float-end">
					<p>
						Crafted with <span class="text-danger"><i
							class="bi bi-heart"></i></span> by <a href="http://ahmadsaugi.com">A.
							Saugi</a>
					</p>
				</div>
			</div>
		</footer>
	</div>
</body>
</html>