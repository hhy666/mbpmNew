<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.matrix.form.api.MFormContext"%>
<%@ page import="commonj.sdo.DataObject"%>
<%@ page import="com.matrix.commonservice.data.DataService" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transi
	var isomorphicDir = "/moffice/matrix/
resource/isomorphic/";</SCRIPT>
<SCRIPT SRC="/moffice/matrix/resource/isomorphic/system/modules/ISC_Core10.10.js"></SCRIPT>
<SCRIPT SRC="/moffice/matrix/resource/isomorphic/system/modules/ISC_Foundation10.10.js"></SCRIPT>
<SCRIPT SRC="/moffice/matrix/resource/isomorphic/system/modules/ISC_Containers10.10.js"></SCRIPT>
<SCRIPT SRC="/moffice/matrix/resource/isomorphic/system/modules/ISC_Grids10.10.js"></SCRIPT>
<SCRIPT SRC="/moffice/matrix/resource/isomorphic/system/modules/ISC_Forms10.10.js"></SCRIPT>
<SCRIPT SRC="/moffice/matrix/resource/isomorphic/system/modules/ISC_DataBinding10.10.js"></SCRIPT>
<SCRIPT SRC="/moffice/matrix/resource/isomorphic/system/modules/ISC_RichTextEditor10.10.js"></SCRIPT>
<SCRIPT SRC="/moffice/matrix/resource/matrixSmartClient10.10.js"></SCRIPT>
<SCRIPT SRC="/moffice/matrix/resource/matrix10.10.js"></SCRIPT>
<SCRIPT SRC="/moffice/matrix/resource/date10.10.js"></SCRIPT>
<SCRIPT SRC="/moffice/matrix/resource/common_property10.10.js"></SCRIPT>
<SCRIPT SRC="/moffice/matrix/resource/formcatalog10.10.js"></SCRIPT>
<SCRIPT SRC="/moffice/matrix/resource/isomorphic/skins/Enterprise/load_skin10.10.js"></SCRIPT>
<link rel="stylesheet" href="/moffice/matrix/resource/isomorphic/skins/Enterprise/matrix_runtime10.10.css" type="text/css"/>
<SCRIPT SRC="/moffice/matrix/resource/isomorphic/locales/frameworkMessages_zh_CN10.10.properties"></SCRIPT>
<SCRIPT SRC="/moffice/matrix/resource/isomorphic/locales/matrixMessages_zh_CN10.10.properties"></SCRIPT>
<html>
	<head>
		<base href="<%=basePath%>">

	</head>

	<body>
	<table id="table001" style="width: 100%; height: 100%;">
<% 
StringBuffer hql = new StringBuffer("from office.document.support.AuthorGroupRelationBO"); 
	hql.append(" where adid='6666'"); 
	DataService dataService = MFormContext.getService("DataService"); 
	DataObject obj = (DataObject)dataService.queryObject(hql.toString(),null) ;
	if(obj!=null){
StringBuffer hql2 = new StringBuffer("from office.document.support.ProcessAuthorizationGroup where uuid='"+obj.getString("authorGroupId")+"'");
	DataObject obj2 = (DataObject)dataService.queryObject(hql2.toString(),null) ;
	//是否填写意见 
	int isOpinion = obj2.getInt("opinion"); 
	//基本操作编码 
	String baseCode = obj2.getString("baseCode"); 
	//高级操作编码 
	String advCode = obj2.getString("advCode"); 
	if(baseCode!=""&&advCode!=""){
	String[] p = baseCode.split(",");
	int m = p.length/3;
	int n = m+1;
	for(int i = 0 ; i < n ; i++){
	
	%>
		<tr id="right_tr00<%=i %>">
		<%
	   for(int j=0;j<p.length;j++){

	%>
	

	
				<td id="right_td00<%=j %>" style="width: 33%;">&nbsp;
					<div id="right_button00<%=j %>_div" class="matrixInline"
						style="width: 65px;; position: relative;; height: 22px;">
					
						<script>
	isc.Button.create( {
		ID : "Mbutton00<%=j%>",
		name : "button00<%=j%>",
		title : <%=j%>,
		displayId : "right_button00<%=j %>_div",
		position : "absolute",
		top : 0,
		left : 0,
		width : "100%",
		height : "100%",
		icon : "[skin]/images/matrix/actions/save.png",
		showDisabledIcon : false,
		showDownIcon : false,
		showRollOverIcon : false
	});

</script>
					</div>
				</td>
			

 <%} 
 %>
 	</tr>
 <%}
 }
 }%>
	
	
			
				</table>
	</body>
</html>
