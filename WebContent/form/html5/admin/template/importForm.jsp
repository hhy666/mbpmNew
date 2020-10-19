<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.matrix.form.admin.catalog.model.CatalogInfo"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset='utf-8'/>
<%@ include file="/form/html5/admin/html5Head.jsp"%>
<link href='<%=request.getContextPath() %>/resource/html5/css/fileinput.min.css' rel="stylesheet"></link>
<script src='<%=request.getContextPath() %>/resource/html5/js/fileinput.min.js'></script>
<script src='<%=request.getContextPath() %>/resource/html5/js/zh.js'></script>
<style type="text/css">
	.mask {
		display: none;
        background-color: rgb(0, 0, 0);
        opacity: 0.3;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        z-index: 9999999
    }
</style>
<script type="text/javascript">
	$(function(){
		 var designType = document.getElementById('designType').value;
		 if(designType == 1){     //设计开发时上传表单模型
			 $('#uploadFile').fileinput({
				 language: 'zh',
				 enctype: 'multipart/form-data',
				 uploadAsync: false,   //同步上传
				 uploadExtraData: {
			         'uploadToken':'SOME-TOKEN', //用于访问控制/安全 
			     },
			     maxFileCount: 1,
			     allowedFileExtensions: ['xml'],   //只允许xml
				 showUpload: false,   //是否显示上传按钮
				 showRemove: false,   //是否显示删除/清空按钮。默认值true
				 showPreview: false,   //是否显示文件的预览图。默认值true
				 showCaption: false,  //是否显示文件标题，默认为true
				 showBrowse: true,    //是否显示文件浏览/选择按钮。默认值true
				 showCancel: false,     //是否显示文件上传取消按钮以中止正在进行的上传
				 msgPlaceholder: '请选择xml格式的文件',   //未选择文件时的提示信息
			 }).on('fileuploaded', function (event, data, previewId, index) {       //文件上传成功
				 console.log('文件上传成功'); 			
			 }).on('fileuploaderror', function(event, data, msg) {
				 console.log('文件上传错误'); 
			 });
		 }else{
			 $('#uploadFile').fileinput({
				 language: 'zh',
				 enctype: 'multipart/form-data',
				 uploadAsync: false,   //同步上传
				 uploadExtraData: {
			         'uploadToken':'SOME-TOKEN', //用于访问控制/安全 
			     },
			     maxFileCount: 1,
			     allowedFileExtensions: ['zip'],   //只允许zip
				 showUpload: false,   //是否显示上传按钮
				 showRemove: false,   //是否显示删除/清空按钮。默认值true
				 showPreview: false,   //是否显示文件的预览图。默认值true
				 showCaption: false,  //是否显示文件标题，默认为true
				 showBrowse: true,    //是否显示文件浏览/选择按钮。默认值true
				 showCancel: false,     //是否显示文件上传取消按钮以中止正在进行的上传
				 msgPlaceholder: '请选择zip格式的文件',   //未选择文件时的提示信息
			 }).on('fileuploaded', function (event, data, previewId, index) {       //文件上传成功
				 console.log('文件上传成功'); 			
			 }).on('fileuploaderror', function(event, data, msg) {
				 console.log('文件上传错误'); 
			 });
		 }	 
	})
</script>
</head>
<body>
<div style="width: 100%; height: 100%; overflow: auto; position: relative; margin: 0 auto; zoom: 1; padding: 10px 10px;" id="context">
  <form id="form0" name="form0" eventProxy="Mform0" method="post" style="margin:0px;position:relative;overflow:auto;width:100%;height:100%;" enctype="multipart/form-data">
	<div id="showModal" class="mask"></div>
	<!-- 1设计开发  2管理实施  3移动端 -->
	<input id="designType" name="designType" type="hidden" value="${param.designType }">
	<table id="table001" class="tableLayout" style="width: 100%;">
		<tr>
			<td class="tdLayout" style="width:40%;text-align:center;vertical-align:middle;background-color:rgb(248, 248, 248)">
				<label class="control-label ">选择文件：</label>
			</td>
			<td class="tdLayout" style="width:60%;">
				<input id="uploadFile" name="file" type="file" data-show-caption="true">
			</td>
		</tr>
		<tr>
			<td style="height:50px;"></td>
		</tr>
		<tr>
			<td class="cmdLayout" colspan="2" rowspan="1">
				<button type="button" id="button001" class="x-btn ok-btn ">确认</button>
				<button type="button" id="button002" class="x-btn cancel-btn ">取消</button>
				<script>
				$('#button001').click(function() {
					$('#button001').attr("disabled",true);
					var index = layer.load(0, {shade: false}); //0代表加载的风格，支持0-2
					document.getElementById('showModal').style.display = 'block';
					var designType = document.getElementById('designType').value;
					if($('.file-caption-name').val()=='' || $('.file-caption-name').attr('title')=='验证错误'){
						if(designType == 1){ 
							layer.alert('请选择一个xml文件！');
						}else{
							layer.alert('请选择一个zip文件！');
						}
						$('#button001').attr("disabled",false);
						layer.close(layer.load());//关闭加载层
						document.getElementById('showModal').style.display = 'none';
						return false;
					}
					var url = "";
					if(designType == 1){     //设计开发时上传表单模型
						url = "<%=path %>/file/importfile?importType=formModel&operation=importForm";
					}else{
						url = "<%=path %>/ImpAndExpFormServlet?flag=import";
					}					
					$('#form0').attr("action", url);
					$('#form0').submit();
				});

				$('#button002').click(function() {
					var index = parent.layer.getFrameIndex(window.name);
					parent.layer.close(index);
				});
			  </script>
			</td>
		</tr>
	</table>
 </form>
</div>
</body>
</html>
