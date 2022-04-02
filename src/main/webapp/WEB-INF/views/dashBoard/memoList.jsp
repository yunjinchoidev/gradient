<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />





<!DOCTYPE html>
<html lang="en">





<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>쌍용 5조 PMBOK</title>

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


</head>

<script>
$(document).ready(function(){
	
	
	
	var msg = "${msg}";
	if(msg!=""){
		if(confirm(msg+"\n메인화면으로 이동할까요?")){
			location.href="${path}/memoList.do";
		}
	}
	
	
	
	
	
	
	var pageSize="${memoSch.pageSize}"
		$("[name=pageSize]").val(pageSize);
		$("[name=pageSize]").change(function(){
			$("[name=curPage]").val(1);
			$("#frm01").submit();
		});	
		
		if( $("psc")=="memoDelete"){
			alert("메모가 정상적으로 삭제 되었습니다.")
		}
		
		
		
});

		function goPage(no){
			$("[name=curPage]").val(no);
			$("#frm01").submit();
		}
		
		
</script>


<body>
	<!--  메모장 -->
	<div class="card">
		<div class="card-header">
			<h4>
				[<span style="color: red">${member.name } </span>]님 만을 위한 메모장
			</h4>
		</div>
		<div class="card-body">


			<form id="frm01" class="form" action="${path}/memoList.do"
				method="post">
				<div class="dataTable-wrapper dataTable-loading no-footer sortable searchable fixed-columns">
					<div class="dataTable-top">
						<div class="input-group-prepend">
							<input type="hidden" name="curPage" value="1" /> <span
								class="input-group-text">총 ${memoSch.count}건</span>
						</div>
						
						<div class="dataTable-dropdown">
							<select class="dataTable-selector form-select" name="pageSize">
								<option value="3">3</option>
								<option value="5">5</option>
								<option value="10" selected="selected">10</option>
								<option value="15">15</option>
								<option value="20">20</option>
								<option value="25">25</option>
							</select><label>entries per page</label>
						</div>
						
						
						<script>
						$(document).ready(function(){
							$( ".searchbar" ).change(function() {
								  alert( "검색 종류를 변경합니다." );
								  $(".searchWhat").attr("name", this.value)
								  alert($(".searchWhat").value)
						 });
						
						});
						
						</script>
						
						
						
						<div class="dataTable-search" style="display: inline-block; ">
							
							<div style="display: inline-block;" >
								<select class="dataTable-selector form-select searchbar" 
								name="searchbar" style="display: inline-block; ">
										<option selected="selected">검색</option>
										<option value="title" selected="selected">title</option>
										<option value="contents">contents</option>
								</select>
								</div>
								
								<div style="display: inline-block;" >
								<input style="display: inline-block; " class="dataTable-input searchWhat" placeholder="검색어를 입력" type="text"
									name="title" value="${memoSch.title}"> 
								  <button class="btn btn-info" type="submit">검색</button>
								<a class="btn btn-danger" style="text-align: right"
								data-bs-toggle="modal" data-bs-target="#inlineForm">메모 쓰기</a>
								</div>
						</div>
						
						
						
					</div>
					</div>
			</form>









			<div class="dataTable-container">
				<table class="table table-striped dataTable-table" id="table1">
					<thead>
						<tr>
							<th data-sortable="" style="width: 12.0176%;"><a href="#"
								class="dataTable-sorter">메모 번호</a></th>
							<th data-sortable="" style="width: 18.9989%;"><a href="#"
								class="dataTable-sorter">메모 명</a></th>
							<th data-sortable="" style="width: 42.0816%;"><a href="#"
								class="dataTable-sorter">메모내용</a></th>
							<th data-sortable="" style="width: 16.3175%;"><a href="#"
								class="dataTable-sorter">작성일</a></th>
							<th data-sortable="" style="width: 10.8049%;"><a href="#"
								class="dataTable-sorter">중요도</a></th>
						</tr>
					</thead>

					<tbody>
						<c:forEach var="list" items="${list}">
							<tr>
								<td>${list.memokey}</td>
								<td style="cursor: pointer;">${list.title }
									<span class="badge bg-danger" id="delBtn"
									onclick="location.href='/project5/memoDelete.do?memokey=${list.memokey}'">
									삭제</span>
								</td>
								<td>${list.contents }</td>
								<td><fmt:formatDate value="${list.writedate }" /></td>
								<td style="cursor: pointer;"><c:if
										test="${list.importance eq '하'}">
										<span class="badge bg-primary importance22">하</span>
									</c:if> <c:if test="${list.importance eq '중'}">
										<span class="badge bg-secondary importance22">중</span>
									</c:if> <c:if test="${list.importance eq '상'}">
										<span class="badge bg-danger importance22">상</span>
									</c:if></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>

			<script>
										$(document).ready(function(){
											$("#delBtn").click(function(){
												confirm("정말 삭제 하시겠습니까?")
											})
											 var a=0;
											
											 setInterval(function() {
												 a++;
													if(a%2==0){
														$(".importance22").css("display","none");
													}else{
														$(".importance22").css("display","");
													}
											}, 1000);
											
										})
										
										
										</script>




			<div class="dataTable-bottom">
				<div class="dataTable-info">Showing 1 to 10 of 26 entries</div>

				<ul class="pagination  justify-content-end">
					<li class="page-item"><a class="page-link"
						href="javascript:goPage(${memoSch.startBlock!=1?memoSch.startBlock-1:1})">Previous</a></li>
					<c:forEach var="cnt" begin="${memoSch.startBlock}"
						end="${memoSch.endBlock}">
						<li class="page-item ${cnt==memoSch.curPage?'active':''}">
							<!-- 클릭한 현재 페이지 번호 --> <a class="page-link"
							href="javascript:goPage(${cnt})">${cnt}</a>
						</li>
					</c:forEach>
					<li class="page-item"><a class="page-link"
						href="javascript:goPage(${memoSch.endBlock!=memoSch.pageCount?memoSch.endBlock+1:memoSch.endBlock})">Next</a></li>
				</ul>


			</div>
		</div>
	</div>





















	<!-- 메모 모달 -->



	<script
		src="/project5/resources/dist/assets/vendors/perfect-scrollbar/perfect-scrollbar.min.js"></script>
	<script
		src="/project5/resources/dist/assets/js/bootstrap.bundle.min.js"></script>
	<script
		src="/project5/resources/dist/assets/vendors/simple-datatables/simple-datatables.js"></script>
	<script src="/project5/resources/dist/assets/js/main.js"></script>

	<!--login form Modal -->
	<div class="modal fade text-left" id="inlineForm" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel33" aria-hidden="true">
		<div
			class="modal-dialog modal-dialog-centered modal-dialog-scrollable"
			role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="myModalLabel33">메모 쓰기</h4>
					<button type="button" class="close" data-bs-dismiss="modal"
						aria-label="Close">
						<i data-feather="x"></i>
					</button>
				</div>
				<form action="/project5/memoInsert.do" >
					<input type="hidden" name="memberkey" value="${member.memberkey }">
					<input type="hidden" name="projectkey" value="1">
					<div class="modal-body">

						<label>중요도: </label>
						<div class="form-group">
							<select class="form-control" name="importance">
								<option value="상">상</option>
								<option value="중">중</option>
								<option value="하">하</option>
							</select>
						</div>

						<label>제목: </label>
						<div class="form-group">
							<input type="text" name="title" class="form-control">
						</div>

						<label>내용: </label>
						<div class="form-group">
							<input type="text" name="contents" class="form-control">
						</div>
					</div>

					<div class="modal-footer">
						<button type="button" class="btn btn-light-secondary"
							data-bs-dismiss="modal">
							<i class="bx bx-x d-block d-sm-none"></i> <span
								class="d-none d-sm-block">닫기</span>
						</button>
						<button type="submit" class="btn btn-danger ml-2">
							<i class="bx bx-check d-block d-sm-none"></i> <span
								class="d-none d-sm-block">작성완료</span>
						</button>
					</div>
				</form>
			</div>
		</div>
	</div>

</body>
</html>