/**
 * 
 * @Author：zsd
 * 
 */

;
!function(window, undefined) {
	"use strict";

	var $, win, ready = {
		getPath : function() {
			var jsPath = document.currentScript ? document.currentScript.src
					: function() {
						var js = document.scripts, last = js.length - 1, src;
						for (var i = last; i > 0; i--) {
							if (js[i].readyState === 'interactive') {
								src = js[i].src;
								break;
							}
						}
						return src || js[last].src;
					}();
			return jsPath.substring(0, jsPath.lastIndexOf('/') + 1);
		}()
	};

	// 默认内置方法。
	var MatrixLang = {
		v : '1.0.0',
		ie : function() { // ie版本
			var agent = navigator.userAgent.toLowerCase();
			return (!!window.ActiveXObject || "ActiveXObject" in window) ? ((agent
					.match(/msie\s(\d+)/) || [])[1] || '11' // 由于ie11并没有msie的标识
			)
					: false;
		}(),
		projectBaseLang:['zh-CN','en-US'],
		propertyFiles:['matrixMessages','customMessages','bootstrap-table', 'select2'],
		path : ready.getPath,
		cache: false,
		topDialog:null,
		loadProperties : function(lan) {
			if (lan != null && lan != undefined) {						
				setCookie("langge", lan)
			} else {
				lan = getCookie("langge");
				if (lan == null || lan === undefined) {
					lan = "zh-CN"
				}
			}
			if(window.opener){     //window.open打开的窗口
				this.topDialog=window.opener.top;
				if(typeof (this.topDialog.MatrixLang)=='undefined'){
					loadI18nProperties(lan);
					loadLayDate(lan);
					setSelectOption();
					this.topDialog=window;
				}else {
					updateHtmlLocale();
				}
			}else{
				if (top.location!=self.location) {
					debugger;
					this.topDialog=window.top;
					if(typeof (this.topDialog.MatrixLang)=='undefined'){
						loadI18nProperties(lan);
						loadLayDate(lan);
						setSelectOption();
						this.topDialog=window;
					}else {
						updateHtmlLocale();
					}
				}else{
					this.topDialog=window.top;
					loadI18nProperties(lan);
					loadLayDate(lan);
					setSelectOption();
				}
			}			
		},laydatePropObj: {},
		laydatePropertys:function () {
			return MatrixLang.topDialog.MatrixLang.laydatePropObj;
		},
		messages2langkey:{}
	}
	window.MatrixLang = MatrixLang;
	//设置cookies
	function setCookie(name, value) {
		var Days = 30;
		var exp = new Date();
		exp.setTime(exp.getTime() + Days * 24 * 60 * 60 * 1000);
		document.cookie = name + "=" + escape(value) + ";expires="
				+ exp.toGMTString();
	}
	//设置cookies
	function getCookie(name) {
		var arr, reg = new RegExp("(^| )" + name + "=([^;]*)(;|$)");
		if(window.opener){
			if (arr = window.opener.top.document.cookie.match(reg)) {
				return unescape(arr[2]);
			}
		}else {
			if (arr = window.top.document.cookie.match(reg)) {
				return unescape(arr[2]);
			}
		}
		return null;
	}
	//
	function loadI18nProperties(lan) {
		$.i18n.properties({
			name: MatrixLang.propertyFiles,
			path: getProjectPath()+'/i18n/i18n_getI8nProperties.action?fileName=',
			mode: 'map',
			language: lan,
			callback: function () {
				console.log("i18n赋值中...");
				try {
					//初始化页面元素
					updateHtmlLocale();
				} catch (ex) {
				}
				console.log("i18n写入完毕");
			}
		});
	}
	//加载laydate 国际化文件
	function loadLayDate(lan) {
		var layDateFile= MatrixLang.path+lan + '/laydate_'+lan.replace("-","_")+'.json'
		$.ajax({
			url: layDateFile,
			async: false,
			cache: true,
			dataType: 'json',
			success: function (data, status) {

				if (true) {
					console.debug('Succeeded in downloading ' + layDateFile + '.');
					console.debug(data);
				}
				MatrixLang.laydatePropObj[MatrixLang.getLayDateLang()]=data;
			},
			error: function (jqXHR, textStatus, errorThrown) {

				if (true) {
					console.debug('Failed to download or parse ' + layDateFile + '. errorThrown: ' + errorThrown);
				}
			}
		});
	}
	//获取本地信息对应的国际化key值
	MatrixLang.getLangKey = function(msg) {
		if(MatrixLang.topDialog==null){
			MatrixLang.topDialog=window;
		}
		if(MatrixLang.cache){
			if (MatrixLang.topDialog.sessionStorage.getItem(msg) != null) {
				return MatrixLang.topDialog.sessionStorage.getItem(msg);
			}
		}else {
			if (typeof (MatrixLang.topDialog.MatrixLang.messages2langkey[msg]) != "undefined") {
				return MatrixLang.topDialog.MatrixLang.messages2langkey[msg];
			}
		}
		return msg;
	}
	//获取国际化语言信息(默认中文key 做映射关系)
	MatrixLang.geti18nInfo = function(message) {
		if(MatrixLang.topDialog==null){
			MatrixLang.topDialog=window;
		}
		const key = MatrixLang.getLangKey(message);
		try {
			message = MatrixLang.topDialog.$.i18n.prop(key);
		} catch (e) {
			// Handle this async error
			console.log('i18n exception', "请检查国际化资源文件,"+key+"并未在文件中找到映射.");
			return message;

		}
		return message;
	}
	//获取无映射国际化语言信息
	MatrixLang.geti18nInfoNokey = function(key) {
		if(MatrixLang.topDialog==null){
			MatrixLang.topDialog=window;
		}
		let message=key;
		try {
			message = MatrixLang.topDialog.$.i18n.prop(key);
		} catch (e) {
			// Handle this async error
			console.log('i18n exception', "请检查国际化资源文件,"+key+"并未在文件中找到映射.");
			return message;

		}
		return message;
	}
	//获取laydate语言状态 （由于底层laydate 的语言标示和本地语言标示不同所以做个转换）
	MatrixLang.getLayDateLang= function() {
		const lan = getCookie("langge");
		if("zh-CN"==lan){
			return "cn"
		}else if("en-US"==lan){
			return "en"
		}
		return lan;
	}
	//设置主页语言选项
	function setSelectOption() {
		debugger;
		if ($("#languageSelect").length>0) {
			MatrixLang.projectBaseLang.map(function (item,index,ary ) {
				if (getCookie("langge")==item) {
					$("#languageSelect").append("<option value='" + item + "' selected>" + MatrixLang.geti18nInfoNokey(item) + "</option>");
				} else {
					$("#languageSelect").append("<option value='" + item + "' >" + MatrixLang.geti18nInfoNokey(item) + "</option>");
				}
				return item;
			});
		}
	}
	//获取laydate语言状态 （由于底层laydate 的语言标示和本地语言标示不同所以做个转换）
	MatrixLang.changeLang= function(lan,viewType) {
		debugger;
		if(MatrixLang.topDialog==null){
			MatrixLang.topDialog=window;
		}
		setCookie("langge", lan);
		MatrixLang.topDialog.changeView(viewType);
	}
	//清除缓存重新加载语言数据
	MatrixLang.resetI8nCache=function(){
		$.ajax({
			url: getProjectPath()+'/i18n/i18n_resetI18nCache.action',
			dataType: 'text',
			success: function (data, status) {
				loadLangKey();
				MatrixLang.loadProperties();
				Matrix.say("刷新成功");
			},
			error: function (jqXHR, textStatus, errorThrown) {
				console.debug('Failed to reset i18n cache');
			}
		});
	}
	//获取laydate语言状态
	MatrixLang.getCurrentLang= function() {
		const lan = getCookie("langge");
		return lan;
	}
	//加载语言中文字典
	function loadLangKey() {
		var layKeyFile= MatrixLang.path+'/message2key.properties'
		$.ajax({
			url: layKeyFile,
			async: false,
			cache: true,
			dataType: 'text',
			success: function (data, status) {
				if (true) {
					console.debug('Succeeded in downloading ' + layKeyFile + '.');
					console.debug(data);
				}
				parseData(data)
			},
			error: function (jqXHR, textStatus, errorThrown) {
					console.debug('Failed to download or parse ' + layKeyFile + '. errorThrown: ' + errorThrown);
			}
		});
	}
	//处理数据
	function parseData(data) {
		var lines = data.split(/\n/);
		var regPlaceHolder = /(\{\d+})/g;
		var regRepPlaceHolder = /\{(\d+)}/g;
		var unicodeRE = /(\\u.{4})/ig;
		lines.forEach(function (line, i) {
			line = line.trim();
			if (line.length > 0 && line.match("^#") != "#") { // skip comments
				var pair = line.split('=');
				if (pair.length > 0) {
					/** Process key & value */
					var name = decodeURI(pair[0]).trim();
					var value = pair.length == 1 ? "" : pair[1];
					// process multi-line values
					while (value.match(/\\$/) === "\\") {
						value = value.substring(0, value.length - 1);
						value += lines[++i].trimRight();
					}
					// Put values with embedded '='s back together
					for (var s = 2; s < pair.length; s++) {
						value += '=' + pair[s];
					}
					name = name.trim();
					// var unicodeMatches = value.match(unicodeRE);
					// if (unicodeMatches) {
					// 	unicodeMatches.forEach(function (match) {
					// 		value = value.replace(match, unescapeUnicode(match));
					// 	});
					// }
					var unicodeMatches = name.match(unicodeRE);
					if (unicodeMatches) {
						unicodeMatches.forEach(function (match) {
							name = name.replace(match, unescapeUnicode(match));
						});
					}
					// add to map
					if (!MatrixLang.cache) {
						MatrixLang.messages2langkey[name] = value;
					}else{
						window.sessionStorage.setItem(name,value);
					}

				}
			}
		});
		if (MatrixLang.cache) {
			if(data){
				window.sessionStorage.setItem("langKeyCache","true");
			}else{
				window.sessionStorage.setItem("langKeyCache","");
			}
		}
	}
	function updateHtmlLocale() {
		$('[data-i18n-text]').each(function () {
			//如果text里面还有html需要过滤掉
			var html = $(this).html();
			var reg = /<(.*)>/;
			if (reg.test(html)) {
				var htmlValue = reg.exec(html)[0];
				$(this).html(htmlValue + MatrixLang.geti18nInfo($(this).data('i18n-text')));
			} else {
				$(this).text(MatrixLang.geti18nInfo($(this).data('i18n-text')));
			}
		});
		$('[data-i18n-value]').each(function () {
			$(this).val(MatrixLang.geti18nInfo($(this).data('i18n-value')));
		});
		$('[data-i18n-title]').each(function () {
			$(this).attr("title",MatrixLang.geti18nInfo($(this).data('i18n-title')));
		});
		$('[data-i18n-placeholder]').each(function () {
			$(this).attr("placeholder",MatrixLang.geti18nInfo($(this).data('i18n-placeholder')));
		});
	}
	function unescapeUnicode(str) {

		// unescape unicode codes
		var codes = [];
		var code = parseInt(str.substr(2), 16);
		if (code >= 0 && code < Math.pow(2, 16)) {
			codes.push(code);
		}
		// convert codes to text
		return codes.reduce(function (acc, val) { return acc + String.fromCharCode(val); }, '');
	}
	function getProjectPath(){
		var pathName = document.location.pathname;
		var index = pathName.substr(1).indexOf("/");
		var result = pathName.substr(0,index+1);
		return result;
	}
	// 主入口
	ready.run = function(_$) {
		$ = _$;
		win = $(window);
		if(!window.sessionStorage){
			MatrixLang.cache=false;
			loadLangKey();
		}else{
			MatrixLang.cache=true;
			if("true"!=window.sessionStorage.getItem("langKeyCache")&&top.location==self.location){
				loadLangKey();
			}
		}
	};

	// 加载方式
	debugger;
	 (typeof define === 'function' && define.amd) ? define(['jquery'], function(){ //requirejs加载
         ready.run(window.jQuery);
         return MatrixLang;
     }) :function() { // 普通script标签加载
		ready.run(window.jQuery);
		MatrixLang.loadProperties();
	}();

}(window);


