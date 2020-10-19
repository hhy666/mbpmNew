<%@page pageEncoding="utf-8"%>
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
<script>

	//判断结尾
	function endWith(str, target) {
		var start = str.length-target.length;
		var arr = str.substr(start,target.length);
		if(arr == target){
			return true;
		}
		return false;
	}

	function save(){
		var cols = document.getElementById('cols').value;
		var rows = document.getElementById('rows').value;
		var height = document.getElementById('height').value;
		
		if(cols!='1'&&cols!='2'){
			Matrix.warn("列数必须为1或者2!");
			return false;
		}
		
		if(rows<=0){
			Matrix.warn("行数必须大于0!");
			return false;
		}
		
		document.getElementById('form0').action=
			"<%=path%>/portal/partsAction_editSelectParts.action?type=${param.type}";
		Matrix.send('form0',{'button003':'保存'},function(data){
			newData = isc.JSON.decode(data.data);
			if(newData[0].result==true){
				Matrix.closeWindow(data);
			}else{
				Matrix.warn('行数和列数必须为整数！');
			}
		});
	}
</script>
</head>
<body>
	<div style="width:100%;height:100%;overflow:auto;position:relative;">
		<form id="form0" name="form0" method="post" action="" style="margin: 0px; position: relative; overflow: hidden; width: 100%; height: 100%;padding: 10px" enctype="application/x-www-form-urlencoded"> 
		   	<input type="hidden" name="form0" value="form0" /> 
		   	<input type="hidden" name="partId" id="partId" value="${param.partId }" />
		   	<input type="hidden" name="portalId" id="portalId" value="${param.portalId }" />
   	        <div id="TabContainer001_div" class="matrixComponentDiv" style="width:100%;height:100%;position:relative;">
		   		<table class="maintain_form_content" style="width:100%;height:100%;">
		   			<tr>
						<td class="tdLabelCls" style="width: 30%;">
							<label data-i18n-text="标题" id="j_id0" name="j_id0">
							 	标题
							</label>
						</td>
						<td class="tdValueCls" style="width:70%;">
							<div id="title_div" eventProxy="Mform0" class="matrixInline" style="width:100%">
								<input class="form-control" type="text" name="title" id="title" style="width:100%;" disabled="disabled" value="${title}" >
							</div>
						</td>
					</tr>
					<tr style="display:none">
						<td class="tdLabelCls" style="width: 30%;">
							<label data-i18n-text="宽度" id="j_id3" name="j_id3">
								宽度
							</label>
						</td>
						<td class="tdValueCls" style="width:70%;">
							<div id="width_div" eventProxy="Mform0" class="matrixInline" style="width:100%">
								<input class="form-control" type="text" name="width" id="width" style="width:100%;" value="${width}">
							</div>
						</td>
					</tr>
					<tr>
						<td class="tdLabelCls" style="width: 30%;">
							<label data-i18n-text="高度" id="j_id4" name="j_id4">
								高度
							</label>
						</td>
						<td class="tdValueCls" style="width:70%;">
							<div id="height_div" eventProxy="Mform0" class="matrixInline" style="width:100%">
								<input class="form-control" type="number" name="height" id="height" style="width:100%;" value="${height}">
							</div>
						</td>
					</tr>
					<tr>
						<td class="tdLabelCls" style="width: 30%;">
							<label data-i18n-text="行数" id="j_id5" name="j_id5">
								行数
							</label>
						</td>
						<td class="tdValueCls" style="width:70%;">
							<div id="rows_div" eventProxy="Mform0" class="matrixInline" style="width:100%">
								<input class="form-control" type="number" name="rows" id="rows" style="width:100%;" value="${rows}">
							</div>
						</td>
					</tr>
					<tr>
						<td class="tdLabelCls" style="width: 30%;">
							<label data-i18n-text="列数" id="j_id6" name="j_id6">
								列数
							</label>
						</td>
						<td class="tdValueCls" style="width:70%;">
							<div id="cols_div" class="matrixInline" style="width:100%">
								<input class="form-control" type="number" name="cols" id="cols" style="width:100%;" value="${cols}">
							</div>
						</td>
					</tr>
					<tr>
						<td class="cmdLayout" colspan="2">
							<div id="button003_div" class="matrixInline" >
								<input data-i18n-value="保存" type="button" class="x-btn ok-btn " value="保存"  onclick="save()">
							</div>
							<div id="button004_div" class="matrixInline" >
								<input data-i18n-value="取消" type="button" class="x-btn cancel-btn " value="取消"  onclick="Matrix.closeWindow()">
							</div>
						</td>
					</tr>
		   		</table>
		   	</div>
		</form>
	<!-- 国际化开始 -->
    <SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/js/jquery.i18n.properties.js'></SCRIPT>
    <SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/lang/matrix_lang.js'></SCRIPT>
    <!-- 国际化结束 -->
	</div>
</body>
</html>