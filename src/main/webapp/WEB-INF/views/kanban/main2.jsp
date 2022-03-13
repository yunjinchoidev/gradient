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
    	             { name: "status", map: "state", type: "string" },
    	             { name: "text", map: "label", type: "string" },
    	             { name: "tags", type: "string" },
    	             { name: "color", map: "hex", type: "string" },
    	             { name: "resourceId", type: "number" }
    	    ];

    	    var source =
    	     {
    	         localData: [
    	                  { id: "1161", state: "new", label: "Combine Orders", tags: "orders, combine", hex: "#5dc3f0", resourceId: 3 },
    	                  { id: "1645", state: "work", label: "Change Billing Address", tags: "billing", hex: "#f19b60", resourceId: 1 },
    	                  { id: "9213", state: "new", label: "One item added to the cart", tags: "cart", hex: "#5dc3f0", resourceId: 3 },
    	                  { id: "6546", state: "done", label: "Edit Item Price", tags: "price, edit", hex: "#5dc3f0", resourceId: 4 },
    	                  { id: "9034", state: "new", label: "Login 404 issue", tags: "issue, login", hex: "#6bbd49" }
    	         ],
    	         dataType: "array",
    	         dataFields: fields
    	     };

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

    	    $('#kanban').jqxKanban({
    	        width: 1000,
    	        height: 600,
    	        resources: resourcesAdapterFunc(),
    	        source: dataAdapter,
    	        columns: [
    	            { text: "Backlog", dataField: "new", maxItems: 5 },
    	            { text: "In Progress", dataField: "work", maxItems: 5 },
    	            { text: "Done", dataField: "done", maxItems: 5, collapseDirection: "right" }
    	        ]
    	    });

    	   // $("#updateItem, #removeItem, #addItem").jqxButton();
    	    
    	    
    	    
    	    
    	    $("#updateItem").click(function () {
    	        $('#kanban').jqxKanban('updateItem', "1161", { status: "new", text: "Task", tags: "task", color: "#5dc3f0", resourceId: 3 });
    	        $("#updateItem").jqxButton({ disabled: true });
    	    });
    	    var newItemsCount = 0;
    	    $("#addItem").click(function () {
    	        $('#kanban').jqxKanban('addItem', { status: "new", text: "Task" + newItemsCount, tags: "task" + newItemsCount, color: "#5dc3f0" });
    	        newItemsCount++;
    	    });
    	    $("#removeItem").click(function () {
    	        $('#kanban').jqxKanban('removeItem', "1645");
    	        $("#removeItem").jqxButton({ disabled: true });
    	    });
    	});    
    
    
    </script>
    
    </head>
<body>
<div id="main">
          <div id="kanban"></div> 
         <br />
         <button id="addItem">Add Item</button>
         <button id="removeItem">Remove Item</button>
         <button id="updateItem">Update Item</button>  
        
        </div>
        
</body>
</html>