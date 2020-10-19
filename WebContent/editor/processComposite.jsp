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
		
		<%-- var type = "${param.type}";
		var cln = parent.topForm.cloneNode(true);
		document.body.appendChild(cln);
		if(type=='add'){
			cln.action='<%=request.getContextPath()%>/form/formInfo_addFormVersion.action?layoutType=${param.layoutType}';
		}else if(type=="copy"){
			cln.action='<%=request.getContextPath()%>/form/formInfo_copyFormVersion.action?layoutType=${param.layoutType}';
		}
		cln.action= <%=request.getContextPath()%>/editor/flowdesigner.jsp?pdid="+pdid+"&ptid="+ptid+"&containerType=process&containerId="+pdid+"&mode=flow&initFlag=true&processType="+processType;
		
		document.getElementById('Form0').submit(); --%>
		
		var processType = "${param.processType}";
		var pdid = "${param.pdid}";
		var ptid = "${param.ptid}";
		var processId = "${param.processId}";
		var tempCls = "${param.tempCls}";
		var pkgTid = "${param.pkgTid}";
		
		var type = "${param.type}";
		if(type=='update'){
			$("#content").attr("src","<%=path%>/editor/flowdesigner.jsp?pdid="+pdid+"&ptid="+ptid+"&containerType=process&containerId="+pdid+"&mode=flow&initFlag=true&processType="+processType);
		}else {
			$("#content").attr("src","<%=path%>/editor/castFlowdesigner.jsp?pkgTid="+pkgTid+"&type="+type+"&pdid="+pdid+"&tempCls="+tempCls+"&processId="+processId+"&processType="+processType);
		}
		//top.topWin.location.reload();
		
	}
	
	//标签页点击事件
	function aClick(win,title){
		debugger;
		//$('#loading').css('display','');
		//每次点击清除其他标签选中的class
		$('.itme-head').removeClass('select');
		//给当前选中加class
		$(win).addClass('select');
		
		//清楚其他标签下划线 给选中增加
		$('.bottom-line').css('display','none');
		win.parentNode.parentNode.children[1].style.display = "";
		
		var formId = document.getElementById('nodeId').value;
		var formUuid = document.getElementById('formUuid').value;
		if(formUuid==null||formUuid==''){
			formUuid = document.getElementById('initFormUuid').value;
		}
		var templateId = document.getElementById('templateId').value;
		var templateClass = document.getElementById('templateType').value;
		//当前设计器布局类型 1:表格  2:网格
		var layoutType = document.getElementById('layoutType').value;
		//设置各个标签的跳转
		
		var layoutType = $('#layoutType').val();
		if(title=='设计'){
			$('#head').css('display','none');
			$("#main").css('width','100%');
			$('#main').css('height','calc(100% - 60px)');
			$("#main").css('box-shadow','');
			$("#content").css('border','0px');
			$("#content").attr("src","<%=path%>/form/admin/composite/viewChange.jsp?isMobile=false&formUuid="+formUuid);
		}

	}
	
	//返回上级界面
	function backList(){
		/* var templateType = $("#templateType").val();
		var paretnNodeId = $("#paretnNodeId").val();
		childWin.document.getElementById('templateType').value = templateType;
		childWin.document.getElementById('nodeId').value = paretnNodeId;
		var childWin = top.childWindow;
		childWin.refreshData(); 
		*/
		top.topWin.location.reload();
		Matrix.closeWindow();
		<%-- window.location.href = "<%=path%>/form/html5/admin/logon/matrix/h5FormList.jsp?templateType="+templateType+"&nodeId="+paretnNodeId; --%>
	}
	</script>
</head>
<body style="background: rgba(245,245,247,.9);border-top:1px solid white;">
	<!-- 父模板ID 只用于返回上级菜单-->
	<input type="hidden" id="paretnNodeId" name="paretnNodeId" value="${nodeId}">
	<input type="hidden" id="templateType" name="templateType" value="${templateType}">
	
	<!-- 当前模板ID -->
	<input type="hidden" id="templateId" name="templateId" value="${mBizId}">
	
	<!-- 树节点 表单编码 由子页面h5CompositeModel.jsp赋值 -->
	<input type="hidden" id="nodeId" name="nodeId">
	
	<!-- 表单ID 由子页面h5CompositeModel.jsp赋值 -->
	<input type="hidden" id="initFormUuid" name="initFormUuid" value="${initFormUuid}">
	<input type="hidden" id="formUuid" name="formUuid" value="${param.formUuid}">
	
	
	<div class="synergTitle">
		<i onclick="backList();" class="fa fa-angle-left" style="color: #fff;top: 10px;left:15px;font-size: 30px;position: absolute;cursor: pointer;"></i>
 		<div style="top: 15px;left:50px;position: absolute;color:white;font-size:15px">${name}</div>
		<div style="display: inline-table;width: 80px;position: relative;text-align: center;">
			<div style="height: 48px;width:110px">
				<a class="itme-head select" href="javascript:void(0);" onclick="aClick(this,'设计')">设计</a>
			</div>
			<div class="bottom-line" style="width: 100%;background: white;height: 2px;"></div>
		</div>
	</div>
	<!--  
	<div id="loading" style="width:100%;height:100%">
		<img style="position: absolute;margin: auto;top: 0px;bottom: 0px;left: 0px;right: 0px;" src="<%=path %>/image/ajax-loader.gif">
	</div>
	-->
	<div id="head" style="display:none;margin:auto;margin-top:10px;width:85%;height: 50px;padding-top:10px;border:1px solid rgb(231, 234, 236);background:white;box-shadow:0 2px 4px 0 rgba(0,0,0,.08)">
		<div id="form_div" style="top:0px;bottom:0px;right: 10px;padding-top: 15px;margin:auto;position: absolute;">
		</div>
	</div>
	<div id="main" style="margin:auto;width:100%;height: calc(100% - 50px);background:white;";>
		<iframe id="content" style="width:100%;height:100%;" frameborder="0" src="" >
		</iframe>
	</div>
</body>
</html>