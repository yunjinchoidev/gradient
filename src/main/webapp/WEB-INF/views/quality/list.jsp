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
<title>Insert title here</title>
</head>

<body>

<%@ include file="../chatBot/chatBot.jsp"%>
	<%@ include file="../common/header.jsp"%>
	<div id="main">

		<div class="page-heading">
			<div class="page-title">
				<div class="row">

					<%@ include file="../projectHome/sort.jsp" %>


					<div class="col-12 col-md-6 order-md-1 order-last">
						<h3 onclick="location.href='/project5/qualityList.do'" style="cursor: pointer;">품질 건의</h3>
						<p class="text-subtitle text-muted">For user to check they
							list</p>
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
					<div class="card-header">
					<a href="/project5/qualityList.do" class="btn btn-warning">품질 건의</a>
					<a href="/project5/evalitem.do" class="btn btn-primary">품질 평가 항목</a>
					<a href="#" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#evalModal">품질 평가</a>
					<a href="${path}/certiprj.do" class="btn btn-success">인증서 발급</a>	
					</div>
					<div class="card-body">
						<div
							class="dataTable-wrapper dataTable-loading no-footer sortable searchable fixed-columns">
							
							<!--  이곳에서 한 화면에서 몇 페이지를 볼 지 보내줍니다. -->
							<form id="frm01" class="form" action="/project5/qualityList.do">
								<div class="dataTable-top">
									<div class="dataTable-dropdown">
										<span class="input-group-text" style="margin-right: 10px;">총 ${qualitySch.count}건</span> <span
											class="input-group-text">페이지 크기</span> 
											<select class="dataTable-selector form-select" name="pageSize">
											<option value="5">5</option>
											<option value="10" selected>10</option>
											<option value="15">15</option>
											<option value="20">20</option>
											<option value="25">25</option></select><label>한 화면당 페이지 수</label>
									</div>
								

							</div>
							<div class="dataTable-container">
								<table class="table table-striped dataTable-table" id="table1">
									<thead>
										<tr>
											<th data-sortable="" style="width: 20%;"><a href="#"
												class="dataTable-sorter">품질평가</a></th>
											<th data-sortable="" style="width: 40%;"><a href="#"
												class="dataTable-sorter">프로젝트명</a></th>
											<th data-sortable="" style="width: 20%;"><a href="#"
												class="dataTable-sorter">작성일</a></th>
											<th data-sortable="" style="width: 20%;"><a href="#"
												class="dataTable-sorter">담당자</a></th>

										</tr>
									</thead>




									<tbody>
										<c:forEach var="list" items="${list}">
											<tr
											onclick="location.href='/project5/qualityInsert.do?qualitykey='+${list.qualitykey}"
												>
												<td>${list.qualitykey }</td>
												<td onclick="locaion.href='/project5/qualityInsert.do?qualitykey='+${list.qualitykey}">${list.title }</td>
												<td>${list.writedate }</td>
												<td>${member.name}</td>
												<td><span class="badge bg-success">Active</span></td>
											</tr>
										</c:forEach>
								</table>
									</tbody>

										<div style=text-align:center>
										<a href="/project5/qualityInsertFrom.do" class="btn btn-primary"
											id="write" style="text-align: right">등록</a>
										</div>
									
							</div>




	<!-- class="page-item active" -->
				<ul class="pagination  justify-content-end">
					<li class="page-item"><a class="page-link"
						href="javascript:goPage(${qualitySch.startBlock!=1?qualitySch.startBlock-1:1})"">Previous</a></li>
					<c:forEach var="cnt" begin="${qualitySch.startBlock}"
						end="${qualitySch.endBlock}">
						<li class="page-item ${cnt==qualitySch.curPage?'active':''}">
							<!-- 클릭한 현재 페이지 번호 --> <a class="page-link"
							href="javascript:goPage(${cnt})">${cnt}</a>
						</li>
					</c:forEach>
					<li class="page-item"><a class="page-link"
						href="javascript:goPage(${qualitySch.endBlock!=qualitySch.pageCount?qualitySch.endBlock+1:qualitySch.endBlock})">Next</a></li>
					<!-- 다음 block의 리스트는 현재 블럭의 마지막 번호 +1 
	  	   마지막 블럭이 총페이지수일 때는 다음 블럭이 없기 때문에 그대로 두고
	  	   다음 블럭이 있을 때만 카운트 되게 
	  -->
				</ul>













					
					</div>
				</div>

			</section>


		</div>

	</div>

<!-- 품질평가 Modal ==장훈주 start== -->
  	<div class="modal fade text-left" id="evalModal" tabindex="-1" role="dialog"
       	aria-labelledby="myModalLabel33" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-lg" role="document">
        <div class="modal-content" style="overflow:auto;">
            <div class="modal-header">
                <h4 class="modal-title" id="myModalLabel33">품질평가</h4>
                <button type="button" class="close" data-bs-dismiss="modal"
                    aria-label="Close">
                    <i data-feather="x"></i>
                </button>
            </div>
          
            	<!-- 모달 입력 요소 영역 -->
            <form id="qualityevalFrm" action="${path}/qualitypass.do" method="get">
                <div class="modal-body" style="margin:10px;">
                	<!-- 프로젝트 select box -->
                	<div id="prjselect">
                    	<select class="form-select" style="text-align:center;" name="prjkey">
                    		<c:forEach var="prlist" items="${prjlist}">
                    			<option value="${prlist.prjkey}">${prlist.prjname}</option>
                    		</c:forEach>
                    	</select>
                    </div>
                    <!-- 품질 체크 항목 -->
                    <div style="margin-top: 50px;">
                    	<!-- 1번문항 -->
                    	<c:forEach var="eval" items="${evallist}">
                    	  <c:set var="i" value="${i+1}"/>
                    	  <c:set var="chk" value="${chk+1}"/>
	                    	<div style="margin-bottom: 20px;">
		                    	<h5>${eval.evalkey}. ${eval.evalcontent}</h5>
		                    	<input type="radio" name="chk${chk}" class="form-check-input" id="flexRadioDefault${i}" value="10">
		                    	<label class="form-check-label" for="flexRadioDefault${i}">예</label>
		                    	<input type="radio" name="chk${chk}" class="form-check-input" id="flexRadioDefault${i=i+1}" value="0"
		                    		style="margin-left:10px;">
		                    	<label class="form-check-label" for="flexRadioDefault${i}">아니오</label>
	                    	</div>
                    	</c:forEach>	   	
                    </div>                                          
                </div>
             </form>
                <!-- 버튼 영역 -->
                <div class="modal-footer">
                    <button type="button" class="btn btn-light-secondary"
                        data-bs-dismiss="modal">
                        <i class="bx bx-x d-block d-sm-none"></i>
                        <span class="d-none d-sm-block">닫기</span>
                    </button>
                    <button type="button" id="evalregBtn" class="btn btn-primary ml-1"
                        data-bs-dismiss="modal">
                        <i class="bx bx-check d-block d-sm-none"></i>
                        <span class="d-none d-sm-block">등록</span>
                    </button>
                </div>
          
        </div>
    </div>
</div>
<!-- ==장훈주 end== -->
	
	
</body>

<script>
	// 장훈주 추가 start
	$(document).ready(function(){
			
		var score=0;
		var msg = "${msg}";
		
		if(msg == "합격처리되었습니다"){
			alert(msg)
			location.href = "${path}/qualityList.do"
		}
		
		if(msg == "인증되었습니다"){
			alert(msg)
			location.href = document.referrer;
		}
		
		$("#evalregBtn").click(function(){
		
				if($('input[name=chk1]').is(':checked')==false){
					alert('1번 문항 품질 평가 항목을 확인해주세요');
					return
				}else if($('input[name=chk2]').is(':checked')==false){
					alert('2번 문항 품질 평가 항목을 확인해주세요');
					return
				}else if($('input[name=chk3]').is(':checked')==false){
					alert('3번 문항 품질 평가 항목을 확인해주세요');
					return
				}else if($('input[name=chk4]').is(':checked')==false){
					alert('4번 문항 품질 평가 항목을 확인해주세요');
					return
				}else if($('input[name=chk5]').is(':checked')==false){
					alert('5번 문항 품질 평가 항목을 확인해주세요');
					return
				}else if($('input[name=chk6]').is(':checked')==false){
					alert('6번 문항 품질 평가 항목을 확인해주세요');
					return
				}else if($('input[name=chk7]').is(':checked')==false){
					alert('7번 문항 품질 평가 항목을 확인해주세요');
					return
				}else if($('input[name=chk8]').is(':checked')==false){
					alert('8번 문항 품질 평가 항목을 확인해주세요');
					return
				}else if($('input[name=chk9]').is(':checked')==false){
					alert('9번 문항 품질 평가 항목을 확인해주세요');
					return
				}else if($('input[name=chk10]').is(':checked')==false){
					alert('10번 문항 품질 평가 항목을 확인해주세요');
					return
				}else{
					for(var i=1; i<=10; i++){
						score += parseInt($('input[name=chk'+i+']:checked').val());
					}
					
					if(score != 100){
						alert("불합격입니다");
						score=0;
					}else{
						$("#qualityevalFrm").submit();
					}	
					
				}		
			
		});
		
			
	});
	// 장훈주 추가 end
	
</script>

</html>