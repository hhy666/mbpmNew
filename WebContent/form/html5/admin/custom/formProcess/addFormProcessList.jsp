<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset='utf-8' />
<%@ include file="/form/html5/admin/html5Head.jsp"%>
<link href='<%=request.getContextPath() %>/resource/html5/css/switchery.min.css' rel="stylesheet"></link>
<script src='<%=request.getContextPath() %>/resource/html5/js/switchery.min.js'></script>
<style type="text/css">
	.colorChoose{
		cursor:pointer;
		margin-right:10px;
		display:inline-flex;
		border-radius:50%;
		width:24px;
		height:24px;
	}
	
	.colorChoose:hover{
		width:28px;
		height:28px;
	}
</style>
<script type="text/javascript">
	$(function(){
		colorInit();
		//颜色选择
		$('.colorChoose').click(function(){
			$('.colorChoose').css('border','0px');
			$(this).css('border','2px solid black');
			var background = $(this).css('background-color');
			$('#color').val(background);
		});
		
		var templateType = $('#templateType').val();   //4表单定制 5流程定制
		if(templateType == '4'){
			document.getElementById('associatedForm').style.display = '';
			document.getElementById('versionPolicy').style.display = '';
			document.getElementById('extensibleField').style.display = '';
		}else if(templateType == '5'){
			document.getElementById('associatedProcess').style.display = '';
			//document.getElementById('authorizeForm').style.display = '';
		}
		
		var elem = document.querySelector('.js-switch');
		var init = new Switchery(elem,{size:"small",color:"rgb(91, 155, 213)"});
		elem.onchange = function() {
		   debugger;
		   if(elem.checked){
			   document.getElementById('isExtensibleField').value="2";
		   }else{
			   document.getElementById('isExtensibleField').value="1";
		   }
		};
	})
	
	//颜色初始化
	function colorInit(){
		var color = $('#color').val();
		if(color==null||color==""){
			$('.colorChoose').css('border','0px');
			$('.colorChoose.type2').css('border','2px solid black');
			$('#color').val('rgb(91,155,213)');
		}
	}
	
	function checkName(){
		var addType = '${param.addType }';  //add添加
		var operation = '${operation }';	//update编辑
		
		$('#namefont').html("");
	
		if($('#name').val() == null || $('#name').val() == ''){
			$('#namefont').html("请输入名称");
		}else{
			var name = $('#name').val();
			var parentId = $('#parentId').val();
			var url="<%=request.getContextPath()%>/formProcess/formProcess_addFormProcessBefore.action";	
			
			var jsonData = {};
			jsonData.name = name;		
			jsonData.parentId = parentId;			
			if(operation == 'update'){  //编辑
				var uuid = $('#uuid').val();
				jsonData.uuid = uuid;
			}
			Matrix.sendRequest(url,jsonData,function(data){
				var callbackStr = data.data;
			    var callbackJson = isc.JSON.decode(callbackStr);
				
			    var nameMessage = callbackJson.nameMessage;
				$('#namefont').html(nameMessage);
			});
		}
	}
	
	//弹出关联表单窗口
	function openAssociatedForm(){
		parent.iframeJs = this;
		parent.layer.open({
	    	id:'associatedForm',
			type : 2,			
			title : ['选择表单'],
			shade: [0.1, '#000'],
			shadeClose: false, //开启遮罩关闭
			area : [ '30%', '50%' ],
			content : '<%=path %>/editor/common/selectFormTree.jsp?iframewindowid=associatedForm'
		});
	}
	
	//选择关联表单窗口回调 
	function onassociatedFormClose(record){
		if(record!=null && record!=""){
			var name = record.name;   //表单名称
			var id = record.id;   //表单编码
			var layoutType = record.layoutType;   //布局类型
			$('#associatedFormName').val(name);
			$('#associatedFormId').val(id);
			$('#layoutType').val(layoutType);
			
			if(layoutType == '1'){		//表格布局只支持 复制老版本	
				$("#newVersionPolicy").val(1);
				$("#newVersionPolicy").attr('disabled', true);
			}else{
				$("#newVersionPolicy").attr('disabled', false);
			}
		}
	}
	
	//清除已选择的关联表单
	function clearAssociatedForm(){
		$('#associatedFormName').val('');
		$('#associatedFormId').val('');
		$('#layoutType').val('');
	}
	
	
	//弹出关联流程窗口
	function openAssociatedProcess(){
		parent.iframeJs = this;
		parent.layer.open({
	    	id:'associatedProcess',
			type : 2,
			title : ['选择流程'],
			shade: [0.1, '#000'],
			shadeClose: false, //开启遮罩关闭
			area : [ '30%', '50%' ],
			content : '<%=path %>/editor/common/selectProcessTree.jsp?iframewindowid=associatedProcess',
		});
	}
	
	//选择关联流程窗口回调 
	function onassociatedProcessClose(record){
		if(record!=null && record!=""){
			var name = record.name; // 流程名称
			var id = record.pdid; // 流程编码
			$('#associatedProcessName').val(name);
			$('#associatedProcessId').val(id);
		}
	}
	
	//清除已选择的关联流程
	function clearAssociatedProcess(){
		$('#associatedProcessName').val('');
		$('#associatedProcessId').val('');
	}
	
	
	//弹出授权表单窗口
	function openAuthorizeForm(){
		parent.iframeJs = this;
		parent.layer.open({
	    	id:'authorizeForm',
			type : 2,			
			title : ['选择表单'],
			shade: [0.1, '#000'],
			shadeClose: false, //开启遮罩关闭
			area : [ '30%', '50%' ],
			content : '<%=path %>/editor/common/selectFormTree.jsp?iframewindowid=authorizeForm'
		});
	}
	
	//选择授权表单窗口回调 
	function onauthorizeFormClose(record){
		if(record!=null && record!=""){
			var name = record.name;   //表单名称
			var id = record.id;   //表单编码
			$('#authorizeFormName').val(name);
			$('#authorizeFormId').val(id);
		}
	}
	
	//清除已选择的授权表单
	function clearAuthorizeForm(){
		$('#authorizeFormName').val('');
		$('#authorizeFormId').val('');
	}
	
	//弹出授权设置窗口
	function openAuthSet(){
		parent.authUser.areaIds = document.getElementById("authId").value;      //编码
		parent.authUser.areaName = document.getElementById("authName").value;  //名称
		parent.iframeJs = this;
	  	parent.layer.open({
		   id:'authSet',
		   type : 2,			
		   title : ['授权设置'],
		   shade: [0.1, '#000'],
		   shadeClose: false, //开启遮罩关闭
		   area : [ '45%', '60%' ],
		   content : '<%=path %>/office/html5/select/MixSelect.jsp?iframewindowid=authSet'
	   });
	}
	
	//授权设置窗口回调
	function onauthSetClose(record){
		if(record!=null && record!=""){		
			var allNames = record.allNames;
			var allIds = record.allIds;
			
			$('#authName').val(allNames);
			$('#authId').val(allIds);
		}
	}
</script>
</head>
<body>
	<div style="width: 100%; height: 100%; overflow: auto; position: relative; margin: 0 auto; zoom: 1; padding: 10px 10px;" id="context">
		<form id="form0" name="form0" eventProxy="Mform0" method="post" action="" style="margin: 0px; position: relative; overflow: hidden; width: 100%; height: 100%;" enctype="application/x-www-form-urlencoded">
			<input type="hidden" name="form0" value="form0" />
			<input type="hidden" id="color" name="color" value="${color}">
			<input type="hidden" id="templateType" name="templateType" value='${param.type}' /> 
			<input type="hidden" id="uuid" name="uuid" value="${uuid }"> 
			<input type="hidden" id="parentId" name="parentId" value="${param.parentId }" />
			
			<input type="hidden" id="associatedFormId" name="associatedFormId" value="${associatedFormId }"/>
			<input type="hidden" id="associatedProcessId" name="associatedProcessId" value="${associatedProcessId }"/>
			<input type="hidden" id="layoutType" name="layoutType" value="${layoutType }"/>
			
			<input type="hidden" id="authId" name="authId" value="${authId }"/>
			<!--  
			<input type="hidden" id="authorizeFormId" name="authorizeFormId" value="${authorizeFormId }"/>
			-->
			
			<!-- 记录可扩展开关状态 -->
			<input type="hidden" id="isExtensibleField" name="isExtensibleField" value="${isExtensibleField }"/>
			
			
			<div style="height:calc(100% - 54px);width: 100%;overflow: auto;">
				<table id="table001" class="tableLayout" style="width: 100%;">
					<tr>
						<td class="tdLayout" style="width: 40%; text-align: center; vertical-align: middle; background-color: rgb(248, 248, 248)">
							<label class="control-label ">名称：</label>
						</td>
						<td class="tdLayout" style="width: 100%;">
							<div class="input-group col-md-12 " style="display: inline-table; vertical-align: middle; width: 100%;">
								<input id="name" name="name" type="text" value="${templateName }"
									class="form-control "
									style="width: 100%; height: 100%; padding-left: 5px;"
									autocomplete="off" onblur="checkName();">
							</div><font id="namefont" color="red"></font>
						</td>
					</tr>
					<tr id="associatedForm" style="display:none;">
						<td class="tdLayout" style="width: 40%; text-align: center; vertical-align: middle; background-color: rgb(248, 248, 248)">
							<label class="control-label ">关联表单：</label>
						</td>
						<td class="tdLayout" style="width: 60%;">
							<div class="input-group" style="width: 100%;">
								 <input type="text" id="associatedFormName" name="associatedFormName" value="${associatedFormName }"  placeholder="请选择表单" class="form-control" readonly="readonly" >
			            		 <span class="input-group-addon addon-udSelect udSelect" onclick="openAssociatedForm();" style="border-left: 0px;border-radius: 0px;display: ${operation == 'update'?'none':''}"><i class="fa fa-search"></i></span>
			            		 <span class="input-group-addon addon-udSelect udSelect" onclick="clearAssociatedForm();" style="border-radius: 0px;display: ${operation == 'update'?'none':''}"><i class="fa fa-times"></i></span>
							</div><font id="formfont" color="red"></font>			
						</td>
					</tr>
					<tr id="versionPolicy" style="display: none;">
						<td class="tdLayout" style="width: 40%; text-align: center; vertical-align: middle; background-color: rgb(248, 248, 248)">
							<label class="control-label ">新版本策略：</label>
						</td>
						<td class="tdLayout" style="width: 100%;">
							<div style="vertical-align: middle;">
								<select id="newVersionPolicy" name="newVersionPolicy" class="form-control" style="height:100%;width:100%;" ${operation == 'update'?'disabled':''}>
									 <option value="2" ${newVersionPolicy == '2' ? "selected" : ""}>继承表单</option>	
									 <option value="1" ${newVersionPolicy == '1' ? "selected" : ""}>复制表单</option>			                         	                      
			                    </select>
							</div>
						</td>
					</tr>
					<tr id="extensibleField" style="display: none;">
	  					<td class="tdLayout" style="width: 40%; text-align: center; vertical-align: middle; background-color: rgb(248, 248, 248)">
	  						<label class="control-label ">数据可扩展：</label>			
						</td>
						<td class="tdLayout" style="width: 100%;">
							<div class="input-group" style="width: 100%;padding-left: 7px;">
								<input type="checkbox" class="js-switch" ${isExtensibleField!='1'?'checked':''} ${operation == 'update'?'disabled':''}/>
							</div>
						</td>
	  				</tr>
					<tr id="associatedProcess" style="display:none;">
						<td class="tdLayout" style="width: 40%; text-align: center; vertical-align: middle; background-color: rgb(248, 248, 248)">
							<label class="control-label ">关联流程：</label>
						</td>
						<td class="tdLayout" style="width: 60%;">
							<div class="input-group" style="width: 100%;">
								 <input type="text" id="associatedProcessName" name="associatedProcessName" value="${associatedProcessName }"  placeholder="请选择流程" class="form-control" readonly="readonly" >
			            		 <span class="input-group-addon addon-udSelect udSelect" onclick="openAssociatedProcess();" style="border-left: 0px;border-radius: 0px;display: ${operation == 'update'?'none':''}"><i class="fa fa-search"></i></span>
			            		 <span class="input-group-addon addon-udSelect udSelect" onclick="clearAssociatedProcess();" style="border-radius: 0px;display: ${operation == 'update'?'none':''}"><i class="fa fa-times"></i></span>
							</div><font id="processfont" color="red"></font>				
						</td>
					</tr>
					<!-- 
					<tr id="authorizeForm" style="display:none;">
						<td class="tdLayout" style="width: 40%; text-align: center; vertical-align: middle; background-color: rgb(248, 248, 248)">
							<labelclass="control-label ">授权表单：</label>
						</td>
						<td class="tdLayout" style="width: 60%;">
							<div class="input-group">
								 <input type="text" id="authorizeFormName" name="authorizeFormName" value="${authorizeFormName }"  placeholder="请选择表单" class="form-control" readonly="readonly" >
			            		 <span class="input-group-addon addon-udSelect udSelect" onclick="openAuthorizeForm();" style="border-left: 0px;border-radius: 0px"><i class="fa fa-search"></i></span>
			            		 <span class="input-group-addon addon-udSelect udSelect" onclick="clearAuthorizeForm();" style="border-radius: 0px"><i class="fa fa-times"></i></span>
							</div>
						</td>
					</tr>
					 -->
					 <tr>
						<td class="tdLayout" style="width: 40%; text-align: center; vertical-align: middle; background-color: rgb(248, 248, 248)">
							<label class="control-label ">授权范围:</label>
						</td>
						<td class="tdLayout" style="width: 60%;vertical-align: bottom;position: relative;">
							<div id="authName_div" class="input-group" style="width: 100%;">
								<textarea id="authName" name="authName" class="form-control" rows="3"  style="resize: none;" readonly="readonly">${authName }</textarea>
								<span class="input-group-addon addon-udSelect udSelect" onclick="openAuthSet()"><i class="fa fa-search"></i></span>
							</div>
						</td>
	  				</tr>
					<tr>
						<td class="tdLayout" style="width: 40%; text-align: center; vertical-align: middle; background-color: rgb(248, 248, 248)">
							<label class="control-label ">颜色：</label>
						</td>
						<td class="tdLayout" style="padding-left:10px;width: 60%;vertical-align: bottom;position: relative;">
							<div class="colorChoose type2" style="border:2px solid black;background:rgb(91,155,213)"></div>
							<div class="colorChoose" style="background:rgb(249,109,100)"></div>
							<div class="colorChoose" style="background:rgb(13,179,166)"></div>
							<div class="colorChoose" style="background:rgb(245,197,71)"></div>
							<div class="colorChoose" style="background:rgb(172,146,236)"></div>
							<div class="colorChoose type3" style="background:rgb(130,188,255)"></div>
						</td>
	  				</tr>
					<tr>
						<td class="tdLayout" style="width: 40%; text-align: center; vertical-align: middle; background-color: rgb(248, 248, 248)">
							<label class="control-label ">备注：</label>
						</td>
						<td class="tdLayout" style="height:108px;width: 60%;">
							<div id="inputTextArea001_div" class="col-md-12 input-group " style="height: 100%;width: 100%;">
								<textarea id="desc" name="desc" class="form-control "
									style="width: 100%; height: 100%;resize: none;">${templateDesc }</textarea>
							</div>
						</td>
					</tr>
				</table>
			</div>
			
			<div class="cmdLayout">
				<button type="button" id="button001" class="x-btn ok-btn ">保存</button>
				<button type="button" id="button002" class="x-btn cancel-btn ">取消</button>

				<script>
				$('#button001').click(function(){
					//设置确定按钮不可用  防止重复提交
					$('#button001').attr("disabled",true);
					
					var addType = '${param.addType }';
					var operation = '${operation}';
					var name = $('#name').val();  //名称
					var parentId = $('#parentId').val();  //父编码  即目录主键编码
					
					if(name.length<0 || name.length>40){
						Matrix.warn('名称长度不符合标准！');
						$('#button001').attr("disabled",false);
						return;
					}
					
					$('#namefont').html("");
					
					var flag1 = false;
					var flag2 = false;
					var flag3 = false;
					
					if(name == null || name == ''){
						$('#namefont').html("请输入名称");
					}else{
						$('#namefont').html("");
						flag1 = true;
					}
					
					var templateType = $('#templateType').val();   //4表单定制 5流程定制
					if(templateType == '4'){
						var associatedFormName = $('#associatedFormName').val();  //关联表单					
						if(associatedFormName == null || associatedFormName == ''){
							$('#formfont').html("请选择关联表单");
						}else{
							$('#formfont').html("");
							flag2 = true;
						}
						if(!(flag1 & flag2)){
							$('#button001').attr("disabled",false);
							return;
						}
					
					}else if(templateType == '5'){
						var associatedProcessName = $('#associatedProcessName').val();  //关联流程					
						if(associatedProcessName == null || associatedProcessName == ''){
							$('#processfont').html("请选择关联流程");
						}else{
							$('#processfont').html("");
							flag3 = true;
						}
						if(!(flag1 & flag3)){
							$('#button001').attr("disabled",false);
							return;
						}
					}
							
					var url="<%=request.getContextPath()%>/formProcess/formProcess_addFormProcessBefore.action";	
					var jsonData = {};
					jsonData.templateType = templateType;	
					jsonData.name = name;					
					jsonData.parentId = parentId;				
					var associatedFormId = $('#associatedFormId').val();
					var associatedProcessId = $('#associatedProcessId').val();
					jsonData.associatedFormId = associatedFormId;											
					jsonData.associatedProcessId = associatedProcessId;						
					
					if(operation == 'update'){  //编辑
						var uuid = $('#uuid').val();
						jsonData.uuid = uuid;
					}
					Matrix.sendRequest(url,jsonData,function(data){
						var callbackStr = data.data;
					    var callbackJson = isc.JSON.decode(callbackStr);
						
					    var nameMessage = callbackJson.nameMessage;
						$('#namefont').html(nameMessage);
						
						var formMessage = callbackJson.formMessage;
						$('#formfont').html(formMessage);
						
						var processMessage = callbackJson.processMessage;
						$('#processfont').html(processMessage);
												
						if($('#namefont').html() == '' && $('#formfont').html() == '' && $('#processfont').html() == ''){ 
							$("#form0").attr("action", "<%=request.getContextPath()%>/formProcess/formProcess_saveOrUpdateFormProcess.action");
							$('#form0').submit();
						}else{
							$('#button001').attr("disabled",false);
						}
					});									
				});
				
				$('#button002').click(function() {
					var index = parent.layer.getFrameIndex(window.name);
					parent.layer.close(index);
				});
				</script>
			</div>
		</form>
	</div>
</body>
</html>
