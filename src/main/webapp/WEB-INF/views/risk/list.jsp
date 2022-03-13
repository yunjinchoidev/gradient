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

<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<script>
	$(document).ready(function(){
		
		var msg = "${msg}";
		var id = "${member.id}";
					
		if(msg!=""){
			alert(msg);
			if(msg=="등록되었습니다"){
				location.href="${path}/risk.do";
			}
		}
		
		$("#regBtn").click(function(){
			if(confirm('등록 하시겠습니까?')){
				$('#regForm').submit();
			}
		});
		
		var pageSize="${riskSch.pageSize}"
			$("[name=pageSize]").val(pageSize);
			$("[name=pageSize]").change(function(){
				$("[name=curPage]").val(1);
				$("#schform").submit();
			});
			
		});
	
	function goDetail(riskkey){
		location.href="${path}/riskdetail.do?riskkey="+riskkey;		
	}
	
	function goPage(riskkey){
		$("[name=curPage]").val(riskkey);
		$("#schform").submit();
	}
	
	function load(){
		$("#schform").submit();
		return false;
	}
			
</script>
</head>

<body>
	<%@ include file="../common/header.jsp"%>
	<div id="main">
		<div class="page-heading">
			<div class="page-title">
				<div class="row">
					<div class="col-12 col-md-6 order-md-1 order-last">
						<h3>리스크 관리</h3>
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
					<div class="card-body">
						<div class="dataTable-wrapper dataTable-loading no-footer sortable searchable fixed-columns">
						  <form id="schform" action="${path}/risk.do" method="post">
						  	<input type="hidden" name="curPage" value="1"/>
							<div class="dataTable-top">
								<div class="dataTable-dropdown">
									<select name="pageSize" class="dataTable-selector form-select">
										<option>5</option>
										<option>10</option>
										<option>15</option>
										<option>20</option>
										<option>25</option>
									</select>
									<label>게시글 수</label>	
								</div>
								
								<div class="dataTable-search">
									<input type="text" id="schFrm" name="sch" class="dataTable-input" placeholder="Search..." type="text">
								</div>
							</div>
						  </form>
							<div class="dataTable-container">
								<table class="table table-striped dataTable-table" id="table1">
									<thead>
										<tr>
											<th data-sortable="" style="width: 20%;"><a
												href="#" class="dataTable-sorter">리스크</a></th>
											<th data-sortable="" style="width: 30%;"><a
												href="#" class="dataTable-sorter">프로젝트</a></th>
											<th data-sortable="" style="width: 10%;"><a
												href="#" class="dataTable-sorter">작성일</a></th>
											<th data-sortable="" style="width: 10%;"><a
												href="#" class="dataTable-sorter">완료예정일</a></th>
											<th data-sortable="" style="width: 10%;"><a
												href="#" class="dataTable-sorter">중요도</a></th>
											<th data-sortable="" style="width: 10%;"><a
												href="#" class="dataTable-sorter">진행사항</a></th>
											<th data-sortable="" style="width: 10%;"><a
												href="#" class="dataTable-sorter">담당자</a></th>
										</tr>
									</thead>

									<tbody>
									
									<c:forEach var="rlist" items="${risklist}">
                        				<tr onclick="goDetail(${rlist.riskkey})">                        					
				                            <td id="rtitle">${rlist.title}</td>
				                            <td id="rprjname">${rlist.prjname}</td>
				                            <td>${rlist.writedates}</td>
				                            <td>${rlist.comdate}</td>
				                            <td>
				                            <!-- 중요도 값에 따라 색 변경 -->
				                            <c:choose>
				                            	<c:when test="${rlist.importance eq'낮음'}">
                               						<span class="badge bg-primary">${rlist.importance}</span>
                               					</c:when>
                               					<c:when test="${rlist.importance eq'보통'}">
                               						<span class="badge bg-warning">${rlist.importance}</span>
                               					</c:when>
                               					<c:when test="${rlist.importance eq'중요'}">
                               						<span class="badge bg-danger">${rlist.importance}</span>
                               					</c:when>
                               				</c:choose>
                            				</td>
                            				<td>
                            				<!-- 진행사항 값에 따라 생 변경 -->
                            				<c:choose>
                            					<c:when test="${rlist.progress eq'진행중'}">
                               						<span id="prog" class="badge bg-warning">${rlist.progress}</span>
                               					</c:when>
                               					<c:when test="${rlist.progress eq'대기'}">
                               						<span id="prog" class="badge bg-primary">${rlist.progress}</span>
                               					</c:when>
                               					<c:when test="${rlist.progress eq'완료'}">
                               						<span id="prog" class="badge bg-success">${rlist.progress}</span>
                               					</c:when>
                               				</c:choose>
                            				</td>
                            				<td>${rlist.name}</td>
                       					 </tr>
                       				</c:forEach>
                       					                 					 	                       					 
									</tbody>

								</table>
								
								<button style="margin: auto;display:block;" id="mainregbtn"
								class="btn btn-primary rounded-pill" data-bs-toggle="modal" data-bs-target="#regModal">등록</button>
								
							</div>

							<div class="dataTable-bottom">
								<div class="dataTable-info">전체 리스크: ${riskSch.count}</div>
								<ul class="pagination pagination-primary float-end dataTable-pagination">
									<li class="page-item pager"><a class="page-link"
										href="javascript:goPage(${riskSch.startBlock!=1?riskSch.startBlock-1:1})">‹</a></li>
									<c:forEach var="cnt" begin="${riskSch.startBlock}" end="${riskSch.endBlock}">
	  									<li class="page-item ${cnt==riskSch.curPage?'active':''}"> <!-- 클릭한 현재 페이지 번호 -->
	  									<a class="page-link" href="javascript:goPage(${cnt})">${cnt}</a></li>
	 								</c:forEach>
									<li class="page-item pager"><a class="page-link"
										href="javascript:goPage(${riskSch.endBlock!=riskSch.pageCount?riskSch.endBlock+1:riskSch.endBlock})">›</a></li>
								</ul>
							</div>
						</div>
					</div>
				</div>

			</section>
		</div>

	</div>
	
	<!-- 등록 Modal -->
  	<div class="modal fade text-left" id="regModal" tabindex="-1" role="dialog"
       	aria-labelledby="myModalLabel33" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myModalLabel33">리스크 등록</h4>
                <button type="button" class="close" data-bs-dismiss="modal"
                    aria-label="Close">
                    <i data-feather="x"></i>
                </button>
            </div>
            <form id="regForm" action="${path}/insertrisk.do" method="post">
            	<!-- 모달 입력 요소 영역 -->
                <div class="modal-body" style="margin:10px;">
                	<!-- 프로젝트 select box -->
                	<div id="prjselect">
                    	<select class="form-select" style="text-align:center;" name="prjkey">
                    		<c:forEach var="prlist" items="${prjlist}">
                    			<option value="${prlist.prjkey}">${prlist.prjname}</option>
                    		</c:forEach>
                    	</select>
                    </div>
                    
                    <!-- 중요도, 제목 공통 영역 -->
                    <div id="headerdiv" style="display:flex;margin-top: 10px;">
                    <!-- 중요도 select box -->
                    	<div id="importselect" style="flex:1;margin-right:5px;">
                    		<select class="form-select" name="importance">
	                    		<option value="중요">중요</option>
	                    		<option value="보통">보통</option>
	                    		<option value="낮음">낮음</option>
                    		</select>
                    	</div>
                    <!-- 제목 -->
                    	<div id="title" style="flex:4;">
                    		<input class="form-control" type="text" name="title" placeholder="제목을 입력하세요">
                    	</div>
                    </div>
                    
                    <!-- 상세내용 -->
                    <div id="regcontent" style="margin-top: 10px;">
                    	<textarea name="content" placeholder="상세 내용" class="form-control" rows="5" cols="5"></textarea>
                    </div>
                    
                    <!-- 진행사항, 완료 예정일 영역 -->
                    <div id="footerdiv" style="display:flex; margin-top: 10px;">
                    <!-- 진행사항 -->
                    	<div id="importselectdiv" style="flex:3; margin-right:150px;">
                    		<select class="form-select" name="progress">
	                    		<option value="진행중">진행중</option>
	                    		<option value="대기">대기</option>
	                    		<option value="완료">완료</option>
                    		</select>
                    	</div>
                    <!-- 완료예정일 -->
                    	<div id="comdatediv" style="flex:1; margin-top:5px;">
                    		<input type=date name="comdate">
                    	</div>
                    </div>
                        
                </div>
                <!-- 버튼 영역 -->
                <div class="modal-footer">
                    <button type="button" class="btn btn-light-secondary"
                        data-bs-dismiss="modal">
                        <i class="bx bx-x d-block d-sm-none"></i>
                        <span class="d-none d-sm-block">닫기</span>
                    </button>
                    <button type="button" id="regBtn" class="btn btn-primary ml-1"
                        data-bs-dismiss="modal">
                        <i class="bx bx-check d-block d-sm-none"></i>
                        <span class="d-none d-sm-block">등록</span>
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

</body>
</html>