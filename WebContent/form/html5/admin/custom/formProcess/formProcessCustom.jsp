<%@page import="com.matrix.app.MAppProperties"%>
<%@page import="com.matrix.app.MAppContext"%>
<%@page import="com.matrix.form.admin.common.utils.CommonUtil"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//Ddiv HTML 4.01 Transitional//EN" "http://www.w3.org/div/html4/loose.ddiv">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/form/html5/admin/html5Head.jsp"%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resource/html5/iconfonts/iconfont.css"/>
<title>Insert title here</title>
<style type="text/css">
	.module-create{
		transition-property: all;
		transition-duration: 218ms;
		width:205px;
		background:#fff;
		height:130px;
		line-height: 130px;
		//box-shadow:2px 2px 5px rgba(185,185,185,.3);
		border-radius:5px;
		position: relative;
		margin: 15px;
		float:left;
		text-align: center;
		border: 1px dashed #e0e0e0;
		margin: 30px;
		cursor: pointer;
	}
	.module-create:hover {
    	border-color: #0DB3A6;
    	color: #0DB3A6;
	}
	.icon-shezhi:hover {
    	color: #0DB3A6!important;
    	border-color: #0DB3A6!important;
	}
</style>
<%
    boolean isSysAdmin = CommonUtil.isSysAdmin();   //是否一级管理员
    boolean isDesigner = CommonUtil.isDesigner();    //是否设计开发人员
    boolean isTenantEnable = MAppProperties.getInstance().isTenantEnable();
    boolean isSetInitialAppId = MAppProperties.getInstance().isSetInitialAppId();
    String tenantId  = MAppContext.getTenantId();
%>
<script type="text/javascript">

	window.onload = function(){
		debugger;
		document.getElementById('isSysAdmin').value = "<%=isSysAdmin %>";
		document.getElementById('isDesigner').value = "<%=isDesigner %>";
		document.getElementById('isTenantEnable').value = "<%=isTenantEnable %>";
		document.getElementById('isSetInitialAppId').value = "<%=isSetInitialAppId %>";	
		
		var tenantId = document.getElementById('tenantId').value;
		if(tenantId==null || tenantId.trim().length==0){
			document.getElementById('tenantId').value = "<%=tenantId %>";
		}
		
		refreshData();
		
		//菜单栏变色变指针
		$("li").mouseover(function(){
			$(this).css("background","rgba(13,179,166,.1)");
			$(this).css("cursor","pointer");
		});
		
		$("li").mouseleave(function(){
			$("li").css("background","#fff");
			$("li").css("cursor","default");
		});
	}
		

	//工具按钮点击事件
	function showList(div){
		//将当前ID赋到隐藏于中
		var	uuid = $(div).parent().attr('id');
		var	text = $(div).parent().children(".moveDiv").text();
		
		//一级管理员才能删除 前移  后移
		var isSysAdmin = document.getElementById('isSysAdmin').value;
		if(isSysAdmin != 'true'){
			$('.liEdit').css('display','none');
			$('.liDelete').css('display','none');
			$('.liGo').css('display','none');
			$('.liBack').css('display','none');
			$('#toolList').css('height','0px');
		}

		$("#templateId").val(uuid);
		var div = $("#toolList");
        if (div.is(":hidden")){
            div.show();
            div.css("display", "");
            div.css("left", document.body.scrollLeft + event.clientX - 149);
            div.css("top", document.body.scrollLeft + event.clientY + 15);
            div.focus();
        } else {
            div.hide();
        }
        e = window.event;
        if (e.stopPropagation) {
            e.stopPropagation();      //阻止div点击事件 冒泡传播
        } else {
            e.cancelBubble = true;   //ie兼容
        }
	}
	
	//工具菜单隐藏
	function hideList(){
		var div = $("#toolList");
        div.css("display", "none");
	}
	
	//加载应用下拉框
	function getAppInfo(){
		var json = {};
		$.ajax({
			type:'post',
			url:'<%=path %>/formProcess/formProcess_getAppInfo.action',
			data:json,
			dataType:'json',
			success:function(data){
				for (var i = 0; i < data.length; i++) {
					$("#appSelect").append("<option value='"+ data[i].appId +"'>" + data[i].appName + "</option>");
				}
				//显示当前应用编码
				var tenantId = document.getElementById('tenantId').value;			
				$("#appSelect").val(tenantId);
			}
		});
	}
	
	//切换应用
	function changeApp(){
		document.getElementById('tenantId').value = $('#appSelect option:selected').val();
		refreshData();
	}
	
	//刷新
	function refreshData(data){
		//4表单定制   5流程定制
		var templateType = $("#templateType").val();
		var json = {};
		json.templateType = templateType;
		if(data!=null){
			json.data = data;
		}
		var tenantId = document.getElementById('tenantId').value;			
		json.tenantId = tenantId;
		$.ajax({
			type:'post',
			url:'<%=path %>/formProcess/formProcess_loadCustomModuleList.action',
			data:json,
			dataType:'json',
			success:function(data){
				var f = document.getElementById("mainDiv"); 
				while(f.hasChildNodes()) //当div下还存在子节点时 循环继续
				{
				    f.removeChild(f.firstChild);
				}

				if(data!=null){
					var templateType = $('#templateType').val();
					var html = '';
					html += '<div id="app-header" style="height: 90px;">';
					html += '<div style="position:relative;left: 70px;top: 55px;">';
					if(templateType=="4"){
						html += '<span style="font-size: 18px">表单定制模块管理</span>';
					}else if(templateType=="5"){
						html += '<span style="font-size: 18px">流程定制模块管理</span>';
					}											
					html += '</div>';
					html += '</div>';
					
					html += '<div style="height: 40px;">';
					var isTenantEnable = $('#isTenantEnable').val();
					var isSetInitialAppId = $('#isSetInitialAppId').val();					
					if(isTenantEnable == 'true' && isSetInitialAppId == 'false'){   //启用租户并且当前没有配置启动单个应用   才有切换应用						
						html += '<div style="float: left;width: calc(100% - 250px);text-align: center;">';
						html += '<span style="font-size: 15px">切换应用：</span>';
						html += '<select onchange="changeApp();" class="form-control select2-accessible" id="appSelect" style="display:inline;text-overflow: ellipsis;overflow: hidden;width: 150px;">';
						html += '</select>';
						html += '</div>';
					}					
					
					html += '<div style="float: right;position: relative;">';
					html += '<i class="fa fa-search" style="position: absolute;top: 11px;left: 15px;color: #5E6D82;"></i>';
					html += '<input id="search" type="text" placeholder="  输入名称搜索" style="padding:7px 30px;background: #EAECED;width: 250px;height: 34px;border: 0px;border-radius:30px"/>';
					html += '</div>';
					html += '</div>';			
					
					html += '</div>';
					html += '<div style="width:100%;height: calc(100% - 90px);padding-left:50px">';
					//一级管理员 并且是设计开发人员才能新建模块
					var isSysAdmin = document.getElementById('isSysAdmin').value;					
					var isDesigner = document.getElementById('isDesigner').value;
					if(isSysAdmin == 'true' && isDesigner == 'true'){
						html += '<div class="module-create" onclick="addModule();">';
						html += '<span style="font-size: 15px;vertical-align: middle;height: 100%" >';	
						html += '<i class="iconfont icon-plus" style="margin-right: 4px;font-size: 16px;"></i>';							
						html += '新建模块';
						html += '</span>';
						html += '</div>';
					}
					
					for(var i=0;i<data.length;i++){
						var id = data[i].id;
						var color = data[i].color;
						if(i!=0&&i%5==0){
							html += '</div>';
							html += '<div style="vertical-align: top;text-align:left;width:100%;padding-left:50px">';
						}
						//判断模板号
						var num = '';
						if(i.toString().length==1){
							num = '00'+ i;
						}else if(i.toString().length==2){
							num = '0'+ i;
						}else if(i.toString().length==3){
							num = i;
						}
						html += '<div tabindex="0" class="templateMain" onclick="clickTem(this);" id="tem'+ num + '_' + id +'" style="transition-property: all;transition-duration: 218ms;width:205px;background:#fff;height:130px;text-align: center;box-shadow:2px 2px 5px rgba(185,185,185,.3);border-radius:5px;position: relative;margin: 30px;float:left">';
						html += '<div style="width: 100%;height: 8px;background: '+color+'"></div>';
						html += '<div style="transition-property: all;transition-duration: 218ms;margin:20px;background: '+ color +';height: 50px;width: 50px;border-radius:10px;display: inline-table;">';
						<%-- html += '<img src="<%=path %>/image/Option.png" style="background:transparent;margin:10px;height: 30px;width: 30px;"/>'; --%>
						html += '</div>';
						html += '<div class="moveDiv" style="transition-property: all;transition-duration: 218ms;font-size: 15px;width:100px;overflow:hidden;text-overflow:ellipsis;margin:auto;">';
						html += data[i].text;
						html += '</div>';
						html += '<i class="iconfont icon-shezhi imgButton" style="display: none;position: absolute;right: 8px;bottom: 1px;font-size: 20px;color: #91A1B7;" onclick="showList(this);"></i>';
						html += '</div>';
					}
					html += '</div>';
					$("#mainDiv").append(html);
					
					var isTenantEnable = $('#isTenantEnable').val();
					if(isTenantEnable){
						getAppInfo();
					}
									
					var isSysAdmin = document.getElementById('isSysAdmin').value;
					if(isSysAdmin == 'true'){
						//监听显示工具按钮
						$("div[id^='tem']").mouseover(function(){
							$(this).children(".imgButton").css("display","");
						});
						
						$("div[id^='tem']").mouseleave(function(){
							$(".imgButton").css("display","none");
						});
						
						//监听工具栏失焦隐藏
						$("#toolList").blur(function(){
							$("#toolList").css("display","none");
						});
					}
					
					//监听回车执行查询
					$('#search').bind('keyup', function(event) {
						if (event.keyCode == "13") {
							var data = $("#search").val();
							refreshData(data);
				        }
				    });
					
					//div指针变型监听
					$("div[id^=tem]").mouseover(function(){
						$(this).css("cursor","pointer");
					});
						
					$("div[id^=tem]").mouseleave(function(){
						$("li").css("cursor","default");
					});
					
					//div鼠标移过动画效果
					$(".templateMain").mouseover(function(){
						$(this).css("transform","translate(0,-5px)");
						$(this).css("cursor","pointer");
					});
					
					$(".templateMain").mouseleave(function(){
						$(this).css("transform","translate(0,0)");
						$(this).css("cursor","default");

					});
				}
			}
		});
	}

	//删除模块
	function deleteModule(){
		var templateId = $("#templateId").val();
		var templateType = $("#templateType").val();
		var json = {};
		json.nodeId = templateId;
		json.templateType = templateType;
		json.nodeType = 'module';
		Matrix.confirm('确定要删除吗？',function(value){
			if(true){
				$.ajax({
					type:'post',
					url:'<%=path %>/formProcess/formProcess_deleteNode.action',
					data:json,
					dataType:'json',
					success:function(data){
						if(data==true){
							refreshData();
							Matrix.success('删除成功！');
						}
					}
				});
			}
		});
	}
	
	
	//新建模块
	function addModule(){
		//根据模板类型根据当前的根节点
		var templateType = $("#templateType").val();
		var json = {};
		json.templateType = templateType;
		var tenantId = document.getElementById('tenantId').value;			
		json.tenantId = tenantId;
		$.ajax({
			type:'post',
			url:'<%=path %>/formProcess/formProcess_getRootIdBeforeAdd.action',
			data:json,
			dataType:'json',
			success:function(data){
				var parentId = data;
				layer.open({
			    	id:'addModule',
					type : 2,//iframe 层					
					shade: [0.1, '#000'],
					title : ['新建模块'],
					closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
					shadeClose: false, //开启遮罩关闭
					area : [ '50%', '60%' ],
					content : '<%=request.getContextPath()%>/form/html5/admin/custom/formProcess/addModuleList.jsp?addType=add&parentId='+parentId+'&tenantId='+tenantId+'&type='+templateType,
					end	: function(){
						refreshData();
					}
				});
			}
		});
	}
	
	//前移
	function goMoveModule(){
		//拿到当前div id
		var templateId = $("#templateId").val();
		var index = templateId.substring(3,6);
		//根据当前div查找前一个div的ID
		var num = parseInt(index,10);
		var lastNum = num - 1;
		var lastTemId = "";
		if(lastNum.toString().length==1){
			lastTemId = '00'+ lastNum;
		}else if(lastNum.toString().length==2){
			lastTemId = '0'+ lastNum;
		}else if(lastNum.toString().length==3){
			lastTemId = lastNum;
		}
		//判断是否为第一个
		var last = $("div[id^=tem"+lastTemId+"_]");
		if(last.length==0){
			Matrix.warn("首位不能前移！");
		}else{
			var json = {};
			json.now = templateId;
			json.last = last[0].id;
			json.templateType = '1';
			$.ajax({
				type:'post',
				url:'<%=path %>/formProcess/formProcess_goMoveNode.action',
				data:json,
				dataType:'json',
				success:function(data){
					if(data==true){
						hideList();
						refreshData();
					}
				}
			});
		}
	}
	
	//后移
	function backMoveModule(){
		//拿到当前div id
		var templateId = $("#templateId").val();
		var index = templateId.substring(3,6);
		//根据当前div查找后一个div的ID
		var num = parseInt(index,10);
		var nextNum = num + 1;
		var nextTemId = "";
		if(nextNum.toString().length==1){
			nextTemId = '00'+ nextNum;
		}else if(nextNum.toString().length==2){
			nextTemId = '0'+ nextNum;
		}else if(nextNum.toString().length==3){
			nextTemId = nextNum;
		}
		//判断是否为最后一个
		var next = $("div[id^=tem"+nextTemId+"_]");
		if(next.length==0){
			Matrix.warn("末位不能后移！");
		}else{
			var json = {};
			json.now = templateId;
			json.next = next[0].id;
			json.templateType = '1';
			$.ajax({
				type:'post',
				url:'<%=path %>/formProcess/formProcess_backMoveNode.action',
				data:json,
				dataType:'json',
				success:function(data){
					if(data==true){
						hideList();
						refreshData();
					}
				}
			});
		}
	}
	
	//修改
	function editModule(){
		var templateId = $("#templateId").val();
		var templateType = $("#templateType").val();
		layer.open({
	    	id:'editModule',
			type : 2,//iframe 层			
			shade: [0.1, '#000'],
			title : ['编辑模块'],
			closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
			shadeClose: false, //开启遮罩关闭
			area : [ '50%', '50%' ],
			content : '<%=path%>/formProcess/formProcess_loadEditModulePage.action?uuid='+templateId+'&type='+templateType,
			end	: function(){
				hideList();
				refreshData();
			}
		});
	}
	
	//点击进入列表
	function clickTem(data){
		var templateType = $("#templateType").val();
		var nodeId = data.id;
		nodeId = nodeId.substring(7,nodeId.length);
		
		var tenantId = document.getElementById('tenantId').value;			
		
		window.location.href = "<%=path%>/form/html5/admin/custom/formProcess/formProcessList.jsp?templateType="+templateType+"&tenantId="+tenantId+"&nodeId="+nodeId;
	}
	
	

</script>
</head>
<body>
	<input type="hidden" id="templateType" name="templateType" value="${param.templateType}">
	<input type="hidden" id="templateId" name="templateId">
	<!-- 是否是一级管理员 -->
	<input type="hidden" id="isSysAdmin" name="isSysAdmin">
	<!-- 是否是设计开发人员 -->
	<input type="hidden" id="isDesigner" name="isDesigner">	
	<!-- 是否启用租户 -->
	<input type="hidden" id="isTenantEnable" name="isTenantEnable">
	<!-- 是否配置启动单个应用 -->
	<input type="hidden" id="isSetInitialAppId" name="isSetInitialAppId">
	<!-- 当前租户编码 -->
	<input type="hidden" id="tenantId" name="tenantId" value="${param.tenantId}">
	
		
	<div tabindex="0" onblur="hideList();" id="toolList" style="z-index:999999;position:absolute;display: none;height:144px;width:160px;background:#fff;box-shadow:2px 2px 5px rgba(185,185,185,.3)">
		<ul>
			<li class="liEdit" style="height: 36px;line-height: 36px;font-size: 14px;padding-left: 10px;" onclick="editModule();">修改</li>
			<li class="liDelete" style="height: 36px;line-height: 36px;font-size: 14px;padding-left: 10px;" onclick="deleteModule();">删除</li>
			<li class="liGo" style="height: 36px;line-height: 36px;font-size: 14px;padding-left: 10px;" onclick="goMoveModule();">前移</li>
			<li class="liBack" style="height: 36px;line-height: 36px;font-size: 14px;padding-left: 10px;" onclick="backMoveModule();">后移</li>
		</ul>
	</div>
	<div style="width: 100%;height: 100%;overflow:auto;background: rgba(245,245,247,.9)">
		<div id="mainDiv" style="background: rgba(245,245,247,.9);width: 70%;height:100%;margin:auto;">
			
		</div>
	</div>
</body>
</html>