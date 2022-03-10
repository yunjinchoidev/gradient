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

<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="/project5/resources/dist/assets/js/pages/ui-chartjs.js"></script>
<script src="/project5/resources/dist/assets/vendors/perfect-scrollbar/perfect-scrollbar.min.js"></script>
<script src="/project5/resources/dist/assets/vendors/chartjs/Chart.min.js"></script>
<meta charset="UTF-8">
<title>쌍용 5조 PMBOK 메인 페이지</title>
<script>
$(document).ready(function(){
	var psc = "${psc}";
	
	if(psc=="success"){
		alert("로그인 성공하셨습니다.");
	}
	
	if(psc=="logout"){
		alert("로그아웃 되었습니다.");
	}
})

</script>

<style type="text/css">/* Chart.js */
@keyframes chartjs-render-animation{from{opacity:.99}to{opacity:1}}.chartjs-render-monitor{animation:chartjs-render-animation 1ms}.chartjs-size-monitor,.chartjs-size-monitor-expand,.chartjs-size-monitor-shrink{position:absolute;direction:ltr;left:0;top:0;right:0;bottom:0;overflow:hidden;pointer-events:none;visibility:hidden;z-index:-1}.chartjs-size-monitor-expand>div{position:absolute;width:1000000px;height:1000000px;left:0;top:0}.chartjs-size-monitor-shrink>div{position:absolute;width:200%;height:200%;left:0;top:0}</style>
</head>

<body>

	<%@ include file="../common/header.jsp"%>


	<div id="main">

		<div class="page-heading">
			<div class="page-title">
				<div class="row">
					<div class="col-12 col-md-6 order-md-1 order-last">
						<h3>공개된 모든 프로젝트</h3>
						<p class="text-subtitle text-muted">대시보드입니다.</p>
					</div>
					<div class="col-12 col-md-6 order-md-2 order-first">
						<nav aria-label="breadcrumb"
							class="breadcrumb-header float-start float-lg-end">
						</nav>
					</div>
				</div>
			</div>
			<section class="section">
				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-header">
								<h5 class="card-title">대시보드입니다. </h5>
							</div>
							<div class="card-body">
								대시보드입니다. <a
									href="https://github.com/yunjinchoidev/project5" target="_blank">대시보드입니다.<br><br>
									</a>
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
						<h3>현황</h3>
						<p class="text-subtitle text-muted">현황입니다</p>
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
									<h4 class="card-title">프로젝트 1</h4>
									<p class="card-text">프로젝트1프로젝트1프로젝트1프로젝트1프로젝트1프로젝트1프로젝트1프로젝트1프로젝트1</p>
								</div>
								<img class="img-fluid w-100"
									src="/project5/resources/image/project.png"
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
									<h4 class="card-title">진행사항</h4>
									<p class="card-text">###</p>
								</div>
								<img class="img-fluid w-100"
									src="/project5/resources/image/progress.png"
									alt="Card image cap">
							</div>
							<div class="card-footer d-flex justify-content-between">
								<span>Card Footer</span>
								<button class="btn btn-light-primary">Read More</button>
							</div>
						</div>
						
						
						
						
						
						<div class="card collapse-icon accordion-icon-rotate">
							<div class="card-header">
								<h1 class="card-title pl-1">Accordion</h1>
							</div>
							<div class="card-content">
								<div class="card-body">
									<div class="accordion" id="cardAccordion">
										<div class="card">
											<div class="card-header" id="headingOne"
												data-bs-toggle="collapse" data-bs-target="#collapseOne"
												aria-expanded="false" aria-controls="collapseOne"
												role="button">
												<span class="collapsed collapse-title">Accordion Item
													1</span>
											</div>
											<div id="collapseOne" class="collapse pt-1"
												aria-labelledby="headingOne" data-parent="#cardAccordion">
												<div class="card-body">Cheesecake muffin cupcake
													dragée lemon drops tiramisu cake gummies chocolate cake.
													Marshmallow tart croissant. Tart dessert tiramisu marzipan
													lollipop lemon drops.</div>
											</div>
										</div>
										<div class="card collapse-header">
											<div class="card-header" id="headingTwo"
												data-bs-toggle="collapse" data-bs-target="#collapseTwo"
												aria-expanded="false" aria-controls="collapseTwo"
												role="button">
												<span class="collapsed collapse-title">Accordion Item
													2</span>
											</div>
											<div id="collapseTwo" class="collapse pt-1"
												aria-labelledby="headingTwo" data-parent="#cardAccordion">
												<div class="card-body">Pastry pudding cookie toffee
													bonbon jujubes jujubes powder topping. Jelly beans gummi
													bears sweet roll bonbon muffin liquorice. Wafer lollipop
													sesame snaps.</div>
											</div>
										</div>
										<div class="card open">
											<div class="card-header" id="headingThree"
												data-bs-toggle="collapse" data-bs-target="#collapseThree"
												aria-expanded="true" aria-controls="collapseThree"
												role="button">
												<span class="collapsed collapse-title">Accordion Item
													3</span>
											</div>
											<div id="collapseThree" class="collapse show pt-1"
												aria-labelledby="headingThree" data-parent="#cardAccordion">
												<div class="card-body">Sweet pie candy jelly. Sesame
													snaps biscuit sugar plum. Sweet roll topping fruitcake.
													Caramels liquorice biscuit ice cream fruitcake cotton candy
													tart.</div>
											</div>
										</div>
										<div class="card">
											<div class="card-header" id="headingFour"
												data-bs-toggle="collapse" data-bs-target="#collapseFour"
												aria-expanded="false" aria-controls="collapseFour"
												role="button">
												<span class="collapsed  collapse-title">Accordion
													Item 4</span>
											</div>
											<div id="collapseFour" class="collapse pt-1"
												aria-labelledby="headingFour" data-parent="#cardAccordion">
												<div class="card-body">Sweet pie candy jelly. Sesame
													snaps biscuit sugar plum. Sweet roll topping fruitcake.
													Caramels liquorice biscuit ice cream fruitcake cotton candy
													tart.</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					
					
					
					
					<div class="col-xl-4 col-md-6 col-sm-12">
						<div class="card">
							<div class="card-content">
								<img
									src="/project5/resources/image/project.png"
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
								<img
									src="/project5/resources/image/progress.png"
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
									<h4 class="card-title mb-0">Video Card</h4>
								</div>
								<div
									class="embed-responsive embed-responsive-item embed-responsive-16by9 w-100">
									<iframe src="https://www.youtube.com/embed/2b9txcAt4e0"
										style="width: 100%" height="300" allowfullscreen=""></iframe>
								</div>
								<div class="card-body">
									<p class="card-text">Candy cupcake sugar plum oat cake
										wafer marzipan jujubes. Jelly-o sesame snaps cheesecake
										topping. Cupcake fruitcake macaroon donut pastry gummies
										tiramisu chocolate bar muffin.</p>
									<a href="#" class="card-link">Card link</a> <a href="#"
										class="card-link">Another link</a>
								</div>
							</div>
						</div>
					</div>
					
					
					
					
					
					<div class="col-xl-4 col-md-6 col-sm-12">
						<div class="card">
							<div class="card-content">
								<div class="card-body">
									<h4 class="card-title">Carousel</h4>
									<h6 class="card-subtitle">Support card subtitle</h6>
								</div>
								<div id="carouselExampleSlidesOnly" class="carousel slide"
									data-bs-ride="carousel">
									<div class="carousel-inner">
										<div class="carousel-item">
											<img
												src="/project5/resources/dist/assets/images/samples/architecture1.jpg"
												class="d-block w-100" alt="Image Architecture">
										</div>
										<div class="carousel-item active">
											<img
												src="/project5/resources/dist/assets/images/samples/bg-mountain.jpg"
												class="d-block w-100" alt="Image Mountain">
										</div>
										<div class="carousel-item">
											<img
												src="/project5/resources/dist/assets/images/samples/jump.jpg"
												class="d-block w-100" alt="Image Jump">
										</div>
									</div>
									<a class="carousel-control-prev"
										href="#carouselExampleControls" role="button"
										data-bs-slide="prev"> <span
										class="carousel-control-prev-icon" aria-hidden="true"></span>
										<span class="visually-hidden">Previous</span>
									</a> <a class="carousel-control-next"
										href="#carouselExampleControls" role="button"
										data-bs-slide="next"> <span
										class="carousel-control-next-icon" aria-hidden="true"></span>
										<span class="visually-hidden">Next</span>
									</a>
								</div>
								<div class="card-body">
									<p class="card-text">Lorem ipsum dolor sit amet consectetur
										adipisicing elit. Sunt assumenda mollitia officia dolorum eius
										quasi.Chocolate sesame snaps apple pie danish cupcake sweet
										roll jujubes tiramisu.</p>
									<p class="card-text">Gummies bonbon apple pie fruitcake
										icing biscuit apple pie jelly-o sweet roll. Toffee sugar plum
										sugar plum jelly-o jujubes bonbon dessert carrot cake. Sweet
										pie candy jelly. Sesame snaps biscuit sugar plum. Sweet roll
										topping fruitcake. Caramels liquorice biscuit ice cream
										fruitcake cotton candy tart.</p>
								</div>
							</div>
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
						
						
						<div class="card">
                                <div class="card-header">
                                    <h4 class="card-title">Bar Chart</h4>
                                </div>
                                <div class="card-body"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div>
                                    <canvas id="bar" width="455" height="227" style="display: block; width: 455px; height: 227px;" class="chartjs-render-monitor"></canvas>
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