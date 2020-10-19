var support_language_list = [{codeNo:"zh-CN",codeDesc:"中文"},{codeNo:"en-US",codeDesc:"English"}]
// var support_language_list = [{codeNo:"zh-CN",codeDesc:"中文"}]
//文件路径处理
var _dync_href = window.document.location.href;
var _dync_path = window.document.location.pathname;
var _dync_pos = _dync_href.indexOf(_dync_path);
var _dync_root_path = _dync_href.substring(0, _dync_pos) + "/";
//版本号处理
var _ver_src = document.getElementsByTagName("link")[0].href
var _ver_flag = _ver_src.indexOf("?")
var _ver_suffix;
if (_ver_flag != '-1') {
    _ver_suffix = _ver_src.substr(_ver_flag);
} else {
    var myDate = new Date;
    var year = myDate.getFullYear();
    var mon = myDate.getMonth() + 1;
    var day = myDate.getDate()
    _ver_suffix = "?v=" + year + mon + day;
}

var bimsUserSelectedLanguage;
//var browser_language = navigator.language || navigator.userLanguage; //常规浏览器语言和IE浏览器

bimsUserLanguageHandle()
//获取已选语言，若用户语言不支持，默认中文
function bimsUserLanguageHandle() {
    var cssLoadGetSelectedLanguage = window.sessionStorage.getItem("selectedLanguage")
    if (cssLoadGetSelectedLanguage) {
        bimsUserSelectedLanguage = cssLoadGetSelectedLanguage;
    } else {
        //解决首次登录，没有userInfo时，避免报错，跳转单点登录
        if (window.sessionStorage.getItem("userInfo")) {
            var userInfoLanguage = JSON.parse(window.sessionStorage.getItem("userInfo")).lang
            for (var i in support_language_list) {
                if (support_language_list[i].codeNo == userInfoLanguage) {
                    bimsUserSelectedLanguage = userInfoLanguage
                    return;
                } else {
                    bimsUserSelectedLanguage = "zh-CN";
                }
            }
        } else {
            bimsUserSelectedLanguage = "zh-CN";
        }
    }
    window.sessionStorage.setItem("selectedLanguage", bimsUserSelectedLanguage)
}

// loadCssByLanguage()
//根据支持的语言，加载多语言css
function loadCssByLanguage() {
    for (var i in support_language_list) {
        var lang = support_language_list[i].codeNo
        if (bimsUserSelectedLanguage == lang) {
            dynamicLoadCss(_dync_root_path + "/Languages/" + lang + "/css/global-" + lang + ".css" + _ver_suffix, 'stylesheet', lang)
        } else {
            dynamicLoadCss(_dync_root_path + "/Languages/" + lang + "/css/global-" + lang + ".css" + _ver_suffix, 'alternate stylesheet', lang)
        }
    }
}

function dynamicLoadCss(url, rel, lang) {
    var head = document.getElementsByTagName('head')[0];
    var link = document.createElement('link');
    link.type = 'text/css';
    link.rel = rel;
    link.href = url;
    link.lang = lang;
    head.appendChild(link);
}