
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
    var MatrixDialog = {
        v : '1.0.0',
        ie : function() { // ie版本
            var agent = navigator.userAgent.toLowerCase();
            return (!!window.ActiveXObject || "ActiveXObject" in window) ? ((agent
                        .match(/msie\s(\d+)/) || [])[1] || '11' // 由于ie11并没有msie的标识
                )
                : false;
        }(),

    }
    MatrixDialog.windowMap = new Map();
    window.MatrixDialog = MatrixDialog;
    //获取
    MatrixDialog.openLayer = function(data) {
        let index = null;
        if (data.m_current_dialog) {
            index = window.layer.open(data);
        }else {
            index = top.layer.open(data);
            top.MatrixDialog.windowMap.set(index.toString(), window);
        }
        return index;
    }
    //关闭窗口并回调方法
    MatrixDialog.closeAndCallBack = function(iframewindowid,data,operationType) {
        let index = null;
        let obj =null;
        try {
            index = top.layer.getFrameIndex(window.name);
            if (index == null || typeof index == "undefined") {
                return false;
            }
            if (typeof top.MatrixDialog == "undefined") {
                return false;
            }
            obj = top.MatrixDialog.windowMap.get(index);
            //关闭窗口时判断 当前页面有没有打开该name的窗口  并且页面window 集合里没有该对象也为false
            if (obj == null || typeof obj == "undefined") {
                return false;
            }
            if (typeof (obj["on" + iframewindowid + "Close"])!="undefined") {
                obj["on" + iframewindowid + "Close"](data, operationType);
            }
        } catch (err) {
            console.error(err);
            return false;
        } finally {
            if (obj != null && typeof obj != "undefined") {
                top.layer.close(index);
                top.MatrixDialog.windowMap.delete(index);
            }
        }
    }
// 主入口
    ready.run = function(_$) {
        $ = _$;
        win = $(window);
    };
    // 加载方式
    debugger;
    (typeof define === 'function' && define.amd) ? define(['jquery'], function(){ //requirejs加载
        ready.run(window.jQuery);
        return MatrixDialog;
    }) :function() { // 普通script标签加载
        ready.run(window.jQuery);
    }();

}(window);


