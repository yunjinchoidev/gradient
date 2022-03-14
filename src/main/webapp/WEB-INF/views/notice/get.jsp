<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>


<script>
	$(document)
			.ready(
					function() {
						var noticekey = "${notice.noticekey}"
						console.log("noticekey : " + noticekey);
						$("#del")
								.click(
										function() {
											confirm("정말 삭제하시겠습니까?");
											location.href = "/project5/noticeDelete.do?noticekey="
													+ noticekey;
										})

						$("#update")
								.click(
										function() {
											confirm("정말 수정하시겠습니까?");
											location.href = "/project5/noticeUpdateForm.do?noticekey="
													+ noticekey;
										})

					})
</script>


<!-- 이부분이 안찍히네요>> 저기  -->
</head>
<body>
	<%@ include file="../common/header.jsp"%>

	<div id="main">
		<section id="multiple-column-form">
			<div class="row match-height">
				<div class="col-12">
					<div class="card">

						<div class="card-header">
							<h4 class="card-title">공지사항</h4>
						</div>



						<div class="card-content">
							<div class="card-body">
								<div class="row">
									<div class="col-md-6 col-12">
										<div class="form-group">
											<label for="first-name-column">공지 제목</label> <input
												type="text" id="first-name-column" class="form-control"
												placeholder="title" name="title" value="${notice.title }"
												readonly="readonly">
										</div>
									</div>
									<div class="col-md-6 col-12">
										<div class="form-group">
											<label for="first-name-column">조회수</label> <input type="text"
												id="first-name-column" class="form-control"
												placeholder="title" name="title" value="${notice.cnt }"
												readonly="readonly">
										</div>
									</div>
									<div class="col-md-6 col-12">
										<div class="form-group">
											<label for="first-name-column">작성자</label> <input type="text"
												id="first-name-column" class="form-control"
												placeholder="title" name="title" value="${notice.name }"
												readonly="readonly">
										</div>
									</div>


									<div class="col-md-6 col-12">
										<div class="form-group">
											<label for="last-name-column">작성일</label> <input
												id="last-name-column" class="form-control"
												readonly="readonly" placeholder="writeDate" name="writeDate"
												value='<fmt:formatDate type="both" value="${notice.writeDate}" />' />
										</div>
									</div>





									<div class="col-md-6 col-12">
										<div class="form-group">
											<label for="city-column">City</label> <input type="text"
												id="city-column" class="form-control" placeholder="City"
												name="city-column">
										</div>
									</div>
									<div class="col-md-6 col-12">
										<div class="form-group">
											<label for="country-floating">Country</label> <input
												type="text" id="country-floating" class="form-control"
												name="country-floating" placeholder="Country">
										</div>
									</div>
									<div class="col-md-6 col-12">
										<div class="form-group">
											<label for="company-column">Company</label> <input
												type="text" id="company-column" class="form-control"
												name="company-column" placeholder="Company">
										</div>
									</div>
									<div class="col-md-6 col-12">
										<div class="form-group">
											<label for="email-id-column">Email</label> <input
												type="email" id="email-id-column" class="form-control"
												name="email-id-column" placeholder="Email">
										</div>
									</div>
									<div class="col-md-6 col-12">
										<div class="form-group">
											<label for="email-id-column">Contents</label>
											<textarea class="form-control" name="content"
												placeholder="content" rows="4" readonly="readonly">${notice.content }</textarea>
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
											style="height: 90%;"
											onclick="location.href='/project5/notice.do'">
											<i class="fas fa-plane"></i> 목록으로
										</button>
										<button type="button" class="btn btn-primary me-1 mb-1"
											id="update">수정하기</button>
										<button type="button"
											class="btn btn-light-secondary me-1 mb-1" id="del">삭제하기</button>
									</div>
								</div>







						
						</div>
					</div>
					
					
					
						<div class='row'>
									<div class="col-lg-12">
										<!-- /.panel -->
										<div class="panel panel-default">
											     <div class="panel-heading">
											<div class="panel-heading">
												<i class="fa fa-comments fa-fw"></i> 댓글 
												<button id='addReplyBtn' class='btn btn-primary btn-xs pull-right'>댓글 달기</button>
													
											</div>
											<!-- /.panel-heading -->
											<div class="panel-body">
												<ul class="chat">
												</ul>
												<!-- ./ end ul -->
											</div>
											<!-- /.panel .chat-panel -->
											<div class="panel-footer"></div>
										</div>
									</div>
									<!-- ./ end row -->
								</div>
							</div>
					
					
					
					
					
					
					
					
					
					
					
				</div>
				
					
			</div>
			
			
			
			
		</section>
		
					<div class="row">
                        <div class="col">
                            <div class="card">
                                <div class="card-header">
                                    댓글
                                </div>
                                <div class="card-body">
                                    <div class="form-floating">
                                        <textarea class="form-control" placeholder="Leave a comment here" id="floatingTextarea"></textarea>
                                        <label for="floatingTextarea">Comments</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
		
		
	</div>






	<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label>Reply</label> <input class="form-control" name='reply'
							value='New Reply!!!!'>
					</div>
					<div class="form-group">
						<label>Replyer</label> <input class="form-control" name='replyer'
							value='replyer'>
					</div>
					<div class="form-group">
						<label>Reply Date</label> <input class="form-control"
							name='replyDate' value='2018-01-01 13:13'>
					</div>

				</div>
				<div class="modal-footer">
					<button id='modalModBtn' type="button" class="btn btn-warning">Modify</button>
					<button id='modalRemoveBtn' type="button" class="btn btn-danger">Remove</button>
					<button id='modalRegisterBtn' type="button" class="btn btn-primary">Register</button>
					<button id='modalCloseBtn' type="button" class="btn btn-default">Close</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->


















</body>
</html>





















<script type="text/javascript" src="/project5/ref/js/reply.js"></script>

<script>
	$(document).ready(function() {
						var noticekeyValue = '<c:out value="${notice.noticekey}"/>';
						var replyUL = $(".chat");

						
						showList(1);

						
						
						
						function showList(page) {
							console.log("show list " + page);
							replyService.getList({noticekey : noticekeyValue,
												page : 1
											},
											function(list) {
												console.log("list: " + list);
												console.log(list);

												if (page == -1) {
													pageNum = Math
															.ceil(replyCnt / 10.0);
													showList(pageNum);
													return;
												}

												var str = "";

												if (list == null
														|| list.length == 0) {
													return;
												}

												for (var i = 0, len = list.length || 0; i < len; i++) {
													str += "<li class='left clearfix' data-rno='"+list[i].rno+"'>";
													str += "  <div><div class='header'><strong class='primary-font'>["
															+ list[i].rno
															+ "] "
															+ list[i].replyer
															+ "</strong>";
													str += "    <small class='pull-right text-muted'>"
															+ replyService
																	.displayTime(list[i].replyDate)
															+ "</small></div>";
													str += "    <p>"
															+ list[i].reply
															+ "</p></div></li>";
												}

												replyUL.html(str);

												showReplyPage(replyCnt);

											});//end function

						}//end showList

						var pageNum = 1;
						var replyPageFooter = $(".panel-footer");

						function showReplyPage(replyCnt) {

							var endNum = Math.ceil(pageNum / 10.0) * 10;
							var startNum = endNum - 9;

							var prev = startNum != 1;
							var next = false;

							if (endNum * 10 >= replyCnt) {
								endNum = Math.ceil(replyCnt / 10.0);
							}

							if (endNum * 10 < replyCnt) {
								next = true;
							}

							var str = "<ul class='pagination pull-right'>";

							if (prev) {
								str += "<li class='page-item'><a class='page-link' href='"
										+ (startNum - 1)
										+ "'>Previous</a></li>";
							}

							for (var i = startNum; i <= endNum; i++) {

								var active = pageNum == i ? "active" : "";

								str += "<li class='page-item "+active+" '><a class='page-link' href='"+i+"'>"
										+ i + "</a></li>";
							}

							if (next) {
								str += "<li class='page-item'><a class='page-link' href='"
										+ (endNum + 1) + "'>Next</a></li>";
							}

							str += "</ul></div>";

							console.log(str);

							replyPageFooter.html(str);
						}

						
						
						
						
						
						
						
						
						
						
						replyPageFooter.on("click", "li a", function(e) {
							e.preventDefault();
							console.log("page click");

							var targetPageNum = $(this).attr("href");

							console.log("targetPageNum: " + targetPageNum);

							pageNum = targetPageNum;

							showList(pageNum);
						});

						/*     function showList(page){
						
						 replyService.getList({bno:bnoValue,page: page|| 1 }, function(list) {
						
						 var str="";
						 if(list == null || list.length == 0){
						
						 replyUL.html("");
						
						 return;
						 }
						 for (var i = 0, len = list.length || 0; i < len; i++) {
						 str +="<li class='left clearfix' data-rno='"+list[i].rno+"'>";
						 str +="  <div><div class='header'><strong class='primary-font'>"+list[i].replyer+"</strong>"; 
						 str +="    <small class='pull-right text-muted'>"+replyService.displayTime(list[i].replyDate)+"</small></div>";
						 str +="    <p>"+list[i].reply+"</p></div></li>";
						 }


						 replyUL.html(str);

						 });//end function
						
						 }//end showList */

						var modal = $(".modal");
						var modalInputReply = modal.find("input[name='reply']");
						var modalInputReplyer = modal
								.find("input[name='replyer']");
						var modalInputReplyDate = modal
								.find("input[name='replyDate']");

						var modalModBtn = $("#modalModBtn");
						var modalRemoveBtn = $("#modalRemoveBtn");
						var modalRegisterBtn = $("#modalRegisterBtn");

						$("#modalCloseBtn").on("click", function(e) {

							modal.modal('hide');
						});

						$("#addReplyBtn").on("click", function(e) {
							modal.find("input").val("");
							modalInputReplyDate.closest("div").hide();
							modal.find("button[id !='modalCloseBtn']").hide();
							modalRegisterBtn.show();
							$(".modal").modal("show");

						});

						modalRegisterBtn.on("click", function(e) {
							var reply = {
								reply : modalInputReply.val(),
								replyer : modalInputReplyer.val(),
								noticekey : noticekeyValue
							};
							replyService.add(reply, function(result) {
								alert(result);
								modal.find("input").val("");
								modal.modal("hide");
								//showList(1);
								showList(-1);

							});

						});

						//댓글 조회 클릭 이벤트 처리 
						$(".chat").on("click","li",
										function(e) {
											var rno = $(this).data("rno");
											replyService.get(
															rno,
															function(reply) {

																modalInputReply
																		.val(reply.reply);
																modalInputReplyer
																		.val(reply.replyer);
																modalInputReplyDate
																		.val(
																				replyService
																						.displayTime(reply.replyDate))
																		.attr(
																				"readonly",
																				"readonly");
																modal
																		.data(
																				"rno",
																				reply.rno);

																modal
																		.find(
																				"button[id !='modalCloseBtn']")
																		.hide();
																modalModBtn
																		.show();
																modalRemoveBtn
																		.show();

																$(".modal")
																		.modal(
																				"show");

															});
										});

						/*     modalModBtn.on("click", function(e){
						
						 var reply = {rno:modal.data("rno"), reply: modalInputReply.val()};
						
						 replyService.update(reply, function(result){
						
						 alert(result);
						 modal.modal("hide");
						 showList(1);
						
						 });
						
						 });

						 modalRemoveBtn.on("click", function (e){
						
						 var rno = modal.data("rno");
						
						 replyService.remove(rno, function(result){
						
						 alert(result);
						 modal.modal("hide");
						 showList(1);
						
						 });
						
						 }); */

						modalModBtn.on("click", function(e) {

							var reply = {
								rno : modal.data("rno"),
								reply : modalInputReply.val()
							};

							replyService.update(reply, function(result) {

								alert(result);
								modal.modal("hide");
								showList(pageNum);

							});

						});

						modalRemoveBtn.on("click", function(e) {

							var rno = modal.data("rno");

							replyService.remove(rno, function(result) {

								alert(result);
								modal.modal("hide");
								showList(pageNum);

							});

						});

					});
</script>


<script>
	console.log("===============");
	console.log("JS TEST");
	console.log("JS TEST");

	var noticekeyValue = '<c:out value="${notice.noticekey}"/>';

	//for replyService add test
	/*
	 replyService.add(
	 {reply:"JS Test", replyer:"tester", noticekey:noticekeyValue}
	 ,
	 function(result){ 
	 alert("추가 성공 RESULT: " + result);
	 }
	 ); 
	 */

	/*
	console.log("getList SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS");
	//reply List Test
	replyService.getList({
	noticekey : 3
	}, function(list) {
	alert("리스트 조회 시도")
	console.log("리스트 조회 시도");
	console.log(list.length)
	for (var i = 0, len = list.length || 0; i < len; i++) {
		console.log(list[i]);
		console.log(list[i]);
	}
	console.log("리스트 조회 종료");

	});
	
	console.log("getList EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE");	
	 */

	//17번 댓글 삭제 테스트 
	/*
	 replyService.remove(1, function(count) {

	 console.log(count);

	 if (count === "success") {
	 alert("삭제 성공 REMOVED");
	 }
	 }, function(err) {
	 alert('삭제 실패 ERROR...');
	 });
	 */

	//12번 댓글 수정 
	/*
	 replyService.update({
	 rno : 12,
	 noticekey:noticekeyValue,
	 reply : "Modified Reply...."
	 }, function(result) {

	 alert("수정 완료...");

	 });  
	 */
</script>


<script type="text/javascript">
	$(document).ready(function() {

		var operForm = $("#operForm");

		$("button[data-oper='modify']").on("click", function(e) {

			operForm.attr("action", "/board/modify").submit();

		});

		$("button[data-oper='list']").on("click", function(e) {

			operForm.find("#bno").remove();
			operForm.attr("action", "/board/list")
			operForm.submit();

		});
	});
</script>

