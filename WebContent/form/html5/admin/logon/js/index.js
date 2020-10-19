var openwin = new Array();
// 注销
function logoff() {
	if (openwin.length > 0) { // 关闭所有已经打开的窗口
		for (var i = 0; i < openwin.length; i++) {
			openwin[i].close();
		}
	}
	top.location = getPathRoot() + 'logon/logon_logoff.action?m_appId='+getUrlParam("m_appId");
}

// 获得打开窗口的winodw对象
function getWindow(windobj) {
	openwin.push(windobj);
}

// 关闭标签页时清除session
window.onbeforeunload = function() {
	var operation = document.getElementById('operation').value;
	if (operation != 'noLogOut') {
		$
				.ajax({
					url : getPathRoot() + 'logon/logon_logoff.action?m_appId='+getUrlParam("m_appId"),
					type : "post",
					dataType : "json",
					success : function(data) {
					}
				});
	}
};
function changeView(viewType) {
	if (openwin.length > 0) { // 关闭所有已经打开的窗口
		for (var i = 0; i < openwin.length; i++) {
			openwin[i].close();
		}
	}
	document.getElementById('operation').value = 'noLogOut';
	//切换视图链接
	var switchUrl = getPathRoot() + 'logon/logon_switchView.action?viewType=' + viewType;
	var m_appId = getUrlParam("m_appId");
	if(m_appId!=null && m_appId!=''){
		switchUrl = switchUrl + '&m_appId=' + m_appId;
	}
	window.location.href = switchUrl;
}
function getUrlParam(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); // 构造一个含有目标参数的正则表达式对象
    var r = window.location.search.substr(1).match(reg); // 匹配目标参数
    if (r != null) return unescape(r[2]);
    return null; // 返回参数值
}


function getPathRoot(){
	 var pathName = window.location.pathname.substring(1);
	 var webName = pathName == '' ? '' : pathName.substring(0, pathName.indexOf('/'));
	 var path_root = window.location.protocol + '//' + window.location.host + '/'+ webName + '/';
	 return path_root;
}