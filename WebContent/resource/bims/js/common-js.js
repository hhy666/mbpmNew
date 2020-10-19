document.write('<script type="text/javascript" src="' + _dync_root_path + 'js/plugins/jquery-3.3.1.min.js' + _ver_suffix + '"></script>');
document.write('<script type="text/javascript" src="' + _dync_root_path + 'js/plugins/boostrap/js/Popper.js' + _ver_suffix + '"></script>');
document.write('<script type="text/javascript" src="' + _dync_root_path + 'js/plugins/boostrap/js/bootstrap.min.js' + _ver_suffix + '"></script>');
document.write('<script type="text/javascript" src="' + _dync_root_path + 'js/plugins/bootstrap-table/bootstrap-table.min.js' + _ver_suffix + '"></script>');
document.write('<script type="text/javascript" src="' + _dync_root_path + 'js/plugins/bootstrap-table/bootstrap-table-locale-all.min.js' + _ver_suffix + '"></script>');
// document.write('<script type="text/javascript" src="' + _dync_root_path + 'js/plugins/layer/layer.js' + _ver_suffix + '"></script>');
document.write('<script type="text/javascript" src="' + _dync_root_path + 'js/plugins/bootstrap-datepicker-1.9.0-dist/js/bootstrap-datepicker.min.js' + _ver_suffix + '"></script>');
document.write('<script type="text/javascript" src="' + _dync_root_path + 'js/plugins/bootstrap-datepicker-1.9.0-dist/locales/bootstrap-datepicker.zh-CN.min.js' + _ver_suffix + '"></script>');
document.write('<script type="text/javascript" src="' + _dync_root_path + 'js/plugins/validate/jquery.validate.js' + _ver_suffix + '"></script>');
document.write('<script type="text/javascript" src="' + _dync_root_path + 'js/plugins/validate/additional-methods.js' + _ver_suffix + '"></script>');
document.write('<script type="text/javascript" src="' + _dync_root_path + 'js/plugins/webupload/webuploader.min.js' + _ver_suffix + '"></script>');
document.write('<script type="text/javascript" src="' + _dync_root_path + 'js/plugins/bootstrap3-typeahead/js/bootstrap3-typeahead.js' + _ver_suffix + '"></script>');
document.write('<script type="text/javascript" src="' + _dync_root_path + 'js/plugins/bootstrap-select-1.13.9/js/bootstrap-select.min.js' + _ver_suffix + '"></script>');
document.write('<script type="text/javascript" src="' + _dync_root_path + 'js/plugins/zTree_v3-master/js/jquery.ztree.all.min.js' + _ver_suffix + '"></script>');
document.write('<script type="text/javascript" src="' + _dync_root_path + 'js/plugins/zTree_v3-master/js/jquery.ztree.exhide.js' + _ver_suffix + '"></script>');
document.write('<script type="text/javascript" src="' + _dync_root_path + 'js/plugins/pagination/js/pagination.min.js' + _ver_suffix + '"></script>');
document.write('<script type="text/javascript" src="' + _dync_root_path + 'js/plugins/i18n/jquery.i18n.properties.js' + _ver_suffix + '"></script>');
document.write('<script type="text/javascript" src="' + _dync_root_path + 'js/pagejs/global.js' + _ver_suffix + '"></script>');
document.write('<script type="text/javascript" src="' + _dync_root_path + 'js/common/api.js' + _ver_suffix + '"></script>');
var commonjs_lang = window.sessionStorage.getItem("selectedLanguage")
if (!commonjs_lang) {
    commonjs_lang = "zh-CN"
}
document.write('<script type="text/javascript" src="' + _dync_root_path + 'js/plugins/layer/layer_' + commonjs_lang + '.js' + _ver_suffix + '"></script>');
document.write('<script type="text/javascript" src="' + _dync_root_path + 'Languages/' + commonjs_lang + '/js/language-param-' + commonjs_lang + '.js' + _ver_suffix + '"></script>');

document.write('<script type="text/javascript" src="' + _dync_root_path + 'js/common/util.js' + _ver_suffix + '"></script>');