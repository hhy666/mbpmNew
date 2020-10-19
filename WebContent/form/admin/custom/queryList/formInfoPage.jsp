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
		<link href='<%=request.getContextPath() %>/resource/html5/css/skin/mCustom_<%=session.getAttribute("skin") %>.css' rel="stylesheet"></link>

		<script type="text/javascript">
		var formFlag="${formFlag}";
		parent.parent.allData=<%=request.getAttribute("list")%>;
			//双击左边行
		function doubleClick2Select(){
		if(parent.parent.flag==true){//只能选择当前子表的数据标志
		//parent.parent.MDataGrid005.setData([]);
		parent.parent.Matrix.refreshDataGridData("DataGrid005");
			parent.parent.flag=false;
		}
		  var select  = MDataGrid004.getSelection();
			if(select!=null && select.length>0){
				var gridDataList = parent.parent.MDataGrid005.getData();
				var newData = {};
				newData.name = select[0].name;
				newData.formId = select[0].formId;
				newData.enType = select[0].enType;
				newData.edType = select[0].edType;
				newData.dataType = select[0].dataType;
				newData.codeId = select[0].codeId;
				if(select[0].enType=='1'){
				newData.operator = 'like';
				}else{
				newData.operator = 'equal';
				}
				newData.style = select[0].style;   //显示风格
				newData.options = select[0].options;  //下拉框基本代码
				var result = false;
				if(gridDataList!=null && gridDataList.size()>0){
					result = isEcho(newData,gridDataList);
				}
				if(!result){
					parent.parent.MDataGrid005.addData(newData);
					parent.parent.MDataGrid005.redraw();
				}
			}
		}
		
		
		//检查是否重复
		function isEcho(newData,gridDataList){
			for(var i = 0;i<gridDataList.size();i++){
				var data = gridDataList[i];
				if(data.formId==newData.formId){
					return true;
				}
			}
			return false;
		}
		//---------------键盘监听事件-----开始-----------------
		isc.Page.setEvent(isc.EH.KEY_PRESS,function(){
        	var _key = isc.Event.getKey();
        	if(_key=="Enter" && MQueryField002==MQueryField002.form.getFocusItem()){
         	   MtoolBarItem002.click();
       		}
    	});
		//---------------键盘监听事件-----结束-----------------
		
		function getSelection(){
			var select =  MDataGrid004.getSelection();
			var value=[];
			if(select!=null && select.length>0){
			for(var i=0;i<select.length;i++){
				var record = select[i];
				if(select[0].enType=='1'){
				record.operator  = 'like';
				}else{
				record.operator  = 'equal';
				}
				parent.parent.selectUser[i] = record;
				value[i]=record;
			}
			return value;
			}
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
 				action:"<%=request.getContextPath()%>/query/form_queryFormlist.action",
 				fields:[{
 					name:'Form0_hidden_text',
 					width:0,
 					height:0,
 					displayId:'Form0_hidden_text_div'
 				}]
  });
  </script>

			<form id="Form0" name="Form0" eventProxy="MForm0" method="post"
				action="<%=request.getContextPath()%>/query/form_queryFormlist.action"
				style="margin: 0px; height: 100%;overflow: hidden;"
				enctype="application/x-www-form-urlencoded">
				<input type="hidden" name="Form0" value="Form0" />
				<input name="version" id="version" type="hidden">
				<input type="hidden" id="X-Requested-With" name="X-Requested-With"
					value="XMLHttpRequest">
				<input type="hidden" id="dataGridId" name="dataGridId"
					value="DataGrid004">
				<!-- 子页面的隐藏字段 -->
				<input type="hidden" id="name" name="name">
				<input type="hidden" id="desc" name="desc">


				<div type="hidden" id="Form0_hidden_text_div"
					name="Form0_hidden_text_div"
					style="position: absolute; width: 0; height: 0; z-index: 0 top :   0; left: 0; display: none;"></div>
				<table id="table001" class="tableLayout"
					style="width: 100%; height: 100%;">
					<tr id="tr001">
						<td id="td001" class="tdLayout" style="width: 100%; height: 100%;">

							<div id="DataGrid004_div" class="matrixComponentDiv"
								style="width: 100%; height: 100%;">
								<script> var MDataGrid004_DS=<%=request.getAttribute("list")%>;
	
	isc.MatrixListGrid.create({
		ID:"MDataGrid004",
		name:"DataGrid004",
		displayId:"DataGrid004_div",
		position:"relative",
		width:"100%",
		height:"100%",
		showAllRecords:true,
		canHover:true,
		fields:[
			{title:"表单数据项",matrixCellId:"name",name:"name",canEdit:false,editorType:'Text',type:'text'},
		],
		autoSaveEdits:false,
		isMLoaded:false,
		autoDraw:false,
		autoFetchData:true,
		selectionType:"multiple",
		selectionAppearance:"rowStyle",
		canDragSelect:true,
		alternateRecordStyles:true,
		showRollOver:true,
		canSort:false,
		showHover:true,
		autoFitFieldWidths:false,
		//recordClick:function(){getSelection();},
		recordClick:function(){getSelection();},
		cellDoubleClick:function(record, rowNum, colNum){doubleClick2Select();(record, rowNum, colNum);},
		editEvent:"doubleClick",
		canCustomFilter:true,
		exportCells:[{id:'name',title:'表单数据'}],
		showRecordComponents:true,
		showRecordComponentsByCell:true});
		isc.MatrixDataSource.create({
			ID:'MDataGrid004_custom_filter_ds',
			fields:[
					{title:"表单数据",name:"name",type:'text',editorType:'Text'}
				   ]});
	    isc.FilterBuilder.create({ID:'MDataGrid004_custom_filter',dataSource:MDataGrid004_custom_filter_ds,overflow:'auto',topOperatorAppearance:"none"});
	    isc.Button.create({ID:'MDataGrid004_custom_filter_btn',title:"确认",autoDraw:false,click:"MDataGrid004.hideCustomFilter()"});
	    isc.Button.create({ID:'MDataGrid004_custom_filter_btn_reset',title:"重置",autoDraw:false,click:"MDataGrid004_custom_filter.clearCriteria()"});
	    isc.Button.create({ID:'MDataGrid004_custom_filter_btn_cancel',title:"取消",autoDraw:false,click:"MDataGrid004_custom_filter_window.hide()"});
	    isc.Window.create({ID:'MDataGrid004_custom_filter_window',title:"高级查询",autoCenter:true,overflow:"auto",isModal:true,autoDraw:true,height:300,width:500,canDragResize:true,showMaximizeButton:true,items: [MDataGrid004_custom_filter],showFooter:true,footerHeight:20,footerControls:[isc.HTMLFlow.create({width:'50%',contents:"&nbsp;",autoDraw:false}),MDataGrid004_custom_filter_btn,isc.HTMLFlow.create({width:'5%',contents:"&nbsp;",autoDraw:false}),MDataGrid004_custom_filter_btn_reset,isc.HTMLFlow.create({width:'5%',contents:"&nbsp;",autoDraw:false}),MDataGrid004_custom_filter_btn_cancel,isc.HTMLFlow.create({width:'30%',contents:"&nbsp;",autoDraw:false})]});MDataGrid004_custom_filter.resizeTo('100%','100%');MDataGrid004_custom_filter_window.hide();isc.Page.setEvent(isc.EH.LOAD,function(){MDataGrid004.isMLoaded=true;MDataGrid004.draw();MDataGrid004.setData(MDataGrid004_DS);MDataGrid004.resizeTo('100%','100%');isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"MDataGrid004.resizeTo(0,0);MDataGrid004.resizeTo('100%','100%');",null);},isc.Page.FIRE_ONCE);},isc.Page.FIRE_ONCE);if(Matrix.getDataGridIdsHiddenOfForm('form0')){Matrix.getDataGridIdsHiddenOfForm('form0').value=Matrix.getDataGridIdsHiddenOfForm('form0').value+',DataGrid004'}</script>
							</div>
							<input id="DataGrid004_data_entity"
								name="DataGrid004_data_entity" value="foundation.org.User"
								type="hidden" />

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