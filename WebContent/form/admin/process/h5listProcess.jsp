<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%@page import="com.matrix.app.MAppProperties"%>
<%@page import="com.matrix.engine.foundation.config.MFSystemProperties"%>

<%@ page
	import="
		java.text.SimpleDateFormat,
		com.matrix.api.MFExecutionService,
   		com.matrix.api.identity.*,
		com.matrix.client.ClientConstants,
		java.util.*"%>	
		<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
<!DOCTYPE HTML>
<html>
<meta http-equiv='pragma' content='no-cache'>
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='0'>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<head>
<jsp:include page="/form/html5/admin/html5Head.jsp"/>
<title>h5设计开发流程版本列表</title>
<%
	//是否启用集团
	boolean isGroupEnable = MAppProperties.getInstance().isGroupEnable();
	String rootId = MFSystemProperties.getInstance().getDepRootValue();   //配置的根编码
%>

<% 
MFExecutionService mfes = (MFExecutionService)session.getAttribute(ClientConstants.EXECUTION_SERVICE);

MFUser user = mfes.getMFUser();
String userId = user.getUserId();
String sessionId = mfes.getSessionId();

String contextPath = request.getContextPath();
if(contextPath != null)
	contextPath = contextPath.substring(1);
	//String serverIp = request.getLocalAddr();
String url = request.getRequestURL().toString();
//String serverIp = url.substring(url.indexOf("//")+2,url.indexOf(":",url.indexOf("//"))); 
String serverIp = request.getServerName();
int serverPort = request.getServerPort();
String params = "";
params +="serverIp="+serverIp;
params +="&contextPath="+contextPath;
params +="&sessionId="+sessionId;
params +="&userId="+userId;
params +="&serverPort="+serverPort;
params +="&simulationType=2&mode=design";
%>
<script type="text/javascript">

	var isGroupEnable = <%=isGroupEnable %>;
	var rootId = "<%=rootId %>";
	
	//点击选择
	function singleClickSelect(row, element){
		$('.changeColor').removeClass('changeColor');//去除之前选中的行的，选中样式
		$(element).addClass('changeColor');
		
	}

	//设计流程
	function designProcess(row){
		parent.designProcess(row.pkgTid,window);
		
	}
	
	//创建流程
	function createProcess(){
		parent.createProcess();
	}
	
	//复制流程 
	function copyProcess(){
		var $tr = $('#DataGrid001_table').find('tr.changeColor');   //选中行
		if($tr!=null && $tr.length==1){
			var index = $tr.data('index'); //获得选中的行的index
			var item = Matrix.getGridData('DataGrid001');   //所有数据
			var listSize = item.length;      //长度
			var record = item[index];  //当前选中行
			var orgId = record.ORG_ID; 
			if(rootId!=orgId){
				Matrix.warn("分公司版本无法复制！");
				return false;
			}		 			
			parent.copyProcess(record.pkgTid,window);
		}else{
			Matrix.warn("没有数据被选中，不能执行此操作。");
		}
	}
	
	//编辑流程
	function editProcess(){
		var $tr = $('#DataGrid001_table').find('tr.changeColor');   //选中行
		if($tr!=null && $tr.length==1){
			var index = $tr.data('index'); //获得选中的行的index
			var item = Matrix.getGridData('DataGrid001');   //所有数据
			var listSize = item.length;      //长度
			var record = item[index];  //当前选中行
			var processType = Matrix.getFormItemValue("processType");
			parent.designProcess(record.pkgTid,window);
		}else{
			Matrix.warn("没有数据被选中，不能执行此操作。");
		}
	}
	
	//删除流程
	function deleteProcess(){
		var $tr = $('#DataGrid001_table').find('tr.changeColor');   //选中行
		if($tr!=null && $tr.length==1){
			var index = $tr.data('index'); //获得选中的行的index
			var item = Matrix.getGridData('DataGrid001');   //所有数据
			var listSize = item.length;      //长度
			var record = item[index];  //当前选中行
			if(record.status == 3){
				Matrix.warn("已发布流程不能直接删除，请先取消发布！");
				return;
			}	
			
			if(parent.validateDeleteProcess(record)){
				Matrix.confirm("确定要删除选择的流程模板吗？",function(value){if(true){deleteProcessSubmit(record)}});
			}else{
				Matrix.warn("您无权删除的流程模板！");
				return false;
			}
		}else{
			Matrix.warn("没有数据被选中，不能执行此操作。");
		}
	}
	
	//删除流程模板
	function deleteProcessSubmit(record){
		if(record.status == 3){
			Matrix.warn("已发布流程不能直接删除，请先取消发布！");
			return;
		}	
		var data = {};
		data["pkgTid"]=record.pkgTid;
		var url = "<%=path%>/process/processTmplAction_deleteProcessTmpl.action";
		Matrix.sendRequest(url,data,function(response){
				if("true"==response.data){
					$('#DataGrid001_table').bootstrapTable('refresh');
					Matrix.success("删除成功！");
				}else{
					Matrix.warn("删除失败！");
				}
			},
			function(){
				Matrix.warn("删除失败！");
				return false;
			}
		);
	}
	
	//迁移流程模板实例
	function upgradeProcess(){
		var $tr = $('#DataGrid001_table').find('tr.changeColor');   //选中行
		if($tr!=null && $tr.length==1){
			var index = $tr.data('index'); //获得选中的行的index
			var item = Matrix.getGridData('DataGrid001');   //所有数据
			var listSize = item.length;      //长度
			var record = item[index];  //当前选中行
			var upgradePkgTmplId = record.pkgTid;
			var processId = document.getElementById("processId").value;
			document.getElementById("upgradePkgTmplId").value = upgradePkgTmplId;
			/* var src = webContextPath+"/process/processTmplAction_querySelectedPkgTemplates.action?upgradePkgTmplId=" + upgradePkgTmplId + "&processId=" + processId +"&selection=" + selection;
		    MselectProcessTmplWindow.initSrc = src;
		    Matrix.showWindow("selectProcessTmplWindow"); */
		    layer.open({
		    	type:2,
				title:["选择流程模板"],
				area:['60%','60%'],
				content:"<%=path%>/process/processTmplAction_querySelectedPkgTemplates.action?upgradePkgTmplId=" + upgradePkgTmplId + "&processId=" + processId
		    });
		}else{
			Matrix.warn("没有数据被选中，不能执行此操作。");
		}
	}
	
	// 取消发布流程
	function cancelPublishedStatus(){
		var userId = parent.userId;;
		var releasedType = parent.releasedType;
		var isAdmin = parent.isAdmin;
		var $tr = $('#DataGrid001_table').find('tr.changeColor');   //选中行
		if($tr!=null && $tr.length==1){
			var index = $tr.data('index'); //获得选中的行的index
			var item = Matrix.getGridData('DataGrid001');   //所有数据
			var listSize = item.length;      //长度
			var record = item[index];  //当前选中行
			
			if(record.status!=releasedType){
				Matrix.warn("请选择已经发布的流程模板！");
				return false;
			}
			
			Matrix.confirm("取消发布流程模板将删除所有相关的流程实例数据，是否继续？",function(value){if(true){cancelPublishedStatusSubmit(record)}});
			return false;
		}else{
			Matrix.warn("没有数据被选中，不能执行此操作。");
		}
	}
	
	function cancelPublishedStatusSubmit(record){
		var selectedTmplTID = record.pkgTid;
	    var data = {};
		data["selectedTmplTID"] = selectedTmplTID;
		var url = "<%=path%>/process/processTmplAction_cancelPublishedStatus.action";
		Matrix.sendRequest(url,data,function(response){
			if("true"==response.data){
				$('#DataGrid001_table').bootstrapTable('refresh');
				Matrix.warn("取消发布流程模板成功！");
			}else{
				Matrix.warn("取消发布流程模板失败！");
			}
		},
			function(){
				Matrix.warn("取消发布流程模板失败！");
				return false;
			}
		);
	}
	
	// 仿真
	function simulationProcess(){
		var $tr = $('#DataGrid001_table').find('tr.changeColor');   //选中行
		if($tr!=null && $tr.length==1){
			var index = $tr.data('index'); //获得选中的行的index
			var item = Matrix.getGridData('DataGrid001');   //所有数据
			var listSize = item.length;      //长度
			var record = item[index];  //当前选中行
			var params = "<%=params%>";
			//var params = parent.simulationParams;
		    params = params + "&pkgTid="+record.pkgTid;
			var url = "<%=path%>/form/admin/process/flex/MatrixDesigner.jsp?"+params;
			var iHeight = 700;
			var iWidth = 950;
			var iTop = (window.screen.availHeight-30-iHeight)/2; //获得窗口的垂直位置;
	  		var iLeft = (window.screen.availWidth-10-iWidth)/2;  //获得窗口的水平位置;
	  		var property = "toolbar=no, menubar=no, scrollbars=no, resizable=yes,location=no, status=no, width=" + iWidth + ",height=" + iHeight + ",left=" + iLeft + ",top=" + iTop;
			window.open( url, "仿真流程", property);
		}else{
			Matrix.warn("没有数据被选中，不能执行此操作。");
		}
	}
	
	//置为最新版
	function changeNew(){
		layer.open({
			type:2,
			title:['置为最新版'],
			area:['65%','80%'],
			content:"<%=request.getContextPath()%>/process/processTmplAction_processNewVersion.action"
		});
		
	}

</script>
</head>
<body>
	<form id="Form0" name="Form0" method="post"
	action=""
	style="margin: 0px; height: 100%;"
	enctype="application/x-www-form-urlencoded">
		<input type="hidden" name="Form0" value="Form0" /> 
		<input type="hidden" id="processId" name="processId" value="${param.processId}">
		<input type="hidden" id="dataGridId" name="dataGridId" value="DataGrid0">
		<input type="hidden" id="upgradePkgTmplId" name="upgradePkgTmplId">
		<input type="hidden" id="processType" name="processType" value="${param.processType}">
		<input type="hidden" id="iframewindowid" name="iframewindowid" value="${iframewindowid}">
		<!-- 是否启用集团 -->
		<input type="hidden" id="isGroupEnable" name="isGroupEnable" value="<%=isGroupEnable %>">
		<!-- 是否定制流程 -->
		<input type="hidden" id="isCustomFlow" name="isCustomFlow" value="${isCustomFlow }"/>
	
		<div style="display: table">
			<table class="query_form_content" style="height:100%;width:100%;overflow:hidden;border-collapse: collapse;border-spacing:0px;table-layout:fixed;">
		  			<tr style=" height: 0px">
					<td class="query_form_toolbar"icolspan="2" style="padding: 3px">
						<div style="/* padding:4px; */background: #f8f8f8;text-align: left;vertical-align: middle;height: 44px;border: 1px solid #E6E9ED;line-height: 44px;">
							<button type="button" class="btn  btn-default toolBarItem" id="MtoolBarItemAdd" style="padding-left:5px;padding-right:5px;margin:0px;border:0;" onclick="createProcess();">
								<img src="<%=path%>/resource/images/new.png" style="padding-right: 2px;">创建
							</button>
							<button type="button" class="btn  btn-default toolBarItem" id="MtoolBarItemCopy" style="padding-left:5px;padding-right:5px;margin:0px;border:0;" onclick="copyProcess();">
								<img src="<%=path%>/resource/images/relatarc.png" style="padding-right: 2px;">复制
							</button>
							<button type="button" class="btn  btn-default toolBarItem" id="MtoolBarItemEdit" style="padding-left:5px;padding-right:5px;margin:0px;border:0;" onclick="editProcess();">
								<img src="<%=path%>/resource/images/edit.png" style="padding-right: 2px;">编辑
							</button>
							<button type="button" class="btn  btn-default toolBarItem" id="MtoolBarItemDel" style="padding-left:5px;padding-right:5px;margin:0px;border:0;" onclick="deleteProcess();">
								<img src="<%=path%>/resource/images/delete.png" style="padding-right: 2px;">删除
							</button>
							<button type="button" class="btn  btn-default toolBarItem" id="MtoolBarItemReCancel style="padding-left:5px;padding-right:5px;margin:0px;border:0;" onclick="cancelPublishedStatus();">
								<img src="<%=path%>/resource/images/deletex.png" style="padding-right: 2px;">撤销发布
							</button>
							<button type="button" class="btn  btn-default toolBarItem" id="MtoolBarItemUpgrade" style="padding-left:5px;padding-right:5px;margin:0px;border:0;" onclick="upgradeProcess();">
								<img src="<%=path%>/resource/images/setAuth.png" style="padding-right: 2px;">迁移
							</button>
							<button type="button" class="btn  btn-default toolBarItem" id="MtoolBarItemImp" style="display:none;padding-left:5px;padding-right:5px;margin:0px;border:0;" onclick="simulationProcess();">
								<img src="<%=path%>/resource/images/canceltop.png" style="padding-right: 2px;">仿真
							</button>
							<button type="button" class="btn  btn-default toolBarItem" id="MtoolBarItemExp" style="display:none;padding-left:5px;padding-right:5px;margin:0px;border:0;" onclick="changeNew();">
								<img src="<%=path%>/resource/images/settop.png" style="padding-right: 2px;">置为最新版
							</button>
						</div>
					</td>
				</tr>
			</table>
		</div>
		<div style="height: calc(100% - 54px);display: block">
			<table id="DataGrid001_table" style="width:100%;">
			</table>
			
			<script type="text/javascript">
				$(document).ready(function() { 
					var isGroupEnable = $('#isGroupEnable').val();  //是否启用集团
					var isCustomFlow = $('#isCustomFlow').val();  //是否定制流程					
					var processId = $("#processId").val();
					$("#DataGrid001_table").bootstrapTable({           
						classes: 'table table-hover table-no-bordered',
						method: "post", 
						contentType : "application/x-www-form-urlencoded",  //必须配置 不然queryParams传参后台获取不到
						url: "<%=request.getContextPath() %>/process/processTmplAction_h5queryPkgTemplates.action?processId="+processId, 
						search: false,    //是否启用搜索框
						sortable: false,  //是否启用排序
						pagination:false, //是否启用分页
						sidePagination: "server",   //指定服务器端分页
						formatLoadingMessage: function() {
				            return '请稍等，正在加载中...';
					    },
						formatNoMatches: function() {
				            return '无符合条件的记录';
				        },
				        columns: [
					        {title:"名称",field:"PACKAGE_NAME",sortable:true,clickToSelect:true,editorType:'Text',type:'text'},
					    	{title:"版本",field:"RH_VERSION",sortable:true,clickToSelect:true,editorType:'Text',type:'text'},
					    	{title:"最后更新时间",field:"PKG_SUBMIT_TIME",sortable:true,clickToSelect:true,editorType:'Text',type:'text'},
					    	{title:"状态",field:"RH_PUB_STATUS",sortable:true,clickToSelect:true,editorType:'Text',type:'text'},
					    	{title:"当前操作人",field:"PACKAGE_OWNER",sortable:true,clickToSelect:true,editorType:'Text',type:'text',visible:false},
					    	{title:"最后更新人",field:"PKG_SUBMIT_ID",sortable:true,clickToSelect:true,editorType:'Text',type:'text'},
					    	{title:"机构名称",field:"ORG_NAME",sortable:true,clickToSelect:true,editorType:'Text',type:'text',visible:isGroupEnable=='true'?true:false},
					    	{title:"业务编码",field:"BUSINESS_ID",sortable:true,clickToSelect:true,editorType:'Text',type:'text',visible:false},
					    	{title:"业务名称",field:"BUSINESS_NAME",sortable:true,clickToSelect:true,editorType:'Text',type:'text',visible:isCustomFlow=='true'?true:false}
					    ],
					    singleSelect:true,  //设置true将禁止多选
					    onClickRow:function(row, $element){   //单击行事件
					    	singleClickSelect(row, $element);
						},
					    onDblClickRow:function(row){   //双击行事件
					    	designProcess(row);
						}
				  });
			    });
			</script>
		</div>
	</form>
</body>
</html>