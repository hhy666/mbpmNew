<%@page import="com.matrix.app.MAppProperties"%>
<%@page import="com.matrix.app.MAppContext"%>
<%@page import="com.matrix.form.api.MFormContext"%>
<%@page import="com.matrix.commonservice.data.DataService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>租户登录页面</title>
<jsp:include page="/form/html5/admin/html5Head.jsp"/>
<style type="text/css">
	body{
	    margin: 0;
	    padding: 0;
	    font-size: 14px;
	    font-family: "Helvetica Neue", "PingFang SC", "Hiragino Sans GB", "Microsoft YaHei", 微软雅黑, Arial, sans-serif;
	    position: absolute;
	    top: 0;
	    left: 0;
	    right: 0;
	    bottom: 0;
	    background: #f7f7f7;
	    -webkit-font-smoothing: antialiased;
	}
	div{
		box-sizing: border-box;
	}
	.account-logo {
	    position: absolute;
	    top: 60px;
	    left: 100px;
	}
	.account-logo>span {
	    height: 40px;
	    display: block;
	}
	.account-title{
		font-size: 20px;
	    font-weight: bold;
	    color: #1375ba;
	    line-height: 40px;
	}
	img {
	    border: 0;
	    outline: 0;
	}
	.account-pane-container {
	    position: absolute;
	    top: 50%;
	    left: 50%;
	    -webkit-transform: translate(-50%,-50%);
	    -moz-transform: translate(-50%,-50%);
	    -ms-transform: translate(-50%,-50%);
	    -o-transform: translate(-50%,-50%);
	    transform: translate(-50%,-50%);
	}
	.account-pane.account-pane-signin {
	    width: 740px;
	}
	.account-pane {
	    width: 400px;
	    -webkit-box-shadow: 0 5px 10px 0 rgba(28,5,62,.05), 0 10px 40px 0 rgba(23,26,53,.05);
	    box-shadow: 0 5px 10px 0 rgba(28,5,62,.05), 0 10px 40px 0 rgba(23,26,53,.05);
	}
	.account-pane .signin-container-banner {
	    display: inline-block;
	    position: relative;
	    width: 340px;
	    height: 450px;
	    vertical-align: middle;
	}
	.account-pane .signin-container-banner .banner-background {
	    position: absolute;
	    top: 0;
	    left: 0;
	    z-index: -1;
	    width: 100%;
	    -webkit-border-radius: 2px 0 0 2px;
	    -moz-border-radius: 2px 0 0 2px;
	    border-radius: 2px 0 0 2px;
	}
	.account-pane .account-container.signin-container {
	    -webkit-border-radius: 0 2px 2px 0;
	    -moz-border-radius: 0 2px 2px 0;
	    border-radius: 0 2px 2px 0;
	}
	.account-pane .account-container {
	    position: relative;
	    background: #fff;
	    display: inline-block;
	    vertical-align: middle;
	    width: 400px;
	    -webkit-border-radius: 2px;
	    -moz-border-radius: 2px;
	    border-radius: 2px;
	}
	.signin-container {
	    min-height: 450px;
	}
	.signin-container .signin-menu {
	    background: #fff;
	    text-align: center;
	    line-height: 60px;
	    border-bottom: solid 1px #e9e9e9;
	    -webkit-border-radius: 0 2px 0 0;
	    -moz-border-radius: 0 2px 0 0;
	    border-radius: 0 2px 0 0;
	}
	.signin-container .signin-content {
	    position: relative;
	    padding: 70px 40px 50px 40px;
	}
	.signin-container .signin-content .signin-row {
	    position: relative;
	}
	
	.signin-container .signin-content #signin-btn {
	    margin: 40px 0 20px;
	}
	.x-btn.style-green {
	    color: #fff;
	    background-color: #178cdf;
	    border-color: #178cdf;
	}
	.x-btn.style-green:hover {
	    background-color: #1375ba;
	    border-color: #1375ba;
	}
	input{
	    text-overflow: ellipsis;
	    white-space: nowrap;
	    background-color: rgb(255, 255, 255);
	    background-image: none;
	    vertical-align: middle;
	    box-shadow: none;
	    width: 100%;
	    height: 36px;
	    overflow: hidden;
	    -webkit-appearance: none;
	    padding: 3px 8px;
	    margin: 0;
	    outline: 0;
	    border: 1px solid #ccc;
	    border-radius: 2px;
	    transition: border-color 218ms ease 0s;
	}
	.account-pane input{
	    padding-left: 12px;
	}
	input:focus{
		 border: 1px solid #178cdf;
	}
	/* WebKit browsers  */
	input::-webkit-input-placeholder {
		color:#C9CED9
	}
	/*  Mozilla Firefox 4-18使用伪类 */
	input:-moz-placeholder {
	     color:#C9CED9
	}
	/* Mozilla Firefox 19+ 使用伪元素  */
	input::-moz-placeholder { 
	  	color:#C9CED9
	}
	/* IE10使用伪类 */
	input:-ms-input-placeholder {
	  	color:#C9CED9
	}
</style>
<%
	String m_appId=request.getParameter("m_appId");
	if(m_appId==null||m_appId.trim().length()==0){
		m_appId=(String)request.getAttribute("m_appId");
	}
	DataService dataService = MFormContext.getService("DataService");
	//是否启用了租户
	boolean isTenantEnable = MAppProperties.getInstance().isTenantEnable();
	boolean isExistApp = false;  //默认不存在改应用
	String appName = "";  //应用名称
	
	if(isTenantEnable){	  //启用租户了去校验应用是否存在		
		if(m_appId!=null&&m_appId.trim().length()>0){
			appName = (String) dataService.querySqlValue("select APP_NAME from mf_tmpl_application where APP_ID = '"+m_appId+"'", null, null);
			if(appName!=null && appName.trim().length()>0){
				isExistApp = true;
			}
		}
	}
	
	
	
%>
<script type="text/javascript">
	if (window != top) {
		top.location.href = location.href;
	}
	window.onload = function(){
		debugger;
		var isTenantEnable = "<%=isTenantEnable %>";
		if(isTenantEnable == 'false'){
			Matrix.warn("不支持租户~!");
			return;
		}
		var m_appId = "<%=m_appId %>";
		if(m_appId == 'null'){
			Matrix.warn("该应用不存在~!");
			return;
		}
		var isExistApp = "<%=isExistApp %>";
		if(isExistApp == 'false'){
			Matrix.warn("该应用不存在~!");
			return;
		}
		
		var appName = "欢迎使用: "+"<%=appName %>"
		//左上角系统标题设置
		document.getElementById("account-title").innerText = appName;	
	}
	//登录
	function login(){
		Matrix.showMask2();
		//表单验证
		if (!Matrix.validateForm('form0')) {
			Matrix.hideMask2();
			return false;
		}
	    document.getElementById('form0').submit();
	    Matrix.hideMask2();
	}
	
	function reImg(){
		if(document.getElementById("invalidUser"))
			document.getElementById("invalidUser").style.display ="none";
		 	var img = document.getElementById("img");  
		img.src = "<%=request.getContextPath()%>/ImageServlet?d="+ Math.random();
	}
</script>
</head>
<body>
	<form id="form0" name="form0" method="post" action="<%=request.getContextPath()%>/logon/logon_logon.action?m_appId=<%=m_appId%>" style="margin:0px;overflow:hidden;height:100%;" enctype="application/x-www-form-urlencoded">
		<input type="hidden" name="form0" value="form0" />
		<input type="hidden" id="validateType" name="validateType" value="jquery" /> 
		
		<div id="matrixMask" name="matrixMask" class="matrixMask" style="width: 100%; height: 100%; position: absolute;top: 1;left: 1;z-index: 9999999999999;display: none;"></div>
				
		<div class="account-logo" href="/"><span class="account-title" id="account-title"></div>
		<div class="account-pane-container">
			<div class="account-pane account-pane-signin">
				<a class="signin-container-banner" target="_blank">
					<img class="banner-background" style="width:100%;height:100%;" src="<%=request.getContextPath()%>/resource/images/tenantbanner.png">
				</a><div class="account-container signin-container">
					<div class="signin-menu">账号登录</div>
					<div class="signin-content">
						<div class="signin-row">
							<input id="logonName" name="logonName" type="text" placeholder="用户名" required="required" onkeydown='if(event.keyCode==13){login();}'>
							<%
								Object InvalidUser = request.getAttribute("InvalidUser");
								if (InvalidUser != null) {
							%>
							<label id="invalidUser" class="logonDIV_matrix"
								style="color: red; font-size: 10px; height: 32px; line-height: 32px;margin-left: 10px">无效</label>
							<%
								} else {
							%>
							<%
								}
							%>
						</div>
						<div class="signin-row" style="margin-top: 15px;">
							<input name="password" type="password" placeholder="密码" required="required" onkeydown='if(event.keyCode==13){login();}'>
							<%
								Object InvalidPsd = request.getAttribute("InvalidPsd");
								if (InvalidPsd != null) {
							%>
							<label id="invalidUser" class="logonDIV_matrix"
								style="color: red; font-size: 10px; height: 32px; line-height: 32px;margin-left: 10px">无效</label>
							<%
								} else {
							%>
							<%
								}
							%>
						</div>
						<div class="signin-row" style="margin-top: 15px;">
							<input type="text" id="code" name="code" placeholder="请输入验证码"
								required style="width: 72%;" onkeydown='if(event.keyCode==13){login();}'/> <a href="javascript:reImg();"><img
								id="img"
								src="<%=request.getContextPath()%>/ImageServlet?d=<%=System.currentTimeMillis()%>"
								style="vertical-align: top; height: 26px; margin-top: 2px; margin-left: 10px;"></a>
							<%
								Object InvalidCode = request.getAttribute("InvalidCode");
								System.out.print(InvalidCode);
								if (InvalidCode != null) {
							%>
							<label id="invalidUser" class="logonDIV_matrix"
								style="color: red; font-size: 10px; height: 32px; line-height: 32px; margin-left: 10px">错误验证码!</label>
							<%
								} else {
							%>
							<%
								}
							%>
						</div>
						<div class="signin-row" style="margin-top: 50px;">
							<div class="x-btn style-green"  onclick="login();">登录</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
</body>
</html>