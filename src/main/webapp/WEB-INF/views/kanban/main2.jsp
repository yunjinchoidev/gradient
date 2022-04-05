<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title id='Description'>Kanban Board.</title>
    
    
    
    <script  src="http://code.jquery.com/jquery-latest.min.js"></script>
    <link rel="stylesheet" href="/project5/jqwidgets-ver13.2.0/a/jqx.base.css" type="text/css" />
    <script type="text/javascript" src="/project5/jqwidgets-ver13.2.0/scripts/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="/project5/jqwidgets-ver13.2.0/a/jqxcore.js"></script>
    <script type="text/javascript" src="/project5/jqwidgets-ver13.2.0/a/jqxsortable.js"></script>
    <script type="text/javascript" src="/project5/jqwidgets-ver13.2.0/a/jqxkanban.js"></script>
    <script type="text/javascript" src="/project5/jqwidgets-ver13.2.0/a/jqxdata.js"></script>
    <script type="text/javascript">
    $(document).ready(function () {        
    	
    	var projectkey = parserInt("${project.projectkey}")
		var data = {projectkey : projectkey}
    	// 칸반보드 전체 값 저장할 변수 선언
	    var nice;
	    // 칸반보드 전체 값 객체 배열로 가져오기
   		 $.ajax({
         		  type:"post",
         		  url:"/project5/kanbanList.do",
         		 async:false,
         		 data:data,
         		  dataType:"json",
         		  success:function(data){
         			console.log("조회성공");
         			console.log("결과물이 이것 " +data.list);
         			for(idx in data.list){
             			 console.log("idx: " + idx + "data.list[idx]: " + data.list[idx]);
         			 };
         			 nice = data.list;
         		  },
         		  error:function(err){
         			  console.log("실패")
         			  console.log(err)
         			  failureCallback(err);
         			  document.getElementById('script-warning').style.display = 'block';
         		  }
         	 	});
    	
    	
    	
   	    /*	   
    	    var gogogo= [
                { id: "1161", state: "new", label: "Combine Orders", tags: "orders, combine", hex: "#5dc3f0", resourceId: 3 },
                { id: "9037", state: "new", label: "new4", tags: "issue, login", hex: "#6bbd49", resourceId: 8}];
    	  */  
    	   
    		 console.log("nice"+nice);
     	   //  화면단에 뿌려주기
     	    var source =
     	     {
     	         localData: nice,
     	         dataType: "array",
     	         dataFields: fields
     	     };
     	   
    	
    	
     	   
     	   
     	   
     	   
     	   
    	////////////////////////////////////////////////////////////////////////////////////
    	  // 칸반 보드 하나를 구성하는 변수들
    	   var fields = [
    	             { name: "id", type: "string" },
    	             { name: "state", type: "string" },
    	             { name: "label", type: "string" },
    	             { name: "tags", type: "string" },
    	             { name: "contents", type: "string" },
    	             { name: "hex", type: "string" },
    	             { name: "memberkey", type: "number" }
    	    ];

    	   
    	  
    	   
    	   
    	   
    	    //////////////////////////////////////////////////////////////////////////////////////////////////
    	    // 멤버 정보
    	    var dataAdapter = new $.jqx.dataAdapter(source);
    	    var resourcesAdapterFunc = function () {
    	        var resourcesSource =
    	        {
    	            localData: [
    	                  { id: 0, name: "No name", image: "https://www.jqwidgets.com/jquery-widgets-demo/jqwidgets/styles/images/common.png", common: true },
    	                  { id: 1, name: "Andrew Fuller", image: "https://www.jqwidgets.com/jquery-widgets-demo/images/andrew.png" },
    	                  { id: 2, name: "Janet Leverling", image: "https://www.jqwidgets.com/jquery-widgets-demo/images/janet.png" },
    	                  { id: 3, name: "Steven Buchanan", image: "https://www.jqwidgets.com/jquery-widgets-demo/images/steven.png" },
    	                  { id: 4, name: "Nancy Davolio", image: "https://www.jqwidgets.com/jquery-widgets-demo/images/nancy.png" },
    	                  { id: 5, name: "Michael Buchanan", image: "https://www.jqwidgets.com/jquery-widgets-demo/images/Michael.png" },
    	                  { id: 6, name: "Margaret Buchanan", image: "https://www.jqwidgets.com/jquery-widgets-demo/images/margaret.png" },
    	                  { id: 7, name: "Robert Buchanan", image: "https://www.jqwidgets.com/jquery-widgets-demo/images/robert.png" },
    	                  { id: 8, name: "Laura Buchanan", image: "https://www.jqwidgets.com/jquery-widgets-demo/images/Laura.png" },
    	                  { id: 9, name: "Laura Buchanan", image: "https://www.jqwidgets.com/jquery-widgets-demo/images/Anne.png" }
    	            ],
    	            dataType: "array",
    	            dataFields: [
    	                 { name: "id", type: "number" },
    	                 { name: "name", type: "string" },
    	                 { name: "image", type: "string" },
    	                 { name: "common", type: "boolean" }
    	            ]
    	        };
    	        var resourcesDataAdapter = new $.jqx.dataAdapter(resourcesSource);
    	        return resourcesDataAdapter;
    	    }
    	    
    	    
    	    
    	    // 칸반 컬럼 구성하기
    	    $('#kanban').jqxKanban({
    	        width: 1400, // 칸반 전체 가로
    	        height: 700, // 칸반 전체 세로
    	        resources: resourcesAdapterFunc(),
    	        source: dataAdapter,
    	        columns: [
    	            { text: "작업 전 ", dataField: "new", maxItems: 50 },
    	            { text: "진행 중", dataField: "work", maxItems: 50, collapseDirection: "right"},
    	            { text: "완료", dataField: "done", maxItems: 50, collapseDirection: "right" }
    	        ]
    	    });

    	    
    	    
    	    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    	    //$("#updateItem, #removeItem, #addItem").jqxButton();
    	    
    	   
    	   // 칸반 수정 실행
    	    $("#updateItem").click(function () {
    	    	alert("정말 수정하시겠습니까?");
    	    	$("#frm01").attr("action","/project5/kanbanUpdate.do");
				$("#frm01").submit();
    	    });
    	    
    	    // 칸반 추가 실행
    	    $("#addItem").click(function(){
    	    	alert("정말 추가 하시겠습니까?" );
    	    	$("#frm01").attr("action","/project5/kanbanInsert.do");
				$("#frm01").submit();
    	    })
    	    
    	    
    	    
    	    // 칸반 삭제  실행
    	    $("#removeItem").click(function () {
    	    	alert("정말 삭제하시겠습니까? ");
    	    	$("#frm01").attr("action","/project5/kanbanDelete.do");
				$("#frm01").submit();
    	    });
    	    
    	    
    	    //모든 칸반 정보 불러오기
    	    $("#getItems").click(function () {
    	        var items = $('#kanban').jqxKanban('getItems');
    	        alert(items);
    	        console.log(items);
    	    });
    	    
    	    
    	    // 칸반 하나 클릭  // 칸반 하나 조회
    	    $('#kanban').on('itemAttrClicked', function (event) {
    	    	console.log("===================")
    	        var args = event.args;
    	        var itemId = args.itemId;
    	        var attribute = args.attribute; 
    	        console.log(args);
    	        console.log(itemId);
    	        console.log(attribute);
    	        $("[name=id]").val(args.item.id);
    	        $("[name=status]").val(args.item.status);
    	        $("[name=text]").val(args.item.text);
    	        $("[name=tags]").val(args.item.tags);
    	        $("[name=content]").val(args.item.content);
    	        $("[name=color]").val(args.item.color);
    	        $("[name=resourceId]").val(args.item.resourceId);   
    	        $("#addItem").hide();
    	    	$("#removeItem").show();
    	    	$("#updateItem").show();
				$(".modal").modal('show');
 	    	    	});
    	    
    	    
    	    // 칸반 움직이기
    	    $('#kanban').on('itemMoved', function (event) {
    	        var args = event.args;
    	        var itemId = args.itemId;
    	        var oldParentId = args.oldParentId;
    	        var newParentId = args.newParentId;
    	        var itemData = args.itemData;
    	        var oldColumn = args.oldColumn;
    	        var newColumn = args.newColumn;
    	        console.log("----------------")
    	        console.log(itemId);
    	        console.log(args);
    	        console.log(itemId);
     	       console.log(newColumn.dataField);
     	       console.log(itemData.text);
    	       //confirm("칸반을 움직여 일정을 수정하시겠습니까?")
    	       $("[name=id]").val(itemId);
    	       $("[name=status]").val(newColumn.dataField);
    	       $("[name=text]").val(itemData.text);
    	       $("[name=tags]").val(itemData.tags);
    	    
    	       $("#frm01").attr("action","/project5/kanbanUpdate2.do");
				$("#frm01").submit();
    	    });
    	    
    	    // 컬럼 클릭
    	    $('#kanban').on('columnAttrClicked', function (event) {
    	        var args = event.args;
    	        var column = args.column;
    	        var cancelToggle = args.cancelToggle; // false by default. Set to true to cancel toggling dynamically.
    	        var attribute = args.attribute; // title, button
    	        alert("컬럼 클릭");
    	    });

    	    
    	    
    	    // 메인창에서 추가하기 모달 띄우기 클릭
    	    $('#addForm').click(function () {
    	    	$("#addItem").show();
    	    	$("#removeItem").hide();
    	    	$("#updateItem").hide();
    	    });
    	    
    	    
    	    
    	    var psc = "${psc}";
    	    
    	    if(psc=="add"){
    	    	alert("성공적으로 추가 되었습니다.")
    	    };
    	    
    	    if(psc=="update"){
    	    	alert("성공적으로 수정 되었습니다.")
    	    }
    	    
    	    if(psc=="move"){
    	    	alert("성공적으로 이동 되었습니다.")
    	    }
    	    
    	    if(psc=="delete"){
    	    	alert("성공적으로 삭제되었습니다.")
    	    }
    	    
    	    
    	    
    	});    
    </script>









    
    
    </head>
<body>







          <div id="kanban"></div> 
          
          
          
           <div id="log"></div>  
          
         	 <br>
         	 
         	  <div>
		        <a href="#" class="btn btn-danger" data-bs-toggle="modal"  data-bs-target="#inlineForm" id="addForm">칸반 추가 창 </a>
		         <a href="#" class="btn btn-danger" id="getItems">모든 칸반 정보 얻기</a>
       		 </div>
        
        
        
        
         							  <!--login form Modal -->
                                            <div class="modal fade text-left" id="inlineForm" tabindex="-1"
                                                role="dialog" aria-labelledby="myModalLabel33" aria-hidden="true">
                                                <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable"
                                                    role="document">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h4 class="modal-title" id="myModalLabel33">칸반 보드 </h4>
                                                            <button type="button" class="close" data-bs-dismiss="modal"
                                                                aria-label="Close">
                                                                <i data-feather="x"></i>
                                                            </button>
                                                        </div>
                                                        
                                                  
                                                        <form action="#" id="frm01">
                                                            <div class="modal-body">
                                                                <label>id: </label>
                                                                <div class="form-group">
                                                                    <input type="text" name="id"
                                                                        class="form-control">
                                                                </div>
                                                                
                                                                
                                                                <label>status: </label>
                                                                <div class="form-group">
                                                                        <select  class="form-control" name="status">
                                                                        	<option value="new">new</option>
                                                                        	<option value="done">done</option>
                                                                        	<option value="work">work</option>
                                                                        </select>
                                                                        
                                                                        
                                                                </div>
                                                                
                                                                <label>text(내용): </label>
                                                                <div class="form-group">
                                                                    <input type="text"  name="text"
                                                                        class="form-control">
                                                                </div>
                                                                
                                                                  <label>tags: </label>
                                                                <div class="form-group">
                                                                    <input type="text" name="tags" 
                                                                        class="form-control">
                                                                </div>

                                                                  <label>contents: </label>
                                                                <div class="form-group">
                                                                    <input type="text" name="content"
                                                                        class="form-control">
                                                                </div>

                                                                  <label>color: </label>
                                                                <div class="form-group">
                                                                    <input type="color" name="color"
                                                                        class="form-control">
                                                                </div>
                                                                
                                                                  <label>resourceId: </label>
                                                                <div class="form-group">
                                                                    <input type="text" name="resourceId" value=${member.memberkey }
                                                                        class="form-control">
                                                                </div>
                                                            </div>
                                                            
                                                            
                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-light-secondary"
                                                                    data-bs-dismiss="modal">
                                                                    <i class="bx bx-x d-block d-sm-none"></i>
                                                                    <span class="d-none d-sm-block">Close</span>
                                                                </button>
                                                                <button type="button" class="btn btn-primary ml-1 add"
                                                                    data-bs-dismiss="modal" id="addItem">
                                                                    <i class="bx bx-check d-block d-sm-none"></i>
                                                                    <span class="d-none d-sm-block"  >추가</span>
                                                                </button>
                                                                <button type="button" class="btn btn-danger ml-2 update"
                                                                    data-bs-dismiss="modal" id="updateItem">
                                                                    <i class="bx bx-check d-block d-sm-none"></i>
                                                                    <span class="d-none d-sm-block">수정</span>
                                                                </button>
                                                                <button type="button" class="btn btn-warning ml-2 delete"
                                                                    data-bs-dismiss="modal" id="removeItem">
                                                                    <i class="bx bx-check d-block d-sm-none"></i>
                                                                    <span class="d-none d-sm-block">삭제</span>
                                                                </button>
                                                                
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
        
        
        
        
        
        
</body>
</html>