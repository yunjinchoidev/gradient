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
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<head>
<meta charset="UTF-8">
<title>GRADIENT</title>
<script type="text/javascript">
	$(document).ready(function() {
		var psc = "${psc}";
		console.log("psc : " + psc);
		if (psc == "success") {
			alert("로그인 성공하셨습니다.");
		}

		if (psc == "logout") {
			alert("로그아웃 되었습니다.");
		}
	})
</script>
</head>

<body>
<!-- 페이스북 댓글api -->
<div id="fb-root"></div>
<script async defer crossorigin="anonymous" src="https://connect.facebook.net/ko_KR/sdk.js#xfbml=1&version=v13.0&appId=282186027273418&autoLogAppEvents=1" 
nonce="SuTAbMKi">
</script>


	<%@ include file="chatBot/chatBot.jsp"%>
	<%@ include file="common/header.jsp"%>


	<div id="main">

		<div class="page-heading">
			<div class="page-title">
				<div class="row">
					<div class="col-12 col-md-6 order-md-1 order-last">
						<h3>GRADIENT에 방문하신 여러분을 환영합니다</h3>
						<p class="text-subtitle text-muted">
						여러분을 더 유능하게 만들어 줄 당신의 친구가 바로 여기있습니다.</p>
					</div>
					<div class="col-12 col-md-6 order-md-2 order-first">
						<nav aria-label="breadcrumb"
							class="breadcrumb-header float-start float-lg-end"></nav>
					</div>
				</div>
			</div>
			<section class="section">
				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-header">
								<h5 class="card-title">안녕하세요?</h5>
							</div>
							<div class="card-body" style="width: 100%;">
							    조원 : 최윤진, 마혜민, 문재영, 신지호, 윤혜정, 장훈주<br>
								프로젝트 기간 : 2022년 3월 4일 ~ 4월 12일 <br> <br> <a
									href="https://github.com/yunjinchoidev/project5"
									target="_blank">깃허브 링크입니다.<br> <br>
								</a>
								
									<!-- 댓글 들어가는 부분 -->
								<div class="fb-comments" 
								data-href="http://106.10.16.155:7080/project5/main.do" 
								data-width="1100" data-numposts="5" style="width: 100%"></div>
							</div>
							
							
							
							
							
							
							
							
							
						</div>
					</div>
				</div>
			</section>


			<!-- Groups section start -->
			<section id="groups">
				<div class="row match-height">
					<div class="col-12 mt-3 mb-1">
						<h4 class="section-title text-uppercase">5조</h4>
					</div>
				</div>
				<div class="row match-height">
					<div class="col-12">
						<div class="card-group">
							<div class="card">
								<div class="card-content">
									<img class="card-img-top img-fluid"
										src="/project5/resources/emoji/cyj.jpg" alt="Card image cap"
										style="width: 100%; height: 200px">
									<div class="card-body">
										<h4 class="card-title">최윤진</h4>
										<p class="card-text">안녕하세요. 프로젝트 조장을 맡았습니다.</p>
										<small class="text-muted">3월 9일</small>
									</div>
								</div>
							</div>
							<div class="card">
								<div class="card-content">
									<img class="card-img-top img-fluid"
										src="/project5/resources/emoji/mhm.png" alt="Card image cap"
										style="width: 100%; height: 200px">
									<div class="card-body">
										<h4 class="card-title">마혜민</h4>
										<p class="card-text">This card has supporting text below
											as a natural lead-in to additional content.</p>
										<small class="text-muted">Last updated 3 mins ago</small>
									</div>
								</div>
							</div>
							<div class="card">
								<div class="card-content">
									<img class="card-img-top img-fluid"
										src="/project5/resources/emoji/mjy.jpg" alt="Card image cap"
										style="width: 100%; height: 200px">
									<div class="card-body">
										<h4 class="card-title">문재영</h4>
										<p class="card-text">This card has supporting text below
											as a natural lead-in to additional content.</p>
										<small class="text-muted">Last updated 3 mins ago</small>
									</div>
								</div>
							</div>
							<div class="card">
								<div class="card-content">
									<img class="card-img-top img-fluid"
										src="/project5/resources/emoji/sjh.jpg" alt="Card image cap"
										style="width: 100%; height: 200px">
									<div class="card-body">
										<h4 class="card-title">신지호</h4>
										<p class="card-text">This card has supporting text below
											as a natural lead-in to additional content.</p>
										<small class="text-muted">Last updated 3 mins ago</small>
									</div>
								</div>
							</div>
							<div class="card">
								<div class="card-content">
									<img class="card-img-top img-fluid"
										src="/project5/resources/emoji/yhj.jpg" alt="Card image cap"
										style="width: 100%; height: 200px">
									<div class="card-body">
										<h4 class="card-title">윤혜정</h4>
										<p class="card-text">This card has supporting text below
											as a natural lead-in to additional content.</p>
										<small class="text-muted">Last updated 3 mins ago</small>
									</div>
								</div>
							</div>
							<div class="card">
								<div class="card-content">
									<img class="card-img-top img-fluid"
										src="/project5/resources/emoji/jhj.jpg" alt="Card image cap"
										style="width: 100%; height: 200px;">
									<div class="card-body">
										<h4 class="card-title">장훈주</h4>
										<p class="card-text">This card has supporting text below
											as a natural lead-in to additional content.</p>
										<small class="text-muted">Last updated 3 mins ago</small>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>
		</div>




























		<div class="page-heading">
			<div class="page-title">
				<div class="row">
					<div class="col-12 col-md-6 order-md-1 order-last">
						<h3>개발의 기록</h3>
						<p class="text-subtitle text-muted">프로젝트의 여정을 기록해두었습니다.</p>
					</div>
					<div class="col-12 col-md-6 order-md-2 order-first">
						<nav aria-label="breadcrumb"
							class="breadcrumb-header float-start float-lg-end">
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="index.html">Dashboard</a></li>
								<li class="breadcrumb-item active" aria-current="page">Card</li>
							</ol>
						</nav>
					</div>
				</div>
			</div>
			<!-- Basic card section start -->
			<section id="content-types">
				<div class="row">
					<div class="col-xl-4 col-md-6 col-sm-12">
						<div class="card">
							<div class="card-content">
								<div class="card-body">
									<h4 class="card-title">회의록</h4>
									<p class="card-text">Gummies bonbon apple pie fruitcake
										icing biscuit apple pie jelly-o sweet roll. Toffee sugar plum
										sugar plum jelly-o jujubes bonbon dessert carrot cake.</p>
								</div>
								<img class="img-fluid w-100"
									src="/project5/resources/image/notionconference.png"
									alt="Card image cap">
							</div>
							<div class="card-footer d-flex justify-content-between">
								<span>Card Footer</span>
								<button class="btn btn-light-primary">Read More</button>
							</div>
						</div>

						<div class="card">
							<div class="card-content">
								<div class="card-body">
									<h4 class="card-title">산출물</h4>
									<p class="card-text">Gummies bonbon apple pie fruitcake
										icing biscuit apple pie jelly-o sweet roll. Toffee sugar plum
										sugar plum jelly-o jujubes bonbon dessert carrot cake.</p>
								</div>
								<img class="img-fluid w-100"
									src="/project5/resources/image/ouroutput.png"
									alt="Card image cap">
							</div>
							<div class="card-footer d-flex justify-content-between">
								<span>Card Footer</span>
								<button class="btn btn-light-primary">Read More</button>
							</div>
						</div>












					</div>








					<div class="col-xl-4 col-md-6 col-sm-12">


						<div class="card">
							<div class="card-content">
								<img src="/project5/resources/image/introduce.png"
									class="card-img-top img-fluid" alt="singleminded">
								<div class="card-body">
									<h5 class="card-title">Be Single Minded</h5>
									<p class="card-text">Chocolate sesame snaps apple pie
										danish cupcake sweet roll jujubes tiramisu.Gummies bonbon
										apple pie fruitcake icing biscuit apple pie jelly-o sweet
										roll.</p>
								</div>
							</div>
							<ul class="list-group list-group-flush">
								<li class="list-group-item">Cras justo odio</li>
								<li class="list-group-item">Dapibus ac facilisis in</li>
								<li class="list-group-item">Vestibulum at eros</li>
							</ul>
						</div>


						<div class="card">
							<div class="card-content">
								<div class="card-body">
									<h4 class="card-title">Feedback Form</h4>
									<p class="card-text">Gummies bonbon apple pie fruitcake
										icing biscuit apple pie jelly-o sweet roll. Toffee sugar plum
										sugar plum jelly-o jujubes bonbon dessert carrot cake.</p>
									<form class="form" method="post">
										<div class="form-body">
											<div class="form-group">
												<label for="feedback1" class="sr-only">Name</label> <input
													type="text" id="feedback1" class="form-control"
													placeholder="Name" name="name">
											</div>
											<div class="form-group">
												<label for="feedback4" class="sr-only">Last Game</label> <input
													type="text" id="feedback4" class="form-control"
													placeholder="Last Name" name="LastName">
											</div>
											<div class="form-group">
												<label for="feedback2" class="sr-only">Email</label> <input
													type="email" id="feedback2" class="form-control"
													placeholder="Email" name="email">
											</div>
											<div class="form-group">
												<select name="reason" class="form-control">
													<option value="Inquiry">Inquiry</option>
													<option value="Complain">complaints</option>
													<option value="Quotation">Quotation</option>
												</select>
											</div>
											<div class="form-group form-label-group">
												<textarea class="form-control" id="label-textarea" rows="3"
													placeholder="Suggestion"></textarea>
												<label for="label-textarea"></label>
											</div>
										</div>
										<div class="form-actions d-flex justify-content-end">
											<button type="submit" class="btn btn-primary me-1">Submit</button>
											<button type="reset" class="btn btn-light-primary">Cancel</button>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>












					<div class="col-xl-4 col-md-6 col-sm-12">
						<div class="card">
							<div class="card-content">
								<div class="card-body">
									<h4 class="card-title">후기</h4>
									<p class="card-text">Gummies bonbon apple pie fruitcake
										icing biscuit apple pie jelly-o sweet roll. Toffee sugar plum
										sugar plum jelly-o jujubes bonbon dessert carrot cake.</p>
								</div>
								<img class="img-fluid w-100"
									src="/project5/resources/image/after.png"
									alt="Card image cap">
							</div>
							<div class="card-footer d-flex justify-content-between">
								<span>Card Footer</span>
								<button class="btn btn-light-primary">Read More</button>
							</div>
						</div>


					</div>
					<div class="col-md-6 col-sm-12">
						<div class="card">
							<div class="card-content">
								<img class="card-img-top img-fluid"
									src="/project5/resources/dist/assets/images/samples/origami.jpg"
									alt="Card image cap" style="height: 20rem">
								<div class="card-body">
									<h4 class="card-title">Top Image Cap</h4>
									<p class="card-text">Jelly-o sesame snaps cheesecake
										topping. Cupcake fruitcake macaroon donut pastry gummies
										tiramisu chocolate bar muffin. Dessert bonbon caramels brownie
										chocolate bar chocolate tart dragée.</p>
									<p class="card-text">Cupcake fruitcake macaroon donut
										pastry gummies tiramisu chocolate bar muffin.</p>
									<button class="btn btn-primary block">Update now</button>
								</div>
							</div>
						</div>
					</div>
					<div class="col-md-6 col-sm-12">
						<div class="card">
							<div class="card-content">
								<div class="card-body">
									<h4 class="card-title">Bottom Image Cap</h4>
									<p class="card-text">Jelly-o sesame snaps cheesecake
										topping. Cupcake fruitcake macaroon donut pastry gummies
										tiramisu chocolate bar muffin. Dessert bonbon caramels brownie
										chocolate bar chocolate tart dragée.</p>
									<p class="card-text">Cupcake fruitcake macaroon donut
										pastry gummies tiramisu chocolate bar muffin.</p>
									<small class="text-muted">Last updated 3 mins ago</small>
								</div>
								<img class="card-img-bottom img-fluid"
									src="/project5/resources/dist/assets/images/samples/water.jpg"
									alt="Card image cap" style="height: 20rem; object-fit: cover;">
							</div>
						</div>
					</div>
				</div>
			</section>
			<!-- Basic Card types section end -->



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