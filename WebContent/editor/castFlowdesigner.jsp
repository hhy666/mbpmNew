<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript">

//用来添加和复制流程
	window.onload = function(){
		var type = "${param.type}";
		var action = "";
		if(type=="add"){
			action = "<%=path%>/process/processTmplAction_createProcessTmpl.action";
		}else if(type=="copy"){
			action = "<%=path%>/process/processTmplAction_copyProcessTmpl.action";
		}
		document.getElementById("processForm").action=action;
		document.getElementById("processForm").submit();
	}

</script>
<body>
	<form id="processForm" name="processForm">
		<input type="hidden" id="tempCls" name="tempCls" value="${param.tempCls}">
		<input type="hidden" id="processId" name="processId" value="${param.processId}">
		<input type="hidden" id="processType" name="processType" value="${param.processType}">
		<input type="hidden" id="pdid" name="pdid" value="${param.pdid}">
		<input type="hidden" id="pkgTid" name="pkgTid" value="${param.pkgTid}">
	</form>
</body>
</html>