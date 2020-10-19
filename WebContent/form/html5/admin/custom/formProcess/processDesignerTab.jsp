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
<link rel='stylesheet' href='<%=path%>/resource/html5/css/font-awesome.min.css'/>
<title>Insert title here</title>

<script type="text/javascript">

	window.onload = function(){
		debugger;
		Matrix.showMask2();
		var index = layer.load(0, {shade: false}); //0代表加载的风格，支持0-2
		
		var processId = document.getElementById('processId').value;
		var templateId = document.getElementById('templateId').value;
		
		var versionType = document.getElementById('versionType').value;
		var businessId = document.getElementById('businessId').value;
		var orgId = document.getElementById('orgId').value;
		
		//加载流程设计
		$("#content").attr("src","<%=path%>/form/html5/admin/custom/formProcess/processDesignerPage.jsp?processId="+processId+"&templateId="+templateId+"&versionType="+versionType+"&businessId="+businessId+"&orgId="+orgId+"&mHtml5Flag=true");
	}
	
	//返回上级界面
	function backList(){
		var templateType = $("#templateType").val();
		var paretnNodeId = $("#paretnNodeId").val();
		var childWin = top.childWindow;
		childWin.document.getElementById('templateType').value = templateType;
		childWin.document.getElementById('nodeId').value = paretnNodeId;
		
		//关闭流程定制窗口时清除session
		$.ajax({
            url: '<%=path%>/formProcess/formProcess_clearCustomSession.action',
            data: null,
            type: "post",
            dataType: "json",
            async: false, // 同步
            success: function (result) {
         		
            }
        });
		Matrix.closeWindow();		
	}
</script>
</head>
<body style="background: rgba(245,245,247,.9)">
	<!-- 父模板ID 只用于返回上级菜单-->
	<input type="hidden" id="paretnNodeId" name="paretnNodeId" value="${nodeId}">
	<!-- 当前模板类型 4定制表单  5定制流程 -->
	<input type="hidden" id="templateType" name="templateType" value="${templateType}">	
	<!-- 当前模板ID -->
	<input type="hidden" id="templateId" name="templateId" value="${mBizId}">	
	<!-- 流程编码 -->
	<input type="hidden" id="processId" name="processId" value="${processId}">
	<!-- 版本类型  1:集团基础版本   2业务子版本  3机构子版本 -->
	<input type="hidden" name="versionType" id="versionType" value="${versionType}">
	<!-- 业务编码 -->
	<input type="hidden" name="businessId" id="businessId" value="${businessId}">
	<!-- 机构编码 -->
	<input type="hidden" name="orgId" id="orgId" value="${orgId}">
	
	<div id="matrixMask" name="matrixMask" class="matrixMask" style="width: 100%; height: 100%; position: absolute;top: 1;left: 1;z-index: 9999999999999;display: none;"> </div>
	<div class="synergTitle">
		<i onclick="backList();" class="fa fa-angle-left" style="color: #fff;top: 10px;left:15px;font-size: 30px;position: absolute;cursor: pointer;"></i>
		<div style="top: 15px;left:50px;position: absolute;color:white;font-size:15px">${name}</div>
		<div style="display: inline-table;width: 80px;position: relative;text-align: center;">
			<div style="height: 48px;width:110px">
				<a class="itme-head select" href="javascript:void(0);">流程设计</a>
			</div>
			<div class="bottom-line" style="width: 100%;background: white;height: 2px;"></div>
		</div>		
	</div>
	<div id="main" style="margin:auto;margin-top:0px;width:100%;height: calc(100% - 50px);background:white;">
		<iframe id="content" style="width:100%;height:100%;" frameborder="0" src="" >
		</iframe>
	</div>
</body>
</html>