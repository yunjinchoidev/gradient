
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GRADIENT - 공지사항</title>

<style>
.uploadResult {
	width: 100%;
	background-color: gray;
}

.uploadResult ul {
	display: flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
}

.uploadResult ul li {
	list-style: none;
	padding: 10px;
}

.uploadResult ul li img {
	width: 100px;
}
</style>

<style>
.bigPictureWrapper {
	position: absolute;
	display: none;
	justify-content: center;
	align-items: center;
	top: 0%;
	width: 100%;
	height: 100%;
	background-color: gray;
	z-index: 100;
}

.bigPicture {
	position: relative;
	display: flex;
	justify-content: center;
	align-items: center;
}
</style>


</head>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
$(document).ready(function(){

	
	var A = "${psc}";
	if(	A=="writeSuccess"){
		confirm("작성을 완료했습니다. 메인 페이지로 이동할까요?")
		location.href="/project5/notice.do"
	}
	
})


</script>




<body>
<%@ include file="../chatBot/chatBot.jsp"%>
	<%@ include file="../common/header.jsp"%>
	<div id="main">
		<section id="multiple-column-form">
			<div class="row match-height">
				<div class="col-12">
					<div class="card">

						<div class="card-header">
							<h4 class="card-title">공지사항 등록</h4>
						</div>

						<div class="card-content">
							<div class="card-body">
								<form class="form" action="/project5/noticeWrite.do"	>
									<input type="hidden" name="memberkey" value="${member.memberkey }">
									<div class="row">
										<div class="col-md-12 col-12">
											<div class="form-group">
												<label for="first-name-column">공지 제목</label> <input
													type="text" id="first-name-column" class="form-control"
													placeholder="title" name="title">
											</div>
										</div>
										<div class="col-md-12 col-12">
											<div class="form-group">
												<label for="last-name-column">작성일</label> <input type="date"
													id="last-name-column" class="form-control"
													placeholder="writeDate" name="writeDateS">
											</div>
										</div>
										<div class="col-md-12 col-12">
											<div class="form-group">
												<label for="email-id-column">Contents</label>
												<textarea class="form-control" name="content"
													placeholder="content" rows="4"></textarea>
											</div>
										</div>


										<div class="row">
											<div class="col-lg-12">
												<div class="panel panel-default">
													<div class="panel-heading">File Attach</div>
													<div class="panel-body">
														<div class="form-group uploadDiv">
															<input type="file" name='uploadFile' multiple>
														</div>
														<div class='uploadResult'>
															<ul>
															</ul>
														</div>
													</div>
												</div>
											</div>
										</div>






										<div class="col-12 d-flex justify-content-end">
											<button type="button"
												class="btn btn-danger btn-icon icon-left"
												style="height: 90%"
												onclick="location.href='/project5/notice.do'">
												<i class="fas fa-plane"></i> 뒤로가기
											</button>
											<button type="submit" class="btn btn-primary me-1 mb-1">등록</button>
											<button type="reset"
												class="btn btn-light-secondary me-1 mb-1">초기화</button>
										</div>
									</div>
								</form>





							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
	</div>


</body>

</html>




<script>




$(document).ready(function(e){
		  var formObj = $("form");
		  ////////////////////////////////////////////////////////////////////////// 파일 DB 에 저장하기 위한 처리.
		  $("button[type='submit']").on("click", function(e){
		   e.preventDefault();
		    console.log("submit clicked");
		    var str = "";
			console.log("attachList 대기 ")    
		    $(".uploadResult ul li").each(function(i, obj){
		      var jobj = $(obj);
		      console.dir(jobj);
		      console.log("-------------------------");
		      console.log(jobj.data("filename"));
		      str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
		      str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
		      str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
		      str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+ jobj.data("type")+"'>";
		    });
		    console.log("str"+str);
			console.log("attachList 끝 ");   
		   formObj.append(str).submit();
		    console.log("전송");
		  });

  
		  
		  
		  
		  
		  
	  var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	  var maxSize = 5242880; //5MB
  
			  function checkExtension(fileName, fileSize){
			    if(fileSize >= maxSize){
			      alert("파일 사이즈 초과");
			      return false;
			    }
			    if(regex.test(fileName)){
			      alert("해당 종류의 파일은 업로드할 수 없습니다.");
			      return false;
			    }
			    return true;
			  }
  
	  
	  
					  // 파일 저장 처리
					  $("input[type='file']").change(function(e){
					    var formData = new FormData();
					    var inputFile = $("input[name='uploadFile']");
					    var files = inputFile[0].files;
					    for(var i = 0; i < files.length; i++){
					      if(!checkExtension(files[i].name, files[i].size) ){
					        return false;
					      }
					      formData.append("uploadFile", files[i]);
					    }
					    
					    $.ajax({
					      url: '/project5/uploadAjaxAction.do',
					      processData: false, 
					      contentType: false,data: 
					      formData,type: 'POST',
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
					  });  
  
  
  
  
  
  
  
  
  
  

  
  
  
					  	// 이미지 html에 띄어주기
						  function showUploadResult(uploadResultArr){
						    if(!uploadResultArr || uploadResultArr.length == 0){ return; }
						    var uploadUL = $(".uploadResult ul");
						    var str ="";
						    $(uploadResultArr).each(function(i, obj){
								if(obj.image){
									var fileCallPath =  encodeURIComponent( obj.uploadPath+ "/"+obj.uuid +"_"+obj.fileName);
									str += "<li data-path='"+obj.uploadPath+"'";
									str +=" data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'"
									str +" ><div>";
									str += "<span> "+ obj.fileName+"</span>";
									str += "<button type='button' data-file=\'"+fileCallPath+"\' "
									str += "data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
									str += "<img src='/project5/display.do?fileName="+fileCallPath+"'>";
									str += "</div>";
									str +"</li>";
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

  
  	
  	
				  		// 이미지 삭제
					  $(".uploadResult").on("click", "button", function(e){
					    console.log("delete file");
					    var targetFile = $(this).data("file");
					    var type = $(this).data("type");
					    var targetLi = $(this).closest("li");
					    $.ajax({
					      url: '/project5/deleteFile.do',
					      data: {fileName: targetFile, type:type},
					      dataType:'text',
					      type: 'POST',
					        success: function(result){
					           alert(result);
					           targetLi.remove();
					         }
					    }); //$.ajax
					   });
  
});

</script>











