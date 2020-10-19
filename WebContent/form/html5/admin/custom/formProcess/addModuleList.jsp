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
		var addType = '${param.addType }';  //add添加目录
		var operation = '${operation }';	//update编辑目录
		
		$('#namefont').html("");
	
		if($('#name').val() == null || $('#name').val() == ''){
			$('#namefont').html("请输入名称");
		}else{
			var name = $('#name').val();
			var url="<%=request.getContextPath()%>/formProcess/formProcess_addModuleBefore.action";	
			
			var jsonData = {};
			jsonData.name = name;
			var templateType = $('#templateType').val();
			jsonData.templateType = templateType;
			if(operation == 'update'){  //编辑目录
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
			<input type="hidden" id="tenantId" name="tenantId" value="${param.tenantId }" />
			
			<div style="height:calc(100% - 54px);width: 100%;overflow: auto;">
				<table id="table001" class="tableLayout" style="width: 100%;">
					<tr id="tr002">
						<td id="td003" class="tdLayout" style="width: 40%; text-align: center; vertical-align: middle; background-color: rgb(248, 248, 248)">
							<label class="control-label ">名称：</label>
						</td>
						<td id="td004" class="tdLayout" style="width: 100%;">
							<div id="input002_div" class="input-group col-md-12 " style="display: inline-table; vertical-align: middle; width: 100%;">
								<input id="name" name="name" type="text" value="${templateName }"
									class="form-control "
									style="width: 100%; height: 100%; padding-left: 5px;"
									autocomplete="off" onblur="checkName();">
							</div><font id="namefont" color="red">${requestScope.nameEchoMessage }</font>
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
					<tr id="tr003">
						<td id="td005" class="tdLayout" style="width: 40%; text-align: center; vertical-align: middle; background-color: rgb(248, 248, 248)">
							<label class="control-label ">备注：</label>
						</td>
						<td id="td006" class="tdLayout" style="height:108px;width: 60%;">
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
					
					if(name.length<0 || name.length>40){
						Matrix.warn('名称长度不符合标准！');
						$('#button001').attr("disabled",false);
						return;
					}
					
					$('#namefont').html("");
					
					var flag =false;					
					if(name == null || name == ''){
						$('#namefont').html("请输入名称");
					}else{
						flag = true;
					}
					if(!flag){
						$('#button001').attr("disabled",false);
						return;
					}
					
					var url="<%=request.getContextPath()%>/formProcess/formProcess_addModuleBefore.action";	
					var jsonData = {};
					jsonData.name = name;
					var templateType = $('#templateType').val();
					jsonData.templateType = templateType;
					if(operation == 'update'){  //编辑目录
						var uuid = $('#uuid').val();
						jsonData.uuid = uuid;
					}
					//当前用户应用编码
					var tenantId = document.getElementById('tenantId').value;			
					jsonData.tenantId = tenantId;
					
					Matrix.sendRequest(url,jsonData,function(data){
						var callbackStr = data.data;
					    var callbackJson = isc.JSON.decode(callbackStr);
						
					    var nameMessage = callbackJson.nameMessage;
						$('#namefont').html(nameMessage);
												
						if($('#namefont').html() == ''){ 
							$("#form0").attr("action", "<%=request.getContextPath()%>/formProcess/formProcess_saveOrUpdateModule.action");
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
