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

<script type="text/javascript">

	window.onload = function(){
		//菜单栏变指针
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
		changePC();
	}
	
	//切换PC表单
	function changePC(){
		debugger;
		var templateId = $('#templateId').val();  //当前定制模板主键
		var layoutType = $('#layoutType').val();  //当前布局类型 
		
		var json = {};
		json.mBizId = templateId;
		json.layoutType = layoutType;
		
		$.ajax({
			type:'post',
			url:'<%=path %>/formProcess/formProcess_loadFormDesigner.action',
			data:json,
			dataType:'json',
			success:function(data){
				if(data){	
					var formUuid = data.formUuid; 
					var version = data.version;
					$('#version').val(version);
					//设置当前版本号
					$('#versionNum').text("(V"+ version +".0)");
					
					if(layoutType == '2'){  //网格布局
						var isExtensibleField = document.getElementById('isExtensibleField').value;
						$("#content").attr("src","<%=path%>/form/admin/composite/viewChange.jsp?isMobile=false&formUuid="+formUuid+"&isExtensibleField="+isExtensibleField);
					}else{   //表格布局
						$("#content").attr("src","<%=path%>/form/admin/designer/designer.jsp");
					}
				}		
			}
		});	
	}
	
	//打开表单版本列表窗口
	function openFormVersion(){
		debugger;
		var formType = "pc";  //表单类型  pc电脑  mo移动
		var nodeUuid = $('#nodeUuid').val();
		var templateId = $('#templateId').val();
		var layoutType = $('#layoutType').val();  //当前布局类型 
		var newVersionPolicy = document.getElementById('newVersionPolicy').value;
		var isExtensibleField = document.getElementById('isExtensibleField').value;
		var versionType = document.getElementById('versionType').value;
		var businessId = document.getElementById('businessId').value;
		var orgId = document.getElementById('orgId').value;
		
		layer.open({
			id:'formVersion',
			type : 2,			
			title : ['表单版本列表'],
			shade: [0.1, '#000'],
			shadeClose: false, //开启遮罩关闭
			area : [ '55%', '60%' ],
			content : "<%=path%>/form/formInfo_loadH5FormVersionsList.action?iframewindowid=formVersion&entrance=customForm&formType="+formType+"&layoutType="+layoutType+"&templateId="+templateId+"&newVersionPolicy="+newVersionPolicy+"&isExtensibleField="+isExtensibleField+"&versionType="+versionType+"&businessId="+businessId+"&orgId="+orgId+"&nodeUuid="+nodeUuid
	   });
	}
	
	//表单版本列表窗口回调
	function onformVersionClose(data){
		if(data!=null && data!=''){
			var opType = data.opType;   //操作类型
			if(opType == 'update'){
				var version = data.version;  //版本号
				$('#versionNum').text("(V"+ version +".0)");
				layer.msg('编辑表单中！');
			}else if(opType == 'copy'){
				var version = data.version;  //版本号
				$('#versionNum').text("(V"+ version +".0)");
				Matrix.success('复制成功！');
			}else if(opType == 'delete'){
				Matrix.success('删除成功！');
			}
		}
	}
</script>
</head>
<body>
	<!-- 当前设计器布局类型 1:表格  2:网格 -->
	<input type="hidden" name="layoutType" id="layoutType" value="${param.layoutType}">
	<!-- 电脑表单信息（点击表单设计时URL带入） -->
	<input type="hidden" name="nodeUuid" id="nodeUuid" value="${param.nodeUuid}">
	<input type="hidden" name="formId" id="formId" value="${param.formId}">
	<!-- 当前模板主键编码 -->
	<input type="hidden" name="templateId" id="templateId" value="${param.templateId}">
	<!-- 存放电脑表单的当前版本号 -->
	<input type="hidden" name="version" id="version" value="${version}">
	<!-- 新版本策略    1复制老表单  2继承老表单 -->
	<input type="hidden" name="newVersionPolicy" id="newVersionPolicy" value="${param.newVersionPolicy}">
	<!-- 是否可扩展   1不可扩展   2可扩展 -->
	<input type="hidden" name="isExtensibleField" id="isExtensibleField" value="${param.isExtensibleField}">
	<!-- 版本类型  1:集团基础版本   2业务子版本  3机构子版本 -->
	<input type="hidden" name="versionType" id="versionType" value="${param.versionType}">
	<!-- 业务编码 -->
	<input type="hidden" name="businessId" id="businessId" value="${param.businessId}">
	<!-- 机构编码 -->
	<input type="hidden" name="orgId" id="orgId" value="${param.orgId}">
	
	<div id="web2" style="width: 100%;height: 100%;position: relative;">
		<div id="head" style="position:relative;margin:auto;margin-top:10px;width:85%;height: 50px;border:1px solid rgb(231, 234, 236);background:white;box-shadow:0 2px 4px 0 rgba(0,0,0,.08)">
			<div style="top:0px;bottom:0px;left: 10px;padding-top: 15px;margin:auto;position: absolute;">
				<label style="color:rgb(252, 182, 51);font-size: 14px;padding-left: 10px;cursor: default;" >说明：</label>
				<label style="color:rgb(22, 105, 171);font-size: 14px;padding-left: 10px;cursor: default;padding-right: 10px" >当前为PC表单设计界面</label>
			</div>
			<div style="top:0px;bottom:0px;right: 10px;padding-top: 15px;margin:auto;position: absolute;">
				<label class="flowTools" id="versionBtn" style="color:rgb(22, 105, 171);font-size: 14px;padding-left: 10px;cursor: default;" onclick="openFormVersion()">版本<span id="versionNum" style="color:rgb(252, 182, 51) "></span></label>
			</div>
		</div>
		<div style="margin:auto;margin-top:10px;width:85%;height: calc(100% - 80px);background:white;box-shadow:0 2px 4px 0 rgba(0,0,0,.08)";>
			<iframe id="content" style="border:1px solid rgb(231, 234, 236);width:100%;height:100%;" frameborder="0" src="">
			</iframe>
		</div>
	</div>
</body>
</html>