<!DOCTYPE html>
<%@page import="com.matrix.api.config.RunModeType"%>
<%@page import="com.matrix.app.MAppContext"%>
<%@page import="com.matrix.app.MAppProperties"%>
<%@page import="com.matrix.client.foundation.function.action.FunctionHelper"%>
<%@page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.matrix.engine.foundation.config.MFSystemProperties"%>
<%@ page import="com.matrix.form.admin.common.utils.CommonUtil"%>
<%@ page import="commonj.sdo.DataObject"%>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.List" %>
<html>
<head>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">

    <link
            href="<%=request.getContextPath()%>/form/admin/main/css/bootstrap.css"
            rel="stylesheet">
    <link
            href="<%=request.getContextPath()%>/form/admin/main/css/font-awesome.min.css"
            rel="stylesheet">
    <link
            href="<%=request.getContextPath()%>/form/admin/main/css/animate.min.css"
            rel="stylesheet">
    <link
            href="<%=request.getContextPath()%>/form/admin/main/css/style.min.css"
            rel="stylesheet">
</head>
<link href="<%=request.getContextPath()%>/form/admin/main/css/menu.css"
      rel="stylesheet">
</head>

<link rel="stylesheet" type="text/css"
      href="<%=request.getContextPath()%>/resource/css/reset.css" />
<link rel="stylesheet" type="text/css"
      href="<%=request.getContextPath()%>/resource/css/style.css" />
<link href='<%=request.getContextPath() %>/resource/html5/css/skin/mCustom_<%=session.getAttribute("skin") %>.css' rel="stylesheet"></link>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resource/html5/iconfonts/iconfont.css"/>

<title>Matrix BPM</title>

<jsp:include page="/form/admin/common/resource.jsp"/>
<style type="text/css">
    .dropdown-menu {
        min-width: 100px;
        border: medium none;
        display: none;
        float: left;
        font-size: 12px;
        left: 0;
        list-style: none outside none;
        padding: 0;
        position: absolute;
        text-shadow: none;
        top: 100%;
        z-index: 1000;
        border-radius: 0;
        box-shadow: 0 0 3px rgba(86,96,117,.3);
        background-color: white;
    }
    .dropdown-menu> li > a:hover, .dropdown-menu> li > a:focus {
        color: #262626;
        text-decoration: none;
        background-color: rgba(13,179,166,.1);
    }
</style>
</head>
<script src="<%=request.getContextPath()%>/resource/html5/js/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/form/html5/admin/logon/js/index.js"></script>
<script>
	window.onload = function(){
		//获取当前和子机构信息
		$.ajax({
			type:'post',
			url:'<%=request.getContextPath() %>/homePage/getOrgInfo',
			data:null,
			dataType:'json',
			success:function(data){
				var orgInfo = data.orgInfo;
				for (var i = 0; i < orgInfo.length; i++) {
					$("#changeOrg").append("<option value='"+ orgInfo[i].orgId +"'>" + orgInfo[i].orgName + "</option>");
				}
				$("#changeOrg").val(data.checkOrgId);				
			}
		});
	}
	
	function changeOrgOption(){
		var json = {};
		json.newOrgId = $("#changeOrg").val();
		$.ajax({
			type:'post',
			url:'<%=request.getContextPath() %>/homePage/changeOrgOption',
			data:json,
			dataType:'json',
			success:function(data){
				if (data != "") {
					const dataJson = data.data;
					if (dataJson.status) {
						//isc.say(dataJson.msg);
					} else {
						isc.warn(dataJson.msg);
					}
				}
			}
		});
	}
	

    //用于储存协同事项window刷新
    var childWindow;

    function setContent(url){
        document.getElementById('iframe0').src = url;
    }

    function changePortlet(id){
        if(id=='dep'){
            document.getElementById('depcontent').style.background  = "#7abee1";
            document.getElementById('companycontent').style.background  = "#1f91cd";
            document.getElementById('iframe0').src = "<%=request.getContextPath()%>/portal/portalAction_previewOfficePortal.action";
        }else{
            document.getElementById('depcontent').style.background  = "#1f91cd";
            document.getElementById('companycontent').style.background  = "#7abee1";
            document.getElementById('iframe0').src = "<%=request.getContextPath()%>/portal/portalAction_previewOfficePortal.action";
        }
    }

    //最外层打开移动表单设计页面
    function openMobileForm(){
        layer.open({
            id:'layer01',
            type : 2,

            title : ['移动表单设计'],
            shadeClose: false, //开启遮罩关闭
            area : [ '80%', '85%' ],
            content : "<%=request.getContextPath()%>/form.dform?iframewindowid=layer01",
            cancel: function(){
                //还原电脑表单模型  清除移动表单模型
                $.ajax({
                    url: '<%=request.getContextPath()%>/templet/tem_returnToFormModel.action',
                    type: "post",
                    dataType: "json",
                    success: function(data){
                    }
                });
            }
        });
    }
</script>

<%
	//登录方式  logon直接登录  switch 切换视图登录
	String logonMode = (String)request.getAttribute("logonMode");
	FunctionHelper helper = new FunctionHelper();
	List list = helper.loadChildrenFunctionByCustom(logonMode);

	/*for(Iterator iter = list.iterator(); iter.hasNext(); ){
		DataObject data = (DataObject)iter.next();
		out.println("id:"+data.getString("functionId")+",name:"+data.getString("functionName"));

		List children = data.getList("children");
		for(Iterator iter2 = children.iterator(); iter2.hasNext(); ){
			DataObject data2 = (DataObject)iter2.next();
			out.println("subid:"+data2.getString("functionId")+",subname:"+data2.getString("functionName"));

		}
	}
	*/
	boolean isDesigner = CommonUtil.isDesigner();  //是否是designer
	 //是否是主应用登录 还是租户登录
	 boolean isMainApp = true;
	 String tenantId = MAppContext.getTenantId();
	 if(!MAppProperties.MASTER_APP_ID.equals(tenantId)){  //当前是租户登录
		 isMainApp = false;
	 }
	 //是否启用租户
	 boolean isTenantEnable = MAppProperties.getInstance().isTenantEnable();
	 
%>
<body class="fixed-sidebar full-height-layout pace-done"
      style="overflow: hidden; background-color: #fff;" >
<input type="hidden" id="operation" name="operation"/>  <!-- 是否注销 -->
<input type="hidden" id="logonMode" name="logonMode" value="${logonMode}"/>  <!-- 登录方式  user直接登录默认是普通用户视图      admin切换管理员视图登录   user切换普通用户视图登录 -->
<div class="shouye-title" style="min-height:53px;">
    <div class="logo"><img
            src="<%=request.getContextPath()%>/resource/images/logo.png"></div>
    <div id="topMenuContr" class="topMenuContr">
        <div style="padding-top:8px;position:absolute;width:100%;">
            <img src="<%=request.getContextPath()%>/form/admin/main/menu_14.png" width="16px" height="16px" style="vertical-align:middle;" id="closeTop">
        </div>
    </div>

    <script type="text/javascript">
        //展开缩放按钮
        $('#topMenuContr').click(function(){
            var width = $('#navigation').width();
            if(width == '220'){
                //$('#topMenuContr').css('background-color','rgb(122, 190, 225)');
                $('#navigation').css('display','none');
                $('#navigation').css('width','0px');
                $('#page-wrapper').css('margin-left','0px');
            }else{
                //$('#topMenuContr').css('background-color','rgb(6,131,229)');
                $('#page-wrapper').css('margin-left','220px');
                $('#navigation').css('width','220px');
                $('#navigation').css('display','');
            }
        });
    </script>
    <div class="dropdown" id="viewType" style="top: 10px; left:10px; height: 35px;float: left;position: relative;">
        <button class="btn btn-primary dropdown-toggle btn-bgcolor" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true" id="changeView">
          	  管理实施 
        </button>
        <ul class="dropdown-menu">
            <li id="user_view"><a href="javascript:changeView('user');">普通视图</a></li>
            <li id="designer_view"><a href="javascript:changeView('designer');">设计开发</a></li>
        </ul>
    </div>
    <script type="text/javascript">
        $(function(){
            $('#user_view').show();
            var isMainApp = <%=isMainApp %>;
            var isTenantEnable = <%=isTenantEnable %>;
            if(isMainApp && isTenantEnable){  //主应用登录并且启用租户 不可切换到普通视图
                $('#user_view').hide();
            }

            $('#designer_view').hide();
            var isDesigner = <%=isDesigner %>;
            if(isDesigner){
                $('#designer_view').show();
            }

        })
    </script>
    <div class="shouye-title-right">
    	<% if(MFSystemProperties.getInstance().getRunModeType().getValue() == RunModeType.DEVELOPMENT_TYPE){%>
	    <div  class="btn-group" style="height: 35px;float: left;" role="group">
	        <button  class="btn btn-primary btn-bgcolor langSelect"
	                 onclick="MatrixLang.resetI8nCache()">重置国际化资源</button>
	    </div>
	    <% }%>
	    <div class="btn-group" style="height: 35px;float: left;position: relative;margin-left: 5px;" role="group">
	        <select id="changeOrg" class="btn btn-primary btn-bgcolor" onchange="changeOrgOption();">
	        </select>
	    </div>
        <h2>
        	<i class="icon iconfont icon-yonghu" style="float: left;color: white;margin-top: 1px;"></i>
        	<span>欢迎您，${userName}</span>
        </h2>
        <div class="right0">
        	<a href="javascript:logoff();" style="color: white;text-decoration: none;">
        		<i class="icon iconfont icon-zhuxiao"></i><span style="margin-left: 2px;">退出</span>
        	</a>
        </div>
    </div>
</div>
<div class="pace  pace-inactive">
    <div class="pace-progress" data-progress-text="100%" data-progress="99"
         style="width: 100%;">
        <div class="pace-progress-inner"></div>
    </div>
    <div class="pace-activity"></div>
</div>
<div id="wrapper" style="overflow:hidden;"><!--左侧导航开始--> <nav
        class="navbar-default navbar-static-side" role="navigation" id="navigation" style="height: calc(100% - 53px);padding-top:10px;">
    <div class="nav-close"><i class="fa fa-times-circle"></i></div>
    <div class="slimScrollDiv"
         style="position: relative; width: auto; height: 100%;overflow: auto;">
        <div class="sidebar-collapse">
            <div class="bback" style="display:none;">
                <span style="line-height:25px;color:#FFFFFF">在线人数:<%=session.getAttribute("Logon_User_Num")%></span>
            </div>
            <ul class="nav" id="side-menu">
                <!--   <li class="nav-header">
                        <div class="dropdown profile-element">
                            <span><img alt="image" class="img-circle" src="<%=request.getContextPath()%>/form/admin/main/profile_small.jpg"></span>
                            <a data-toggle="dropdown" class="dropdown-toggle" href="http://www.zi-han.net/theme/hplus/#">
                                <span class="clear">
                               <span class="block m-t-xs"><strong class="font-bold">Beaut-zihan</strong></span>
                                <span class="text-muted text-xs block">超级管理员</span>
                                </span>
                            </a>

                        </div>
                        <div class="logo-element">H+
                        </div>
                    </li>
                     -->
                <%
                    for (Iterator iter = list.iterator(); iter.hasNext();) {
                        DataObject data = (DataObject) iter.next();
                        //		out.println("id:"+data.getString("functionId")+",name:"+);
                        String sIconUrl = data.getString("sIconUrl");   //小图标URL
                %>
                <li><a href="" class="menu-title">
                    <%
                        if(sIconUrl!=null && sIconUrl.trim().length()>0){
                    %>
                    <img src="<%=request.getContextPath()%><%=sIconUrl%>"
                    <%
                    }else{
                    %>
                    <img src="<%=request.getContextPath()%>/form/admin/main/mmenu.png"
                        <%
		}
		%>
                         style="height: 18px; padding-right: 10px;margin: 0px;  float: left;">
                    <span style="height:18px;line-height:18px;display: block;" data-i18n-text="<%=data.getString("functionName")%>"><%=data.getString("functionName")%></span>
                    <span class="fa arrow" style="margin-top:-16px;"></span>
                </a>
                    <ul class="nav nav-second-level collapse">

                        <%
                            List children = data.getList("children");
                            for (Iterator iter2 = children.iterator(); iter2.hasNext();) {
                                DataObject data2 = (DataObject) iter2.next();
                                //out.println("subid:"+data2.getString("functionId")+",subname:"+data2.getString("functionName"));
                                String url = request.getContextPath() + "/"
                                        + data2.getString("functionValue");
                        %>
                        <li><a
                                class="J_menuItem" href="javascript:setContent('<%=url %>')"
                                data-index="0">
                            <img src="<%=request.getContextPath()%>/resource/images/right-arrow.png" style="
    height: 9px;
    width: 9px;
" >
                            <span data-i18n-text="<%=data2.getString("functionName")%>"><%=data2.getString("functionName")%></span></a></li>
                        <%
                            }
                        %>

                    </ul>

                </li>
                <%
                    }
                %>


            </ul>
        </div>
        <div class="slimScrollBar"
             style="width: 4px; position: absolute; top: 0px; opacity: 0.4; display: none; border-radius: 7px; z-index: 99; right: 1px; height: 799px; background: rgb(0, 0, 0);"></div>
        <div class="slimScrollRail"
             style="width: 4px; height: 100%; position: absolute; top: 0px; display: none; border-radius: 7px; opacity: 0.9; z-index: 90; right: 1px; background: rgb(51, 51, 51);"></div>
    </div>
</nav> <!--左侧导航结束--> <!--右侧部分开始-->
    <div id="page-wrapper" class="gray-bg dashbard-1" style="height:100%;overflow:hidden;">


        <div class="row J_mainContent" id="content-main" style="height:100%;overflow:hidden;">
            <iframe
                    class="J_iframe" style="overflow: hidden;" id="iframe0" name="iframe0"
                    width="100%" height="100%" src="<%=request.getContextPath()%>/form/admin/logon/matrix/welcome.jsp" frameborder="0"
                    data-id="index_v1.html" seamless=""></iframe></div>


        <!--   <div class="footer">
                        <div class="pull-right">© 2004-2015 <a href="" target="_blank">华创动力科技</a>
                        </div>
                    </div>
                   --></div>
        <%
	 String operation = (String)request.getAttribute("operation");   //changeSkin 更换皮肤时自动刷新管理员界面  并展开皮肤管理子菜单
	 if("changeSkin".equals(operation)){
%>
    <script>
        debugger;
        document.getElementById('iframe0').src = '<%=request.getContextPath()%>/office/html5/select/SelectSkin.jsp';
        var skinLink = $("li a:contains('皮肤管理')");
        if(skinLink.length == 1){
            skinLink.parent().parent().addClass('in');
            skinLink.parent().parent().parent().addClass('active');
            skinLink.focus();
        }
    </script>
        <%
	 }else if("changeApp".equals(operation)){
%>
    <script>
        debugger;
        document.getElementById('iframe0').src = '<%=request.getContextPath()%>/app/appList.jsp';
        var skinLink = $("li a:contains('应用管理')");
        if(skinLink.length == 1){
            skinLink.parent().parent().addClass('in');
            skinLink.parent().parent().parent().addClass('active');
            skinLink.focus();
        }
    </script>
        <%
	 }
%>
    <script
            src="<%=request.getContextPath()%>/form/admin/main/js/jquery.min.js"></script>
	 <!-- 国际化开始 -->
    <SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/js/jquery.i18n.properties.js'></SCRIPT>
    <SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/lang/matrix_lang.js'></SCRIPT>
    <!-- 国际化结束 -->
    <SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/js/matrix_dialog.js'></SCRIPT>
    <!--右侧部分结束-->
    <script
            src="<%=request.getContextPath()%>/form/admin/main/js/bootstrap.min.js"></script>
    <script
            src="<%=request.getContextPath()%>/form/admin/main/js/jquery.metisMenu.js"></script>
    <script
            src='<%=request.getContextPath() %>/resource/html5/js/layer.min.js'></script>
    <script
            src="<%=request.getContextPath()%>/form/admin/main/js/hplus.min.js"></script>
    <script
            src="<%=request.getContextPath()%>/form/admin/main/js/jquery.slimscroll.min.js"></script>

    <button id="btn01" class="navbar-minimalize minimalize-styl-2 btn btn-primary " type="button" style="width:0px;height:0px;"/>

</body>
