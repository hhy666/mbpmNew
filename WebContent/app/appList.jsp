<%@page pageEncoding="utf-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML>
<html>
<meta http-equiv='pragma' content='no-cache'>
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='0'>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<title>应用维护列表</title>
<head>
<%@ include file="/form/html5/admin/html5Head.jsp"%>
<script type="text/javascript">
function deleteButton(){
	//var selects = Matrix.getGridSelections(DataGrid001);
 	var selects = Matrix.getGridSelections("DataGrid001"); 
	var data="{'appIds':'";
	if(selects.length == 0){
		Matrix.warn('未选中数据!');
		return;
	}else{
		for(var i=0;i<selects.length;i++){
			if("root"==selects[i].appId){
				Matrix.warn("主应用不可删除!");
				return;
			}
			if("当前应用"==selects[i].useStatus){
				Matrix.warn("当前应用不可删除!");
				return;
			}
			data+=selects[i].appId;
			if(i!=selects.length-1){
				data+=",";
			}
		}
		data+="'}";
		Matrix.confirm("是否确认删除选中应用?",function(value){
			if(!value){
				deleteApp(data);
			}
		});
	}
}
//切换应用
function changeApp(){
	var selects = Matrix.getGridSelections("DataGrid001"); 
	if(selects.length !=1){
		Matrix.warn('请选择一条应用进行切换!');
		return;
	}
	var json = {};
	json.appId = selects[0].appId;
	json.schema = selects[0].schemaCode;
	Matrix.confirm("是否确认切换选中应用?",function(value){
		if(!value){
			$.ajax({
				type:'post',
				url:'<%=path%>/mapp/mapp_switchApplication.action',
				data : json,
				dataType : 'json',
				success : function(json) {

					if (json != "") {
						if (json.success == true) {
							Matrix.say('切换成功！');
							top.changeView('changeApp');
						} else {
							Matrix.error(json.msg);
						}
					} else {
						Matrix.error("服务器异常请联系管理员");
					}
				}
			});
		}
	});
}
function deleteApp(data){
	var url ='<%=path%>/mapp/mapp_deleteApplication.action?nodeType=application';
	var synJson = eval('(' + data + ')');
	Matrix.sendRequest(url,synJson,function(data){
	    var json = eval('(' + data.data + ')');
		if(json.success == true){
			Matrix.refreshDataGridData('DataGrid001');
			Matrix.say("删除成功!");
		}else{
			Matrix.warn("未能删除!");
		}
	});
}
function setAppStatus(appStatus){
	//var selects = Matrix.getGridSelections(DataGrid001);
 	var selects = Matrix.getGridSelections("DataGrid001"); 
 	var msg="";
 	if(appStatus==1){
 		msg="启用"
 	}else{
 		msg="禁用"
 	}
	var data="{'appStatus':"+appStatus+",'appIds':'";
	if(selects.length == 0){
		Matrix.warn('未选中数据!');
		return;
	}else{
		for(var i=0;i<selects.length;i++){
			if("root"==selects[i].appId){
				Matrix.warn("主应用不可"+msg+"!");
				return;
			}
			if("当前应用"==selects[i].useStatus){
				Matrix.warn("当前应用不可"+msg+"!");
				return;
			}
			data+=selects[i].appId;
			if(i!=selects.length-1){
				data+=",";
			}
		}
		data+="'}";
		Matrix.confirm("是否确认"+msg+"选中应用?",function(value){
			if(!value){
				var url ='<%=path%>/mapp/mapp_setAppStatus.action';
				var synJson = eval('(' + data + ')');
				Matrix.sendRequest(url,synJson,function(data){
				    var json = eval('(' + data.data + ')');
					if(json.success == true){
						Matrix.refreshDataGridData('DataGrid001');
						Matrix.say(msg+"成功!");
					}else{
						Matrix.warn(msg+"删除!");
					}
				});
			}
		});
	}
}

//添加应用
function addApp(){
	layer.open({
		id : 'AddDialog',
		type : 2,
		title : [ '添加应用' ],
		closeBtn : 1,
		shadeClose : false,
		area : [ '50%', '70%' ],
		content : '<%=path%>/mapp/mapp_getAppInfo.action?iframewindowid=AddDialog&optType=add'
	});
}

//修改应用
function editApp(){
	var selects = Matrix.getGridSelections("DataGrid001"); 
	if(selects.length !=1){
		Matrix.warn('请选择一条应用进行修改!');
		return;
	}
	doubleClickSelect(selects[0]);
}

//双击修改
function doubleClickSelect(select){
	var appId = select.appId;
	layer.open({
		id : 'editDialog',
		type : 2,
		title : [ '修改应用' ],
		closeBtn : 1,
		shadeClose : false,
		area : [ '50%', '70%' ],
		content : '<%=path%>/mapp/mapp_getAppInfo.action?iframewindowid=editDialog&optType=update&appId='+appId+''
	});
}


</script>
</head>
<body>
	<div
		style="width: 100%; height: 100%; overflow: auto; position: relative;">
		<form id="form0" name="form0" eventProxy="Mform0" method="post" style="margin: 0px; position: relative; overflow: auto; width: 100%; height: 100%;" enctype="application/x-www-form-urlencoded">
			<input type="hidden" name="form0" value="form0" /> <input
				type="hidden" id="dataGridId" name="dataGridId" value="DataGrid001" />
			<input type="hidden" id="matrix_form_datagrid_form0"
				name="matrix_form_datagrid_form0" value="" />
			<div type="hidden" id="form0_hidden_text_div"
				name="form0_hidden_text_div"
				style="position: absolute; width: 0; height: 0; z-index: -9999999999; top: 0; left: 0; display: none;"></div>
			<input type="hidden" name="javax.matrix.faces.ViewState"
				id="javax.matrix.faces.ViewState" value="" />
			<div style="display: block">
				<table class="query_form_content"
					style="height: 100%; width: 100%; overflow: hidden; border-collapse: collapse; border-spacing: 0px; table-layout: fixed;">
					<tr style="height: 0px">
						<td class="query_form_toolbar" icolspan="2" style="padding: 3px">
							<div
								style="height: 40px; padding: 4px; background: #f8f8f8; text-align: left; border: 1px solid #E6E9ED">
								<label style="padding-left: 5px">应用名称:</label>
								<div
									style="padding-right: 5px; display: inline-block; vertical-align: middle;">
									<input class="form-control" type="text" style=""
										name="appNameQuery" id="appNameQuery">
								</div>
								<label style="padding-left: 5px">应用状态:</label>
								<div
									style="padding-right: 5px; display: inline-block; vertical-align: middle;">
									<select class="form-control select2-accessible"
										name="appStatus" id="appStatus">
										<option value="" selected="selected"></option>
										<option value="0" >停用</option>
										<option value="1" selected="selected">启用</option>
									</select>
								</div>
								<div style="padding-right: 5px; display: inline-block; vertical-align: middle;">
									<input type="button" value="查询"
										class="btn  btn-default toolBarItem" id="MtoolBarItem"
										style="border: 0; background: transparent"
										onclick="Matrix.refreshDataGridData('DataGrid001');">
								</div>
								<div style="padding-right: 5px; display: inline-block; vertical-align: middle;">
									<input type="button" value="添加"
										class="btn  btn-default toolBarItem" id="MtoolBarItem001"
										style="border: 0; background: transparent"
										onclick="addApp();">
								</div>
								<div style="padding-right: 5px; display: inline-block; vertical-align: middle;">
									<input type="button" value="修改"
										class="btn  btn-default toolBarItem" id="MtoolBarItem006"
										style="border: 0; background: transparent"
										onclick="editApp();">
								</div>
								<div style="padding-right: 5px; display: inline-block; vertical-align: middle;">
									<input type="button" value="删除"
										class="btn  btn-default toolBarItem" id="MtoolBarItem002"
										style="border: 0; background: transparent"
										onclick="deleteButton()"/>
								</div>
								<div style="padding-right: 5px; display: inline-block; vertical-align: middle;">
									<input type="button" value="启用"
										class="btn  btn-default toolBarItem" id="MtoolBarItem003" name="MtoolBarItem003"
										style="border: 0; background: transparent"
										onclick="setAppStatus(1)"/>
								</div>
								<div style="padding-right: 5px; display: inline-block; vertical-align: middle;">
									<input type="button" value="禁用"
										class="btn  btn-default toolBarItem" id="MtoolBarItem004" name="MtoolBarItem004"
										style="border: 0; background: transparent"
										onclick="setAppStatus(0)"/>
								</div>
								<div style="padding-right: 5px; display: none; vertical-align: middle;">
									<input type="button" value="切换应用"
										class="btn  btn-default toolBarItem" id="MtoolBarItem005" name="MtoolBarItem005"
										style="border: 0; background: transparent"
										onclick="changeApp()"/>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td
							style="border-style: none; width: 100%; margin: 0px; padding: 0px; vertical-align: top;">

						</td>
					</tr>
				</table>
			</div>
			<div style="display: block; height: 80%; overflow: auto;">
				<table id="DataGrid001_table" style="width: 100%; height: 100%;">
					<script>
								$(document).ready(function(){
									$("#DataGrid001_table").bootstrapTable({
										classes:'table table-bordered table-striped',
										method:'post',
										contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
										url:'<%=path%>/mapp/mapp_getAppList.action',
																search : false,
																sidePagination : "server",
																singleSelect : false,
																clickToSelect : true,
																sortable : false,
																pagination : true,
																onDblClickRow : function(
																		row) {
																},
																queryParams : function(
																		params) {
																	var param = {
																		offset : params.offset,
																		limit : params.limit
																	}
																	var form = document
																			.getElementById('form0');
																	var tagElements = form
																			.getElementsByTagName('input');
																	for (var j = 0; j < tagElements.length; j++) {
																		param[tagElements[j].name] = tagElements[j].value;
																	}
																	;
																	var tagElements2 = form
																			.getElementsByTagName('select');
																	for (var j = 0; j < tagElements2.length; j++) {
																		param[tagElements2[j].name] = tagElements2[j].value;
																	}
																	;
																	return param;
																},
																//singleSelect:true,
																//sortable:false,
																pageSize : 10,
																pageList : [
																		10, 20,
																		30, 40 ],
																formatLoadingMessage : function() {
																	return '请稍等，正在加载中...';
																},
																formatNoMatches : function() {
																	return '无符合条件的记录';
																},
																columns : [
																		{
																			title : ' ',
																			checkbox : true
																		},
																		{
																			title:"序号", width:'8px',
																			formatter : function(
																					value,
																					row,
																					index) {
																				var pageSize = $(
																						"#DataGrid001_table")
																						.bootstrapTable(
																								'getOptions').pageSize;
																				var pageNumber = $(
																						"#DataGrid001_table")
																						.bootstrapTable(
																								'getOptions').pageNumber;
																				return pageSize
																						* (pageNumber - 1)
																						+ index
																						+ 1;
																			}
																		},
																		{
																			field : 'appName',
																			title : '应用名称',
																			editorType : 'Text',
																			clickToSelect : true,
																			type : 'text'
																		},
																		{
																			field : 'createdDate',
																			title : '创建时间',
																			editorType : 'Text',
																			clickToSelect : true,
																			type : 'Text'
																		},
																		{
																			field : 'appStatus',
																			title : '应用状态',
																			editorType : 'Text',
																			clickToSelect : true,
																			type : 'text',
																			formatter : function(
																					value,
																					row,
																					index) { // 单元格格式化函数
																				var text = '-';
																				if (value == true) {
																					text = "启用";
																				} else if (value == false) {
																					text = "停用";
																				}
																				return text;
																			}
																		},{
																			field : 'useStatus',
																			title : '使用状态',
																			editorType : 'Text',
																			clickToSelect : true,
																			type : 'text',
																			visible:false
																		} ],
																		onDblClickRow:function(row){   //双击行事件
																	    	doubleClickSelect(row);
																		},

															});
										});
					</script>
				</table>
			</div>
		</form>
	</div>
</body>
</html>