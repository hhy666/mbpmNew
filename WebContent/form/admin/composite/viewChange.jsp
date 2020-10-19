<%@page pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML>
<html>
<meta http-equiv='pragma' content='no-cache'>
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='0'>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<jsp:include page="/form/html5/admin/html5Head.jsp"/>
<title>Insert title here</title>
<script type="text/javascript">
	$(document).ready(function(){
		window.location.href = "<%=path%>/dist/index.html#/?formUuid=${param.formUuid}&designType=${param.designType}&isMobile=${param.isMobile}&isExtendField=${param.isExtensibleField}";
	});
</script>
</head>
<body>

</body>
</html>