//获取当前项目的绝对路径
function getPathRoot(){
	 var pathName = window.location.pathname.substring(1);
	 var webName = pathName == '' ? '' : pathName.substring(0, pathName.indexOf('/'));
	 var path_root = window.location.protocol + '//' + window.location.host + '/'+ webName + '/';
	 return path_root;
}
var webpath = getPathRoot();

function getUrlParam(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); // 构造一个含有目标参数的正则表达式对象
    var r = window.location.search.substr(1).match(reg); // 匹配目标参数
    if (r != null) return unescape(r[2]);
    return null; // 返回参数值
}

document.write('' +
	'<link href="'+webpath+'resource/html5/css/matrix_runtime.css" rel="stylesheet"></link>\n' +
	'<link href="'+webpath+'resource/html5/css/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet"></link>\n' +
	'<link href="'+webpath+'resource/html5/css/font-awesome.min.css" rel="stylesheet"></link>\n' +
	'<link href="'+webpath+'resource/html5/css/flat/blue.css" rel="stylesheet"></link>\n' +
	'<link href="'+webpath+'resource/html5/css/square/blue.css" rel="stylesheet"></link>\n' +
	'<link href="'+webpath+'resource/html5/css/bootstrap-select.min.css" rel="stylesheet"></link>\n' +
	'<link href="'+webpath+'resource/html5/css/select2.css" rel="stylesheet"></link>\n' +
	'<link href="'+webpath+'resource/html5/css/clockpicker.css" rel="stylesheet"></link>\n' +
	'<link href="'+webpath+'resource/css/filecss.css" rel="stylesheet"></link>\n' +
	'<link href="'+webpath+'office/html5/assets/bootstrap-table/src/bootstrap-table.css" rel="stylesheet"></link>\n' +
	'<link href="'+webpath+'resource/html5/css/google-code-prettify/bin/prettify.min.css" rel="stylesheet"></link>\n' +
	'<link href="'+webpath+'resource/html5/css/custom.css" rel="stylesheet"></link>\n' +
	'<link href="'+webpath+'resource/css/themes/default/style.min.css" rel="stylesheet"></link>\n' +
	'<link href="'+webpath+'resource/html5/assets/toastr-master/toastr.min.css" rel="stylesheet"></link>\n' +
	
    '<script src="'+webpath+'resource/html5/js/jquery.min.js"></script>\n' +
    '<script src="'+webpath+'resource/html5/js/jquery.i18n.properties.js"></script>\n' +
    '<script src="'+webpath+'resource/html5/lang/matrix_lang.js"></script>\n' +
    '<script src="'+webpath+'resource/html5/js/jquery.inputmask.bundle.min.js"></script>\n' +
    '<script src="'+webpath+'resource/html5/css/bootstrap/dist/js/bootstrap.min.js"></script>\n' +
    '<script src="'+webpath+'resource/html5/js/icheck.min.js"></script>\n' +
    '<script src="'+webpath+'resource/html5/js/bootstrap-select.min.js"></script>\n' +
    '<script src="'+webpath+'resource/html5/js/select2.js"></script>\n' +
    '<script src="'+webpath+'resource/html5/js/layer.min.js"></script>\n' +
    '<script src="'+webpath+'resource/html5/js/autosize.min.js"></script>\n' +
    '<script src="'+webpath+'resource/html5/js/demo.js"></script>\n' +
    '<script src="'+webpath+'resource/html5/js/laydate/laydate.js"></script>\n' +
    '<script src="'+webpath+'resource/html5/js/clockpicker.js"></script>\n' +
    '<script src="'+webpath+'resource/html5/js/bootstrap-wysiwyg/js/bootstrap-wysiwyg.min.js"></script>\n' +
    '<script src="'+webpath+'resource/html5/js/jquery.hotkeys/jquery.hotkeys.js"></script>\n' +
    '<script src="'+webpath+'resource/html5/css/google-code-prettify/src/prettify.js"></script>\n' +
    '<script src="'+webpath+'resource/html5/js/filejs.js"></script>\n' +  
    '<script src="'+webpath+'resource/html5/js/jstree.min.js"></script>\n' +  
    '<script src="'+webpath+'office/html5/assets/bootstrap-table/src/bootstrap-table.js"></script>\n' +
    '<script src="'+webpath+'resource/html5/assets/toastr-master/toastr.min.js"></script>\n' +
    '<script src="'+webpath+'resource/html5/js/validator.js"></script>\n' +
    '<script src="'+webpath+'office/html5/assets/bootstrap-table/src/bootstrap-table.js"></script>\n' +
    '<script src="'+webpath+'resource/html5/js/matrix_runtime.js"></script>' +
    '');
	
	//实例化XmlHttpRequest对象
    var xhr=new XMLHttpRequest();
    //使用GET方式请求指定网址的页面
    xhr.open("GET",webpath + 'home/home_getCurrentSkin.action',false);
    //发送空内容请求
    xhr.send(null);
    let currentSkin = 'primary';
    if(xhr.status===200){//200状态码表示正常
    	try{
    		var data = JSON.parse(xhr.responseText)
        	currentSkin = data.skin;
    	}catch(err){
    		console.log(err);
    	}
    }else{
    	console.log("request skin error");
    }
    document.write('<link href="'+webpath+'resource/html5/css/skin/mCustom_'+currentSkin+'.css" rel="stylesheet"></link>');
    