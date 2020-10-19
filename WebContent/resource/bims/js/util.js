/**
 * 通用工具
 * @author: ZL
 * @version 1.0.0
 */

/**
 *【】ajax请求统一返回格式： { meta：{success:true/false,code:状态码,msg:消息,timestamp:时间字符串}, data:{返回需要的数据} }
 */
$().ready(function(){
    component_utilJsLang = getJsLanguageParam("component_utilJsLang")

	$("input[vf]").keyup(function() {
		var vf = $(this).attr("vf");
		$(this).val(regular[vf].replaceValue(this));
	});
	$("input[vf]").change(function() {
		var vf = $(this).attr("vf");
		$(this).val(regular[vf].replaceValue(this));
	});
	if($("select[name=outDepartmentId]").length > 0){
	    if($.getSessionStorage("appointOrgFlag") == "true"){
	        var searchOrgId = jQuery.parseJSON($.getSessionStorage('userInfo')).companyId
	        var callBack = function(result){
	            if(result.busCode == "SUCCESS"){
	                
	                $("select[name=outDepartmentId]").each(function(){
                       var id = $(this).attr("id")
                       var type = $(this).attr("type")
                       var selectList = result.resData
                       var option = "";
                       if(type == "outpay"){
                           option = '<option value="">'+component_utilJsLang.select_pleaseSelect+'</option>'
                       }else if(type == "invoice"){
                           option = '<option value="000000">'+component_utilJsLang.select_pleaseSelect+'</option>'
                       }else{
                           option = '<option value="">'+component_utilJsLang.select_all+'</option>'
                       }
                       for(var i in selectList){
                           option += "<option value="+selectList[i].unifyCode+">"+selectList[i].orgFullName+"</option>"
                       }
                       $("#"+id).html(option)
                       $("#"+id).selectpicker('refresh')
                       $("#"+id).selectpicker('render')
                       
                       var val = $(this).attr("default")
                       if(val != "" && val !=null){
                           $("#"+id).selectpicker('val', val);
                       }
	                })
	            }
	        }
	        AjaxHandler.ajaxGetAsync(BIMSglobalConfig.serverUrl+ BIMSapi.orgDepartment,{"searchOrgId":searchOrgId},callBack)
	    }else{
	        $('.selectpicker').selectpicker('destroy');
	        $("select[name=outDepartmentId]").each(function(){
	            $(this).prev().remove()
	        })
	        $("select[name=outDepartmentId]").remove()
	    }
	}
})
var component_utilJsLang = null

//默认bootstrap table pageList 大小
var pageList = [10,20,50,100,200,500];

//默认bootstrap table pageSize 大小
var pageSize = 20;

//bootstrap table
var BootstrapTableHandler = {
        bootstrapTableSetting : function(url,method,pageSize,pageList,sortName,uniqueId,columnsSetting,formId,height,showColumns){
            var showColumnsFlag = true;
            if (showColumns && showColumns == 'true') {
                showColumnsFlag = true;
            } else if (showColumns && showColumns == 'false') {
                showColumnsFlag = false;
            }
            var setting = {
                    url: url, 
                    method: method, 
                    toolbar: '#dataToolbar',  
                    contentType: 'application/x-www-form-urlencoded',
                    striped: true, 
                    cache: false,
                    pagination: true, 
                    sortable: true,
                    sortName: sortName,
                    sortOrder: "desc", 
                    sidePagination: "server",
                    pageNumber: 1, 
                    pageSize: pageSize, 
                    pageList: pageList, 
                    strictSearch: true,
                    showColumns: showColumnsFlag, 
                    minimumCountColumns: 2,
                    clickToSelect: false,
                    singleSelect: false,
                    height: height,
                    uniqueId: uniqueId,
                    showToggle: false,
                    cardView: false, 
                    detailView: false,
                    locale: getSelectedLanguage(),
                    queryParamsType:'', 
                   	queryParams: function queryParams(params){  //传递参数（*）
                   		var param = {};
                   		if(formId != null && formId != ""){
                   			param = form2JsonString(formId); //获得form的中的值，如果需要JSON.stringify,再加
                   		}
   						 var temp = { //与后台分页字段匹配
                                    pageNumber:this.pageNumber,
                                    pageSize:this.pageSize,
                                    sort:this.sortName,
                                    order:this.sortOrder
                                  };
     
   	                    $.extend(param, temp);//如果后台分页变量名和bootstrap变量名一致则使用该方式即可,最好一致
   	                    return param;
	                },
                    responseHandler:
                        function (res) {
                            if (res.code == "10000") {
                                var data;
                                if (typeof (res.resData) == "undefined") {
                                    data = [];
                                } else {
                                    data = res.resData;
                                }
                                return {
                                    "rows": data.rows,
                                    "total": data.total
                                };
                            } else if(res.code == "403"){
                                LayerHandler.errorMsgCallback(res.msg,function(){
                                    top.window.location = BIMSglobalConfig.ccicPortalUrl;
                                    sessionStorage.clear()
                                })
                            } else {
                                LayerHandler.errorMsg(res.msg);
                            }
                        },
						onLoadError:
						    function (status, jqXHR) {
						        if (jqXHR.responseJSON) {
						            LayerHandler.errorMsg(jqXHR.responseJSON.msg);
						        } else {
						            layer.alert("Network Exception");
						        }
						    },
                    columns: columnsSetting
                };
            return setting;
        },
        bootstrapTableSettingshowFooter : function(url,method,pageSize,pageList,sortName,uniqueId,columnsSetting,formId,height){
            var setting = {
                    url: url, 
                    method: method, 
                    toolbar: '#dataToolbar',  
                    contentType: 'application/x-www-form-urlencoded',
                    striped: true, 
                    cache: false,
                    pagination: true, 
                    sortable: true,
                    sortName: sortName,
                    sortOrder: "desc", 
                    showFooter:true,
                    sidePagination: "server",
                    pageNumber: 1, 
                    pageSize: pageSize, 
                    pageList: pageList, 
                    strictSearch: true,
                    showColumns: true, 
                    minimumCountColumns: 2,
                    clickToSelect: false,
                    singleSelect: false,
                    height: height,
                    uniqueId: uniqueId,
                    showToggle: false,
                    cardView: false, 
                    detailView: false,
                    locale: getSelectedLanguage(),
                    queryParamsType:'', 
                    queryParams: function queryParams(params){  //传递参数（*）
                   		var param = {};
                   		if(formId != null && formId != ""){
                   			param = form2JsonString(formId); //获得form的中的值，如果需要JSON.stringify,再加
                   		}
   						 var temp = { //与后台分页字段匹配
                                    pageNumber:this.pageNumber,
                                    pageSize:this.pageSize,
                                    sort:this.sortName,
                                    order:this.sortOrder
                                  };
     
   	                    $.extend(param, temp);//如果后台分页变量名和bootstrap变量名一致则使用该方式即可,最好一致
   	                    return param;
	                },
                    responseHandler:
                        function (res) {
                            if (res.code == "10000") {
                                var data;
                                if (typeof (res.resData) == "undefined") {
                                    data = [];
                                } else {
                                    data = res.resData;
                                }
                                return {
                                    "rows": data.rows,
                                    "total": data.total
                                };
                            } else if(res.code == "403"){
                                LayerHandler.errorMsgCallback(res.msg,function(){
                                    top.window.location = BIMSglobalConfig.ccicPortalUrl;
                                    sessionStorage.clear()
                                })
                            } else {
                                LayerHandler.errorMsg(res.msg);
                            }
                        },
						onLoadError:
						    function (status, jqXHR) {
						        if (jqXHR.responseJSON) {
						            LayerHandler.errorMsg(jqXHR.responseJSON.msg);
						        } else {
						            layer.alert("Network Exception");
						        }
						    },
                    columns: columnsSetting
                };
            return setting;
        },
        bootstrapTableSettingWithNoPagination : function(url,method,sortName,uniqueId,columnsSetting,formId,height){
            var setting = {
                    url: url, 
                    method: method, 
                    contentType: 'application/x-www-form-urlencoded',
                    striped: true, 
                    cache: false,
                    pagination: false, 
                    sortable: true,
                    sortName: sortName,
                    sortOrder: "desc", 
                    strictSearch: true,
                    showColumns: false, 
                    minimumCountColumns: 2,
                    clickToSelect: true,
                    singleSelect: false,
                    height: height,
                    uniqueId: uniqueId,
                    showToggle: false,
                    cardView: false, 
                    detailView: false,
                    locale: getSelectedLanguage(),
                    queryParams: function queryParams(params){  //传递参数（*）
						 var param = form2JsonString(formId); //获得form的中的值，如果需要JSON.stringify,再加
						 var temp = { //与后台分页字段匹配
                                 pageNumber:this.pageNumber,
                                 pageSize:this.pageSize,
                                 sort:this.sortName,
                                 order:this.sortOrder
                               };
  
	                    $.extend(param, temp);//如果后台分页变量名和bootstrap变量名一致则使用该方式即可,最好一致
	                    return param;
	                },
                    responseHandler:
                        function (res) {
                            if (res.code == "10000") {
                                var data;
                                if (typeof (res.resData) == "undefined") {
                                    data = [];
                                } else {
                                    data = res.resData;
                                }
                                return {
                                    "data": data.rows,
                                };
                            } else if(res.code == "403"){
                                LayerHandler.errorMsgCallback(res.msg,function(){
                                    top.window.location = BIMSglobalConfig.ccicPortalUrl;
                                    sessionStorage.clear()
                                })
                            } else {
                                LayerHandler.errorMsg(res.msg);
                            }
                        },
                    onLoadError:
                        function (status, jqXHR) {
                            if (jqXHR.responseJSON) {
                                LayerHandler.errorMsg(jqXHR.responseJSON.msg);
                            } else {
                                layer.alert("Network Exception");
                            }
                        },
                    columns: columnsSetting
                };
            return setting;
        },
        //后端分页   排序传参版
        bootstrapTableSettingSetData : function(url,method,pageSize,pageList,sortName,sortOrder,uniqueId,columnsSetting,formId,height){
            var setting = {
                    url: url, 
                    method: method, 
                    toolbar: '#dataToolbar',  
                    contentType: 'application/x-www-form-urlencoded',
                    striped: true, 
                    cache: false,
                    pagination: true, 
                    sortable: true,
                    sortName: sortName,
                    sortOrder: sortOrder, 
                    sidePagination: "server",
                    pageNumber: 1, 
                    pageSize: pageSize, 
                    pageList: pageList, 
                    strictSearch: true,
                    showColumns: false, 
                    minimumCountColumns: 2,
                    clickToSelect: false,
                    singleSelect: false,
	                height: height,
                    uniqueId: uniqueId,
                    showToggle: false,
                    cardView: false, 
                    detailView: false,
                    locale: getSelectedLanguage(),
                    queryParamsType:'', 
                   	queryParams: function queryParams(params){  //传递参数（*）
						 var param = form2JsonString(formId); //获得form的中的值，如果需要JSON.stringify,再加
						 var temp = { //与后台分页字段匹配
                                 pageNumber:this.pageNumber,
                                 pageSize:this.pageSize,
                                 sort:$.isEmpty(this.sortName)?param.sort:this.sortName,
                                 order:$.isEmpty(this.sortOrder)?param.order:this.sortOrder
                               };
  
	                    $.extend(param, temp);//如果后台分页变量名和bootstrap变量名一致则使用该方式即可,最好一致
	                    return param;
	                },
                    responseHandler:
                        function (res) {
                            if (res.code == "10000") {
                                var data;
                                if (typeof (res.resData) == "undefined") {
                                    data = [];
                                } else {
                                    data = res.resData;
                                }
                                return {
                                    "rows": data.rows,
                                    "total": data.total
                                };
                            } else if(res.code == "403"){
                                LayerHandler.errorMsgCallback(res.msg,function(){
                                    top.window.location = BIMSglobalConfig.ccicPortalUrl;
                                    sessionStorage.clear()
                                })
                            } else {
                                LayerHandler.errorMsg(res.msg);
                            }
                        },
                    onLoadError:
                        function (status, jqXHR) {
                            if (jqXHR.responseJSON) {
                                LayerHandler.errorMsg(jqXHR.responseJSON.msg);
                            } else {
                                layer.alert("Network Exception");
                            }
                        },
                    columns: columnsSetting
                };
            return setting;
       },
        // 前端list分页
        bootstrapTableSettingWithPaginationAndInitData : function(data,pageSize,pageList,sortName,uniqueId,columnsSetting){
            var setting = {
                    data: data,
                    striped: true, 
                    cache: false,
                    pagination: true, 
                    sidePagination:"client",
                    pageNumber: 1, 
                    pageSize: pageSize, 
                    pageList: pageList, 
                    total:data.length,
                    sortable: true,
                    sortName: sortName,
                    sortOrder: "desc", 
                    strictSearch: true,
                    showColumns: false, 
                    minimumCountColumns: 2,
                    clickToSelect: true,
                    singleSelect: false,
                    //height: 400,
                    uniqueId: uniqueId,
                    showToggle: false,
                    cardView: false, 
                    detailView: false,
                    locale: getSelectedLanguage(),
                    columns: columnsSetting
                };
            return setting;
        },
        // 前端list不分页
        bootstrapTableSettingWithNoPaginationAndInitData : function(data,sortName,uniqueId,columnsSetting){
            var setting = {
                    data: data,
                    striped: true, 
                    cache: false,
                    pagination: false, 
                    sidePagination:"client",
                    sortable: true,
                    sortName: sortName,
                    sortOrder: "desc", 
                    strictSearch: true,
                    showColumns: false, 
                    minimumCountColumns: 2,
                    clickToSelect: true,
                    singleSelect: false,
                    //height: 400,
                    uniqueId: uniqueId,
                    showToggle: false,
                    cardView: false, 
                    detailView: false,
                    locale: getSelectedLanguage(),
                    columns: columnsSetting
                };
            return setting;
        },
        bootstrapTableSettingWithPaginationAndInitDataSingleClick : function(url,method,pageSize,pageList,sortName,uniqueId,columnsSetting,formId,height){
           var setting = {
                    url: url, 
                    method: method, 
                    toolbar: '#dataToolbar',  
                    contentType: 'application/x-www-form-urlencoded',
                    striped: true, 
                    cache: false,
                    pagination: true, 
                    sortable: true,
                    sortName: sortName,
                    sortOrder: "desc", 
                    sidePagination: "server",
                    pageNumber: 1, 
                    pageSize: pageSize, 
                    pageList: pageList, 
                    strictSearch: true,
                    showColumns: true, 
                    minimumCountColumns: 2,
                    clickToSelect: false,
                    singleSelect: true,
                    height: height,
                    uniqueId: uniqueId,
                    showToggle: false,
                    cardView: false, 
                    detailView: false,
                    locale: getSelectedLanguage(),
                    queryParamsType:'', 
                    queryParams: function queryParams(params){  //传递参数（*）
                        var param = {};
                        if(formId != null && formId != ""){
                            param = form2JsonString(formId); //获得form的中的值，如果需要JSON.stringify,再加
                        }
                         var temp = { //与后台分页字段匹配
                                    pageNumber:this.pageNumber,
                                    pageSize:this.pageSize,
                                    sort:this.sortName,
                                    order:this.sortOrder
                                  };
     
                        $.extend(param, temp);//如果后台分页变量名和bootstrap变量名一致则使用该方式即可,最好一致
                        return param;
                    },
                    responseHandler:
                        function (res) {
                            if (res.code == "10000") {
                                var data;
                                if (typeof (res.resData) == "undefined") {
                                    data = [];
                                } else {
                                    data = res.resData;
                                }
                                return {
                                    "rows": data.rows,
                                    "total": data.total
                                };
                            } else if(res.code == "403"){
                                LayerHandler.errorMsgCallback(res.msg,function(){
                                    top.window.location = BIMSglobalConfig.ccicPortalUrl;
                                    sessionStorage.clear()
                                })
                            } else {
                                LayerHandler.errorMsg(res.msg);
                            }
                        },
                    onLoadError:
                        function (status, jqXHR) {
                            if (jqXHR.responseJSON) {
                                LayerHandler.errorMsg(jqXHR.responseJSON.msg);
                            } else {
                                layer.alert("Network Exception");
                            }
                        },
                    columns: columnsSetting
                };
            return setting;
        },
        bootstrapTableSettingWithPaginationAndInitDataSelectRow : function(url,method,pageSize,pageList,sortName,uniqueId,columnsSetting,formId,selectFlag,height){
           var setting = {
                    url: url, 
                    method: method, 
                    toolbar: '#dataToolbar',  
                    contentType: 'application/x-www-form-urlencoded',
                    striped: true, 
                    cache: false,
                    pagination: true, 
                    sortable: true,
                    sortName: sortName,
                    sortOrder: "desc", 
                    sidePagination: "server",
                    pageNumber: 1, 
                    pageSize: pageSize, 
                    pageList: pageList, 
                    strictSearch: true,
                    showColumns: false, 
                    minimumCountColumns: 2,
                    clickToSelect: false,
                    singleSelect: selectFlag,
                    height: height,
                    uniqueId: uniqueId,
                    showToggle: false,
                    cardView: false, 
                    detailView: false,
                    locale: getSelectedLanguage(),
                    queryParamsType:'', 
                    queryParams: function queryParams(params){  //传递参数（*）
                        var param = {};
                        if(formId != null && formId != ""){
                            param = form2JsonString(formId); //获得form的中的值，如果需要JSON.stringify,再加
                        }
                         var temp = { //与后台分页字段匹配
                                    pageNumber:this.pageNumber,
                                    pageSize:this.pageSize,
                                    sort:this.sortName,
                                    order:this.sortOrder
                                  };
     
                        $.extend(param, temp);//如果后台分页变量名和bootstrap变量名一致则使用该方式即可,最好一致
                        return param;
                    },
                    responseHandler:
                        function (res) {
                            if (res.code == "10000") {
                                var data;
                                if (typeof (res.resData) == "undefined") {
                                    data = [];
                                } else {
                                    data = res.resData;
                                }
                                return {
                                    "rows": data.rows,
                                    "total": data.total
                                };
                            } else if(res.code == "403"){
                                LayerHandler.errorMsgCallback(res.msg,function(){
                                    top.window.location = BIMSglobalConfig.ccicPortalUrl;
                                    sessionStorage.clear()
                                })
                            } else {
                                LayerHandler.errorMsg(res.msg);
                            }
                        },
                    onLoadError:
                        function (status, jqXHR) {
                            if (jqXHR.responseJSON) {
                                LayerHandler.errorMsg(jqXHR.responseJSON.msg);
                            } else {
                                layer.alert("Network Exception");
                            }
                        },
                    columns: columnsSetting
                };
            return setting;
        },
        /**
         * 插入单条记录
         * $table.bootstrapTable('insertRow', {index: 1, row: row}).
         * 
         * 
         */
        insertRow:function(tableId,rowRecord){
            $("#"+tableId).bootstrapTable('insertRow', rowRecord)
        },
        /**
         * 修改单条记录
         * $table.bootstrapTable('updateByUniqueId', {id: 3, row: row}).
         * 
         */
        updateRowByUniqueId:function(tableId,rowRecord){
            $("#"+tableId).bootstrapTable('updateByUniqueId', rowRecord);
        },
        /**
         * 删除单条记录
         * $table.bootstrapTable('removeByUniqueId', 1).
         * @param id
         */
        deleteRowByUniqueId:function(tableId,uniqueId){
            $("#"+tableId).bootstrapTable('removeByUniqueId', uniqueId);
        }
        
};
var AjaxHandler = {
        /**
         * 异步请求
         * 请求地址：requestUrl
         * JSON对象: params
         * 正常回调方法: callBack
         */
        ajaxGetAsync : function(requestUrl, params, callBack) {
            return ajaxFunc(requestUrl, params, "GET", callBack, true);
        },
        ajaxPostAsync : function(requestUrl, params, callBack) {
            return ajaxFunc(requestUrl, params, "POST", callBack, true);
        },
        ajaxPutAsync : function(requestUrl, params, callBack) {
            return ajaxFunc(requestUrl, params, "PUT", callBack, true);
        },
        ajaxDeleteAsync : function(requestUrl, params, callBack) {
            return ajaxFunc(requestUrl, params, "DELETE", callBack, true);
        },
        ajaxPostFormAsync: function(requestUrl, params, callBack) {
        	var data = null;
        	var opts = {
        		type: "POST",
        		url: requestUrl,
        		data: {filter:params},
        		//dataType: "json",
        		contentType: "application/x-www-form-urlencoded;charset=utf-8",
        		cache: false,
        		async: true,
                success: function (result, status, xhr) {
                    if (result.code == '10000') {
                        if (callBack) { //有回调方法
                            callBack(result); //自行处理
                        } else {
                            data = result;
                        }
                    } else {
                        LayerHandler.errorMsg(result.msg);
                    }
                },
                error: function (xhr, status, error) {
                    if (xhr.responseJSON) {
                        LayerHandler.errorMsg(xhr.responseJSON.msg);
                    } else {
                        layer.alert("Network Exception");
                    }
                }
        	};
        	$.ajax(opts);
        	return data;
        }, 
        
        ajaxFuncNoLoadingMes: function (requestUrl, params, method, callBack, sync) {
		    var data = null;
		    var opts = {
		        type: method,
		        url: requestUrl,
		        data: {},
		        dataType: "json",
		        contentType: "application/json;charset=utf-8",
		        cache: false,
		        async: sync,
		        success: function (result, status, xhr) {
		            if (result.code == '10000') {
		                if (callBack) { //有回调方法
		                    callBack(result); //自行处理
		                } else {
		                    data = result;
		                }
		            } else if (result.code == "403") {
		                LayerHandler.errorMsgCallback(result.msg, function () {
		                    top.window.location = BIMSglobalConfig.ccicPortalUrl;
		                    sessionStorage.clear()
		                })
		            } 
		        },
		        error: function (xhr, status, error) {
		            if (xhr.responseJSON) {
		                LayerHandler.errorMsg(xhr.responseJSON.msg);
		            } else {
		                layer.alert("Network Exception");
		            }
		        }
		    };
		    if (params) {
		        var queryStr = params;
		        if (method == "GET") {
		            queryStr = $.param(queryStr); //自动转换为查询字符串
		            //queryStr = encodeURI(encodeURI(queryStr));//编码防止中文(后台需要自行decode)
		            opts.contentType = "application/x-www-form-urlencoded;charset=utf-8";
		        } else {
		            queryStr = JSON.stringify(params);
		        }
		        opts.data = queryStr;
		    }
		    $.ajax(opts);
		    return data;
		},
        /**
         * 同步请求
         * 请求地址：requestUrl
         * JSON对象: params
         */
        ajaxGetSync : function(requestUrl, params) {
            return ajaxFunc(requestUrl, params, "GET", null, false);
        },
        ajaxPostSync : function(requestUrl, params) {
            return ajaxFunc(requestUrl, params, "POST", null, false);
        },
        ajaxPutSync : function(requestUrl, params) {
            return ajaxFunc(requestUrl, params, "PUT", null, false);
        },
        ajaxDeleteSync : function(requestUrl, params) {
            return ajaxFunc(requestUrl, params, "DELETE", null, false);
        },
        /**
         * 自行传参,默认同步,直接返回结果
         * options：参数配置对象{}
         */
        ajaxCustomGet : function(options) {
            options.type = "GET";//强制设置为GET
            return ajaxCustomFunc(options);
        },
        ajaxCustomPost : function(options) {
            options.type = "POST";//强制设置为POST
            return ajaxCustomFunc(options);
        },
        ajaxCustomPut : function(options) {
            options.type = "PUT";//强制设置为PUT
            return ajaxCustomFunc(options);
        },
        ajaxCustomDelete : function(options) {
            options.type = "DELETE";//强制设置为DELETE
            return ajaxCustomFunc(options);
        }
};
//固定传参
var ajaxFunc = function(requestUrl, params, method, callBack, sync) {
    var data=null;
    var opts =  {
            type: method,
            url: requestUrl,
            data: {},
            dataType: "json",
            contentType : "application/json;charset=utf-8",
            cache : false,
            async : sync,
//          beforeSend:function(){
//              LayerHandler.loadMsg(2)
//          },
//          complete: function(){
//              LayerHandler.loadRemove();
//          },
            success: function (result, status, xhr) {
                if (result.code == '10000') {
                    if (callBack) { //有回调方法
                        callBack(result); //自行处理
                    } else {
                        data = result;
                    }
                } else if(result.code == "403"){
                    LayerHandler.errorMsgCallback(result.msg,function(){
                        top.window.location = BIMSglobalConfig.ccicPortalUrl;
                        sessionStorage.clear()
                    })
                } else {
                    LayerHandler.errorMsg(result.msg);
                }
            },
            error: function (xhr, status, error) {
                if (xhr.responseJSON) {
                    LayerHandler.errorMsg(xhr.responseJSON.msg);
                } else {
                    layer.alert("Network Exception");
                }
            }
      };
    
    if(params){
        var queryStr = params;
        if(method == "GET"){
            queryStr = $.param(queryStr);//自动转换为查询字符串
            //queryStr = encodeURI(encodeURI(queryStr));//编码防止中文(后台需要自行decode)
            opts.contentType = "application/x-www-form-urlencoded;charset=utf-8";
        }else{
            queryStr = JSON.stringify(params);
        }
        opts.data = queryStr;
    }
    
     $.ajax(opts);
     return data;
};
//自定传参
var ajaxCustomFunc = function(options) {
    var data=null;
    var opts =  $.extend({
            type: '',//GET/POST/PUT/DELETE
            url: '',
            data: {},
            dataType: "json",
            contentType : "application/json;charset=utf-8",
            cache : false, //false:不缓存
            async : false, //false:同步
            success: function (result, status, xhr) {
                if (result.code == '10000') {
                    data = result;
                } else if(result.code == "403"){
                    LayerHandler.errorMsgCallback(result.msg,function(){
                        top.window.location = BIMSglobalConfig.ccicPortalUrl;
                        sessionStorage.clear()
                    })
                } else {
                    LayerHandler.errorMsg(result.msg);
                }
            },
            error : function(xhr,status,error) {
                if (xhr.responseJSON) {
                    LayerHandler.errorMsg(xhr.responseJSON.msg);
                } else {
                    layer.alert("Network Exception");
                }
                return null;
            }
        }, options);
    if(opts.data){
        var queryStr = opts.data;
        if(method == "GET"){
            queryStr = $.param(queryStr);//转换为查询字符串
            queryStr = encodeURI(encodeURI(queryStr));//编码防止中文(后台需要自行decode)
            opts.contentType = "application/x-www-form-urlencoded;charset=utf-8";
        }else{
            queryStr = JSON.stringify(queryStr);//参数带上JSON.stringify();
        }
        opts.data = queryStr;
    }
    
    $.ajax(opts);
    return data;
};

/**
 * 列表分页查询组装filter 值
 */
var ConditionFilterHandler={
	
	wrapFilterVal:function(formId,andFlag){
		var form = $("#" + formId);
		var inputArr = form.find('input:text');
		var array = new Array();
		for(var i=0;i<inputArr.length;i++){
			var attr = inputArr[i].name;
			var condition = inputArr[i].getAttribute("condition");
			var inputVal = inputArr[i].value;
			if('' != inputVal && null != condition){
				var temp = attr +' ' + condition +' ' + inputVal;
				array.push(temp);
			}
		}
		var selectArr = form.find('select');
		for(var i=0;i<selectArr.length;i++){
			var attr = selectArr[i].name;
			var condition = selectArr[i].getAttribute("condition");
			var selectVal = selectArr[i].value;
			if('' != selectVal){
				var temp = attr +' ' + condition +' ' + selectVal;
				array.push(temp);
			}
		}
		if(andFlag){
			return array.join(' %and ');
		}else{
			return array.join(' %or ');
		}
		
	}
	
};
/**
 * 金额处理类
 */
var MoneyHandler = {
	/**
	 * 分转元
	 */
	fenTransferYuan:function(amount){
		if(amount !=null || amount !=""){
			var result =  Number(amount) / 100.0;
			return result.toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,')
		}else{
			return;
		}
	},
	/**
	 * 元转分
	 */
	yuanTransferFen:function(amount){
		var result = Number(amount.toString().replace(",", "")) * 100;
		return result.toFixed(0);
	}
};


/**
 * 去除空格处理器
 */
var TrimSpaceHandler = {
		// 去除首尾空格
		trimStartAndEndSpace:function(val){
			var str_new = $.trim(val);
			return str_new;
		}
}

/**
 * layer 提示框
 */
var LayerHandler = {
    success: function(msg) {
        layer.msg(msg, {
            icon: 1
        });
    },
    error: function(msg) {
        layer.alert(msg, {
    		icon: 5
  			 ,closeBtn: 0 
	    },function(index){
	    	layer.close(index);
	    })
    },
    warning: function(msg) {
        layer.msg(msg, {
            icon: 0
        });
    },
    warningForConfirm: function(msg, func) {

        layer.confirm(msg, {
            icon: 3,
            title: component_utilJsLang.layerAlertTitle
        }, function(index) {
            //do something
            func();
            layer.close(index);
        });
    },
    successMsg:function(msg){
    	msg = undefined == msg ? component_utilJsLang.oprSuccess : msg;
    	layer.msg(msg, {
    		icon: 6,
    		time:3000
    	});
    },
    errorMsg:function(msg){
    	msg = undefined == msg ? component_utilJsLang.oprError : msg;
    	layer.alert(msg, {
    		icon: 5
  			 ,closeBtn: 0 
	    },function(index){
	    	layer.close(index);
	    })
	},
    promptMsg:function(msg){
    	layer.alert(msg, {
    		icon: 7
  			 ,closeBtn: 0 
	    },function(index){
	    	layer.close(index);
	    })
	},
    errorMsgCallback:function(msg,callback){
    	msg = undefined == msg ? component_utilJsLang.networkError : msg;
    	layer.alert(msg, {
    		icon: 5
  			 ,closeBtn: 0 
	    },function(index){
	    	callback();
	    	layer.close(index);
	    })
	},
    promptMsgCallback:function(msg,callback){
    	layer.alert(msg, {
    		icon: 7
	    },function(index){
	    	callback();
	    	layer.close(index);
	    })
	},
	loadMsg:function(msg){
		if(msg){
			layer.load(msg);
		}else{
			layer.load(2);
		}
	},
	loadRemove:function(){
		layer.closeAll('loading');
	},
	successMsgCallback:function(msg,callback){
    	layer.alert(msg, {
    		icon: 6
  			 ,closeBtn: 0 
	    },function(index){
	    	callback();
	    	layer.close(index);
	    })
    },
    successAlert: function (msg) {
        layer.alert(msg, {
            icon: 1
        });
    }
}
/**
 * 处理url参数
 */
var UrlHandler = {
        /** 获取url参数 
         *  参数名 ： name
         */
        getUrlParam : function(name){
             var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
             var r = window.location.search.substr(1).match(reg);  //匹配目标参数
             if (r != null) return unescape(r[2]); return null; //返回参数值
        },
}

var DateHandler = {
        /**
         * option date
         * startTimeId : start-time-id
         * endTimeId : end-time-id
         * format : How to output the required date
         * format : String. default : 'mm/dd/yyyy'
         *  p : meridian in lower case ('am' or 'pm') - according to locale file
            P : meridian in upper case ('AM' or 'PM') - according to locale file
            s : seconds without leading zeros
            ss : seconds, 2 digits with leading zeros
            i : minutes without leading zeros
            ii : minutes, 2 digits with leading zeros
            h : hour without leading zeros - 24-hour format
            hh : hour, 2 digits with leading zeros - 24-hour format
            H : hour without leading zeros - 12-hour format
            HH : hour, 2 digits with leading zeros - 12-hour format
            d : day of the month without leading zeros
            dd : day of the month, 2 digits with leading zeros
            m : numeric representation of month without leading zeros
            mm : numeric representation of the month, 2 digits with leading zeros
            M : short textual representation of a month, three letters
            MM : full textual representation of a month, such as January or March
            yy : two digit representation of a year
            yyyy : full numeric representation of a year, 4 digits
         */
        /*minView 日期控件显示 0为到秒，2为到日*/
        //startTime和endTime两个方法可以进行起始时间大小的判断，若不需要可以使用basicSettings方法
        startTime : function(startTimeId,endTimeId,format,minView,hideInputId){
            $('#'+startTimeId).datepicker({
                format: format,
                weekStart: 1,
                todayBtn:  'linked',
                todayHighlight: 1,
                startView: 0,
                forceParse: 0,
                showMeridian: 0,
                minView:minView,
                language: getSelectedLanguage(), //语言
                autoclose: true, //选择后自动关闭
                clearBtn: true,//清除按钮
            }).on('changeDate',function(ev){
                var startTime = $('#'+startTimeId).val();
                $('#'+hideInputId).val(startTime);
                /**
                 * Set the start time to the minimum end time
                 * hide : endTime < startTime Click not allowed
                 */
                $('#'+endTimeId).datepicker('setStartDate', startTime);
            });
        },
        endTime : function(startTimeId,endTimeId,format,minView,hideInputId){
            $('#'+endTimeId).datepicker({
                format: format,
                weekStart: 1,
                todayBtn:  'linked',
                todayHighlight: 1,
                startView: 0,
                forceParse: 0,
                showMeridian: 0,
                minView:minView,
                language: getSelectedLanguage(), //语言
                autoclose: true, //选择后自动关闭
                clearBtn: true,//清除按钮
            }).on('changeDate',function(ev){
                var endTime = $('#'+endTimeId).val();
                $('#'+hideInputId).val(endTime);
                /**
                 * Set the end time to the maximum start time
                 * hide : endTime < startTime Click not allowed
                 */
                $('#'+startTimeId).datepicker('setEndDate', endTime);       
            })
        }, 
        startTime_months : function(startTimeId,endTimeId,format,minView,hideInputId){
            $('#'+startTimeId).datepicker({
                format: format,
                weekStart: 1,
                todayBtn:  'linked',
                todayHighlight: 1,
                startView: 1,
                forceParse: 0,
                showMeridian: 0,
                minView:minView,
                minViewMode: 1,
   				maxViewMode: 2,
                language: getSelectedLanguage(), //语言
                autoclose: true, //选择后自动关闭
                clearBtn: true,//清除按钮
            }).on('changeDate',function(ev){
                var startTime = $('#'+startTimeId).val();
                $('#'+hideInputId).val(startTime);
                /**
                 * Set the start time to the minimum end time
                 * hide : endTime < startTime Click not allowed
                 */
                $('#'+endTimeId).datepicker('setStartDate', startTime);
            });
        },
        endTime_months : function(startTimeId,endTimeId,format,minView,hideInputId){
            $('#'+endTimeId).datepicker({
                format: format,
                weekStart: 1,
                todayBtn:  'linked',
                todayHighlight: 1,
                startView: 1,
                forceParse: 0,
                showMeridian: 0,
                minView:minView,
                minViewMode: 1,
   				maxViewMode: 2,
                language: getSelectedLanguage(), //语言
                autoclose: true, //选择后自动关闭
                clearBtn: true,//清除按钮
            }).on('changeDate',function(ev){
                var endTime = $('#'+endTimeId).val();
                $('#'+hideInputId).val(endTime);
                /**
                 * Set the end time to the maximum start time
                 * hide : endTime < startTime Click not allowed
                 */
                $('#'+startTimeId).datepicker('setEndDate', endTime);       
            })
        },
        //一个基本配置的日期选择器,hideInputId是接收选中时间的隐藏输入框id
        basicSettings_months : function(datePickerId,format,minView,hideInputId){
            $('#'+datePickerId).datepicker({
                format: format,
                weekStart: 1,
                todayBtn:  'linked',
                todayHighlight: 1,
                startView: 1,
                forceParse: 0,
                showMeridian: 0,
                minView:minView,
                minViewMode: 1,
   				maxViewMode: 2,
                language: getSelectedLanguage(), //语言
                autoclose: true, //选择后自动关闭
                clearBtn: true,//清除按钮
            }).on('hide',function(ev){
                var pickTime = $('#'+datePickerId).val();
                $('#'+hideInputId).val($('#'+datePickerId).val());
            });
        },
        basicSettings_monthsdata : function(datePickerId,format,minView,hideInputId){
            $('#'+datePickerId).datepicker({
            	 format: format,
                weekStart: 1,
                todayBtn:  'linked',
                todayHighlight: 1,
                startView: 0,
                forceParse: 0,
                showMeridian: 0,
                minView:minView,
                language: getSelectedLanguage(), //语言
                autoclose: true, //选择后自动关闭
                clearBtn: true,//清除按钮
                startDate: (function () {
                  var date = (new Date().toLocaleDateString() + '/0/0').split('/');
                  return new Date(date[0],date[1]-1);
                 })(),
                endDate: (function () {
                  var date = (new Date().toLocaleDateString() + '/23/59').split('/');
                  return new Date(date[0], date[1],0,date[3],date[4]);
                })()
            }).on('hide',function(ev){
                var pickTime = $('#'+datePickerId).val();
                $('#'+hideInputId).val($('#'+datePickerId).val());
            });
        },
          basicSettings_year : function(datePickerId,format,minView,hideInputId){
            $('#'+datePickerId).datepicker({
                format: format,
                weekStart: 1,
                todayBtn:  'linked',
                todayHighlight: 1,
                startView: 1,
                forceParse: 0,
                showMeridian: 0,
                minView:minView,
                minViewMode: 2,
   				maxViewMode: 2,
                language: getSelectedLanguage(), //语言
                autoclose: true, //选择后自动关闭
                clearBtn: true,//清除按钮
            }).on('hide',function(ev){
                var pickTime = $('#'+datePickerId).val();
                $('#'+hideInputId).val($('#'+datePickerId).val());
            });
        },
        basicSettings : function(datePickerId,format,minView,hideInputId){
            $('#'+datePickerId).datepicker({
                format: format,
                weekStart: 1,
                todayBtn:  'linked',
                todayHighlight: 1,
                startView: 0,
                forceParse: 0,
                showMeridian: 0,
                minView:minView,
                language: getSelectedLanguage(), //语言
                autoclose: true, //选择后自动关闭
                clearBtn: true,//清除按钮
            }).on('hide',function(ev){
                var pickTime = $('#'+datePickerId).val();
                $('#'+hideInputId).val($('#'+datePickerId).val());
            });
        },
        /**
         * class is "glyphicon-remove" can remove time label content
         */
        removeTime : function(){
            $(".glyphicon-remove").click(function(){
                $($($(this).parent()).prev()).val("");
            });
        },
        /**
         * Get user timezone 获取时区
         */
        clientTimeZone : function () {
            var munites = new Date().getTimezoneOffset();
            var hour = parseInt(munites / 60);
            var munite = munites % 60;
            var prefix = "-";
            if (hour < 0 || munite < 0) {
                prefix = "+";
                hour = -hour;
                if (munite < 0) {
                    munite = -munite;
                }
            }
            hour = hour + "";
            munite = munite + "";
            if (hour.length == 1) {
                hour = "0" + hour;
            }
            if (munite.length == 1) {
                munite = "0" + munite;
            }
        return prefix + hour +":"+ munite;
            //return prefix + parseInt(hour);
        },
        /**由于地址栏"+" 号不能转义,所以timeZone 正负号处理 0表示+ 1表示-*/
        timeZoneHead : function(timeZone) {
            var noSymbolTimeZone = timeZone.substring(1,timeZone.length);
            var symbol = timeZone.substring(0,1);
            if("+" == symbol){
                timeZone = "0"+noSymbolTimeZone;
            }
            if("-" == symbol){
                timeZone = "1"+noSymbolTimeZone;
            }
            return "" != timeZone ? timeZone : "";
        },
        dateTime : function(timeId,format,minView){
            $('#'+timeId).datetimepicker({
                format: format,
                weekStart: 1,
                todayBtn:  1,
                startDate : new Date(),
                autoclose: 1,
                todayHighlight: 1,
                startView: 2,
                forceParse: 0,
                showMeridian: 0,
                minView:minView
            }).on('hide',function(ev){

            });
        },
        /**
         * 格式化日期，用法formatDateByParam(date,"yyyy-MM-dd HH:mm")
         * @param 时间 date
         * @param 输出格式 mask
         * d:日期天数；dd:日期天数（2位，不够补0）；ddd:星期（英文简写）；dddd:星期（英文全拼）；
         * M:数字月份；MM:数字月份（2位，不够补0）；MMM:月份（英文简写）；MMMM:月份（英文全拼）；
         * yy:年份（2位）；yyyy:年份；
         * h:小时（12时计时法）；hh:小时（2位，不足补0；12时计时法）；
         * H:小时（24时计时法）；HH:小时（2位，不足补0；24时计时法）；
         * m:分钟；mm:分钟（2位，不足补0）；
         * s:秒；ss:秒（2位，不足补0）；
         * l:毫秒数（保留3位）；
         * tt: 小时（12时计时法，保留am、pm）；TT: 小时（12时计时法，保留AM、PM）；
         */
         formatDateByParam : function(date,mask){
             /*在使用new Date()过程中，传递时间参数，会遇到一些兼容问题，谷歌上没有问题，ie ,火狐上出现的Invalid Date,因此将所有的'-'转为'/'即可*/
            if(date != null && date != ''){
                date = date.replace(new RegExp(/-/gm) ,"/");//将所有的'-'转为'/'即可
            }else {
                return
            }
            
            
            var d = new Date(date);
            var zeroize = function (value, length)
            {
                if (!length) length = 2;
                value = String(value);
                for (var i = 0, zeros = ''; i < (length - value.length); i++)
                {
                    zeros += '0';
                }
                return zeros + value;
            };
         
            return mask.replace(/"[^"]*"|'[^']*'|\b(?:d{1,4}|m{1,4}|yy(?:yy)?|([hHMstT])\1?|[lLZ])\b/g, function ($0)
            {
                switch ($0)
                {
                    case 'd': return d.getDate();
                    case 'dd': return zeroize(d.getDate());
                    case 'ddd': return ['Sun', 'Mon', 'Tue', 'Wed', 'Thr', 'Fri', 'Sat'][d.getDay()];
                    case 'dddd': return ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'][d.getDay()];
                    case 'M': return d.getMonth() + 1;
                    case 'MM': return zeroize(d.getMonth() + 1);
                    case 'MMM': return ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'][d.getMonth()];
                    case 'MMMM': return ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'][d.getMonth()];
                    case 'yy': return String(d.getFullYear()).substr(2);
                    case 'yyyy': return d.getFullYear();
                    case 'h': return d.getHours() % 12 || 12;
                    case 'hh': return zeroize(d.getHours() % 12 || 12);
                    case 'H': return d.getHours();
                    case 'HH': return zeroize(d.getHours());
                    case 'm': return d.getMinutes();
                    case 'mm': return zeroize(d.getMinutes());
                    case 's': return d.getSeconds();
                    case 'ss': return zeroize(d.getSeconds());
                    case 'l': return zeroize(d.getMilliseconds(), 3);
                    case 'L': var m = d.getMilliseconds();
                        if (m > 99) m = Math.round(m / 10);
                        return zeroize(m);
                    case 'tt': return d.getHours() < 12 ? 'am' : 'pm';
                    case 'TT': return d.getHours() < 12 ? 'AM' : 'PM';
                    case 'Z': return d.toUTCString().match(/[A-Z]+$/);
                    default: return $0.substr(1, $0.length - 2);
                }
            });
        },
        //此方法传入参数date为new Date()类型
        formatNewDateByParam : function(date,mask){
           var d = date;
           var zeroize = function (value, length)
           {
               if (!length) length = 2;
               value = String(value);
               for (var i = 0, zeros = ''; i < (length - value.length); i++)
               {
                   zeros += '0';
               }
               return zeros + value;
           };
        
           return mask.replace(/"[^"]*"|'[^']*'|\b(?:d{1,4}|m{1,4}|yy(?:yy)?|([hHMstT])\1?|[lLZ])\b/g, function ($0)
           {
               switch ($0)
               {
                   case 'd': return d.getDate();
                   case 'dd': return zeroize(d.getDate());
                   case 'ddd': return ['Sun', 'Mon', 'Tue', 'Wed', 'Thr', 'Fri', 'Sat'][d.getDay()];
                   case 'dddd': return ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'][d.getDay()];
                   case 'M': return d.getMonth() + 1;
                   case 'MM': return zeroize(d.getMonth() + 1);
                   case 'MMM': return ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'][d.getMonth()];
                   case 'MMMM': return ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'][d.getMonth()];
                   case 'yy': return String(d.getFullYear()).substr(2);
                   case 'yyyy': return d.getFullYear();
                   case 'h': return d.getHours() % 12 || 12;
                   case 'hh': return zeroize(d.getHours() % 12 || 12);
                   case 'H': return d.getHours();
                   case 'HH': return zeroize(d.getHours());
                   case 'm': return d.getMinutes();
                   case 'mm': return zeroize(d.getMinutes());
                   case 's': return d.getSeconds();
                   case 'ss': return zeroize(d.getSeconds());
                   case 'l': return zeroize(d.getMilliseconds(), 3);
                   case 'L': var m = d.getMilliseconds();
                       if (m > 99) m = Math.round(m / 10);
                       return zeroize(m);
                   case 'tt': return d.getHours() < 12 ? 'am' : 'pm';
                   case 'TT': return d.getHours() < 12 ? 'AM' : 'PM';
                   case 'Z': return d.toUTCString().match(/[A-Z]+$/);
                   default: return $0.substr(1, $0.length - 2);
               }
           });
       },
        format2Date:function(datetime){
        	if('' == datetime || null == datetime){
        		return "";
        	}
        	var date = datetime.substring(0,10);
        	return date;
        }
        
};

var cacheHandler = {
        //获取localStorage
        getLocalStorage: function(key) {
            if(('localStorage' in window) && window['localStorage'] !== null){
                //将取出的数据转为对象
                return JSON.parse(localStorage.getItem(key));
            }
            return null;
        },
        //获取sessionStorage
        getSessionStorage: function(key) {
            if(('sessionStorage' in window) && window['sessionStorage'] !== null){
                return JSON.parse(sessionStorage.getItem(key));
            }
            return null;
        }
};

//jquery 插件
(function($){
  //对其他js无依赖的注册到jquery中去了
  $.extend({
    //非空判断
    isEmpty: function(value) {
        if (value === null || value == undefined || value === '') {
            return true;
        }
        return false;
    },
    //判断是否obj对象
    isObject : function(value) {
      var type = typeof value;
      return value != null && (type == 'object' || type == 'function');
    },
    //uuid
    uuid : function(){
        return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
            var r = Math.random()*16|0, v = c == 'x' ? r : (r&0x3|0x8);
            return v.toString(16);
        });
    },
    //长期存储localStorage,关闭浏览器还有效
    setLocalStorage: function(key,value) {
        if(('localStorage' in window) && window['localStorage'] !== null){
            localStorage.setItem(key, value);
        }
    },
    //获取localStorage
    getLocalStorage: function(key) {
        if(('localStorage' in window) && window['localStorage'] !== null){
            return localStorage.getItem(key);
        }
        return null;
    },
    //删除localStorage
    removeLocalStorage:function(key){
        localStorage.removeItem(key);
    },
    //清除localStorage
    clearLocalStorage:function(){
        localStorage.clear();
    },
    //临时存储sessionStorage，关闭浏览器失效
    setSessionStorage: function(key,value) {
        if(('sessionStorage' in window) && window['sessionStorage'] !== null){
            sessionStorage.setItem(key, value);
        }
    },
    //获取sessionStorage
    getSessionStorage: function(key) {
        if(('sessionStorage' in window) && window['sessionStorage'] !== null){
            return sessionStorage.getItem(key);
        }
        return null;
    },
    //删除sessionStorage
    removeSessionStorage:function(key){
        sessionStorage.removeItem(key);
    },
    //清除sessionStorage
    clearSessionStorage:function(){
        sessionStorage.clear();
    },
    /**
    * 简单获取cookie
    */
   getCookie :function (name) {
       var arr;
       var reg = new RegExp("(^| )" + name + "=([^;]*)(;|$)");
       if (arr = document.cookie.match(reg)){
       	return unescape(arr[2]);
       }
       else { return null;}
   },
  });

  //ajax统一设置
  $.ajaxSetup({
      timeout : 30000,
      beforeSend: function (request) {
         var url = arguments[1].url
         var accessToken = $.getSessionStorage("accessToken")
         request.setRequestHeader("accessToken", accessToken)
         request.setRequestHeader("lang", getSelectedLanguage().toLowerCase())
		 var nowTime = new Date().getTime()
		 var time = $.getSessionStorage("time")
		 var expiresIn = $.getSessionStorage("expiresIn")
		 var lastOprTime = $.getSessionStorage("lastOprTime")
		 var timeDifference = Number(nowTime) - Number(time)  //超时时间间隔
		 var exceedOprTime = Number(nowTime) - Number(lastOprTime)  //操作时间间隔
		 var exceedTime = Number(expiresIn) * 0.7;
		 
		 if(url.indexOf(BIMSapi.selectFinMesTask) == -1 && url.indexOf( BIMSapi.queryTodoList) == -1 && url.indexOf( BIMSapi.queryRejectList) == -1){
		     LayerHandler.loadMsg(2)
		 }
		 
         if(url.indexOf( BIMSapi.selectFinMesTask) == -1){
		 if(timeDifference >= exceedTime){
			 if(exceedOprTime < 180000 && lastOprTime != null && lastOprTime != ""){ //距上一次的操作时间
				 
			 }else{
				 sessionStorage.setItem("lastOprTime",new Date().getTime())
				 axios({
				 method:'post',
				 // url:BIMSglobalConfig.ccicIndex + "/refreshToken",
				 url:BIMSglobalConfig.serverUrl + "/fin-user/refresh",
				 data: {
					 userSubId: jQuery.parseJSON($.getSessionStorage("userInfo")).userSubId,
					 refreshToken: $.getSessionStorage("refreshToken")
					 }
				 }).then(function(response){
					 var data = response.data
					 if(data.busCode == "SUCCESS"){
						 var resData = data.resData;
						 if(resData != null && resData != ""){
							 sessionStorage.setItem("accessToken", resData.accessToken); 
							 sessionStorage.setItem("refreshToken", resData.refreshToken); 
							 sessionStorage.setItem("userInfo",JSON.stringify(resData.user));
							 sessionStorage.setItem("expiresIn",resData.expiresIn);
							 sessionStorage.setItem("time",new Date().getTime())
							 sessionStorage.setItem("lastOprTime",new Date().getTime())
						 }
					 }else{
						 sessionStorage.clear()
						 LayerHandler.errorMsgCallback(component_utilJsLang.loginTimeout,function(){
							 top.window.location = BIMSglobalConfig.ccicPortalUrl;
						 })
					 }
				 })
			 }
		 }else{
			 
		 }
    }
      },
      complete:function(XMLHttpRequest,textStatus){ 
          LayerHandler.loadRemove();
     },
     error : function(xhr,status,error) {
        layer.alert("Network Exception");
     }
   });
  
  
   initButtonPermisson();//按钮显隐状态调整
}(jQuery));

function getHasPermisson() {
    var userInfoStr = $.getSessionStorage('userInfo');
    var userSubId = JSON.parse(userInfoStr).userSubId;
    var resource = AjaxHandler.ajaxGetSync(BIMSglobalConfig.serverUrl +  BIMSapi.btnPermissionList, {
        "userSubId": userSubId
    });
    if (resource.busCode == "SUCCESS") {
        var resourceList = resource.resData;
        var hasBtnPermisson = {};
        for (var i in resourceList) {
            var key = [resourceList[i].resourceId];
            hasBtnPermisson[key] = '1';
        }
        $.setSessionStorage('hasBtnPermisson', JSON.stringify(hasBtnPermisson));
    } else {
        LayerHandler.errorMsg(resource.busMsg)
    }
}


function initButtonPermisson() {
    var hasBtnPermisson = JSON.parse($.getSessionStorage('hasBtnPermisson'))
    $("[permission-key]").each(function () {
        var permsKey = $(this).attr("permission-key");
        if (hasBtnPermisson && !$.isEmpty(hasBtnPermisson[permsKey])) {
            $(this).removeClass("permission-display"); //显示按钮
        } else { //对列表超链接做特殊处理
            if ($(this).attr("isHyperlinks") == 'true') {
                $(this).show()
                $(this).removeAttr('href')
                $(this).removeAttr('id')
                $(this).attr("disabled", true).css("pointer-events", "none");
            }
        }
//      else{
//          $(this).addClass("dis-none");//隐藏按钮，把隐藏样式直接写在按钮上,这里不控制了
//      }
      });
}


//表单提交用于回去name和value对应的关系值
function form2JsonString(formId) {
    var formdata = $("#" + formId).serializeArray();
    var jsonObj = {};
    $(formdata).each(function () {

        if (jsonObj[this.name]) { //将有相通name的CheckBox合并到一个数组中
            if ($.isArray(jsonObj[this.name])) {
                // jsonObj[this.name].push(this.value);
                jsonObj[this.name].push(TrimSpaceHandler.trimStartAndEndSpace(this.value));
            } else {
                // jsonObj[this.name] = [jsonObj[this.name], this.value];
                jsonObj[this.name] = [jsonObj[this.name], TrimSpaceHandler.trimStartAndEndSpace(this.value)];
            }
        } else {
            // jsonObj[this.name] = this.value;
            jsonObj[this.name] = TrimSpaceHandler.trimStartAndEndSpace(this.value);
        }
    })
    return jsonObj;
};

var FormHandler = {
        
        resetDetailForm :function(formid) {
            $("#"+formid).find("span").each(function(){
                $(this).text("");
            }); 
        },
        formToObject : function(formId) {
            var form = $('#' + formId);
            var obj = new Object();
            $(':input', form).not(':button,.ignore').each(function(i, n) {
                switch (n.type) {
                case "radio":
                    if (n.checked) {
                        obj[n.name] = $(n).val().trim();
                    }
                    break;
                case "checkbox":
                    if (!obj[n.name]) {
                        obj[n.name] = new Array();
                    }
                    if (n.checked) {
                        obj[n.name].push($(n).val().trim());
                    }
                    break;
                default:
                    if($(n).val().trim() != ''){
                        obj[n.name] = $(n).val().trim();
                    }
                    break;
                }
            });
            return obj;
        },
        fillForm : function(obj,formId){
            var form = $('#' + formId);
            form[0].reset();
            $(':input', form).not(':button').each(function(i, n) {
                switch (n.type) {
                case "radio":
                    if (typeof(obj[n.name]) != 'undefined' && obj[n.name] != null 
                            && obj[n.name] != '' && obj[n.name] == $(n).val()) {
                        $(n).attr("checked","checked");
                    }
                    break;
                case "checkbox":
                    if (typeof(obj[n.name]) != 'undefined' && obj[n.name] != null ) {
                        $(obj[n.name]).each(function(j,m){
                            if(m && m == $(n).val()){
                                $(n).attr("checked","checked");
                            }
                        });
                    }
                    break;
                case "select":
                    if (typeof(obj[n.name]) != 'undefined' && obj[n.name] != null ) {
                        $(n).attr("value",obj[n.name]);
                    }
                    break;
                default:
                    if (typeof(obj[n.name]) != 'undefined' && obj[n.name] != null) {
                        $(n).val(obj[n.name]);
                    }
                    break;
                }
            });
            // Define the label attribute name and cvt, the cvt is the variable name of the list
            form.find('span').each(function(i, n) {
                var name = $(n).attr("name");
                var cvt = $(n).attr("cvt");
                if(name){
                    if(cvt){
                        // Escape
                        $(n).text(CodeHanlder.convertValToDesc(evil(cvt),obj[name]));
                        $(n).attr("title",CodeHanlder.convertValToDesc(evil(cvt),obj[name]));
                    }else{
                        $(n).text(obj[name]);
                        $(n).attr("title",obj[name]);
                    }
                }
            });
            form.find('input').each(function(i, n) {
                var name = $(n).attr("name");
                var cvt = $(n).attr("cvt");
                if(name){
                    if(cvt){
                        // Escape
                        $(n).text(CodeHanlder.convertValToDesc(evil(cvt),obj[name]));
//                      $(n).attr("title",CodeHanlder.convertValToDesc(evil(cvt),obj[name]));
                    }else{
                        $(n).text(obj[name]);
//                      $(n).attr("title",obj[name]);
                    }
                }
            });
          form.find('p').each(function(i, n) {
                var name = $(n).attr("name");
                var cvt = $(n).attr("cvt");
                if(name){
                    if(cvt){
                        // Escape
                        $(n).text(CodeHanlder.convertValToDesc(evil(cvt),obj[name]));
                        $(n).attr("title",CodeHanlder.convertValToDesc(evil(cvt),obj[name]));
                    }else{
                        $(n).text(obj[name]);
                        $(n).attr("title",obj[name]);
                    }
                }
            });
        },
        fillFormForBus : function(obj,formId){
            var form = $('#' + formId);
            form[0].reset();
            $(':input', form).not(':button').each(function(i, n) {
                switch (n.type) {
                case "radio":
                    if (typeof(obj[n.name]) != 'undefined' && obj[n.name] != null 
                            && obj[n.name] != '' && obj[n.name] == $(n).val()) {
                        $(n).attr("checked","checked");
                    }
                    break;
                case "checkbox":
                    if (typeof(obj[n.name]) != 'undefined' && obj[n.name] != null ) {
                        $(obj[n.name]).each(function(j,m){
                            if(m && m == $(n).val()){
                                $(n).attr("checked","checked");
                            }
                        });
                    }
                    break;
                case "select":
                    if (typeof(obj[n.name]) != 'undefined' && obj[n.name] != null ) {
                        $(n).attr("value",obj[n.name]);
                    }
                    break;
                default:
                    if (typeof(obj[n.name]) != 'undefined' && obj[n.name] != null) {
                        $(n).val(obj[n.name]);
                    }
                    break;
                }
            });
            // Define the label attribute name and cvt, the cvt is the variable name of the list
            form.find('span').each(function(i, n) {
                var name = $(n).attr("name");
                var cvt = $(n).attr("cvt");
                if(name){
                    if(cvt){
                        // Escape
                        $(n).text(CodeHanlder.convertValToDescForBus(evil(cvt),obj[name]));
                    }else{
                        $(n).text(obj[name]);
                    }
                }
            });
            form.find('input').each(function(i, n) {
                var name = $(n).attr("name");
                var cvt = $(n).attr("cvt");
                if(name){
                    if(cvt){
                        // Escape
                        $(n).text(CodeHanlder.convertValToDescForBus(evil(cvt),obj[name]));
                    }else{
                        $(n).text(obj[name]);
                    }
                }
            });
          form.find('p').each(function(i, n) {
                var name = $(n).attr("name");
                var cvt = $(n).attr("cvt");
                if(name){
                    if(cvt){
                        // Escape
                        $(n).text(CodeHanlder.convertValToDescForBus(evil(cvt),obj[name]));
                    }else{
                        $(n).text(obj[name]);
                    }
                }
            });
        },
        fillDynaFormForBus : function(obj,formId){
            var form = $('#' + formId);
            form[0].reset();
            $(':input', form).not(':button').each(function(i, n) {
                switch (n.type) {
                case "radio":
                    if (typeof(obj[n.name]) != 'undefined' && obj[n.name] != null 
                            && obj[n.name] != '' && obj[n.name] == $(n).val()) {
                        $(n).attr("checked","checked");
                    }
                    break;
                case "checkbox":
                    if (typeof (obj[n.name]) != 'undefined' && obj[n.name] != null) {
                        if ($.isArray(obj[n.name])) {
                            $(obj[n.name]).each(function (j, m) {
                                if (m && m == $(n).val()) {
                                    $(n).attr("checked", "checked");
                                }
                            });
                        } else {
                            if (obj[n.name] == $(n).val()) {
                                $(n).attr("checked", "checked");
                            }
                        }
                    }
                    break;
                case "select":
                    if (typeof(obj[n.name]) != 'undefined' && obj[n.name] != null ) {
                        $(n).attr("value",obj[n.name]);
                    }
                    break;
                default:
                    if (typeof(obj[n.name]) != 'undefined' && obj[n.name] != null) {
                        $(n).val(obj[n.name]);
                    }
                    break;
                }
            });
            form.find('[tag-type="dyna-form-btselect"]').each(function (i, n) {
                var name = $(n).attr("name");
                var id = $(n).attr("id");
                if (name && id) {
                    $("#" + formId + " #" + id).val(obj[name]);
                    $("#" + formId + " #" + id).selectpicker('refresh');
                }
            });
            form.find('[tag-type="dyna-form-date"]').each(function (i, n) {
                var id = $(n).attr("id");
                if (id) {
                    $("#" + formId + " #" + id).datepicker('clearDates')
                    $("#" + formId + " #" + id).datepicker('setDate', new Date(obj[id]))
                }
            });
            // Define the label attribute name and cvt, the cvt is the variable name of the list
            form.find('span').each(function(i, n) {
                var name = $(n).attr("name");
                var cvt = $(n).attr("cvt");
                if(name){
                    if(cvt){
                        // Escape
                        $(n).text(CodeHanlder.convertValToDescForBus(evil(cvt),obj[name]));
                    }else{
                        $(n).text(obj[name]);
                    }
                }
            });
            form.find('input').each(function(i, n) {
                var name = $(n).attr("name");
                var cvt = $(n).attr("cvt");
                if(name){
                    if(cvt){
                        // Escape
                        $(n).text(CodeHanlder.convertValToDescForBus(evil(cvt),obj[name]));
                    }else{
                        $(n).text(obj[name]);
                    }
                }
            });
          form.find('p').each(function(i, n) {
                var name = $(n).attr("name");
                var cvt = $(n).attr("cvt");
                if(name){
                    if(cvt){
                        // Escape
                        $(n).text(CodeHanlder.convertValToDescForBus(evil(cvt),obj[name]));
                    }else{
                        $(n).text(obj[name]);
                    }
                }
            });
        },
        fillFormForSetBus : function(obj,formId){
            var form = $('#' + formId);
            form[0].reset();
            $(':input', form).not(':button').each(function(i, n) {
                switch (n.localName) {
                case "radio":
                    if (typeof(obj[n.name]) != 'undefined' && obj[n.name] != null 
                            && obj[n.name] != '' && obj[n.name] == $(n).val()) {
                        $(n).attr("checked","checked");
                    }
                    break;
                case "checkbox":
                    if (typeof(obj[n.name]) != 'undefined' && obj[n.name] != null ) {
                        $(obj[n.name]).each(function(j,m){
                            if(m && m == $(n).val()){
                                $(n).attr("checked","checked");
                            }
                        });
                    }
                    break;
                case "select":
                    if (typeof(obj[n.name]) != 'undefined' && obj[n.name] != null ) {
                    	for(var i=0;i<n.length;i++){
                    		if(n[i].value==obj[n.name]){
                    			  $(n[i]).attr("selected","selected");
                    		}
                    	}
                    }
                    break;
                case "textarea":
                	if (typeof(obj[n.name]) != 'undefined' && obj[n.name] != null ) {
                        $(n).text(obj[n.name]);
                    }
                    break;
                default:
                    if (typeof(obj[n.name]) != 'undefined' && obj[n.name] != null) {
                        $(n).attr("value",obj[n.name]);
                    }
                    break;
                }
            });
            form.find('[tag-type="dyna-form-btselect"]').each(function (i, n) {
                var name = $(n).attr("name");
                var id = $(n).attr("id");
                if (name && id) {
                    $("#" + formId + " #" + id).val(obj[name]);
                    $("#" + formId + " #" + id).selectpicker('refresh');
                }
            });
            form.find('[tag-type="dyna-form-date"]').each(function (i, n) {
                var id = $(n).attr("id");
                if (id) {
                	$(n).attr("value",obj[id]);
					$(n).attr("style","")
                }
            });
            // Define the label attribute name and cvt, the cvt is the variable name of the list
            form.find('span').each(function(i, n) {
                var name = $(n).attr("name");
                var cvt = $(n).attr("cvt");
                if(name){
                    if(cvt){
                        // Escape
                        $(n).text(CodeHanlder.fillFormForSetBus(evil(cvt),obj[name]));
                    }else{
                        $(n).text(obj[name]);
                    }
                }
            });
            form.find('input').each(function(i, n) {
                var name = $(n).attr("name");
                var cvt = $(n).attr("cvt");
                if(name){
                    if(cvt){
                        // Escape
                        $(n).text(CodeHanlder.fillFormForSetBus(evil(cvt),obj[name]));
                    }else{
                        $(n).text(obj[name]);
                    }
                }
            });
          form.find('p').each(function(i, n) {
                var name = $(n).attr("name");
                var cvt = $(n).attr("cvt");
                if(name){
                    if(cvt){
                        // Escape
                        $(n).text(CodeHanlder.fillFormForSetBus(evil(cvt),obj[name]));
                    }else{
                        $(n).text(obj[name]);
                    }
                }
            });
        },
};

var CodeHanlder = {
        /**
         * Fill in the drop-down list
         * dataList : The json format of data
         * excVal: The exclusion value of dataId
         * elementId: The element id
         * dataId: The id of data,drop-down list value.
         * dataDesc: The desc of data,drop-down list display text.
         */
		 fillSelectOptionCustom: function(dataList, excVal, elementId, dataId, dataDesc,dataDefault){
		 		$("#"+elementId).empty();
	            if(typeof(dataList) != "undefined" && dataList != ''){
	                var opt = "";
	                if(!$.isEmpty(dataDefault)){
	                	opt+='<option value="">'+dataDefault+'</option>';
	                }
	                $.each(dataList, function(i,n){
	                     if( n[dataId] != excVal){
	                             opt = opt + '<option value="'+ n[dataId] +'" >'+n[dataDesc]+'</option>'
	                     }
	                });
	                $("#"+elementId).append(opt);
	            }
	        },
        /**
         * codes : The json string of code
         * excVal: The exclusion value of codeNo
         * id: The element id
         */
        fillSelectOption: function(codes, excVal, id){
        	$("#"+id).empty();
            if(typeof(codes) != "undefined" && codes != ''){
                var opt = '<option value="" selected="selected">All</option>';
                $.each(codes, function(i,n){
                     if( n.codeNo != excVal){
                         opt = opt + '<option value="'+ n.codeNo +'">'+n.codeDesc+'</option>'
                     }
                });
                $("#"+id).append(opt);
            }
        },
        /**
         * codes : The json string of code
         * excVal: The exclusion value of codeNo
         * id: The element id
         */
        fillSelectOptionWithBlank: function(codes, excVal, id){
        	$("#"+id).empty();
            if(typeof(codes) != "undefined" && codes != ''){
                var opt = '<option value="" selected="selected"></option>';
                $.each(codes, function(i,n){
                     if( n.codeNo != excVal){
                         opt = opt + '<option value="'+ n.codeNo +'">'+n.codeDesc+'</option>'
                     }
                });
                $("#"+id).append(opt);
            }
        },
        /**
         * Fill in the drop-down list(把数据填充到下拉列表)
         * codes : The json string of code
         * excVal: The exclusion value of codeNo
         * id: The element id
         */
        fillSelectOptionWithData: function(codes, excVal, id){
        	$("#"+id).empty();
            if(typeof(codes) != "undefined" && codes != ''){
                var opt = "";
                $.each(codes, function(i,n){
                     if( n.codeNo != excVal){
                         if (opt == ""){
                             opt = '<option value="'+ n.codeNo +'" selected="selected">'+n.codeDesc+'</option>'
                         }else{
                             opt = opt + '<option value="'+ n.codeNo +'" >'+n.codeDesc+'</option>'
                         }
                          
                     }
                });
                $("#"+id).append(opt);
            }
        },
        /**
         * Fill in the drop-down list(把数据填充到下拉列表)
         * codes : The json string of code
         * excVal: The exclusion value of codeNo
         * id: The element id
         */
        fillSelectOptionWithDataNotBlank: function(codes, excVal, id){
        	$("#"+id).empty();
            if(typeof(codes) != "undefined" && codes != ''){
                var opt = '' ;
                $.each(codes, function(i,n){
                     if( n.codeNo != excVal){
                          opt = opt + '<option value="'+ n.codeNo +'">'+n.codeDesc+'</option>'
                     }
                });
                $("#"+id).append(opt);
            }
        },
         /**
          * 
         * Fill in the drop-down list(把数据填充到下拉列表)
         * codes : 参数类型
         * excVal: 不需要填充的值
         * id: 填充下拉框ID
         */
        fillTypeSelectOptionWithDataNotBlank: function(codeType, excVal, id){
        	var busSysCodeContent = cacheHandler.getSessionStorage('busSysCodeContent');
    		var codes = busSysCodeContent[codeType];
    		$("#"+id).empty();
            if(typeof(codes) != "undefined" && codes != ''){
                var opt = '' ;
                $.each(codes, function(i,n){
                     if( n.codeNo != excVal){
                          opt = opt + '<option value="'+ n.codeNo +'">'+n.codeDesc+'</option>'
                     }
                });
                $("#"+id).append(opt);
            }
        },
        /**
         * codes : The json string of code
         * val: value
         */
        convertValToDesc: function(codes, val){
            var d = '';
            if(typeof(codes) != "undefined" && codes != '' 
                    && typeof(val) != "undefined"){
                $.each(codes, function(i,n){
                     if (n.codeNo == val) {
                         d = n.codeDesc;
                     }
                });
            }
            return d;
        },
        convertValToDescForBus: function(codes, val){
            var d = null;
            if(typeof(codes) != "undefined" && codes != '' 
                    && typeof(val) != "undefined"){
                $.each(codes, function(i,n){
                     if (n.codeNo == val) {
                         d = n.codeDesc;
                     }
                });
            }
            return d;
        },
         /**
         *  CODE码 转义
         * @param {Object} codeType code类型 
         * @param {Object} val  
         */
        convertTypeToDescForBus: function(codeType, val){
        	var busSysCodeContent = cacheHandler.getSessionStorage('busSysCodeContent');
    		var codes = busSysCodeContent[codeType];
            var d = null;
            if(typeof(codes) != "undefined" && codes != '' 
                    && typeof(val) != "undefined"){
                $.each(codes, function(i,n){
                     if (n.codeNo == val) {
                         d = n.codeDesc;
                     }
                });
            }
            return d;
        },
        /**
         * codes : The json string of code
         * excVal: The exclusion value of codeNo
         * id: The element id
         * value : The value is option by default
         */
        fillSelectOptionAndSetValue: function(codes, excVal, id,value){
        	$("#"+id).empty();
            if(typeof(codes) != "undefined" && codes != ''){
                var opt = '<option value="" selected="selected">All</option>';
                $.each(codes, function(i,n){
                     if( n.codeNo != excVal){
                         opt = opt + '<option value="'+ n.codeNo +'">'+n.codeDesc+'</option>'
                     }
                });
                $("#"+id).append(opt);
            }
                var s = document.getElementById(id);  
                var ops = s.options;  
                for(var i=0;i<ops.length; i++){  
                    var tempValue = ops[i].value;  
                    if(tempValue == value)  
                    {  
                        ops[i].selected = true;  
                    }  
                }  
        },/**
         *  CODE码 转义
         * @param {Object} codeType code类型 
         * @param {Object} val  
         */
        convertTypeToDescForBusName: function(codes, val,id,name){
            var d = null;
            if(typeof(codes) != "undefined" && codes != '' 
                    && typeof(val) != "undefined"){
                $.each(codes, function(i,n){
                     if (n[id] == val) {
                         d = n[name];
                     }
                });
            }
            return d;
        },
        /**
         * Fill in the drop-down list
         * dataList : The json format of data
         * excVal: The exclusion value of dataId
         * elementId: The element id
         * dataId: The id of data,drop-down list value.
         * dataDesc: The desc of data,drop-down list display text.
         */
		 fillSelectOptionCustomJoint: function(dataList, excVal, elementId, dataId, dataDesc,dataJoint,dataDefault){
		 		$("#"+elementId).empty();
	            if(typeof(dataList) != "undefined" && dataList != ''){
	                var opt = "";
	                if(!$.isEmpty(dataDefault)){
	                	opt+='<option value="">'+dataDefault+'</option>';
	                }
	                $.each(dataList, function(i,n){
	                     if( n[dataId] != excVal){
	                             opt = opt + '<option title="'+n[dataDesc]+'"  value="'+ n[dataId] +'" >'+n[dataDesc]+'-'+n[dataJoint]+'</option>'
	                     }
	                });
	                $("#"+elementId).append(opt);
	            }
	        },
};
function evil(fn) {
    var Fn = Function; //一个变量指向Function，防止有些前端编译工具报错
    return new Fn('return ' + fn)();
};

var JqueryValidatorHandler = {
        /**
         * Remove .has-success, .has-error and <span>
         * id is this form id
         */
        removeClass : function(id){
            $("#"+id).find("div").removeClass("has-success").removeClass("has-error");
            $("#"+id).find("span[id$='-error']").remove();
        }
};



function conversionZero(value) {
	if(value == null || value == "" || value == undefined) {
		return 0;
	} else {
		return value;
	}
}
/**
 * 加法运算，避免数据相加小数点后产生多位数和计算精度损失。
 *
 * @param num1加数1 | num2加数2
 */
function numAdd(num1, num2) {
	num1=conversionZero(num1);
	num2=conversionZero(num2);
	var baseNum, baseNum1, baseNum2;
	try {
		baseNum1 = num1.toString().split(".")[1].length;
	} catch(e) {
		baseNum1 = 0;
	}
	try {
		baseNum2 = num2.toString().split(".")[1].length;
	} catch(e) {
		baseNum2 = 0;
	}
	baseNum = Math.pow(10, Math.max(baseNum1, baseNum2));
	return(num1 * baseNum + num2 * baseNum) / baseNum;
};
/**
 *减法运算，避免数据相减小数点后产生多位数和计算精度损失。
 *
 * @param num1被减数  |  num2减数
 */
function numSub(num1, num2) {
	num1=conversionZero(num1);
	num2=conversionZero(num2);
	var baseNum, baseNum1, baseNum2;
	var precision; // 精度
	try {
		baseNum1 = num1.toString().split(".")[1].length;
	} catch(e) {
		baseNum1 = 0;
	}
	try {
		baseNum2 = num2.toString().split(".")[1].length;
	} catch(e) {
		baseNum2 = 0;
	}
	baseNum = Math.pow(10, Math.max(baseNum1, baseNum2));
	precision = (baseNum1 >= baseNum2) ? baseNum1 : baseNum2;
	return((num1 * baseNum - num2 * baseNum) / baseNum).toFixed(precision);
};
/**
 * 乘法运算，避免数据相乘小数点后产生多位数和计算精度损失。
 *
 * @param num1被乘数 | num2乘数
 */
function numMulti(num1, num2) {
	num1=conversionZero(num1);
	num2=conversionZero(num2);
	var baseNum = 0;
	try {
		baseNum += num1.toString().split(".")[1].length;
	} catch(e) {}
	try {
		baseNum += num2.toString().split(".")[1].length;
	} catch(e) {}
	return Number(num1.toString().replace(".", "")) * Number(num2.toString().replace(".", "")) / Math.pow(10, baseNum);
};
/**
 * 除法运算，避免数据相除小数点后产生多位数和计算精度损失。
 *
 * @param num1被除数 | num2除数
 */
function numDiv(num1, num2) {
	num1=conversionZero(num1);
	num2=conversionZero(num2);
	var baseNum1 = 0,
		baseNum2 = 0;
	var baseNum3, baseNum4;
	try {
		baseNum1 = num1.toString().split(".")[1].length;
	} catch(e) {
		baseNum1 = 0;
	}
	try {
		baseNum2 = num2.toString().split(".")[1].length;
	} catch(e) {
		baseNum2 = 0;
	}
	with(Math) {
		baseNum3 = Number(num1.toString().replace(".", ""));
		baseNum4 = Number(num2.toString().replace(".", ""));
		return(baseNum3 / baseNum4) * pow(10, baseNum2 - baseNum1);
	}
};

function number_format(val, type, dec_point, thousands_sep) {
	if(val === '' || val === 0) return '0.00'
	val = Number(val)
	if(isNaN(val)) return ''
	return val.toFixed(type).replace(/(\d)(?=(\d{3})+\.)/g, '$1,')
};

function format_money(val, type) {
	if(val === '' || val === 0) return '0.00'
	val = Number(val)
	if(isNaN(val)) return ''
	return val.toFixed(type).replace(/(\d)(?=(\d{3})+\.)/g, '$1,')
}

//小数点保留两位,第三位四舍五入
function changeTwoDecimal(x){
	var f_x = parseFloat(x);
	if (isNaN(f_x))
	{
	return false;
	}
	f_x = Math.round(f_x *100)/100;
	
	return f_x;
}

//计算税后金额  amount 金额   rate 税率  0.00 格式
function afterTaxAmount(amount,rate){
 return numMulti( changeTwoDecimal(numMulti(amount, numDiv(1,numAdd(1,rate)))),100);
}


//截取传入字符串,超过一定长度后显示...
function subStrPoint(str){
	if(typeof(str) != "undefined" && str != null){ //判断传入字符串是否为undefined
		if(str.length >15){
			return str.substring(0,15)+"...";
		}else{
			return str;
		}
	}else{
		return " ";
	}
}

//filter
function initTableHeight(){
		//拿到父窗口的centerTabs高度(这是iframe子页面拿到父窗口元素的方法，需要根据自己项目所使用的框架自行修改元素的id)
		var panelH = $("#frame", parent.document).height();
		//拿到顶部工具栏高度
		var toolBarH = $(".headBtnDiv").height();
		//计算表格container该设置的高度
		var height = panelH - toolBarH -135;
		var container = $(".fixed-table-container").css({"height": height});
		return height+60;
}
var regular = {
	money: {
		replaceValue: function(obj) {
			var value = obj.value;
			value = value.replace(/[^\d.]/g, ""); //清除"数字"和"."以外的字符
			value = value.replace(/^\./g, ""); //验证第一个字符是数字
			value = value.replace(/\.{2,}/g, ""); //只保留第一个, 清除多余的
			value = value.replace(".", "$#$").replace(/\./g, "").replace("$#$", ".");
			value = value.replace(/^(\-)*(\d+)\.(\d\d).*$/, '$1$2.$3'); //只能输入两个小数
			var valueString=value.toString();
			if(valueString.indexOf('.')==-1) { 
				value = value.replace(/\b(0+)/gi, '');
			}
			value = $.isEmpty(value) ? 0 : value;
			return value;
		}
	},
	discount: {
		replaceValue: function(obj) {
			var value = obj.value;
			value = value.replace(/[^\d.]/g, ""); //清除"数字"和"."以外的字符
			value = value.replace(/^\./g, ""); //验证第一个字符是数字
			value = value.replace(/\.{2,}/g, ""); //只保留第一个, 清除多余的
			value = value.replace(".", "$#$").replace(/\./g, "").replace("$#$", ".");
			value = value.replace(/^(\-)*(\d+)\.(\d\d).*$/, '$1$2.$3'); //只能输入两个小数
			var valueString=value.toString();
			if(valueString.indexOf('.')==-1) {
				value = value.replace(/\b(0+)/gi, '');
			}
			value = $.isEmpty(value) ? 0 : value;
			return value;
		}
	},
	amount:{
		replaceValue:function(obj){
			var value = obj.value;
			value = value.replace(/[^\d]/g, ""); //清除"数字"和"."以外的字符
			value = value.replace(/\b(0+)/gi, '');
			value = $.isEmpty(value) ? 0 : value;
			return value;
		}
	},
	reat:{
		replaceValue:function(obj){
			var value = obj.value;
			value = value.replace(/[^\d]/g, ""); //清除"数字"和"."以外的字符
			value = value.replace(/\b(0+)/gi, '');
			value = $.isEmpty(value) ? 0 : value;
			if(value>100){
				value=100;
			}
			return value;
		}
	},
	searchMoney: {
        replaceValue: function(obj) {
            var value = obj.value;
            value = value.replace(/[^\d.]/g, ""); //清除"数字"和"."以外的字符
            value = value.replace(/^\./g, ""); //验证第一个字符是数字
            value = value.replace(/\.{2,}/g, ""); //只保留第一个, 清除多余的
            value = value.replace(".", "$#$").replace(/\./g, "").replace("$#$", ".");
            value = value.replace(/^(\-)*(\d+)\.(\d\d).*$/, '$1$2.$3'); //只能输入两个小数
            var valueString=value.toString();
            if(value != 0){
                if(valueString.indexOf('.') == -1) {
                    value = value.replace(/\b(0+)/gi, '');
                }
            }
            value = $.isEmpty(value) ? null : value;
            return value;
        }
    },

};

function fileDownloadMethod(url, fileName) {
    var xhr = new XMLHttpRequest();
    xhr.open('GET', url, true); // 设置请求方式POST方式
    xhr.responseType = "blob"; // 返回类型blob
    //xhr.setRequestHeader("accessToken",accessToken);
    xhr.setRequestHeader("Content-Type", "application/octet-stream"); //设置请求内容类型
    // 请求回调函数，在请求后台完成，后台返回数据后执行此方法onload
    xhr.onload = function () {
        var content = this.response; //获取后台响应内容
        //解析后台返回的文件内容，这里主要是处理Blob类型
        var excelBlob = new Blob([content]);
        //window.navigator.msSaveOrOpenBlob(excelBlob, fileName);
        //浏览器兼容处理
        if (isIE() || isEdge()) {
            window.navigator.msSaveOrOpenBlob(excelBlob, fileName);
        } else {
            window.location.href = url;
        }
    };
    // 发送ajax请求
    xhr.send();
}

//判断是否IE浏览器
function isIE() {
    if (!!window.ActiveXObject || "ActiveXObject" in window) {
        return true;
    } else {
        return false;
    }
}
function isEdge() {
    if (navigator.userAgent.indexOf("Edge") > -1) {
        return true;
    } else {
        return false;
    }
}
function Dailyassignment() {
	var date = new Date();
	var year = date.getFullYear();
	var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
	var end_day = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();

	var endTime = year + "-" + month + "-" + end_day;

	// JS取得当前日期的前一天
	var startTime = new Date(date.getTime() - 24 * 60 * 60 * 1000).format("yyyy-MM-dd");

	$("#startDate").val(startTime);
	$("#endDate").val(endTime);
	$("#startDateHide").val(startTime.replace(new RegExp("-", "gm"), ""));
	$("#endDateHide").val(endTime.replace(new RegExp("-", "gm"), ""));
	$("#startMatchDate").val(endTime);
	$("#endMatchDate").val(endTime);
	$("#startMatchDateHide").val(endTime.replace(new RegExp("-", "gm"), ""));
	$("#endMatchDateHide").val(endTime.replace(new RegExp("-", "gm"), ""));
	$("#startInvoiceDate").val(endTime);
	$("#endInvoiceDate").val(endTime);
	$("#startInvoiceDateHide").val(endTime.replace(new RegExp("-", "gm"), ""));
	$("#endInvoiceDateHide").val(endTime.replace(new RegExp("-", "gm"), ""));
}

// 日期格式化
Date.prototype.format = function(format) {　　
	var args = {　　　　
		"M+": this.getMonth() + 1,
		　　　　"d+": this.getDate(),
		　　　　"h+": this.getHours(),
		　　　　"m+": this.getMinutes(),
		　　　　"s+": this.getSeconds(),
		　　　　"q+": Math.floor((this.getMonth() + 3) / 3), //quarter
		　　　　"S": this.getMilliseconds()　　
	};　　
	if(/(y+)/.test(format)) format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));　　
	for(var i in args) {　　　　
		var n = args[i];　　　　
		if(new RegExp("(" + i + ")").test(format)) format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? n : ("00" + n).substr(("" + n).length));　　
	}　　
	return format;
};

function everyMonth(){
	var date = new Date();
	var year = date.getFullYear();
	var month = date.getMonth() + 1;
//	if(month == 1) {
//		year = date.getFullYear() - 1;
//		month = 12;
//	} else {
//		month = month - 1;
//	}
	if(month < 10) {
		month = "0" + month;
	}

	var startTime = year + "-" + month;
	$("#startDate").val(startTime);
	$("#startDateHide").val(startTime.replace(new RegExp("-", "gm"), ""));
	$("#endDate").val(startTime);
	$("#endDateHide").val(startTime.replace(new RegExp("-", "gm"), ""));
	$("#onstartDate").val(startTime);
	$("#onstartDateHide").val(startTime.replace(new RegExp("-", "gm"), ""));
	$("#onendDate").val(startTime);
	$("#onendDateHide").val(startTime.replace(new RegExp("-", "gm"), ""));
}
//每日计算
function everyDay() {
	var startDate = $("#startDateHide").val();
	var endDate = $("#endDateHide").val();
	if(startDate != '' && startDate != null && (endDate == null || endDate == '')) {
		LayerHandler.promptMsg(component_utilJsLang.pleaseSlectEndTime);
		return false;
	}
	if((startDate == null || startDate == '') && endDate != '' && endDate != null) {
		LayerHandler.promptMsg(component_utilJsLang.pleaseSlectStartTime);
		return false;
	}
	var startDateHide=startDate.replace(new RegExp("-", "gm"), "");
	var endDateHide=endDate.replace(new RegExp("-", "gm"), "");
	if(startDateHide>endDateHide){
		LayerHandler.promptMsg(component_utilJsLang.selectTimeValidate);
		return false;
	}
	
	$("#startDateHide").val(startDateHide);
	$("#endDateHide").val(endDateHide);
	return true;
}
function backHisPageMethod() {
    var flag = UrlHandler.getUrlParam("backHisFlag"); //验证跳转地址
    if ($.isEmpty(flag)) {
        window.history.back(-1);
    } else {
        $(window.parent.document).find("#frame").attr("src", "workPlat.html");
    }
}

//报表查询公司部门动态创建下拉框
function departmentUserdata() {
	
	companyNameList();
	productNameList();

}
function productNameList(){
	$('#productNameList').html("");
	var userInfoStr = $.getSessionStorage('userInfo');
	var	userInfo = JSON.parse(userInfoStr);
	var userSubId=userInfo.userSubId;
//	var userSubId="925616";

	var reqUrl = BIMSglobalConfig.serverUrl +  BIMSapi.productSubUser + "?userSubId=" + userSubId + "";
	var param = {};
	var productIdlist = [];
	var result = AjaxHandler.ajaxGetSync(reqUrl, param);
	if("SUCCESS" == result.busCode) {
		var res = result.resData;	
		if(res.length > 0){
		
			$("#productNameList").append('<option  class="all" value="all">'+component_utilJsLang.selectAllProductLine+'</option>');
		}
	
		for(var i = 0; i < res.length; i++) {

			$("#productNameList").append("<option class='one'  value=" + res[i].productId + ">" + res[i].productName + "</option>");
			productIdlist.push(res[i].productId);
		
		}
			$("#productName").val(productIdlist);
			$('#productNameList').selectpicker('refresh');

	} else {
		// 异常错误处理
		LayerHandler.errorMsg(result.busMsg);
	}
	
	
	$("#productNameList").change(function() {
		$('#productNameList option').attr("disabled", false);
		var busiOrgNameList = $("#productNameList").val();
		var productIdList = $("#productName").val();
		if(Array.prototype.isPrototypeOf(busiOrgNameList) && busiOrgNameList.length === 0){
			$('#productNameList option.all').attr("disabled", false);
				$('#productNameList option').attr("disabled", false);
				$('#productNameList').selectpicker('refresh');
				$("#productIdList").val("");
		}
		for(var i = 0; i < busiOrgNameList.length; i++) {
			if(busiOrgNameList[0] == "all") {
				$('#productNameList option.one').attr("disabled", true);
				$('#productNameList').selectpicker('refresh');
				$("#productIdList").val(productIdList);
			}else{
				$('#productNameList option.all').attr("disabled", true);
				$('#productNameList option.one').attr("disabled", false);
				$('#productNameList').selectpicker('refresh');
				$("#productIdList").val(busiOrgNameList);
			}
		}

	})
}
function companyNameList(){
	var userInfoStr = $.getSessionStorage('userInfo');
	var	userInfo = JSON.parse(userInfoStr);
	var companyId=userInfo.companyId;
	var companyFullname=userInfo.companyFullname;
	var orgId=userInfo.orgId;
	var orgFullName=userInfo.orgFullName;
	
//	var companyId="2003022";
//	var companyFullname="中国检验认证集团广东有限公司";
//	var orgId="2003022027005";
//	var orgFullName="财务部(广东公司)";
	
	$('#busiOrgName').attr("disabled", true);
	$('#companyName').html("");
	var resourceId = window.parent.attrID();
	var reqUrl = BIMSglobalConfig.serverUrl +  BIMSapi.departmentUserdata + "?resourceId=" + resourceId + "";
	var param = {};
	var result = AjaxHandler.ajaxGetSync(reqUrl, param);
	$("#companyFlag").after("<input type='hidden' name='resourceId' id='resourceId' value="+ resourceId+" />");
	if("SUCCESS" == result.busCode) {
		var res = result.resData;
		var keymap = [];
		var orgIdlist = [];
		if(res.allFlag == false) {
			$("#companyFlag").val(0);
		} else {
			$("#companyFlag").val(1);
		}
		if(res.selfFlag == false) {
			$("#defineFlag").val(0);
		} else {
			$("#defineFlag").val(1);
		}
		for(var key in res.departmentMap) {
			keymap.push(key)
		}
		if(res.companyList.length > 0){
		
			$("#companyName").append('<option  class="all" value="all">'+component_utilJsLang.selectAllCompany+'</option>');
		}
		for(var i = 0; i < res.companyList.length; i++) {

			$("#companyName").append("<option id=" + res.companyList[i].companyId + "  class='one " + res.companyList[i].companyId + "' value=" + res.companyList[i].companyId + ">" + res.companyList[i].companyFullName + "</option>");
		}
		$("#companyName").selectpicker('val', companyId);
		$('#companyName').selectpicker('refresh');
		var companyNameList = $("#companyName").val();
		if(companyNameList.length!=""){
			$('#companyName option.all').attr("disabled", true);
			$('#busiOrgName').attr("disabled", false);
			busiOrgNamelist(companyNameList);
			$('#busiOrgName option.all').attr("disabled", true);
			$("#busiOrgName").selectpicker('val', orgId);
			var busiOrgIdList=$("#busiOrgIdList").val();
			if(busiOrgIdList!=""){
				$('#busiOrgName option.all').attr("disabled", true);
			}
		}
		

	} else {
		// 异常错误处理
		LayerHandler.errorMsg(result.busMsg);
	}
	querysos();
	function busiOrgNamelist(orgIdlist) {
		$('#busiOrgName').html("");
		$("#busiOrgName").append('<option class="all" value="1">'+component_utilJsLang.selectAllDept+'</option>');
		var resourceId = window.parent.attrID();
		var reqUrl = BIMSglobalConfig.serverUrl +  BIMSapi.departmentUserdata + "?resourceId=" + resourceId + "";
		var param = {};
		var result = AjaxHandler.ajaxGetSync(reqUrl, param);
		if("SUCCESS" == result.busCode) {
			var res = result.resData;
			var keymap = [];
			var orgIdList = [];
			for(var i = 0; i < res.companyList.length; i++) {
				$("#busiOrgName").append("<optgroup class=" + res.companyList[i].companyId + " label=" + res.companyList[i].companyFullName + "></optgroup>");
			}
			for(var j = 0; j < orgIdlist.length; j++) {
				var keys = orgIdlist[j];
				var list = res.departmentMap[keys];
				if(!list) {
					var list = "";
				} else {
					for(var n = 0; n < list.length; n++) {
						$("#busiOrgName optgroup." + keys).append("<option class=" + keys + "  value=" + list[n].orgId + ">" + list[n].orgName + "</option>");
						orgIdList.push(list[n].orgId);
	
					}
					
					$("#busiOrgNamelist").val(orgIdList);
					
					$('#busiOrgName').selectpicker('refresh');
				}
	
			}
	
		} else {
			// 异常错误处理
			LayerHandler.errorMsg(result.busMsg);
		}
	
	}
	
	$("#companyName").change(function() {
		
		$('#busiOrgName').attr("disabled", true);
		$('#busiOrgName').html("");
		$('#busiOrgName').selectpicker('refresh');
		var companyNameList = $("#companyName").val();
		if(Array.prototype.isPrototypeOf(companyNameList) && companyNameList.length === 0){
				$('#companyName option.one').attr("disabled", false);
				$('#companyName option.all').attr("disabled", false);
				$('#busiOrgName').attr("disabled", true);
				$('#companyName').selectpicker('refresh');
		}
		for(var i = 0; i < companyNameList.length; i++) {
			if(companyNameList[0] == "all") {
				$('#companyName option.one').attr("disabled", true);
				$('#busiOrgName').attr("disabled", true);
				$('#busiOrgName').html("");
				$("#busiOrgIdList").val("");
				$('#busiOrgName').selectpicker('refresh');
				$('#companyName').selectpicker('refresh');
			}else {
				$('#companyName option.all').attr("disabled", true);
				$('#companyName option.one').attr("disabled", false);
				$('#companyName').selectpicker('refresh');
				$('#busiOrgName').attr("disabled", false);
				busiOrgNamelist(companyNameList);
			}
		}

	})
	
	$("#busiOrgName").change(function() {
		$('#busiOrgName optgroup').attr("disabled", false);
		var busiOrgNameList = $("#busiOrgName").val();
		if(Array.prototype.isPrototypeOf(busiOrgNameList) && busiOrgNameList.length === 0){
			$('#busiOrgName option.all').attr("disabled", false);
				$('#busiOrgName optgroup').attr("disabled", false);
				$('#busiOrgName').selectpicker('refresh');
		}
		for(var i = 0; i < busiOrgNameList.length; i++) {
			if(busiOrgNameList[0] == "1") {
				$('#busiOrgName optgroup').attr("disabled", true);
				$('#busiOrgName').selectpicker('refresh');
			}else{
				$('#busiOrgName option.all').attr("disabled", true);
				$('#busiOrgName optgroup').attr("disabled", false);
				$('#busiOrgName').selectpicker('refresh');
			}
		}

	})
}

function querysos(){
	$("#exportBtn").removeClass("Ash_disposal");
	$("#exportBtn").attr("disabled", false);
	var companyNameList = $("#companyName").val();
	var busiOrgList = $("#busiOrgName").val();
	for(var i = 0; i < busiOrgList.length; i++) {
		if(busiOrgList[0] == 1) {
			var busiOrgNameList = $("#busiOrgNamelist").val();
		} else {
			var busiOrgNameList = $("#busiOrgName").val();
		}
	}
	if(Array.prototype.isPrototypeOf(companyNameList) && companyNameList.length === 0){
		$("#allFlag").val(0)
		$("#busiOrgIdList").val("");
	}
	for(var i = 0; i < companyNameList.length; i++) {
		if(companyNameList[0] == "all") {
			$("#allFlag").val(1)
			$("#busiOrgIdList").val("");
		}else{
			if(busiOrgList == "") {
				var busiOrgNameList = $("#busiOrgNamelist").val();
				$("#allFlag").val(0);
				var busiOrgIdList = busiOrgNameList;
				$("#busiOrgIdList").val(busiOrgIdList);
			} else {
				$("#allFlag").val(0);
				var busiOrgIdList =busiOrgNameList;
				$("#busiOrgIdList").val(busiOrgIdList);
			}

		}
	}
}
function relReset(){
	$("#exportBtn").removeClass("Ash_disposal");
	$("#exportBtn").attr("disabled", false);
	$('#companyName option.one').attr("disabled", false);
	$('#companyName option.all').attr("disabled", false);
	$("#companyName").selectpicker('refresh');
	$('#busiOrgName').html("");
	$("#busiOrgName").selectpicker('refresh');
	$('#productNameList option.one').attr("disabled", false);
	$('#productNameList option.all').attr("disabled", false);
	$("#productNameList").selectpicker('refresh');
}
function setPageTitle(title) {
    $("#pageTtl", parent.document).html(title)
}
/**
	 * 只展示服务项名称
	 * @param {Object} value
	 */
function setTableShowServiceItemName(value) {
		if($.isEmpty(value)) {
			return "";
		}
		var indexOf = value.indexOf("{");
		var values = value;
		value = serviceItemNameSubStr(value);
		if(value.length > 120000) {
			if(indexOf != -1) {
				if(value.substring(0, indexOf).length > 12) {
					values = "<p style='text-align: left;display: inline-block;'>"+value.substring(0, 12) + "<span style='color:#3c91f7'><span data-html='true' data-placement='right' class='has-tooltip' data-toggle='tooltip' title='<span>" + value + "</span>'>......</span></span><p>";
				} else {
					values = "<p style='text-align: left;display: inline-block;'>"+value.substring(0, indexOf) + "<span style='color:#3c91f7'>" + value.substring(indexOf, 12) + "<span data-html='true' data-placement='right' class='has-tooltip' data-toggle='tooltip' title='<span>" + value + "</span>'>......</span></span><p>";
				}
			} else {
				values = "<p style='text-align: left;display: inline-block;'>"+value.substring(0, 12) + "<span style='color:#3c91f7'><span data-html='true' class='has-tooltip' data-placement='right' data-toggle='tooltip' title='<span>" + value + "</span>'>......</span></span><p>";
			}
		} else {
			if(indexOf != -1) {
				values = "<p style='text-align: left;display: inline-block;'>"+value.substring(0, indexOf) + "<span class='show-service-name'>" + value.substring(indexOf, value.length) + "</span><p>";
			}
		}
		return values;
	}
	/***
	 * 服务型名称换行显示
	 * @param {Object} name 服务型名称
	 * @param {Object} subStrlength 需要换行的长度 默认20
	 */
 function serviceItemNameSubStr(name, subStrlength) {
		if($.isEmpty(subStrlength)) {
			subStrlength = 20;
		}
		var nameList = [];
		for(var i = 0; i < name.length; i++) {
			nameList.push(name.substr(i * subStrlength, subStrlength));
			if((i + 1) * subStrlength >= name.length) {
				break;
			}
		}
		name = nameList.join("<br>");
		return name;
	}
 
 //国际化
    var pageLanguageParamObj;
    var getWebRootPath = function () {
        var a = window.document.location.href; //
        var b = window.document.location.pathname;
        var pos = a.indexOf(b);
        var path = a.substring(0, pos);
        /*若有项目名
        a = a.substring(a.indexOf("/") + 2, a.length);
        a = a.substring(a.indexOf("/") + 1, a.length);
        var pathName = a.substring(0, a.indexOf("/"));
        return path + "/" + pathName; */
        return path + "/";
    }

    function loadProperties(type) {
        var webRootPath = getWebRootPath();
        jQuery.i18n.properties({
            name: 'i18n', // 资源文件名称  
            path: webRootPath + 'Languages/' + type + '/i18n/', // 资源文件所在目录路径  
            mode: 'map', // 模式：变量或 Map  
            language: type, // 对应的语言  
            cache: false,
            encoding: 'UTF-8',
            callback: function () { // 回调方法
                $('[data-locale]').each(function () {
                    if ($(this).attr("data-locale")) {
                        $(this).html($.i18n.prop($(this).attr("data-locale")));
                    }
                    if ($(this).attr("data-locale-title")) {
                        $(this).attr("title", $.i18n.prop($(this).attr("data-locale-title")))
                    }
                    if ($(this).attr("data-locale-placeholder")) {
                        $(this).attr("placeholder", $.i18n.prop($(this).attr("data-locale-placeholder")))
                    }
                    if ($(this).attr("data-locale-content")) {
                        $(this).attr("data-content", $.i18n.prop($(this).attr("data-locale-content")))
                    }
                });
            }
        });
    }

    function getSelectedLanguage() {
        return $.getSessionStorage("selectedLanguage")
    }
    function getPageLanguageEffect(pageName,mainPageTitle) {
        var lang = $.getSessionStorage("selectedLanguage")
        if (!lang) {
            lang = "zh-CN"
        }
        var webRootPath = getWebRootPath()
        var selectLangPath = webRootPath + "js/plugins/bootstrap-select-1.13.9/js/i18n/defaults-" + lang.replace("-", "_") + ".js"
        var validateLangPath = webRootPath + "js/plugins/validate/messages_" + lang + ".js"
    
        var languageParamPath = webRootPath + 'Languages/' + lang + '/js/language-param-' + lang + '.js'
        loadJavascript(languageParamPath, false)
        loadJavascript(selectLangPath, false)
        loadJavascript(validateLangPath, false)
    
        pageLanguageParamObj = eval("pagelanguageParamSettings_" + lang.replace("-", "_"))[pageName]
        if ($.isEmpty(mainPageTitle)) {
            if (pageLanguageParamObj.pageTitle) {
                setPageTitle(pageLanguageParamObj.pageTitle)
            }
        } else {
            setPageTitle(pageLanguageParamObj[mainPageTitle])
        }
        setAssignmentAttribute(pageLanguageParamObj);
        loadProperties(lang)
    }
    // 重载相关方法 获取返回对象
    function getPageLanguageEffectNew(pageName,mainPageTitle) {
        var lang = $.getSessionStorage("selectedLanguage")
        if (!lang) {
            lang = "zh-CN"
        }
        var webRootPath = getWebRootPath()
        var selectLangPath = webRootPath + "js/plugins/bootstrap-select-1.13.9/js/i18n/defaults-" + lang.replace("-", "_") + ".js"
        var validateLangPath = webRootPath + "js/plugins/validate/messages_" + lang + ".js"
    
        var languageParamPath = webRootPath + 'Languages/' + lang + '/js/language-param-' + lang + '.js'
        loadJavascript(languageParamPath, false)
        loadJavascript(selectLangPath, false)
        loadJavascript(validateLangPath, false)
    
        var pageLanguageParamObj = eval("pagelanguageParamSettings_" + lang.replace("-", "_"))[pageName]
        if ($.isEmpty(mainPageTitle)) {
            if (pageLanguageParamObj.pageTitle) {
                setPageTitle(pageLanguageParamObj.pageTitle)
            }
        } else {
            setPageTitle(pageLanguageParamObj[mainPageTitle])
        }
        setAssignmentAttribute(pageLanguageParamObj);
        loadProperties(lang)
        return pageLanguageParamObj;
    }
    function getComponentLanguageEffect(componentPageName) {
        var lang = $.getSessionStorage("selectedLanguage")
        if (!lang) {
            lang = "zh-CN"
        }
        var componentLanguageParamObj = JSON.stringify(eval("pagelanguageParamSettings_" + lang.replace("-", "_"))[componentPageName])
        loadProperties(lang)
        eval(componentPageName + "=" + componentLanguageParamObj);
    }
    /**
     * 给页面提示等属性赋值多语言版本
     * @param {Object} data  数据集合
     */
    function setAssignmentAttribute(data) {
        $('[data-assignment]').each(function () {
            if (!$.isEmpty(data[$(this).attr("data-assignment")]) && !$.isEmpty($(this).attr("data-attribute"))) {
                if ($(this).attr("data-attribute") == "html") {
                    $(this).html(data[$(this).attr("data-assignment")]);
                } else {
                    $(this).attr($(this).attr("data-attribute"), data[$(this).attr("data-assignment")]);
                }
            }
        });
    }
    function getJsLanguageParam(objName) {
        var lang = $.getSessionStorage("selectedLanguage")
        if (!lang) {
            lang = "zh-CN"
        }
        // var jsLanguageParamObj = JSON.stringify(eval("pagelanguageParamSettings_" + lang.replace("-", "_"))[objName])
        var jsLanguageParamObj = JSON.stringify({
            formatLoadingMessage: function () {
                return "正在努力地加载数据中，请稍候……"
            }, formatRecordsPerPage: function (a) {
                return "每页显示 " + a + " 条记录"
            }, formatShowingRows: function (a, b, c) {
                return "显示第 " + a + " 到第 " + b + " 条记录，总共 " + c + " 条记录"
            }, formatSearch: function () {
                return "搜索"
            }, formatNoMatches: function () {
                return "没有找到匹配的记录"
            }, formatPaginationSwitch: function () {
                return "隐藏/显示分页"
            }, formatRefresh: function () {
                return "刷新"
            }, formatToggle: function () {
                return "切换"
            }, formatColumns: function () {
                return "列"
            }, formatExport: function () {
                return "导出数据"
            }, formatClearFilters: function () {
                return "清空过滤"
            }
        })
        return eval(objName + "=" + jsLanguageParamObj);
    }
    function loadJavascript(url, async) {
        $.ajax({
            url: url,
            dataType: "script",
            async: async
        });
    }