<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML >
<%@ page import="com.matrix.form.admin.common.utils.CommonUtil" %>
<html>
<head>
<meta charset="UTF-8">
<title>选择表单</title>
<%@ include file="/form/html5/admin/html5Head.jsp"%>
<!-- 需要给该通用树传递参数commonType[form 14，entity16] -->
<style>
	.jstree-default .jstree-hovered{
		 background:none;
		 border-radius:0px;
     	 color: blue;
    	 text-decoration: underline;
 		 box-shadow:none
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
    	background: url("<%=path %>/office/html5/image/openfoldericon.png") no-repeat #fff;
        background-position: 50% 50%;
    	background-size: auto;
	}
	.jstree-default .jstree-node-offline {
    	background: url("<%=path %>/office/html5/image/foldericon.png") no-repeat #fff;
       	background-position: 50% 50%;
    	background-size: auto;
	}
 </style>
<script type="text/javascript">
	$(function() {
		//关闭
	    $("#button001").click(function(){
        	Matrix.closeLayerWindow();
   		});
		 
		//确认
	    $("#button002").click(function(){
	          var selecttree = $('#container').jstree().get_selected(true);
		      if(selecttree!=null&&selecttree.length>0){
		    	  var node = $('#container').jstree().get_selected(true)[0].original; 
			      if(node.isFolder == false){
			    	  var currentFormId = $('#currentFormId').val();
			    	  if(currentFormId != '' && node.id == currentFormId){
			    		  Matrix.warn("子表单不可选择自身!");
		              	  return false;
			    	  }
			    	  var data = {};
		       		  data.id = node.id;
		       		  data.name = node.text;
		       		  data.layoutType = node.layoutType;
		  	    	  Matrix.closeWindow(data);
	              }else{
	              	  Matrix.warn("请选择表单!");
	              	  return false;
	              }
		      }else{
		    	  var data = {};
	       		  data.id = "";
	       		  data.name = "";
	  	    	  Matrix.closeWindow(data);
		      }
	    });
    });

</script>
</head>
<body >
<%
String processType = request.getParameter("processType");
%>

<div id="j_id1" jsId="j_id1" style="position:relative;_layout:flowlayout;width:100%;height:100%;overflow:auto;">
  <form id="form0" name="form0" eventProxy="Mform0" method="post" action="<%=request.getContextPath()%>/common/processTmpl_getH5FormForTree.action" 
		style="margin:0px;height:100%;" enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="form0" value="form0" />
	<input type="hidden" name="rootMid" id="rootMid" value="${param.rootMid}"/>
	<input type="hidden" name="rootEntityId" id="rootEntityId" value="${param.rootEntityId}"/>
	<!-- table表格布局  gird网格布局    空为查所有表单-->
	<input type="hidden" name="optType" id="optType" value="${param.optType}"/>
	<!-- 当前为选择子表单的表单编码-->
	<input type="hidden" name="currentFormId" id="currentFormId" value="${param.formId}""/>
	
	<div style=" position: absolute;height: 100%;width: 100%;overflow: hidden;">
  		<!-- 表单树-->
	    <div id="container" style="height:calc(100% - 54px); width:100%;overflow: auto;background: #fff; font-size: 12px;">
	    </div>
	    <script type="text/javascript">
		    $(document).ready(function() {
		    	var type;
		    	var entityId;
		    	var rootMid = $("#rootMid").val();
		    	var rootEntityId = $("#rootEntityId").val();
		    	var optType = $("#optType").val();
				var tree=$('#container').jstree({
					'core' : {
						'multiple' : false,    //设置为单选
						"animation" : false,   //打开/关闭动画持续时间（以毫秒为单位） - 将此设置false为禁用动画（默认为200）
						'dblclick_toggle': false,  //禁止双击（ 默认为true）
	    				'data' : {
							"url" : "<%=path %>/common/processTmpl_getH5FormForTree.action",
							"data" : function(node) {
								if(node.original){
									type = node.original.type;
									entityId = node.original.entityId;
								}
								return {
									"root" : node.id ==="#"?"0":node.id,
									"type" : type,
									"entityId" : entityId,
									"rootMid" : rootMid,
									"rootEntityId" : rootEntityId,
									"optType" : optType
								};
							},
							"dataType" : "json",
							"type" : "post"
						},
						'themes' : {
							'icons' : true
						}
					},	     
					"plugins" : [ "wholerow" ]
				});
				
				//双击事件
				$('#container').on('dblclick.jstree', function(e, datas) {
					var selecttree = $('#container').jstree().get_selected(true);
	        		if(selecttree!=null&&selecttree.length>0){
		                 var node = $('#container').jstree().get_selected(true)[0].original; 
				         var name = node.text;  
		                 var id = node.id;				
		                 if(node.isFolder == false){
		                	 debugger;
					    	  var currentFormId = $('#currentFormId').val();
					    	  if(currentFormId != '' && node.id == currentFormId){
					    		  Matrix.warn("子表单不可选择自身!");
				              	  return false;
					    	  }
		              		 var data = {};
		              		 data.id = node.id;
		              		 data.name = node.text;
		              		 data.layoutType = node.layoutType;
		              		 Matrix.closeWindow(data);
		              	}else{
		              		 Matrix.warn("请选择表单!");
		              		 return false;
		              	}
		            }
				});
		     });		                
		</script>
		<div id="buttom" class="cmdLayout">  
	  		<button id="button002" class="x-btn ok-btn " type="button">确认</button>
	    	<button style="margin-left:5px;" id="button001" class="x-btn cancel-btn " type="button">关闭</button>
		</div>		
	</div>
</form>
</div>
</body>
</html>