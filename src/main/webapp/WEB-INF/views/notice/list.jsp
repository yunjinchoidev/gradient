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
<title>GRADIENT - 공지사항</title>
</head>
<script>
	$(document).ready(function() {
		
					var psc = "${psc}";
					if (psc == "write") {
						alert("공지사항 작성이 완료되었습니다.");
					}
					if (psc == "delete") {
						alert("공지사항 삭제가 완료되었습니다.");
					}
					if (psc == "update") {
						alert("공지사항 수정이 완료되었습니다.");
					}
					if (msg == "updateForm") {
						location.href = "/project5/notice.do";
					}


					console.log("psc : " + psc);
					var name = "${member.name}"
					console.log("member.name : " + name);
		
					$("#write").click(function() {
						if (name == "") {
							alert("접근 권한이 없습니다.")
						} else {
							location.href = "/${path}/noticeWriteForm.do";
						}
					})
		
					
					
					// 한 화면에서 몇 개씩 볼 것인지 생각해봅시다.		
					var pageSize = "${noticeSch.pageSize}"
					$("[name=pageSize]").val(pageSize); 

		
		
						$("[name=pageSize]").change(function() {
							$("[name=curPage]").val(1);
							$("#frm01").submit();
						});

						/*
						$.ajax({
						 url: '//noticeAttachFileInfo.do',
						 processData: false, 
						 contentType: false,
						 data: noticekey,
						 type: 'POST',
						 dataType:'json',
						   success: function(result){
						     console.log(result); 
						  showUploadResult(result);//////////////////////////////////////////////////////////////////////// 이곳에서 함수 호출 
						 },
						 error: function(result){
						     console.log(result); 
						  console.log("실패")
						 }
						}); //$.ajax
						 */

						function showUploadResult(uploadResultArr) {
							if (!uploadResultArr || uploadResultArr.length == 0) {
								return;
							}
							var uploadUL = $("#uploadImg");
							var str = "";
							$(uploadResultArr)
									.each(
											function(i, obj) {
												if (obj.fileType) {
													var fileCallPath = encodeURIComponent(obj.uploadPath
															+ "/"
															+ obj.uuid
															+ "_"
															+ obj.fileName);
													str += "<img src='/${path}/display.do?fileName="
															+ fileCallPath
															+ "' style='width:50px; height:50px;'>";
												} else {
													var fileCallPath = encodeURIComponent(obj.uploadPath
															+ "/"
															+ obj.uuid
															+ "_"
															+ obj.fileName);
													var fileLink = fileCallPath
															.replace(
																	new RegExp(
																			/\\/g),
																	"/");

													str += "<li "
						str += "data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"' ><div>";
													str += "<span> "
															+ obj.fileName
															+ "</span>";
													str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' " 
						str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
													str += "<img src='/${path}/resources/img/attach.png'></a>";
													str += "</div>";
													str + "</li>";
												}
											});
							uploadUL.append(str);
						}
					})

					
					
					
					
					function goPage(no) {
						 // 현재 페이지에 입력한 no를 대입함으로써 페이지 이동 처리!
						$("[name=curPage]").val(no);
						$("#frm01").submit();
					}
	
	
	
	
	
	
</script>




<body>
<%@ include file="../chatBot/chatBot.jsp"%>
	<%@ include file="../common/header.jsp"%>
	<div id="main">

		<div class="page-heading">
			<div class="page-title">
				<div class="row">
					<div class="col-12 col-md-6 order-md-1 order-last">
						<h3 onclick="location.href='/project5/notice.do'" style="cursor: pointer;">공지사항</h3>
						<p class="text-subtitle text-muted">주기적으로 확인해주세요</p>
					</div>
					<div class="col-12 col-md-6 order-md-2 order-first">
						<nav aria-label="breadcrumb"
							class="breadcrumb-header float-start float-lg-end">
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="index.html">Dashboard</a></li>
								<li class="breadcrumb-item active" aria-current="page">DataTable</li>
							</ol>
						</nav>
					</div>
				</div>
			</div>

	
				
				<section class="section">
					<div class="card">
						<div class="card-header"></div>
						<div class="card-body">
							<div	class="dataTable-wrapper dataTable-loading no-footer sortable searchable 
							fixed-columns">

							<!--  이곳에서 한 화면에서 몇 페이지를 볼 지 보내줍니다. -->
							<form id="frm01" class="form" action="/project5/notice.do">
							<input type="hidden" name="curPage" value="1" />
								<div class="dataTable-top">
									<div class="dataTable-dropdown">
										<span class="input-group-text" style="margin-right: 10px;">총
											${noticeSch.count}건</span> <span class="input-group-text">페이지
											크기</span> <select class="dataTable-selector form-select"
											name="pageSize">
											<option value="3" selected>3</option>
											<option value="5">5</option>
											<option value="10" >10</option>
											<option value="15">15</option>
											<option value="20">20</option>
											<option value="25">25</option>
										</select><label>한 화면당 페이지 수</label>
									</div>
									<div class="dataTable-search" style="display: inline-block;">
										<div style="display: inline-block;">
											<select class="dataTable-selector form-select searchbar"
												name="searchbar" style="display: inline-block;">
												<option selected="selected">검색</option>
												<option value="title" selected="selected">title</option>
												<option value="contents">contents</option>
											</select>
										</div>
										<div style="display: inline-block;">
											<input style="display: inline-block;"
												class="dataTable-input searchWhat" placeholder="검색어를 입력"
												type="text" name="title" value="${noticeSch.title}">
											<button class="btn btn-info" type="submit">검색</button>
											<a href="${path }/noticeWriteForm.do" class="btn btn-danger"
												id="write" style="text-align: right">글쓰기</a>
										</div>
									</div>
								</div>
							</form>







							<div class="dataTable-container">					
				<table class="table table-striped dataTable-table" id="table1">
							<thead>
								<tr>
									<th data-sortable="" style="width: 6.0176%;"><a href="#"
										class="dataTable-sorter">번호</a>
									<th data-sortable="" style="width: 42.9989%;"><a href="#"
										class="dataTable-sorter" style="padding-left: 20px;">제목</a></th>
									<th data-sortable="" style="width: 18.0816%;"><a href="#"
										class="dataTable-sorter">작성일</a></th>
									<th data-sortable="" style="width: 8.3175%;"><a href="#"
										class="dataTable-sorter">조회수</a></th>
									<th data-sortable="" style="width: 8%;"><a href="#"
										class="dataTable-sorter">작성자</a></th>
								</tr>
							</thead>

							<tbody>
								<c:forEach var="list" items="${list}">
									<tr style="cursor: pointer;"
										onclick="location.href='/project5/noticeGet.do?noticekey='+${list.noticekey}">
										<td>${list.noticekey }${list.level}</td>
										<td style="text-align: left">
										<c:forEach varStatus="sts"
												begin="1" end="${list.level}">
													    				&nbsp;&nbsp;
													  <c:if test="${list.level>1 and sts.last }">
														<img width="25" height="15" src="${path}/a02_img/reply1.PNG" />
													 </c:if>
									<%-- level 만큼 공백을 넣고, 마지막(sts.last)에 답글이미지 삽입  --%>
											</c:forEach> ${list.title }
											</td>
											
										<td><fmt:formatDate value="${list.writeDate }"/></td>
										<td>${list.views }</td>
										<td>${list.name }</td>
									</tr>
								</c:forEach>
							</tbody>
				</table>
			</div>






			<div class="dataTable-bottom">
				
				<!--  페이지 쪽 부분을 볼 수 있는 곳 -->
				<!-- class="page-item active" -->
				<ul class="pagination  justify-content-end">
					<li class="page-item">
					<a class="page-link" href="javascript:goPage(${noticeSch.startBlock!=1?noticeSch.startBlock-1:1})"">Previous</a></li>
					<c:forEach var="cnt" begin="${noticeSch.startBlock}" end="${noticeSch.endBlock}">
						<li class="page-item ${cnt==noticeSch.curPage?'active':''}">
							<!-- 클릭한 현재 페이지 번호 --> 
							<a class="page-link" href="javascript:goPage(${cnt})">
								${cnt}
							</a>
						</li>
					</c:forEach>
					<li class="page-item">
					<a class="page-link" href="javascript:goPage(${noticeSch.endBlock!=noticeSch.pageCount?noticeSch.endBlock+1:noticeSch.endBlock})">Next</a></li>
					<!-- 다음 block의 리스트는 현재 블럭의 마지막 번호 +1 
					  	   마지막 블럭이 총페이지수일 때는 다음 블럭이 없기 때문에 그대로 두고
					  	   다음 블럭이 있을 때만 카운트 되게 
	 					 -->
				</ul>

			</div>
		</div>
	</div>
	</div>

	</section>
	</div>

	</div>
</body>
</html>