<%@page pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<jsp:include page="/form/html5/admin/html5Head.jsp"/>
<title>Insert title here</title>
<script type="text/javascript">

	//添加变量
	function addEntityPro(){
	   var selects = $('#DataGrid001_table').bootstrapTable('getSelections');
	   if(selects!=null&&selects.length>0){
		   doubleClickSelect(selects[0]);
	   }else{
		   Matrix.warn('请先选中变量！');
	   }
	}
	
	function doubleClickSelect(selects){
		Matrix.closeWindow(selects);
	}

</script>
</head>
<body style="padding:5px">
	<input type="hidden" id="formId" name="formId" value="${param.formId}">
	<input type="hidden" id="entity" name="entity" value="${param.entity}">
	<input type="hidden" id="iframewindowid" name="iframewindowid" value="${param.iframewindowid}">
	<div style="display: block;overflow:auto;height:90%;padding:5px">
		<table id="DataGrid001_table" style="width:100%;height:100%;">
			<script>
				$(document).ready(function(){
					$("#DataGrid001_table").bootstrapTable({
						classes:'table table-bordered table-striped',
						method:'post',
						contentType : "application/x-www-form-urlencoded",
						url:'<%=path%>/designerVue/formDesignVue_getEntityProIdList.action',
						search: false, 
						sidePagination: "server", 
						singleSelect: true,
						clickToSelect: true, 
						sortable: false,   
						//pagination: true,
						onClickRow:function(row,$element){
							$('.info').removeClass('info');//移除class
		                    $($element).addClass('info');//添加class
						},
						onDblClickRow:function(row){
							doubleClickSelect(row);
						},
						queryParams: function(params){
							var param = {
								//offset: params.offset,
								//limit:params.limit,
								entity:$('#entity').val(),
							}
							return param;
						},
						//singleSelect:true,
						//sortable:false,
						//pageSize:20,
						//pageList:[10,20,30,40],
						formatLoadingMessage: function() {
			           	 	return '请稍等，正在加载中...';
				        },
				        formatNoMatches: function() {
				            return '无符合条件的记录';
				        },
						columns:[{
							title:' ',
				            checkbox: true
				        },{
							title:'序号',
							 formatter: function (value, row, index) { 
								var pageSize = $("#DataGrid001_table").bootstrapTable('getOptions').pageSize;
								var pageNumber = $("#DataGrid001_table").bootstrapTable('getOptions').pageNumber;
		                            return pageSize * (pageNumber - 1) + index + 1;  
		                        }
						},{
							field:'mid',
							title:'编码',
							editorType:'Text',
							clickToSelect: true,
							type:'Text'
						},{
							field:'name',
							title:'名称',
							editorType:'Text',
							clickToSelect: true,
							type:'Text'
						}]
					});
				});
			</script>
		</table>
	</div>
	<div class="cmdLayout">
		<button type="button" class="x-btn ok-btn " id="MtoolBarItemAdd" onclick="addEntityPro()">确定</button>
   		<button style="margin-left:5px;" id="button001" class="x-btn cancel-btn " type="button" onclick="Matrix.closeWindow()">取消</button>
  	</div>
</body>
</html>