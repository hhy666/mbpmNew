<%@page import="com.matrix.form.admin.common.utils.CommonUtil"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/form/html5/admin/html5Head.jsp"%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resource/html5/iconfonts/iconfont.css"/>
<title>Insert title here</title>
<style type="text/css">
	.app-create{
		transition-property: all;
		transition-duration: 218ms;
		width:240px;
		background:#fff;
		height:110px;
		line-height: 110px;
		//box-shadow:2px 2px 5px rgba(185,185,185,.3);
		border-radius:5px;
		position: relative;
		margin: 15px;
		float:left;
		text-align: center;
		border: 1px dashed #e0e0e0;
	}
	.app-create:hover {
    	border-color: #0DB3A6;
    	color: #0DB3A6;
	}
	.app-item{
		transition-property: all;
		transition-duration: 218ms;
		width:240px;
		background:#fff;
		height:110px;
		box-shadow:2px 2px 5px rgba(185,185,185,.3);
		border-radius:5px;
		position: relative;
		margin: 15px;
		float:left;
		overflow: hidden;
	}
	.app-area{
		display: inline-block;
	    width:240px;
	    height:110px;
	}
	.app-wrapper {
		height: 100%;
	}
	.app-design {
	    position: absolute;
	    top: 110px;
	    left: 0;
	    -webkit-border-radius: 0 0 2.4px 2.4px;
	    -moz-border-radius: 0 0 2.4px 2.4px;
	    border-radius: 0 0 2.4px 2.4px;
	    -webkit-transform: translate(0,0);
	    -moz-transform: translate(0,0);
	    -ms-transform: translate(0,0);
	    -o-transform: translate(0,0);
	    transform: translate(0,0);
	    -webkit-transition: all 218ms;
	    -moz-transition: all 218ms;
	    -o-transition: all 218ms;
	    transition: all 218ms;
	    width: 100%;
	    height: 35px;
	    cursor: pointer;
	}
	.app-design a {
	    display: block;
	    color: #91A1B7;
	    position: absolute;
	    top: 5px;
	    left: 10px;
	    padding: 3px 13px;
	    border: 1px solid #91A1B7;
	    -webkit-border-radius: 47px;
	    -moz-border-radius: 47px;
	    border-radius: 47px;
	}
	.app-design a:hover {
    	color: #0DB3A6!important;
    	border-color: #0DB3A6!important;
	}
	.app-design i:hover {
    	color: #0DB3A6!important;
    	border-color: #0DB3A6!important;
	}
	.app-list>.app-item,.open>.app-area>.app-wrapper{
		height: 100%;
	 	-webkit-transform: translate(0,-15px);
	    -moz-transform: translate(0,-15px);
	    -ms-transform: translate(0,-15px);
	    -o-transform: translate(0,-15px);
	    transform: translate(0,-15px);
	}
	.app-list>.app-item,.open>.app-design{
		background: #F3F3F3;
	    -webkit-transform: translate(0,-35px);
	    -moz-transform: translate(0,-35px);
	    -ms-transform: translate(0,-35px);
	    -o-transform: translate(0,-35px);
	    transform: translate(0,-35px);
	}
</style>
<%
	boolean isSysAdmin = CommonUtil.isSysAdmin();   //是否一级管理员
	boolean isSubAdmin = CommonUtil.isSubAdmin();   //是否二级管理员
	boolean isDesigner = CommonUtil.isDesigner();    //是否设计开发人员
%>
<script type="text/javascript">

	window.onload = function(){
		debugger;
		document.getElementById('isSysAdmin').value = "<%=isSysAdmin %>";
		document.getElementById('isSubAdmin').value = "<%=isSubAdmin %>";
		document.getElementById('isDesigner').value = "<%=isDesigner %>";
		
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

	//加载下拉框模板目录
	function getCustomModule(){
		var templateType = $("#templateType").val();
		var levelType = $("#levelType").val();		
		var tenantId = document.getElementById('tenantId').value;
		
		var json = {};
		json.templateType = templateType;
		json.levelType = levelType;
		json.tenantId = tenantId;
		if(levelType != 0){   //当前层次子版本类型  0基础   1业务  2组织
			var parentTemplUuid = $("#parentTemplUuid").val();
			json.parentTemplUuid = parentTemplUuid;
		}
		$.ajax({
			type:'post',
			url:'<%=path %>/formProcess/formProcess_getCustomModule.action',
			data:json,
			dataType:'json',
			success:function(data){
				for (var i = 0; i < data.length; i++) {
					$("#module").append("<option value='"+ data[i].templateId +"'>" + data[i].templateName + "</option>");
				}
				//显示当前模板目录
				$("#module").val($("#nodeId").val());
			}
		});
	}
	
	//刷新
	function refreshData(condition){
		debugger;
		var json = {};
		var nodeId = $("#nodeId").val();
		var templateType = $('#templateType').val();
		
		json.nodeId = nodeId;
		json.templateType = templateType;
		
		let isSearch = false;
		if("undefined" != typeof condition){
			isSearch = true;
			json.condition = condition;    //查询条件
		}
		
		$.ajax({
			type:'post',
			url:'<%=path %>/formProcess/formProcess_loadCustomTemplateList.action',
			data:json,
			dataType:'json',
			success:function(data){
				debugger;
				if(!isSearch){
					var f = document.getElementById("mainDiv"); 
					while(f.hasChildNodes()) //当div下还存在子节点时 循环继续
					{
					    f.removeChild(f.firstChild);
					}		
				}else{
					var f = document.getElementById("app-list"); 
					while(f.hasChildNodes()) //当div下还存在子节点时 循环继续
					{
					    f.removeChild(f.firstChild);
					}
				}
				//当前层次子版本类型  0基础   1业务  2组织
				var levelType = data.levelType;
				$('#levelType').val(levelType);
				//当前路径
				var curPosition = data.curPosition;
				 //上一层模板主键编码  用于返回
				var parentTemplUuid = data.parentTemplUuid;
				$('#parentTemplUuid').val(parentTemplUuid);
				
				//上一层业务编码 
				var parentBusId = data.parentBusId;
				$('#parentBusId').val(parentBusId);
				
				//上一层机构编码 
				var parentOrgId = data.parentOrgId;
				$('#parentOrgId').val(parentOrgId);
				
				//模板JSON数组信息
				var data = data.templateJson;
				if(data!=null){
					var html = '';
					
					if(!isSearch){
						html += '<div id="app-header" style="height: 90px;">';
						html += '<i onclick="backList();" class="fa fa-angle-left" style="color: black;top: 10px;left:15px;font-size: 30px;position: absolute;"></i>';					
						html += '<div style="position:relative;left: 70px;top: 55px;">';
						html += '<span style="font-size: 16px;color: rgb(22, 105, 171);">当前路径：</span>';
						html += '<span style="font-size: 15px;">'+curPosition+'</span>';
						html += '</div>';
						html += '</div>';
						
						html += '<div style="height: 40px;">';
						html += '<div style="float: left;width: calc(100% - 250px);text-align: center;">';
						if(levelType == 1){
							html += '<span style="font-size: 15px">定制模块：</span>';
						}else{
							html += '<span style="font-size: 15px">定制模板：</span>';
						}					
						html += '<select onchange="changeModule();" class="form-control select2-accessible" id="module" style="display:inline;text-overflow: ellipsis;overflow: hidden;width: 300px;">';
						html += '</select>';
						html += '</div>';
						
						html += '<div style="float: right;position: relative;">';
						html += '<i class="iconfont icon-search" style="position: absolute;top: 8px;left: 15px;color: #5E6D82;"></i>';
						html += '<input id="search" type="text" placeholder="  输入名称搜索" style="padding:7px 30px;background: #EAECED;width: 250px;height: 34px;border: 0px;border-radius:30px"/>';
						html += '</div>';
						html += '</div>';					
					}	
					
					html += '<div id="app-list" style="height: calc(100% - 130px);padding-left:50px">';					
					//是否一级管理员
					var isSysAdmin = document.getElementById('isSysAdmin').value;
					//是否二级管理员
					var isSubAdmin = document.getElementById('isSubAdmin').value;
					//是否设计开发人员
					var isDesigner = document.getElementById('isDesigner').value;
					
					if(levelType == 0){     //定制模块进入的集团基础版本层级
						if(isSysAdmin == 'true' && isDesigner == 'true'){      //一级管理员 并且是设计开发人员才能新建定制
							html += '<div class="app-create" onclick="createTemplate();">';
							html += '<span style="font-size: 15px;vertical-align: middle;height: 100%" >';	
							html += '<i class="iconfont icon-plus" style="margin-right: 4px;font-size: 16px;"></i>';							
							if(templateType=="4"){
								html += '新建定制表单'
							}else if(templateType=="5"){
								html += '新建定制流程'
							}
							html += '</span>';
							html += '</div>';
						}
						
					}else if(levelType == 1){     //业务版本层级
						if(isSysAdmin == 'true'){    //一级管理员才能新建业务子版本
							html += '<div class="app-create" onclick="addBusinessSub();">';
							html += '<span style="font-size: 15px;vertical-align: middle;height: 100%" >';	
							html += '<i class="iconfont icon-plus" style="margin-right: 4px;font-size: 16px;"></i>';				
							html += '新建业务子版本'
							html += '</span>';
							html += '</div>';
						}
						
					}else if(levelType == 2){	 //组织版本层级
						if(isSubAdmin == 'true'){    //二级管理员才能新建组织子版本
							html += '<div class="app-create" onclick="addOrgSub();">';
							html += '<span style="font-size: 15px;vertical-align: middle;height: 100%" >';	
							html += '<i class="iconfont icon-plus" style="margin-right: 4px;font-size: 16px;"></i>';				
							html += '新建组织子版本'
							html += '</span>';
							html += '</div>';
						}					
					}				
					
					for(var i=0;i<data.length;i++){
						var id = data[i].id;
						var color = data[i].color;
						var parentTId = data[i].parentTId;    //定制子版本时记录的父定制模板编码
						var businessId = data[i].businessId;   //定制子版本时业务编码
						var orgId = data[i].orgId;    //定制子版本时机构编码
						var versionType = data[i].versionType;    //版本类型  1:集团基础版本   2业务子版本  3机构子版本
						
						$('#data').val(JSON.stringify(data));
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
						html += '<div class="app-item">';					
						html += '<div class="app-area" id="tem'+ num + '_' + id +'" onclick="clickForm(this,'+i+')">';
						html += '<div class="app-wrapper">';
						html += '<div style="position:absolute;left:20px;top:30px;background:'+ (color==null?"rgb(91, 155, 213)":color) +';height: 50px;width: 50px;border-radius:10px;">';
						html += '</div>';
						html += '<div class="app-text" title="'+ data[i].text+'" style="height:60px;word-break: break-all;font-size: 15px;position: absolute;top: 45px;bottom:0px;left: 85px;text-overflow:ellipsis;overflow:hidden;">';
						html += data[i].text;
						html += '</div>';
						html += '</div>';
						html += '</div>';
						
						html += '<div class="app-design" id="tem'+ num + '_' + id +'" parentTId="'+parentTId+'" businessId="'+businessId+'" orgId="'+orgId+'" versionType="'+versionType+'">';
						html += '<a id="tem'+ num + '_' + id +'" onclick="enterTemplate(this,'+i+')" href="#"><span>进入下一级</span></a>';	
						
						html += '<i class="iconfont icon-shezhi" style="position: absolute;right: 8px;bottom: 2px;font-size: 20px;color: #91A1B7;" onclick="showList(this);"></i>';
						html += '</div>';
											
						html += '</div>';			
					}
					html += '</div>';
					
					if(!isSearch){
						$("#mainDiv").append(html);
						//数据加载完后加载下拉框模板目录
						getCustomModule();
					}else{
						$("#app-list").append(html);
					}		
							
					$("div[class='app-item']").mouseover(function(){
						$(this).addClass("open");							
					});
					
					$("div[class='app-item']").mouseleave(function(){
						if($('#toolList').is(':hidden')){						
							$(this).removeClass("open");						
						}					
					});
					
					//监听工具栏失焦隐藏
					$("#toolList").mouseover(function(){
						$(this).parent().addClass("open");	
					});
					
					
					//监听回车执行查询
					$('#search').keydown(function(){					
				        if (event.keyCode == "13") {				  
				        	var condition = $("#search").val();
				        	refreshData(condition);
				        }
					});
					
					//后退变型监听
					$(".fa-angle-left").mouseover(function(){
						$(this).css("cursor","pointer");
					});
						
					$(".fa-angle-left").mouseleave(function(){
						$(this).css("cursor","default");
					});
					
					//div鼠标移过动画效果
					$(".app-create,.app-item").mouseover(function(){
						$(this).css("transform","translate(0,-5px)");
						$(this).css("cursor","pointer");
					});
					
					$(".app-create,.app-item").mouseleave(function(){
						if($('#toolList').is(':hidden')){
							$(this).css("transform","translate(0,0)");
							$(this).css("cursor","default");
						}						
					});
					
					//根据文字长度设定文字内容div位置
					var count = $(".app-text").length;
					for(var i=0;i<count;i++){
						//初始长度
						var strlenght = 0;
						//文本区
						var str = $(".app-text")[i].innerHTML;
						for(var a=0;a<str.trim().length;a++){
							var pattern = new RegExp("[\u4E00-\u9FA5]+");//中文验证
							var pattern2 = new RegExp("[A-Za-z]+");//英文验证
							var pattern3 = new RegExp("[0-9]+");//数字验证
							//if (isCN(str.charAt(i)) == true) {
							if (pattern.test(str.charAt(i))) {
								strlenght = strlenght + 2; //中文为两个字符两
							} else if(pattern2.test(str.charAt(i))||pattern3.test(str.charAt(i))){
								strlenght = strlenght + 1; //英文或数字一个字符
							}
						}
						if(strlenght<21){
							$(".app-text")[i].style.top = '45px';
						}else if(strlenght>=21&&strlenght<=42){
							$(".app-text")[i].style.top = '35px';
						}else if(strlenght>42){
							$(".app-text")[i].style.top = '25px';
						}
					}
				}
			}
		});
	}
	
	//判断是不是中文
	function isCN(str) { 
		var regexCh = /[u00-uff]/;
		return !regexCh.test(str);
	}
	
	//模板目录下拉框change事件
	function changeModule(){
		var nodeId = $('#module option:selected').val();
		var nodeName = $('#module option:selected').text();
		$("#nodeId").val(nodeId);
		$("#nodeName").val(nodeName);
		refreshData();
	}
	
	//工具按钮点击事件
	function showList(div){		
		//将当前ID赋到隐藏于中
		var	uuid = $(div).parent().attr('id');
		var	text = $(div).parent().children(".app-text").text();
		var	parentTId = $(div).parent().attr('parentTId');
		var	businessId = $(div).parent().attr('businessId');
		var	orgId = $(div).parent().attr('orgId');
		var	versionType = $(div).parent().attr('versionType');
		
		$("#templateId").val(uuid);
		$("#parentTId").val(parentTId);
		$("#businessId").val(businessId);
		$("#orgId").val(orgId);
		$("#versionType").val(versionType);
		
		var isSysAdmin = document.getElementById('isSysAdmin').value;
		if(isSysAdmin == 'true'){	//一级管理员

		}else{    //二级管理员
//			$('.liEdit').css('display','none');
//			$('.liDelete').css('display','none');
//			$('.liGo').css('display','none');
//			$('.liBack').css('display','none');
//			$('#toolList').css('height','225px');
		}

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
	
	//前移
	function goMove(){
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
			json.templateType = '2';
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
	function backMove(){
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
			json.templateType = '2';
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
	
	//新建定制表单或流程
	function createTemplate(){
		var templateType = $("#templateType").val();
		var nodeid = $("#nodeId").val();
		var title = '';
		var heightNum;
		var widthNum;
		if(templateType=="4"){
			title = '新建定制表单';
			heightNum = '550px';
    		widthNum = '50%';
		}else if(templateType=="5"){
			title = '新建定制流程';
			heightNum = '550px';
    		widthNum = '50%';
		}
		layer.open({
	    	id:'createTemplate',
			type : 2,//iframe 层			
			shade: [0.1, '#000'],
			title : [title],
			closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
			shadeClose: false, //开启遮罩关闭
			area : [ widthNum, heightNum ],
			content : '<%=request.getContextPath()%>/form/html5/admin/custom/formProcess/addFormProcessList.jsp?addType=add&parentId='+nodeid+'&type='+templateType+'',
			end	: function(){
				hideList();
				refreshData();
			}
		});
	}
	
	
	function editTemplate(){
		var templateType = $("#templateType").val();
		var nodeid = $("#nodeId").val();
		var templateId = $("#templateId").val();
		
		var parentTId = $("#parentTId").val();  //定制子版本时记录的父定制模板编码   为空代表是最基础的集团版
		var businessId = $("#businessId").val();  //定制子版本时业务编码
		var orgId = $("#orgId").val();	  //定制子版本时机构编码		
		var versionType = $("#versionType").val();  //版本类型  1:集团基础版本   2业务子版本  3机构子版本
		
		if(versionType == '1'){     //定制子版本时记录的父定制模板编码   为空代表是最基础的集团版
			var title = '';
			var heightNum;
			var widthNum;
			if(templateType=="4"){
				title = '编辑定制表单';
				heightNum = '60%';
	    		widthNum = '50%';
			}else if(templateType=="5"){
				title = '编辑定制流程';
				heightNum = '50%';
	    		widthNum = '50%';
			}			
			layer.open({
		    	id:'editTemplate',
				type : 2,//iframe 层			
				shade: [0.1, '#000'],
				title : [title],
				closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
				shadeClose: false, //开启遮罩关闭
				area : [ widthNum, heightNum ],
				content : '<%=path%>/formProcess/formProcess_loadEditTemplatePage.action?uuid='+templateId+'&parentId='+nodeid+'&type='+templateType+'',
				end	: function(){
					hideList();
					refreshData();
				}
			});
			
		}else{		
			var title = '';
			if(versionType == '2'){   //业务子版本
				title = '编辑业务子版本';
			}else{   //机构子版本
				title = '编辑机构子版本';
			}
			layer.open({
		    	id:'editTemplate',
				type : 2,//iframe 层			
				shade: [0.1, '#000'],
				title : [title],
				closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
				shadeClose: false, //开启遮罩关闭
				area : [ '50%', '60%' ],
				content : '<%=path%>/formProcess/formProcess_loadEditSubCustomPage.action?versionType='+versionType+'&uuid='+templateId+'&parentId='+nodeid+'&type='+templateType+'',
				end	: function(){
					hideList();
					refreshData();
				}
			});
		}
		
		
	}
	
	//删除数据
	function deleteData(){
		var templateId = $("#templateId").val();
		var templateType = $("#templateType").val();
		var json = {};
		json.nodeId = templateId;
		json.templateType = templateType;
		json.nodeType = 'template';
		Matrix.confirm('确定要删除吗？',function(value){
			if(true){
				$.ajax({
					type:'post',
					url:'<%=path %>/formProcess/formProcess_deleteNode.action',
					data:json,
					dataType:'json',
					success:function(data){
						if(data==true){
							hideList();
							refreshData();
							Matrix.success('删除成功！');
						}else{
							Matrix.warn('该定制下已有子版本，无法删除！');
						}
					}
				});
			}
		});
	}
	
	//返回目录界面
	function backList(){
		debugger;
		var levelType = $("#levelType").val();		
		var templateType = $("#templateType").val();
		//当前用户应用编码
		var tenantId = document.getElementById('tenantId').value;
		
		if(levelType == 0){   //当前层次子版本类型  0基础   1业务  2组织
			window.location.href = "<%=path%>/form/html5/admin/custom/formProcess/formProcessCustom.jsp?tenantId="+tenantId+"&templateType="+templateType;
		}else{
			var parentTemplUuid = $("#parentTemplUuid").val();
			window.location.href = "<%=path%>/form/html5/admin/custom/formProcess/formProcessList.jsp?tenantId="+tenantId+"&nodeId="+parentTemplUuid+"&templateType="+templateType;
		}
		
	}
	
	//点击进入表单或流程详细信息页面
	function clickForm(div,count){
		debugger;
		var json = $('#data').val();
		var data = JSON.parse(json)[count];
		var name = data.text;
		var templateType = $("#templateType").val();
		
		var nodeId = $("#nodeId").val();
		var templateId = div.id;
		templateId = templateId.substring(7,templateId.length);
		
		//进入之前判断是不是存在版本
		var json = {};
		json.mBizId = templateId;
		json.templateType = templateType;
		if(templateType == '4'){  //表单定制
			json.mid = data.formMid;
		}else if(templateType == '5'){  //流程定制
			json.mid = data.flowMid;
		}
		$.ajax({
			type:'post',
			url:'<%=path %>/formProcess/formProcess_isExistVersion.action',
			data:json,
			dataType:'json',
			success:function(res){
				var isExist = res.isExist;
				if(isExist){
					var contentUrl;
					if(templateType == '4'){  //表单定制
						var formMid = data.formMid;
						contentUrl = "<%=path%>/formProcess/formProcess_toFormDesignerTab.action?iframewindowid=formDesignTab&mBizId="+templateId+"&templateType="+templateType+"&nodeId="+nodeId+"&mid="+formMid+"&name="+name
					}else if(templateType == '5'){  //流程定制
						var flowMid = data.flowMid;
						contentUrl = "<%=path%>/formProcess/formProcess_toProcessDesignerTab.action?iframewindowid=processDesignTab&mBizId="+templateId+"&templateType="+templateType+"&nodeId="+nodeId+"&mid="+flowMid+"&name="+name
					}
					top.childWindow = window;
					top.layer.open({
						type:2,
						title:false,
						area:['100%','100%'],
						content:contentUrl
					});
				}else{     //不存在
					Matrix.warn('该定制没有版本，无法进入！');
				}
			}
		});		
	}
	
	//点击进入下一级定制
	function enterTemplate(div,count){
		//var json = $('#data').val();
		//var data = JSON.parse(json)[count];
		//var name = data.text;
		var templateType = $("#templateType").val();
		var nodeId = $("#nodeId").val();
		var templateId = div.id;
		templateId = templateId.substring(7,templateId.length);
		
		//进入下一级时，表单和流程定制校验父定制模板的最新版本表单有没有  且是否发布  
		//表单定制还要校验是否存在overWrite为true的可继承区域	
		var url = "<%=request.getContextPath()%>/formProcess/formProcess_checkPublishInherit.action";
		var jsonData = {};
		jsonData.templateType = templateType;
		jsonData.templateId = templateId;
		Matrix.sendRequest(url,jsonData,function(data){
			debugger;
			var result = isc.JSON.decode(data.data);			
			if(result.message!=null && result.message.trim().length>0){
				Matrix.warn(result.message);
			}else{
				$("#nodeId").val(templateId);
				
				hideList();
				refreshData();
			}
		});	
	}
	
	
	//添加业务子版本
	function addBusinessSub(){
		debugger;
		var templateType = $("#templateType").val();
		var nodeid = $("#nodeId").val();
		var parentBusId = $("#parentBusId").val();  //父业务编码
				
		var parentTemplUuid = $("#parentTemplUuid").val();  //父定制模板主键编码 
		var jsonData = {};
		jsonData.templateType = templateType;	
		jsonData.parentTemplUuid = parentTemplUuid;
		
		layer.open({
	    	id:'addBusinessSub',
			type : 2,//iframe 层			
			shade: [0.1, '#000'],
			title : ['新建业务子版本'],
			closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
			shadeClose: false, //开启遮罩关闭
			area : [ '50%', '60%' ],
			content : '<%=request.getContextPath()%>/form/html5/admin/custom/formProcess/addSubCustomList.jsp?addType=add&versionType=2&parentId='+nodeid+'&parentBusId='+parentBusId+'&type='+templateType+'',
			end	: function(){
				hideList();
				refreshData();
			}
		});
	}
	
	
	//添加机构子版本
	function addOrgSub(){
		var templateType = $("#templateType").val();
		var nodeid = $("#nodeId").val();
		var parentBusId = $("#parentBusId").val();  //父业务编码
		var parentOrgId = $("#parentOrgId").val();  //父机构编码
		
		//启用集团才能添加机构子版本
		var url = "<%=request.getContextPath()%>/formProcess/formProcess_checkGroupEnable.action";
		Matrix.sendRequest(url,null,function(data){
			debugger;
			var result = isc.JSON.decode(data.data);			
			if(result.message!=null && result.message.trim().length>0){
				Matrix.warn(result.message);
			}else{
				layer.open({
			    	id:'addBusinessSub',
					type : 2,//iframe 层			
					shade: [0.1, '#000'],
					title : ['新建机构子版本'],
					closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
					shadeClose: false, //开启遮罩关闭
					area : [ '50%', '60%' ],
					content : '<%=request.getContextPath()%>/form/html5/admin/custom/formProcess/addSubCustomList.jsp?addType=add&versionType=3&parentId='+nodeid+'&parentBusId='+parentBusId+'&parentOrgId='+parentOrgId+'&type='+templateType+'',
					end	: function(){
						hideList();
						refreshData();
					}
				});
			}
		});		
	}
	
	
	//记录iframe中的一级弹出窗口
	var iframeJs;
	
	function onassociatedFormClose(data){
		iframeJs.onassociatedFormClose(data);
	}
	
	function onassociatedProcessClose(data){
		iframeJs.onassociatedProcessClose(data);
	}
	
	function onauthorizeFormClose(data){
		iframeJs.onauthorizeFormClose(data);
	}
	
	var authUser = {};
	function onauthSetClose(data){
		iframeJs.onauthSetClose(data);
	}
	
</script>
</head>
<body>
	<div style="margin:0px;position:relative;width:100%;height:100%;">
		<input type="hidden" id="data" name="data">
		<!-- 当前模板ID -->
		<input type="hidden" id="templateId" name="templateId">
		<!-- 定制子版本时记录的父定制模板编码   为空代表是最基础的集团版-->
		<input type="hidden" id="parentTId" name="parentTId">
		<!-- 定制子版本时业务编码-->
		<input type="hidden" id="businessId" name="businessId">	
		<!-- 定制子版本时机构编码-->
		<input type="hidden" id="orgId" name="orgId">
		<!-- 版本类型  1:集团基础版本   2业务子版本  3机构子版本-->
		<input type="hidden" id="versionType" name="versionType">	
		<!-- 当前层次子版本类型  0基础   1业务  2组织-->	
		<input type="hidden" id="levelType" name="levelType">
		<!-- 上一层模板主键编码  用于返回-->	
		<input type="hidden" id="parentTemplUuid" name="parentTemplUuid">
		
		<input type="hidden" id="nodeName" name="nodeName" value="${param.nodeName}">
		<!-- 父节点ID -->
		<input type="hidden" id="nodeId" name="nodeId" value="${param.nodeId}">
		<input type="hidden" id="templateType" name="templateType" value="${param.templateType}">
		<!-- 是否是一级管理员 -->
		<input type="hidden" id="isSysAdmin" name="isSysAdmin">
		<!-- 是否是二级管理员 -->
		<input type="hidden" id="isSubAdmin" name="isSubAdmin">
		<!-- 是否是设计开发人员 -->
		<input type="hidden" id="isDesigner" name="isDesigner">
		<!-- 当前租户编码 -->
		<input type="hidden" id="tenantId" name="tenantId" value="${param.tenantId}">
		
		<!-- 上一层业务编码 -->
		<input type="hidden" id="parentBusId" name="parentBusId">
		<!-- 上一层机构编码 -->
		<input type="hidden" id="parentOrgId" name="parentOrgId">		
			
		<div tabindex="0" onblur="hideList();" id="toolList" style="z-index:999999;position:absolute;display: none;height:144px;width:160px;background:#fff;box-shadow:2px 2px 5px rgba(185,185,185,.3)">
			<ul>
				<li class="liEdit" style="height: 36px;line-height: 36px;font-size: 14px;padding-left: 10px;" onclick="editTemplate();">修改</li>
				<li class="liDelete" style="height: 36px;line-height: 36px;font-size: 14px;padding-left: 10px;" onclick="deleteData();">删除</li>
				<li class="liGo" style="height: 36px;line-height: 36px;font-size: 14px;padding-left: 10px;" onclick="goMove();">前移</li>
				<li class="liBack" style="height: 36px;line-height: 36px;font-size: 14px;padding-left: 10px;" onclick="backMove();">后移</li>
			</ul>
		</div>
		<div style="width: 100%;height: 100%;background: rgba(245,245,247,.9);overflow:auto">
			<div id="mainDiv" style="background: rgba(245,245,247,.9);width: 90%;height:100%;margin:auto;">
			</div>
		</div>
	</div>
</body>
</html>