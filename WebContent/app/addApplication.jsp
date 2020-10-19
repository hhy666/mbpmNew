<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>添加应用</title>
	<jsp:include page="/form/html5/admin/html5Head.jsp"/>
	<script type="text/javascript">
		window.onload = function(){
			var optType = Matrix.getFormItemValue('optType');
			if(optType == 'update'){     //修改
				document.getElementById("appId").readOnly=true;
				document.getElementById("appId").removeAttribute("required");
				document.getElementById('depSpan').remove();
			}
		}
		
		//选择组织机构编码
	    function openSelectDep(){
	   	 layer.open({
		    	id:'selectDep',
				type : 2,
				title : ['选择部门'],
				shadeClose: false, //开启遮罩关闭
				area : [ '50%', '90%' ],
				content : '<%=request.getContextPath()%>/office/html5/select/SingleSelectDep.jsp?iframewindowid=selectDep'
			});
	    }
	    //选择组织机构窗口回调
		function onselectDepClose(data){
			if(data!=null){
				Matrix.setFormItemValue('orgRootId',data.ids);
				Matrix.setFormItemValue('orgRootName',data.names);
			}
		}
	    
	    //保存应用信息
	    function saveApp(){
	    	Matrix.showMask2();
    		//表单验证
    		if (!Matrix.validateForm('form0')) {
    			Matrix.hideMask2();
    			return false;
    		}
	    	var synJson = Matrix.formToObject('form0');
	    	var url = null;
	    	var optType = Matrix.getFormItemValue('optType');
			if(optType == 'add'){     //添加
				url = "<%=request.getContextPath()%>/mapp/mapp_creatApplication.action";
			}else{   //修改
				url = "<%=request.getContextPath()%>/mapp/mapp_updateApplication.action";
			}
	    	Matrix.sendRequest(url,synJson,function(data){
				if(data != null && data.data != null){
					var json = isc.JSON.decode(data.data);
					if(json.success){
						if(optType == 'add'){     //添加
							parent.Matrix.say("添加成功");
						}else{
							parent.Matrix.say("修改成功");
						}
						parent.Matrix.refreshDataGridData('DataGrid001');
  	        			Matrix.closeWindow();
					}
				}
				Matrix.hideMask2();
	    	});
	    }
	</script>
</head>
<body>
	<form id="form0" name="form0" method="post" action="" style="margin:0px;overflow:hidden;height:100%;padding: 10px;" enctype="application/x-www-form-urlencoded">
		<input type="hidden" name="form0" value="form0" />
		<!-- Matrix平台校验 -->
		<input type="hidden" id="validateType" name="validateType" value="jquery" /> 
		<!-- 判断是添加还是修改操作 -->
		<input id="optType" type="hidden" name="optType" value="<%=request.getParameter("optType")%>"/>
		<!-- 组织机构编码 -->
		<input type="hidden" id="orgRootId" name="orgRootId" value="${appInfo.orgRootId }"> 

		<table id="table001" class="tableLayout">	
			<tr id="tr001">
				<td id="td001" class="tdLabelCls" style="width:25%;">
					<label>
						应用名称：
					</label>
				</td>
				<td id="td002" class="tdValueCls" style="width:75%;">
					<div id="input001_div" style="vertical-align: middle;">
						<input id="appName" name="appName" type="text" value="${appInfo.appName }" class="form-control" style="height:100%;width:100%;" required="required"/>
					</div>
				</td>
			</tr>
			<tr id="tr002">
				<td id="td003" class="tdLabelCls" style="width:25%;">
					<label>
						应用编码：
					</label>
				</td>
				<td id="td004" class="tdValueCls" style="width:75%;">
					<div id="input002_div" style="vertical-align: middle;">
					<input id="appId" name="appId" type="text" value="${appInfo.appId }" class="form-control" style="height:100%;width:100%;" required="required"/>
				</div>
				</td>
			</tr>
			<tr id="tr003">
				<td id="td005" class="tdLabelCls" style="width:25%">
					<label>
						组织机构：
					</label>
				</td>
				<td id="td006" class="tdValueCls" style="width:75%;">
					<div id="orgRootId_div" class="input-group" style="width:100%;">
						 <input type="text" id="orgRootName" name="orgRootName" value="${appInfo.orgRootName }" class="form-control" readonly="readonly">
	            		 <span class="input-group-addon addon-udSelect udSelect" onclick="openSelectDep();" id="depSpan"><i class="fa fa-search"></i></span>
					</div>
				</td>
			</tr>
			<tr id="tr004">
				<td id="td007" class="tdLabelCls" style="width: 25%;">
					 <label>
					 	应用描述：
					 </label>
				</td>
						
				<td id="td008" class="tdValueCls" style="width: 75%;">
					<div id="appDesc_div">				
						<textarea class="form-control" rows="3" id="appDesc" name="appDesc" style="resize: none;">${appInfo.appDesc }</textarea>
					</div>
		    	 </td>
			</tr>		
			<tr>
				<td colspan="2" class="cmdLayout">				
					<input type="button" class="x-btn ok-btn " value="保存" onclick="saveApp();">
					<input type="button" class="x-btn cancel-btn " value="关闭" onclick="Matrix.closeWindow();">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>