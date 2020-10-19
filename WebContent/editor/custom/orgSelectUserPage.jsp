<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>表单</title>
		<jsp:include page="/form/admin/common/taglib.jsp" />
		<jsp:include page="/form/admin/common/resource.jsp" />
		
		<script type="text/javascript">
		window.onload = function(){
			//var parentId = Matrix.getFormItemValue("parentId");
			//main_iframe1.src = "<%=request.getContextPath()%>/mobile/showUser_loadDataGridData.action?parentId="+parentId;
		}
			function refreshDataGrid(node){
				var uuid = node.entityId;//树节点的主键
				Matrix.setFormItemValue('flag','refresh');
				Matrix.setFormItemValue('parentId',uuid);
				//main_iframe1.src = webContextPath+"/mobile/showUser_loadDataGridData.action?parentId="+uuid;
				//main_iframe1.contentDocument.location.reload();
				Matrix.refreshDataGridData("DataGrid001");
			}
		//双击左边行
		function doubleClick2Select(){
		  var select = MDataGrid001.getSelection();
		  var items = parent.parent.MDataGrid005.getData();
		  if(!items.contains(select[0])){
		  	  items.add(select[0]);
		  }else{
		  	  parent.parent.Matrix.warn("您已经选择了该人员！");
		  }
		  parent.parent.MDataGrid005.setData(items);
		}
		
		</script>
</head>
<body>
<jsp:include page="/form/admin/common/loading.jsp" />
<div id="j_id1" jsId="j_id1"
	style="position: relative; _layout: flowlayout; width: 100%; height: 100%">
<script>
 var MForm0=isc.MatrixForm.create({
 				ID:"MForm0",
 				name:"MForm0",
 				position:"absolute",
 				action:"<%=request.getContextPath()%>/mobile/flowEdit_loadOrgTreeNodeByCondition.action",
 				fields:[{
 					name:'Form0_hidden_text',
 					width:0,
 					height:0,
 					displayId:'Form0_hidden_text_div'
 					}]
 				
  });
  </script>

<form id="Form0" name="Form0" eventProxy="MForm0" method="post"
	action="<%=request.getContextPath()%>/mobile/flowEdit_loadOrgTreeNodeByCondition.action"
	style="margin: 0px; height: 100%;"
	enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="Form0" value="Form0"/>
	<input name="version" id="version" type="hidden">
	<input type="hidden" id="mid" name="mid">
	<input type="hidden" id="dataGridId" name="dataGridId" value="DataGrid001"/>
	<input type="hidden" id="flag" name ="flag" value="initLoad"/>
	<input type="hidden" id="parentId" name ="parentId"/>
	
<div type="hidden" id="Form0_hidden_text_div"
	name="Form0_hidden_text_div"
	style="position: absolute; width: 0; height: 0; z-index: 0 top: 0; left: 0; display: none;"></div>
	<table id="table001" class="tableLayout" style="width:100%;height:100%;">
	<tr id="tr001">
	<td id="td001" class="tdLayout" style="width:100%;height:50%;">
	
	<div id="Tree001_div" class="matrixComponentDiv">
	<script> isc.MatrixTree.create({	
								ID:"MTree001_DS",
						   		modelType:"children",
								ownerType:"tree",
								formId:"Form0",
								autoOpenRoot:true,
								ownerId:"Tree001",
								childrenProperty:"children",
								nameProperty:"text",
								root:{
									id:"RootTreeNode",
									entityId:"RootTreeNode",
									text:"RootTreeNode",
									type:0
								}
						});
		
		isc.MatrixTreeGrid.create({
						ID:"MTree001",
						name:"MTree001",
						height:"100%",
						width:"100%",
						displayId:"Tree001_div",
						position:"relative",
						showHeader:false,
						showHover:false,
						showCellContextMenus:true,
						leaveScrollbarGap:false,
						canAutoFitFields:true,
						wrapCells:false,
						fixedRecordHeights:true,
						selectionType:"single",
						selectionAppearance:"rowStyle",
						folderIcon:Matrix.getActionIcon("node"),
						data:MTree001_DS,
						autoFetchData:true,
						showOpenIcons:false,
						closedIconSuffix:'',
						showPartialSelection:false,
						cascadeSelection:false,
						border:0,
						onMoveUpAction:"true",
						onMoveDownAction:"true", 
						nodeContextClick:function(viewer, node, recordNum){
						               assignNodeMenu(viewer, node, recordNum);
						 
						},
						nodeClick:function(viewer, node, recordNum){
								refreshDataGrid(node);
								//forwardPageByNodeType(node);
						},
						getIcon:function(node){//根据节点类型返回不同类型的icon
						  return getNodeIconByType(node);
						}
						
					});
					
					
					
					isc.Page.setEvent(isc.EH.LOAD,"MTree001.resizeTo('100%','100%');");
					isc.Page.setEvent(isc.EH.RESIZE,"MTree001.resizeTo(0,0);MTree001.resizeTo('100%','100%');",null);</script></div></td>
</tr>
<tr id="tr002"><td id="td002" class="tdLayout" style="width:100%;height:50%;">
<input id="QueryField001" type="hidden" name="QueryField001" />
<table class="query_form_content" 
	style="height:100%;width:100%;overflow:hidden;border-collapse: collapse;border-spacing:0px;table-layout:fixed;">
	<tr>
	<td colspan="2" style="border-style:none;width:100%;margin:0px;padding:0px;">
	<div id="DataGrid001_div" class="matrixComponentDiv" style="width:100%;height:100%;">
	<script> var MDataGrid001_DS=<%=request.getAttribute("list")%>;
		isc.MatrixListGrid.create({
			ID:"MDataGrid001",name:"DataGrid001",
			displayId:"DataGrid001_div",
			position:"relative",
			width:"100%",
			height:"100%",
			showAllRecords:true,
			fields:[
				{title:"用户名称",matrixCellId:"userName",name:"userName",canEdit:false,editorType:'Text',type:'text'}],
			autoSaveEdits:false,
			isMLoaded:false,
			autoDraw:false,
			autoFetchData:true,
			selectionType:"single",
			selectionAppearance:"rowStyle",
			canDragSelect:true,
			alternateRecordStyles:true,
			showRollOver:true,canSort:true,
			showHeader:false,autoFitFieldWidths:false,
			cellDoubleClick:function(record, rowNum, colNum){doubleClick2Select();(record, rowNum, colNum);},
			editEvent:"doubleClick",canCustomFilter:true,exportCells:[{id:'userName',title:'用户名称'},{title:"人员编码",name:"userId",type:'text',editorType:'Text'},
						 		{title:"登陆名称",name:"logonName",type:'text',editorType:'Text'}],
			showRecordComponents:true,showRecordComponentsByCell:true});
			isc.MatrixDataSource.create(
				{ID:'MDataGrid001_custom_filter_ds',
				fields:[{title:"用户名称",name:"userName",type:'text',editorType:'Text'}]});
			isc.FilterBuilder.create({
						 	ID:'MDataGrid001_custom_filter',
						 	dataSource:MDataGrid001_custom_filter_ds,
						 	topOperatorAppearance:"none"
						 });
						 isc.Button.create({
						 	ID:'MDataGrid001_custom_filter_btn',
						 	title:"确认",
						 	autoDraw:false,
						 	click:"MDataGrid001.hideCustomFilter()"
						 });
						 isc.Button.create({
						 	ID:'MDataGrid001_custom_filter_btn_cancel',
						 	title:"取消",
						 	autoDraw:false,
						 	click:"MDataGrid001_custom_filter_window.hide()"
						 });
						 isc.Window.create({
						 	ID:'MDataGrid001_custom_filter_window',
						 	title:"高级查询",
						 	autoCenter:true,
						 	overflow:"auto",
						 	isModal:true,
						 	autoDraw:false,
						 	height:300,
						 	width:500,
						 	canDragResize:true,
						 	showMaximizeButton:true,
						 	items: [MDataGrid001_custom_filter],
						 	showFooter:true,
						 	footerHeight:20,
						 	footerControls:[
						 		isc.HTMLFlow.create({
						 			width:'30%',
						 			contents:"&nbsp;",
						 			autoDraw:false
						 		}),
						 		MDataGrid001_custom_filter_btn,
						 		isc.HTMLFlow.create({
						 			width:'5%',
						 			contents:"&nbsp;",
						 			autoDraw:false
						 		}),
						 		MDataGrid001_custom_filter_btn_cancel,
						 		isc.HTMLFlow.create({
						 			width:'30%',
						 			contents:"&nbsp;",
						 			autoDraw:false
						 		})
						 	]
						 });
						 isc.Page.setEvent(isc.EH.LOAD,function(){MDataGrid001.isMLoaded=true;MDataGrid001.draw();MDataGrid001.setData(MDataGrid001_DS);MDataGrid001.resizeTo('100%','100%');
						 isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"MDataGrid001.resizeTo(0,0);MDataGrid001.resizeTo('100%','100%');",null);},isc.Page.FIRE_ONCE);},isc.Page.FIRE_ONCE);
						 if(Matrix.getDataGridIdsHiddenOfForm('form0')){
						 	Matrix.getDataGridIdsHiddenOfForm('form0').value=Matrix.getDataGridIdsHiddenOfForm('form0').value+',DataGrid001'}
			</script>
	</td>
	
</tr>
</table>

</td>
</tr>
</table>
</form>
<script>
	MForm0.initComplete=true;MForm0.redraw();
	isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);
</script>


</div>

</body>
</html>