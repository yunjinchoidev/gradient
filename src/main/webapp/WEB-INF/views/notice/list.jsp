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
<title>Insert title here</title>
</head>
<script>
	$(document).ready(function() {
		var psc = "${psc}";

		console.log("psc : " + psc);
		var name = "${member.name}"
		console.log("member.name : " + name);

		if (psc == "write") {
			alert("공지사항 작성이 완료되었습니다.");
		}
		if (psc == "delete") {
			alert("공지사항 삭제가 완료되었습니다.");
		}
		if (psc == "update") {
			alert("공지사항 수정이 완료되었습니다.");
		}

		$("#write").click(function() {
			if (name == "") {
				alert("접근 권한이 없습니다.")
				location.href = "/project5/notice.do";
			} else {
				location.href = "/project5/noticeWriteForm.do";
			}
		})
		var pageSize = "${noticeSch.pageSize}"
		$("[name=pageSize]").val(pageSize);
		$("[name=pageSize]").change(function() {
			$("[name=curPage]").val(1);
			$("#frm01").submit();
		});

		
		
		

			var noticekey =1;
			  
		    $.ajax({
		      url: '/project5/aaaa.do',
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
		          console.log("asdfads");
		          console.log(result); 
		    	  console.log("afsdfa")
		      }
		    }); //$.ajax
	  
		
		
		
		
		
		
		
		
		  function showUploadResult(uploadResultArr){
			    if(!uploadResultArr || uploadResultArr.length == 0){ return; }
			    var uploadUL = $("#uploadImg");
			    var str ="";
			    $(uploadResultArr).each(function(i, obj){
					if(obj.fileType){
						var fileCallPath =  encodeURIComponent( obj.uploadPath+ "/"+obj.uuid +"_"+obj.fileName);
						str += "<img src='/project5/display.do?fileName="+fileCallPath+"' style='width:50px; height:50px;'>";
					}else{
						var fileCallPath =  encodeURIComponent( obj.uploadPath+"/"+ obj.uuid +"_"+obj.fileName);			      
					    var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
					      
						str += "<li "
						str += "data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"' ><div>";
						str += "<span> "+ obj.fileName+"</span>";
						str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' " 
						str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
						str += "<img src='/project5/resources/img/attach.png'></a>";
						str += "</div>";
						str +"</li>";
					}
			    });
			    uploadUL.append(str);
			  }
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	})

	function goPage(no) {
		$("[name=curPage]").val(no);
		$("#frm01").submit();
	}
</script>
<body>
	<%@ include file="../common/header.jsp"%>
	<div id="main">

		<div class="page-heading">
			<div class="page-title">
				<div class="row">
					<div class="col-12 col-md-6 order-md-1 order-last">
						<h3>공지사항</h3>
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



			<form id="frm01" class="form" action="/project5/notice.do"
				method="post">
				<input type="hidden" name="curPage" value="1" />
				<section class="section">
					<div class="card">
						<div class="card-header">Simple Datatable</div>
						<div class="card-body">
							<div
								class="dataTable-wrapper dataTable-loading no-footer sortable searchable fixed-columns">
								<div class="dataTable-top">
									<div class="dataTable-dropdown">
										<span class="input-group-text">총 ${noticeSch.count}건</span> <span
											class="input-group-text">페이지 크기</span> <select
											class="dataTable-selector form-select" name="pageSize"><option
												value="5">5</option>
											<option value="10" selected="">10</option>
											<option value="15">15</option>
											<option value="20">20</option>
											<option value="25">25</option></select><label>entries per page</label>
									</div>
									<div class="dataTable-search">

										<a href="/project5/noticeWriteForm.do" class="btn btn-danger"
											id="write" style="text-align: right">글쓰기</a>
									</div>

								</div>
			</form>


















			<div class="dataTable-container">
				<table class="table table-striped dataTable-table" id="table1">
					<thead>
						<tr>
							<th data-sortable="" style="width: 6.0176%;"><a href="#"
								class="dataTable-sorter">번호</a></th>
								<th data-sortable="" style="width: 6%;"><a href="#"
								class="dataTable-sorter">이미지</a></th>
							<th data-sortable="" style="width: 42.9989%;"><a href="#"
								class="dataTable-sorter">제목</a></th>
							<th data-sortable="" style="width: 18.0816%;"><a href="#"
								class="dataTable-sorter">작성일</a></th>
							<th data-sortable="" style="width: 8.3175%;"><a href="#"
								class="dataTable-sorter">조회수</a></th>
							<th data-sortable="" style="width: 8%;"><a href="#"
								class="dataTable-sorter">작성자</a></th>
							<th data-sortable="" style="width: 10.8049%;"><a href="#"
								class="dataTable-sorter">Status</a></th>
						</tr>
					</thead>




					<tbody>
						<c:forEach var="list" items="${list}">
							<tr
								onclick="location.href='/project5/noticeGet.do?noticekey='+${list.noticekey}">
								<td>${list.noticekey }${list.level}</td>
								
								
								<td id="uploadImg"></td>
								
								<td style="text-align: left"><c:forEach varStatus="sts"
										begin="1" end="${list.level}">
											    				&nbsp;&nbsp;
											    				<c:if test="${list.level>1 and sts.last }">
											<img width="25" height="15" src="${path}/a02_img/reply1.PNG" />
											    				</c:if>
											    				<%-- level 만큼 공백을 넣고, 마지막(sts.last)에 답글이미지 삽입  --%>
									</c:forEach> ${list.title }
									
									</td>
									
									

								

								<td>${list.writeDate }</td>
								<td>${list.cnt }</td>
								<td>${list.name } A</td>
								<td><span class="badge bg-success">Active</span></td>
							</tr>
						</c:forEach>
					</tbody>




				</table>

			</div>






			<div class="dataTable-bottom">
				<div class="dataTable-info">

						<input class="dataTable-input" placeholder="Search..." type="text"
							name="title" value="${noticeSch.title}" placeholder="제목">
						<input class="dataTable-input" placeholder="Search..." type="text"
							name="writer" value="${noticeSch.content}" placeholder="작성자">
						<button class="btn btn-info" type="submit">조회</button>
						<button class="btn btn-success" id="regBtn" type="button">등록</button>

				</div>


















				<!-- class="page-item active" -->
				<ul class="pagination  justify-content-end">
					<li class="page-item"><a class="page-link"
						href="javascript:goPage(${noticeSch.startBlock!=1?noticeSch.startBlock-1:1})"">Previous</a></li>
					<c:forEach var="cnt" begin="${noticeSch.startBlock}"
						end="${noticeSch.endBlock}">
						<li class="page-item ${cnt==noticeSch.curPage?'active':''}">
							<!-- 클릭한 현재 페이지 번호 --> <a class="page-link"
							href="javascript:goPage(${cnt})">${cnt}</a>
						</li>
					</c:forEach>
					<li class="page-item"><a class="page-link"
						href="javascript:goPage(${noticeSch.endBlock!=noticeSch.pageCount?noticeSch.endBlock+1:noticeSch.endBlock})">Next</a></li>
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