<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>失败页面</title>
<script src="<%=request.getContextPath()%>/resource/html5/js/jquery.min.js"></script>
<script src='<%=request.getContextPath() %>/resource/html5/js/layer.min.js'></script>
<SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/js/matrix_runtime.js'></SCRIPT>
</head>
<body>
	 <script>
    	$(function(){	
    		Matrix.warn('服务器异常！');
    	})
    </script>
</body>
</html>