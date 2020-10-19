<%@page import="com.matrix.app.MAppProperties"%>
<%@page import="com.matrix.engine.foundation.config.MFSystemProperties"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML>
<html>
<meta http-equiv='pragma' content='no-cache'>
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='0'>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<head>
<jsp:include page="/form/html5/admin/html5Head.jsp"/>
<title>h5设计开发表单版本列表</title>
<%
	//是否启用集团
	boolean isGroupEnable = MAppProperties.getInstance().isGroupEnable();
	String rootId = MFSystemProperties.getInstance().getDepRootValue();   //配置的根编码
%>
<script type="text/javascript">
var isGroupEnable = <%=isGroupEnable %>;
var rootId = "<%=rootId %>";

	//点击选择
	function singleClickSelect(row, element){
		$('#uuid').val(row.uuid);
		$('.changeColor').removeClass('changeColor');//去除之前选中的行的，选中样式
		$(element).addClass('changeColor');
		
		
		var entrance = $('#entrance').val();  // 入口  customForm：定制表单时表单版本入口
		if(entrance == 'customForm'){
			var phase = row.phase;   //3设计开发  4管理实施
			if(phase == 3){
				$('#MtoolBarItemDel').attr('disabled',true);
			}else{
				$('#MtoolBarItemDel').attr('disabled',false);
			}
		}
	}

	//添加表单版本[同步提交]
	function addFormVersion(){
	   
	    //将本页面的字段值赋值到父页面中
	    // parent.document.getElementById("version").value = addVersion;
	     
	     var Form0 =  parent.document.getElementById("Form0");
	     
	     var layoutType = document.getElementById("layoutType").value;
	     parent.document.getElementById("mid").value = "${formInfo.mid}";
	     parent.document.getElementById("name").value = "${formInfo.name}";
	     parent.document.getElementById("desc").value = "${formInfo.desc}";
	     
	     //parent.document.getElementById('Form0').action='<%=request.getContextPath()%>/form/formInfo_addFormVersion.action';
	     //parent.document.getElementById('Form0').submit();
	     
	     top.openAddFormVersion(Form0,this.window,layoutType);
	     
	     
	}
	
	//复制一个新的表单版本
	function copyFormVersion(){
		var $tr = $('#DataGrid001_table').find('tr.changeColor');   //选中行
		if($tr!=null && $tr.length==1){
			var index = $tr.data('index'); //获得选中的行的index
			var item = Matrix.getGridData('DataGrid001');   //所有数据
			var listSize = item.length;      //长度
			var record = item[index];  //当前选中行
			if(record!=null){
				  parent.document.getElementById("formUuid").value = record.uuid;		
			}else{
				Matrix.warn("请先选择表单版本!");
				return;
			}
		 	
			var orgId = record.orgId; 
			if(rootId!=orgId){
				Matrix.warn("分公司版本无法复制!");
				return;
			}
			
		    var Form0 =  parent.document.getElementById("Form0");
		    //将本页面的字段值赋值到父页面中
			//parent.document.getElementById("version").value = addVersion;
			var layoutType = document.getElementById("layoutType").value;
	
			parent.document.getElementById("mid").value = "${formInfo.mid}";
			parent.document.getElementById("name").value = "${formInfo.name}";
			parent.document.getElementById("desc").value = "${formInfo.desc}";
		     
		     
			top.openCopyFormVersion(Form0,this.window,layoutType);
			//parent.document.getElementById('Form0').action='<%=request.getContextPath()%>/form/formInfo_copyFormVersion.action';
		    //parent.document.getElementById('Form0').submit();
		}else{
			Matrix.warn("没有数据被选中，不能执行此操作。");
		}
	}
	
	//通过编辑按钮更新 
    function updateFormVersion(){
    	var $tr = $('#DataGrid001_table').find('tr.changeColor');   //选中行
		if($tr!=null && $tr.length==1){
			var index = $tr.data('index'); //获得选中的行的index
			var item = Matrix.getGridData('DataGrid001');   //所有数据
			var listSize = item.length;      //长度
			var record = item[index];  //当前选中行
			if(record!=null){
	    		doubleClickUpdateFormVersion(record);
			}else{
				Matrix.warn("请先选择表单版本!");
			}
		}else{
			Matrix.warn("没有数据被选中，不能执行此操作。");
		}
    
    }
	
  	//双击实现修改模型 
	function doubleClickUpdateFormVersion(record){
		 
		 
		 <%-- parent.document.getElementById("formUuid").value = record.uuid;
		 parent.document.getElementById('Form0').action='<%=request.getContextPath()%>/form/formInfo_updateFormVersion.action?state='+record.state;
	     parent.document.getElementById('Form0').submit();
	      --%>
	      var layoutType = document.getElementById('layoutType').value;
	      top.topWin = this.window;
	     top.layer.open({
	    	type:2,
			title:false,
			area:['100%','100%'],
			closeBtn:0,
 			content:'<%=request.getContextPath()%>/form/formInfo_updateFormVersion.action?name=${formInfo.name}&formUuid='+ record.uuid +'&state='+record.state + '&layoutType='+layoutType
	     });
	}
  	
  	
	//删除数据
    function deleteDataGridData(){
		var $tr = $('#DataGrid001_table').find('tr.changeColor');   //选中行
		if($tr!=null && $tr.length==1){
			var index = $tr.data('index'); //获得选中的行的index
			var item = Matrix.getGridData('DataGrid001');   //所有数据
			var listSize = item.length;      //长度
			var record = item[index];  //当前选中行
			var state = record.state;
			//是否发布
			if(state==1){
				Matrix.warn("表单已发布，不能执行删除操作。");
				return false;
			}
			
			//操作人是否为空
			var operator = record.operator;
			
			if(operator!=null&&operator.length>0){
				var currentUser = parent.document.getElementById('currentUser').value;
				if(currentUser!=null){
					if(currentUser!=operator){
						Matrix.warn('您当前未获得对该表单的操作权限!');
						return false;
					}
					
				}else{
					Matrix.warn('获取当前登录用户信息异常!');
					return false;
				}
			
			}
			Matrix.confirm('您确定要删除该表单版本？',function(data){
				if(true){
					var uuid = $('#uuid').val();
					var url ='<%=request.getContextPath()%>/form/formInfo_h5deleteFormVersion.action?uuid='+uuid;
					Matrix.sendRequest(url,null,function(datq){
						$('#DataGrid001_table').bootstrapTable('refresh');
						Matrix.success("删除成功！");
					});
				}
			});
		}else{
			Matrix.warn("没有数据被选中，不能执行此操作。");
		}
	}
	
	//表单版本授权
	function empowerFormVersion(){
		var $tr = $('#DataGrid001_table').find('tr.changeColor');   //选中行
		if($tr!=null && $tr.length==1){
			var index = $tr.data('index'); //获得选中的行的index
			var item = Matrix.getGridData('DataGrid001');   //所有数据
			var listSize = item.length;      //长度
			var record = item[index];  //当前选中行
			if(record!=null){
				var phase = record.phase; 
				if(phase==4){
					Matrix.warn("管理实施阶段的表单无法授权!");
					return false;
				}
				var state = record.state;
				//将 formUuid 
			    var formUuid = record.uuid;
			    /*
			    var modulePath = "";    
		        var url ="<%=request.getContextPath()%>/security/formSecurity_loadSecurityIndex.action?formUuid="+formUuid+"&modulePath="+modulePath;
		      	
				if(state==1){//发布
					url=url+"&state="+state;
				}
				layer.open({
					type:2,
					title:['表单授权'],
					area:['65%','80%'],
					content:url
				});
				*/
			    layer.open({
			        id:'m_dataPower',
			        type : 2,
			        title : ['表单授权'],
			        shade: [0.1, '#000'],
			        shadeClose: false, //开启遮罩关闭
			        area : [ '1200px', '700px' ],
			  	  	content : "../form/admin/security/secScopeList.html?entrance=ListOperationSet&formUuid="+formUuid+"&iframewindowid=m_dataPower"
			    });
			
			}else{
				Matrix.warn("请先选择表单版本!");
			}
		}else{
			Matrix.warn("没有数据被选中，不能执行此操作。");
		}
	}
	
	//导出权限
	function saveFormAuth2File(){
		var $tr = $('#DataGrid001_table').find('tr.changeColor');   //选中行
		if($tr!=null && $tr.length==1){
			var index = $tr.data('index'); //获得选中的行的index
			var item = Matrix.getGridData('DataGrid001');   //所有数据
			var listSize = item.length;      //长度
			var record = item[index];  //当前选中行
			//将 formUuid 
		    var formUuid = record.uuid; 
		    var formName = record.mid;
		    var flag = "exportMod";
	        var url ="<%=request.getContextPath()%>/ModelConvertDocumentHelper?formUuid="+formUuid+"&formName="+formName+"&flag="+flag;
	      	window.location.href = url;
		}else{
			Matrix.warn("请先选择表单版本!");
		}
	
	}
	
	//导入权限
	function importFile(){
		var $tr = $('#DataGrid001_table').find('tr.changeColor');   //选中行
		if($tr!=null && $tr.length==1){
			var index = $tr.data('index'); //获得选中的行的index
			var item = Matrix.getGridData('DataGrid001');   //所有数据
			var listSize = item.length;      //长度
			var record = item[index];  //当前选中行
			if(record!=null){
				var state = record.state;
				var formUuid = record.uuid; 
				var formName = record.mid;
				var flag = "importDoc";
     			var url = "<%=request.getContextPath()%>/form/formInfo_addSecurityFilePage.action?recordId="+formUuid+"&formName="+formName;
     			layer.open({
					type:2,
					title:['导入权限'],
					area:['65%','80%'],
					content:url
				});
  			}else{
  				Matrix.warn("请先选择表单版本!");
			}
		
		}else{
			Matrix.warn("请先选择表单版本!");
		}
	}

	 //发布表单
	function publishedForm() {
		var $tr = $('#DataGrid001_table').find('tr.changeColor');   //选中行
		if($tr!=null && $tr.length==1){
			var index = $tr.data('index'); //获得选中的行的index
			var item = Matrix.getGridData('DataGrid001');   //所有数据
			var listSize = item.length;      //长度
			var record = item[index];  //当前选中行
		    var state = record.state;
		    if(record.version==0){
		    	Matrix.warn("该版本不支持此操作!");
			 			return false;
			}
		    
		    if (state == 1) {
		    	Matrix.warn("您已经发布,请勿重复操作!");
		    } else if (state == 0) {
		        document.getElementById("state").value = 1;
		        document.getElementById("uuid").value = record.uuid;
		        //切换选择状态
		        document.getElementById('Form0').action ='<%=request.getContextPath()%>/form/formInfo_updateFormState.action';
		        Matrix.send("Form0",null,function(data){
						var dataStr = data.data;
					    if(dataStr!=null){
							var dataJson = isc.JSON.decode(dataStr);
							if(dataJson.message==true){//发布成功
								$('#DataGrid001_table').bootstrapTable('refresh');
		       					Matrix.success('发布成功! ');
							}else{
								Matrix.warn('操作失败,请确认表单模型是否校验通过！');
							}
					    }
					});
		      	return false;
		     }
		}else{
			Matrix.warn("没有数据被选中，不能执行此操作。");
		}
	 }
	 
	 
	//撤销发布
    function cancelPublishedForm(){
    	var $tr = $('#DataGrid001_table').find('tr.changeColor');   //选中行
		if($tr!=null && $tr.length==1){
			var index = $tr.data('index'); //获得选中的行的index
			var item = Matrix.getGridData('DataGrid001');   //所有数据
			var listSize = item.length;      //长度
			var record = item[index];  //当前选中行
	 		if(record.version==0){
	 			Matrix.warn("该版本不支持此操作!");
	 			return false;
	 		}
	        var state = record.state;
	        if(state==0){
	        	Matrix.warn("您还未发布,请勿执行此操作!");
	        }else if(state==1){
	        	document.getElementById("state").value=0;
	        	document.getElementById("uuid").value=record.uuid;

			   	document.getElementById('Form0').action='<%=request.getContextPath()%>/form/formInfo_updateFormState.action';
				Matrix.send("Form0",null,function(data){
					var dataStr = data.data;
				    if(dataStr!=null){
						var dataJson = isc.JSON.decode(dataStr);
						if(dataJson.message==true){//撤销发布成功
							$('#DataGrid001_table').bootstrapTable('refresh');
	       					Matrix.success('撤销发布成功!');
						}else{
							Matrix.warn('操作失败!');
						}
				    }
				});
				
			    return false;
	        }
		}else{
			Matrix.warn("没有数据被选中，不能执行此操作。");
		}
    }
	
    var winObj;
	var rowNum = null;  //当前操作设置行的顺序号
	//实施时 流程设计数据权限
	function onoperationSetClose(data){
		winObj.onoperationSetClose(data, rowNum);
	}
</script>
</head>
<body>
	<form id="Form0" name="Form0" eventProxy="MForm0" method="post" 
				action="<%=request.getContextPath()%>/form/formInfo_getFormVersions.action" style="margin:0px;height:100%;" 
				enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="Form0" value="Form0" />
	<!-- commom cols -->
	<input type="hidden" id="nodeUuid" name="nodeUuid" value="${formInfo.nodeUuid}">
	
	<!-- 实体类型 entity[1] or query Obj [2]  -->
	<input type="hidden" id="type" name="type" value="${formInfo.type}">
	<input type="hidden" id="version" name="version"/><!-- 添加时动态写入值 -->
	
	<input type="hidden" id="mid" name="mid" value="${formInfo.mid}">
	<input type="hidden" id="name" name="name" value="${formInfo.name}">
	<input type="hidden" id="desc" name="desc" value="${formInfo.desc}">
	<input type="hidden" id="createdUser" name="createdUser" value="${formInfo.createdUser }"/>  
	<!-- <input type="hidden" id="createdDate" name="createdDate" value="${formInfo.createdDate }"/>-->
	<input type="hidden" id="operatorName" name="operatorName" value="${formInfo.operatorName }"/>
	
	<!-- 布局类型 1表格 2网格 -->
	<input type="hidden" id="layoutType" name="layoutType" value="${layoutType }"/>
	
	<!-- 是否定制表单 -->
	<input type="hidden" id="isCustomForm" name="isCustomForm" value="${isCustomForm }"/>
	
	<input type="hidden" id="gridListName" name="gridListName" value="MDataGrid0"/>
	<input type="hidden" id="actionType" name="actionType"/>
	<input type="hidden" id="delete_data_rows" name="delete_data_rows">
	<input type="hidden" id="update_data_rows" name="update_data_rows">
	<input type="hidden" id="state" name="state">
	<input type="hidden" id="uuid" name="uuid">
	<!-- 是否启用集团 -->
	<input type="hidden" id="isGroupEnable" name="isGroupEnable" value="<%=isGroupEnable %>">
	<div style="display: block">
		<table class="query_form_content" style="height:100%;width:100%;overflow:hidden;border-collapse: collapse;border-spacing:0px;table-layout:fixed;">
	  			<tr style=" height: 0px">
				<td class="query_form_toolbar"icolspan="2" style="padding: 3px">
					<div style="/* padding:4px; */background: #f8f8f8;text-align: left;vertical-align: middle;height: 44px;border: 1px solid #E6E9ED;line-height: 44px;">
						<button type="button" class="btn  btn-default toolBarItem" id="MtoolBarItemAdd" style="padding-left:5px;padding-right:5px;margin:0px;border:0;" onclick="addFormVersion();">
							<img src="<%=path%>/resource/images/new.png" style="padding-right: 2px;">添加
						</button>
						<button type="button" class="btn  btn-default toolBarItem" id="MtoolBarItemEdit" style="padding-left:5px;padding-right:5px;margin:0px;border:0;" onclick="updateFormVersion();">
							<img src="<%=path%>/resource/images/edit.png" style="padding-right: 2px;">编辑
						</button>
						<button type="button" class="btn  btn-default toolBarItem" id="MtoolBarItemCopy" style="padding-left:5px;padding-right:5px;margin:0px;border:0;" onclick="copyFormVersion();">
							<img src="<%=path%>/resource/images/relatarc.png" style="padding-right: 2px;">复制
						</button>
						<button type="button" class="btn  btn-default toolBarItem" id="MtoolBarItemDel" style="padding-left:5px;padding-right:5px;margin:0px;border:0;" onclick="deleteDataGridData();">
							<img src="<%=path%>/resource/images/delete.png" style="padding-right: 2px;">删除
						</button>
						<button type="button" class="btn  btn-default toolBarItem" id="MtoolBarItemAuth" style="padding-left:5px;padding-right:5px;margin:0px;border:0;" onclick="empowerFormVersion();">
							<img src="<%=path%>/resource/images/setAuth.png" style="padding-right: 2px;">授权
						</button>
						<button type="button" class="btn  btn-default toolBarItem" id="MtoolBarItemImp" style="padding-left:5px;padding-right:5px;margin:0px;border:0;" onclick="importFile();">
							<img src="<%=path%>/resource/images/settop.png" style="padding-right: 2px;">导入权限
						</button>
						<button type="button" class="btn  btn-default toolBarItem" id="MtoolBarItemExp" style="padding-left:5px;padding-right:5px;margin:0px;border:0;" onclick="saveFormAuth2File();">
							<img src="<%=path%>/resource/images/canceltop.png" style="padding-right: 2px;">导出权限
						</button>
						<button type="button" class="btn  btn-default toolBarItem" id="MtoolBarItemPublish" style="padding-left:5px;padding-right:5px;margin:0px;border:0;" onclick="publishedForm();">
							<img src="<%=path%>/resource/images/submit.png" style="padding-right: 2px;">发布
						</button>
						<button type="button" class="btn  btn-default toolBarItem" id="MtoolBarItemRePublish" style="padding-left:5px;padding-right:5px;margin:0px;border:0;" onclick="cancelPublishedForm();">
							<img src="<%=path%>/resource/images/deletex.png" style="padding-right: 2px;">撤销发布
						</button>
					</div>
				</td>
			</tr>
		</table>
	</div>
	<div style="height: calc(100% - 54px);display: block">
		<table id="DataGrid001_table" style="width:100%;">
		</table>
		
		<script type="text/javascript">
			$(document).ready(function() { 
				var isGroupEnable = $('#isGroupEnable').val();  //是否启用集团
				var isCustomForm = $('#isCustomForm').val();  //是否定制表单
				var nodeUuid = $("#nodeUuid").val();
				$("#DataGrid001_table").bootstrapTable({           
					classes: 'table table-hover table-no-bordered',
					method: "post", 
					contentType : "application/x-www-form-urlencoded",  //必须配置 不然queryParams传参后台获取不到
					url: "<%=request.getContextPath() %>/form/formInfo_h5GetFormVersions.action?nodeUuid="+nodeUuid, 
					search: false,    //是否启用搜索框
					sortable: false,  //是否启用排序
					pagination:false, //是否启用分页
					sidePagination: "server",   //指定服务器端分页
					formatLoadingMessage: function() {
			            return '请稍等，正在加载中...';
				    },
					formatNoMatches: function() {
			            return '无符合条件的记录';
			        },
				    columns: [
				        {
				         title : '序号',
				         align: "center",
				         width: 50,
				         formatter: function (value, row, index) {
				        	  //获取每页显示的数量
				        	  var pageSize=$('#DataGrid001_table').bootstrapTable('getOptions').pageSize;  
				        	  //获取当前是第几页  
				        	  var pageNumber=$('#DataGrid001_table').bootstrapTable('getOptions').pageNumber;
				        	  //返回序号，注意index是从0开始的，所以要加上1
				        	  return pageSize * (pageNumber - 1) + index + 1;
				          }				 
					    },          
					    {title:"主键编码",field:"uuid",sortable:true,clickToSelect:true,editorType:'Text',type:'text',visible:false},
					    {title:"阶段",field:"phase",sortable:true,clickToSelect:true,editorType:'Text',type:'text',visible:false},
				        {title:"版本号",field:"version",sortable:true,clickToSelect:true,editorType:'Text',type:'text'},
				    	{title:"创建人",field:"createdUser",sortable:true,clickToSelect:true,editorType:'Text',type:'text'},
				    	{title:"创建时间",field:"createdDate",sortable:true,clickToSelect:true,editorType:'Text',type:'text'},
				    	{title:"发布人",field:"publishedUser",sortable:true,clickToSelect:true,editorType:'Text',type:'text'},
				    	{title:"发布时间",field:"publishedDate",sortable:true,clickToSelect:true,editorType:'Text',type:'text'},
				    	{title:"当前操作人",field:"operatorName",sortable:true,clickToSelect:true,editorType:'Text',type:'text'},
				    	{title:"机构名称",field:"orgName",sortable:true,clickToSelect:true,editorType:'Text',type:'text',visible:isGroupEnable=='true'?true:false},
				    	{title:"业务编码",field:"businessId",sortable:true,clickToSelect:true,editorType:'Text',type:'text',visible:false},
				    	{title:"业务名称",field:"businessName",sortable:true,clickToSelect:true,editorType:'Text',type:'text',visible:isCustomForm=='true'?true:false},
				    	{title:"状态",field:"state",sortable:true,clickToSelect:true,editorType:'Text',type:'text',
				    		formatter: function (value, row, index) {
				               if(value == '0') {
				                  return "未发布";
				               }else if(value == '1'){
				                  return "发布";
				               }
					        }
				    	}
				    ],
				    singleSelect:true,  //设置true将禁止多选
				    onClickRow:function(row, $element){   //单击行事件
				    	singleClickSelect(row, $element);
					},
				    onDblClickRow:function(row){   //双击行事件
				    	doubleClickUpdateFormVersion(row);
					},
			  });
		    });
		</script>
	</div>
</form>
</body>
</html>