<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
body{
	margin:0;
	padding:0;
}
/* .container{
	width:90%
	margin:10px auto;
} */
.portfolio-menu{
	text-align:center;
}
.portfolio-menu ul li{
	display:inline-block;
	margin:0;
	list-style:none;
	padding:10px 15px;
	cursor:pointer;
	-webkit-transition:all 05s ease;
	-moz-transition:all 05s ease;
	-ms-transition:all 05s ease;
	-o-transition:all 05s ease;
	transition:all .5s ease;
}

.portfolio-item{
	/*width:100%;*/
}
.portfolio-item .item{
	/*width:303px;*/
	float:left;
	margin-bottom:10px;
}

</style>
</head>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!------ Include the above in your HEAD tag ---------->

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/magnific-popup.js/1.1.0/magnific-popup.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.isotope/3.0.6/isotope.pkgd.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/magnific-popup.js/1.1.0/jquery.magnific-popup.js"></script>

<script>
// $('.portfolio-item').isotope({
//  	itemSelector: '.item',
//  	layoutMode: 'fitRows'
//  });
 $('.portfolio-menu ul li').click(function(){
 	$('.portfolio-menu ul li').removeClass('active');
 	$(this).addClass('active');
 	
 	var selector = $(this).attr('data-filter');
 	$('.portfolio-item').isotope({
 		filter:selector
 	});
 	return  false;
 });
 $(document).ready(function() {
 var popup_btn = $('.popup-btn');
 popup_btn.magnificPopup({
 type : 'image',
 gallery : {
 	enabled : true
 }
 });
 });
</script>


<script>
$(document).ready(function(){
	console.log("준비완료")
	var memberkey;
	var memberkeyValue =parseInt("${member.memberkey}");
	var data = { memberkey : memberkeyValue};
	
	$.ajax({
		  url: '/project5/myFileListInOutput.do',
	      data: data,
	      type: 'POST',
	      dataType:'json',
		success:function(result){
				alert("성공")
				console.log("성공")
				console.log(result);
				console.log(result.myFileListInOutput)
				for(var i=0; i<result.myFileListInOutput.length; i++){
					console.log(i)
					showUploadResult2(result.myFileListInOutput[i]);// 이곳에서 함수 호출 
				}
			},
		error:function(result){
			console.log("실패")
		}
	})
    
  function showUploadResult2(obj){
	    		console.log("obj"+obj);
				var fileCallPath =  encodeURIComponent(obj.fname);
				console.log(fileCallPath);
				var go="/project5/display2.do?fileName="+fileCallPath;
				var A = $("#galleryImg")
				var str = "";
				str += "<div class='item selfie col-lg-3 col-md-4 col-6 col-sm'>"
				str += "<a href='https://image.freepik.com/free-photo/stylish-young-woman-with-bags-taking-selfie_23-2147962203.jpg' class='fancylight popup-btn' data-fancybox-group='light'> "
				str += "<img class=img-fluid' src='"+go+"' alt=''>"
				str += "</a></div>"
				A.append(str)
				//$("#not").attr("src",go)
	  }
	
	console.log(A)
	
})
</script>


<body>

 <div class="container">
         <div class="row">
            <div class="col-lg-12 text-center my-2">
                   <h3 class="py-3"><a href="https://spreeowl.com/">파일함입니다.</a></h3>
               <h4>파일함입니다<h4>
            </div>
         </div>
         
         
         
         
         
         <div class="portfolio-menu mt-2 mb-4">
            <ul>
               <li class="btn btn-outline-dark active" data-filter="*" >text</li>
               <li class="btn btn-outline-dark" data-filter=".gts" >png</li>
               <li class="btn btn-outline-dark" data-filter=".lap" >jpg</li>
               <li class="btn btn-outline-dark text" data-filter=".selfie" >pptx</li>
               <li class="btn btn-outline-dark text" data-filter=".selfie" >excel</li>
            </ul>
         </div>
         
         
         
		<!--  갤러리함 -->         
         <div class="portfolio-item row" id="galleryImg">
            
            <div class="item selfie col-lg-3 col-md-4 col-6 col-sm">
               <a href="https://image.freepik.com/free-photo/stylish-young-woman-with-bags-taking-selfie_23-2147962203.jpg" class="fancylight popup-btn" data-fancybox-group="light"> 
               <img class="img-fluid"  id="not" src="https://image.freepik.com/free-photo/stylish-young-woman-with-bags-taking-selfie_23-2147962203.jpg" alt="">
               </a>
            </div>
            
            
         </div>
         
         
         
         
      </div>
      
      

</body>
</html>