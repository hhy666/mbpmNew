<%@page pageEncoding="utf-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML>
<html>
<meta http-equiv='pragma' content='no-cache'>
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='0'>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<head>
<jsp:include page="/form/html5/admin/html5Head.jsp"/>
<script type="text/javascript">

		window.onload = function(){
			debugger;
			var type = "${param.type}";
			var cln = parent.topForm.cloneNode(true);
			document.body.appendChild(cln);
			if(type=='add'){
				cln.action='<%=request.getContextPath()%>/form/formInfo_addFormVersion.action?layoutType=${param.layoutType}';
			}else if(type=="copy"){
				cln.action='<%=request.getContextPath()%>/form/formInfo_copyFormVersion.action?layoutType=${param.layoutType}';
			}
			document.getElementById('Form0').submit();
		}

</script>
</head>
<body>
	<%-- <form id="form0" name="form0" method="post" action="<%=request.getContextPath()%>/form/formInfo_addFormVersion.action"  enctype="application/x-www-form-urlencoded"> 
		<input type="hidden" id="mid" name="mid">
		<input type="hidden" id="name" name="name">
		<input type="hidden" id="desc" name="desc">
		<input type="hidden" id="nodeUuid" name="nodeUuid">
		<input type="hidden" id="parentNodeId" name="parentNodeId">
		<input type="hidden" id="layoutType" name="layoutType">
		<input type="hidden" id="currentUser" name="currentUser">
		<input type="hidden" id="version" name="version">
		<input type="hidden" id="type" name="type">
		<input type="hidden" id="formUuid" name="formUuid">
	</form> --%>
</body>
</html>