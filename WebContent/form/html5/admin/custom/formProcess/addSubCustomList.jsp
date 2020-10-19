<%@page import="com.matrix.commonservice.data.DataService"%>
<%@page import="com.matrix.app.MAppContext"%>
<%@page import="com.matrix.form.api.MFormContext"%>
<%@page import="com.matrix.form.admin.common.utils.RestRequestUrl"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.matrix.form.admin.common.utils.CommonUtil"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset='utf-8' />
<title>添加子版本定制</title>
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
<%
	boolean isSysAdmin = CommonUtil.isSysAdmin();   //是否一级管理员
	boolean isSubAdmin = CommonUtil.isSubAdmin();   //是否二级管理员
	String getSubBusinessByIdUrl = RestRequestUrl.GETSUBBUSINESSBYID;
	
	String currentOrgId = MFormContext.getUser().getOrgId();
	DataService dataService = MFormContext.getService("DataService");
	String currentOrgName = (String) dataService.queryValue("select depName from foundation.org.Department where sequenceId='"+currentOrgId+"'", null);
%>
<script type="text/javascript">
	$(function(){
		document.getElementById('isSysAdmin').value = "<%=isSysAdmin %>";
		document.getElementById('isSubAdmin').value = "<%=isSubAdmin %>";
		document.getElementById('currentOrgName').value = "<%=currentOrgName %>";
		
		colorInit();
		//颜色选择
		$('.colorChoose').click(function(){
			$('.colorChoose').css('border','0px');
			$(this).css('border','2px solid black');
			var background = $(this).css('background-color');
			$('#color').val(background);
		});
		
		var addType = '${param.addType }';  //add添加
		var operation = '${operation}';
		var templateType = $('#templateType').val();   //4表单定制 5流程定制
		var versionType = $('#versionType').val();  //2业务子版本  3组织子版本
		
		if(versionType == '2'){  //业务子版本
			var json = {};
			json.businessId = document.getElementById('parentBusId').value;
			$.ajax({
				type:'post',
				url:'<%=getSubBusinessByIdUrl %>',
				data:json,
				dataType:'json',
				success:function(data){
					for (var i = 0; i < data.length; i++) {
						$("#businessId").append("<option value='"+ data[i].businessId +"'>" + data[i].businessName + "</option>");
					}
					if(operation == 'update'){   //编辑时
						$("#businessId").val($("#currentBusinessId").val());
					}				
				}
			});
		}
		
		if(addType == 'add'){   //添加时
			//是否一级管理员
			var isSysAdmin = document.getElementById('isSysAdmin').value;
			//是否二级管理员
			var isSubAdmin = document.getElementById('isSubAdmin').value;
			
			//子版本类型限制
			if(versionType == '3'){  //添加组织子版本时  不能指定业务类型的子版本
				var obj = document.getElementById('levelType');
				obj.options[1].remove();
								
				document.getElementById('subVersionType').style.display="none";
				if(templateType == '4'){   //表单定制
					document.getElementById('currentOrg').style.display="";
				}			
			}
		}
		
		if(versionType == '2'){  //业务子版本
			document.getElementById('business').style.display = '';
		}
		if(templateType == '5' && versionType == '3' && addType == 'add'){  //定制流程时添加机构子版本
			document.getElementById('dep').style.display="";
		}		
		if(operation == 'update' && versionType == '3'){  //编辑组织子版本时
			document.getElementById('dep').style.display = '';
		}
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
			var url="<%=request.getContextPath()%>/formProcess/formProcess_addSubCustomBefore.action";	
			
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
	
	//选部门 
	function selectdep(){
		layer.open({
			id:'selectdep',
    		type:2,
    		shade: [0.1, '#000'],
    		title:['选择部门'],
    		closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
    		shadeClose: false, //开启遮罩关闭
    		area:['85%','100%'],
    		content: '<%=path %>/office/html5/select/SingleSelectDep.jsp?flag=false&iframewindowid=selectdep'
    	});
	}
	
	//选择部门回调
	function onselectdepClose(data){
		if(data!=null){		
			document.getElementById("depName").value = data.names;
			document.getElementById("depId").value = data.ids;
		}
	}	
	
	//清除已选择的部门
	function cleardep(){
		document.getElementById("depName").value = '';
		document.getElementById("depId").value = '';
	}
</script>
</head>
<body>
	<div style="width: 100%; height: 100%; overflow: auto; position: relative; margin: 0 auto; zoom: 1; padding: 10px 10px;" id="context">
		<form id="form0" name="form0" eventProxy="Mform0" method="post" action="" style="margin: 0px; position: relative; overflow: hidden; width: 100%; height: 100%;" enctype="application/x-www-form-urlencoded">
			<input type="hidden" name="form0" value="form0" />
			<!-- 当前颜色 -->
			<input type="hidden" id="color" name="color" value="${color}">
			<!-- 4表单定制  5流程定制 -->
			<input type="hidden" id="templateType" name="templateType" value="${param.type}" /> 
			<!-- 当前子版本模板主键 -->
			<input type="hidden" id="uuid" name="uuid" value="${uuid }"> 
			<!-- 父定制模板主键   -->
			<input type="hidden" id="parentId" name="parentId" value="${param.parentId }" />		
			<!-- 版本类型  1:集团基础版本   2业务子版本  3机构子版本   -->
			<input type="hidden" id="versionType" name="versionType" value="${param.versionType}" />
			<!-- 定制子版本时机构编码-->
			<input type="hidden" id="orgId" name="orgId" value="${orgId }" />
			<!-- 定制子版本时业务编码-->
			<input type="hidden" id="currentBusinessId" name="currentBusinessId" value="${businessId }" />
				
			<!-- 授权范围编码 -->
			<input type="hidden" id="authId" name="authId" value="${authId }"/>
			
			<!-- 指定部门编码 -->
			<input type="hidden" id="depId" name="depId"/>
			
			<!-- 是否是一级管理员 -->
			<input type="hidden" id="isSysAdmin" name="isSysAdmin">
			<!-- 是否是二级管理员 -->
			<input type="hidden" id="isSubAdmin" name="isSubAdmin">
			
		    <!-- 上一层业务编码 -->
		    <input type="hidden" id="parentBusId" name="parentBusId" value="${param.parentBusId}">
			<!-- 上一层机构编码 -->
			<input type="hidden" id="parentOrgId" name="parentOrgId" value="${param.parentOrgId}">	
			
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
					<tr id="currentOrg" style="display:none;">
						<td class="tdLayout" style="width: 30%; text-align: center; vertical-align: middle; background-color: rgb(248, 248, 248)">
							<label class="control-label ">机构名称</label>
						</td>
						<td class="tdLayout" style="width: 70%;">
							<div class="input-group" style="width: 100%;">
								 <input type="text" id="currentOrgName" class="form-control" readonly="readonly">			            	
							</div>
						</td>
					</tr>
					<tr id="business" style="display:none;">
						<td class="tdLayout" style="width: 40%; text-align: center; vertical-align: middle; background-color: rgb(248, 248, 248)">
							<label class="control-label ">业务分类：</label>
						</td>
						<td class="tdLayout" style="width: 100%;">
							<div style="vertical-align: middle;">
								<select id="businessId" name="businessId" class="form-control" style="height:100%;width:100%;" ${operation == 'update'?'disabled':''}>
                         	                      
			                    </select>
							</div>
						</td>
					</tr>
	  				<tr id="dep" style="display:none;">
						<td class="tdLayout" style="width: 30%; text-align: center; vertical-align: middle; background-color: rgb(248, 248, 248)">
							<label class="control-label ">${operation == 'update'?'所属机构':'组织：'}</label>
						</td>
						<td class="tdLayout" style="width: 70%;">
							<div class="input-group" style="width: 100%;">
								 <input type="text" id="depName" name="depName" value="${depName }" placeholder="请选择组织" class="form-control" readonly="readonly">
			            		 <span class="input-group-addon addon-udSelect udSelect" onclick="selectdep();" style="border-left: 0px;border-radius: 0px;display:${operation == 'update'?'none':''};" style=""><i class="fa fa-search"></i></span>
			            		 <span class="input-group-addon addon-udSelect udSelect" onclick="cleardep();" style="border-radius: 0px;display:${operation == 'update'?'none':''};"><i class="fa fa-times"></i></span>
							</div><font id="depfont" color="red"></font>
						</td>
					</tr>
					<tr id="subVersionType">
						<td class="tdLayout" style="width: 40%; text-align: center; vertical-align: middle; background-color: rgb(248, 248, 248)">
							<label class="control-label ">子版本类型：</label>
						</td>
						<td class="tdLayout" style="width: 100%;">
							<div style="vertical-align: middle;">
								<select id="levelType" name="levelType" class="form-control" style="height:100%;width:100%;" ${operation == 'update'?'disabled':''}>									 								 
									 <option value="2" ${levelType == 2 ? "selected" : ""}>组织类型</option>	
									 <option value="1" ${levelType == 1 ? "selected" : ""}>业务类型</option>	                         	                      
			                    </select>
							</div>
						</td>
					</tr>
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
					debugger;
					//设置确定按钮不可用  防止重复提交
					$('#button001').attr("disabled",true);
					
					var addType = '${param.addType }';
					var operation = '${operation}';
					var templateType = $('#templateType').val();   //4表单定制 5流程定制
					var name = $('#name').val();  //名称
					var parentId = $('#parentId').val();  //父编码  即目录主键编码
					var versionType = $('#versionType').val();  //版本类型  1:集团基础版本   2业务子版本  3机构子版本
					
					if(name.length<0 || name.length>40){
						Matrix.warn('名称长度不符合标准！');
						$('#button001').attr("disabled",false);
						return false;
					}
					
					$('#namefont').html("");				
					if(name == null || name == ''){
						$('#namefont').html("请输入名称");
						$('#button001').attr("disabled",false);
						return false;
					}else{
						$('#namefont').html("");
					}
					
					if(templateType == '5' && versionType == '3'){  //定制流程时机构子版本
						var depName = $('#depName').val();  //名称
						$('#depfont').html("");				
						if(depName == null || depName == ''){
							$('#depfont').html("请选择部门");
							$('#button001').attr("disabled",false);
							return false;
						}else{
							$('#depfont').html("");
						}				
					}		
							
					var url = "<%=request.getContextPath()%>/formProcess/formProcess_addSubCustomBefore.action";	
					var jsonData = {};
					jsonData.templateType = templateType;	
					jsonData.name = name;					
					jsonData.parentId = parentId;
					jsonData.versionType = versionType;
					if(templateType == '5' && versionType == '3'){  //定制流程时机构子版本
						jsonData.depId = document.getElementById('depId').value;
					}
					if(versionType == '2'){   //业务子版本
						var businessId = $('#businessId').val();  //业务分类编码
						jsonData.businessId = businessId;
					}else if(versionType == '3'){  //机构子版本
						var parentBusId = $('#parentBusId').val();  //父业务分类编码
						jsonData.businessId = parentBusId;
						
						var parentOrgId = $('#parentOrgId').val();  //父机构编码
						jsonData.parentOrgId = parentOrgId;
					}
																					
					if(operation == 'update'){  //编辑
						var uuid = $('#uuid').val();
						jsonData.uuid = uuid;
					}
					Matrix.sendRequest(url,jsonData,function(data){
						var callbackStr = data.data;
					    var callbackJson = isc.JSON.decode(callbackStr);
						
					    var nameMessage = callbackJson.nameMessage;
						$('#namefont').html(nameMessage);
												
						if($('#namefont').html() == ''){
							if(versionType == '2'){   //业务子版本
								var businessIdMessage = callbackJson.businessIdMessage;
								if(businessIdMessage != ''){
									Matrix.warn(businessIdMessage);
									$('#button001').attr("disabled",false);
									return false;
								}
							}else if(versionType == '3'){  //机构子版本
								var orgIdMessage = callbackJson.orgIdMessage;
								if(orgIdMessage != ''){
									Matrix.warn(orgIdMessage);
									$('#button001').attr("disabled",false);
									return false;
								}
							}
							$("#form0").attr("action", "<%=request.getContextPath()%>/formProcess/formProcess_saveOrUpdateSubCustom.action");
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