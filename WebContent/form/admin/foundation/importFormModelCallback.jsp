<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <meta http-equiv="pragma" content="no-cache">
        <meta http-equiv="cache-control" content="no-cache">
        <meta http-equiv="expires" content="0">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<script type="text/javascript">
			//导入成功
			var operation = '<%=request.getAttribute("operation")%>';
			if(operation == 'importForm'){  //vue版本导入表单
				parent.location.reload();
				parent.layer.alert(message);
				var index = parent.layer.getFrameIndex(window.name);
				parent.layer.close(index);
			}else{
				parent.Matrix.forceFreshTreeNode("Tree0", 'RootTreeNode');
				parent.isc.MH.importFormXMLSuccess();
			}			
		</script>
    </head>
    
    <body>
		    	
    </body>

</html>


