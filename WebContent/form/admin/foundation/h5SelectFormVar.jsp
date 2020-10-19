<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	basePath = path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<script>var webContextPath="<%=path%>";</script>
		<base href="<%=basePath%>">
		<title>选择</title>
<link href='<%=path %>/resource/html5/css/matrix_runtime.css' rel="stylesheet"></link>
		<script src="<%=path%>/resource/html5/js/jquery.min.js"></script>
		<script src='<%=request.getContextPath() %>/resource/html5/js/layer.min.js'></script>
		<script src='<%=request.getContextPath() %>/resource/html5/js/matrix_runtime.js'></script>
		<script src="<%=path%>/resource/html5/js/jstree.min.js"></script>
		<script src="<%=path%>/resource/html5/js/demo.js"></script>
		<link href="<%=path%>/css/bootstrap.min.css" rel="stylesheet">
		<link rel="stylesheet"
			href="<%=path%>/css/themes/default/style.min.css" />
<jsp:include page="/form/admin/common/taglib.jsp"/>
<jsp:include page="/form/admin/common/resource.jsp"/>
			
	</head>
	<body>
		<style>
			.jstree-default .jstree-hovered {
				background: none;
				border-radius: 0px;
				color: blue;
				text-decoration: underline;
				box-shadow: none
			}
			
			.jstree-default .jstree-clicked {
				background: #DDDDDD;
				border-radius: 0px;
				box-shadow: none;
			}
			
			.jstree-anchor {
				padding: 0 4px 0 0px;
			}
			
			.jstree-default .jstree-node-online {
				background: url("<%=path%>/office/html5/image/openfoldericon.png")
					no-repeat #fff;
				background-position: 50% 50%;
				background-size: auto;
			}
			
			.jstree-default .jstree-node-offline {
				background: url("<%=path%>/office/html5/image/foldericon.png") no-repeat
					#fff;
				background-position: 50% 50%;
				background-size: auto;
			}
		</style>
		<div style="width:100%;height:100%;overflow:auto;position:relative;margin:0 auto;zoom:1" id="context"><form id="form0" name="form0" eventProxy="Mform0" method="post" action="<%=request.getContextPath() %>/refactor/html5RefactorAction_migrateComponent.action" style="margin:0px;position:relative;overflow:auto;width:100%;height:100%;" enctype="application/x-www-form-urlencoded">
		<table style="width: 100%; height: 100%;">
			<tr>
				<td style="width: 100%; height: 90%;">
					<div id="container"
						style="background: #fff; font-size: 12px; height: 100%;; overflow: auto;"></div>

					<!-- include the minified jstree source -->
					<script type="text/javascript">
						$(document).ready(function() {
							var tree=	$('#container').jstree({
								'core' : {
									'multiple' : false,
									'dblclick_toggle': true,
				    				'data' : {
										"url" : "<%=request.getContextPath()%>/common/formVarTree_h5LoadFormVar.action",
										"data" : 
											function(node) {
											if(node.id==="#"){
													return {
														"root" : node.id ==="#"?"root":node.id,
														"optType" : $('#optType').val()	
													};
												}else{
													return {
														"root" : node.id ==="#"?"root":node.id,
														"type" : node.original.type,
														"entity" : node.original.entity,
														"entityId" : node.original.id
													};
												}
											},
										"dataType" : "json",
										"type":"post"
									},
									'themes' : {
										'icons' : true
									}
								},
								
								'expand_selected_onload' : true, //选中项蓝色底显示  
			                	"checkbox": {
			                    	"keep_selected_style": true,//是否默认选中
			                    	"three_state": false,//父子级别级联选择
			                    	"tie_selection": true
			                	},
			                	"themes": { "theme": "default", "dots": false, "icons": false },  
			            		"plugins" : [ "themes", "json_data","crrm","contextmenu"]
							});
			
			        		//展开时候图标设置
			    			$('#container').on('open_node.jstree', function(e, datas) {  
				     			var nodeId = datas.node.id; 
				     			//$('#container').jstree(true).set_icon(nodeId, "jstree-node-online");
			    				// tree.set_icon(node,"jstree-node-offline");
			    			});
			        		
			        		//双击
			    			$('#container').on('dblclick.jstree', function(e, datas) {
			    				var original = $('#container').jstree().get_selected(true)[0].original;
			    				var type = original.type;
			    				var optType = $('#optType').val();
			    				if(optType == 'formVar'){   //选择表单变量时
			    					if(type=="DataObject" || type=="List"){
					    				var data = "{'id':'"+original.id+"','dataObjectEntity':'"+original.dataObjectEntity+"','text':'"+ original.text + "','entity':'"+ original.entity + "'}";
					    				Matrix.closeWindow(data);
				    				}else{
				    					layer.alert("请选择表单变量！");
				    				}	    				
			    				}else{
			    					if(type=="entity"){
					    				var data = "{'id':'"+original.id+"','length':'"+original.length+"','name':'"+original.name+"','parentNodeId':'"+ original.parentNodeId + "','displayFormat':'"+ original.displayFormat + "','options':'"+ original.options + "','uiType':"+ original.uiType + ",'isRequired':"+ original.isRequired + ",'defaultValue':'"+ original.defaultValue + "','precision':'"+ original.precision + "'}";
					    				Matrix.closeWindow(data);
				    				}else{
				    					layer.alert("请选择属性！");
				    				}	    				}	    				
			    				
			    		    });
			    			
						   /*  //收拢时候图标设置
						    $('#container').on('dblclick', function(e, datas) {  
						     	var nodeId = datas.node.id; 
						     	alert(123);
						     	//$('#container').jstree(true).set_icon(nodeId, "jstree-node-offline");
						    	// tree.set_icon(node,"jstree-node-offline");
			    			}); */
			    			
			    			$('#container').on('load_node.jstree', function(e, data){
					    		$('#container').jstree(true).open_node("root");
			    			});
						});
					</script>
				</td>
			</tr>
			<tr>
				<td id="td2" class="cmdLayout" >
				<button type="button"  id="button001" class="x-btn ok-btn "  >确定</button>
				<button type="button"  id="button002" class="x-btn cancel-btn " >取消</button>
				
				<!-- formVar时为选择表单变量 ,否则为选择属性 -->
				<input id="optType" type="hidden" name="optType" value="${param.optType}"/>
				
				<input id="srcCompId" type="hidden" name="srcCompId" />
				<input id="cType" type="hidden" name="cType" value=${componentType } />
				<input id="targetModuleUuid" type="hidden" name="targetModuleUuid"  />
				<input id="srcEntityPath" type="hidden" name="srcEntityPath" />
				<script>
					$('#button001').click(function(data){
						var selected = $('#container').jstree(true).get_selected();						
						var optType = $('#optType').val();
	    				if(optType == 'formVar'){   //选择表单变量时
	    					if(selected.length == 1){
	    						var node = $('#container').jstree(true).get_node(selected[0]);
								var type = node.original.type;
								if(type=="DataObject" || type=="List"){
				    				var data = "{'id':'"+node.original.id+"','dataObjectEntity':'"+node.original.dataObjectEntity+"','text':'"+ node.original.text + "','entity':'"+ node.original.entity + "'}";
				    				Matrix.closeWindow(data);
			    				}else{
			    					layer.alert("请选择表单变量！");
			    				}	    
	    					}else{
	    						layer.alert("请选择表单变量！");
								return;
							}				
	    			   }else{	    					
	    					if(selected.length == 1){
								var node = $('#container').jstree(true).get_node(selected[0]);
								var type = node.original.type;
			    				if(type=="entity"){
				    				var data = "{'id':'"+node.original.id+"','length':'"+node.original.length+"','name':'"+node.original.name+"','parentNodeId':'"+ node.original.parentNodeId + "','displayFormat':'"+ node.original.displayFormat + "','options':'"+ node.original.options + "','uiType':"+ node.original.uiType + ",'isRequired':"+ node.original.isRequired + ",'defaultValue':'"+ node.original.defaultValue + "','precision':'"+ node.original.precision + "'}";
				    				Matrix.closeWindow(data);
			    				}else{
			    					layer.alert("请选择属性！");
			    				}
							}else{
								layer.alert("请选择属性！");
								return;
							}
	    				}
						
					});
					
					$('#button002').click(function(){
						var index = parent.layer.getFrameIndex(window.name);
						parent.layer.close(index);
					});
				</script></td>
			</tr>
	</table>
		</form>
		</div>
	</body>
</html>
