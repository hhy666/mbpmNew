<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
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
<head>
<jsp:include page="/form/html5/admin/html5Head.jsp"/>
<title>h5修改表单基本信息</title>
<script type="text/javascript">

	function save(){
		Matrix.showMask();
		Matrix.send("Form0",null,callbackFun);
		Matrix.hideMask();
	}
	
	function callbackFun(result){
		var curPhase = '${param.phase}';
		var msg = result.data;
		if(msg!=null&&msg=="1"){
			if(!curPhase=='4'){
				Matrix.warn("名称重复!");
			}
		}else if(msg!=null&&msg=="2"){
		//更新成功后刷新子节点
			if(curPhase!=null && curPhase!='null' && curPhase!='undefined' && curPhase!='' && curPhase=='4'){
				parent.Matrix.forceFreshTreeNode("Tree0","${param.parentNodeId}");
				parent.$('#container').jstree("refresh_node","${param.parentNodeId}");
				//parent.Matrix.success("表单更新成功!");
			}else{
				parent.parent.$('#container').jstree("refresh_node","${param.parentNodeId}");
				parent.parent.Matrix.forceFreshTreeNode("Tree0","${param.parentNodeId}");
				parent.parent.$('#container').jstree("deselect_node","${catalogNode.uuid}");
				//parent.Matrix.success("表单更新成功!");
			}
		}
	}

</script>
</head>
<body>
	<form id="Form0" name="Form0"  method="post"  action="<%=request.getContextPath()%>/catalog_updateForm.action"
	style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
		<input id="comType" type="hidden" name="comType" value="${catalogNode.comType}" />
		
		<input id="mid" type="hidden" name="mid" value="${catalogNode.mid}" />
	    <input id="tenantId" type="hidden" name="tenantId" value="${catalogNode.tenantId}" />
	    <input id="phase" type="hidden" name="phase" value="${catalogNode.phase}" />
		<input id="isPublic" type="hidden" name="isPublic" value="${catalogNode.isPublic}"/>
		<input id="createdUser" type="hidden" name="createdUser" value="${catalogNode.createdUser}"/>
		<input id="uuid" type="hidden" name="uuid" value="${catalogNode.uuid}" />
		
		<input id="parentUuid" type="hidden" name="parentUuid" value="${catalogNode.parentUuid}" />
		<input id="type" type="hidden" name="type" value="${catalogNode.type}" />
		<input id="index" type="hidden" name="index" value="${catalogNode.index}" />
		<input id="createdDate" type="hidden" name="createdDate" value="${catalogNode.createdDate}" />
		<!-- 在更新过程中传递节点信息 -->
		<input id="parentId" type="hidden" name="parentId" value="${param.entityId}" />
		<input id="parentNodeId" type="hidden" name="parentNodeId" value="${param.parentNodeId}"/>
		<table class="maintain_form_content" style="width:100%;height: 85%;">
        	<tr>
        		<td class="tdLabelCls" style="width: 30%;">
        			<label id="j_id0" name="j_id0" data-i18n-text="编&nbsp;&nbsp;码">
						编&nbsp;&nbsp;码：
					</label>
        		</td>
        		<td class="tdValueCls" style="width: 70%;">
					<input disabled="disabled"  class="form-control" type="text" name="definedId" id="definedId" style="WIDTH:100%;" value="${catalogNode.mid}">
				</td>
        	</tr>
        	<tr>
        		<td class="tdLabelCls" style="width: 30%;">
        			<label id="j_id1" name="j_id1" data-i18n-text="名&nbsp;&nbsp;称">
						名&nbsp;&nbsp;称：
					</label>
				</td>		        		
        		<td class="tdValueCls" style="width: 70%;">
					<input required class="form-control" type="text" name="name" id="name" style="WIDTH:100%;" value="${catalogNode.name}">
        		</td>
        	</tr>
        	<tr>
        		<td class="tdLabelCls" style="width: 30%;">
        			<label id="j_id2" name="j_id2" data-i18n-text="路&nbsp;&nbsp;径">
						路&nbsp;&nbsp;径：
					</label>
				</td>		        
				<td class="tdValueCls" style="width: 70%;">
					<input readonly="readonly" class="form-control" type="text" name="entityLabel" id="entityLabel" style="WIDTH:100%;" value="${requestScope.entity}">
				</td>
        	</tr>
        	<tr>
        		<td class="tdLabelCls" style="width: 30%;">
        			<label id="j_id3" name="j_id3" data-i18n-text="描&nbsp;&nbsp;述">
						描&nbsp;&nbsp;述：
					</label>
				</td>		        
				<td class="tdValueCls" style="width: 70%;">
					<textarea class="form-control" name="desc" id="desc" style="width: 100%;height:120px;resize:none">${catalogNode.desc}</textarea>
				</td>
        	</tr>
        	<%-- <tr style="display: none">
        		<td class="tdLabelCls" style="width: 30%;">
        			<label id="j_id21" name="j_id21" data-i18n-text="类&nbsp;&nbsp;型">
						类&nbsp;&nbsp;型：
					</label>
				</td>		        
				<td class="tdValueCls" style="width: 70%;">
					<input readonly="readonly" class="form-control" type="text" name="comType2" id="comType2" style="WIDTH:100%;" value="${requestScope.entity}">
				</td>
        	</tr> --%>
        	<tr>
        		<td style="text-align: center;vertical-align: top;padding-top: 20px;" colspan="4">
					<div id="button003_div" class="matrixInline">
						<input data-i18n-value="保存" type="button" class="x-btn ok-btn " value="保存" onclick="save()">
					</div>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>