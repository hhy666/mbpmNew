<%@ page pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
		<jsp:include page="/foundation/common/taglib.jsp" />
		<jsp:include page="/foundation/common/resource.jsp" />
		<script type="text/javascript">
			function type1() {
				document.getElementById('tr010').style.display = '';
				document.getElementById('tr011').style.display = '';
				document.getElementById('tr099').style.display = '';
				document.getElementById('tr012').style.display = 'none';
				document.getElementById('tr013').style.display = 'none';
				document.getElementById('tr014').style.display = 'none';
				document.getElementById('tr015').style.display = 'none';
				document.getElementById('tr016').style.display = 'none';
		
				Matrix.setFormItemValue('input003', '');
				Matrix.setFormItemValue('receiverId', '');
				Matrix.setFormItemValue('inputTextArea004', '');
				Matrix.setFormItemValue('msgContentVal', '');
				Matrix.setFormItemValue('input097', '');
				Matrix.setFormItemValue('targetFormId', '');
			}
			function type2() {
				document.getElementById('tr010').style.display = 'none';
				document.getElementById('tr011').style.display = 'none';
				document.getElementById('tr099').style.display = 'none';
				document.getElementById('tr012').style.display = '';
				document.getElementById('tr013').style.display = '';
				document.getElementById('tr014').style.display = 'none';
				document.getElementById('tr015').style.display = 'none';
				document.getElementById('tr016').style.display = 'none';
		
				Mradio004.setValue('0');
				Matrix.setFormItemValue('eventUserName', '');
				Matrix.setFormItemValue('input098', '');
				Matrix.setFormItemValue('input005', '');
				Matrix.setFormItemValue('eventUserId', '');
				Matrix.setFormItemValue('eventFlowId', '');
				Matrix.setFormItemValue('eventAdid', '');
				Matrix.setFormItemValue('inputTextArea003', '');
				Matrix.setFormItemValue('eventPdid', '');
				Matrix.setFormItemValue('input097', '');
				Matrix.setFormItemValue('targetFormId', '');
				
			}
			function type3(){
				document.getElementById('tr010').style.display = 'none';
				document.getElementById('tr011').style.display = 'none';
				document.getElementById('tr099').style.display = 'none';
				document.getElementById('tr012').style.display = 'none';
				document.getElementById('tr013').style.display = 'none';
				document.getElementById('tr014').style.display = '';
				document.getElementById('tr015').style.display = '';
				document.getElementById('tr016').style.display = '';
				
				Mradio004.setValue('0');
				Matrix.setFormItemValue('eventUserName', '');
				Matrix.setFormItemValue('eventUserId', '');
				Matrix.setFormItemValue('input098', '');
				Matrix.setFormItemValue('eventFlowId', '');
				Matrix.setFormItemValue('input005', '');
				Matrix.setFormItemValue('eventAdid', '');
				Matrix.setFormItemValue('inputTextArea003', '');
				Matrix.setFormItemValue('eventPdid', '');
				Matrix.setFormItemValue('input003', '');
				Matrix.setFormItemValue('receiverId', '');
				Matrix.setFormItemValue('inputTextArea004', '');
				Matrix.setFormItemValue('msgContentVal', '');
			}
			function onload() {  //根据不同的动作类型加载不同界面
				var type = '0';//'${formTrigger.eventType}';
				if (type == "" || type == '0') { //触发流程类型
					type1();
				}
				if (type == '1') { //发送消息类型
					type2();
				}
				if(type == '2'){  //数据复制类型
					type3();
				}
				
				
			}
			function hiddenType() {  //下拉框的选择值改变时调用
				var actionType = Matrix.getFormItemValue('comboBox001');
				if ("0" == actionType) {
					type1();
				}
				if ("1" == actionType) {
					type2();
				}
				if ("2" == actionType) {
					type3();
				}
				
				Mform0.redraw();  //设成 %比 这种情况时需要重画一下
			} 
			//***********************************************************************
			function chageStarterType(){  //切换发起人类型
				var starterType = document.getElementsByName('radiogroup002'); //获取单选按钮组
				if(starterType[0].checked == true){
					Matrix.setFormItemValue('input005','');
					Matrix.setFormItemValue('eventAdid','');
					return;
				}
				if(starterType[1].checked == true){
					Matrix.setFormItemValue('eventUserName', '');
					Matrix.setFormItemValue('eventUserId', '');
					Matrix.setFormItemValue('eventAdid', '');
					Matrix.setFormItemValue('input005','');
					return;
				}
				if(starterType[2].checked == true){
					Matrix.setFormItemValue('eventUserName','');
					Matrix.setFormItemValue('eventUserId','');
					return;
				}
			}
			function changeTriggerPoint(){  //改变触发器触发点时
				var triggerPoint = document.getElementsByName('triggerPoint');
				if(triggerPoint[0].checked == true){
					Matrix.setFormItemValue('input007','');
					Matrix.setFormItemValue('input099','');
					Matrix.setFormItemValue('checkPointFlowId','');
					Matrix.setFormItemValue('checkPointId','');
					Matrix.setFormItemValue('conditionVal','');
					Matrix.setFormItemValue('inputTextArea002','');
					document.getElementById('tr022').style.display = 'none';
					Mform0.setValue("checkBox001","");
				}
				if(triggerPoint[1].checked == true){
					Matrix.setFormItemValue('input007','');
					Matrix.setFormItemValue('input099','');
					Matrix.setFormItemValue('checkPointFlowId','');
					Matrix.setFormItemValue('checkPointId','');
					Matrix.setFormItemValue('conditionVal','');
					Matrix.setFormItemValue('inputTextArea002','');
					document.getElementById('tr022').style.display = '';
				}
				if(triggerPoint[2].checked == true){
					Matrix.setFormItemValue('conditionVal','');
					Matrix.setFormItemValue('inputTextArea002','');
					document.getElementById('tr022').style.display = '';
				}
				if(triggerPoint[3].checked == true){
					Matrix.setFormItemValue('input007','');
					Matrix.setFormItemValue('input099','');
					Matrix.setFormItemValue('checkPointFlowId','');
					Matrix.setFormItemValue('checkPointId','');
					document.getElementById('tr022').style.display = 'none';
					Mform0.setValue("checkBox001","");
				}
				
			}
		//***************************************************************************	
			function validation() {
				var name = Matrix.getFormItemValue('input001'); //验证名称是否为空
				if(name == ''){
					alert('名称不能为空');
					return false;
				}
				var radiogroup = document.getElementsByName('triggerPoint');//获取触发点按钮组
				if(radiogroup[2].checked == true){ //选中核定节点，需验证流程和节点是否为空
					var checkPointFlow = Matrix.getFormItemValue('input099');
					if(checkPointFlow == ''){
						alert('请选择核定节点的流程');
						return false;
					}
					var checkPoint = Matrix.getFormItemValue('input007');
					if(checkPoint == ''){
						alert('请选择核定节点');
						return false;
					}
				}
				if(radiogroup[3].checked == true){
					var firstCondition = Matrix.getFormItemValue('inputTextArea002');
					if(firstCondition == ''){
						alert('请选择首次满足条件');
						return false;
					}
				}
				var actionType = Matrix.getFormItemValue('comboBox001');
				if ("0" == actionType) {
					var starters = document.getElementsByName('radiogroup002');
					if (starters[0].checked == true) {
						var input = Matrix.getFormItemValue('eventUserName');
						if (input == null || input == '') {
							alert('请选择指定人员');
							return false;
						}
					}
					if(starters[1].checked == true){
						Matrix.setFormItemValue('eventUserName','');
						Matrix.setFormItemValue('input005','');
					}
					if (starters[2].checked == true) {
						var input = Matrix.getFormItemValue('input005');
						if (input == null || input == '') {
							alert('请选择触发节点');
							return false;
						}
					}
					var lcmb = Matrix.getFormItemValue('inputTextArea003');
					if (lcmb == null || lcmb == '') {
						alert('请选择流程模板');
						return false;
					}
				}
				if ('1' == actionType) {
					var input1 = Matrix.getFormItemValue('input003');
					if (input1 == null || input1 == '') {
						alert('请选择消息接收人');
						return false;
					}
					var input2 = Matrix.getFormItemValue('inputTextArea004');
					if (input1 == null || input1 == '') {
						alert('请选择消息模板');
						return false;
					}
				}
				if('2' == actionType){
					var targetFormName = Matrix.getFormItemValue('input097');
					if(targetFormName == ''){
						alert('请选择目标表单');
						return false;
					}
				}
				return true;
			}
		//***************************************************************************弹出窗口部分
			var authUser = {};
			function showSelectPersons() {  //选择指定人员或消息接收人
				var eventType = Matrix.getFormItemValue('comboBox001');
				if(eventType == '0'){
					var radiogroup = document.getElementsByName('radiogroup002');
					radiogroup[0].checked = true;
					authUser.areaIds = document.getElementById("eventUserId").value;
					authUser.areaName = Matrix.getFormItemValue("eventUserName");
				}else{
					authUser.areaIds = document.getElementById("receiverId").value;
					authUser.areaName = Matrix.getFormItemValue("input003");
				}
				Matrix.showWindow('persons');
			}
		
			function onpersonsClose(data) {
				if (data != null) {
					var userNames = data.allNames;
					var userId = data.allIds;
					var eventType = Matrix.getFormItemValue('comboBox001');
					if (eventType == '0') {
						Matrix.setFormItemValue('eventUserId', userId);
						Matrix.setFormItemValue('eventUserName', userNames);
					}else{
						Matrix.setFormItemValue('receiverId', userId);
						Matrix.setFormItemValue('input003', userNames);
					}
				}
			}
			
			function selectFlow(componentId) { //选择流程模板
				Matrix.setFormItemValue("componentId",componentId);
				if(componentId == 'input099'){
					var radiogroup = document.getElementsByName("triggerPoint");
					radiogroup[2].checked = true;
					Matrix.setFormItemValue('inputTextArea002','');
					Matrix.setFormItemValue('conditionVal','');
					Matrix.setFormItemValue('input007','');
					Matrix.setFormItemValue('checkPointId','');
					document.getElementById('tr022').style.display = '';
					
				}
				if(componentId == 'input098'){
					var radiogroup = document.getElementsByName("radiogroup002");
					radiogroup[2].checked = true;
					Matrix.setFormItemValue('eventUserName','');
					Matrix.setFormItemValue('eventUserId','');
					Matrix.setFormItemValue('input005','');
					Matrix.setFormItemValue('eventAdid','');
				}
				
				Matrix.showWindow('flow');
			}
			function onflowClose(result) {
				if (result != null) {
					var data = eval("("+result+")");
					var startCoTmplName = data.text; // 模板名称
					//var startCoTmplId = data.uuid;
					var flowId = data.id; // 模板编码
					var componentId = Matrix.getFormItemValue("componentId");
					Matrix.setFormItemValue(componentId, startCoTmplName); //显示流程名称
					if(componentId == 'inputTextArea003'){
						Matrix.setFormItemValue('eventPdid', flowId);
					}
					if(componentId == 'input099'){
						Matrix.setFormItemValue('checkPointFlowId', flowId);
					}
					if(componentId == 'input098'){
						Matrix.setFormItemValue('eventFlowId', flowId);
					}
					
				}
			}
			function showPoint(componentId){
				Matrix.setFormItemValue("componentId",componentId);
				if(componentId == 'input007'){
					var radiogroup = document.getElementsByName("triggerPoint");
					radiogroup[2].checked = true;
					Matrix.setFormItemValue('inputTextArea002','');
					document.getElementById('tr022').style.display = '';
					if(Matrix.getFormItemValue('input099') == ''){
						Matrix.warn('请先选择流程');
						return;
					}
				}
				if(componentId == 'input005'){
					var radiogroup = document.getElementsByName("radiogroup002");
					radiogroup[2].checked = true;
					Matrix.setFormItemValue('evnetUserNames','');
					if(Matrix.getFormItemValue('input098') == ''){
						Matrix.warn('请先选择流程');
						return;
					}
				}
				Matrix.showWindow('checkPoint');
			}
			function oncheckPointClose(result){
				var data = eval("("+result+")");
				var componentId = Matrix.getFormItemValue('componentId');
				if(componentId == 'input007'){
					Matrix.setFormItemValue('checkPointId',data.pointId);
				}
				if(componentId == 'input005'){
					Matrix.setFormItemValue('eventAdid',data.pointId);
				}
				Matrix.setFormItemValue(componentId,data.pointName);
			}
			
			function showFormTree(){ // 选择目标表单
				Matrix.showWindow('formTree');
			}
			function onformTreeClose(result){
				if (result != null) {
					var data = eval("("+result+")");
					var targetFormName = data.text;
					var targetFormId = data.id;
					Matrix.setFormItemValue('input097',targetFormName);
					Matrix.setFormItemValue('targetFormId',targetFormId);
					var oldTargetFormId = Matrix.getFormItemValue('oldTargetFormId');//获取原先选择的目标表单 Id
					if(oldTargetFormId == null || oldTargetFormId == ''){ //说明是第一次选择表单
						Matrix.setFormItemValue('oldTargetFormId',targetFormId);
					}else{
						if(oldTargetFormId != targetFormId){ //若新选的目标表单跟原先选择的不一样，把设置的条件清空,同时把新选的表单ID变为原先的表单ID
							Matrix.setFormItemValue('dataCopyStr','');
							alert('---------'+Matrix.getFormItemValue('dataCopyStr'));
							Matrix.setFormItemValue('oldTargetFormId',targetFormId);
						}
						//否则，不用做任何处理
					}
				}
			}
			
			function showDataCopySet(){
				var targetFormName = Matrix.getFormItemValue('input097');
				if(targetFormName==''){
					alert('请选择目标表单');
					return;
				}
				var dataCopyStr = Matrix.getFormItemValue('dataCopyStr');
				Matrix.showWindow('dataCopy');
			}
			function ondataCopyClose(data){
				if(data != null && data != ''){
					Matrix.setFormItemValue('dataCopyStr',data);
				}
			}
			
			function showFirstCondition(){
				var radiogroup = document.getElementsByName("triggerPoint");
				radiogroup[3].checked = true;
				Matrix.setFormItemValue('input099','');
				Matrix.setFormItemValue('input007','');
				Matrix.setFormItemValue('checkPointFlowId','');
				Matrix.setFormItemValue('checkPointId','');
				document.getElementById('tr022').style.display = 'none';
				Mform0.setValue("checkBox001","");
				var condition = Matrix.getFormItemValue('inputTextArea002');
				Mcondition.initSrc = "<%=request.getContextPath()%>/trigger/condition_condition.action?firstCondition="+condition,
				Mcondition.src = "<%=request.getContextPath()%>/trigger/condition_condition.action?firstCondition="+condition,
				Matrix.showWindow('condition');
			}
			function onconditionClose(data){
				if(data!=null && data!=''){
					var result = eval("("+data+")");
					Matrix.setFormItemValue('inputTextArea002',result.conditionText);
					Matrix.setFormItemValue('conditionVal',result.conditionVal);
				}
			}
			function showMsgContent(){
				var msgContent = Matrix.getFormItemValue('inputTextArea004');
				MmsgContent.initSrc = "<%=request.getContextPath()%>/trigger/condition_loadMsgContent.action?msgContent="+msgContent,
				MmsgContent.src = "<%=request.getContextPath()%>/trigger/condition_loadMsgContent.action?msgContent="+msgContent,
				Matrix.showWindow('msgContent');
			}
			function onmsgContentClose(data){
				if(data!=null && data!=''){
					var result = eval("("+data+")");
					Matrix.setFormItemValue('inputTextArea004',result.msgContentText);
					Matrix.setFormItemValue('msgContentVal',result.msgContentVal);
				}
			}
		</script>
	</head>

	<body>
		<div id='loading' name='loading' class='loading'>
			<script>
				Matrix.showLoading();
			</script>
		</div>
		<script>
			isc.Page.setEvent(isc.EH.LOAD, "onload()", isc.Page.FIRE_ONCE);
		</script>
		<script>
			var Mform0 = isc.MatrixForm.create( {
				ID : "Mform0",
				name : "Mform0",
				position : "absolute",
				action : "",
				canSelectText : true,
				fields : [ {
					name : 'form0_hidden_text',
					width : 0,
					height : 0,
					displayId : 'form0_hidden_text_div'
				} ]
			});
		</script>
		
		<div style="width: 100%; height: 100%; overflow: auto; position: relative;">
			<form id="form0" name="form0" eventProxy="Mform0" method="post" action=""
				  style="margin: 0px; position: relative; overflow: auto; width: 100%; height: 100%;"
				  enctype="application/x-www-form-urlencoded">
			<div type="hidden" id="form0_hidden_text_div" name="form0_hidden_text_div" style="position: absolute; width: 0; height: 0; z-index: -9999999999; top: 0; left: 0; display: none;">
			</div>
			<table id="table001" class="tableLayout" style="width: 100%;">
				<tr id="tr001">
					<td id="td001" class="tdLayout" colspan="3" rowspan="1"
						style="width: 100%;">
						<label id="label001" name="label001" id="label001"
							style="font-size: 14px; margin-left: 5px;">
							触发定义
						</label>
					</td>
				</tr>
				<tr id="tr002">
					<td id="td003" class="maintain_form_label" style="width: 30%">
						<label id="label002" name="label002" id="label002"
							   style="color: red;">
							*
						</label>
						<label id="label003" name="label003" id="label003">
							名称：
						</label>
					</td>
					<td id="td004" class="tdLayout" colspan="2" style="width: 70%;">
						<div id="input001_div" eventProxy="Mform0" class="matrixInline"
							style="width: 50%;"></div>
						<script>
							var input001 = isc.TextItem.create( {
								ID : "Minput001",
								name : "input001",  //name 字段
								editorType : "TextItem",
								displayId : "input001_div",
								position : "relative",
								autoDraw : false,
								value:'${formTrigger.name==null?"":formTrigger.name}',
								width : "100%"
							});
							Mform0.addField(input001);
						</script>
					</td>
				</tr>
				<tr id="tr003">
					<td id="td005" class="maintain_form_label" style="width: 30%">
						<label id="label004" name="label004" id="label004">
							状态
						</label>
					</td>
					<td id="td006" class="tdLayout" colspan="2" style="width: 70%">
						<div id="radioGroup001_0_div" eventProxy="Mform0" class="matrixInline"></div>
						<div id="radioGroup001_1_div" eventProxy="Mform0" class="matrixInline"></div>
						<script>
							var radioGroup001_0 = isc.RadioItem.create( {
								ID : "MradioGroup001_0",
								name : "radioGroup001", //status 字段
								editorType : "RadioItem",
								displayId : "radioGroup001_0_div",
								value : "0",
								title : "启动",
								position : "relative",
								groupId : "radioGroup001",
								disabled : false,
								autoDraw : false
							});
							Mform0.addField(radioGroup001_0);
						</script>
						<script>
							var radioGroup001_1 = isc.RadioItem.create( {
								ID : "MradioGroup001_1",
								name : "radioGroup001",
								editorType : "RadioItem",
								displayId : "radioGroup001_1_div",
								value : "1",
								title : "停用",
								position : "relative",
								groupId : "radioGroup001",
								disabled : false,
								autoDraw : false
							});
							Mform0.addField(radioGroup001_1);
							Mform0.setValue("radioGroup001", '${formTrigger.status}');
						</script>
					</td>
				</tr>
				<tr id="tr004">
					<td id="td007" class="tdLayout" colspan="3" rowspan="1" style="width: 100%">
						<label id="label005" name="label005" id="label005" style="font-size: 14px; margin-left: 5px;">
						条件
						</label>
					</td>
				</tr>
				<tr id="tr005">
					<td id="td009" class="maintain_form_label" colspan="1" rowspan="3" style="width: 30%">
						<label id="label007" name="label007" id="label007" style="color: red;">
						*
						</label>
						<label id="label006" name="label006" id="label006">
						触发点：
						</label>
					</td>
					<td id="td010" class="tdLayout" colspan="2" rowspan="1" style="width: 70%">
						<div id="radio001_div" eventProxy="Mform0" class="matrixInline" style=""></div>
						<div id="radio020_div" eventProxy="Mform0" class="matrixInline" style=""></div>
						<script>
							var radio001 = isc.RadioItem.create( {
								ID : "Mradio001",
								name : "triggerPoint",  //eventPiont 字段
								title : '流程开始',
								editorType : "RadioItem",
								displayId : "radio001_div",
								value : "0",
								groupId : "triggerPoint",
								position : "relative",
								width : 99,
								autoDraw : false,
								title : "流程开始",
								change : "changeTriggerPoint();"
							});
							Mform0.addField(radio001);
							Mform0.setValue("triggerPoint", '${formTrigger.eventPoint}');
						</script>
						<script>
							var radio020 = isc.RadioItem.create( {
								ID : "Mradio020",
								name : "triggerPoint",  //eventPiont 字段
								title : '流程结束',
								editorType : "RadioItem",
								displayId : "radio020_div",
								value : "3",
								groupId : "triggerPoint",
								position : "relative",
								width : 99,
								autoDraw : false,
								title : "流程结束",
								change : "changeTriggerPoint();"
							});
							Mform0.addField(radio020);
							Mform0.setValue("triggerPoint", '${formTrigger.eventPoint}');
						</script>
					</td>
				</tr>
				<tr id="tr006">
					<td id="td012" class="tdLayout" colspan="1" rowspan="1" style="width: 10%">
						<div id="radio002_div" eventProxy="Mform0" class="matrixInline" style=""></div>
						<script>
							var radio002 = isc.RadioItem.create( {
								ID : "Mradio002",
								name : "triggerPoint",
								title : '核定节点通过',
								editorType : "RadioItem",
								displayId : "radio002_div",
								value : "1",
								groupId : "triggerPoint",
								position : "relative",
								width : 107,
								autoDraw : false,
								title : "核定节点通过",
								change : "changeTriggerPoint();"
							});
							Mform0.addField(radio002);
							Mform0.setValue("triggerPoint", '${formTrigger.eventPoint}');
						</script>
					</td>
					<td id="td011" rowspan="1" style="width: 60%" colspan="1" class="tdLayout">
						<div style="float: left; margin-top: 5px;">
							选择流程：
						</div>
						<div id="input099_div" eventProxy="Mform0" style="width: 35%; float: left;"></div>

						<div style="float: left; margin-top: 5px;">
							选择节点：
						</div>
						<div id="input007_div" eventProxy="Mform0" style="width: 35%; float: left;"></div>
						<script>
							var input099 = isc.TextItem.create({
								ID : "Minput099",
								name : "input099",
								editorType : "TextItem",
								displayId : "input099_div",
								position : "relative",
								autoDraw : false,
								width : "100%",
								canEdit : true,
								click : "selectFlow('input099');",
								hint :　"请选择流程",
								showHintInField : true,
								canEdit : false,
								value :　"<%=request.getAttribute("checkPointFlowName") == null
										? ""
										: (String) request.getAttribute("checkPointFlowName")%>"
							});
							Mform0.addField(input099);
						</script>
						<script>
							var input007 = isc.TextItem.create( {
								ID : "Minput007",
								name : "input007", //核定节点通过
								editorType : "TextItem",
								displayId : "input007_div",
								position : "relative",
								autoDraw : false,
								width : "100%",
								value :'<%=request.getAttribute("checkPointName") == null
											? ""
											: (String) request.getAttribute("checkPointName")%>',
								canEdit : true,
								click : "showPoint('input007');",
								hint :　"请选择指定节点",
								showHintInField : true,
								canEdit : false
							});
							Mform0.addField(input007);
						</script>
					</td>
				</tr>
				<tr id="tr007">
					<td id="td014" class="tdLayout" colspan="1" rowspan="1" style="width: 10%;">
						<div id="radio003_div" eventProxy="Mform0" class="matrixInline" style=""></div>
						<div id="radio022_div" eventProxy="Mform0" class="matrixInline" style=""></div>
						<script>
							var radio003 = isc.RadioItem.create( {
								ID : "Mradio003",
								name : "triggerPoint",
								title : '首次条件满足时',
								editorType : "RadioItem",
								displayId : "radio003_div",
								value : "2",
								groupId : "triggerPoint",
								position : "relative",
								width : 122,
								autoDraw : false,
								title : "首次条件满足时",
								change : "changeTriggerPoint();"
							});
							Mform0.addField(radio003);
							Mform0.setValue("triggerPoint", '${formTrigger.eventPoint}');
						</script>
						<script>
							var radio022 = isc.RadioItem.create( {
								ID : "Mradio022",
								name : "triggerPoint",
								title : '每次条件满足时',
								editorType : "RadioItem",
								displayId : "radio022_div",
								value : "4",
								groupId : "triggerPoint",
								position : "relative",
								width : 122,
								autoDraw : false,
								title : "每次条件满足时",
								change : "changeTriggerPoint();"
							});
							Mform0.addField(radio022);
							Mform0.setValue("triggerPoint", '${formTrigger.eventPoint}');
						</script>
					</td>
					<td id="td037"  colspan="1" rowspan="1" class="tdLayout" style="width: 60%;">
						<div id="inputTextArea002_div" eventProxy="Mform0" class="matrixInline" style="width: 100%;"></div>
						<script>
							var inputTextArea002 = isc.TextAreaItem.create( {
								ID : "MinputTextArea002",
								name : "inputTextArea002", //首次条件满足
								editorType : "TextAreaItem",
								displayId : "inputTextArea002_div",
								position : "relative",
								autoDraw : false,
								width : '100%',
								value : '${requestScope.firstCondition == null?"":requestScope.firstCondition}',
								height : 54,
								hint : "请选择首次满足条件",
								showHintInField : true,
								click : "showFirstCondition();",
								canEdit : false
							});
							Mform0.addField(inputTextArea002);
						</script>
					</td>
				</tr>
				<tr id="tr008">
					<td id="td015" class="tdLayout" colspan="3" rowspan="1"
						style="width: 100%;">
						<label id="label008" name="label008" id="label008"
							style="font-size: 14px; margin-left: 5px;">
							动作
						</label>
					</td>
				</tr>
				<tr id="tr009">
					<td id="td017" class="maintain_form_label" style="width: 30%;">
						<label id="label009" name="label009" id="label009">
							类型：
						</label>
					</td>
					<td id="td018" class="tdLayout" colspan="2" style="width: 70%;">
						<div id="comboBox001_div" eventProxy="Mform0"
							class="matrixInline" style=""></div>
						<script>
							var McomboBox001_VM = [];
							var comboBox001 = isc.SelectItem.create( {
								ID : "McomboBox001",
								name : "comboBox001",  //eventType 字段
								editorType : "SelectItem",
								displayId : "comboBox001_div",
								autoDraw : false,
								valueMap : [],
								value : "0",
								position : "relative",
								changed : "hiddenType();"
							});
							Mform0.addField(comboBox001);
							McomboBox001_VM = [ '0', '1' ,'2'];
							McomboBox001.displayValueMap = {
								'0' : '触发流程',
								'1' : '发送消息',
								'2' : '数据设置'
							};
							McomboBox001.setValueMap(McomboBox001_VM);
							McomboBox001.setValue('${formTrigger.eventType==null?"0":formTrigger.eventType}');
						</script>
					</td>
				</tr>
				<tr id="tr010">
					<td id="td019" class="maintain_form_label" style="width: 30%;" 
						rowspan="2">
						<label id="label010" name="label010" id="label010"
							style="color: red;">
							*
						</label>
						<label id="label011" name="label011" id="label011">
							流程发起人
						</label>
					</td>
					<td id="td020" class="tdLayout" colspan="2" style="width: 70%;">
						<div id="radio005_div" eventProxy="Mform0" class="matrixInline"
							style=""></div>
						<div id="radio004_div" eventProxy="Mform0" class="matrixInline"
							style=""></div>
						<div id="eventUserName_div" eventProxy="Mform0"
							class="matrixInline" style=""></div>
						<script>
								var radio004 = isc.RadioItem.create( {
									ID : "Mradio004",
									name : "radiogroup002",
									title : '指定人员',
									editorType : "RadioItem",
									displayId : "radio004_div",
									value : "1",
									groupId : "radiogroup002",
									position : "relative",
									width : 82,
									autoDraw : false,
									title : "指定人员",
									change : "chageStarterType();"
									
								});
								Mform0.addField(radio004);
								Mform0.setValue("radiogroup002", '${formTrigger.startType}');
						</script>
						
						<script>
							<%String eventUserNames = (String) request
									.getAttribute("eventUserNames");
							if (eventUserNames == null) {
								eventUserNames = "";
							}%>
							var startersName = isc.TextItem.create( {
								ID : "MeventUserName",
								name : "eventUserName",
								editorType : "TextItem",
								displayId : "eventUserName_div",
								position : "relative",
								autoDraw : false,
								width : 144,
								hint : "请选择指定人员",
								showHintInField : true,
								value :"<%=eventUserNames%>",
								click : "showSelectPersons();",
								canEdit : false
							});
							Mform0.addField(startersName);
						</script>
													
						<script>
							var radio005 = isc.RadioItem.create( {
								ID : "Mradio005",
								name : "radiogroup002",
								title : '当前流程发起人',
								editorType : "RadioItem",
								displayId : "radio005_div",
								value : "0",
								groupId : "radiogroup002",
								position : "relative",
								width : 116,
								autoDraw : false,
								title : "当前流程发起人",
								change : "chageStarterType();"
							});
							Mform0.addField(radio005);
							Mform0.setValue("radiogroup002", '${formTrigger.startType}');
						</script>
					</td>
				</tr>
				<tr id="tr099">
					<td id="td099" class="tdLayout" style="width: 70%;" colspan="2">
						<div style="width: 100%;">
							<div id="radio006_div" eventProxy="Mform0" class=""
								style="width: 15%; float: left;"></div>
							<div style="float: left; margin-top: 5px;">
								选择流程：
							</div>
							<div style="width: 33%; float: left;">
								<div id="input098_div" eventProxy="Mform0" class="" style=""></div>
							</div>
							<div style="float: left; margin-top: 5px;">
								选择节点：
							</div>
							<div style="width: 30%; float: left;">
								<div id="input005_div" eventProxy="Mform0" class="" style=""></div>
							</div>
						</div>
						<script>
							var radio006 = isc.RadioItem.create( {
								ID : "Mradio006",
								name : "radiogroup002",
								title : '选定节点',
								editorType : "RadioItem",
								displayId : "radio006_div",
								value : "2",
								groupId : "radiogroup002",
								position : "relative",
								width : 82,
								autoDraw : false,
								title : "选定节点",
								change : "chageStarterType();"
							});
							Mform0.addField(radio006);
							Mform0.setValue("radiogroup002", '${formTrigger.startType}');
						</script>
						<script>
							var input098 = isc.TextItem.create({
								ID : "Minput098",
								name : "input098",
								editorType : "TextItem",
								displayId : "input098_div",
								position : "relative",
								autoDraw : false,
								width : "100%",
								canEdit : true,
								click : "selectFlow('input098');",
								hint :　"请选择流程",
								showHintInField : true,
								canEdit : false,
								value :　"<%=request.getAttribute("eventFlowName") == null
										? ""
										: (String) request.getAttribute("eventFlowName")%>"
							});
							Mform0.addField(input098);
						</script>
						<script>
							<%String actName = (String) request.getAttribute("actName");
									if (actName == null) {
										actName = "";
									}%>
							var input005 = isc.TextItem.create( {
								ID : "Minput005",
								name : "input005",
								width : "100%",
								editorType : "TextItem",
								displayId : "input005_div",
								position : "relative",
								autoDraw : false,
								hint : "请选择选定节点",
								showHintInField : true,
								value: "<%=actName%>",
								click : "showPoint('input005');",
								canEdit : false
							});
							Mform0.addField(input005);
						</script>
					</td>
				</tr>
				<tr id="tr011">
					<td id="td021" class="maintain_form_label" style="width: 30%;">
						<label id="label012" name="label012" id="label012"
							style="color: red;">
							*
						</label>
						<label id="label013" name="label013" id="label013">
							流程模板
						</label>
					</td>
					<td id="td022" colspan="2" style="width: 70%;">
						<div id="inputTextArea003_div" eventProxy="Mform0"
							class="matrixInline" style="width: 100%;"></div>
						<script>
							var inputTextArea003 = isc.TextItem.create( {
								ID : "MinputTextArea003",
								name : "inputTextArea003",
								editorType : "TextItem",
								displayId : "inputTextArea003_div",
								position : "relative",
								autoDraw : false,
								width : "100%",
								click : "selectFlow('inputTextArea003');",
								value : "<%=request.getAttribute("lcmb") == null
											? ""
											: (String) request.getAttribute("lcmb")%>",
								hint : "请选择流程模板",
								showHintInField : true,
								canEdit : false
							});
							Mform0.addField(inputTextArea003);
						</script>
					</td>
				</tr>
				<tr id="tr012">
					<td id="td023" class="maintain_form_label" style="width: 30%">
						<label id="label014" name="label014" id="label014"
							style="color: red;">
							*
						</label>
						<label id="label015" name="label015" id="label015">
							消息接收人
						</label>
					</td>
					<td id="td024" class="tdLayout" colspan="2" style="width: 70%;">
						<div id="input003_div" eventProxy="Mform0" class="matrixInline"
							style="width: 50%;"></div>
						<%
							String receiverNames = (String) request
									.getAttribute("receiverNames");
							if (receiverNames == null) {
								receiverNames = "";
							}
						%>
						<script>
							var input003 = isc.TextItem.create( {
								ID : "Minput003",
								name : "input003",
								editorType : "TextItem",
								displayId : "input003_div",
								position : "relative",
								autoDraw : false,
								width : "100%",
								click : "showSelectPersons();",
								value : "<%=receiverNames%>",
								hint : "请选择消息接收人",
								showHintInField : true,
								canEdit : false
							});
							Mform0.addField(input003);
						</script>
					</td>
				</tr>
				<tr id="tr013">
					<td id="td025" class="maintain_form_label" style="width: 30%;">
						<label id="label016" name="label016" id="label016"
							style="color: red;">
							*
						</label>
						<label id="label017" name="label017" id="label017">
							消息模板
						</label>
					</td>
					<td id="td026" colspan="2" style="width: 70%;">
						<div id="inputTextArea004_div" eventProxy="Mform0"
							class="matrixInline" style="width: 50%;"></div>
						<script>
							var inputTextArea004 = isc.TextAreaItem.create( {
								ID : "MinputTextArea004",
								name : "inputTextArea004",
								editorType : "TextAreaItem",
								displayId : "inputTextArea004_div",
								position : "relative",
								autoDraw : false,
								width : '100%',
								value : '${requestScope.msgContent == null?"":requestScope.msgContent}',
								height : 62,
								hint : "请选择消息模板",
								showHintInField : true,
								click : "showMsgContent();",
								canEdit : false
							});
							Mform0.addField(inputTextArea004);
						</script>
					</td>
				</tr>
				<tr id="tr014">
					<td id="td027" class="maintain_form_label" style="width: 30%;">
						<label id="label018" name="label018" id="label018"
							style="color: red;">
							*
						</label>
						<label id="label019" name="label019" id="label019">
							目标表单
						</label>
					</td>
					<td id="td028" class="tdLayout" colspan="2" style="width: 70%">
						<div id="input097_div" eventProxy="Mform0" class="matrixInline"
							style="width:100%"></div>
						<script>
							var input097 = isc.TextItem.create( {
							ID : "Minput097",
							name : "input097",
							editorType : "TextItem",
							displayId : "input097_div",
							position : "relative",
							autoDraw : false,
							width : "100%",
							value : "<%=request.getAttribute("targetFormName")==null?"":request.getAttribute("targetFormName")%>",
							hint : "请选择目标表单",
							showHintInField : true,
							click : "showFormTree();",
							canEdit : false
							});
							Mform0.addField(input097);
						</script>

					</td>
				</tr>
				<tr id="tr015">
					<td id="td029" class="maintain_form_label" style="width: 30%">
						<label id="label020" name="label020" id="label020"
							style="color: red;">
							*
						</label>
						<label id="label021" name="label021" id="label021">
							操作类型
						</label>
					</td>
					<td id="td030" class="tdLayout" colspan="2" style="width: 70%">
						<div id="comboBox002_div" eventProxy="Mform0" class="matrixInline"
							style="width:100%"></div>
						<script>
							var McomboBox002_VM = [];
							var comboBox002 = isc.SelectItem.create( {
								ID : "McomboBox002",
								name : "comboBox002",  //eventType 字段
								editorType : "SelectItem",
								displayId : "comboBox002_div",
								autoDraw : false,
								valueMap : [],
								value : "add",
								position : "relative",
								changed : "hiddenType();"
							});
							Mform0.addField(comboBox002);
							McomboBox002_VM = [ 'add', 'update'];
							McomboBox002.displayValueMap = {
								'add' : '增加',
								'update' : '修改'
							};
							McomboBox002.setValueMap(McomboBox002_VM);
							McomboBox002.setValue('${formTrigger.operateType==null?"add":formTrigger.operateType}');
						</script>
					</td>
				</tr>
				<tr id="tr016">
					<td id="td031" class="maintain_form_label" style="width: 30%;">
						<label id="label022" name="label022" id="label022">
							数据拷贝设置
						</label>
					</td>
					<td id="td032" class="tdLayout" colspan="2" style="width: 70%;">
						<div id="button003_div" class="matrixInline"
							style="position: relative;; width: 100px;; height: 22px;">
						<script>
								isc.Button.create( {
									ID : "Mbutton003",
									name : "button003",
									title : "设置",
									displayId : "button003_div",
									position : "absolute",
									top : 0,
									left : 0,
									width : "100%",
									height : "100%",
									showDisabledIcon : false,
									showDownIcon : false,
									showRollOverIcon : false
								});
								Mbutton003.click = function() {
									Matrix.showMask();
									showDataCopySet();
									Matrix.hideMask();
								};
						</script>
					</td>
				</tr>
				<tr id="tr022" style="display:none">
					<td id="td02_22" class="maintain_form_label" style="width: 30%">
						<label id="label020" name="label020" id="label020"
							style="color: red;">
							*
						</label>
						<label id="label021" name="label021" id="label021">
							预前控制
						</label>
					</td>
					<td id="td01_22" colspan="2" rowspan="1" style="width:70%;">
						<div id="checkBox001_div" class="matrixInline" eventProxy="Mform0"></div>
						<script>
							 var checkBox001=isc.CheckboxItem.create({
				 				 ID:"McheckBox001",
				 				 name:"checkBox001",
				 				 title:'启用',
				 				 editorType:"CheckboxItem",
				 				 displayId:"checkBox001_div",
				 				 valueMap:{"":false,"true":true},
				 				 position:"relative",
				 				 autoDraw:false,
				 				 height:25,
				 				 title:"启用"
			 				 });
			 				 Mform0.addField(checkBox001);
			 				 Mform0.setValue("checkBox001",'${formTrigger.beforeControl}');
						</script>
					</td>
				</tr>
				<tr id="tr017">
					<td id="td033" class="maintain_form_label" colspan="3" rowspan="1"
							style="width: 100%;height:30px">
							&nbsp;
					<div id="button001_div" class="matrixInline" style="position: relative;; width: 100px;; height: 30px;">
					<script><!--
						isc.Button.create( {
							ID : "Mbutton001",
							name : "button001",
							title : "保存",
							displayId : "button001_div",
							position : "absolute",
							top : 0,
							left : 0,
							width : "100%",
							height : "100%",
							icon : "[skin]/images/matrix/actions/save.png",
							showDisabledIcon : false,
							showDownIcon : false,
							showRollOverIcon : false
						});
						Mbutton001.click = function() {
							Mbutton001.disable();
							Matrix.showMask();
							var x = eval("validation();");
							if (x != null && x == false) {
								Matrix.hideMask();
								Mbutton001.enable();
								return false;
							}
							if (!true) {
								Matrix.hideMask();
								Mbutton001.enable();
								return false;
							}
							if (!Mform0.validate()) {
								Matrix.hideMask();
								Mbutton001.enable();
								return false;
							}
							
							var synJson = Matrix.formToObject('form0');
							synJson.comboBox001 = Matrix.getFormItemValue('comboBox001');
							synJson.comboBox002 = Matrix.getFormItemValue('comboBox002');
							var optString = Matrix.getFormItemValue('optString');
							var url = null;
							var index = Matrix.getFormItemValue('index');
							if(optString == '0'){
								url = "<%=request.getContextPath()%>/trigger/formProcessor_add.action";
							}else{
								url = "<%=request.getContextPath()%>/trigger/formProcessor_edit.action?index="+index;
								}
								
								Matrix.sendRequest(url,synJson,function(data){
									if(data != null && data.data != null){
										var json = isc.JSON.decode(data.data);
										if(json.result){
											Matrix.setFormItemValue('optString','1');
											Matrix.setFormItemValue('index',json.index);
											parent.Matrix.refreshDataGridData('DataGrid001');
											Mbutton001.enable();
											Matrix.say('保存成功');
										}else{
											alert("该触发器已存在，请更换名称");
											Mbutton001.enable();
										}
									}
								});
										
								Matrix.hideMask();
							};
						--></script>
						</div>
					</td>
				</tr>
			</table>
			<script>
				function getParamsForpersons() {
					var params = '&';
					var value;
					return params;
				}
				isc.Window.create( {
					ID : "Mpersons",
					id : "persons",
					name : "persons",
					autoCenter : true,
					position : "absolute",
					height : "80%",
					width : "80%",
					title : "指定人员",
					canDragReposition : true,
					showMinimizeButton : false,
					showMaximizeButton : true,
					showCloseButton : true,
					showModalMask : false,
					modalMaskOpacity : 0,
					isModal : true,
					autoDraw : false,
					headerControls : [ "headerIcon", "headerLabel", "minimizeButton",
							"maximizeButton", "closeButton" ],
					getParamsFun : getParamsForpersons,
					initSrc : "<%=request.getContextPath()%>/form/admin/custom/trigger/selectPerson.jsp",
					src : "<%=request.getContextPath()%>/form/admin/custom/trigger/selectPerson.jsp",
					showFooter : false
				});
			</script>
			<script>
				Mpersons.hide();
			</script>
			<script>
				function getParamsForflow() {
					var params = '&';
					var value;
					value = null;
					try {
						value = eval("1");
					} catch (error) {
						value = "1"
					}
					if (value != null) {
						value = "test=" + value;
						params += value;
					}
					return params;
				}
				isc.Window.create( {
					ID : "Mflow",
					id : "flow",
					name : "flow",
					autoCenter : true,
					position : "absolute",
					height : "50%",
					width : "50%",
					title : "选择流程",
					canDragReposition : true,
					showMinimizeButton : false,
					showMaximizeButton : true,
					showCloseButton : true,
					showModalMask : false,
					modalMaskOpacity : 0,
					isModal : true,
					autoDraw : false,
					headerControls : [ "headerIcon", "headerLabel", "minimizeButton",
							"maximizeButton", "closeButton" ],
					getParamsFun : getParamsForflow,
					initSrc : "<%=request.getContextPath()%>/form/admin/foundation/selectProcessTree.jsp",
					src : "<%=request.getContextPath()%>/form/admin/foundation/selectProcessTree.jsp",
					showFooter : false
				});
			</script>
			<script>
				Mflow.hide();
			</script>

			<script>
				function getParamsForcheckPoint() {
					var componentId = Matrix.getFormItemValue('componentId');
					var flowId ;
					if(componentId == 'input007'){
						flowId = Matrix.getFormItemValue('checkPointFlowId');
					}
					if(componentId == 'input005'){
						flowId = Matrix.getFormItemValue('eventFlowId');
					}
					var params = '&';
					var value;
					value = null;
					try {
						value = eval(flowId);
					} catch (error) {
						value = flowId
					}
					if (value != null) {
						value = "flowId=" + value;
						params += value;
					}
					return params;
				}
				isc.Window.create( {
					ID : "McheckPoint",
					id : "checkPoint",
					name : "checkPoint",
					autoCenter : true,
					position : "absolute",
					height : "50%",
					width : "50%",
					title : "选择流程节点",
					canDragReposition : true,
					showMinimizeButton : false,
					showMaximizeButton : true,
					showCloseButton : true,
					showModalMask : false,
					modalMaskOpacity : 0,
					isModal : true,
					autoDraw : false,
					headerControls : [ "headerIcon", "headerLabel", "minimizeButton",
							"maximizeButton", "closeButton" ],
					getParamsFun : getParamsForcheckPoint,
					initSrc : "<%=request.getContextPath()%>/trigger/checkPoint_getPointList.action",
					src : "<%=request.getContextPath()%>/trigger/checkPoint_getPointList.action",
					showFooter : false
				});
			</script>
			<script>
				isc.Window.create( {
					ID : "MformTree",
					id : "formTree",
					name : "formTree",
					autoCenter : true,
					position : "absolute",
					height : "50%",
					width : "50%",
					title : "选择目标表单",
					canDragReposition : true,
					showMinimizeButton : false,
					showMaximizeButton : true,
					showCloseButton : true,
					showModalMask : false,
					modalMaskOpacity : 0,
					isModal : true,
					autoDraw : false,
					headerControls : [ "headerIcon", "headerLabel", "minimizeButton",
							"maximizeButton", "closeButton" ],
					initSrc : "<%=request.getContextPath()%>/form/admin/custom/trigger/selectFormTree.jsp",
					src : "<%=request.getContextPath()%>/form/admin/custom/trigger/selectFormTree.jsp",
					showFooter : false
				});
		</script>

		<script>
			function getParamsFordataCopy() {
				var operateType = Matrix.getFormItemValue('comboBox002');
				var targetFormId = Matrix.getFormItemValue('targetFormId');
				var optString = <%=request.getParameter("optString")%>;
				var dataCopyStr = Matrix.getFormItemValue('dataCopyStr');
				var params = '&';
				var value;
				value = null;
				try {
					value = eval(operateType);
				} catch (error) {
					value = operateType;
				}
				if (value != null) {
					value = "operateType=" + value;
					params += value;
				}
				params += "&";
				try {
					value = eval(optString);
				} catch (error) {
					value = optString;
				}
				if (value != null) {
					value = "optString=" + value;
					params += value;
				}
				params += "&";
				try {
					value = eval(targetFormId);
				} catch (error) {
					value = targetFormId;
				}
				if (value != null) {
					value = "targetFormId=" + value;
					params += value;
				}
				return params;
			}
			isc.Window.create( {
				ID : "MdataCopy",
				id : "dataCopy",
				name : "dataCopy",
				autoCenter : true,
				position : "absolute",
				height : "80%",
				width : "50%",
				title : "数据复制设置",
				canDragReposition : true,
				showMinimizeButton : true,
				showMaximizeButton : true,
				showCloseButton : true,
				showModalMask : false,
				modalMaskOpacity : 0,
				isModal : true,
				autoDraw : false,
				headerControls : [ "headerIcon", "headerLabel", "minimizeButton",
						"maximizeButton", "closeButton" ],
				getParamsFun : getParamsFordataCopy,
				initSrc : "<%=request.getContextPath()%>/form/admin/custom/trigger/betweenLayer.jsp",
				src : "<%=request.getContextPath()%>/form/admin/custom/trigger/betweenLayer.jsp",
				showFooter : false
			});
		</script>
		<script>
			Mflow.hide();
		</script>

		<script>
			isc.Window.create( {
				ID : "Mcondition",
				id : "condition",
				name : "condition",
				autoCenter : true,
				position : "absolute",
				height : "80%",
				width : "70%",
				title : "首次满足条件",
				canDragReposition : true,
				showMinimizeButton : false,
				showMaximizeButton : true,
				showCloseButton : true,
				showModalMask : false,
				modalMaskOpacity : 0,
				isModal : true,
				autoDraw : false,
				headerControls : [ "headerIcon", "headerLabel", "minimizeButton",
						"maximizeButton", "closeButton" ],
				showFooter : false
			});
		</script>
		<script>
			Mcondition.hide();
		</script>
		<script>
			isc.Window.create( {
				ID : "MmsgContent",
				id : "msgContent",
				name : "msgContent",
				autoCenter : true,
				position : "absolute",
				height : "80%",
				width : "70%",
				title : "消息模板",
				canDragReposition : true,
				showMinimizeButton : false,
				showMaximizeButton : true,
				showCloseButton : true,
				showModalMask : false,
				modalMaskOpacity : 0,
				isModal : true,
				autoDraw : false,
				headerControls : [ "headerIcon", "headerLabel", "minimizeButton",
						"maximizeButton", "closeButton" ],
				showFooter : false
			});
		</script>
		<script>
			MmsgContent.hide();
		</script>
		
		</form>
		</div>
		
		<script>
			Mform0.initComplete = true;
			Mform0.redraw();
			isc.Page.setEvent(isc.EH.RESIZE, function() {
				isc.Page.setEvent(isc.EH.RESIZE, "Mform0.redraw()", null);
			}, isc.Page.FIRE_ONCE);
		</script>
	</body>
</html>
