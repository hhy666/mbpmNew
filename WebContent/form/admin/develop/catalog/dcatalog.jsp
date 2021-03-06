<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

    
    <head>
        <meta http-equiv="pragma" content="no-cache">
        <meta http-equiv="cache-control" content="no-cache">
        <meta http-equiv="expires" content="0">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      	<title>
    		Matrix Form 控制台
        </title>
        <jsp:include page="/form/admin/common/taglib.jsp"/>
		<jsp:include page="/form/admin/common/resource.jsp"/>
		<script type="text/javascript">
		


		function forwardPage(node,url){
			var src = handTreeNodeHref(node,url);
			src = "<%=request.getContextPath()%>"+"/"+src;
			Matrix.getMatrixComponentById("horizontalContainer0Panel1").setContentsURL(src);
		}
		
		//刷新节点
		function refreshNode(target){
			var refreshNode = document.getElementById('refreshNode');
			refreshNode.value = "true";
			Matrix.refreshTreeNode(target);
			refreshNode.value = "";
		}
		
		//表单授权
		function  formAuthority(target){
			var formUuid = target.id;
			var modulePath = target.modulePath;
			
			var url ="<%=request.getContextPath()%>/security/formSecurity_loadSecurityIndex.action?formUuid="+formUuid+"&modulePath="+modulePath;
			MDialogAuth.initSrc = url;
			Matrix.showWindow("DialogAuth");
		
		}
		
		
		//复制表单路径到粘贴板
		function copyFormId(target){
			var mid = target.id;
		    var formId = mid.trim()+".rform";
		    var isIE = isc.Browser.isIE;
		    
		    if(isIE){
			    window.clipboardData.setData("Text",formId);
		    
		    }else{
		    	isc.say('该功能仅支持IE浏览器,其他浏览器请选择复制以下内容：<br/>'+formId);
		    }
		
		}
		//复制实体的全路径到粘贴板
		function copyObjectPath(target){
			var ePath = target.entityPath;
			var isIE = isc.Browser.isIE;
			if(isIE){
			    window.clipboardData.setData("Text",ePath);
		    
		    }else{
		    	isc.say('该功能仅支持IE浏览器,其他浏览器请选择复制以下内容：<br/>'+formId);
		    }
		}
	



	
//单击节点 and 右键单击
 function forwardPageByNodeType(node){
 
 	/*
	//通用服务不可修改
    var isCommonService = commonServiceClickValidate(node.sid);
	     if(isCommonService) 
	     		return false;
	*/
	     		
	var nodeType =parseInt(node.type);
    switch(nodeType){
    	
    		
    	case 14://表单
    	    modifyComponent(node);
    		break;
    	case 15://逻辑服务
    	
    		 var url ="dcatalog/catalogAction_getLogicServiceById.action?mid=treeNode.id&parentNodeId=parentNode.id&entityPath=parentNode.entityPath&parentId=parentNode.parentId&comType="+node.comType;
		      forwardPage(node,url);
    		   break;
    	
    	   
    	case 16://业务对象
    	    var comType = node.comType;
    	    var url = "dentity/entityAction_getBObjectMainPage.action?entityId=treeNode.id&entityPath=treeNode.entityPath&entityType="+comType+"&moduleClsPath=parentNode.entityPath";
    	    forwardPage(node,url); 
    		break;
    	
    }
}
	
	
	
	
	
	//删除节点 根节点暂未添加该事件
	function deleteCatalog(target){
	    var nodeType = target.type;//节点类型
	    var confirmMsg = "节点";
	    var comType = target.comType;
	    switch(nodeType){
	    	case 1:
	    	  confirmMsg ="子目录"+target.text;
	    	break;
	    	case 2:
	    	confirmMsg ="模块"+target.text;
	    	break;
	    	case 14:
	    	confirmMsg ="表单"+target.text;
	    	break;
	    	case 15:
	    		if(comType==1){
		    		confirmMsg ="服务逻辑"+target.text;
		    	}else if(comType==2){
		    		confirmMsg ="脚本逻辑"+target.text;
		    	}else{
			    	confirmMsg ="逻辑服务"+target.text;
		    	}
	    	break;
	    	case 16:
		    	if(comType==1){
		    		confirmMsg ="实体对象"+target.text;
		    	}else if(comType==2){
		    		confirmMsg ="查询对象"+target.text;
		    	}else{
		    	confirmMsg ="业务对象"+target.text;
		    	
		    	}
	    		break;
	    	case 17:
	    	confirmMsg ="流程"+target.text;
	    	break;
	    	case 18:
	    	confirmMsg ="场景"+target.text;
	    	break;
	    	
	    }
	    
	    
	    isc.confirm('确定要删除'+confirmMsg+'吗?',function(data){//true or null
		      if(data){
		      	if(nodeType==14){//删除表单
		      	 var url ="dcatalog/catalogAction_deleteForm.action?mid=treeNode.id&parentNodeId=parentNode.id&parentId=parentNode.parentId&entityPath=parentNode.entityPath";
		  		 forwardPage(target,url);
		      	
		      	}else{
				//forwardPage(target,"<%=request.getContextPath()%>/catalog_deleteCatalog.action?entityId=treeNode.entityId&parentNodeId=parentNode.id&type="+target.type+"&mid="+target.id);
		      	
		      	}
		                                    		
		      }
                                    		 
        });
		
	}
	
	//删除组件
    function deleteComponent(target){
		forwardPage(target,"<%=request.getContextPath()%>/catalog_deleteCatalog.action?entityId=treeNode.entityId&parentNodeId=parentNode.id&type="+target.type+"&mid="+target.id);
    }	
    
	
	
	
	//添加组件 entityId作为新建节点父节点 parentId 父节点父节点
	function addComponent(target,type,comType){
		
		var url = "dcatalog/catalogAction_loadAddFormPage.action?parentId="+target.parentId+"&parentNodeId=treeNode.id&type="+type+"&entityPath="+target.entityPath;
		
		if(comType!=null){
			url = url+"&comType="+comType;
		}
	   forwardPage(target,url);
		
	}
	
	
	
	//****************************************************************
	function exportModule(){
		var url = "form/admin/develop/emptyPage.jsp";
		forwardPage(target,url);
	}
	
	//****************************************************************
	
	
	//修改组件
	function modifyComponent(target){
	   var type = parseInt(target.type);
	   if(type==14){//xiugai
	   	  var url ="dcatalog/catalogAction_loadUpdateFormPage.action?mid=treeNode.id&parentNodeId=parentNode.id&parentId=parentNode.parentId&entityPath=parentNode.entityPath";
		  forwardPage(target,url);
	   
	   }else if(type==17){//流程

	 	  forwardPage(target,"form/admin/process/mainProcess.jsp?processId=treeNode.id&processTmplId=treeNode.entityId&entityId=treeNode.entityId&parentNodeId=parentNode.id&type="+target.type); 

	   }else{
	   	  forwardPage(target,"<%=request.getContextPath()%>/catalog_getCatalogById.action?entityId=treeNode.entityId&parentNodeId=parentNode.id&type="+target.type);
	   } 
	  

	}
	
	//验证通用服务,点击节点时 不连接到修改页面
	function commonServiceClickValidate(nodeId){
		var commonArray = ['commonservice','info','process','tool','info_logic','process_logic','tool_logic'];
	    return  commonArray.contains(nodeId);
	
	}
	
	
				
     //指定右键菜单
     function assignNodeMenu(viewer, node, recordNum){
     	/*
     	 //通用服务不可修改
   		 var isCommonService = commonServiceClickValidate(node.sid);
	     if(isCommonService) 
	     		return false;
	     if(node.type>10){
	     	 isCommonService = commonServiceClickValidate(node.virtualSid);
	     	 if(isCommonService) 
		     	return false;
	     
	     }
	     */
	     	
     	 //根据节点类型设置右键菜单
			var nodeType = node.type;
			if(nodeType==0){ //根目录
				var nodeMenu = MTreeMenu_Root;
				if(nodeMenu){
					nodeMenu.target=node;//将右键菜单指向该节点
					nodeMenu.showContextMenu();//弹出显示该菜单
				}
			}else if(nodeType==1){//子目录
				var nodeMenu = MTreeMenu_SubCatalog;
				if(nodeMenu){
					nodeMenu.target=node;
					nodeMenu.showContextMenu();
				}
			
			}else if(nodeType==2){//模块
				var nodeMenu = MTreeMenu_Module;
				if(nodeMenu){
					nodeMenu.target=node;
					nodeMenu.showContextMenu();
				}
			
			}else if(nodeType==4){//表单目录
				var nodeMenu = MTreeMenu_FormFolder;
				if(nodeMenu){
					nodeMenu.target=node;
					nodeMenu.showContextMenu();
				}
			
			}else if(nodeType==5){//逻辑目录
				var nodeMenu = MTreeMenu_LogicFolder;
				if(nodeMenu){
					nodeMenu.target=node;
					nodeMenu.showContextMenu();
				}
			
			}else if(nodeType==6){//业务对象目录
				var nodeMenu = MTreeMenu_ServiceObjFolder;
				if(nodeMenu){
					nodeMenu.target=node;
					nodeMenu.showContextMenu();
				}
			
			}else if(nodeType==7){//流程目录
				var nodeMenu = MTreeMenu_SynFlowFolder;
				if(nodeMenu){
					nodeMenu.target=node;
					nodeMenu.showContextMenu();
				}
			
			}else if(nodeType==8){//场景目录
				var nodeMenu = MTreeMenu_SceneFolder;
				if(nodeMenu){
					nodeMenu.target=node;
					nodeMenu.showContextMenu();
				}
			
			}else if(nodeType==14){//表单页
				var nodeMenu = MTreeMenu_FormPage;
				if(nodeMenu){
					nodeMenu.target=node;
					nodeMenu.showContextMenu();
				}
			
			}else if(nodeType==15){//逻辑页 除表单页面外，其余四个是相同的右键菜单
				var nodeMenu = MTreeMenu_Common;
				if(nodeMenu){
					nodeMenu.target=node;
					nodeMenu.showContextMenu();
				}
			
			}else if(nodeType==16){//实体页(业务对象页)
				var nodeMenu = MTreeMenu_BOPage;
				if(nodeMenu){
					nodeMenu.target=node;
					nodeMenu.showContextMenu();
				}
			
			}else if(nodeType==17){//流程页
				var nodeMenu = MTreeMenu_Common;
				if(nodeMenu){
					nodeMenu.target=node;
					nodeMenu.showContextMenu();
				}
			
			}else if(nodeType==18){//场景页
				var nodeMenu = MTreeMenu_Common;
				if(nodeMenu){
					nodeMenu.target=node;
					nodeMenu.showContextMenu();
				}
	    	}
     }

</script>
</head>

<body>
<jsp:include page="/form/admin/common/loading.jsp" />
	<script>
 isc.HLayout.create({
			ID:"MhorizontalContainer0",
            height:"100%",
			width: "100%",
			align: "center",
			overflow: "auto",
			defaultLayoutAlign: "center",
			members: [
				isc.MatrixHTMLFlow.create({
					 ID:"MhorizontalContainer0Panel0",
					 width: '16%',
					 height: "100%",
					 overflow: "hidden",
					 showResizeBar: "true",
					 contents:"<div id='horizontalContainer0Panel0_div' class='matrixComponentDiv' style='overflow:hidden'></div>"
			}),
			isc.HTMLPane.create({
				ID:"MhorizontalContainer0Panel1",
				height: "100%",
				overflow: "hidden",
				showEdges:false,
				contentsType:"page",
				contentsURL:"<%=request.getContextPath()%>/form/admin/logon/matrix/welcome.jsp"
				})
			] 
		});
     </script>
<div id="horizontalContainer0Panel0_div2"
	style="width: 100%; height: 100%; overflow: hidden;"
	class="matrixInline"><script>
							var MForm0=isc.MatrixForm.create({
								ID:"MForm0",name:"MForm0",position:"absolute",
								action:"<%=request.getContextPath()%>/dcatalog/catalogAction_loadTreeNodes.action",
								fields:[{
										name:'Form0_hidden_text',
										width:0,
										height:0,
										displayId:'Form0_hidden_text_div'
								}]
							});
				</script>

<form id="Form0" name="Form0" eventProxy="MForm0" method="post"
	action="<%=request.getContextPath()%>/dcatalog/catalogAction_loadTreeNodes.action"
	style="margin: 0px; height: 100%;"
	enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="Form0" value="Form0" />
	<input type="hidden" name="refreshNode" id="refreshNode" />
<div type="hidden" id="Form0_hidden_text_div"
	name="Form0_hidden_text_div"
	style="position: absolute; width: 0; height: 0; z-index: 0; top :   0; left: 0; display: none;"></div>


<table style="width:100%;height:100%;margin:0px;">
	  
	    	<tr>
				<td height="20px" style="margin:0px;">当前位置>>研发</td>
		    </tr>
			<tr>
				<td >
					<div id="Tree0_div" class="matrixComponentDiv"
	style="width: 100%; height: 100%; position: relative;">
	<script> 
						isc.MatrixTree.create({	
								ID:"MTree0_DS",
						   		modelType:"children",
								ownerType:"tree",
								formId:"Form0",
								autoOpenRoot:true,
								ownerId:"Tree0",
								childrenProperty:"children",
								nameProperty:"text",
								root:{
									id:"RootTreeNode",
									entityId:"RootTreeNode",
									text:"RootTreeNode",
									type:0
								}
						});
				//isc.Page.setEvent('load','MTree0_DS.openFolder(MTree0_DS.root)',isc.Page.FIRE_ONCE);
				
				isc.MatrixTreeGrid.create({
						ID:"MTree0",
						name:"Tree0",
						height:"100%",
						width:"100%",
						displayId:"Tree0_div",
						position:"relative",
						showHeader:false,
						showHover:false,
						showCellContextMenus:true,
						leaveScrollbarGap:false,
						canAutoFitFields:true,
						wrapCells:false,
						fixedRecordHeights:true,
						selectionType:"single",
						selectionAppearance:"rowStyle",
						folderIcon:Matrix.getActionIcon("node"),
						data:MTree0_DS,
						autoFetchData:true,
						showOpenIcons:false,
						closedIconSuffix:'',
						showPartialSelection:false,
						cascadeSelection:false,
						border:0,
						onMoveUpAction:"true",
						onMoveDownAction:"true", 
						nodeContextClick:function(viewer, node, recordNum){
						               assignNodeMenu(viewer, node, recordNum);
						 
						},
						nodeClick:function(viewer, node, recordNum){
								forwardPageByNodeType(node);
						},
						getIcon:function(node){//根据节点类型返回不同类型的icon
						  return getNodeIconByType(node);
						}
					});
					
					
					if(MhorizontalContainer0Panel0)
							if(!MhorizontalContainer0Panel0.customMembers)MhorizontalContainer0Panel0.customMembers=[];
							
					MhorizontalContainer0Panel0.customMembers.add(MTree0);
					isc.Page.setEvent(isc.EH.LOAD,"MTree0.resizeTo('100%','100%');");
					isc.Page.setEvent(isc.EH.RESIZE,"MTree0.resizeTo(0,0);MTree0.resizeTo('100%','100%');",null);
				</script>
		</div>
				
				</td>
			</tr>
		
		
	</table>





		<script>
				//根的右键菜单
				isc.Menu.create({
					ID:"MTreeMenu_Root",
					autoDraw:false,
					showShadow:true,
					shadowDepth:10,
					data: [
							{title:"刷新",click:"refreshNode(target)",icon:Matrix.getActionIcon("refresh")}
						 ] 
				});
				//子目录右键菜单
				isc.Menu.create({
					ID:"MTreeMenu_SubCatalog",
					autoDraw:false,
					showShadow:true,
					shadowDepth:10,
					data: [ 
						    {title:"刷新",click:"refreshNode(target)",icon:Matrix.getActionIcon("refresh")}//,
						  ]
				}); 
				//模块右键菜单
					isc.Menu.create({
						ID:"MTreeMenu_Module",
						autoDraw:false,
						showShadow:true,
						shadowDepth:10,
						data: [ 
							{title:"刷新",click:"refreshNode(target)",icon:Matrix.getActionIcon("refresh")},
							{title:"导出模块",click:"exportModule(target)",icon:Matrix.getActionIcon("export")}
						] 
					});
				   //表单目录右键菜单
				   isc.Menu.create({
					   ID:"MTreeMenu_FormFolder",
					   autoDraw:false,
					   showShadow:true,
					   shadowDepth:10,
					   data: [ 
						     {title:"新建表单",click:"addComponent(target,14)",icon:Matrix.getActionIcon("add")},
						     {title:"刷新",click:"refreshNode(target)",icon:Matrix.getActionIcon("refresh")}
					   ] 
					});
					
				//业务对象右键菜单
				isc.Menu.create({
					ID:"MTreeMenu_ServiceObjFolder",
					autoDraw:false,
						showShadow:true,
						shadowDepth:10,
						data: [
						{title:"刷新",click:"refreshNode(target)",icon:Matrix.getActionIcon("refresh")}
					] 
				});
				//协同流程右键菜单
				isc.Menu.create({
					ID:"MTreeMenu_SynFlowFolder",
				    autoDraw:false,
					showShadow:true,
					shadowDepth:10,
					data: [
						{title:"新建协同流程",click:"addComponent(target,17)",icon:Matrix.getActionIcon("add")},
						{title:"刷新",click:"refreshNode(target)",icon:Matrix.getActionIcon("refresh")}
					]
				});
				//逻辑服务右键菜单
				isc.Menu.create({
					ID:"MTreeMenu_LogicFolder",
					autoDraw:false,
						showShadow:true,
						shadowDepth:10,
						data: [
							{title:"刷新",click:"refreshNode(target)", icon:Matrix.getActionIcon("refresh")}
					] 
				});
				//场景右键菜单
				isc.Menu.create({
					ID:"MTreeMenu_SceneFolder",
					autoDraw:false,
						showShadow:true,
						shadowDepth:10,
						data: [
							{title:"新建场景",click:"addComponent(target,18)",icon:Matrix.getActionIcon("add")},
							{title:"刷新",click:"refreshNode(target)",icon:Matrix.getActionIcon("refresh")}
						] 
				});
				//业务对象页面
				isc.Menu.create({
					    ID:"MTreeMenu_Common",
					    autoDraw:false,
						showShadow:true,
						shadowDepth:10,
						data: [ 
						{title:"打开",click:"forwardPageByNodeType(target)",icon:Matrix.getActionIcon("edit")}
					] 
				});
				//表单页面右键菜单
				isc.Menu.create({
					ID:"MTreeMenu_FormPage",
					autoDraw:false,
						showShadow:true,
						shadowDepth:10,
						data: [ 
						{title:"打开",click:"forwardPageByNodeType(target)",icon:Matrix.getActionIcon("edit")},
						{title:"复制路径",click:"copyFormId(target)",icon:Matrix.getActionIcon("copy")},
						{title:"授权",click:"formAuthority(target)",icon:Matrix.getActionIcon("auth")},
						{title:"删除",click:"deleteCatalog(target)",icon:Matrix.getActionIcon("delete")}
					   ] 
				});
				//业务对象页面右键菜单
				isc.Menu.create({
					ID:"MTreeMenu_BOPage",
					autoDraw:false,
						showShadow:true,
						shadowDepth:10,
						data: [ 
						{title:"打开",click:"forwardPageByNodeType(target)",icon:Matrix.getActionIcon("edit")},
						{title:"复制路径",click:"copyObjectPath(target)",icon:Matrix.getActionIcon("copy")},
						{title:"删除",click:"deleteCatalog(target)",icon:Matrix.getActionIcon("delete")},
						{title:"上移",click:"Matrix.moveUpTreeNode(target)",icon:Matrix.getActionIcon("move_up")},
						{title:"下移",click:"Matrix.moveDownTreeNode(target)",icon:Matrix.getActionIcon("move_down")},
						{title:"刷新",click:"refreshNode(target)", icon:Matrix.getActionIcon("refresh")}
					   ] 
				});
					isc.Window.create({
							ID:"MCatalogTarget",
							id:"CatalogTarget",
							name:"CatalogTarget",
							autoCenter: true,
							position:"absolute",
							height: "500px",
							width: "900px",
							title: "test",
							canDragReposition: false,
							showMinimizeButton:false,
							showMaximizeButton:false,
							showCloseButton:true,
							showModalMask: false,
							modalMaskOpacity:0,
							isModal:true,
							autoDraw: false,
							headerControls:[
								"headerIcon","headerLabel",
								"closeButton"
							]
							
							//initSrc:
							//src:
					});
					MCatalogTarget.hide();
					
	isc.Window.create({
		ID:"MDialogAuth",
		id:"DialogAuth",
		name:"DialogAuth",
		targetDialog:"CatalogTarget",
		autoCenter: true,
		position:"absolute",
		height: "500",
		width: "900",
		title: "表单授权",
		canDragReposition: false,
		showMinimizeButton:false,
		showMaximizeButton:false,
		showCloseButton:true,
		showModalMask: false,
		modalMaskOpacity:0,
		isModal:true,
		autoDraw: false,
		headerControls:[
			"headerIcon","headerLabel","closeButton"
		]
		
		
	 });
	MDialogAuth.hide();
					
					
			</script>
	</form>
	<script>
	MForm0.initComplete=true;MForm0.redraw();isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);
	</script>
</div>
<script>
	document.getElementById('horizontalContainer0Panel0_div').appendChild(document.getElementById('horizontalContainer0Panel0_div2'));
</script>
</body>

</html>