<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ page import="com.matrix.form.admin.common.utils.CommonUtil" %>
	<%  
		int currentPhase = CommonUtil.getCurPhase();

	%>
<!DOCTYPE HTML>
<html>
<meta http-equiv='pragma' content='no-cache'>
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='0'>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<head>
<jsp:include page="/form/html5/admin/html5Head.jsp"/>
<title>h5更新实体信息</title>
<script type="text/javascript">

	window.onload = function(){
		var phase = "<%=currentPhase%>";
	 	if(phase=="1"||phase=="4"){//需求分析&业务定制阶段
	 		MtableName.setRequired(false);
	 		
	 		document.getElementById("tableNameTr").style.display="none";
	 		document.getElementById("keyStrategyTr").style.display="none";
	 		document.getElementById("cacheTypeTr").style.display="none";
	 	
	 	}
	 	
		
		$("#state").val('${entityInfo.state}');
		$("#keyStrategy").val('${entityInfo.keyStrategy}');
		$("#cacheType").val('${entityInfo.cacheType}');
		$("#storeType").val('${entityInfo.storeType}');
		
	}
		//主键生成策略变化 序列名
		 function keyStrategyChanged(value){
		 	var sequenceName = document.getElementById('sequenceName');
		 	var seqNameTr = document.getElementById("sequenceNameTr");
		 	if(value=='sequence'){//如果为序列 序列输入框可用
		 		//tr显示
		 		seqNameTr.style.display = "table-row";
		 		sequenceName.disabled = false;
		 		sequenceName.required = true;
		 	}else{//其余类型不可用
		 	    sequenceName.value = "";
		 	    sequenceName.disabled = true;
		     	sequenceName.required = false;
		     	seqNameTr.style.display = "none";
		 	}
		 
		 }
		 
		 
	function save(){
		Matrix.showMask();
		Matrix.convertFormItemValue('Form0');
		$('#dsName').attr("disabled",false);
		$('#storeType').attr("disabled",false);
	 	//document.getElementById('Form0').submit();
	 	Matrix.send("Form0",null,callbackFun);
	 	Matrix.hideMask();
	}		 
	
	//更新回调函数
 	function callbackFun(data){
 		//返回成功时刷新树节点parentNodeId
 		$('#dsName').attr("disabled",true);
		$('#storeType').attr("disabled",true);
 		parent.parent.Matrix.forceFreshTreeNode("Tree0","${param.parentNodeId}");
 	    Matrix.success(data.data);
 	}
	</script>
</head>
<body>
	<form id="Form0" name="Form0" eventProxy="MForm0" method="post" 
	  action="<%=request.getContextPath()%>/entity/entityInfo_updateEntityInfo.action" 
	  style="margin:0px;" enctype="application/x-www-form-urlencoded">
<input type="hidden" name="Form0" value="Form0" />
		<input type="hidden" name="Form0" value="Form0" />
		<input type="hidden" name="parentNodeId" value="parentNodeId" value="${param.parentNodeId}" />
		<input id="entity" type="hidden" name="entity" value="${entityInfo.entity}" />
		<input id="mid" type="hidden" name="mid" value="${entityInfo.mid}" />
		<input id="type" type="hidden" name="type" value="${entityInfo.type}" />
		<input id="tenantId" type="hidden" name="tenantId" value="${entityInfo.tenantId}" />
		<input id="uuid" type="hidden" name="uuid"  value="${entityInfo.uuid}"/>
		<input id="createdDate" type="hidden" name="createdDate"  value="${entityInfo.createdDate}"/>
		<input id="lastModifiedDate" type="hidden" name="lastModifiedDate" value="${entityInfo.lastModifiedDate}" />
		<input id="lastModifiedUser" type="hidden" name="lastModifiedUser"  value="${entityInfo.lastModifiedUser}"/>
		<input id="createdUser" type="hidden" name="createdUser"  value="${entityInfo.createdUser}"/>
		
		<input id="phase" type="hidden" name="phase"  value="${entityInfo.phase}"/>
		
		<table class="maintain_form_content" style="width:100%;height: 85%;">
        	<tr>
        		<td class="tdLabelCls" style="width: 30%;">
        			<label id="j_id0" name="j_id0" data-i18n-text="编码：">
						编码：
					</label>
        		</td>
        		<td class="tdValueCls" style="width: 70%;">
					<input disabled="true"  class="form-control" type="text" name="definedId" id="definedId" style="WIDTH:100%;" value="${entityInfo.mid}">
				</td>
        	</tr>
        	<tr>
        		<td class="tdLabelCls" style="width: 30%;">
        			<label  data-i18n-text="名称：">
						名称：
					</label>
				</td>		        		
        		<td class="tdValueCls" style="width: 70%;">
					<input required class="form-control" type="text" name="name" id="name" style="WIDTH:100%;" value="${entityInfo.name}">
        		</td>
        	</tr>
        	<tr>
        		<td class="tdLabelCls" style="width: 30%;">
        			<label  data-i18n-text="启用状态：">
						启用状态：
					</label>
				</td>		        		
        		<td class="tdValueCls" style="width: 70%;">
					<select class="form-control " id="state" name="state" style=" width:100%;height:100%;" onchange="" autocomplete="off" aria-hidden="true">
						<option value="1">启用</option>
						<option value="0">未启用</option>
					</select>
        		</td>
        	</tr>
        	<tr>
        		<td class="tdLabelCls" style="width: 30%;">
        			<label id="j_id2" name="j_id2" data-i18n-text="路径：">
						路径：
					</label>
				</td>		        
				<td class="tdValueCls" style="width: 70%;">
					<input readonly="readonly" class="form-control" type="text" name="entityLabel" id="entityLabel" style="WIDTH:100%;" value="${entityInfo.entity}">
				</td>
        	</tr>
        	<tr id="tableNameTr">
        		<td class="tdLabelCls" style="width: 30%;">
        			<label id="j_id2" name="j_id2" data-i18n-text="表名：">
						表名：
					</label>
				</td>		        
				<td class="tdValueCls" style="width: 70%;">
					<input class="form-control" type="text" name="tableName" id="tableName" style="WIDTH:100%;" value="${entityInfo.tableName}">
				</td>
        	</tr>
        	<tr id="keyStrategyTr">
        		<td class="tdLabelCls" style="width: 30%;">
        			<label  data-i18n-text="主键生成策略：">
						主键生成策略：
					</label>
				</td>		        		
        		<td class="tdValueCls" style="width: 70%;">
					<select class="form-control " id="keyStrategy" name="keyStrategy" style=" width:100%;height:100%;" onchange="keyStrategyChanged(value)" autocomplete="off" aria-hidden="true">
						<option value="assigned">assigned</option>
						<option value="uuid.hex">uuid.hex</option>
						<option value="increment">increment</option>
						<option value="sequence">sequence</option>
					</select>
        		</td>
        	</tr>
        	<tr id="sequenceNameTr">
        		<td class="tdLabelCls" style="width: 30%;">
        			<label  data-i18n-text="序列名：">
						序列名：
					</label>
				</td>		        		
        		<td class="tdValueCls" style="width: 70%;">
					<input class="form-control" type="text" name="sequenceName" id="sequenceName" style="WIDTH:100%;" value="${entityInfo.sequenceName}">
        		</td>
        	</tr>
        	<tr id="cacheTypeTr"> 
        		<td class="tdLabelCls" style="width: 30%;">
        			<label  data-i18n-text=" 缓存类型：">
						 缓存类型：
					</label>
				</td>		        		
        		<td class="tdValueCls" style="width: 70%;">
					<select class="form-control " id="cacheType" name="cacheType" style=" width:100%;height:100%;" onchange="" autocomplete="off" aria-hidden="true">
						<option value="none">无</option>
						<option value="read-only">只读型</option>
						<option value="read-write">读写型</option>
						<option value="nonstrict-read-only">非严格读写型</option>
					</select>
        		</td>
        	</tr>
        	<tr>
        		<td class="tdLabelCls" style="width: 30%;">
        			<label  data-i18n-text="存储类型：">
						 存储类型：
					</label>
				</td>		        		
        		<td class="tdValueCls" style="width: 70%;">
					<select disabled="disabled" class="form-control " id="storeType" name="storeType" style=" width:100%;height:100%;" onchange="" autocomplete="off" aria-hidden="true">
						<option value="">服务器</option>
						<option value="1">服务器</option>
						<option value="2">本地</option>
					</select>
        		</td>
        	</tr>
        	<script>
		    	var displayVal = ('${entityInfo.keyStrategy}'=='sequence')?"table-row":"none";
		 		document.getElementById("sequenceNameTr").style.display = displayVal;
			 </script>
        	<tr>
        		<td class="tdLabelCls" style="width: 30%;">
        			<label  data-i18n-text="数据源名称：">
						 数据源名称：
					</label>
				</td>		        		
        		<td class="tdValueCls" style="width: 70%;">
					<select disabled="disabled" class="form-control " id="dsName" name="dsName" style=" width:100%;height:100%;" onchange="" autocomplete="off" aria-hidden="true">
						<option value="workflowDS">workflowDS</option>
					</select>
        		</td>
        	</tr>
        	<tr>
        		<td class="tdLabelCls" style="width: 30%;">
        			<label id="j_id3" name="j_id3" data-i18n-text="描述：">
						描述：
					</label>
				</td>		        
				<td class="tdValueCls" style="width: 70%;">
					<textarea class="form-control" name="desc" id="desc" style="width: 100%;height:120px;resize:none">${entityInfo.desc}</textarea>
				</td>
        	</tr>
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