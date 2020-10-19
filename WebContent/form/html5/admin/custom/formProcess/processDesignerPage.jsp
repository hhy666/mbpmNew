<%@page import="com.matrix.form.admin.common.utils.CommonUtil"%>
<%@page pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<jsp:include page="/form/html5/admin/html5Head.jsp"/>
<title>Insert title here</title>
<%
	boolean isAdmin = CommonUtil.isSysAdmin();
%>
<style type="text/css">
	.dropdown-menu {
	    position: absolute;
	    top: 100%;
	    left: 0;
	    z-index: 1000;
	    display: none;
	    float: left;
	    min-width: 100px;
	    padding: 5px 0;
	    margin: 2px 0 0;
	    font-size: 14px;
	    text-align: left;
	    list-style: none;
	    background-color: #fff;
	    -webkit-background-clip: padding-box;
	    background-clip: padding-box;
	    border: 1px solid #ccc;
	    border: 1px solid rgba(0, 0, 0, .15);
	    border-radius: 4px;
	    -webkit-box-shadow: 0 6px 12px rgba(0, 0, 0, .175);
	    box-shadow: 0 6px 12px rgba(0, 0, 0, .175);
	}
	.dropdown-menu.operation> li > a:hover, .dropdown-menu.operation > li > a:focus {
	    color: #262626;
	    text-decoration: none;
	    background-color: rgba(13,179,166,.1);
	}
</style>
<script type="text/javascript">
	
	var isAdmin = <%=isAdmin %>;

	window.onload = function(){
		//菜单栏变色变指针
		$(".flowTools").mouseover(function(){
			$(this).css("cursor","pointer");
		});
		
		$(".flowTools").mouseleave(function(){
			$(this).css("cursor","default");
		});
		
		parent.Matrix.hideMask2();
		parent.layer.close(parent.layer.load());//关闭加载层
		
		getData();
	}
	
	//删除流程版本时刷新
	function getData(){
		getFlowVersion();
	}
	
	//获取当前流程最新版本 
	function getFlowVersion(){
		debugger;
		var pdid = $("#processId").val();
		var processType = $("#processType").val();
		var templateId = $('#templateId').val();
		
		var json = {};
		json.mBizId = templateId;
		$.ajax({
			type:'post',
			url:'<%=path %>/formProcess/formProcess_loadFlowDesigner.action',
			data:json,
			dataType:'json',
			success:function(data){
				if(data){
					var ptid = data.ptid; 
					var version = data.version; //版本号
					$('#version').val(version);
					//设置当前版本号
					$('#versionNum').text("(V"+ version +")");
					
					var isShowSave = getIsShowSave(data);
					$('#content').attr('src','<%=path%>/editor/flowdesigner.jsp?isShowSave='+isShowSave+'&pdid='+pdid+'&ptid='+ptid+'&containerType=process&containerId='+pdid+'&mode=flow&initFlag=true&processType='+processType);
				}
				
			}
		});
	}
	
	
	//打开流程版本列表窗口
	function openFlowVersion(){
		var processId = $('#processId').val();
		var processType = $('#processType').val();
		var templateId = $('#templateId').val();
		var versionType = document.getElementById('versionType').value;
		var businessId = document.getElementById('businessId').value;
		var orgId = document.getElementById('orgId').value;
		
		layer.open({
			id:'flowVersion',
			type : 2,
			title : ['流程版本列表'],
			shade: [0.1, '#000'],
			shadeClose: false, //开启遮罩关闭
			area : [ '45%', '55%' ],
			content : "<%=path%>/form/admin/process/h5ProcessList.jsp?iframewindowid=flowVersion&entrance=customProcess&templateId="+templateId+"&versionType="+versionType+"&businessId="+businessId+"&orgId="+orgId+"&processId="+processId+"&processType="+processType
	   });
	}
	
	//流程版本列表窗口回调
	function onflowVersionClose(data){
		if(data!=null && data!=''){
			var opType = data.opType;   //操作类型
			var version = data.version;  //版本号
			$('#version').val(version);
			$('#versionNum').text("(V"+ version +")");
			
			if(opType == 'add'){
				Matrix.say('添加成功！');
			}else if(opType == 'update'){
				layer.msg('编辑流程中！');
			}else if(opType == 'copy'){
				Matrix.say('复制成功！');
			}
		}
	}
	
	 function getIsShowSave(record){
		debugger;
    	var isShowSave = true;  //是否显示保存 发布  取消发布按钮
   		var isCustomVersion = record.isCustomVersion;   //是否当前定制模板下的版本   true为是
   		//一级管理员和二级管理员操作设计基础版本时不可保存 发布  取消发布
   		if(!isCustomVersion){
   			isShowSave = false;
   		}
    	return isShowSave;
    }
	 
	var winObj;
	var rowNum = null;  //当前操作设置行的顺序号
	//实施时 流程设计数据权限
	function onoperationSetClose(data){
		winObj.onoperationSetClose(data, rowNum);
	}
</script>
</head>
<body>
	<!-- 当前模板主键-->
	<input type="hidden" id="templateId" name="templateId" value="${param.templateId}">
	<!-- 当前流程编码-->
	<input type="hidden" id="processId" name="processId" value="${param.processId}">
	<!-- 默认直接是2协同 -->
	<input type="hidden" id="processType" name="processType" value="2">
	<!-- 当前流程版本 -->
	<input type="hidden" name="version" id="version">
	<!-- 版本类型  1:集团基础版本   2业务子版本  3机构子版本 -->
	<input type="hidden" name="versionType" id="versionType" value="${param.versionType}">
	<!-- 业务编码 -->
	<input type="hidden" name="businessId" id="businessId" value="${param.businessId}">
	<!-- 机构编码 -->
	<input type="hidden" name="orgId" id="orgId" value="${param.orgId}">

	<div id="web2" style="position: absolute;width: 100%;height: 100%;">
		<div id="head" style="position:relative;margin:auto;margin-top:10px;width:85%;height: 50px;border:1px solid rgb(231, 234, 236);background:white;box-shadow:0 2px 4px 0 rgba(0,0,0,.08)">
			<div style="top:0px;bottom:0px;left: 10px;padding-top: 15px;margin:auto;position: absolute;">
				<label style="color:rgb(252, 182, 51);font-size: 14px;padding-left: 10px;cursor: default;" >说明：</label>
				<label style="color:rgb(22, 105, 171);font-size: 14px;padding-left: 10px;cursor: default;padding-right: 10px" >当前为流程设计界面</label>
			</div>
			<div style="top:0px;bottom:0px;right: 10px;padding-top: 15px;margin:auto;position: absolute;">
				<label style="color:rgb(22, 105, 171);font-size: 14px;cursor: pointer;" onclick="openFlowVersion()">版本<span id="versionNum" style="color:rgb(252, 182, 51) "></span></label>
			</div>
		</div>
		<div style="margin:auto;margin-top:10px;width:85%;height: calc(100% - 80px);background:white;box-shadow:0 2px 4px 0 rgba(0,0,0,0.16), 0 2px 8px 0 rgba(0,0,0,0.12)";>
			<iframe id="content" style="border:1px solid rgb(231, 234, 236);width:100%;height:100%;" frameborder="0" src="">
			</iframe>
		</div>
	</div>
</body>
</html>