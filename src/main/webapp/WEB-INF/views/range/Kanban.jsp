<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

  <!DOCTYPE html>
  <html lang="en">
  <body>
  	<%@ include file="../common/header.jsp"%>
  	
  <script src="https://unpkg.com/gojs@2.2.5/release/go.js"></script>
  
  <p>
    This is a minimalist HTML and JavaScript skeleton of the GoJS Sample
    <a href="https://gojs.net/latest/samples/kanban.html">kanban.html</a>. It was automatically generated from a button on the sample page,
    and does not contain the full HTML. It is intended as a starting point to adapt for your own usage.
    For many samples, you may need to inspect the
    <a href="https://github.com/NorthwoodsSoftware/GoJS/blob/master/samples/kanban.html">full source on Github</a>
    and copy other files or scripts.
  </p>
  
  
  <div id="allSampleContent" class="p-4 w-full" style="padding-left: 200px; margin-left: 300px;">
  
  
  
  <link href="https://fonts.googleapis.com/css?family=Lato:300,400,700" rel="stylesheet" type="text/css">
    <script id="code">

  // define a custom grid layout that makes sure the length of each lane is the same
  // and that each lane is broad enough to hold its subgraph
  class PoolLayout extends go.GridLayout {
    constructor() {
      super();
      this.MINLENGTH = 200;  // this controls the minimum length of any swimlane
      this.MINBREADTH = 100;  // this controls the minimum breadth of any non-collapsed swimlane
      this.cellSize = new go.Size(1, 1);
      this.wrappingColumn = Infinity;
      this.wrappingWidth = Infinity;
      this.spacing = new go.Size(0, 0);
      this.alignment = go.GridLayout.Position;
    }

    doLayout(coll) {
      const diagram = this.diagram;
      if (diagram === null) return;
      diagram.startTransaction("PoolLayout");
      // make sure all of the Group Shapes are big enough
      const minlen = this.computeMinPoolLength();
      diagram.findTopLevelGroups().each(lane => {
        if (!(lane instanceof go.Group)) return;
        const shape = lane.selectionObject;
        if (shape !== null) {  // change the desiredSize to be big enough in both directions
          const sz = this.computeLaneSize(lane);
          shape.width = (!isNaN(shape.width)) ? Math.max(shape.width, sz.width) : sz.width;
          // if you want the height of all of the lanes to shrink as the maximum needed height decreases:
          shape.height = minlen;
          // if you want the height of all of the lanes to remain at the maximum height ever needed:
          //shape.height = (isNaN(shape.height) ? minlen : Math.max(shape.height, minlen));
          const cell = lane.resizeCellSize;
          if (!isNaN(shape.width) && !isNaN(cell.width) && cell.width > 0) shape.width = Math.ceil(shape.width / cell.width) * cell.width;
          if (!isNaN(shape.height) && !isNaN(cell.height) && cell.height > 0) shape.height = Math.ceil(shape.height / cell.height) * cell.height;
        }
      });
      // now do all of the usual stuff, according to whatever properties have been set on this GridLayout
      super.doLayout(coll);
      diagram.commitTransaction("PoolLayout");
    };

    // compute the minimum length of the whole diagram needed to hold all of the Lane Groups
    computeMinPoolLength() {
      let len = this.MINLENGTH;
      myDiagram.findTopLevelGroups().each(lane => {
        const holder = lane.placeholder;
        if (holder !== null) {
          const sz = holder.actualBounds;
          len = Math.max(len, sz.height);
        }
      });
      return len;
    }

    // compute the minimum size for a particular Lane Group
    computeLaneSize(lane) {
      // assert(lane instanceof go.Group);
      const sz = new go.Size(lane.isSubGraphExpanded ? this.MINBREADTH : 1, this.MINLENGTH);
      if (lane.isSubGraphExpanded) {
        const holder = lane.placeholder;
        if (holder !== null) {
          const hsz = holder.actualBounds;
          sz.width = Math.max(sz.width, hsz.width);
        }
      }
      // minimum breadth needs to be big enough to hold the header
      const hdr = lane.findObject("HEADER");
      if (hdr !== null) sz.width = Math.max(sz.width, hdr.actualBounds.width);
      return sz;
    }
  }
  // end PoolLayout class


    function init() {

      // Since 2.2 you can also author concise templates with method chaining instead of GraphObject.make
      // For details, see https://gojs.net/latest/intro/buildingObjects.html
      const $ = go.GraphObject.make;

      myDiagram =
        $(go.Diagram, "myDiagramDiv",
          {
            // make sure the top-left corner of the viewport is occupied
            contentAlignment: go.Spot.TopLeft,
            // use a simple layout to stack the top-level Groups next to each other
            layout: $(PoolLayout),
            // disallow nodes to be dragged to the diagram's background
            mouseDrop: e => {
              e.diagram.currentTool.doCancel();
            },
            // a clipboard copied node is pasted into the original node's group (i.e. lane).
            "commandHandler.copiesGroupKey": true,
            // automatically re-layout the swim lanes after dragging the selection
            "SelectionMoved": relayoutDiagram,  // this DiagramEvent listener is
            "SelectionCopied": relayoutDiagram, // defined above
            "undoManager.isEnabled": true,
            // allow TextEditingTool to start without selecting first
            "textEditingTool.starting": go.TextEditingTool.SingleClick
          });

      // Customize the dragging tool:
      // When dragging a node set its opacity to 0.6 and move it to be in front of other nodes
      myDiagram.toolManager.draggingTool.doActivate = function() {
        go.DraggingTool.prototype.doActivate.call(this);
        this.currentPart.opacity = 0.6;
        this.currentPart.layerName = "Foreground";
      }
      myDiagram.toolManager.draggingTool.doDeactivate = function() {
        this.currentPart.opacity = 1;
        this.currentPart.layerName = "";
        go.DraggingTool.prototype.doDeactivate.call(this);
      }

      // this is called after nodes have been moved
      function relayoutDiagram() {
        myDiagram.selection.each(n => n.invalidateLayout());
        myDiagram.layoutDiagram();
      }

      // There are only three note colors by default, blue, red, and yellow but you could add more here:
      const noteColors = ['#009CCC', '#CC293D', '#FFD700'];
      function getNoteColor(num) {
        return noteColors[Math.min(num, noteColors.length - 1)];
      }

      myDiagram.nodeTemplate =
        $(go.Node, "Horizontal",
          new go.Binding("location", "loc", go.Point.parse).makeTwoWay(go.Point.stringify),
          $(go.Shape, "Rectangle", {
            fill: '#009CCC', strokeWidth: 1, stroke: '#009CCC',
            width: 6, stretch: go.GraphObject.Vertical, alignment: go.Spot.Left,
            // if a user clicks the colored portion of a node, cycle through colors
            click: (e, obj) => {
              myDiagram.startTransaction("Update node color");
              let newColor = parseInt(obj.part.data.color) + 1;
              if (newColor > noteColors.length - 1) newColor = 0;
              myDiagram.model.setDataProperty(obj.part.data, "color", newColor);
              myDiagram.commitTransaction("Update node color");
            }
          },
            new go.Binding("fill", "color", getNoteColor),
            new go.Binding("stroke", "color", getNoteColor)
          ),
          $(go.Panel, "Auto",
            $(go.Shape, "Rectangle", { fill: "white", stroke: '#CCCCCC' }),
            $(go.Panel, "Table",
              { width: 130, minSize: new go.Size(NaN, 50) },
              $(go.TextBlock,
                {
                  name: 'TEXT',
                  margin: 6, font: '11px Lato, sans-serif', editable: true,
                  stroke: "#000", maxSize: new go.Size(130, NaN),
                  alignment: go.Spot.TopLeft
                },
                new go.Binding("text", "text").makeTwoWay())
            )
          )
        );

      // unmovable node that acts as a button
      myDiagram.nodeTemplateMap.add('newbutton',
        $(go.Node, "Horizontal",
          new go.Binding("location", "loc", go.Point.parse).makeTwoWay(go.Point.stringify),
          {
            selectable: false,
            click: (e, node) => {
              myDiagram.startTransaction('add node');
              const newdata = { group: "Problems", loc: "0 50", text: "New item " + node.containingGroup.memberParts.count, color: 0 };
              myDiagram.model.addNodeData(newdata);
              myDiagram.commitTransaction('add node');
              const newnode = myDiagram.findNodeForData(newdata);
              myDiagram.select(newnode);
              myDiagram.commandHandler.editTextBlock();
            },
            background: 'white'
          },
          $(go.Panel, "Auto",
            $(go.Shape, "Rectangle", { strokeWidth: 0, stroke: null, fill: '#6FB583' }),
            $(go.Shape, "PlusLine", { margin: 6, strokeWidth: 2, width: 12, height: 12, stroke: 'white', background: '#6FB583' })
          ),
          $(go.TextBlock, "New item", { font: '10px Lato, sans-serif', margin: 6, })
        )
      );

      // While dragging, highlight the dragged-over group
      function highlightGroup(grp, show) {
        if (show) {
          const part = myDiagram.toolManager.draggingTool.currentPart;
          if (part.containingGroup !== grp) {
            grp.isHighlighted = true;
            return;
          }
        }
        grp.isHighlighted = false;
      }

      myDiagram.groupTemplate =
        $(go.Group, "Vertical",
          {
            selectable: false,
            selectionObjectName: "SHAPE", // even though its not selectable, this is used in the layout
            layerName: "Background",  // all lanes are always behind all nodes and links
            layout: $(go.GridLayout,  // automatically lay out the lane's subgraph
              {
                wrappingColumn: 1,
                cellSize: new go.Size(1, 1),
                spacing: new go.Size(5, 5),
                alignment: go.GridLayout.Position,
                comparer: (a, b) => {  // can re-order tasks within a lane
                  const ay = a.location.y;
                  const by = b.location.y;
                  if (isNaN(ay) || isNaN(by)) return 0;
                  if (ay < by) return -1;
                  if (ay > by) return 1;
                  return 0;
                }
              }),
            click: (e, grp) => {  // allow simple click on group to clear selection
              if (!e.shift && !e.control && !e.meta) e.diagram.clearSelection();
            },
            computesBoundsAfterDrag: true,  // needed to prevent recomputing Group.placeholder bounds too soon
            handlesDragDropForMembers: true,  // don't need to define handlers on member Nodes and Links
            mouseDragEnter: (e, grp, prev) => highlightGroup(grp, true),
            mouseDragLeave: (e, grp, next) => highlightGroup(grp, false),
            mouseDrop: (e, grp) => {  // dropping a copy of some Nodes and Links onto this Group adds them to this Group
              // don't allow drag-and-dropping a mix of regular Nodes and Groups
              if (e.diagram.selection.all(n => !(n instanceof go.Group))) {
                const ok = grp.addMembers(grp.diagram.selection, true);
                if (!ok) grp.diagram.currentTool.doCancel();
              }
            },
            subGraphExpandedChanged: grp => {
              const shp = grp.selectionObject;
              if (grp.diagram.undoManager.isUndoingRedoing) return;
              if (grp.isSubGraphExpanded) {
                shp.width = grp.data.savedBreadth;
              } else {  // remember the original width
                if (!isNaN(shp.width)) grp.diagram.model.set(grp.data, "savedBreadth", shp.width);
                shp.width = NaN;
              }
            }
          },
          new go.Binding("location", "loc", go.Point.parse).makeTwoWay(go.Point.stringify),
          new go.Binding("isSubGraphExpanded", "expanded").makeTwoWay(),
          // the lane header consisting of a TextBlock and an expander button
          $(go.Panel, "Horizontal",
            { name: "HEADER", alignment: go.Spot.Left },
            $("SubGraphExpanderButton", { margin: 5 }),  // this remains always visible
            $(go.TextBlock,  // the lane label
              { font: "15px Lato, sans-serif", editable: true, margin: new go.Margin(2, 0, 0, 0) },
              // this is hidden when the swimlane is collapsed
              new go.Binding("visible", "isSubGraphExpanded").ofObject(),
              new go.Binding("text").makeTwoWay())
          ),  // end Horizontal Panel
          $(go.Panel, "Auto",  // the lane consisting of a background Shape and a Placeholder representing the subgraph
            $(go.Shape, "Rectangle",  // this is the resized object
              { name: "SHAPE", fill: "#F1F1F1", stroke: null, strokeWidth: 4 },  // strokeWidth controls space between lanes
              new go.Binding("fill", "isHighlighted", h => h ? "#D6D6D6" : "#F1F1F1").ofObject(),
              new go.Binding("desiredSize", "size", go.Size.parse).makeTwoWay(go.Size.stringify)),
            $(go.Placeholder,
              { padding: 12, alignment: go.Spot.TopLeft }),
            $(go.TextBlock,  // this TextBlock is only seen when the swimlane is collapsed
              {
                name: "LABEL", font: "15px Lato, sans-serif", editable: true,
                angle: 90, alignment: go.Spot.TopLeft, margin: new go.Margin(4, 0, 0, 2)
              },
              new go.Binding("visible", "isSubGraphExpanded", e => !e).ofObject(),
              new go.Binding("text").makeTwoWay())
          )  // end Auto Panel
        );  // end Group

      // Set up an unmodeled Part as a legend, and place it directly on the diagram.
      myDiagram.add(
        $(go.Part, "Table",
          { position: new go.Point(10, 10), selectable: false },
          $(go.TextBlock, "Key",
            { row: 0, font: "700 14px Droid Serif, sans-serif" }),  // end row 0
          $(go.Panel, "Horizontal",
            { row: 1, alignment: go.Spot.Left },
            $(go.Shape, "Rectangle",
              { desiredSize: new go.Size(10, 10), fill: '#CC293D', margin: 5 }),
            $(go.TextBlock, "Halted",
              { font: "700 13px Droid Serif, sans-serif" })
          ),  // end row 1
          $(go.Panel, "Horizontal",
            { row: 2, alignment: go.Spot.Left },
            $(go.Shape, "Rectangle",
              { desiredSize: new go.Size(10, 10), fill: '#FFD700', margin: 5 }),
            $(go.TextBlock, "In Progress",
              { font: "700 13px Droid Serif, sans-serif" })
          ),  // end row 2
          $(go.Panel, "Horizontal",
            { row: 3, alignment: go.Spot.Left },
            $(go.Shape, "Rectangle",
              { desiredSize: new go.Size(10, 10), fill: '#009CCC', margin: 5 }),
            $(go.TextBlock, "Completed",
              { font: "700 13px Droid Serif, sans-serif" })
          )  // end row 3
        ));

      load();

    }  // end init

    // Show the diagram's model in JSON format
    function save() {
      document.getElementById("mySavedModel").value = myDiagram.model.toJson();
      myDiagram.isModified = false;
    }
    function load() {
      myDiagram.model = go.Model.fromJson(document.getElementById("mySavedModel").value);
    }
    window.addEventListener('DOMContentLoaded', init);
  </script>









<div id="sample">
  <div id="myDiagramDiv" style="border: 1px solid black; width: 100%; height: 500px; position: relative; -webkit-tap-highlight-color: rgba(255, 255, 255, 0);"><canvas tabindex="0" width="1326" height="601" style="position: absolute; top: 0px; left: 0px; z-index: 2; user-select: none; touch-action: none; width: 1061px; height: 481px;">This text is displayed if your browser does not support the Canvas HTML element.</canvas><div style="position: absolute; overflow: auto; width: 1061px; height: 498px; z-index: 1;"><div style="position: absolute; width: 1263px; height: 1px;"></div></div></div>
  <p>A Kanban board is a work and workflow visualization used to communicate the status and progress of work items. Click on the color of a note to cycle through colors.</p>
  <p>
    This design and implementation were adapted from the <a href="swimLanesVertical.html">Swim Lanes (vertical)</a> sample.
    Unlike that sample:
    </p><ul>
      <li>there are no Links</li>
      <li>lanes cannot be nested into "pools"</li>
      <li>lanes cannot be resized</li>
      <li>the user cannot drop tasks into the diagram's background</li>
      <li>all tasks are ordered within a single column; the user can rearrange the order</li>
      <li>tasks can freely be moved into other lanes</li>
      <li>lanes are not movable or copyable or deletable</li>
    </ul>
  <p></p>
  <button id="SaveButton" onclick="save()">Save</button>
  <button onclick="load()">Load</button>
  Diagram Model saved in JSON format:
  <br>
  <textarea id="mySavedModel" style="width:100%;height:300px">{ "class": "go.GraphLinksModel",
  "nodeDataArray": [
{"key":"Problems", "text":"Problems", "isGroup":true, "loc":"0 23.52284749830794" },
{"key":"Reproduced", "text":"Reproduced", "isGroup":true, "color":"0", "loc":"109 23.52284749830794" },
{"key":"Identified", "text":"Identified", "isGroup":true, "color":"0", "loc":"235 23.52284749830794" },
{"key":"Fixing", "text":"Fixing", "isGroup":true, "color":"0", "loc":"343 23.52284749830794" },
{"key":"Reviewing", "text":"Reviewing", "isGroup":true, "color":"0", "loc":"451 23.52284749830794"},
{"key":"Testing", "text":"Testing", "isGroup":true, "color":"0", "loc":"562 23.52284749830794" },
{"key":"Customer", "text":"Customer", "isGroup":true, "color":"0", "loc":"671 23.52284749830794" },
{"key":-1, "group":"Problems", "category":"newbutton",  "loc":"12 35.52284749830794" },
{"key":1, "text":"text for oneA", "group":"Problems", "color":"0", "loc":"12 35.52284749830794"},
{"key":2, "text":"text for oneB", "group":"Problems", "color":"1", "loc":"12 65.52284749830794"},
{"key":3, "text":"text for oneC", "group":"Problems", "color":"0", "loc":"12 95.52284749830794"},
{"key":4, "text":"text for oneD", "group":"Problems", "color":"1", "loc":"12 125.52284749830794"},
{"key":5, "text":"text for twoA", "group":"Reproduced", "color":"1", "loc":"121 35.52284749830794"},
{"key":6, "text":"text for twoB", "group":"Reproduced", "color":"1", "loc":"121 65.52284749830794"},
{"key":7, "text":"text for twoC", "group":"Identified", "color":"0", "loc":"247 35.52284749830794"},
{"key":8, "text":"text for twoD", "group":"Fixing", "color":"0", "loc":"355 35.52284749830794"},
{"key":9, "text":"text for twoE", "group":"Reviewing", "color":"0", "loc":"463 35.52284749830794"},
{"key":10, "text":"text for twoF", "group":"Reviewing", "color":"1", "loc":"463 65.52284749830794"},
{"key":11, "text":"text for twoG", "group":"Testing", "color":"0", "loc":"574 35.52284749830794"},
{"key":12, "text":"text for fourA", "group":"Customer", "color":"1", "loc":"683 35.52284749830794"},
{"key":13, "text":"text for fourB", "group":"Customer", "color":"1", "loc":"683 65.52284749830794"},
{"key":14, "text":"text for fourC", "group":"Customer", "color":"1", "loc":"683 95.52284749830794"},
{"key":15, "text":"text for fourD", "group":"Customer", "color":"0", "loc":"683 125.52284749830794"},
{"key":16, "text":"text for fiveA", "group":"Customer", "color":"0", "loc":"683 155.52284749830795"}
],
  "linkDataArray": []}
  </textarea>
<p class="text-xs">GoJS version 2.2.5. Copyright 1998-2022 by Northwoods Software.</p></div>
    <p><a href="https://github.com/NorthwoodsSoftware/GoJS/blob/master/samples/kanban.html" target="_blank">View this sample page's source on GitHub</a></p><pre class=" language-js">

  <span class="token comment">// define a custom grid layout that makes sure the length of each lane is the same</span>
  <span class="token comment">// and that each lane is broad enough to hold its subgraph</span>
  <span class="token keyword">class</span> <span class="token class-name">PoolLayout</span> <span class="token keyword">extends</span> <span class="token class-name">go<span class="token punctuation">.</span>GridLayout</span> <span class="token punctuation">{</span>
    <span class="token function">constructor</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{</span>
      <span class="token keyword">super</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
      <span class="token keyword">this</span><span class="token punctuation">.</span><span class="token constant">MINLENGTH</span> <span class="token operator">=</span> <span class="token number">200</span><span class="token punctuation">;</span>  <span class="token comment">// this controls the minimum length of any swimlane</span>
      <span class="token keyword">this</span><span class="token punctuation">.</span><span class="token constant">MINBREADTH</span> <span class="token operator">=</span> <span class="token number">100</span><span class="token punctuation">;</span>  <span class="token comment">// this controls the minimum breadth of any non-collapsed swimlane</span>
      <span class="token keyword">this</span><span class="token punctuation">.</span>cellSize <span class="token operator">=</span> <span class="token keyword">new</span> <span class="token class-name">go<span class="token punctuation">.</span>Size</span><span class="token punctuation">(</span><span class="token number">1</span><span class="token punctuation">,</span> <span class="token number">1</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
      <span class="token keyword">this</span><span class="token punctuation">.</span>wrappingColumn <span class="token operator">=</span> <span class="token number">Infinity</span><span class="token punctuation">;</span>
      <span class="token keyword">this</span><span class="token punctuation">.</span>wrappingWidth <span class="token operator">=</span> <span class="token number">Infinity</span><span class="token punctuation">;</span>
      <span class="token keyword">this</span><span class="token punctuation">.</span>spacing <span class="token operator">=</span> <span class="token keyword">new</span> <span class="token class-name">go<span class="token punctuation">.</span>Size</span><span class="token punctuation">(</span><span class="token number">0</span><span class="token punctuation">,</span> <span class="token number">0</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
      <span class="token keyword">this</span><span class="token punctuation">.</span>alignment <span class="token operator">=</span> go<span class="token punctuation">.</span>GridLayout<span class="token punctuation">.</span>Position<span class="token punctuation">;</span>
    <span class="token punctuation">}</span>

    <span class="token function">doLayout</span><span class="token punctuation">(</span><span class="token parameter">coll</span><span class="token punctuation">)</span> <span class="token punctuation">{</span>
      <span class="token keyword">const</span> diagram <span class="token operator">=</span> <span class="token keyword">this</span><span class="token punctuation">.</span>diagram<span class="token punctuation">;</span>
      <span class="token keyword">if</span> <span class="token punctuation">(</span>diagram <span class="token operator">===</span> <span class="token keyword">null</span><span class="token punctuation">)</span> <span class="token keyword">return</span><span class="token punctuation">;</span>
      diagram<span class="token punctuation">.</span><span class="token function">startTransaction</span><span class="token punctuation">(</span><span class="token string">"PoolLayout"</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
      <span class="token comment">// make sure all of the Group Shapes are big enough</span>
      <span class="token keyword">const</span> minlen <span class="token operator">=</span> <span class="token keyword">this</span><span class="token punctuation">.</span><span class="token function">computeMinPoolLength</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
      diagram<span class="token punctuation">.</span><span class="token function">findTopLevelGroups</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">.</span><span class="token function">each</span><span class="token punctuation">(</span><span class="token parameter">lane</span> <span class="token operator">=&gt;</span> <span class="token punctuation">{</span>
        <span class="token keyword">if</span> <span class="token punctuation">(</span><span class="token operator">!</span><span class="token punctuation">(</span>lane <span class="token keyword">instanceof</span> <span class="token class-name">go<span class="token punctuation">.</span>Group</span><span class="token punctuation">)</span><span class="token punctuation">)</span> <span class="token keyword">return</span><span class="token punctuation">;</span>
        <span class="token keyword">const</span> shape <span class="token operator">=</span> lane<span class="token punctuation">.</span>selectionObject<span class="token punctuation">;</span>
        <span class="token keyword">if</span> <span class="token punctuation">(</span>shape <span class="token operator">!==</span> <span class="token keyword">null</span><span class="token punctuation">)</span> <span class="token punctuation">{</span>  <span class="token comment">// change the desiredSize to be big enough in both directions</span>
          <span class="token keyword">const</span> sz <span class="token operator">=</span> <span class="token keyword">this</span><span class="token punctuation">.</span><span class="token function">computeLaneSize</span><span class="token punctuation">(</span>lane<span class="token punctuation">)</span><span class="token punctuation">;</span>
          shape<span class="token punctuation">.</span>width <span class="token operator">=</span> <span class="token punctuation">(</span><span class="token operator">!</span><span class="token function">isNaN</span><span class="token punctuation">(</span>shape<span class="token punctuation">.</span>width<span class="token punctuation">)</span><span class="token punctuation">)</span> <span class="token operator">?</span> Math<span class="token punctuation">.</span><span class="token function">max</span><span class="token punctuation">(</span>shape<span class="token punctuation">.</span>width<span class="token punctuation">,</span> sz<span class="token punctuation">.</span>width<span class="token punctuation">)</span> <span class="token operator">:</span> sz<span class="token punctuation">.</span>width<span class="token punctuation">;</span>
          <span class="token comment">// if you want the height of all of the lanes to shrink as the maximum needed height decreases:</span>
          shape<span class="token punctuation">.</span>height <span class="token operator">=</span> minlen<span class="token punctuation">;</span>
          <span class="token comment">// if you want the height of all of the lanes to remain at the maximum height ever needed:</span>
          <span class="token comment">//shape.height = (isNaN(shape.height) ? minlen : Math.max(shape.height, minlen));</span>
          <span class="token keyword">const</span> cell <span class="token operator">=</span> lane<span class="token punctuation">.</span>resizeCellSize<span class="token punctuation">;</span>
          <span class="token keyword">if</span> <span class="token punctuation">(</span><span class="token operator">!</span><span class="token function">isNaN</span><span class="token punctuation">(</span>shape<span class="token punctuation">.</span>width<span class="token punctuation">)</span> <span class="token operator">&amp;&amp;</span> <span class="token operator">!</span><span class="token function">isNaN</span><span class="token punctuation">(</span>cell<span class="token punctuation">.</span>width<span class="token punctuation">)</span> <span class="token operator">&amp;&amp;</span> cell<span class="token punctuation">.</span>width <span class="token operator">&gt;</span> <span class="token number">0</span><span class="token punctuation">)</span> shape<span class="token punctuation">.</span>width <span class="token operator">=</span> Math<span class="token punctuation">.</span><span class="token function">ceil</span><span class="token punctuation">(</span>shape<span class="token punctuation">.</span>width <span class="token operator">/</span> cell<span class="token punctuation">.</span>width<span class="token punctuation">)</span> <span class="token operator">*</span> cell<span class="token punctuation">.</span>width<span class="token punctuation">;</span>
          <span class="token keyword">if</span> <span class="token punctuation">(</span><span class="token operator">!</span><span class="token function">isNaN</span><span class="token punctuation">(</span>shape<span class="token punctuation">.</span>height<span class="token punctuation">)</span> <span class="token operator">&amp;&amp;</span> <span class="token operator">!</span><span class="token function">isNaN</span><span class="token punctuation">(</span>cell<span class="token punctuation">.</span>height<span class="token punctuation">)</span> <span class="token operator">&amp;&amp;</span> cell<span class="token punctuation">.</span>height <span class="token operator">&gt;</span> <span class="token number">0</span><span class="token punctuation">)</span> shape<span class="token punctuation">.</span>height <span class="token operator">=</span> Math<span class="token punctuation">.</span><span class="token function">ceil</span><span class="token punctuation">(</span>shape<span class="token punctuation">.</span>height <span class="token operator">/</span> cell<span class="token punctuation">.</span>height<span class="token punctuation">)</span> <span class="token operator">*</span> cell<span class="token punctuation">.</span>height<span class="token punctuation">;</span>
        <span class="token punctuation">}</span>
      <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
      <span class="token comment">// now do all of the usual stuff, according to whatever properties have been set on this GridLayout</span>
      <span class="token keyword">super</span><span class="token punctuation">.</span><span class="token function">doLayout</span><span class="token punctuation">(</span>coll<span class="token punctuation">)</span><span class="token punctuation">;</span>
      diagram<span class="token punctuation">.</span><span class="token function">commitTransaction</span><span class="token punctuation">(</span><span class="token string">"PoolLayout"</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span><span class="token punctuation">;</span>

    <span class="token comment">// compute the minimum length of the whole diagram needed to hold all of the Lane Groups</span>
    <span class="token function">computeMinPoolLength</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{</span>
      <span class="token keyword">let</span> len <span class="token operator">=</span> <span class="token keyword">this</span><span class="token punctuation">.</span><span class="token constant">MINLENGTH</span><span class="token punctuation">;</span>
      myDiagram<span class="token punctuation">.</span><span class="token function">findTopLevelGroups</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">.</span><span class="token function">each</span><span class="token punctuation">(</span><span class="token parameter">lane</span> <span class="token operator">=&gt;</span> <span class="token punctuation">{</span>
        <span class="token keyword">const</span> holder <span class="token operator">=</span> lane<span class="token punctuation">.</span>placeholder<span class="token punctuation">;</span>
        <span class="token keyword">if</span> <span class="token punctuation">(</span>holder <span class="token operator">!==</span> <span class="token keyword">null</span><span class="token punctuation">)</span> <span class="token punctuation">{</span>
          <span class="token keyword">const</span> sz <span class="token operator">=</span> holder<span class="token punctuation">.</span>actualBounds<span class="token punctuation">;</span>
          len <span class="token operator">=</span> Math<span class="token punctuation">.</span><span class="token function">max</span><span class="token punctuation">(</span>len<span class="token punctuation">,</span> sz<span class="token punctuation">.</span>height<span class="token punctuation">)</span><span class="token punctuation">;</span>
        <span class="token punctuation">}</span>
      <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
      <span class="token keyword">return</span> len<span class="token punctuation">;</span>
    <span class="token punctuation">}</span>

    <span class="token comment">// compute the minimum size for a particular Lane Group</span>
    <span class="token function">computeLaneSize</span><span class="token punctuation">(</span><span class="token parameter">lane</span><span class="token punctuation">)</span> <span class="token punctuation">{</span>
      <span class="token comment">// assert(lane instanceof go.Group);</span>
      <span class="token keyword">const</span> sz <span class="token operator">=</span> <span class="token keyword">new</span> <span class="token class-name">go<span class="token punctuation">.</span>Size</span><span class="token punctuation">(</span>lane<span class="token punctuation">.</span>isSubGraphExpanded <span class="token operator">?</span> <span class="token keyword">this</span><span class="token punctuation">.</span><span class="token constant">MINBREADTH</span> <span class="token operator">:</span> <span class="token number">1</span><span class="token punctuation">,</span> <span class="token keyword">this</span><span class="token punctuation">.</span><span class="token constant">MINLENGTH</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
      <span class="token keyword">if</span> <span class="token punctuation">(</span>lane<span class="token punctuation">.</span>isSubGraphExpanded<span class="token punctuation">)</span> <span class="token punctuation">{</span>
        <span class="token keyword">const</span> holder <span class="token operator">=</span> lane<span class="token punctuation">.</span>placeholder<span class="token punctuation">;</span>
        <span class="token keyword">if</span> <span class="token punctuation">(</span>holder <span class="token operator">!==</span> <span class="token keyword">null</span><span class="token punctuation">)</span> <span class="token punctuation">{</span>
          <span class="token keyword">const</span> hsz <span class="token operator">=</span> holder<span class="token punctuation">.</span>actualBounds<span class="token punctuation">;</span>
          sz<span class="token punctuation">.</span>width <span class="token operator">=</span> Math<span class="token punctuation">.</span><span class="token function">max</span><span class="token punctuation">(</span>sz<span class="token punctuation">.</span>width<span class="token punctuation">,</span> hsz<span class="token punctuation">.</span>width<span class="token punctuation">)</span><span class="token punctuation">;</span>
        <span class="token punctuation">}</span>
      <span class="token punctuation">}</span>
      <span class="token comment">// minimum breadth needs to be big enough to hold the header</span>
      <span class="token keyword">const</span> hdr <span class="token operator">=</span> lane<span class="token punctuation">.</span><span class="token function">findObject</span><span class="token punctuation">(</span><span class="token string">"HEADER"</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
      <span class="token keyword">if</span> <span class="token punctuation">(</span>hdr <span class="token operator">!==</span> <span class="token keyword">null</span><span class="token punctuation">)</span> sz<span class="token punctuation">.</span>width <span class="token operator">=</span> Math<span class="token punctuation">.</span><span class="token function">max</span><span class="token punctuation">(</span>sz<span class="token punctuation">.</span>width<span class="token punctuation">,</span> hdr<span class="token punctuation">.</span>actualBounds<span class="token punctuation">.</span>width<span class="token punctuation">)</span><span class="token punctuation">;</span>
      <span class="token keyword">return</span> sz<span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
  <span class="token punctuation">}</span>
  <span class="token comment">// end PoolLayout class</span>


    <span class="token keyword">function</span> <span class="token function">init</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{</span>

      <span class="token comment">// Since 2.2 you can also author concise templates with method chaining instead of GraphObject.make</span>
      <span class="token comment">// For details, see https://gojs.net/latest/intro/buildingObjects.html</span>
      <span class="token keyword">const</span> $ <span class="token operator">=</span> go<span class="token punctuation">.</span>GraphObject<span class="token punctuation">.</span>make<span class="token punctuation">;</span>

      myDiagram <span class="token operator">=</span>
        <span class="token function">$</span><span class="token punctuation">(</span>go<span class="token punctuation">.</span>Diagram<span class="token punctuation">,</span> <span class="token string">"myDiagramDiv"</span><span class="token punctuation">,</span>
          <span class="token punctuation">{</span>
            <span class="token comment">// make sure the top-left corner of the viewport is occupied</span>
            contentAlignment<span class="token operator">:</span> go<span class="token punctuation">.</span>Spot<span class="token punctuation">.</span>TopLeft<span class="token punctuation">,</span>
            <span class="token comment">// use a simple layout to stack the top-level Groups next to each other</span>
            layout<span class="token operator">:</span> <span class="token function">$</span><span class="token punctuation">(</span>PoolLayout<span class="token punctuation">)</span><span class="token punctuation">,</span>
            <span class="token comment">// disallow nodes to be dragged to the diagram's background</span>
            <span class="token function-variable function">mouseDrop</span><span class="token operator">:</span> <span class="token parameter">e</span> <span class="token operator">=&gt;</span> <span class="token punctuation">{</span>
              e<span class="token punctuation">.</span>diagram<span class="token punctuation">.</span>currentTool<span class="token punctuation">.</span><span class="token function">doCancel</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
            <span class="token punctuation">}</span><span class="token punctuation">,</span>
            <span class="token comment">// a clipboard copied node is pasted into the original node's group (i.e. lane).</span>
            <span class="token string">"commandHandler.copiesGroupKey"</span><span class="token operator">:</span> <span class="token boolean">true</span><span class="token punctuation">,</span>
            <span class="token comment">// automatically re-layout the swim lanes after dragging the selection</span>
            <span class="token string">"SelectionMoved"</span><span class="token operator">:</span> relayoutDiagram<span class="token punctuation">,</span>  <span class="token comment">// this DiagramEvent listener is</span>
            <span class="token string">"SelectionCopied"</span><span class="token operator">:</span> relayoutDiagram<span class="token punctuation">,</span> <span class="token comment">// defined above</span>
            <span class="token string">"undoManager.isEnabled"</span><span class="token operator">:</span> <span class="token boolean">true</span><span class="token punctuation">,</span>
            <span class="token comment">// allow TextEditingTool to start without selecting first</span>
            <span class="token string">"textEditingTool.starting"</span><span class="token operator">:</span> go<span class="token punctuation">.</span>TextEditingTool<span class="token punctuation">.</span>SingleClick
          <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

      <span class="token comment">// Customize the dragging tool:</span>
      <span class="token comment">// When dragging a node set its opacity to 0.6 and move it to be in front of other nodes</span>
      myDiagram<span class="token punctuation">.</span>toolManager<span class="token punctuation">.</span>draggingTool<span class="token punctuation">.</span><span class="token function-variable function">doActivate</span> <span class="token operator">=</span> <span class="token keyword">function</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{</span>
        go<span class="token punctuation">.</span><span class="token class-name">DraggingTool</span><span class="token punctuation">.</span>prototype<span class="token punctuation">.</span><span class="token function">doActivate</span><span class="token punctuation">.</span><span class="token function">call</span><span class="token punctuation">(</span><span class="token keyword">this</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
        <span class="token keyword">this</span><span class="token punctuation">.</span>currentPart<span class="token punctuation">.</span>opacity <span class="token operator">=</span> <span class="token number">0.6</span><span class="token punctuation">;</span>
        <span class="token keyword">this</span><span class="token punctuation">.</span>currentPart<span class="token punctuation">.</span>layerName <span class="token operator">=</span> <span class="token string">"Foreground"</span><span class="token punctuation">;</span>
      <span class="token punctuation">}</span>
      myDiagram<span class="token punctuation">.</span>toolManager<span class="token punctuation">.</span>draggingTool<span class="token punctuation">.</span><span class="token function-variable function">doDeactivate</span> <span class="token operator">=</span> <span class="token keyword">function</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{</span>
        <span class="token keyword">this</span><span class="token punctuation">.</span>currentPart<span class="token punctuation">.</span>opacity <span class="token operator">=</span> <span class="token number">1</span><span class="token punctuation">;</span>
        <span class="token keyword">this</span><span class="token punctuation">.</span>currentPart<span class="token punctuation">.</span>layerName <span class="token operator">=</span> <span class="token string">""</span><span class="token punctuation">;</span>
        go<span class="token punctuation">.</span><span class="token class-name">DraggingTool</span><span class="token punctuation">.</span>prototype<span class="token punctuation">.</span><span class="token function">doDeactivate</span><span class="token punctuation">.</span><span class="token function">call</span><span class="token punctuation">(</span><span class="token keyword">this</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
      <span class="token punctuation">}</span>

      <span class="token comment">// this is called after nodes have been moved</span>
      <span class="token keyword">function</span> <span class="token function">relayoutDiagram</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{</span>
        myDiagram<span class="token punctuation">.</span>selection<span class="token punctuation">.</span><span class="token function">each</span><span class="token punctuation">(</span><span class="token parameter">n</span> <span class="token operator">=&gt;</span> n<span class="token punctuation">.</span><span class="token function">invalidateLayout</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
        myDiagram<span class="token punctuation">.</span><span class="token function">layoutDiagram</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
      <span class="token punctuation">}</span>

      <span class="token comment">// There are only three note colors by default, blue, red, and yellow but you could add more here:</span>
      <span class="token keyword">const</span> noteColors <span class="token operator">=</span> <span class="token punctuation">[</span><span class="token string">'#009CCC'</span><span class="token punctuation">,</span> <span class="token string">'#CC293D'</span><span class="token punctuation">,</span> <span class="token string">'#FFD700'</span><span class="token punctuation">]</span><span class="token punctuation">;</span>
      <span class="token keyword">function</span> <span class="token function">getNoteColor</span><span class="token punctuation">(</span><span class="token parameter">num</span><span class="token punctuation">)</span> <span class="token punctuation">{</span>
        <span class="token keyword">return</span> noteColors<span class="token punctuation">[</span>Math<span class="token punctuation">.</span><span class="token function">min</span><span class="token punctuation">(</span>num<span class="token punctuation">,</span> noteColors<span class="token punctuation">.</span>length <span class="token operator">-</span> <span class="token number">1</span><span class="token punctuation">)</span><span class="token punctuation">]</span><span class="token punctuation">;</span>
      <span class="token punctuation">}</span>

      myDiagram<span class="token punctuation">.</span>nodeTemplate <span class="token operator">=</span>
        <span class="token function">$</span><span class="token punctuation">(</span>go<span class="token punctuation">.</span>Node<span class="token punctuation">,</span> <span class="token string">"Horizontal"</span><span class="token punctuation">,</span>
          <span class="token keyword">new</span> <span class="token class-name">go<span class="token punctuation">.</span>Binding</span><span class="token punctuation">(</span><span class="token string">"location"</span><span class="token punctuation">,</span> <span class="token string">"loc"</span><span class="token punctuation">,</span> go<span class="token punctuation">.</span>Point<span class="token punctuation">.</span>parse<span class="token punctuation">)</span><span class="token punctuation">.</span><span class="token function">makeTwoWay</span><span class="token punctuation">(</span>go<span class="token punctuation">.</span>Point<span class="token punctuation">.</span>stringify<span class="token punctuation">)</span><span class="token punctuation">,</span>
          <span class="token function">$</span><span class="token punctuation">(</span>go<span class="token punctuation">.</span>Shape<span class="token punctuation">,</span> <span class="token string">"Rectangle"</span><span class="token punctuation">,</span> <span class="token punctuation">{</span>
            fill<span class="token operator">:</span> <span class="token string">'#009CCC'</span><span class="token punctuation">,</span> strokeWidth<span class="token operator">:</span> <span class="token number">1</span><span class="token punctuation">,</span> stroke<span class="token operator">:</span> <span class="token string">'#009CCC'</span><span class="token punctuation">,</span>
            width<span class="token operator">:</span> <span class="token number">6</span><span class="token punctuation">,</span> stretch<span class="token operator">:</span> go<span class="token punctuation">.</span>GraphObject<span class="token punctuation">.</span>Vertical<span class="token punctuation">,</span> alignment<span class="token operator">:</span> go<span class="token punctuation">.</span>Spot<span class="token punctuation">.</span>Left<span class="token punctuation">,</span>
            <span class="token comment">// if a user clicks the colored portion of a node, cycle through colors</span>
            <span class="token function-variable function">click</span><span class="token operator">:</span> <span class="token punctuation">(</span><span class="token parameter">e<span class="token punctuation">,</span> obj</span><span class="token punctuation">)</span> <span class="token operator">=&gt;</span> <span class="token punctuation">{</span>
              myDiagram<span class="token punctuation">.</span><span class="token function">startTransaction</span><span class="token punctuation">(</span><span class="token string">"Update node color"</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
              <span class="token keyword">let</span> newColor <span class="token operator">=</span> <span class="token function">parseInt</span><span class="token punctuation">(</span>obj<span class="token punctuation">.</span>part<span class="token punctuation">.</span>data<span class="token punctuation">.</span>color<span class="token punctuation">)</span> <span class="token operator">+</span> <span class="token number">1</span><span class="token punctuation">;</span>
              <span class="token keyword">if</span> <span class="token punctuation">(</span>newColor <span class="token operator">&gt;</span> noteColors<span class="token punctuation">.</span>length <span class="token operator">-</span> <span class="token number">1</span><span class="token punctuation">)</span> newColor <span class="token operator">=</span> <span class="token number">0</span><span class="token punctuation">;</span>
              myDiagram<span class="token punctuation">.</span>model<span class="token punctuation">.</span><span class="token function">setDataProperty</span><span class="token punctuation">(</span>obj<span class="token punctuation">.</span>part<span class="token punctuation">.</span>data<span class="token punctuation">,</span> <span class="token string">"color"</span><span class="token punctuation">,</span> newColor<span class="token punctuation">)</span><span class="token punctuation">;</span>
              myDiagram<span class="token punctuation">.</span><span class="token function">commitTransaction</span><span class="token punctuation">(</span><span class="token string">"Update node color"</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
            <span class="token punctuation">}</span>
          <span class="token punctuation">}</span><span class="token punctuation">,</span>
            <span class="token keyword">new</span> <span class="token class-name">go<span class="token punctuation">.</span>Binding</span><span class="token punctuation">(</span><span class="token string">"fill"</span><span class="token punctuation">,</span> <span class="token string">"color"</span><span class="token punctuation">,</span> getNoteColor<span class="token punctuation">)</span><span class="token punctuation">,</span>
            <span class="token keyword">new</span> <span class="token class-name">go<span class="token punctuation">.</span>Binding</span><span class="token punctuation">(</span><span class="token string">"stroke"</span><span class="token punctuation">,</span> <span class="token string">"color"</span><span class="token punctuation">,</span> getNoteColor<span class="token punctuation">)</span>
          <span class="token punctuation">)</span><span class="token punctuation">,</span>
          <span class="token function">$</span><span class="token punctuation">(</span>go<span class="token punctuation">.</span>Panel<span class="token punctuation">,</span> <span class="token string">"Auto"</span><span class="token punctuation">,</span>
            <span class="token function">$</span><span class="token punctuation">(</span>go<span class="token punctuation">.</span>Shape<span class="token punctuation">,</span> <span class="token string">"Rectangle"</span><span class="token punctuation">,</span> <span class="token punctuation">{</span> fill<span class="token operator">:</span> <span class="token string">"white"</span><span class="token punctuation">,</span> stroke<span class="token operator">:</span> <span class="token string">'#CCCCCC'</span> <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">,</span>
            <span class="token function">$</span><span class="token punctuation">(</span>go<span class="token punctuation">.</span>Panel<span class="token punctuation">,</span> <span class="token string">"Table"</span><span class="token punctuation">,</span>
              <span class="token punctuation">{</span> width<span class="token operator">:</span> <span class="token number">130</span><span class="token punctuation">,</span> minSize<span class="token operator">:</span> <span class="token keyword">new</span> <span class="token class-name">go<span class="token punctuation">.</span>Size</span><span class="token punctuation">(</span><span class="token number">NaN</span><span class="token punctuation">,</span> <span class="token number">50</span><span class="token punctuation">)</span> <span class="token punctuation">}</span><span class="token punctuation">,</span>
              <span class="token function">$</span><span class="token punctuation">(</span>go<span class="token punctuation">.</span>TextBlock<span class="token punctuation">,</span>
                <span class="token punctuation">{</span>
                  name<span class="token operator">:</span> <span class="token string">'TEXT'</span><span class="token punctuation">,</span>
                  margin<span class="token operator">:</span> <span class="token number">6</span><span class="token punctuation">,</span> font<span class="token operator">:</span> <span class="token string">'11px Lato, sans-serif'</span><span class="token punctuation">,</span> editable<span class="token operator">:</span> <span class="token boolean">true</span><span class="token punctuation">,</span>
                  stroke<span class="token operator">:</span> <span class="token string">"#000"</span><span class="token punctuation">,</span> maxSize<span class="token operator">:</span> <span class="token keyword">new</span> <span class="token class-name">go<span class="token punctuation">.</span>Size</span><span class="token punctuation">(</span><span class="token number">130</span><span class="token punctuation">,</span> <span class="token number">NaN</span><span class="token punctuation">)</span><span class="token punctuation">,</span>
                  alignment<span class="token operator">:</span> go<span class="token punctuation">.</span>Spot<span class="token punctuation">.</span>TopLeft
                <span class="token punctuation">}</span><span class="token punctuation">,</span>
                <span class="token keyword">new</span> <span class="token class-name">go<span class="token punctuation">.</span>Binding</span><span class="token punctuation">(</span><span class="token string">"text"</span><span class="token punctuation">,</span> <span class="token string">"text"</span><span class="token punctuation">)</span><span class="token punctuation">.</span><span class="token function">makeTwoWay</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">)</span>
            <span class="token punctuation">)</span>
          <span class="token punctuation">)</span>
        <span class="token punctuation">)</span><span class="token punctuation">;</span>

      <span class="token comment">// unmovable node that acts as a button</span>
      myDiagram<span class="token punctuation">.</span>nodeTemplateMap<span class="token punctuation">.</span><span class="token function">add</span><span class="token punctuation">(</span><span class="token string">'newbutton'</span><span class="token punctuation">,</span>
        <span class="token function">$</span><span class="token punctuation">(</span>go<span class="token punctuation">.</span>Node<span class="token punctuation">,</span> <span class="token string">"Horizontal"</span><span class="token punctuation">,</span>
          <span class="token keyword">new</span> <span class="token class-name">go<span class="token punctuation">.</span>Binding</span><span class="token punctuation">(</span><span class="token string">"location"</span><span class="token punctuation">,</span> <span class="token string">"loc"</span><span class="token punctuation">,</span> go<span class="token punctuation">.</span>Point<span class="token punctuation">.</span>parse<span class="token punctuation">)</span><span class="token punctuation">.</span><span class="token function">makeTwoWay</span><span class="token punctuation">(</span>go<span class="token punctuation">.</span>Point<span class="token punctuation">.</span>stringify<span class="token punctuation">)</span><span class="token punctuation">,</span>
          <span class="token punctuation">{</span>
            selectable<span class="token operator">:</span> <span class="token boolean">false</span><span class="token punctuation">,</span>
            <span class="token function-variable function">click</span><span class="token operator">:</span> <span class="token punctuation">(</span><span class="token parameter">e<span class="token punctuation">,</span> node</span><span class="token punctuation">)</span> <span class="token operator">=&gt;</span> <span class="token punctuation">{</span>
              myDiagram<span class="token punctuation">.</span><span class="token function">startTransaction</span><span class="token punctuation">(</span><span class="token string">'add node'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
              <span class="token keyword">const</span> newdata <span class="token operator">=</span> <span class="token punctuation">{</span> group<span class="token operator">:</span> <span class="token string">"Problems"</span><span class="token punctuation">,</span> loc<span class="token operator">:</span> <span class="token string">"0 50"</span><span class="token punctuation">,</span> text<span class="token operator">:</span> <span class="token string">"New item "</span> <span class="token operator">+</span> node<span class="token punctuation">.</span>containingGroup<span class="token punctuation">.</span>memberParts<span class="token punctuation">.</span>count<span class="token punctuation">,</span> color<span class="token operator">:</span> <span class="token number">0</span> <span class="token punctuation">}</span><span class="token punctuation">;</span>
              myDiagram<span class="token punctuation">.</span>model<span class="token punctuation">.</span><span class="token function">addNodeData</span><span class="token punctuation">(</span>newdata<span class="token punctuation">)</span><span class="token punctuation">;</span>
              myDiagram<span class="token punctuation">.</span><span class="token function">commitTransaction</span><span class="token punctuation">(</span><span class="token string">'add node'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
              <span class="token keyword">const</span> newnode <span class="token operator">=</span> myDiagram<span class="token punctuation">.</span><span class="token function">findNodeForData</span><span class="token punctuation">(</span>newdata<span class="token punctuation">)</span><span class="token punctuation">;</span>
              myDiagram<span class="token punctuation">.</span><span class="token function">select</span><span class="token punctuation">(</span>newnode<span class="token punctuation">)</span><span class="token punctuation">;</span>
              myDiagram<span class="token punctuation">.</span>commandHandler<span class="token punctuation">.</span><span class="token function">editTextBlock</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
            <span class="token punctuation">}</span><span class="token punctuation">,</span>
            background<span class="token operator">:</span> <span class="token string">'white'</span>
          <span class="token punctuation">}</span><span class="token punctuation">,</span>
          <span class="token function">$</span><span class="token punctuation">(</span>go<span class="token punctuation">.</span>Panel<span class="token punctuation">,</span> <span class="token string">"Auto"</span><span class="token punctuation">,</span>
            <span class="token function">$</span><span class="token punctuation">(</span>go<span class="token punctuation">.</span>Shape<span class="token punctuation">,</span> <span class="token string">"Rectangle"</span><span class="token punctuation">,</span> <span class="token punctuation">{</span> strokeWidth<span class="token operator">:</span> <span class="token number">0</span><span class="token punctuation">,</span> stroke<span class="token operator">:</span> <span class="token keyword">null</span><span class="token punctuation">,</span> fill<span class="token operator">:</span> <span class="token string">'#6FB583'</span> <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">,</span>
            <span class="token function">$</span><span class="token punctuation">(</span>go<span class="token punctuation">.</span>Shape<span class="token punctuation">,</span> <span class="token string">"PlusLine"</span><span class="token punctuation">,</span> <span class="token punctuation">{</span> margin<span class="token operator">:</span> <span class="token number">6</span><span class="token punctuation">,</span> strokeWidth<span class="token operator">:</span> <span class="token number">2</span><span class="token punctuation">,</span> width<span class="token operator">:</span> <span class="token number">12</span><span class="token punctuation">,</span> height<span class="token operator">:</span> <span class="token number">12</span><span class="token punctuation">,</span> stroke<span class="token operator">:</span> <span class="token string">'white'</span><span class="token punctuation">,</span> background<span class="token operator">:</span> <span class="token string">'#6FB583'</span> <span class="token punctuation">}</span><span class="token punctuation">)</span>
          <span class="token punctuation">)</span><span class="token punctuation">,</span>
          <span class="token function">$</span><span class="token punctuation">(</span>go<span class="token punctuation">.</span>TextBlock<span class="token punctuation">,</span> <span class="token string">"New item"</span><span class="token punctuation">,</span> <span class="token punctuation">{</span> font<span class="token operator">:</span> <span class="token string">'10px Lato, sans-serif'</span><span class="token punctuation">,</span> margin<span class="token operator">:</span> <span class="token number">6</span><span class="token punctuation">,</span> <span class="token punctuation">}</span><span class="token punctuation">)</span>
        <span class="token punctuation">)</span>
      <span class="token punctuation">)</span><span class="token punctuation">;</span>

      <span class="token comment">// While dragging, highlight the dragged-over group</span>
      <span class="token keyword">function</span> <span class="token function">highlightGroup</span><span class="token punctuation">(</span><span class="token parameter">grp<span class="token punctuation">,</span> show</span><span class="token punctuation">)</span> <span class="token punctuation">{</span>
        <span class="token keyword">if</span> <span class="token punctuation">(</span>show<span class="token punctuation">)</span> <span class="token punctuation">{</span>
          <span class="token keyword">const</span> part <span class="token operator">=</span> myDiagram<span class="token punctuation">.</span>toolManager<span class="token punctuation">.</span>draggingTool<span class="token punctuation">.</span>currentPart<span class="token punctuation">;</span>
          <span class="token keyword">if</span> <span class="token punctuation">(</span>part<span class="token punctuation">.</span>containingGroup <span class="token operator">!==</span> grp<span class="token punctuation">)</span> <span class="token punctuation">{</span>
            grp<span class="token punctuation">.</span>isHighlighted <span class="token operator">=</span> <span class="token boolean">true</span><span class="token punctuation">;</span>
            <span class="token keyword">return</span><span class="token punctuation">;</span>
          <span class="token punctuation">}</span>
        <span class="token punctuation">}</span>
        grp<span class="token punctuation">.</span>isHighlighted <span class="token operator">=</span> <span class="token boolean">false</span><span class="token punctuation">;</span>
      <span class="token punctuation">}</span>

      myDiagram<span class="token punctuation">.</span>groupTemplate <span class="token operator">=</span>
        <span class="token function">$</span><span class="token punctuation">(</span>go<span class="token punctuation">.</span>Group<span class="token punctuation">,</span> <span class="token string">"Vertical"</span><span class="token punctuation">,</span>
          <span class="token punctuation">{</span>
            selectable<span class="token operator">:</span> <span class="token boolean">false</span><span class="token punctuation">,</span>
            selectionObjectName<span class="token operator">:</span> <span class="token string">"SHAPE"</span><span class="token punctuation">,</span> <span class="token comment">// even though its not selectable, this is used in the layout</span>
            layerName<span class="token operator">:</span> <span class="token string">"Background"</span><span class="token punctuation">,</span>  <span class="token comment">// all lanes are always behind all nodes and links</span>
            layout<span class="token operator">:</span> <span class="token function">$</span><span class="token punctuation">(</span>go<span class="token punctuation">.</span>GridLayout<span class="token punctuation">,</span>  <span class="token comment">// automatically lay out the lane's subgraph</span>
              <span class="token punctuation">{</span>
                wrappingColumn<span class="token operator">:</span> <span class="token number">1</span><span class="token punctuation">,</span>
                cellSize<span class="token operator">:</span> <span class="token keyword">new</span> <span class="token class-name">go<span class="token punctuation">.</span>Size</span><span class="token punctuation">(</span><span class="token number">1</span><span class="token punctuation">,</span> <span class="token number">1</span><span class="token punctuation">)</span><span class="token punctuation">,</span>
                spacing<span class="token operator">:</span> <span class="token keyword">new</span> <span class="token class-name">go<span class="token punctuation">.</span>Size</span><span class="token punctuation">(</span><span class="token number">5</span><span class="token punctuation">,</span> <span class="token number">5</span><span class="token punctuation">)</span><span class="token punctuation">,</span>
                alignment<span class="token operator">:</span> go<span class="token punctuation">.</span>GridLayout<span class="token punctuation">.</span>Position<span class="token punctuation">,</span>
                <span class="token function-variable function">comparer</span><span class="token operator">:</span> <span class="token punctuation">(</span><span class="token parameter">a<span class="token punctuation">,</span> b</span><span class="token punctuation">)</span> <span class="token operator">=&gt;</span> <span class="token punctuation">{</span>  <span class="token comment">// can re-order tasks within a lane</span>
                  <span class="token keyword">const</span> ay <span class="token operator">=</span> a<span class="token punctuation">.</span>location<span class="token punctuation">.</span>y<span class="token punctuation">;</span>
                  <span class="token keyword">const</span> by <span class="token operator">=</span> b<span class="token punctuation">.</span>location<span class="token punctuation">.</span>y<span class="token punctuation">;</span>
                  <span class="token keyword">if</span> <span class="token punctuation">(</span><span class="token function">isNaN</span><span class="token punctuation">(</span>ay<span class="token punctuation">)</span> <span class="token operator">||</span> <span class="token function">isNaN</span><span class="token punctuation">(</span>by<span class="token punctuation">)</span><span class="token punctuation">)</span> <span class="token keyword">return</span> <span class="token number">0</span><span class="token punctuation">;</span>
                  <span class="token keyword">if</span> <span class="token punctuation">(</span>ay <span class="token operator">&lt;</span> by<span class="token punctuation">)</span> <span class="token keyword">return</span> <span class="token operator">-</span><span class="token number">1</span><span class="token punctuation">;</span>
                  <span class="token keyword">if</span> <span class="token punctuation">(</span>ay <span class="token operator">&gt;</span> by<span class="token punctuation">)</span> <span class="token keyword">return</span> <span class="token number">1</span><span class="token punctuation">;</span>
                  <span class="token keyword">return</span> <span class="token number">0</span><span class="token punctuation">;</span>
                <span class="token punctuation">}</span>
              <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">,</span>
            <span class="token function-variable function">click</span><span class="token operator">:</span> <span class="token punctuation">(</span><span class="token parameter">e<span class="token punctuation">,</span> grp</span><span class="token punctuation">)</span> <span class="token operator">=&gt;</span> <span class="token punctuation">{</span>  <span class="token comment">// allow simple click on group to clear selection</span>
              <span class="token keyword">if</span> <span class="token punctuation">(</span><span class="token operator">!</span>e<span class="token punctuation">.</span>shift <span class="token operator">&amp;&amp;</span> <span class="token operator">!</span>e<span class="token punctuation">.</span>control <span class="token operator">&amp;&amp;</span> <span class="token operator">!</span>e<span class="token punctuation">.</span>meta<span class="token punctuation">)</span> e<span class="token punctuation">.</span>diagram<span class="token punctuation">.</span><span class="token function">clearSelection</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
            <span class="token punctuation">}</span><span class="token punctuation">,</span>
            computesBoundsAfterDrag<span class="token operator">:</span> <span class="token boolean">true</span><span class="token punctuation">,</span>  <span class="token comment">// needed to prevent recomputing Group.placeholder bounds too soon</span>
            handlesDragDropForMembers<span class="token operator">:</span> <span class="token boolean">true</span><span class="token punctuation">,</span>  <span class="token comment">// don't need to define handlers on member Nodes and Links</span>
            <span class="token function-variable function">mouseDragEnter</span><span class="token operator">:</span> <span class="token punctuation">(</span><span class="token parameter">e<span class="token punctuation">,</span> grp<span class="token punctuation">,</span> prev</span><span class="token punctuation">)</span> <span class="token operator">=&gt;</span> <span class="token function">highlightGroup</span><span class="token punctuation">(</span>grp<span class="token punctuation">,</span> <span class="token boolean">true</span><span class="token punctuation">)</span><span class="token punctuation">,</span>
            <span class="token function-variable function">mouseDragLeave</span><span class="token operator">:</span> <span class="token punctuation">(</span><span class="token parameter">e<span class="token punctuation">,</span> grp<span class="token punctuation">,</span> next</span><span class="token punctuation">)</span> <span class="token operator">=&gt;</span> <span class="token function">highlightGroup</span><span class="token punctuation">(</span>grp<span class="token punctuation">,</span> <span class="token boolean">false</span><span class="token punctuation">)</span><span class="token punctuation">,</span>
            <span class="token function-variable function">mouseDrop</span><span class="token operator">:</span> <span class="token punctuation">(</span><span class="token parameter">e<span class="token punctuation">,</span> grp</span><span class="token punctuation">)</span> <span class="token operator">=&gt;</span> <span class="token punctuation">{</span>  <span class="token comment">// dropping a copy of some Nodes and Links onto this Group adds them to this Group</span>
              <span class="token comment">// don't allow drag-and-dropping a mix of regular Nodes and Groups</span>
              <span class="token keyword">if</span> <span class="token punctuation">(</span>e<span class="token punctuation">.</span>diagram<span class="token punctuation">.</span>selection<span class="token punctuation">.</span><span class="token function">all</span><span class="token punctuation">(</span><span class="token parameter">n</span> <span class="token operator">=&gt;</span> <span class="token operator">!</span><span class="token punctuation">(</span>n <span class="token keyword">instanceof</span> <span class="token class-name">go<span class="token punctuation">.</span>Group</span><span class="token punctuation">)</span><span class="token punctuation">)</span><span class="token punctuation">)</span> <span class="token punctuation">{</span>
                <span class="token keyword">const</span> ok <span class="token operator">=</span> grp<span class="token punctuation">.</span><span class="token function">addMembers</span><span class="token punctuation">(</span>grp<span class="token punctuation">.</span>diagram<span class="token punctuation">.</span>selection<span class="token punctuation">,</span> <span class="token boolean">true</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
                <span class="token keyword">if</span> <span class="token punctuation">(</span><span class="token operator">!</span>ok<span class="token punctuation">)</span> grp<span class="token punctuation">.</span>diagram<span class="token punctuation">.</span>currentTool<span class="token punctuation">.</span><span class="token function">doCancel</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
              <span class="token punctuation">}</span>
            <span class="token punctuation">}</span><span class="token punctuation">,</span>
            <span class="token function-variable function">subGraphExpandedChanged</span><span class="token operator">:</span> <span class="token parameter">grp</span> <span class="token operator">=&gt;</span> <span class="token punctuation">{</span>
              <span class="token keyword">const</span> shp <span class="token operator">=</span> grp<span class="token punctuation">.</span>selectionObject<span class="token punctuation">;</span>
              <span class="token keyword">if</span> <span class="token punctuation">(</span>grp<span class="token punctuation">.</span>diagram<span class="token punctuation">.</span>undoManager<span class="token punctuation">.</span>isUndoingRedoing<span class="token punctuation">)</span> <span class="token keyword">return</span><span class="token punctuation">;</span>
              <span class="token keyword">if</span> <span class="token punctuation">(</span>grp<span class="token punctuation">.</span>isSubGraphExpanded<span class="token punctuation">)</span> <span class="token punctuation">{</span>
                shp<span class="token punctuation">.</span>width <span class="token operator">=</span> grp<span class="token punctuation">.</span>data<span class="token punctuation">.</span>savedBreadth<span class="token punctuation">;</span>
              <span class="token punctuation">}</span> <span class="token keyword">else</span> <span class="token punctuation">{</span>  <span class="token comment">// remember the original width</span>
                <span class="token keyword">if</span> <span class="token punctuation">(</span><span class="token operator">!</span><span class="token function">isNaN</span><span class="token punctuation">(</span>shp<span class="token punctuation">.</span>width<span class="token punctuation">)</span><span class="token punctuation">)</span> grp<span class="token punctuation">.</span>diagram<span class="token punctuation">.</span>model<span class="token punctuation">.</span><span class="token function">set</span><span class="token punctuation">(</span>grp<span class="token punctuation">.</span>data<span class="token punctuation">,</span> <span class="token string">"savedBreadth"</span><span class="token punctuation">,</span> shp<span class="token punctuation">.</span>width<span class="token punctuation">)</span><span class="token punctuation">;</span>
                shp<span class="token punctuation">.</span>width <span class="token operator">=</span> <span class="token number">NaN</span><span class="token punctuation">;</span>
              <span class="token punctuation">}</span>
            <span class="token punctuation">}</span>
          <span class="token punctuation">}</span><span class="token punctuation">,</span>
          <span class="token keyword">new</span> <span class="token class-name">go<span class="token punctuation">.</span>Binding</span><span class="token punctuation">(</span><span class="token string">"location"</span><span class="token punctuation">,</span> <span class="token string">"loc"</span><span class="token punctuation">,</span> go<span class="token punctuation">.</span>Point<span class="token punctuation">.</span>parse<span class="token punctuation">)</span><span class="token punctuation">.</span><span class="token function">makeTwoWay</span><span class="token punctuation">(</span>go<span class="token punctuation">.</span>Point<span class="token punctuation">.</span>stringify<span class="token punctuation">)</span><span class="token punctuation">,</span>
          <span class="token keyword">new</span> <span class="token class-name">go<span class="token punctuation">.</span>Binding</span><span class="token punctuation">(</span><span class="token string">"isSubGraphExpanded"</span><span class="token punctuation">,</span> <span class="token string">"expanded"</span><span class="token punctuation">)</span><span class="token punctuation">.</span><span class="token function">makeTwoWay</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">,</span>
          <span class="token comment">// the lane header consisting of a TextBlock and an expander button</span>
          <span class="token function">$</span><span class="token punctuation">(</span>go<span class="token punctuation">.</span>Panel<span class="token punctuation">,</span> <span class="token string">"Horizontal"</span><span class="token punctuation">,</span>
            <span class="token punctuation">{</span> name<span class="token operator">:</span> <span class="token string">"HEADER"</span><span class="token punctuation">,</span> alignment<span class="token operator">:</span> go<span class="token punctuation">.</span>Spot<span class="token punctuation">.</span>Left <span class="token punctuation">}</span><span class="token punctuation">,</span>
            <span class="token function">$</span><span class="token punctuation">(</span><span class="token string">"SubGraphExpanderButton"</span><span class="token punctuation">,</span> <span class="token punctuation">{</span> margin<span class="token operator">:</span> <span class="token number">5</span> <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">,</span>  <span class="token comment">// this remains always visible</span>
            <span class="token function">$</span><span class="token punctuation">(</span>go<span class="token punctuation">.</span>TextBlock<span class="token punctuation">,</span>  <span class="token comment">// the lane label</span>
              <span class="token punctuation">{</span> font<span class="token operator">:</span> <span class="token string">"15px Lato, sans-serif"</span><span class="token punctuation">,</span> editable<span class="token operator">:</span> <span class="token boolean">true</span><span class="token punctuation">,</span> margin<span class="token operator">:</span> <span class="token keyword">new</span> <span class="token class-name">go<span class="token punctuation">.</span>Margin</span><span class="token punctuation">(</span><span class="token number">2</span><span class="token punctuation">,</span> <span class="token number">0</span><span class="token punctuation">,</span> <span class="token number">0</span><span class="token punctuation">,</span> <span class="token number">0</span><span class="token punctuation">)</span> <span class="token punctuation">}</span><span class="token punctuation">,</span>
              <span class="token comment">// this is hidden when the swimlane is collapsed</span>
              <span class="token keyword">new</span> <span class="token class-name">go<span class="token punctuation">.</span>Binding</span><span class="token punctuation">(</span><span class="token string">"visible"</span><span class="token punctuation">,</span> <span class="token string">"isSubGraphExpanded"</span><span class="token punctuation">)</span><span class="token punctuation">.</span><span class="token function">ofObject</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">,</span>
              <span class="token keyword">new</span> <span class="token class-name">go<span class="token punctuation">.</span>Binding</span><span class="token punctuation">(</span><span class="token string">"text"</span><span class="token punctuation">)</span><span class="token punctuation">.</span><span class="token function">makeTwoWay</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">)</span>
          <span class="token punctuation">)</span><span class="token punctuation">,</span>  <span class="token comment">// end Horizontal Panel</span>
          <span class="token function">$</span><span class="token punctuation">(</span>go<span class="token punctuation">.</span>Panel<span class="token punctuation">,</span> <span class="token string">"Auto"</span><span class="token punctuation">,</span>  <span class="token comment">// the lane consisting of a background Shape and a Placeholder representing the subgraph</span>
            <span class="token function">$</span><span class="token punctuation">(</span>go<span class="token punctuation">.</span>Shape<span class="token punctuation">,</span> <span class="token string">"Rectangle"</span><span class="token punctuation">,</span>  <span class="token comment">// this is the resized object</span>
              <span class="token punctuation">{</span> name<span class="token operator">:</span> <span class="token string">"SHAPE"</span><span class="token punctuation">,</span> fill<span class="token operator">:</span> <span class="token string">"#F1F1F1"</span><span class="token punctuation">,</span> stroke<span class="token operator">:</span> <span class="token keyword">null</span><span class="token punctuation">,</span> strokeWidth<span class="token operator">:</span> <span class="token number">4</span> <span class="token punctuation">}</span><span class="token punctuation">,</span>  <span class="token comment">// strokeWidth controls space between lanes</span>
              <span class="token keyword">new</span> <span class="token class-name">go<span class="token punctuation">.</span>Binding</span><span class="token punctuation">(</span><span class="token string">"fill"</span><span class="token punctuation">,</span> <span class="token string">"isHighlighted"</span><span class="token punctuation">,</span> <span class="token parameter">h</span> <span class="token operator">=&gt;</span> h <span class="token operator">?</span> <span class="token string">"#D6D6D6"</span> <span class="token operator">:</span> <span class="token string">"#F1F1F1"</span><span class="token punctuation">)</span><span class="token punctuation">.</span><span class="token function">ofObject</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">,</span>
              <span class="token keyword">new</span> <span class="token class-name">go<span class="token punctuation">.</span>Binding</span><span class="token punctuation">(</span><span class="token string">"desiredSize"</span><span class="token punctuation">,</span> <span class="token string">"size"</span><span class="token punctuation">,</span> go<span class="token punctuation">.</span>Size<span class="token punctuation">.</span>parse<span class="token punctuation">)</span><span class="token punctuation">.</span><span class="token function">makeTwoWay</span><span class="token punctuation">(</span>go<span class="token punctuation">.</span>Size<span class="token punctuation">.</span>stringify<span class="token punctuation">)</span><span class="token punctuation">)</span><span class="token punctuation">,</span>
            <span class="token function">$</span><span class="token punctuation">(</span>go<span class="token punctuation">.</span>Placeholder<span class="token punctuation">,</span>
              <span class="token punctuation">{</span> padding<span class="token operator">:</span> <span class="token number">12</span><span class="token punctuation">,</span> alignment<span class="token operator">:</span> go<span class="token punctuation">.</span>Spot<span class="token punctuation">.</span>TopLeft <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">,</span>
            <span class="token function">$</span><span class="token punctuation">(</span>go<span class="token punctuation">.</span>TextBlock<span class="token punctuation">,</span>  <span class="token comment">// this TextBlock is only seen when the swimlane is collapsed</span>
              <span class="token punctuation">{</span>
                name<span class="token operator">:</span> <span class="token string">"LABEL"</span><span class="token punctuation">,</span> font<span class="token operator">:</span> <span class="token string">"15px Lato, sans-serif"</span><span class="token punctuation">,</span> editable<span class="token operator">:</span> <span class="token boolean">true</span><span class="token punctuation">,</span>
                angle<span class="token operator">:</span> <span class="token number">90</span><span class="token punctuation">,</span> alignment<span class="token operator">:</span> go<span class="token punctuation">.</span>Spot<span class="token punctuation">.</span>TopLeft<span class="token punctuation">,</span> margin<span class="token operator">:</span> <span class="token keyword">new</span> <span class="token class-name">go<span class="token punctuation">.</span>Margin</span><span class="token punctuation">(</span><span class="token number">4</span><span class="token punctuation">,</span> <span class="token number">0</span><span class="token punctuation">,</span> <span class="token number">0</span><span class="token punctuation">,</span> <span class="token number">2</span><span class="token punctuation">)</span>
              <span class="token punctuation">}</span><span class="token punctuation">,</span>
              <span class="token keyword">new</span> <span class="token class-name">go<span class="token punctuation">.</span>Binding</span><span class="token punctuation">(</span><span class="token string">"visible"</span><span class="token punctuation">,</span> <span class="token string">"isSubGraphExpanded"</span><span class="token punctuation">,</span> <span class="token parameter">e</span> <span class="token operator">=&gt;</span> <span class="token operator">!</span>e<span class="token punctuation">)</span><span class="token punctuation">.</span><span class="token function">ofObject</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">,</span>
              <span class="token keyword">new</span> <span class="token class-name">go<span class="token punctuation">.</span>Binding</span><span class="token punctuation">(</span><span class="token string">"text"</span><span class="token punctuation">)</span><span class="token punctuation">.</span><span class="token function">makeTwoWay</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">)</span>
          <span class="token punctuation">)</span>  <span class="token comment">// end Auto Panel</span>
        <span class="token punctuation">)</span><span class="token punctuation">;</span>  <span class="token comment">// end Group</span>

      <span class="token comment">// Set up an unmodeled Part as a legend, and place it directly on the diagram.</span>
      myDiagram<span class="token punctuation">.</span><span class="token function">add</span><span class="token punctuation">(</span>
        <span class="token function">$</span><span class="token punctuation">(</span>go<span class="token punctuation">.</span>Part<span class="token punctuation">,</span> <span class="token string">"Table"</span><span class="token punctuation">,</span>
          <span class="token punctuation">{</span> position<span class="token operator">:</span> <span class="token keyword">new</span> <span class="token class-name">go<span class="token punctuation">.</span>Point</span><span class="token punctuation">(</span><span class="token number">10</span><span class="token punctuation">,</span> <span class="token number">10</span><span class="token punctuation">)</span><span class="token punctuation">,</span> selectable<span class="token operator">:</span> <span class="token boolean">false</span> <span class="token punctuation">}</span><span class="token punctuation">,</span>
          <span class="token function">$</span><span class="token punctuation">(</span>go<span class="token punctuation">.</span>TextBlock<span class="token punctuation">,</span> <span class="token string">"Key"</span><span class="token punctuation">,</span>
            <span class="token punctuation">{</span> row<span class="token operator">:</span> <span class="token number">0</span><span class="token punctuation">,</span> font<span class="token operator">:</span> <span class="token string">"700 14px Droid Serif, sans-serif"</span> <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">,</span>  <span class="token comment">// end row 0</span>
          <span class="token function">$</span><span class="token punctuation">(</span>go<span class="token punctuation">.</span>Panel<span class="token punctuation">,</span> <span class="token string">"Horizontal"</span><span class="token punctuation">,</span>
            <span class="token punctuation">{</span> row<span class="token operator">:</span> <span class="token number">1</span><span class="token punctuation">,</span> alignment<span class="token operator">:</span> go<span class="token punctuation">.</span>Spot<span class="token punctuation">.</span>Left <span class="token punctuation">}</span><span class="token punctuation">,</span>
            <span class="token function">$</span><span class="token punctuation">(</span>go<span class="token punctuation">.</span>Shape<span class="token punctuation">,</span> <span class="token string">"Rectangle"</span><span class="token punctuation">,</span>
              <span class="token punctuation">{</span> desiredSize<span class="token operator">:</span> <span class="token keyword">new</span> <span class="token class-name">go<span class="token punctuation">.</span>Size</span><span class="token punctuation">(</span><span class="token number">10</span><span class="token punctuation">,</span> <span class="token number">10</span><span class="token punctuation">)</span><span class="token punctuation">,</span> fill<span class="token operator">:</span> <span class="token string">'#CC293D'</span><span class="token punctuation">,</span> margin<span class="token operator">:</span> <span class="token number">5</span> <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">,</span>
            <span class="token function">$</span><span class="token punctuation">(</span>go<span class="token punctuation">.</span>TextBlock<span class="token punctuation">,</span> <span class="token string">"Halted"</span><span class="token punctuation">,</span>
              <span class="token punctuation">{</span> font<span class="token operator">:</span> <span class="token string">"700 13px Droid Serif, sans-serif"</span> <span class="token punctuation">}</span><span class="token punctuation">)</span>
          <span class="token punctuation">)</span><span class="token punctuation">,</span>  <span class="token comment">// end row 1</span>
          <span class="token function">$</span><span class="token punctuation">(</span>go<span class="token punctuation">.</span>Panel<span class="token punctuation">,</span> <span class="token string">"Horizontal"</span><span class="token punctuation">,</span>
            <span class="token punctuation">{</span> row<span class="token operator">:</span> <span class="token number">2</span><span class="token punctuation">,</span> alignment<span class="token operator">:</span> go<span class="token punctuation">.</span>Spot<span class="token punctuation">.</span>Left <span class="token punctuation">}</span><span class="token punctuation">,</span>
            <span class="token function">$</span><span class="token punctuation">(</span>go<span class="token punctuation">.</span>Shape<span class="token punctuation">,</span> <span class="token string">"Rectangle"</span><span class="token punctuation">,</span>
              <span class="token punctuation">{</span> desiredSize<span class="token operator">:</span> <span class="token keyword">new</span> <span class="token class-name">go<span class="token punctuation">.</span>Size</span><span class="token punctuation">(</span><span class="token number">10</span><span class="token punctuation">,</span> <span class="token number">10</span><span class="token punctuation">)</span><span class="token punctuation">,</span> fill<span class="token operator">:</span> <span class="token string">'#FFD700'</span><span class="token punctuation">,</span> margin<span class="token operator">:</span> <span class="token number">5</span> <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">,</span>
            <span class="token function">$</span><span class="token punctuation">(</span>go<span class="token punctuation">.</span>TextBlock<span class="token punctuation">,</span> <span class="token string">"In Progress"</span><span class="token punctuation">,</span>
              <span class="token punctuation">{</span> font<span class="token operator">:</span> <span class="token string">"700 13px Droid Serif, sans-serif"</span> <span class="token punctuation">}</span><span class="token punctuation">)</span>
          <span class="token punctuation">)</span><span class="token punctuation">,</span>  <span class="token comment">// end row 2</span>
          <span class="token function">$</span><span class="token punctuation">(</span>go<span class="token punctuation">.</span>Panel<span class="token punctuation">,</span> <span class="token string">"Horizontal"</span><span class="token punctuation">,</span>
            <span class="token punctuation">{</span> row<span class="token operator">:</span> <span class="token number">3</span><span class="token punctuation">,</span> alignment<span class="token operator">:</span> go<span class="token punctuation">.</span>Spot<span class="token punctuation">.</span>Left <span class="token punctuation">}</span><span class="token punctuation">,</span>
            <span class="token function">$</span><span class="token punctuation">(</span>go<span class="token punctuation">.</span>Shape<span class="token punctuation">,</span> <span class="token string">"Rectangle"</span><span class="token punctuation">,</span>
              <span class="token punctuation">{</span> desiredSize<span class="token operator">:</span> <span class="token keyword">new</span> <span class="token class-name">go<span class="token punctuation">.</span>Size</span><span class="token punctuation">(</span><span class="token number">10</span><span class="token punctuation">,</span> <span class="token number">10</span><span class="token punctuation">)</span><span class="token punctuation">,</span> fill<span class="token operator">:</span> <span class="token string">'#009CCC'</span><span class="token punctuation">,</span> margin<span class="token operator">:</span> <span class="token number">5</span> <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">,</span>
            <span class="token function">$</span><span class="token punctuation">(</span>go<span class="token punctuation">.</span>TextBlock<span class="token punctuation">,</span> <span class="token string">"Completed"</span><span class="token punctuation">,</span>
              <span class="token punctuation">{</span> font<span class="token operator">:</span> <span class="token string">"700 13px Droid Serif, sans-serif"</span> <span class="token punctuation">}</span><span class="token punctuation">)</span>
          <span class="token punctuation">)</span>  <span class="token comment">// end row 3</span>
        <span class="token punctuation">)</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

      <span class="token function">load</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

    <span class="token punctuation">}</span>  <span class="token comment">// end init</span>

    <span class="token comment">// Show the diagram's model in JSON format</span>
    <span class="token keyword">function</span> <span class="token function">save</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{</span>
      document<span class="token punctuation">.</span><span class="token function">getElementById</span><span class="token punctuation">(</span><span class="token string">"mySavedModel"</span><span class="token punctuation">)</span><span class="token punctuation">.</span>value <span class="token operator">=</span> myDiagram<span class="token punctuation">.</span>model<span class="token punctuation">.</span><span class="token function">toJson</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
      myDiagram<span class="token punctuation">.</span>isModified <span class="token operator">=</span> <span class="token boolean">false</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
    <span class="token keyword">function</span> <span class="token function">load</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{</span>
      myDiagram<span class="token punctuation">.</span>model <span class="token operator">=</span> go<span class="token punctuation">.</span>Model<span class="token punctuation">.</span><span class="token function">fromJson</span><span class="token punctuation">(</span>document<span class="token punctuation">.</span><span class="token function">getElementById</span><span class="token punctuation">(</span><span class="token string">"mySavedModel"</span><span class="token punctuation">)</span><span class="token punctuation">.</span>value<span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
    window<span class="token punctuation">.</span><span class="token function">addEventListener</span><span class="token punctuation">(</span><span class="token string">'DOMContentLoaded'</span><span class="token punctuation">,</span> init<span class="token punctuation">)</span><span class="token punctuation">;</span>
  </pre></div>
  </body>
  </html>