<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />
<!DOCTYPE html>
<%--


 --%>
<html>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<head>

<!-- 구글 어닐리틱스 -->
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-SKC411JKMD"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'G-SKC411JKMD');
</script>




















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
	<div id="fb-root"></div>
	<script async defer crossorigin="anonymous"
		src="https://connect.facebook.net/ko_KR/sdk.js#xfbml=1&version=v13.0&appId=282186027273418&autoLogAppEvents=1"
		nonce="SuTAbMKi">
		
	</script>
	<%@ include file="chatBot/chatBot.jsp"%>
	<%@ include file="common/header.jsp"%>


	<div id="main">

		<div class="page-heading">
			<div class="page-title">
				<div class="row">
					<div class="col-12 col-md-6 order-md-1 order-last">
							<h1>	안녕하세요?</h1>
						<h3>GRADIENT에 방문하신 여러분을 환영합니다</h3>
						<p class="text-subtitle text-muted"> <br>더  유능하게 <br>더  프로페셔널하게 <br>더 섬세하게</p>
					</div>
					<div class="col-12 col-md-6 order-md-2 order-first">
						<nav aria-label="breadcrumb"
							class="breadcrumb-header float-start float-lg-end"></nav>
					</div>
				</div>
			</div>
		</div>

		<div class="page-heading">
			<div class="page-title">
				<div class="row">
					<div class="col-12 col-md-6 order-md-1 order-last">
						<h3>그래디언트</h3>
						<p class="text-subtitle text-muted">저희는 이렇게 작업합니다.</p>
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

					<div class="col-md-12">
					<div class="card">
                                <div class="card-content">
                                    <img class="card-img-bottom img-fluid" src="/project5/resources/image/roadmap.png" alt="Card image cap" 
                                    style="height: 50rem; object-fit: cover;">
                                </div>
                            </div>
						<div class="card">
                                <div class="card-content">
                                <img class="card-img-bottom img-fluid" src="/project5/resources/image/roadmap2.png" alt="Card image cap" 
                                    style="height: 50rem; object-fit: cover;">
                                    <div class="card-body">
                                        
                                        <h4 class="card-title">우리가 프로젝트를 관리하는 방식</h4>
                                        <hr>
                                          <h2> 프로젝트는 </h2><br>
                                          <h2> 다음과 같은 순서대로 진행됩니다.</h2><br>
                                          <p class="card-text" style="color: black; text-align: left; font-size: 15px; padding-left: 20px;">
                                           1. 프로젝트 시작<br>
                                           	-  PM<br><br>
                                           2. 칸반 보드<br>
                                           	- 프로젝트 범위 조정<br>
                                           	- 요구사항 수립<br><br>
                                           3. 간트차트<br>
                                           	- 한 단계 세분화 된 일정계획 수립<br><br>
                                           4. 예산 관리<br>
                                            - 프로젝트 작업 범위에 걸맞은 예산 계획 수립<br><br>
                                           5. 품질/산출물<br>
                                           	- 요구사항에 맞게 품질의 관리 목표/계획 지정<br>
                                           	- 산출물 점검을 통한 지속적 품질 점검<br><br>
                                           6. 팀 관리<br>
                                            - 실무진 팀 배정 <br><br>
                                           7. 의사소통<br>
                                           	- 회의/채팅<br><br>
                                           8. 리스크 관리 <br>
                                            - 주 단위 조정 작업<br><br>
                                           9. 조달 관리<br>
                                            - 수주사 전달<br><br>
                                           10. 프로젝트 종료<br>
                                            - PM : 프로젝트 종료<br><br>
                                           + 고객센터<br>
                                            - <br><br>
                                        </p>
                                        <p class="card-text">
                                        </p>
                                        <small class="text-muted">Last updated 3 mins ago</small>
                                    </div>
                                
                                </div>
                            </div>
						
						</div>
						
						
						
						
					<div class="col-md-6 col-sm-12">
						<div class="card">
							<div class="card-content">
								<img class="card-img-top img-fluid"
									src="/project5/resources/image/logo.png" alt="Card image cap"
									style="height: 20em; width: 20em;">

								<div class="card-body">
									<h4 class="card-title">왜 그래이언트 인가요?</h4>
									<p class="card-text">왜 그래이언트 인가요?왜 그래이언트 인가요?왜 그래이언트 인가요? 왜
										그래이언트 인가요?왜 그래이언트 인가요?왜 그래이언트 인가요?왜 그래이언트 인가요?왜 그래이언트 인가요? 왜
										그래이언트 인가요?왜 그래이언트 인가요?왜 그래이언트 인가요?왜 그래이언트 인가요?왜 그래이언트 인가요? 왜
										그래이언트 인가요?왜 그래이언트 인가요?왜 그래이언트 인가요?왜 그래이언트 인가요?왜 그래이언트 인가요?</p>
									<p class="card-text">왜 그래이언트 인가요?왜 그래이언트 인가요?왜 그래이언트 인가요?왜
										그래이언트 인가요? 왜 그래이언트 인가요?왜 그래이언트 인가요?왜 그래이언트 인가요?왜 그래이언트 인가요?왜
										그래이언트 인가요? 왜 그래이언트 인가요?왜 그래이언트 인가요?왜 그래이언트 인가요?왜 그래이언트 인가요?왜
										그래이언트 인가요?</p>
									<button class="btn btn-primary block">Update now</button>
								</div>
							</div>
						</div>
					</div>
					<div class="col-md-6 col-sm-12">
						<div class="card">
							<div class="card-content">
								<img class="card-img-top img-fluid"
									src="/project5/resources/image/logo.png" alt="Card image cap"
									style="height: 20em; width: 20em;">

								<div class="card-body">
									<h4 class="card-title">왜 그래이언트 인가요?</h4>
									<p class="card-text">왜 그래이언트 인가요?왜 그래이언트 인가요?왜 그래이언트 인가요? 왜
										그래이언트 인가요?왜 그래이언트 인가요?왜 그래이언트 인가요?왜 그래이언트 인가요?왜 그래이언트 인가요? 왜
										그래이언트 인가요?왜 그래이언트 인가요?왜 그래이언트 인가요?왜 그래이언트 인가요?왜 그래이언트 인가요? 왜
										그래이언트 인가요?왜 그래이언트 인가요?왜 그래이언트 인가요?왜 그래이언트 인가요?왜 그래이언트 인가요?</p>
									<p class="card-text">왜 그래이언트 인가요?왜 그래이언트 인가요?왜 그래이언트 인가요?왜
										그래이언트 인가요? 왜 그래이언트 인가요?왜 그래이언트 인가요?왜 그래이언트 인가요?왜 그래이언트 인가요?왜
										그래이언트 인가요? 왜 그래이언트 인가요?왜 그래이언트 인가요?왜 그래이언트 인가요?왜 그래이언트 인가요?왜
										그래이언트 인가요?</p>
									<button class="btn btn-primary block">Update now</button>
								</div>
							</div>
						</div>
					</div>









































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
									src="/project5/resources/image/logo.png" alt="Card image cap">
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
									src="/project5/resources/image/logo.png" alt="Card image cap">
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
								<img src="/project5/resources/image/logo.png"
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
									src="/project5/resources/image/logo.png" alt="Card image cap">
							</div>
							<div class="card-footer d-flex justify-content-between">
								<span>Card Footer</span>
								<button class="btn btn-light-primary">Read More</button>
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
												<div class="card-body">
													<a>
														<h1>메인페이지 입니다.</h1>
														<h3>Gradient가 어떠셨습니까?</h3>
														<hr>
													</a>
													<!-- 페이스북 댓글api -->
													<!-- 댓글 들어가는 부분 -->
													<div class="fb-comments"
														data-href="http://106.10.16.155:7080/project5/main.do"
														data-width="1400" data-numposts="5"
														style="width: 100%; margin: 30px;"></div>
														
														
														
														<div id="disqus_thread"></div>
															<script>
															    /**
															    *  RECOMMENDED CONFIGURATION VARIABLES: EDIT AND UNCOMMENT THE SECTION BELOW TO INSERT DYNAMIC VALUES FROM YOUR PLATFORM OR CMS.
															    *  LEARN WHY DEFINING THESE VARIABLES IS IMPORTANT: https://disqus.com/admin/universalcode/#configuration-variables    */
															    /*
															    var disqus_config = function () {
															    this.page.url = PAGE_URL;  // Replace PAGE_URL with your page's canonical URL variable
															    this.page.identifier = PAGE_IDENTIFIER; // Replace PAGE_IDENTIFIER with your page's unique identifier variable
															    };
															    */
															    (function() { // DON'T EDIT BELOW THIS LINE
															    var d = document, s = d.createElement('script');
															    s.src = 'https://gradient-1.disqus.com/embed.js';
															    s.setAttribute('data-timestamp', +new Date());
															    (d.head || d.body).appendChild(s);
															    })();
															</script>
															<noscript>Please enable JavaScript to view the <a href="https://disqus.com/?ref_noscript">comments powered by Disqus.</a></noscript>
														</div>
												
												
												
												
											</div>
										</div>
									</div>
								</section>








				</div>
			</section>
			<!-- Basic Card types section end -->

		</div>

	</div>

<script id="dsq-count-scr" src="//gradient-1.disqus.com/count.js" async></script>
</body>

</html>