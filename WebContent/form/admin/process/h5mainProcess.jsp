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
<%@taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML>
<html>
<meta http-equiv='pragma' content='no-cache'>
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='0'>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<head>
<jsp:include page="/form/html5/admin/html5Head.jsp"/>
<%
	MFExecutionService mfes = (MFExecutionService)session.getAttribute(ClientConstants.EXECUTION_SERVICE);

	int phase = CommonUtil.getCurPhase();
	boolean isScene = false;
	//设计开发和调整优化阶段  流程是一样的---lpz----
	if(phase==4||phase==3){
		isScene = true;
	}
	//if(phase==4){
	//	isScene = true;
	//}
	
	
	// 获得产品模式
	//RunModeType modeType = mfes.getMFConfig().getRunModeType();
	//boolean isProductMode = false;
	//if(modeType.getValue()==RunModeType.PRODUCT_TYPE){
	//	isProductMode = true;
	//}
	MFUser user = mfes.getMFUser();
	String userId = user.getUserId();
	int releasedType = PublicationStatus.RELEASED_TYPE;
	int underReleasedType = PublicationStatus.UNDER_REVISION_TYPE;
	
	//String processId = request.getParameter("processId");
	//String parentNodeId = request.getParameter("parentNodeId");
	
	boolean isAdmin = CommonUtil.isSysAdmin();
	
	// 获得设计器所需要的其他参数
	String sessionId = mfes.getSessionId();
	//OrganizationTable orgTable = MFSystemProperties.getInstance().getOrganizationTable();
	//String orgId = orgTable.getDepParentIdDefault();
	//String roleRootId = orgTable.getRoleParentIdDefault();
	//boolean isTreeType = orgTable.getRoleIsTreeFlag();
    //String roleViewType = "grid"; 
	//if(isTreeType)
	//	 roleViewType = "tree"; 
//    String contextPath = request.getContextPath().substring(1);
    String contextPath = "";
 	//String serverIp = request.getLocalAddr();
	String serverIp = request.getServerName();
    int serverPort = request.getServerPort();
    //String returnUrl = "process/process_queryPkgTemplates.action";//获得客户端发送请求的完整url
    
    String params = "";
  //  params +="serverIp="+serverIp;
 //   params +="&contextPath="+contextPath;
  //  params +="&sessionId="+sessionId;
 //   params +="&userId="+userId;
   // params +="&serverPort="+serverPort;
   // params +="&mode=design";
    
%>
<title>h5协同流程</title>
<script type="text/javascript">
	
var parentNodeId = "${param.parentNodeId}";
var processId = "${param.processId}";
var endtityId = "${param.entityId}";

var userId = "<%=userId %>";
var isAdmin = <%=isAdmin %>;
var releasedType = <%=releasedType %>;
var underReleasedType = <%=underReleasedType %>;
var sessionId =  "<%=sessionId %>";
var serverIp =  "<%=serverIp %>";
var serverPort = "<%=serverPort %>";
var contextPath = "<%=contextPath %>";
var isScene = "<%=isScene %>";

	window.onload = function(){
		var processType = document.getElementById('processType').value;
		
		var processListURL = "<%=request.getContextPath()%>/process/processTmplAction_queryPkgTemplates.action?processId=${param.processId}&tempCls=${param.tempCls}";
		if(processType!=null&&processType.length>0){
			processListURL+="&processType="+processType;
		}
		document.getElementById('iframe001').src = processListURL;
	}

	
	 //刷新协同流程目录节点
	 function refreshProcessCatalogTreeNode(){
	 	parent.Matrix.forceFreshTreeNode("Tree0", parentNodeId);
	 }
	 
	 //判断是否是新增流程
	 var isNewProcess =  "${isNewProcess}";
	 if(isNewProcess=="true"){
	 	refreshProcessCatalogTreeNode();
	 }

	//创建流程
	function createProcess(){
		var processType = document.getElementById("processType").value;
		/* var action = webContextPath+"/process/processTmplAction_createProcessTmpl.action?processType="+processType;
		document.getElementById("processForm").action=action;
		document.getElementById("processForm").submit(); */
		
		var pdid = document.getElementById("pdid").value;
		var tempCls = document.getElementById("tempCls").value;
		var processId = document.getElementById("processId").value;
		
		top.topWin = window;
		top.layer.open({
	   	type:2,
			title:false,
			area:['100%','100%'],
			closeBtn:0,
			content:'<%=request.getContextPath()%>/process/processTmplAction_toDesignComposite.action?type=add&processId='+processId+'&tempCls='+tempCls+'&pdid='+pdid+'&processType='+processType
	    });
	}
	
	 //复制流程
	 function copyProcess(pkgTid,window){
	 	/* document.getElementById("pkgTid").value=pkgTid;
		var action = webContextPath+"/process/processTmplAction_copyProcessTmpl.action";
		document.getElementById("processForm").action=action;
		document.getElementById("processForm").submit(); */
		
		var pdid = document.getElementById("pdid").value;
	 	var processType = document.getElementById("processType").value;
		top.topWin = window;
		top.layer.open({
	    	type:2,
			title:false,
			area:['100%','100%'],
			closeBtn:0,
			content:'<%=request.getContextPath()%>/process/processTmplAction_toDesignComposite.action?type=copy&pkgTid='+pkgTid+'&pdid='+pdid+'&processType='+processType
	     });
	 }
	 
	//设计流程
	 function designProcess(pkgTid,window){
	 	var processType = document.getElementById("processType").value;
			var action ="<%=path%>/process/processTmplAction_designProcess.action?processType="+processType;
		document.getElementById("pkgTid").value=pkgTid;
		document.getElementById("processForm").action=action;
		//document.getElementById("processForm").submit();
		
		var pdid = document.getElementById("pdid").value;
		
		top.topWin = window;
		top.layer.open({
	    	type:2,
			title:false,
			area:['100%','100%'],
			closeBtn:0,
 			content:'<%=request.getContextPath()%>/process/processTmplAction_toDesignComposite.action?type=update&ptid='+pkgTid+'&pdid='+pdid+'&processType='+processType
	     });
		//var Form0 =  parent.document.getElementById("processForm");
		
		//top.openDesignWindow(Form0,this.window,layoutType);

/*	 var ptid = pkgTid;
     var pdid = document.getElementById('pdid'); 
	   var url ="<%=request.getContextPath()%>/editor/flowdesigner.jsp?pdid="+pdid+"&ptid="+ptid+"&containerType=process&containerId="+pdid+"&mode=flow&amp;fromDB=true";
		var width = screen.availWidth * 0.8;  
        var height = screen.availHeight * 0.8;  
        var left = parseInt((screen.availWidth/2) - (width/2));//屏幕居中  
        var top = parseInt((screen.availHeight/2) - (height/2)); 
        var windowFeatures = "width=" + width + ",height=" + height + ",status,resizable=no,left=" + left + ",top=" + top + "screenX=" + left + ",screenY=" + top;  
		window.open(url,'设计流程',windowFeatures);
	*/	
	 }
	
	// 删除流程模板 
	 function validateDeleteProcess(record) {
		var owner = record.owner;
			var states = record.status;
			
			if(isAdmin){
				return true;
			}
			/* 发布状态
			if(states==releasedType){
				if(tmplTIDs==""){
					tmplTIDs = ptid;
				}else{
					tmplTIDs = tmplTIDs + "," + ptid;
				}
				continue;
			}*/
			// 非发布状态，判断当前操作人员
		if(owner==null || owner.trim().length==0 || userId==owner){
			}else{
				return false;
			}
		return true;
	}

</script>
</head>
<body>
	<form id="processForm" name="processForm" method="post"
	action=""
	style="margin: 0px; height: 100%;"
	enctype="application/x-www-form-urlencoded">
	
		<input type="hidden" id="processId" name="processId" value="${param.processId}">
		<input type="hidden" id="pdid" name="pdid" value="${param.processId}">
		<input type="hidden" id="pkgTid" name="pkgTid" value="">
		<input type="hidden" id="entityId" name="entityId" value="${param.entityId}">
		<input type="hidden" id="processTmplId" name="processTmplId" value="${param.processTmplId}">
		<input type="hidden" id="parentNodeId" name="parentNodeId" value="${param.processId}">
		<input type="hidden" id="processType" name="processType" value="${param.processType}">
		<input type="hidden" id="isScene" name="isScene" value="<%=isScene %>">
		<input type="hidden" id="fromTmplList" name="fromTmplList" value="true">
		<input type="hidden" id="tempCls" name="tempCls" value="${param.tempCls }">
			<!-- 流程设计需要
	 -->
		<input id="simulationType" name="simulationType" type="hidden" value="0">
	
		<div id="TabContainer001_div" class="form-group col-md-12 formItem" style="width:100%;height:100%;overflow:auto;height: 100%">
			<ul id="TabContainer001" style="height:40px" class="nav nav-tabs disable">
				<li class="active">
					<a href="#TabPanel001" data-toggle="tab" onclick="tabPanel001Click()">流程列表</a>
				</li>
			</ul>
			<div id="content-main" class="tab-content" style="border-color: #e7eaec;-webkit-border-image: none;-o-border-image: none;border-image: none;border-style: solid;border-width: 1px;border-top: 0px;height: calc(100% - 40px)">
				<iframe scrolling="no" id="iframe001" frameborder="0" src="" style="height: 100%;width: 100%" ></iframe>
			</div>
		</div>
	</form>
</body>
</html>