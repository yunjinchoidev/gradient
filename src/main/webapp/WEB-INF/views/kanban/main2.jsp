<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title id='Description'>Kanban Board.</title>
    
    
    
    <script  src="http://code.jquery.com/jquery-latest.min.js"></script>
    <link rel="stylesheet" href="/project5/jqwidgets-ver13.2.0/jqwidgets/styles/jqx.base.css" type="text/css" />
    <script type="text/javascript" src="/project5/jqwidgets-ver13.2.0/scripts/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="/project5/jqwidgets-ver13.2.0/jqwidgets/jqxcore.js"></script>
    <script type="text/javascript" src="/project5/jqwidgets-ver13.2.0/jqwidgets/jqxsortable.js"></script>
    <script type="text/javascript" src="/project5/jqwidgets-ver13.2.0/jqwidgets/jqxkanban.js"></script>
    <script type="text/javascript" src="/project5/jqwidgets-ver13.2.0/jqwidgets/jqxdata.js"></script>
    <script type="text/javascript">
    $(document).ready(function () {            
    	   var fields = [
    	             { name: "id", type: "string" },
    	             { name: "state", type: "string" },
    	             { name: "label", type: "string" },
    	             { name: "tags", type: "string" },
    	             { name: "contents", type: "string" },
    	             { name: "hex", type: "string" },
    	             { name: "resourceId", type: "number" }
    	    ];

    	   
    	   
    	   
    	   
    	   
    	   
    	   
    	   
    	   
    	   //  칸반 하나 하나
    	    var source =
    	     {
    	         localData: [
    	                  { id: "1161", state: "new", label: "Combine Orders", tags: "orders, combine", hex: "#5dc3f0", resourceId: 3 },
    	                  { id: "1645", state: "work", label: "Change Billing Address", tags: "billing", hex: "#f19b60", resourceId: 1 },
    	                  { id: "9213", state: "new", label: "One item added to the cart", tags: "cart", hex: "#5dc3f0", resourceId: 3 },
    	                  { id: "6546", state: "done", label: "Edit Item Price", tags: "price, edit", hex: "#5dc3f0", resourceId: 4 },
    	                  { id: "9034", state: "new", label: "new1", tags: "issue, login", hex: "#6bbd49", resourceId: 5},
    	                  { id: "9034", state: "new", label: "new2", tags: "issue, login", hex: "#6bbd49", resourceId: 7},
    	                  { id: "9036", state: "new", label: "new3", tags: "issue, login", hex: "#6bbd49", resourceId: 8},
    	                  { id: "9037", state: "new", label: "new4", tags: "issue, login", hex: "#6bbd49", resourceId: 8}
    	         ],
    	         dataType: "array",
    	         dataFields: fields
    	     };
    	    
    	    
    	    
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

    	    
    	    
    	    
    	    
    	    
    	    
    	    // 칸반 컬럼
    	    $('#kanban').jqxKanban({
    	        width: 1000,
    	        height: 700,
    	        resources: resourcesAdapterFunc(),
    	        source: dataAdapter,
    	        columns: [
    	            { text: "Backlog", dataField: "new", maxItems: 10 },
    	            { text: "In Progress", dataField: "work", maxItems: 10 },
    	            { text: "Done", dataField: "done", maxItems: 10, collapseDirection: "right" }
    	        ]
    	    });

    	   // $("#updateItem, #removeItem, #addItem").jqxButton();
    	    
    	    
    	    
    	   
    	   // 수정 버튼을 눌렀을 때
    	    $("#updateItem").click(function () {
    	    	alert("정말 수정하시겠습니까?");
    	        $('#kanban').jqxKanban('updateItem', "1161", { status: "new", text: "Task", tags: "task", color: "#5dc3f0", resourceId: 3 });
    	        $("#updateItem").jqxButton({ disabled: true });
    	    });
    	    var newItemsCount = 0;
    	    
    	 
    	    
    	    
    	    // 추가 버튼을 눌렀을 때 
			var go = {status: "new", text: "Task" + newItemsCount+'하하', tags: "task" + newItemsCount+ '룰루', color: "#5dc3f0", resourceId: 10};
    	    $("#addItem").click(function(){
    	    	alert("추가할겁니다. 그렇다면 무엇을 추가할겁니까?" );
    	    	 $('#kanban').jqxKanban('addItem', go);
    	    	 	alert("추가 처리 완료했습니다." );
    	    })
    	    
    	    
    	    
    	    // 삭제 작업 
    	    // remove 뒤에 id 를 적으면 삭제가 된다.
    	    $("#removeItem").click(function () {
    	    	alert("정말 삭제하시겠습니까? ");
    	        $('#kanban').jqxKanban('removeItem', "1111");
    	        //$("#removeItem").jqxButton({ disabled: true });
    	    });
    	    
    	    
    	    
    	    $("#getItems").click(function () {
    	        var items = $('#kanban').jqxKanban('getItems');
    	        console.log(items);
    	    });
    	    
    	    $('#jqxKanban').on('itemAttrClicked', function (event) {
    	        var args = event.args;
    	        var itemId = args.itemId;
    	        var attribute = args.attribute; // template, colorStatus, content, keyword, text, avatar
    	        console.log(itemId);
    	        alert("클릭");
    	    });
    	    
    	    $('#kanban').on('itemMoved', function (event) {
    	        var args = event.args;
    	        var itemId = args.itemId;
    	        var oldParentId = args.oldParentId;
    	        var newParentId = args.newParentId;
    	        var itemData = args.itemData;
    	        var oldColumn = args.oldColumn;
    	        var newColumn = args.newColumn;
    	        console.log(itemId);
    	       alert("칸반을 움직였습니다.");
    	    });
    	    
    	    $('#jqxKanban').on('columnAttrClicked', function (event) {
    	        var args = event.args;
    	        var column = args.column;
    	        var cancelToggle = args.cancelToggle; // false by default. Set to true to cancel toggling dynamically.
    	        var attribute = args.attribute; // title, button
    	        alert("컬럼 클릭");
    	    });
    	    
    	});    
    
    
    </script>
    
    </head>
<body>
		<div id="main">
          <div id="kanban"></div> 
          <br>
		        <a href="#" class="btn btn-danger" data-bs-toggle="modal"  data-bs-target="#inlineForm">칸반 추가 </a>
		        <a href="#" class="btn btn-primary"  id="removeItem">칸반 삭제</a>
		         <a href="#" class="btn btn-success" id="updateItem">칸반 수정</a>
		         <a href="#" class="btn btn-danger" id="getItems">모든 칸반 정보 얻기</a>
        </div>
        
        
        
           <!--login form Modal -->
                                            <div class="modal fade text-left" id="inlineForm" tabindex="-1"
                                                role="dialog" aria-labelledby="myModalLabel33" aria-hidden="true">
                                                <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable"
                                                    role="document">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h4 class="modal-title" id="myModalLabel33">칸반 보드 추가 </h4>
                                                            <button type="button" class="close" data-bs-dismiss="modal"
                                                                aria-label="Close">
                                                                <i data-feather="x"></i>
                                                            </button>
                                                        </div>
                                                        <form action="#">
                                                            <div class="modal-body">
                                                                <label>id: </label>
                                                                <div class="form-group">
                                                                    <input type="text" placeholder="state" name="state"
                                                                        class="form-control">
                                                                </div>
                                                                
                                                                
                                                                
                                                                
                                                                <label>state(위치): </label>
                                                                <div class="form-group">
                                                                    <input type="text" placeholder="state" name="state"
                                                                        class="form-control">
                                                                </div>
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                <label>label(내용): </label>
                                                                <div class="form-group">
                                                                    <input type="text" placeholder="label" name="label"
                                                                        class="form-control">
                                                                </div>
                                                                
                                                                
                                                                
                                                                  <label>tags: </label>
                                                                <div class="form-group">
                                                                    <input type="text" placeholder="tags" name="tags"
                                                                        class="form-control">
                                                                </div>


                                                                  <label>contents: </label>
                                                                <div class="form-group">
                                                                    <input type="text" placeholder="contents" name="contents"
                                                                        class="form-control">
                                                                </div>

                                                                  <label>hex: </label>
                                                                <div class="form-group">
                                                                    <input type="color" placeholder="hex" name="hex"
                                                                        class="form-control">
                                                                </div>
                                                                
                                                                
                                                                
                                                                  <label>resourceId: </label>
                                                                <div class="form-group">
                                                                    <input type="text" placeholder="resourceId" name="resourceId"
                                                                        class="form-control">
                                                                </div>
                                                                
                                                                





                                                                
                                                                
                                                            </div>
                                                            
                                                            
                                                            
                                                            
                                                            
                                                            
                                                            
                                                            
                                                            
                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-light-secondary"
                                                                    data-bs-dismiss="modal">
                                                                    <i class="bx bx-x d-block d-sm-none"></i>
                                                                    <span class="d-none d-sm-block">Close</span>
                                                                </button>
                                                                <button type="button" class="btn btn-primary ml-1"
                                                                    data-bs-dismiss="modal" id="addItem">
                                                                    <i class="bx bx-check d-block d-sm-none"></i>
                                                                    <span class="d-none d-sm-block">추가</span>
                                                                </button>
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
        
        
        
        
        
        
</body>
</html>