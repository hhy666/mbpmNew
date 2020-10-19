<%@page import="com.matrix.app.MAppProperties"%>
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
    <title>单选人员页面</title>
    <link href='<%=path %>/resource/html5/css/matrix_runtime.css' rel="stylesheet"></link>
	<link href="<%=path %>/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%=path %>/css/themes/default/style.min.css" />
    <link href='<%=path %>/resource/html5/css/font-awesome.min.css' rel="stylesheet"></link>
	<link href='<%=path %>/resource/html5/css/skin/mCustom_<%=session.getAttribute("skin") %>.css' rel="stylesheet"></link>
	
	<script src="<%=path %>/resource/html5/js/jquery.min.js"></script>
	<script src="<%=path %>/resource/html5/js/bootstrap.min.js"></script>
	<script src="<%=path %>/resource/html5/js/jstree.min.js"></script>
	<script src="<%=path %>/resource/html5/js/layer.min.js"></script>
	<SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/js/validator.js'></SCRIPT>
	<script src='<%=path %>/resource/html5/js/matrix_runtime.js'></script>
    <style type="text/css">
    	body, ul{
		    margin: 0;
		    padding: 0;
		    font-size: 14px;
		}
		div, ul{
			box-sizing: border-box;
		}
		.main{
		    position: absolute;
		    height: calc(100% - 54px);
		    width: 100%;
		}
		.footer{
			vertical-align:middle;
			background: #F8F8F8;
			border-top:1px solid #e5e5e5;
			color:#fff;width:100%;
			position: fixed;
			bottom: 0px;
			padding: 14px 15px 15px;
			margin-bottom: 0; 
			text-align: right;
		}
		.select-base{
			position: relative;
			height: 100%;
			width: 100%;
		}
		 .select-pane {		   
		    position: absolute;
		    height: calc(100% - 40px);
		    left: 0;
		    bottom: 0;
		    right: 0;
		}
		.dep-pane,.role-pane,.person-pane{
			height: 100%;
		    overflow: hidden;
		}
		.select-tree{
			height: 50%;
			background:#fff;
			font-size: 12px;
			border: 1px #ccc solid;
			border-top: 0px;
			border-bottom: 0px;
			overflow:auto;
		}
		.pane-left{
			position: absolute;
			left: 0;
			top: 0;
			height: 100%;
		    width: 100%;
		}
		.pane-right{
			position: absolute;
		    right: 50px;
		    top: 0;
		    height: 100%;
		    width: calc((100% - 100px)/2);;
		}
		.dep-list,.role-list{
			height: calc(50% - 60px);
			//margin-top: 10px;
			border: 1px #ccc solid;
			border-top: 0px;
			border-bottom: 0px;
			overflow:auto;
		}
		.person-list{
			height: calc(100% - 30px);
			border: 1px #ccc solid;
			border-top: 0px;
			border-bottom: 0px;
			overflow:auto;
		}
		.select-member{
			height: 100%;
			width: 100%;
		}
		.select-member li {
		    cursor: pointer;
		    margin: 0 10px 0 10px;
		    white-space: nowrap;
		    line-height: 24px;
		    list-style-type: none
		}
		
    	.jstree-default .jstree-node-online {
		    background: url("<%=path %>/office/html5/image/openfoldericon.png") no-repeat #fff;
		    background-position: 50% 50%;
		    background-size: auto;
		}
		.jstree-default .jstree-node-offline {
		    background: url("<%=path %>/office/html5/image/foldericon.png") no-repeat #fff;
		    background-position: 50% 50%;
		    background-size: auto;
		}
    	.jstree-default .jstree-hovered{
			 background:none;
		 	 border-radius:0px;
		     color: blue;
		   	 text-decoration: underline;
		 	box-shadow:non
		}
		.jstree-default .jstree-clicked {
		    background: #DDDDDD;
		    border-radius: 0px;
		    box-shadow: none;
		}
		.jstree-anchor {
		    padding: 0 4px 0 0px;
		}
		.nav-tabs > li.active > a,
		.nav-tabs > li.active > a:hover,
		.nav-tabs > li.active > a:focus {
		   color: #fff;
		   cursor: default;
		   background: url("<%=path%>/office/html5/image/current.png")bottom center no-repeat #57b4e7;
		   border-bottom-color: transparent;
		}
		.nav-tabs > li > a:hover {
		  border: none;
		}
		.nav-tabs>li>a {
		    margin-right: 0px;
		    line-height: 27px;
		    border: none;
		    border-radius: 0px;
		}
		.nav > li > a:hover,
		.nav > li > a:focus {
		  text-decoration: none;
		  background-color: #FAFAFA;
		      color: #8A8A8A;
		}
		.nav>li>a {
		    position: relative;
		    display: block;
		    padding: 0px 8px;
		    text-align: center;
		        color: #8A8A8A;
		}
		.nav-tabs>li {
		    font-family: Microsoft YaHei,SimSun,Arial,Helvetica,sans-serif;
		    min-width: 70px;
		    font-size:12px;
		}
		.nav-tabs>li.active>a, .nav-tabs>li.active>a:hover, .nav-tabs>li.active>a:focus {
		
		    border: 1px solid transparent;
		  
		}
		.select_selected:hover {
		    background-position: -128px -256px;
		}
		.select_selected {
		    display: inline-block;
		    width: 32px;
		    height: 32px;
		    vertical-align: middle;
		    background: url("<%=path%>/office/html5/image/icon32.png") no-repeat left top;
		    background-position: 0 -256px;
		    cursor: pointer;
		}
		.select_unselect:hover {
		    background-position: -160px -256px;
		}
		.select_unselect {
		    display: inline-block;
		    width: 32px;
		    height: 32px;
		    vertical-align: middle;
		    background: url("<%=path%>/office/html5/image/icon32.png") no-repeat left top;
		    background-position: -32px -256px;
		    cursor: pointer;
		}
		.form-control {
	   		border-radius: 0;
	 	} 	
		::-webkit-scrollbar {    
		    width:4px;  
		    height:4px;   
		}  
    </style>
    
    <script type="text/javascript">
		$(function() {
		    //监听操作按钮 
		    monitorButton();  
		    
		    //确定
        	 $("#confirm").click(function(){
        		 var data = {};
           	     var ids = "";
           	     var names = "";
                 var opt = $("#opt").val();
                 if("dep"==opt || ""==opt){     //部门
       	 			var length = $('#select001').find('li.changeColor').length;
       	 		    if(length==0){
 				       layer.alert("请选择数据！",{icon: 2});//icon1 对勾 2x
 				       return false;
 			        }
   	     			ids = $('#select001').find('li.changeColor').attr("id");
   	     			names = $('#select001').find('li.changeColor').text();
   	     			
        		}else if("role"==opt){    //角色  
        			var length = $('#select002').find('li.changeColor').length;
       	 		    if(length==0){
 				       layer.alert("请选择数据！",{icon: 2});//icon1 对勾 2x
 				       return false;
 			        }
   	     			ids = $('#select002').find('li.changeColor').attr("id");
   	     			names = $('#select002').find('li.changeColor').text();
			   	     
        		}else if("person"==opt){     //人员
        			var length = $('#select003').find('li.changeColor').length;
       	 		    if(length==0){
 				       layer.alert("请选择数据！",{icon: 2});//icon1 对勾 2x
 				       return false;
 			        }
   	     			ids = $('#select003').find('li.changeColor').attr("id");
   	     			names = $('#select003').find('li.changeColor').text();
        		}
                 if(names.indexOf("(")!=-1 && names.endsWith(")")){
        	    	 names = names.substring(0,names.indexOf("("));
        	     }    
                		
	            data["ids"]=ids;
	            data["names"]=names;
	            data["clientId"]="${param.clientId}";
	            data["id"]="${param.id}";
	     	    parent.closeData = data;//父页面弹出时，给父页面赋值，子页面自己取值
	     	    Matrix.closeWindow(data);
            });
		    
        	 //取消
			 $("#cancel").click(function(){
				 Matrix.closeLayerWindow();
        	 });
        	 
			 //监听标签页DIV点击切换事件
			 $('#dep').click(function(){
				 document.getElementById('opt').value=this.id;
				 $('.dep-pane').css('display','block'); 
	  			 $('.role-pane').css('display','none'); 
	  			 $('.person-pane').css('display','none'); 		  			
	  			 $('#personResult').css('display','none'); 
    			 $('#personList').css('height','100%'); 			
	    		 $('#personList').css('border-top','1px #dadada solid'); 	
	    		 $("#dep").addClass("select");
	 			 $("#role").removeClass("select");
	 			 $("#person").removeClass("select");
	 			 
	 			 document.getElementById('advancedSearch_div').style.display = 'none';
				 $('#advancedSearch').css('-webkit-box-shadow',''); 
				 $('#advancedSearch').css('box-shadow','');
			 });
        	 
			 $('#role').click(function(){
				 document.getElementById('opt').value=this.id;
				 $('.role-pane').css('display','block'); 
   				 $('.dep-pane').css('display','none'); 
   				 $('.person-pane').css('display','none');
   				 $('#personResult').css('display','none'); 
    			 $('#personList').css('height','100%');
    			 $('#personList').css('border-top','1px #dadada solid'); 
    			 $("#role").addClass("select");
	 			 $("#dep").removeClass("select");
	 			 $("#person").removeClass("select");	 
	 			 
	 			 document.getElementById('advancedSearch_div').style.display = 'none';
				 $('#advancedSearch').css('-webkit-box-shadow',''); 
				 $('#advancedSearch').css('box-shadow','');
			 }); 
			 
			 $('#person').click(function(){
				 document.getElementById('opt').value=this.id;
				 $('.person-pane').css('display','block'); 
    			 $('.dep-pane').css('display','none'); 
    			 $('.role-pane').css('display','none'); 
    			 $('#personResult').css('display',''); 
    			 $('#personList').css('height','calc(100% - 30px)'); 
    			 $('#personList').css('border-top','0px'); 
    			 $("#person").addClass("select");
	 			 $("#dep").removeClass("select");
	 			 $("#role").removeClass("select");
			 });
			 
			 var deptRootCode = $('#deptRootCode').val();
        	 var tree = $('#dep_container').jstree({
					'core' : {
					'multiple' : false,
					// 'dblclick_toggle': false   ,
		    		'data' : {
							"url" :"<%=path %>/select/SelectAction_getDepTree.action",
							"data" : function(node) {
								return {
									"root" : node.id ==="#"?"0":node.id,
									"deptRootCode" : deptRootCode
								};
							},
							"dataType" : "json",
							"type":"post"
						},
						'themes' : {
							'icons' : true
						}
					},
					"plugins" : [ "themes", "json_data", "crrm","wholerow"],
					'contextmenu' : false
			  });
					
			  $('#dep_container').on('select_node.jstree', function(e, datas) {  
	            r = [];  
	            var i, j;  
	            for (i = 0, j = datas.selected.length; i < j; i++) {  
	               var node = datas.instance.get_node(datas.selected[i]);  
	               //datas.instance.get_node(datas.selected[i],true).attr('aria-selected', true).children('.jstree-anchor')[0].focus();
	               var text = node.text;  
	               var id = node.id;
	               document.getElementById('depId').value = id;
	               $.ajax({  
		                url: "<%=path %>/select/SelectAction_getPersonByDepId.action?depId="+$("#depId").val(),    //后台webservice里的方法名称  
		                type: "post",  
		                dataType: "json",  
		                contentType: "application/json",  
		                async:false, 
		                success: function (datass) {
			                if(datass!=null&&datass!=""){
			                    var arr = datass.aaData;  
			                    if(arr!=null&&arr.length>0){
			                       var listring = "";
				                   for (var i in arr) {  
				                        var jsonObj =arr[i];  						                     
				                        listring += "<li id=\"" + jsonObj.id + "\" >" + jsonObj.name + "</li>";  
				                   }  			                   
				                   $("#select001").html(listring);  
			                    }else {
			                    	//查不到数据
			                     	$("#select001").html("");  						                    
			                    }
			                }
	               		},  
	              	    error: function (msg) {  
	                  	   layer.msg("出错了！");  
	               	}  
	           	});  
	            }  
	        }) ;
	     
	       //展开时候图标设置
		    $('#dep_container').on('open_node.jstree', function(e, datas) {  
			     var nodeId = datas.node.id; 
			     $('#dep_container').jstree(true).set_icon(nodeId, "jstree-node-online");
			    // tree.set_icon(node,"jstree-node-offline");
		    });
		    //收拢时候图标设置
		    $('#dep_container').on('close_node.jstree', function(e, datas) {  
			     var nodeId = datas.node.id; 
			     $('#dep_container').jstree(true).set_icon(nodeId, "jstree-node-offline");
			    // tree.set_icon(node,"jstree-node-offline");
		    });		 
		    
        	var tree = $('#role_container').jstree({
					'core' : {
					'multiple' : false,
					// 'dblclick_toggle': false   ,
		    		'data' : {
							"url" : "<%=path %>/select/SelectAction_getRoleTree.action",
							"data" : function(node) {
								return {
								"root" : node.id ==="#"?"0":node.id
								};
							},
							"dataType" : "json",
							"type":"post"
						},
						'themes' : {
							'icons' : true
						}
					},
					"plugins" : [ "themes", "json_data", "crrm","wholerow"],
					'contextmenu' : false
			 });
        	 $('#role_container').on('select_node.jstree', function(e, datas) {  
	               r = [];  
	               var i, j;  
	               for (i = 0, j = datas.selected.length; i < j; i++) {  
	                   var node = datas.instance.get_node(datas.selected[i]);  
	                   //datas.instance.get_node(datas.selected[i],true).attr('aria-selected', true).children('.jstree-anchor')[0].focus();
	                   var text = node.text;  
	                   var id = node.id;
	                   document.getElementById('roleId').value = id;
	                   $.ajax({  
		                  url: "<%=path %>/select/SelectAction_getPersonByRoleId.action?roleId="+$("#roleId").val(),    //后台webservice里的方法名称  
		                  type: "post",  
		                  dataType: "json",  
		                  contentType: "application/json",  
		                  async:false, 
		                  success: function (datass) {
			                  if(datass!=null&&datass!=""){
		                   		 var arr = datass.aaData;  
		                    	 if(arr!=null&&arr.length>0){		                    	
		                       		var listring = "";
				                    for (var i in arr) {  
				                        var jsonObj =arr[i]; 
				                        listring += "<li id=\"" + jsonObj.id + "\" >" + jsonObj.name + "</li>";  
				                    }  
			                        $("#select002").html(listring);  
			                     }else{
			                    	$("#select002").html(""); 
			                     }
		                      }
	                	},  
						error: function (msg) {  
	                    	layer.msg("出错了！");  
	                	}  
	            	 });  
	               } 
	          }) ;
		      
	           //展开时候图标设置
			   $('#role_container').on('open_node.jstree', function(e, datas) {  
			       var nodeId = datas.node.id; 
			       $('#role_container').jstree(true).set_icon(nodeId, "jstree-node-online");
			       //tree.set_icon(node,"jstree-node-offline");
			   });
			    //收拢时候图标设置
			   $('#role_container').on('close_node.jstree', function(e, datas) {  
			       var nodeId = datas.node.id; 
			       $('#role_container').jstree(true).set_icon(nodeId, "jstree-node-offline");
			       //tree.set_icon(node,"jstree-node-offline");
			   });	  
	    });
		
		var recordId;  //记录当前选中的区域id
		var ctrl = false;  //记录ctrl键
		//监听相关操作按钮
		function monitorButton(){
			$(document).keydown(function(event){  
				if(event.ctrlKey){  //按下了ctrl键
					ctrl=true;
				}
				if(event.ctrlKey && event.keyCode == 65){   //按下了ctrl+a组合键
					$('.changeColor').removeClass("changeColor");
					$("#"+recordId+" li").addClass("changeColor");
				} 
			}).keyup(function(){
				ctrl=false;
			});
				
			$(".select-member").on("click","li",function(){
			    if(ctrl){   //按下了ctrl键连选
	            	$(this).addClass("changeColor");
	            }else{
	            	$(this).addClass("changeColor").siblings().removeClass("changeColor");			 
	            }
			    recordId = $(this).parent().attr('id');
	 		});
			 
			//双击确定
       		$("#select001").dblclick(function(){ 
       			$("#confirm").click();
            });
       	
            $("#select002").dblclick(function(){ 
            	$("#confirm").click();
        	});
            
            $("#select003").dblclick(function(){ 
            	$("#confirm").click();
        	});
		}
		
		function searchItems(){
			var userName;
			if($("#q").val() == ''){
				layer.msg('请输入查询关键字！', {icon: 2,time: 2000});  //2s后自动关闭
				return;
			}else{
				userName = $("#q").val();
			}
			var deptRootCode = $('#deptRootCode').val();
		    $.ajax({  
	            url: "<%=path %>/select/SelectAction_getAllPerson.action",    //后台webservice里的方法名称  
	            type: "post",  
	            dataType: "json",  
	            data: {"operation" : 'userTab', "userName" : userName, "deptRootCode" : deptRootCode}, 
	            //contentType: "application/json",  
	            async:false, 
	            success: function (datass) {
	            if(datass!=null&&datass!=""){
	                var arr = datass.aaData;  
	                if(arr!=null&&arr.length>0){
	                     //有人员数据
	                    var listring = "";
	                    for (var i in arr) {  
	                        var jsonObj =arr[i];  	                     
	                        listring += "<li id=\"" + jsonObj.id + "\" >" + jsonObj.name + "</li>";                      
	                    }                    
	                     $("#select003").html(listring);  
	                }else{
	                    //无人员数据
	                     $("#select003").html("");
	                }  
	            }
	            },  
	            error: function (msg) {  
	                layer.msg("出错了！");  
	            }  
        	}); 
		}
		
		//根据部门名称搜索
		function searchDept(){
			//先清空人员
			$("#select001").html("");  	
			Matrix.showMask2();
			var depName = $('#depKeyWord').val();
			if(depName == ''){
				Matrix.hideMask2();
				$('#dep_container').css('display','block');
				$('#depResult').css('display','none');
				return;
			}
			$('#dep_container').css('display','none');
			$('#depResult').css('display','block');
			
			var deptRootCode = $('#deptRootCode').val();
			$.ajax({  
	            url: "<%=path %>/select/SelectAction_getAllDept.action",  
	            type: "post",  
	            dataType: "json",  
	            data: {"depName" : depName, "deptRootCode" : deptRootCode}, 
	            async:false, 
	            success: function (datass) {
	            if(datass!=null&&datass!=""){
	                var arr = datass.depData;  
	                if(arr!=null&&arr.length>0){
	                     //有部门数据
	                    var listring = "";
	                    for (var i in arr) {  
	                        var jsonObj =arr[i];  	                     
	                        listring += "<li id=\"" + jsonObj.depId + "\" >" + jsonObj.depName + "</li>";                      
	                    }                    
	                    $("#depSelect").html(listring);  
	                     
	                    $("#depSelect").on("click","li",function(){         			   
	         	            $(this).addClass("changeColor").siblings().removeClass("changeColor");
	         	            
	         	            var depId = $("#depSelect").children("li.changeColor").attr('id');
	         	            document.getElementById('depId').value = depId;
	         	            $.ajax({  
		   		                url: "<%=path %>/select/SelectAction_getPersonByDepId.action?depId="+depId,
		   		                type: "post",  
		   		                dataType: "json",  
		   		                contentType: "application/json",  
		   		                async:false, 
		   		                success: function (datass) {
		   			                if(datass!=null&&datass!=""){
		   			                    var arr = datass.aaData;  
		   			                    if(arr!=null&&arr.length>0){
		   			                       var listring = "";
		   				                   for (var i in arr) {  
		   				                        var jsonObj =arr[i];  						                     
		   				                        listring += "<li id=\"" + jsonObj.id + "\" >" + jsonObj.name + "</li>";  
		   				                   }  			                   
		   				                   $("#select001").html(listring);  
		   			                    }else {
		   			                    	//查不到数据
		   			                     	$("#select001").html("");  						                    
		   			                    }
		   			                }
		   	               		},  
		   	              	    error: function (msg) {  
		   	                  	   layer.msg("出错了！");  
		   	               		}  
		   	           		});  
	         	 		});
	                     
	                }else{
	                    //无部门数据
	                     $("#depSelect").html("");
	                } 
	                Matrix.hideMask2();
	            }
	            },  
	            error: function (msg) {  
	            	Matrix.hideMask2();
	                layer.msg("出错了！");  
	            }  
        	}); 
		}
		
		//根据角色名称搜索
		function searchRole(){
			//先清空人员
			$("#select002").html("");  
			Matrix.showMask2();
			var roleName = $('#roleKeyWord').val();
			if(roleName == ''){
				Matrix.hideMask2();
				$('#role_container').css('display','block');
				$('#roleResult').css('display','none');
				return;
			}
			$('#role_container').css('display','none');
			$('#roleResult').css('display','block');
			
			$.ajax({  
	            url: "<%=path %>/select/SelectAction_getAllRole.action",  
	            type: "post",  
	            dataType: "json",  
	            data: {"roleName" : roleName}, 
	            async:false, 
	            success: function (datass) {
	            if(datass!=null&&datass!=""){
	                var arr = datass.roleData;  
	                if(arr!=null&&arr.length>0){
	                     //有角色数据
	                    var listring = "";
	                    for (var i in arr) {  
	                        var jsonObj =arr[i];  	                     
	                        listring += "<li id=\"" + jsonObj.roleId + "\" >" + jsonObj.roleName + "</li>";                      
	                    }                    
	                     $("#roleSelect").html(listring);  
	                     
	                     $("#roleSelect").on("click","li",function(){    
	                    	 $(this).addClass("changeColor").siblings().removeClass("changeColor");
	                    	 
	                    	 var roleId = $("#roleSelect").children("li.changeColor").attr('id');
	                    	 document.getElementById('roleId').value = roleId;
	                    	 $.ajax({  
				                  url: "<%=path %>/select/SelectAction_getPersonByRoleId.action?roleId="+roleId,
				                  type: "post",  
				                  dataType: "json",  
				                  contentType: "application/json",  
				                  async:false, 
				                  success: function (datass) {
					                  if(datass!=null&&datass!=""){
				                   		 var arr = datass.aaData;  
				                    	 if(arr!=null&&arr.length>0){		                    	
				                       		var listring = "";
						                    for (var i in arr) {  
						                        var jsonObj =arr[i]; 
						                        listring += "<li id=\"" + jsonObj.id + "\" >" + jsonObj.name + "</li>";  
						                    }  
					                        $("#select002").html(listring);  
					                     }else{
					                    	$("#select002").html(""); 
					                     }
				                      }
			                	},  
								error: function (msg) {  
			                    	layer.msg("出错了！");  
			                	}  
		            	 });   	                    	 
	                     });	                     
	                }else{
	                    //无角色数据
	                     $("#roleSelect").html("");
	                } 
	                Matrix.hideMask2();
	            }
	            },  
	            error: function (msg) {  
	            	Matrix.hideMask2();
	                layer.msg("出错了！");  
	            }  
        	}); 
		}
		
		//部门下用户根据关键字查询用户
		function searchUserByDep(){
			Matrix.showMask2();
			
			var userName = $("#userKeyWordByDep").val();
			if(userName == ''){
				Matrix.hideMask2();
				layer.msg('请输入查询关键字！', {icon: 2,time: 2000});  //2s后自动关闭
				return;
			}
			var depId = $("#depId").val();
		    $.ajax({  
	            url: "<%=path %>/select/SelectAction_getAllPerson.action",    //后台webservice里的方法名称  
	            type: "post",  
	            dataType: "json",  
	            data: {"operation" : 'depTab', "userName" : userName, "depId" : depId}, 
	            async:false, 
	            success: function (datass) {
	            if(datass!=null&&datass!=""){
	                var arr = datass.aaData;  
	                if(arr!=null&&arr.length>0){
	                     //有人员数据
	                    var listring = "";
	                    for (var i in arr) {  
	                        var jsonObj =arr[i];  	                     
	                        listring += "<li id=\"" + jsonObj.id + "\" >" + jsonObj.name + "</li>";                      
	                    }                    
	                     $("#select001").html(listring);  
	                }else{
	                    //无人员数据
	                     $("#select001").html("");
	                } 
	                Matrix.hideMask2();
	            }
	            },  
	            error: function (msg) {  
	            	Matrix.hideMask2();
	                layer.msg("出错了！");  
	            }  
        	}); 
		}
		
		//角色下用户根据关键字查询用户
		function searchUserByRole(){
			Matrix.showMask2();
			
			var userName = $("#userKeyWordByRole").val();
			if(userName == ''){
				Matrix.hideMask2();
				layer.msg('请输入查询关键字！', {icon: 2,time: 2000});  //2s后自动关闭
				return;
			}
			var roleId = $("#roleId").val();
		    $.ajax({  
	            url: "<%=path %>/select/SelectAction_getAllPerson.action",    //后台webservice里的方法名称  
	            type: "post",  
	            dataType: "json",  
	            data: {"operation" : 'roleTab', "userName" : userName, "roleId" : roleId}, 
	            async:false, 
	            success: function (datass) {
	            if(datass!=null&&datass!=""){
	                var arr = datass.aaData;  
	                if(arr!=null&&arr.length>0){
	                     //有人员数据
	                    var listring = "";
	                    for (var i in arr) {  
	                        var jsonObj =arr[i];  	                     
	                        listring += "<li id=\"" + jsonObj.id + "\" >" + jsonObj.name + "</li>";                      
	                    }                    
	                     $("#select002").html(listring);  
	                }else{
	                    //无人员数据
	                     $("#select002").html("");
	                } 
	                Matrix.hideMask2();
	            }
	            },  
	            error: function (msg) {  
	            	Matrix.hideMask2();
	                layer.msg("出错了！");  
	            }  
        	}); 
		}
		
		//高级搜索
		function advancedSearch(){
			$('.person-pane').css('display','block'); 
			$('.dep-pane').css('display','none'); 
			$('.role-pane').css('display','none'); 
			$('#personResult').css('display',''); 
			$('#personList').css('height','calc(100% - 30px)'); 
			$("#person").addClass("select");
 			$("#dep").removeClass("select");
 			$("#role").removeClass("select");
			
 			document.getElementById('opt').value='person';
			if(document.getElementById('advancedSearch_div').style.display == 'none'){
				document.getElementById('advancedSearch_div').style.display = 'block';
				$('#advancedSearch').css('-webkit-box-shadow','0 1px 5px 1px #dadada'); 
				$('#advancedSearch').css('box-shadow','0 1px 5px 1px #dadada');
			}else{
				document.getElementById('advancedSearch_div').style.display = 'none';
				$('#advancedSearch').css('-webkit-box-shadow',''); 
				$('#advancedSearch').css('box-shadow','');
				
			}
		}
		
		//搜索
		function search(){			
			 var depName = document.getElementById('depName').value;
			 var roleName = document.getElementById('roleName').value;
			 var userName = document.getElementById('userName').value;
			 var userNo = document.getElementById('userNo').value;
			 
			 if(depName == '' && roleName == '' && userName == '' && userNo == ''){
				  Matrix.hideMask2();
				  layer.msg('请至少输入一个选项的查询关键字！', {icon: 2,time: 2000});  //2s后自动关闭
				  return;
			 }
			 
			 var deptRootCode = $('#deptRootCode').val();
			 $.ajax({  
		            url: "<%=path %>/select/SelectAction_advancedSearchUsers.action",
		            type: "post",  
		            dataType: "json",  
		            data: {"depName" : depName, "roleName" : roleName, "userName" : userName, "userNo" : userNo, "deptRootCode" : deptRootCode},   
		            async:false, 
		            success: function (datass) {
		            if(datass!=null&&datass!=""){
		                var arr = datass.userData;  
		                if(arr!=null&&arr.length>0){
		                     //有人员数据
		                    var listring = "";
		                    for (var i in arr) {  
		                        var jsonObj =arr[i];  	                     
		                        listring += "<li id=\"" + jsonObj.id + "\" >" + jsonObj.name + "</li>";                      
		                    }                    
		                     $("#select003").html(listring);  
		                }else{
		                    //无人员数据
		                     $("#select003").html("");
		                } 
		                document.getElementById('advancedSearch_div').style.display = 'none';
		    			$('#advancedSearch').css('-webkit-box-shadow',''); 
		    			$('#advancedSearch').css('box-shadow','');
		    			
		                Matrix.hideMask2();
		            }
		            },  
		            error: function (msg) {  
		            	Matrix.hideMask2();
		                layer.msg("出错了！");  
		            }  
	        }); 
		}
		
		//重置
		function reset(){
			document.getElementById('depName').value = '';
			document.getElementById('roleName').value = '';
			document.getElementById('userName').value = '';
			document.getElementById('userNo').value = '';
		}
		//取消
		function cancel(){
			document.getElementById('advancedSearch_div').style.display = 'none';
			$('#advancedSearch').css('-webkit-box-shadow',''); 
			$('#advancedSearch').css('box-shadow','');
		}
		
	</script>
</head>  
<body style="background:#FAFAFA;color:#000000;font-size:12px;">
	<input type="hidden" id="opt" name="opt"/>
	<input type="hidden" id="depId" name="depId"/>
	<input type="hidden" id="roleId" name="roleId"/>
	<!-- URL指定部门根编码查询 -->
	<input type="hidden" id="deptRootCode" name="deptRootCode" value="${param.deptRootCode }"/>
	
	<div id="matrixMask" name="matrixMask" class="matrixMask" style="width: 100%; height: 100%; position: absolute;top: 1;left: 1;z-index: 9999999999999;display: none;"> </div>
	<div class="main">
		<div class="select-base">
			<div class="select-menu">
				<div class="select-btn select" id="dep" data-i18n-text="部门">部门</div>
				<div class="select-btn" id="role" data-i18n-text="角色">角色</div>
				<div class="select-btn" id="person" data-i18n-text="人员">人员</div>
				<div class="x-btn cancel-btn" id="advancedSearch" onclick="advancedSearch();" style="position: absolute;right: 0px;top: 3px;font-size: 12px;padding: 0 10px;">
					   <span data-i18n-text="高级搜索">高级搜索</span>
				</div>
			</div>
			<div class="select-pane">
				<div class="pane-left">
					<!-- 部门区域 -->
					<div class="dep-pane" style="display: block;">					
						<div id="depSearch" class="input-group">							
							<input id="depKeyWord" name="depKeyWord" type="text" class="form-control" style="height:30px;" onkeydown="if(event.keyCode == 13)searchDept()" placeholder="请输入部门名称" data-i18n-placeholder="请输入部门名称">
					        <span class="input-group-addon addon-udSelect udSelect" onclick="searchDept();"><i class="fa fa-search"></i></span>
			            </div>
						<div id="dep_container" class="select-tree"></div>
						<div id="depResult" class="select-tree" style="display: none">
							<ul class="select-member" id="depSelect"></ul>        
						</div>
						<div class="input-group">							
							<input id="userKeyWordByDep" name="userKeyWordByDep" type="text" class="form-control" style="height:30px;" onkeydown="if(event.keyCode == 13)searchUserByDep()" placeholder="请输入用户名称或工号" data-i18n-placeholder="请输入用户名称或工号">
					        <span class="input-group-addon addon-udSelect udSelect" onclick="searchUserByDep();"><i class="fa fa-search"></i></span>
			            </div>
						<div id="select001_div" class="dep-list"> 						             
	                        <ul class="select-member" id="select001"></ul>                                                      
	 					</div>
					</div>						
	 				<!-- 角色区域  -->
	 				<div class="role-pane" style="display: none;">
	 					<div id="roleSearch" class="input-group">							
							<input id="roleKeyWord" name="roleKeyWord" type="text" class="form-control" style="height:30px;" onkeydown="if(event.keyCode == 13)searchRole()" placeholder="请输入角色名称" data-i18n-placeholder="请输入角色名称">
					        <span class="input-group-addon addon-udSelect udSelect" onclick="searchRole();"><i class="fa fa-search"></i></span>
			            </div>
	 					<div id="role_container" class="select-tree"></div>
	 					<div id="roleResult" class="select-tree" style="display: none">
							<ul class="select-member" id="roleSelect"></ul>        
						</div>
						<div class="input-group">							
							<input id="userKeyWordByRole" name="userKeyWordByRole" type="text" class="form-control" style="height:30px;" onkeydown="if(event.keyCode == 13)searchUserByRole()" placeholder="请输入用户名称或工号" data-i18n-placeholder="请输入人员名称或工号">
					        <span class="input-group-addon addon-udSelect udSelect" onclick="searchUserByRole();"><i class="fa fa-search"></i></span>
			            </div>
						<div id="select002_div" class="role-list"> 
						   <ul class="select-member" id="select002"></ul>                
						</div>	
					</div>
					<!-- 人员区域 -->	
					<div class="person-pane" style="display: none;">
						<div class="input-group">	
 							<input id="q" name="q" type="text" class="form-control" style="height:30px;" onkeydown="if(event.keyCode == 13)searchItems()" placeholder="请输入用户名称或工号" data-i18n-placeholder="请输入用户名称或工号">
					        <span class="input-group-addon addon-udSelect udSelect" onclick="searchItems();"><i class="fa fa-search"></i></span>												
			            </div>
			            <!-- 高级搜索人员区域 -->	
			            <div id="advancedSearch_div" style="position: absolute;z-index: 99;top: 0px;left: 0px;width: 100%;border: 1px solid #dadada;background: #fff;display: none;">				
					 			<div style="display: block;width: 100%;padding: 0 20px 0 20px;">
					 				<div style="min-height: 30px;padding-top: 8px;padding-bottom: 8px;-webkit-box-sizing: content-box;box-sizing: content-box;">
					 					<div style="display: block;width: 25%;float: left;">
					 						<div title="部门名称" data-i18n-title="部门名称" data-i18n-text="部门名称" style="width: 100%;line-height: 30px;">部门名称：</div>
					 					</div>
					 					<div style="display: block;width: 75%;float: left;">
					 						<input type="text" class="form-control" id="depName" name="depName" style="height:28px;">
					 					</div>
					 				</div>
					 				<div style="min-height: 30px;padding-top: 8px;padding-bottom: 8px;-webkit-box-sizing: content-box;box-sizing: content-box;">
					 					<div style="display: block;width: 25%;float: left;">
					 						<div title="角色名称" data-i18n-title="角色名称" data-i18n-text="角色名称" style="width: 100%;line-height: 30px;">角色名称：</div>
					 					</div>
					 					<div style="display: block;width: 75%;float: left;">
					 						<input type="text" class="form-control" id="roleName" name="roleName" style="height:28px;">
					 					</div>
					 				</div>
					 				<div style="min-height: 30px;padding-top: 8px;padding-bottom: 8px;-webkit-box-sizing: content-box;box-sizing: content-box;">
					 					<div style="display: block;width: 25%;float: left;">
					 						<div title="用户名称" data-i18n-title="用户名称" data-i18n-text="用户名称" style="width: 100%;line-height: 30px;">用户名称：</div>
					 					</div>
					 					<div style="display: block;width: 75%;float: left;">
					 						<input type="text" class="form-control" id="userName" name="userName" style="height:28px;">
					 					</div>
					 				</div>
					 				<div style="min-height: 30px;padding-top: 8px;padding-bottom: 8px;-webkit-box-sizing: content-box;box-sizing: content-box;">
					 					<div style="display: block;width: 25%;float: left;">
					 						<div title="用户工号" data-i18n-title="用户工号" data-i18n-text="用户工号" style="width: 100%;line-height: 30px;">用户工号：</div>
					 					</div>
					 					<div style="display: block;width: 75%;float: left;">
					 						<input type="text" class="form-control" id="userNo" name="userNo" style="height:28px;">
					 					</div>
					 				</div>
					 			</div>
						 		<div style="padding: 10px 0;text-align: center;border-top: 1px solid #dadada;">
						 			<div class="x-btn ok-btn" onclick="search();" style="border-radius: 3px;">
										<span data-i18n-text="搜索">搜索</span>
									</div>	
									<div class="x-btn ok-btn" onclick="reset();" style="margin-left: 15px;border-radius: 3px;">
										<span data-i18n-text="重置">重置</span>
									</div>
									<div class="x-btn cancel-btn" onclick="cancel();" style="margin-left: 15px;border-radius: 3px;">
										<span data-i18n-text="取消">取消</span>
									</div>
						 		</div>
						 </div>
						 <!-- 搜索人员结果区域 -->	
						<div id="person_container" class="person-list">
							<ul class="select-member" id="select003"></ul>         
						</div>	
					</div>
				</div>		
			</div>
		</div>
	</div>
	<div class="cmdLayout">
		<button id="confirm" class="x-btn ok-btn" type="button" data-i18n-text="确定">确定</button>
		<button id="cancel" class="x-btn cancel-btn" type="button" style="margin-left:5px;" data-i18n-text="取消">取消</button>
	</div>
	
	<!-- 国际化开始 -->
    <SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/js/jquery.i18n.properties.js'></SCRIPT>
    <SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/lang/matrix_lang.js'></SCRIPT>
	<SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/js/matrix_dialog.js'></SCRIPT>
    <!-- 国际化结束 -->
</body>
</html>
