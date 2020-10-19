<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML>
<html>
<meta http-equiv='pragma' content='no-cache'>
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='0'>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<head>
<jsp:include page="/form/html5/admin/html5Head.jsp"/>
<title>h5表单标签页</title>
<script type="text/javascript">
	
	//刚添加的表单需要刷新树节点
	var opType = "${param.opType}";
	
	if(opType=="add"){
		parent.Matrix.forceFreshTreeNode("Tree0","${param.parentNodeId}");
		
	}

	//版本列表
	function tabPanel001Click(){
		document.getElementById('iframe001').src = "<%=request.getContextPath()%>/form/formInfo_loadFormVersionsPage.action?nodeUuid=${catalogInfo.uuid}";
	}
	
	//基本信息
	function tabPanel002Click(){
		document.getElementById('iframe001').src = "<%=request.getContextPath()%>/form/formInfo_getFormBasicMsgPage.action?nodeUuid=${catalogInfo.uuid}&parentNodeId=${param.parentNodeId}";
	}

</script>
</head>
<body>
<form id="Form0" name="Form0" eventProxy="MForm0" method="post"
	action="/entity"
	style="margin: 0px; height: 100%;"
	enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="Form0" value="Form0"/>
	<input type="hidden" id="nodeUuid" name="nodeUuid" value="${catalogInfo.uuid}" />
	<input type="hidden" name="parentNodeId" value="parentNodeId" value="${param.parentNodeId}" />
	
	<input type="hidden" name="layoutType" value="layoutType" value="${layoutType}" />
	
	<input name="currentUser" id="currentUser" type="hidden" value="${requestScope.currentUser}">
	<input name="version" id="version" type="hidden">
	<input type="hidden" id="mid" name="mid">
	<input name="type" id="type" type="hidden" value="${catalogInfo.type}">
	
	<!-- 子页面的隐藏字段 -->
	<input type="hidden" id="name" name="name" >
	<input type="hidden" id="desc" name="desc" >
	<!-- 授权列表 子页面的隐藏字段 -->
	<input type="hidden" id="formUuid" name="formUuid" >
		<div id="TabContainer001_div" class="form-group col-md-12 formItem" style="width:100%;height:100%;overflow:auto;height: 100%">
			<ul id="TabContainer001" style="height:40px" class="nav nav-tabs disable">
				<li class="active">
					<a href="#TabPanel001" data-toggle="tab" onclick="tabPanel001Click()">版本列表</a>
				</li>
				<li>
					<a href="#TabPanel002" data-toggle="tab" onclick="tabPanel002Click()">基本信息</a>
				</li>
			</ul>
			<div id="content-main" class="tab-content" style="border-color: #e7eaec;-webkit-border-image: none;-o-border-image: none;border-image: none;border-style: solid;border-width: 1px;border-top: 0px;height: calc(100% - 40px)">
				<iframe scrolling="no" id="iframe001" frameborder="0" src="<%=request.getContextPath()%>/form/formInfo_loadFormVersionsPage.action?nodeUuid=${catalogInfo.uuid}" style="height: 100%;width: 100%" ></iframe>
			</div>
		</div>
	</form>
</body>
</html>