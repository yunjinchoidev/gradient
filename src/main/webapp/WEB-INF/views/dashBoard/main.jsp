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
<title>쌍용 5조 PMBOK 대시보드</title>
<style>
iframe { 
    zoom:500%;
    }
</style>


<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
    <link rel="stylesheet" href="/project5/jqwidgets-ver13.2.0/jqwidgets/styles/jqx.base.css" type="text/css" />
    <script type="text/javascript" src="/project5/jqwidgets-ver13.2.0/scripts/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="/project5/jqwidgets-ver13.2.0/jqwidgets/jqxcore.js"></script>
    <script type="text/javascript" src="/project5/jqwidgets-ver13.2.0/jqwidgets/jqxsortable.js"></script>
    <script type="text/javascript" src="/project5/jqwidgets-ver13.2.0/jqwidgets/jqxkanban.js"></script>
    <script type="text/javascript" src="/project5/jqwidgets-ver13.2.0/jqwidgets/jqxdata.js"></script>
    <script  src="http://code.jquery.com/jquery-latest.min.js"></script>
    
    
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





    
    <script type="text/javascript">
    $(document).ready(function () {            
    	// 칸반보드 전체 값 저장할 변수 선언
	    var nice;
	    // 칸반보드 전체 값 객체 배열로 가져오기
   		 $.ajax({
         		  type:"post",
         		  url:"/project5/kanbanList.do",
         		 async:false,
         		  dataType:"json",
         		  success:function(data){
         			console.log("조회성공");
         			console.log("결과물이 이것 " +data.list);
         			for(idx in data.list){
             			 console.log("idx: " + idx + "data.list[idx]: " + data.list[idx]);
         			 };
         			 nice = data.list;
         		  },
         		  error:function(err){
         			  console.log("실패")
         			  console.log(err)
         			  failureCallback(err);
         			  document.getElementById('script-warning').style.display = 'block';
         		  }
         	 	});
    	
    	
    	
   	    /*	   
    	    var gogogo= [
                { id: "1161", state: "new", label: "Combine Orders", tags: "orders, combine", hex: "#5dc3f0", resourceId: 3 },
                { id: "9037", state: "new", label: "new4", tags: "issue, login", hex: "#6bbd49", resourceId: 8}];
    	  */  
    	   
    		 console.log("nice"+nice);
     	   //  화면단에 뿌려주기
     	    var source =
     	     {
     	         localData: nice,
     	         dataType: "array",
     	         dataFields: fields
     	     };
     	   
    });

</script>
</head>

<body>

	<%@ include file="../common/header.jsp"%>


	<div id="main">

		<div class="page-heading">
			<div class="page-title">
				<div class="row">
					<div class="col-12 col-md-6 order-md-1 order-last">
						<h3>대시보드</h3>
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
									<h4 class="card-title">리스크 관리</h4>
									<p class="card-text">이곳에서 리스크 관리를 하겠습니다.이곳에서 리스크 관리를 하겠습니다.이곳에서 리스크 관리를 하겠습니다.이곳에서 리스크 관리를 하겠습니다.이곳에서 리스크 관리를 하겠습니다.이곳에서 리스크 관리를 하겠습니다.이곳에서 리스크 관리를 하겠습니다.이곳에서 리스크 관리를 하겠습니다.</p>
								</div>
								<img class="img-fluid w-100"
									src="/project5/resources/image/risk.png"
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
									<h4 class="card-title">예산 관리</h4>
									<p class="card-text">이곳에서 예산 관리를 하겠습니다.이곳에서 예산 관리를 하겠습니다.
									이곳에서 예산 관리를 하겠습니다.이곳에서 예산 관리를 하겠습니다.이곳에서 예산 관리를 하겠습니다.
									이곳에서 예산 관리를 하겠습니다.이곳에서 예산 관리를 하겠습니다.이곳에서 예산 관리를 하겠습니다.</p>
								</div>
								<img class="img-fluid w-100"
									src="/project5/resources/image/burget.png"
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
									<h4 class="card-title">조달 관리</h4>
									<p class="card-text">이곳에서 조달 관리를 하겠습니다. 이곳에서 조달 관리를 하겠습니다. 이곳에서 조달 관리를 하겠습니다. 이곳에서 조달 관리를 하겠습니다. 
									이곳에서 조달 관리를 하겠습니다. 이곳에서 조달 관리를 하겠습니다. 이곳에서 조달 관리를 하겠습니다. 이곳에서 조달 관리를 하겠습니다. 이곳에서 조달 관리를 하겠습니다. 
									이곳에서 조달 관리를 하겠습니다. 이곳에서 조달 관리를 하겠습니다. 이곳에서 조달 관리를 하겠습니다. 이곳에서 조달 관리를 하겠습니다. 이곳에서 조달 관리를 하겠습니다. </p>
								</div>
								<img class="img-fluid w-100"
									src="/project5/resources/image/support.png"
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
								<img
									src="/project5/resources/image/output.png"
									class="card-img-top img-fluid" alt="singleminded">
								<div class="card-body">
									<h5 class="card-title">산출물 관리</h5>
									<p class="card-text">산출물 관리 산출물 관리 산출물 관리 산출물 관리 
									산출물 관리 산출물 관리 산출물 관리 산출물 관리 산출물 관리 산출물 관리 
									산출물 관리 산출물 관리 산출물 관리 산출물 관리 산출물 관리 산출물 관리 
										</p>
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
									src="/project5/resources/image/quality.png"
									class="card-img-top img-fluid" alt="singleminded">
								<div class="card-body">
									<h5 class="card-title">품질 관리</h5>
									<p class="card-text">품질 관리 품질 관리 품질 관리 품질 관리
									품질 관리 품질 관리 품질 관리 품질 관리 품질 관리 품질 관리 품질 관리
									품질 관리 품질 관리 품질 관리 품질 관리 품질 관리 품질 관리 품질 관리
										</p>
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
									src="/project5/resources/image/human.png"
									class="card-img-top img-fluid" alt="singleminded">
								<div class="card-body">
									<h5 class="card-title">인적 관리</h5>
									<p class="card-text">인적 관리 인적 관리 인적 관리 
									인적 관리 인적 관리 인적 관리 인적 관리 인적 관리 인적 관리 
									인적 관리 인적 관리 인적 관리 인적 관리 인적 관리 인적 관리 
									인적 관리 인적 관리 인적 관리 인적 관리 인적 관리 인적 관리 
										</p>
								</div>
							</div>
							<ul class="list-group list-group-flush">
								<li class="list-group-item">Cras justo odio</li>
								<li class="list-group-item">Dapibus ac facilisis in</li>
								<li class="list-group-item">Vestibulum at eros</li>
							</ul>
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
												src="/project5/resources/images/notice.jpg"
												class="d-block w-100" alt="Image Architecture">
										</div>
										<div class="carousel-item active">
											<img
												src="/project5/resources/image/notice.png"
												class="d-block w-100" alt="Image Mountain">
										</div>
										<div class="carousel-item">
											<img
												src="/project5/resources/image/progress.png"
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
					</div>
					<div class="col-md-6 col-sm-12">
						<div class="card">
							<div class="card-content">
								<img class="card-img-top img-fluid"
									src="/project5/resources/image/calendar.png"
									alt="Card image cap" style="height: 40rem">
								<div class="card-body">
									<h4 class="card-title">캘린더</h4>
									<p class="card-text">Jelly-o sesame snaps cheesecake
										topping. Cupcake fruitcake macaroon donut pastry gummies
										tiramisu chocolate bar muffin. Dessert bonbon caramels brownie
										chocolate bar chocolate tart dragée.</p>
									<p class="card-text">Cupcake fruitcake macaroon donut
										pastry gummies tiramisu chocolate bar muffin.</p>
									<button class="btn btn-primary block">Update now</button>
									<iframe src="/project5/calendar.do?memberkey=${member.memberkey }" style="width:100%; height: 100%; border : 3px solid black;">
										</iframe>
								</div>
							</div>
						</div>
					</div>
					<div class="col-md-6 col-sm-12">
						<div class="card">
							<div class="card-content">
								<div class="card-body">
									<h4 class="card-title">간트차트</h4>
									<p class="card-text">Jelly-o sesame snaps cheesecake
										topping. Cupcake fruitcake macaroon donut pastry gummies
										tiramisu chocolate bar muffin. Dessert bonbon caramels brownie
										chocolate bar chocolate tart dragée.</p>
									<p class="card-text">Cupcake fruitcake macaroon donut
										pastry gummies tiramisu chocolate bar muffin.</p>
									<small class="text-muted">Last updated 3 mins ago</small>
								</div>
								<img class="card-img-bottom img-fluid"
									src="/project5/resources/image/gantte.png"
									alt="Card image cap" style="height: 20rem; object-fit: cover;">
							</div>
						</div>
					</div>
					
					
					
					<div class="col-md-6 col-sm-12" style="border : 3px solid black; width:100%;">
						<div class="card" style="border : 3px solid black; width : 100%">
							<div class="card-content">
								<div class="card-body">
									<h1 class="card-title">칸반보드</h1>
									<iframe src="/project5/kanbanMain2.do" style="width:100%; height: 80%; border : 3px solid black;">
										</iframe>
									
									
									<p class="card-text">Jelly-o sesame snaps cheesecake
										topping. Cupcake fruitcake macaroon donut pastry gummies
										tiramisu chocolate bar muffin. Dessert bonbon caramels brownie
										chocolate bar chocolate tart dragée.</p>
									<p class="card-text">Cupcake fruitcake macaroon donut
										pastry gummies tiramisu chocolate bar muffin.</p>
									<small class="text-muted">Last updated 3 mins ago</small>
								</div>
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