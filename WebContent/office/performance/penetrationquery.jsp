<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
	<head>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title></title>
		<jsp:include page="/form/admin/common/taglib.jsp" />
		<jsp:include page="/form/admin/common/resource.jsp" />
		<script type="text/javascript">
   function showPenetration(record){
			if(record!=null){
			Mpennode.initSrc="<%=request.getContextPath()%>/performance/pen_penComprehensive.action?flowType=${param.flowType}&startTime=${param.startTime}&endTime=${param.endTime}&type=${param.type}&piid="+record.piid;
			Mpennode.src="<%=request.getContextPath()%>/performance/pen_penComprehensive.action?flowType=${param.flowType}&startTime=${param.startTime}&endTime=${param.endTime}&type=${param.type}&piid="+record.piid;
			Matrix.showWindow("pennode");
			}
		}
		//打印
		function load(){

	var  str = "<%=request.getContextPath()%>/performance/pen_pricomprehensive.action?flowType=${param.flowType}&startTime=${param.startTime}&endTime=${param.endTime}&type=${param.type}&templetId=${param.templetId}";
	Matrix.setFormItemValue('url',str);  
	window.open('<%=request.getContextPath()%>/office/performance/print.jsp');
	}  
	function exportExcel(){
	var data =MDataGrid001.getData();
	if(data!=null){
		var searchForm = document.getElementById("form0") ;
				searchForm.action = "<%=request.getContextPath()%>/performance/pen_exportComprehensive.action?flowType=${param.flowType}&startTime=${param.startTime}&endTime=${param.endTime}&type=${param.type}&templetId=${param.templetId}";
				searchForm.target = "penTarget";
				searchForm.submit();
				}
		
	}
</script>
	</head>
	<body>
		<div id='loading' name='loading' class='loading'>
			<script>Matrix.showLoading();</script>
		</div>

		<script> var Mform0=isc.MatrixForm.create({ID:"Mform0",
		name:"Mform0",
		position:"absolute",
		action:"<%=request.getContextPath()%>/utilization/utili_loadDataGridData.action?catalogId=${param.catalogId}",
		canSelectText : true,
		fields : [ {
			name : 'form0_hidden_text',
			width : 0,
			height : 0,
			displayId : 'form0_hidden_text_div'
		} ]
	});
</script>
		<div
			style="width: 100%; height: 100%; overflow: auto; position: relative;">
			<form id="form0" name="form0" eventProxy="Mform0" method="post"
				action="<%=request.getContextPath()%>/utilization/utili_loadDataGridData.action?catalogId=${param.catalogId}"
				style="margin: 0px; position: relative; overflow: auto; width: 100%; height: 100%;"
				enctype="application/x-www-form-urlencoded">
				<input type="hidden" name="form0" value="form0" />
				<input type="hidden" name="is_mobile_request" />
				<input type="hidden" id="matrix_form_datagrid_form0"
					name="matrix_form_datagrid_form0" value="" />
				<div type="hidden" id="form0_hidden_text_div"
					name="form0_hidden_text_div"
					style="position: absolute; width: 0; height: 0; z-index: -9999999999; top: 0; left: 0; display: none;"></div>
				<input type="hidden" name="javax.matrix.faces.ViewState"
					id="javax.matrix.faces.ViewState" value="" />
				<input type="hidden" id="uuid" name="uuid">
				<input type="hidden" id="url" name="url"
					value="" />
				<input type="hidden" id="formId" name="formId"
					value="${param.formId}" />
				<div id="HorizontalContainer001Panel1_div2"
					style="width: 100%; height: 100%; overflow: hidden;"
					class="matrixInline">
					<table class="query_form_content"
						style="height: 100%; width: 100%; overflow: hidden; border-collapse: collapse; border-spacing: 0px; table-layout: fixed;">
						<tr>
							<td class="query_form_toolbar" colspan="2">
								<script>isc.ToolStripButton.create({
												ID:"MtoolBarItem003",
												icon:"[skin]/images/matrix/actions/add.png",
												title: "导出",showDisabledIcon:false,showDownIcon:false });
								MtoolBarItem003.click=function(){
												Matrix.showMask();
												var x = eval("exportExcel();");
												if(x!=null && x==false){
												Matrix.hideMask();
												return false;}Matrix.hideMask();
												}</script>
								<script>isc.ToolStripButton.create({
												ID:"MtoolBarItem004",
												icon:"[skin]/images/matrix/actions/edit.png",
												title: "打印",
												showDisabledIcon:false,
												showDownIcon:false });
								MtoolBarItem004.click=function(){
												Matrix.showMask();
												var x = eval("load();");
												if(x!=null && x==false){
												Matrix.hideMask();
												return false;}Matrix.hideMask();
												}
								
					</script>
								<div id="QueryForm001_tb_div"
									style="width: 100%; height: 38px;; overflow: hidden;">
									<script>isc.ToolStrip.create({
										ID:"MQueryForm001_tb",
										displayId:"QueryForm001_tb_div",
										width: "100%",
										height: "100%",
										position: "relative",
										members: [ MtoolBarItem003,MtoolBarItem004 ] });</script>
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="2"
								style="border-style: none; width: 100%; margin: 0px; padding: 0px;">
								<div id="DataGrid001_div" class="matrixComponentDiv"
									style="width: 100%; height: 100%;">
									<script>  
				var MDataGrid001_DS=<%=request.getAttribute("str")%>;
				isc.MatrixListGrid.create({ID:"MDataGrid001",
				name:"DataGrid001",
				displayId:"DataGrid001_div",
				position:"relative",
				width:"100%",
				height:"100%",
				fields:[{title:"&nbsp;",name:"MRowNum",canSort:false,canExport:false,canDragResize:false,showDefaultContextMenu:false,autoFreeze:true,
				autoFitEvent:'none',width:45,canEdit:false,canFilter:false,
				autoFitWidth:false,formatCellValue:function(value, record, rowNum, colNum,grid){
				if(grid.startLineNumber==null)return '&nbsp;';return grid.startLineNumber+rowNum;}},
				{title:"流程标题",matrixCellId:"title",name:"title",width:"40%",canEdit:false,editorType:'Text',type:'text'},
				{title:"运行时长",matrixCellId:"runTime",name:"runTime",width:"40%",canEdit:false,editorType:'Text',type:'text'},
				{title:"运行效率",matrixCellId:"efficiency",name:"efficiency",width:"40%",canEdit:false,editorType:'Text',type:'text'},
				{title:"流程期限",matrixCellId:"term",name:"term",width:"40%",canEdit:false,editorType:'Text',type:'text'},
				{title:"超时时长",matrixCellId:"overTime",name:"overTime",width:"40%",canEdit:false,editorType:'Text',type:'text'}
				],
				autoSaveEdits:false,
				isMLoaded:false,
				autoDraw:false,
				autoFetchData:true,
				selectionType:"single",
				selectionAppearance:"rowStyle",
				alternateRecordStyles:true,
				showRollOver:true,
				canSort:true,
				autoFitFieldWidths:false,
				cellDoubleClick:function(record, rowNum, colNum){
				debugger;
				showPenetration(record);
				},
				startLineNumber:1,
				editEvent:"doubleClick",
				canCustomFilter:true,
				exportCells:[
				{id:'title',title:'流程标题'},
				{id:'runTime',title:'运行时长'},
				{id:'efficiency',title:'运行效率'},
				{id:'term',title:'流程期限'},
				{id:'overTime',title:'超时时长'}],
				showRecordComponents:true,showRecordComponentsByCell:true});
				isc.MatrixDataSource.create({ID:'MDataGrid001_custom_filter_ds',fields:[
				{title:"流程标题",name:"title",type:'text',editorType:'Text'},
				{title:"运行时长",name:"runTime",type:'text',editorType:'Text'},
				{title:"运行效率",name:"efficiency",type:'text',editorType:'Text'},
				{title:"流程期限",name:"term",type:'text',editorType:'Text'},
				{title:"超时时长",name:"overTime",type:'text',editorType:'Text'}]});
				isc.FilterBuilder.create({ID:'MDataGrid001_custom_filter',dataSource:MDataGrid001_custom_filter_ds,overflow:'auto',topOperatorAppearance:"none"});
				isc.Button.create({ID:'MDataGrid001_custom_filter_btn',title:"确认",autoDraw:false,click:"MDataGrid001.hideCustomFilter()"});isc.Button.create({ID:'MDataGrid001_custom_filter_btn_reset',title:"重置",autoDraw:false,click:"MDataGrid001_custom_filter.clearCriteria()"});isc.Button.create({ID:'MDataGrid001_custom_filter_btn_cancel',title:"取消",autoDraw:false,click:"MDataGrid001_custom_filter_window.hide()"});isc.Window.create({ID:'MDataGrid001_custom_filter_window',title:"高级查询",autoCenter:true,overflow:"auto",isModal:true,autoDraw:true,height:300,width:500,canDragResize:true,showMaximizeButton:true,items: [MDataGrid001_custom_filter],
				showFooter:true,footerHeight:20,footerControls:[isc.HTMLFlow.create({width:'30%',contents:"&nbsp;",autoDraw:false}),MDataGrid001_custom_filter_btn,isc.HTMLFlow.create({width:'5%',contents:"&nbsp;",autoDraw:false}),MDataGrid001_custom_filter_btn_reset,isc.HTMLFlow.create({width:'5%',contents:"&nbsp;",autoDraw:false}),MDataGrid001_custom_filter_btn_cancel,isc.HTMLFlow.create({width:'30%',contents:"&nbsp;",autoDraw:false})]});MDataGrid001_custom_filter.resizeTo('100%','100%');MDataGrid001_custom_filter_window.hide();
				isc.Page.setEvent(isc.EH.LOAD,function(){MDataGrid001.isMLoaded=true;MDataGrid001.draw();
				MDataGrid001.setData(MDataGrid001_DS);MDataGrid001.resizeTo('100%','100%');isc.Page.setEvent(isc.EH.RESIZE,function(){
				isc.Page.setEvent(isc.EH.RESIZE,"MDataGrid001.resizeTo(0,0);MDataGrid001.resizeTo('100%','100%');",null);},
				isc.Page.FIRE_ONCE);},isc.Page.FIRE_ONCE);if(Matrix.getDataGridIdsHiddenOfForm('form0')){Matrix.getDataGridIdsHiddenOfForm('form0').value=Matrix.getDataGridIdsHiddenOfForm('form0').value+',DataGrid001'}</script>
								</div>
								<input id="DataGrid001_data_entity"
									name="DataGrid001_data_entity" value="" type="hidden" />
							</td>

						</tr>
					</table>

				</div>

				<%-- 
				<script>
	function getParamsForMainDialog() {
		var params = '&';
		var value;
		return params;
	}
	isc.Window.create( {
		ID : "MMainDialog",
		id : "MainDialog",
		name : "MainDialog",
		autoCenter : true,
		position : "absolute",
		height : "50%",
		width : "50%",
		title : "",
		canDragReposition : false,
		showMinimizeButton : true,
		showMaximizeButton : false,
		showCloseButton : true,
		showModalMask : false,
		modalMaskOpacity : 0,
		isModal : true,
		autoDraw : false,
		headerControls : [ "headerIcon", "headerLabel", "closeButton" ],
		showFooter : false
	});
</script>
				<script>
	MMainDialog.hide();
</script>--%>
	<script>
				function getParamsForpennode(){
				var params='&';
				var value;
				return params;
				}
				isc.Window.create({
				ID:"Mpennode",
				id:"pennode",
				name:"pennode",
				autoCenter:true,
				position:"absolute",
				height: "80%",
				width: "80%",
				title:"穿透查询",
				canDragReposition : false,
				showMinimizeButton : false,
				showMaximizeButton : false,
				showCloseButton : true,
				showModalMask : false,
				modalMaskOpacity : 0,
				isModal : true,
				autoDraw : false,
				headerControls : [ "headerIcon", "headerLabel", "minimizeButton",
						"maximizeButton", "closeButton" ],
				showFooter : false });
				</script>
				<script>Mpennode.hide();</script>
			</form>
		</div>
		<script>
	Mform0.initComplete = true;
	Mform0.redraw();
	isc.Page.setEvent(isc.EH.RESIZE, function() {
		isc.Page.setEvent(isc.EH.RESIZE, "Mform0.redraw()", null);
	}, isc.Page.FIRE_ONCE);
</script>
	</body>
</html>
