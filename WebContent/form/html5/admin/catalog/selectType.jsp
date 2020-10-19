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
</head>
<body>
	<div style="width: 100%; height: 100%; overflow: auto; position: relative; margin: 0 auto; zoom: 1; padding: 10px 10px;" id="context">
		<form id="form0" name="form0" eventProxy="Mform0" method="post" action="" style="margin: 0px; position: relative; overflow: hidden; width: 100%; height: 100%;" enctype="application/x-www-form-urlencoded">
			<div id="showModal" class="mask"></div>
			<input type="hidden" id="type" name="type" value="${param.type}"/>
			<input type="hidden" id="uuid" name="uuid" value="${param.uuid}"/>
			<input type="hidden" id="flag" name="flag" value="${param.flag}"/>
			
			<div style="height:calc(100% - 54px);width: 100%;overflow: auto;">				
				<div style="height:40px;width:100%;line-height: 40px;">
					<font id="midfont" color="red" >请选择模块导出模式</font>
				</div>
				<div>
					<div style="float:left;width: 40%;text-align: center;vertical-align: middle;border: 1px solid #cccccc;border-right: 0px;padding: 3px;">
						<label class="control-label" style="line-height: 35px;">导出模式：</label>
					</div>
					<div style="margin-left: 40%;border: 1px solid #cccccc;padding: 3px;">
						<div id="exportType_div"> 
							<select id="exportType" name="exportType" class="form-control" style="height:100%;width:100%;">
								<option value="new">最新版本</option>
								<option value="all">所有版本</option>
							</select>
						</div> 
					</div>
				</div>
			</div>
			<div class="cmdLayout">
				<button type="button" id="button001" class="x-btn ok-btn">确定</button>
				<button type="button" id="button002" class="x-btn cancel-btn">关闭</button>
				<script type="text/javascript">
					$('#button001').click(function(){
						var index = layer.load(0, {shade: false}); //0代表加载的风格，支持0-2
						document.getElementById('showModal').style.display = 'block';
						var type = document.getElementById('type').value;
						var url;
						if(type == '1'){   //导出目录
							url = "<%=request.getContextPath() %>/Html5OperatorContentsHelper";
						}else if(type == '2'){   //导出模块
							url = "<%=request.getContextPath() %>/Html5OperatorModuleHelper";
						}
						$('#form0').attr("action", url);
						$('#form0').submit();
						layer.close(layer.load());//关闭加载层
						document.getElementById('showModal').style.display = 'none';
					});
					
					$('#button002').click(function(){
						var index = parent.layer.getFrameIndex(window.name);
						parent.layer.close(index);
					});
				</script>
			</div>
		</form>
	</div>
</body>
</html>