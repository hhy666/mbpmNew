<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML > 
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>修改表单!</title>


<jsp:include page="/form/admin/common/taglib.jsp"/>
<jsp:include page="/form/admin/common/resource.jsp"/>
</head>
<body>
<jsp:include page="/form/admin/common/loading.jsp" />
<div id="j_id1" jsId="j_id1" style="position: relative; _layout: flowlayout; width: 100%; height: 100%">
<script> 
	var MForm0=isc.MatrixForm.create({
		ID:"MForm0",
		name:"MForm0",
		position:"absolute",
		action:"<%=request.getContextPath()%>/catalog_updateForm.action",
		fields:[{
			name:'Form0_hidden_text',
			width:0,height:0,
			displayId:'Form0_hidden_text_div'
		}]
	});
 </script>
<form id="Form0" name="Form0" eventProxy="MForm0" method="post"  action="<%=request.getContextPath()%>/catalog_updateForm.action"
	style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
	<input id="syn" type="hidden" name="syn" value="false"/>
	<input type="hidden" name="Form0" value="Form0"/>
<div type="hidden" id="Form0_hidden_text_div" name="Form0_hidden_text_div"
	 style="position: absolute; width: 0; height: 0; z-index: 0; top: 0; left: 0; display: none;"></div>

<div style="text-valign: center; position: relative">
<table id="j_id3" jsId="j_id3" class="maintain_form_content">
	<tr id="j_id4" jsId="j_id4">
		<td id="j_id5" jsId="j_id5" class="maintain_form_label" colspan="1"
			rowspan="1" style="width: '20%'"><label
			id="j_id6" name="j_id6" style="margin-left: 10px"> 编&nbsp;&nbsp;码：</label>
		</td>
		<td id="j_id7" jsId="j_id7" class="maintain_form_input" colspan="1" rowspan="1">
		<div id="definedId_div" eventProxy="MForm0" class="matrixInline" style="float:left;"></div>
		<script>
			 var definedId=isc.TextItem.create({
			  	ID:"MdefinedId",
			  	name:"definedId",
			  	editorType:"TextItem",
			  	displayId:"definedId_div",
			  	position:"relative",
			  	value:"${catalogNode.mid}",
			  	width:400,
			  	disabled:true,
			  	required:true
			 });
		 MForm0.addField(definedId);
		</script>
		<span id="MultiLabel0" style="width: 19px; height: 20px; color: #FF0000">*</span>
		</td>
	</tr>
	<tr id="j_id9" jsId="j_id9">
		<td id="j_id10" jsId="j_id10" class="maintain_form_label" colspan="1"
			rowspan="1" style="width: '20%'">
			<label id="j_id11" name="j_id11" style="margin-left: 10px"> 名&nbsp;&nbsp;称：</label></td>
		<td id="j_id12" jsId="j_id12" class="maintain_form_input" colspan="1" rowspan="1">
		<div id="name_div" eventProxy="MForm0" class="matrixInline" style="float:left;"></div>
		<script> 
			var name2=isc.TextItem.create({
				ID:"Mname",
				name:"name",
				editorType:"TextItem",
				displayId:"name_div",
				position:"relative",
				value:"${catalogNode.name}",
				width:400,
				validators:[{
		      		    	type:"custom",
		      		    	condition:function(item, validator, value, record){
		      		         	return inputNameValidate(item, validator, value, record);
		      		         },
		      		         errorMessage:"名称不能为空!"
		      		 	}]
			});
			MForm0.addField(name2);
		</script>
		<span id="MultiLabel1" style="width: 19px; height: 20px; color: #FF0000">*</span>
		<span id="nameEchoMessage"
			style="color: #FF0000">${nameEchoMessage}<div id="repeatMsg"></div></span>
		</td>
	</tr>
	

	<tr id="j_id14" jsId="j_id14" style="display:none;">
		<td id="j_id15" jsId="j_id15" class="maintain_form_label" colspan="1" rowspan="1" style="width: '20%'">
		<label id="j_id16" name="j_id16" style="margin-left: 10px"> 类&nbsp;&nbsp;型：</label>
		</td>
		<td id="j_id17" jsId="j_id17" class="maintain_form_input" colspan="1" rowspan="1">
		<div id="comType2_div" eventProxy="MForm0" class="matrixInline" style=""></div>
		<script>
		 	var McomType2_VM=[];
		    var comType2=isc.ComboBoxItem.create({
		    		ID:"McomType2",
		    		name:"comType2",
		    		editorType:"ComboBoxItem",
		    		displayId:"comType2_div",
		    		valueMap:[],
		    		position:"relative",
		    		width:400
		    });
		    MForm0.addField(comType2);
		    McomType2_VM=['1','2'];
		    McomType2.displayValueMap={'1':'流式布局','2':'绝对布局'};
		    McomType2.setValueMap(McomType2_VM);
		    var comTypeValue = "${catalogNode.comType}";
		    McomType2.setValue(comTypeValue);
		    McomType2.disable();
		</script></td>
	</tr>
	<tr id="j_id114" jsId="j_id114">
			<td id="j_id115" jsId="j_id115" class="maintain_form_label" colspan="1" rowspan="1">
				<label id="j_id116" name="j_id116" style="margin-left:10px">路&nbsp;&nbsp;径：</label>
			</td>
			<td id="j_id117" jsId="j_id117" class="maintain_form_input" colspan="1" rowspan="1">
				<div id="entityLabel_div" eventProxy="MForm0" class="matrixInline" style=""></div>
				<script> var entityLabel=isc.TextItem.create({
								ID:"MentityLabel",
								name:"entityLabel",
								editorType:"TextItem",
								displayId:"entityLabel_div",
								position:"relative",
								width:400,
								value:"${requestScope.entity}",
								canEdit:false
					    });
					    MForm0.addField(entityLabel);
			    </script>
			  
			  </td>
		</tr>
		
	<tr id="j_id20" jsId="j_id20">
		<td id="j_id21" jsId="j_id21" class="maintain_form_label" colspan="1" rowspan="1" style="width: '20%'"><label
			id="j_id22" name="j_id22" style="margin-left: 10px"> 描&nbsp;&nbsp;述：</label></td>
		<td id="j_id23" jsId="j_id23" class="maintain_form_input" colspan="1"
			rowspan="1">
		<div id="desc_div" eventProxy="MForm0" class="matrixInline" style=""></div>
		<script> 
			var desc=isc.TextAreaItem.create({
				ID:"Mdesc",
				name:"desc",
				editorType:"TextAreaItem",
				displayId:"desc_div",
				position:"relative",
				value:"${catalogNode.desc}",
				width:400
			});
			MForm0.addField(desc);
		</script>
	</td>
	</tr>
	<tr id="j_id24" jsId="j_id24"></tr>
	<tr id="j_id25" jsId="j_id25"></tr>
	<tr id="j_id26" jsId="j_id26"></tr>
	<tr id="j_id27" jsId="j_id27">
		<td id="j_id28" jsId="j_id28" class="" style="text-align:center"
			colspan="2" rowspan="1">
		<div id="dataFormSubmitButton_div" class="matrixInline matrixInlineIE"
			style="position: relative;; width: 100px;; height: 22px;">
			<script>
			isc.Button.create({
				ID:"MdataFormSubmitButton",
				name:"dataFormSubmitButton",
				title:"保存",
				displayId:"dataFormSubmitButton_div",
				position:"absolute",
				top:0,left:0,
				width:"100%",height:"100%",
			    icon:Matrix.getActionIcon("save"),
				showDisabledIcon:false,
				showDownIcon:false,
				showRollOverIcon:false
				});
				
				MdataFormSubmitButton.click=function(){
					Matrix.showMask();
				
				    if(!MForm0.validate()){
				    	Matrix.hideMask();
				  	    return false;
					}
				
				//Matrix.convertFormItemValue('Form0');
				Matrix.send("Form0",null,callbackFun);
				Matrix.hideMask();
				return false;
			};
			
			function callbackFun(result){
			 var curPhase = '${param.phase}';
			 var msg = result.data;
			 if(msg!=null&&msg=="1"){
				 document.getElementById("repeatMsg").innerHtml = "名称重复!";
				 	if(!curPhase=='4'){
				 		parent.isc.warn("名称重复!");
				 	}
				 }else if(msg!=null&&msg=="2"){
				  //更新成功后刷新子节点
				if(curPhase!=null && curPhase!='null' && curPhase!='undefined' && curPhase!='' && curPhase=='4'){
					parent.Matrix.forceFreshTreeNode("Tree0","${param.parentNodeId}");
					parent.$('#container').jstree("refresh_node","${param.parentNodeId}");
					isc.say("表单更新成功!");
				}else{
					parent.parent.$('#container').jstree("refresh_node","${param.parentNodeId}");
					parent.parent.Matrix.forceFreshTreeNode("Tree0","${param.parentNodeId}");
					parent.parent.$('#container').jstree("deselect_node","${catalogNode.uuid}");
					parent.isc.say("表单更新成功!");
				}
			}
			}
			</script></div>
		</td>
	</tr>
</table>
</div>
	
	<input id="comType" type="hidden" name="comType" value="${catalogNode.comType}" />
	
	<input id="mid" type="hidden" name="mid" value="${catalogNode.mid}" />
    <input id="tenantId" type="hidden" name="tenantId" value="${catalogNode.tenantId}" />
    <input id="phase" type="hidden" name="phase" value="${catalogNode.phase}" />
	<input id="isPublic" type="hidden" name="isPublic" value="${catalogNode.isPublic}"/>
	<input id="createdUser" type="hidden" name="createdUser" value="${catalogNode.createdUser}"/>
	<input id="uuid" type="hidden" name="uuid" value="${catalogNode.uuid}" />
	
	<input id="parentUuid" type="hidden" name="parentUuid" value="${catalogNode.parentUuid}" />
	<input id="type" type="hidden" name="type" value="${catalogNode.type}" />
	<input id="index" type="hidden" name="index" value="${catalogNode.index}" />
	<input id="createdDate" type="hidden" name="createdDate" value="${catalogNode.createdDate}" />
	<!-- 在更新过程中传递节点信息 -->
	<input id="parentId" type="hidden" name="parentId" value="${param.entityId}" />
	<input id="parentNodeId" type="hidden" name="parentNodeId" value="${param.parentNodeId}"/>
	
</form>
	
<script>

	MForm0.initComplete=true;MForm0.redraw();isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);
</script>
</div>
</body>
</html>