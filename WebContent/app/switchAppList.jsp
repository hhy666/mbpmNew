<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//Ddiv HTML 4.01 Transitional//EN" "http://www.w3.org/div/html4/loose.ddiv">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/js/jquery.min.js'></SCRIPT>
<SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/js/jquery.min.js'></SCRIPT>
<SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/js/jquery.inputmask.bundle.min.js'></SCRIPT>
<SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/css/bootstrap/dist/js/bootstrap.min.js'></SCRIPT>
<SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/js/icheck.min.js'></SCRIPT>
<SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/js/bootstrap-select.js'></SCRIPT>
<SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/js/select2.js'></SCRIPT>
<SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/js/layer.min.js'></SCRIPT>
<SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/js/autosize.min.js'></SCRIPT>
<script src="<%=request.getContextPath() %>/resource/html5/js/demo.js"></script>
<SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/js/laydate/laydate.js'></SCRIPT>
<SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/js/matrix_runtime.js'></SCRIPT>
<SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/js/clockpicker.js'></SCRIPT>
<SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/js/bootstrap-wysiwyg/js/bootstrap-wysiwyg.min.js'></SCRIPT>
 <SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/js/jquery.hotkeys/jquery.hotkeys.js'></SCRIPT>
<SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/css/google-code-prettify/src/prettify.js'></SCRIPT>
<SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/js/validator.js'></SCRIPT>
<SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/js/filejs.js'></SCRIPT>
<script src='<%=request.getContextPath() %>/resource/html5/js/jstree.min.js'></script>
<link rel='stylesheet' href='<%=request.getContextPath() %>/resource/css/themes/default/style.min.css'/>
<script src='<%=request.getContextPath() %>/office/html5/assets/bootstrap-table/src/bootstrap-table.js'></script>
<SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/assets/toastr-master/toastr.min.js'></SCRIPT>
<link href='<%=request.getContextPath() %>/resource/html5/assets/toastr-master/toastr.min.css'  rel="stylesheet"></link>
<title>切换应用</title>

<script type="text/javascript">
//点击进入底表列表
function clickTem(dom){
	var json = {};
	json.appId = $(dom).attr('appId');
	json.schema = $(dom).attr('schema');
	$.ajax({
		type:'post',
		url:'<%=path%>/mapp/mapp_switchApplication.action',
			data : json,
			dataType : 'json',
			success : function(json) {

				if (json != "") {
					if (json.success == true) {
						Matrix.success('切换成功！');
						top.changeView('admin');
					} else {
						Matrix.error(json.msg);
					}
				} else {
					Matrix.error("服务器异常请联系管理员");
				}
			}
		});
	}
<%-- 
function clickTem(dom){
	var json = {};
	$("#appId").val($(dom).attr('appId'));
	$("#schema").val($(dom).attr('schema'));
	$("form").submit();
}--%>

</script>
<style>
body {
	webkit-tap-highlight-color: #222;
}

body {
	font-family: 'Microsoft yahei', Open Sans, 'Helvetica Neue', Arial,
		sans-serif;
	font-size: 15px;
	color: #777;
	line-height: 1.7;
	margin-top: -25px;
}

html, body {
	width: 100%;
	height: 100%;
}

.product {
	background: #f2f2f2;
}

section {
	padding: 80px 0;
}

article, aside, details, figcaption, figure, footer, header, hgroup,
	main, menu, nav, section, summary {
	display: block;
}

:after, :before {
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	box-sizing: border-box;
}

:after, :before {
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	box-sizing: border-box;
}

::selection {
	text-shadow: none;
	color: #fff;
	background: #222;
}

.btn-group-vertical>.btn-group:after, .btn-group-vertical>.btn-group:before,
	.btn-toolbar:after, .btn-toolbar:before, .clearfix:after, .clearfix:before,
	.container-fluid:after, .container-fluid:before, .container:after,
	.container:before, .dl-horizontal dd:after, .dl-horizontal dd:before,
	.form-horizontal .form-group:after, .form-horizontal .form-group:before,
	.modal-footer:after, .modal-footer:before, .modal-header:after,
	.modal-header:before, .nav:after, .nav:before, .navbar-collapse:after,
	.navbar-collapse:before, .navbar-header:after, .navbar-header:before,
	.navbar:after, .navbar:before, .pager:after, .pager:before, .panel-body:after,
	.panel-body:before, .row:after, .row:before {
	display: table;
	content: " ";
}

:after, :before {
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	box-sizing: border-box;
}

.btn-group-vertical>.btn-group:after, .btn-toolbar:after, .clearfix:after,
	.container-fluid:after, .container:after, .dl-horizontal dd:after,
	.form-horizontal .form-group:after, .modal-footer:after, .modal-header:after,
	.nav:after, .navbar-collapse:after, .navbar-header:after, .navbar:after,
	.pager:after, .panel-body:after, .row:after {
	clear: both;
}

.btn-group-vertical>.btn-group:after, .btn-group-vertical>.btn-group:before,
	.btn-toolbar:after, .btn-toolbar:before, .clearfix:after, .clearfix:before,
	.container-fluid:after, .container-fluid:before, .container:after,
	.container:before, .dl-horizontal dd:after, .dl-horizontal dd:before,
	.form-horizontal .form-group:after, .form-horizontal .form-group:before,
	.modal-footer:after, .modal-footer:before, .modal-header:after,
	.modal-header:before, .nav:after, .nav:before, .navbar-collapse:after,
	.navbar-collapse:before, .navbar-header:after, .navbar-header:before,
	.navbar:after, .navbar:before, .pager:after, .pager:before, .panel-body:after,
	.panel-body:before, .row:after, .row:before {
	display: table;
	content: " ";
}

@media ( min-width : 1200px) .container {
	width:1170px;
	

}

@media ( min-width : 992px) .container {
	width:970px;
	

}

@media ( min-width : 768px) .container {
	width:750px;
}

.container {
	padding-right: 15px;
	padding-left: 15px;
	margin-right: auto;
	margin-left: auto;
}

.row {
	margin-right: -15px;
	margin-left: -15px;
}

@media ( min-width : 992px) .col-md-12 {
	width:100%;
}

@media ( min-width : 992px) .col-md-1 , . col-md-10 , . col-md-11 , . col-md-12 ,
		. col-md-2 , . col-md-3 , . col-md-4 , . col-md-5 , . col-md-6 , .
		col-md-7 , . col-md-8 , . col-md-9 {
	float:left;
}

.col-lg-1, .col-lg-10, .col-lg-11, .col-lg-12, .col-lg-2, .col-lg-3,
	.col-lg-4, .col-lg-5, .col-lg-6, .col-lg-7, .col-lg-8, .col-lg-9,
	.col-md-1, .col-md-10, .col-md-11, .col-md-12, .col-md-2, .col-md-3,
	.col-md-4, .col-md-5, .col-md-6, .col-md-7, .col-md-8, .col-md-9,
	.col-sm-1, .col-sm-10, .col-sm-11, .col-sm-12, .col-sm-2, .col-sm-3,
	.col-sm-4, .col-sm-5, .col-sm-6, .col-sm-7, .col-sm-8, .col-sm-9,
	.col-xs-1, .col-xs-10, .col-xs-11, .col-xs-12, .col-xs-2, .col-xs-3,
	.col-xs-4, .col-xs-5, .col-xs-6, .col-xs-7, .col-xs-8, .col-xs-9 {
	position: relative;
	min-height: 1px;
	padding-right: 15px;
	padding-left: 15px;
}

.fadeInLeft {
	-webkit-animation-name: fadeInLeft;
	animation-name: fadeInLeft;
}

@media ( min-width : 992px) .col-md-1 , . col-md-10 , . col-md-11 , . col-md-12 ,
		. col-md-2 , . col-md-3 , . col-md-4 , . col-md-5 , . col-md-6 , .
		col-md-7 , . col-md-8 , . col-md-9 {
	float:left;
}

.productTabs {
	border: 0;
}

.nav-tabs {
	border-bottom: 1px solid #ddd;
}

.nav {
	padding-left: 0;
	margin-bottom: 0;
	list-style: none;
}

ul, ol, li {
	list-style: none outside none;
}

ol, ul {
	margin-top: 0;
	margin-bottom: 10px;
}

.productTabs li {
	width: 33.33%;
	cursor: pointer;
}

.nav-tabs>li {
	float: left;
	margin-bottom: -1px;
}

.nav>li {
	position: relative;
	display: block;
}

ul, ol, li {
	list-style: none outside none;
}

.nav-tabs>li>a.p_tab {
	display: block;
	background-size: cover;
	-moz-background-size: cover;
	-webkit-background-size: cover;
	-o-background-size: cover;
	background-repeat: no-repeat;
	background-position: center;
	border-radius: 9px;
	position: relative;
	border: 0;
	margin-bottom: 30px;
	margin-right: 5%;
}

.nav-tabs>li>a {
	margin-right: 2px;
	line-height: 1.42857143;
	border: 1px solid transparent;
	border-radius: 4px 4px 0 0;
}

.nav>li>a {
	position: relative;
	display: block;
	padding: 10px 15px;
}

.nav-tabs>li>a.p_tab:after {
	clear: both;
	content: '';
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(255, 255, 255, 0.9);
	z-index: 1;
	display: block;
	border-radius: 8px;
	-webkit-transition: all .2s ease-in-out;
	-moz-transition: all .2s ease-in-out;
	-o-transition: all .2s ease-in-out;
	-ms-transition: all .2s ease-in-out;
	transition: all .2s ease-in-out;
}

:after, :before {
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	box-sizing: border-box;
}

a {
	color: #333;
	-webkit-transition: all .35s;
	-moz-transition: all .35s;
	transition: all .35s;
	text-decoration: none;
}

a {
	color: #337ab7;
	text-decoration: none;
}

a {
	background-color: transparent;
}

* {
	padding: 0;
	margin: 0;
}

* {
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	box-sizing: border-box;
}

user agent stylesheet
a:-webkit-any-link {
	color: -webkit-link;
	cursor: pointer;
	text-decoration: underline;
}

.productTabs li {
	width: 33.33%;
	cursor: pointer;
}

ul, ol, li {
	list-style: none outside none;
}

.nav-tabs>li>a.p_tab {
	display: block;
	background-size: cover;
	-moz-background-size: cover;
	-webkit-background-size: cover;
	-o-background-size: cover;
	background-repeat: no-repeat;
	background-position: center;
	border-radius: 9px;
	position: relative;
	border: 0;
	margin-bottom: 30px;
	margin-right: 5%;
}

.nav-tabs>li>a {
	margin-right: 2px;
	line-height: 1.42857143;
	border: 1px solid transparent;
	border-radius: 4px 4px 0 0;
}

.nav>li>a {
	position: relative;
	display: block;
	padding: 10px 15px;
}

.nav-tabs>li.active>a.p_tab:after, .nav-tabs>li.active>a.p_tab:hover:after, .nav-tabs>li.active>a.p_tab:focus:after {
    background-color: rgba(199,0,10,0.75);
}
a {
	color: #333;
	-webkit-transition: all .35s;
	-moz-transition: all .35s;
	transition: all .35s;
	text-decoration: none;
}

a {
	color: #337ab7;
	text-decoration: none;
}

a {
	background-color: transparent;
}

.p_tabCon {
	z-index: 2;
	position: relative;
	padding-bottom: 9%;
}

.nav-tabs .tabLink {
	position: absolute;
	left: 0;
	top: 0;
	width: 80%;
	height: 80%;
	display: block;
	margin: 0;
	cursor: pointer;
	z-index: 999;
}

.nav-tabs>li>a {
	margin-right: 2px;
	line-height: 1.42857143;
	border: 1px solid transparent;
	border-radius: 4px 4px 0 0;
}

.nav>li>a {
	position: relative;
	display: block;
	padding: 10px 15px;
}

.nav-tabs>li>a.p_tab .iconfont {
	font-size: 26px;
	color: #333;
}

.iconfont {
	font-family: "iconfont" !important;
	font-size: 16px;
	font-style: normal;
	-webkit-font-smoothing: antialiased;
	-moz-osx-font-smoothing: grayscale;
}

.nav-tabs>li>a.p_tab .p_tabT {
	color: #333;
	font-size: 18px;
	font-weight: bold;
	letter-spacing: .3px;
}

.nav-tabs>li>a.p_tab .p_tabE {
	color: #999;
	font-family: 'Arial';
	font-size: 12px;
	font-weight: bold;
}

.nav-tabs>li.active>a.p_tab:hover .iconfont, .nav-tabs>li.active>a.p_tab .iconfont
	{
	color: #fff;
}

.nav-tabs>li>a.p_tab .iconfont {
	font-size: 26px;
	color: #333;
}

@font-face {
	font-family: "iconfont";
	src: url('iconfont.eot?t=1575268015099');
	src: url('iconfont.eot?t=1575268015099#iefix')
		format('embedded-opentype'),
		url('data:application/x-font-woff2;charset=utf-8;base64,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')
		format('woff2'), url('iconfont.woff?t=1575268015099') format('woff'),
		url('iconfont.ttf?t=1575268015099') format('truetype'),
		url('iconfont.svg?t=1575268015099#iconfont') format('svg');
}

.iconfont {
	font-family: "iconfont" !important;
	font-size: 16px;
	font-style: normal;
	-webkit-font-smoothing: antialiased;
	-moz-osx-font-smoothing: grayscale;
}

.icon-gerenzhuye:before {
	content: "\e639";
}
.icon-msnui-manage-supervise:before {
    content: "\e720";
}
</style>
</head>
<body>
	<%-- <input type="hidden" id="templateType" name="templateType" value="${param.templateType}"> --%>
	<input type="hidden" id="templateType" name="templateType"
		value="${param.templateType}">
	<input type="hidden" id="templateId" name="templateId">
	<input type="hidden" id="appId" name="appId">
	<input type="hidden" id="schema" name="schema">
	<!--  	<div tabindex="0" id="toolList"
			style="z-index: 999999; position: absolute; height: 100%; width: 100%; background: #fff; box-shadow: 2px 2px 5px rgba(185, 185, 185, .3)">
			
		</div>-->
	<section class="product">
	<div class="container">
		<div class="row">
			<div class="col-md-12 ">
				<div class="row">
					<div class="col-md-4 wow fadeInLeft"
						style="visibility: visible; animation-name: fadeInLeft;">
						<ul id="myTab" class="nav nav-tabs productTabs">
							<c:forEach items="${appList}" var="item"  varStatus="status">
							<c:if test=""></c:if>
								<li class="${item.getAppId()==currentApp?'active':'' }">
								<a  class="p_tab p_tab${status.index}"
									data-toggle="tab"
									style=""
									appId="${item.getAppId() }" schema="${item.getSchemaCode() }"
									onclick="clickTem(this)">
										<div class="p_tabCon">
											<i class="icon iconfont icon-msnui-manage-supervise"></i>
											<h3 class="p_tabT">${item.getAppName() }</h3>
											<h4 class="p_tabE">${item.getAppDesc() }</h4>
										</div>
								</a> <a class="tabLink" appId="${item.getAppId() }" schema="${item.getSchemaCode() }"
									onclick="clickTem(this)"></a></li>
							</c:forEach>
						</ul>
						</ul>
					</div>

				</div>


			</div>
		</div>
	</div>
	</section>
</body>
<script type="text/javascript">
$(document).ready(function(){
    	var oTab = $("#myTab");
    	var oLi = oTab.find("li");
    	var oDd = $("#myTabContent").find(".tab-pane");
    	oLi.click(function(e) {
        	var thisLi = $(this);
        	thisLi.siblings("li").removeClass("active");
        	thisLi.addClass("active");
        	oDd.css("display", "none");
        	oDd.eq(thisLi.index()).css("display", "block").siblings().css("display", "none")
    	})
});
</script>
</script>
</html>