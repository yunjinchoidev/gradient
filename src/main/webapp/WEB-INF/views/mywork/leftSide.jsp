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

<script scr="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&amp;display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="/project5/resources/dist/assets/css/bootstrap.css">
<link rel="stylesheet"
	href="/project5/resources/dist/assets/css/pages/email.css">
<link rel="stylesheet"
	href="/project5/resources/dist/assets/vendors/perfect-scrollbar/perfect-scrollbar.css">
<link rel="stylesheet"
	href="/project5/resources/dist/assets/vendors/bootstrap-icons/bootstrap-icons.css">
<link rel="stylesheet"
	href="/project5/resources/dist/assets/css/app.css">
<link rel="shortcut icon"
	href="/project5/resources/dist/assets/images/favicon.svg"
	type="image/x-icon">
</head>

<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>

function absoulte(data){
	alert("즐겨찾기에 추가합니다");
		var menubarkey;
  		console.log("menubarkey"+menubarkey);
		var menubarkeyValue =$(data).text().substr(2,1);
		console.log("menubarkeyValue"+menubarkeyValue);
		var data = { menubarkey :menubarkeyValue};
		console.log(data);
	    $.ajax({
	      url: '/project5/favoriteInsert.do',
	      data: data,
	      type: 'POST',
	      dataType:'json',
	        success: function(result){
	        console.log(result)
	        		alert("성공")
	        		 location.reload();
	      },
	      error: function(result){
	          console.log(result); 
	          alert("실패")
	      }
	    }); //$.ajax
	
}





function cancel(data){
		var favoritekey;
  		console.log("favoritekey"+favoritekey);
  		favoritekey = parseInt($(data).text().substr(0,1));
		console.log("favoritekey"+favoritekey);
		var data = { favoritekey :favoritekey};
		console.log(data);
	    $.ajax({
	      url: '/project5/favoriteDelete.do',
	      data: data,
	      type: 'POST',
	      dataType:'json',
	        success: function(result){
	        console.log(result)
	        		alert("즐겨찾기에서 해제 되었습니다.!")
	        		 location.reload();
	      },
	      error: function(result){
	          console.log(result); 
	          alert("실패")
	      }
	    }); //$.ajax
	    
	    
}







$(document).ready(function(){
	
	
	
	
	
	
	
	
	
	
	// 즐겨 찾기 목록 불럴오기
	$.ajax({
			url:'/project5/favoriteList.do',
			type:'POST',
  			dataType:'json',
			success:function(result){
				console.log(result)
				console.log(result.list)
				for(var i=0; i<result.list.length; i++){
					console.log(i)
					var favoriteListHtml = $("#favoriteList");
					str="";
					str+="<div >"
					str+="<span class='fonticon-wrap d-inline me-3' style='display: inline-block;' >"
					str+="😃<a  onclick='cancel(this)' class='list-group-item' style='font-size: 20px; font-weight: bolder; display: inline-block;' >"+result.list[i].favoritekey+")</a>"
					str +="<a onclick='/project5/myworkCalendar.do?memberkey=${member.memberkey }' class='list-group-item'"
                    str+="style='font-size: 20px; font-weight: bolder; display: inline-block;' id='btn1'>"+ result.list[i].menubar+"</a> "
                    str+="</span></div>"
					favoriteListHtml.append(str)	;
				}
				
			}
	})
	
	
	
})
</script>




<body>



	<div class="sidebar-left" style="height: 5000px;">
		<div class="sidebar" style="height: 5000px;">
			<div class="sidebar-content email-app-sidebar d-flex">
				<!-- sidebar close icon -->
				<span class="sidebar-close-icon"> <i class="bx bx-x"></i>
				</span>
				<!-- sidebar close icon -->
				<div class="email-app-menu" style="height: 5000px;">
					





					<div class="sidebar-menu-list ps">
						<!-- sidebar menu  -->
						<div class="list-group list-group-messages">


				<div class="form-group form-group-compose">
						<!-- compose button  -->
						<button type="button"
							class="btn btn-warning btn-block my-4 compose-btn">
							<i class="bx bx-plus"></i> 즐겨찾기
						</button>

							<div id="favoriteList">
												
													
							</div>
						
					</div>



















								<div class="form-group form-group-compose">
												<!-- compose button  -->
												<button type="button"
													class="btn btn-primary btn-block my-4 compose-btn">
													<i class="bx bx-plus"></i> 구분
												</button>
								</div>
							
							
							<c:forEach var="list" items="${menubarList }"> 				
								<div>
									<a class="list-group-item"
									style="font-size: 20px; font-weight: bolder; display: inline-block; color: red" onclick='absoulte(this)' ">✔	${list.menubarkey})</a>
									
									<a onclick="location.href='/project5/myWork${list.menubarkey }.do?memberkey=${member.memberkey }'"class="list-group-item"
									style="font-size: 20px; font-weight: bolder; display: inline-block;" id="btn1">
									${list.title }</a>
									
									
								 </div>
							</c:forEach>


							
							
							
							
							
							
						
						</div>
						<!-- sidebar menu  end-->

						<!-- sidebar label end -->
						<div class="ps__rail-x" style="left: 0px; bottom: 0px;">
							<div class="ps__thumb-x" tabindex="0"
								style="left: 0px; width: 0px;"></div>
						</div>
						<div class="ps__rail-y" style="top: 0px; right: 0px;">
							<div class="ps__thumb-y" tabindex="0"
								style="top: 0px; height: 0px;"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


</body>
<script
	src="/project5/resources/dist/assets/vendors/perfect-scrollbar/perfect-scrollbar.min.js"></script>
<script src="/project5/resources/dist/assets/js/bootstrap.bundle.min.js"></script>
<script src="/project5/resources/dist/assets/js/main.js"></script>
</html>