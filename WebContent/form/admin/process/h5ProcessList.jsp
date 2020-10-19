<%@page import="com.matrix.app.MAppProperties"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page
	import="com.matrix.engine.foundation.domain.PkgTemplateKeyInfoVO,
		java.text.SimpleDateFormat,
		com.matrix.api.MFExecutionService,
   		com.matrix.api.template.PublicationStatus,
   		com.matrix.api.identity.*,
		com.matrix.client.TextUtils,
		com.matrix.form.admin.common.utils.*,
		com.matrix.engine.foundation.config.OrganizationTable,
		com.matrix.engine.foundation.config.MFSystemProperties,
		com.matrix.api.config.RunModeType,
		com.matrix.client.ClientConstants,
		java.util.*,
		com.matrix.form.admin.common.utils.CommonUtil"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>H5流程版本列表</title>
<jsp:include page="/form/html5/admin/html5Head.jsp"/>
<%
	MFExecutionService mfes = (MFExecutionService)session.getAttribute(ClientConstants.EXECUTION_SERVICE);
	MFUser user = mfes.getMFUser();
	String userId = user.getUserId();
	int releasedType = PublicationStatus.RELEASED_TYPE;
	int underReleasedType = PublicationStatus.UNDER_REVISION_TYPE;
	boolean isAdmin = CommonUtil.isSysAdmin();
	
	String sessionId = mfes.getSessionId();
	String contextPath = "";
	if(request.getContextPath() != null && request.getContextPath().trim().length()>0)
		contextPath = 	request.getContextPath().substring(1);

	String url = request.getRequestURL().toString();
	String serverIp = request.getServerName();
	int serverPort = request.getServerPort();
	String params = "";
	params +="serverIp="+serverIp;
	params +="&contextPath="+contextPath;
	params +="&sessionId="+sessionId;
	params +="&userId="+userId;
	params +="&serverPort="+serverPort;
	params +="&simulationType=2&mode=design";
	
	
	// 获得产品模式
	RunModeType modeType = mfes.getMFConfig().getRunModeType();
	boolean isProductMode = false;
	if(modeType.getValue()==RunModeType.PRODUCT_TYPE){
		isProductMode = true;
	}
	
	//是否启用集团
	boolean isGroupEnable = MAppProperties.getInstance().isGroupEnable();  
%>
<script>
	var userId = "<%=userId %>";
	var isAdmin = <%=isAdmin %>;
	var releasedType = <%=releasedType %>;
	var underReleasedType = <%=underReleasedType %>;
	var isProductMode = <%=isProductMode %>;
    
	$(function(){
		var entrance = $('#entrance').val();  // 入口  customForm：定制表单时表单版本入口
		
		//定制流程时集团基础版本不能添加 复制 删除  取消发布  迁移版本
   		if(entrance == 'customProcess'){
   			document.getElementById('MtoolBarItemAdd').style.display = 'none';
   			var versionType = $('#versionType').val();
			if(versionType == '1'){   //集团基础版本
				document.getElementById('MtoolBarItemDel').style.display = 'none';	
   		   		document.getElementById('MtoolBarItemCopy').style.display = 'none';	
   		   		document.getElementById('MtoolBarItemCancel').style.display = 'none';	
   		   		document.getElementById('MtoolBarItemPreview').style.display = 'none';			
			}else{
				document.getElementById('MtoolBarItemDel').style.display = '';	
   		   		document.getElementById('MtoolBarItemCopy').style.display = '';	
   		   		document.getElementById('MtoolBarItemCancel').style.display = '';	
   		   		document.getElementById('MtoolBarItemPreview').style.display = '';	
			}
		}else{
			document.getElementById('MtoolBarItemAdd').style.display = '';
	   		document.getElementById('MtoolBarItemDel').style.display = '';	
	   		document.getElementById('MtoolBarItemCopy').style.display = '';	
	   		document.getElementById('MtoolBarItemCancel').style.display = '';	
	   		document.getElementById('MtoolBarItemPreview').style.display = '';	
		}
		
		if(isProductMode){
			//$('#MtoolBarItemCancel').attr('disabled',true);
			document.getElementById('MtoolBarItemCancel').style.display = 'none';
		}
	});
	
	//点击选择
	function singleClickSelect(row, element){
		$('.changeColor').removeClass('changeColor');//去除之前选中的行的，选中样式
		$(element).addClass('changeColor');
		
		var entrance = $('#entrance').val();  // 入口  customForm：定制表单时表单版本入口
		if(entrance == 'customProcess'){
			var isCustomVersion = row.isCustomVersion;
			if(isCustomVersion == true){   //当前定制下的流程才可删除 撤销发布
				$('#MtoolBarItemDel').attr('disabled',false);
				$('#MtoolBarItemCancel').attr('disabled',false)
			}else{
				$('#MtoolBarItemDel').attr('disabled',true);
				$('#MtoolBarItemCancel').attr('disabled',true)
			}
		}
	}
	
	//双击行事件
	function doubleClickSelect(row){
		var record = row;
		var processType = Matrix.getFormItemValue("processType");
		designProcess(record);
	}
	
	//添加流程
	function createProcess(){
		var pdid = document.getElementById("pdid").value;
    	var processType = document.getElementById("processType").value;
		var json = {};
		json.processId = pdid;
		json.tempCls = processType;
		$.ajax({
			type:'post',
			url:'<%=path %>/process/processTmplAction_h5CreateProcessTmpl.action',
			data:json,
			dataType:'json',
			success:function(data){
				if(data){
					var ptid = data.ptid;
					var version = data.version;  //版本号
					
					var isShowSave = getIsShowSave(data);
					parent.$('#content').attr('src','<%=path%>/editor/flowdesigner.jsp?isShowSave='+isShowSave+'&pdid='+pdid+'&ptid='+ptid+'&containerType=process&containerId='+pdid+'&mode=flow&initFlag=true&processType='+processType);
					var data = {};
					data.opType = 'add';
					data.version = version;
					Matrix.closeWindow(data);
				}
			},
			error:function(data){
				Matrix.warn('添加失败！');
	        }
		});
	}
	
	//编辑流程
	function editProcess(){
		var $tr = $('#DataGrid001_table').find('tr.changeColor');   //选中行
		if($tr!=null && $tr.length==1){
			var index = $tr.data('index');  //获得选中的行的index
       		var item = Matrix.getGridData('DataGrid001');   //所有数据
       		var record = item[index];  //当前选中行
       		doubleClickSelect(record);
		}else{
			Matrix.warn("请先选中要修改的流程版本！");
		}
	}
	
	//删除流程
	function deleteProcess(){
		var $tr = $('#DataGrid001_table').find('tr.changeColor');   //选中行
		if($tr!=null && $tr.length==1){
       		var item = Matrix.getGridData('DataGrid001');   //所有数据
       		if(item.length==1){
       			Matrix.warn("只有一个流程版本不可删除！");
       		}else{
       			var index = $tr.data('index');  //获得选中的行的index
       			var record = item[index];  //当前选中行
       			if(record.status == 3){
       				Matrix.warn("已发布流程不能直接删除，请先取消发布！");
       				return;
       			}	
       			Matrix.confirm("确定要删除选择的流程版本吗？",function(value){value=true;if(value){deleteProcessSubmit(record)}});		
       		}
		}else{
			Matrix.warn("请先选中要删除的流程版本！");
		}	
	}
	
	//删除流程版本
	function deleteProcessSubmit(record){
		if(record.status == 3){
			Matrix.warn("已发布流程不能直接删除，请先取消发布！");
			return;
		}	
		var data = {};
		data["pkgTid"]=record.pkgTid;
		var url = "<%=path%>/process/processTmplAction_deleteProcessTmpl.action";
		Matrix.sendRequest(url,data,
			function(response){
				if("true"==response.data){
					Matrix.refreshDataGridData('DataGrid001');
					//先删除再重新加载
					parent.$("#templateSelect").remove();
					parent.getData();  //刷新流程设计父页面
					Matrix.say("删除成功！");
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
	
	//复制流程
	function copyProcess(){
		var $tr = $('#DataGrid001_table').find('tr.changeColor');   //选中行
		if($tr!=null && $tr.length==1){
			var index = $tr.data('index');  //获得选中的行的index
       		var item = Matrix.getGridData('DataGrid001');   //所有数据
       		var record = item[index];  //当前选中行
			document.getElementById("pkgTid").value = record.pkgTid;
			
			var pdid = document.getElementById("pdid").value;
	    	var processType = document.getElementById("processType").value;
			var json = {};
			json.pkgTid = record.pkgTid;
			$.ajax({
				type:'post',
				url:'<%=path %>/process/processTmplAction_h5CopyProcessTmpl.action',
				data:json,
				dataType:'json',
				success:function(data){
					if(data){
						var ptid = data.ptid;
						var version = data.version;  //版本号
						
						var isShowSave = getIsShowSave(record);
						parent.$('#content').attr('src','<%=path%>/editor/flowdesigner.jsp?isShowSave='+isShowSave+'&pdid='+pdid+'&ptid='+ptid+'&containerType=process&containerId='+pdid+'&mode=flow&initFlag=true&processType='+processType);
						var data = {};
						data.opType = 'copy';
						data.version = version;
						Matrix.closeWindow(data);
					}
				},
				error:function(data){
		            Matrix.warn('复制失败！');
		        }
			});
		}else{
			Matrix.warn("请先选中要复制的流程版本！");
		}
	}
	
	//撤销发布流程版本
	function cancelPublishedProcess(){
		var $tr = $('#DataGrid001_table').find('tr.changeColor');   //选中行
		if($tr!=null && $tr.length==1){
			var index = $tr.data('index');  //获得选中的行的index
       		var item = Matrix.getGridData('DataGrid001');   //所有数据
       		var record = item[index];  //当前选中行
       		
       		if(record.status!=releasedType){
    			Matrix.warn("请选择已经发布的流程版本！");
    			return false;
    		}
       		Matrix.confirm("取消发布流程版本将删除所有相关的流程实例数据，是否继续？",function(value){value=true;if(value){cancelPublishedStatusSubmit(record)}});
    		return false;
		}else{
			Matrix.warn("请选择要取消发布的流程版本！");
		}
	}
	
	//取消发布流程
	function cancelPublishedStatusSubmit(record){
		var selectedTmplTID = record.pkgTid;
		var pdid = document.getElementById("pdid").value;
    	var processType = document.getElementById("processType").value
	    var data = {};
		data["selectedTmplTID"] = selectedTmplTID;
		var url = "<%=path%>/process/processTmplAction_cancelPublishedStatus.action";
		Matrix.sendRequest(url,data,
			function(response){
				if("true"==response.data){
					Matrix.refreshDataGridData('DataGrid001');
					
					var isShowSave = getIsShowSave(record);
					parent.$('#content').attr('src','<%=path%>/editor/flowdesigner.jsp?isShowSave='+isShowSave+'&pdid='+pdid+'&ptid='+selectedTmplTID+'&containerType=process&containerId='+pdid+'&mode=flow&initFlag=true&processType='+processType);
					Matrix.say("取消发布流程版本成功！");
				}else{
					Matrix.warn("取消发布流程版本失败！");
				}
			},
			function(){
				Matrix.warn("取消发布流程版本失败！");
				return false;
			}
		);
	}
	
	//迁移流程
	function upgradeProcess(){
		var $tr = $('#DataGrid001_table').find('tr.changeColor');   //选中行
		if($tr!=null && $tr.length==1){
			var index = $tr.data('index');  //获得选中的行的index
       		var item = Matrix.getGridData('DataGrid001');   //所有数据
       		var record = item[index];  //当前选中行
       		
       		if(record.status != 3){
    			Matrix.warn("只有发布状态才能迁移！");
    			return;
    		}	
 			var upgradePkgTmplId = record.pkgTid;
 			var processId = document.getElementById("processId").value;
 			document.getElementById("upgradePkgTmplId").value = upgradePkgTmplId;
			var src = "<%=path%>/process/processTmplAction_querySelectedPkgTemplates.action?iframewindowid=selectProcessTmplWindow&upgradePkgTmplId=" + upgradePkgTmplId + "&processId=" + processId +"";
		    layer.open({
		    	type:2,
		    	area:['90%','90%'],
		    	title:['选择流程版本'],
		    	content:src
		    });
		}else{
			Matrix.warn("请选择要迁移的流程版本！");
		}
	}
	
    //设计流程
	function designProcess(record){
		var pdid = document.getElementById("pdid").value;
    	var ptid = record.pkgTid;
    	var version = record.RH_VERSION;  //版本号
    	var processType = document.getElementById("processType").value;
    	
    	var isShowSave = getIsShowSave(record);
		parent.$('#content').attr('src','<%=path%>/editor/flowdesigner.jsp?isShowSave='+isShowSave+'&pdid='+pdid+'&ptid='+ptid+'&containerType=process&containerId='+pdid+'&mode=flow&initFlag=true&processType='+processType);
		var data = {};
		data.opType = 'update';
		data.version = version;
		Matrix.closeWindow(data);
	}
    
    
    function getIsShowSave(record){
    	var entrance = document.getElementById("entrance").value;  // 入口  customForm：定制表单时表单版本入口
    	var isShowSave = true;  //是否显示保存 发布  取消发布按钮
    	if(entrance == 'customProcess'){
    		var isCustomVersion = record.isCustomVersion;   //是否分公司版本   true为是
    		//操作设计基础版本时不可保存 发布  取消发布
       		var versionType = document.getElementById('versionType').value;
    		if(!isCustomVersion || versionType == 1){   //当前定制下的表单才可保存 发布  取消发布
    			isShowSave = false;
    		}
    	}
    	return isShowSave;
    }
</script>
</head>
<body>
  <form id="form0" name="form0" eventProxy="Mform0" method="post" style="margin: 0px; position: relative; width: 100%; height: 100%;padding-left:6px;padding-right:6px;">
	 <input type="hidden" id="processId" name="processId" value="${param.processId}">
	 <input type="hidden" id="pdid" name="pdid" value="${param.processId}">
	 <input type="hidden" id="processType" name="processType" value="${param.processType}">
	 <input type="hidden" id="pkgTid" name="pkgTid" value="">
	 <input type="hidden" id="upgradePkgTmplId" name="upgradePkgTmplId">
	 <!-- 当前模板主键编码 -->
	 <input type="hidden" id="templateId" name="templateId" value="${param.templateId}">
	 <!-- 入口  customProcess：定制流程时流程版本入口 -->
	 <input type="hidden" name="entrance" id="entrance" value="${param.entrance}">
	 <!-- 版本类型  1:集团基础版本   2业务子版本  3机构子版本 -->
	 <input type="hidden" name="versionType" id="versionType" value="${param.versionType}">
	 <!-- 业务编码 -->
	 <input type="hidden" name="businessId" id="businessId" value="${param.businessId}">
	 <!-- 机构编码 -->
	 <input type="hidden" name="orgId" id="orgId" value="${param.orgId}">
	 <!-- 是否启用集团 -->
	 <input type="hidden" id="isGroupEnable" name="isGroupEnable" value="<%=isGroupEnable %>">
		
	 <div style="height: calc(100% - 54px);overflow: auto;">
		<table id="DataGrid001_table" style="width:100%;height:100%;">
		</table>
		
		<script>
			$(document).ready(function() { 
				var entrance = $('#entrance').val();  // 入口  customForm：定制表单时表单版本入口
				
				var processId = document.getElementById('processId').value;
				var processType = document.getElementById('processType').value;
				var isGroupEnable = $('#isGroupEnable').val();  //是否启用集团
				
				$("#DataGrid001_table").bootstrapTable({           
					classes: 'table table-hover table-no-bordered',
					method: "post", 
					url: "<%=path%>/process/processTmplAction_queryProcessList.action?processId="+processId+"&processType="+processType, 
					search: false, 
					sidePagination: "server", clickToSelect: true, sortable: false,   
					onDblClickRow:function(row){
						doubleClick(row);
					},
					formatLoadingMessage: function() {
			            return '请稍等，正在加载中...';
				    },
					formatNoMatches: function() {
			            return '无符合条件的记录';
			        },
				    columns: [
				        {title:"名称",field:"PACKAGE_NAME",sortable:true,clickToSelect:true,editorType:'Text',type:'text'},
				    	{title:"版本",field:"RH_VERSION",sortable:true,clickToSelect:true,editorType:'Text',type:'text'},
				    	{title:"创建时间",field:"CREATED_TIME",sortable:true,clickToSelect:true,editorType:'Text',type:'text'},
				    	{title:"最后更新时间",field:"PKG_SUBMIT_TIME",sortable:true,clickToSelect:true,editorType:'Text',type:'text'},
				    	{title:"状态",field:"RH_PUB_STATUS",sortable:true,clickToSelect:true,editorType:'Text',type:'text'},
				    	{title:"当前操作人",field:"PACKAGE_OWNER",sortable:true,clickToSelect:true,editorType:'Text',type:'text',visible:false},
				    	{title:"最后更新人",field:"PKG_SUBMIT_ID",sortable:true,clickToSelect:true,editorType:'Text',type:'text'},
				    	{title:"机构名称",field:"ORG_NAME",sortable:true,clickToSelect:true,editorType:'Text',type:'text',visible:isGroupEnable=='true'?true:false},
				    	{title:"业务编码",field:"BUSINESS_ID",sortable:true,clickToSelect:true,editorType:'Text',type:'text',visible:false},
				    	{title:"业务名称",field:"BUSINESS_NAME",sortable:true,clickToSelect:true,editorType:'Text',type:'text',visible:entrance=='customProcess'?true:false},
				    	{title:"是否当前要定制的版本",field:"isCustomVersion",sortable:true,clickToSelect:true,editorType:'Text',type:'text',visible:false}
				    ],
				    singleSelect:true,  //设置true将禁止多选
				    onClickRow:function(row, $element){   //单击行事件
				    	singleClickSelect(row, $element);
					},
				    onDblClickRow:function(row){   //双击行事件
				    	doubleClickSelect(row);
					},
				 });
		     });
		</script>
	</div>
	<div class="cmdLayout">
		<button type="button" class="btn  btn-default toolBarItem" id="MtoolBarItemAdd" style="padding-left:5px;padding-right:5px;margin:0px;border:0;display:none;" onclick="createProcess();">
			<img src="<%=path%>/resource/images/new.png" style="padding-right: 2px;">添加
		</button>
		<button type="button" class="btn  btn-default toolBarItem" id="MtoolBarItemEdit" style="padding-left:5px;padding-right:5px;margin:0px;border:0;" onclick="editProcess();">
			<img src="<%=path%>/resource/images/edit.png" style="padding-right: 2px;">编辑
		</button>
		<button type="button" class="btn  btn-default toolBarItem" id="MtoolBarItemDel" style="padding-left:5px;padding-right:5px;margin:0px;border:0;display:none;" onclick="deleteProcess();">
			<img src="<%=path%>/resource/images/deletex.png" style="padding-right: 4px;">删除
		</button>	
		<button type="button" class="btn  btn-default toolBarItem" id="MtoolBarItemCopy" style="padding-left:5px;padding-right:5px;margin:0px;border:0;display:none;" onclick="copyProcess();">
			<img src="<%=path%>/resource/images/relatarc.png" style="padding-right: 2px;">复制
		</button>
		<button type="button" class="btn  btn-default toolBarItem" id="MtoolBarItemCancel" style="padding-left:5px;padding-right:5px;margin:0px;border:0;display:none;" onclick="cancelPublishedProcess();">
			<img src="<%=path%>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/actions/exit.png" style="padding-right: 2px;">撤销发布
		</button>
		<button type="button" class="btn  btn-default toolBarItem" id="MtoolBarItemPreview" style="padding-left:5px;padding-right:5px;margin:0px;border:0;display:none;" onclick="upgradeProcess();">
			<img src="<%=path%>/resource/images/preview.png" style="padding-right: 4px;">迁移
		</button>
	</div>
  </form>
</body>
</html>