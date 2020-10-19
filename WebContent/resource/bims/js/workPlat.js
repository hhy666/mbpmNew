$().ready(function() {
    //setPageTitle("工作台")
    // getPageLanguageEffect("workPlat");
    // var busSysCodeContent = cacheHandler.getSessionStorage('busSysCodeContent')
    // var workTypeList = busSysCodeContent.WORKFLOW_TODO_URL
    // var workTypeListReject = busSysCodeContent.WORKFLOW_REJECT_URL
    // var workTypeListMessage = busSysCodeContent.WORKFLOW_MESSAGE_URL
    var workTypeList = ""
    var workTypeListReject = ""
    var workTypeListMessage = ""
    // var workTypeListRejMes =  workTypeListReject.concat(workTypeListMessage)
    var workTypeListRejMes =  ""
    function workTypeName(codeListName, workType){
        for(var i in codeListName){
            if (codeListName[i].codeNo == workType) {
                return codeListName[i].codeDesc
            }
        }
        return '<label> </label>';
    }

    var generateTodoList =function(todoList){
        var todoContent = '';
        if(todoList.length>0){
            for(var i in todoList){
                var trContent = ''
                if(todoList[i].isLook == '1'){
                    trContent = '<tr style="color:#BFB8B8"><td>'
                }else {
                    trContent = '<tr><td>'
                }
                todoContent += trContent + todoList[i].createTime + '</td><td>' + todoList[i].customerName
                               + '，'+todoList[i].idType+'<span class="isLook">(' + todoList[i].workId + ')</span><span class="url-span">'
                               +todoList[i].taskUrl+'</span>'+'<span class="url-span">'+todoList[i].id+'</span><span class="url-span">'
                               + todoList[i].workType + '</span>，'
                               + workTypeName(workTypeList, todoList[i].workType) + '</td></tr>'
            }
        }else {
            //$("#noTodoList").show()
            //$("#viewMoreTodo").hide()
        }
        $("#todoContent").append(todoContent)
    }
    
    
    var generateRejectList = function(rejectList){
        var rejectContent = '';
        if(rejectList.length>0){
            for(var i in rejectList){
                var trContent = '';
                if(rejectList[i].isLook == '1'){
                    trContent = '<tr style="color:#BFB8B8"><td>'
                }else {
                    trContent = '<tr><td>'
                }
                rejectContent += trContent + rejectList[i].createTime + '</td><td>' + rejectList[i].customerName
                                   + '，'+rejectList[i].idType+'<span class="isLook">(' + rejectList[i].workId + ')</span><span class="url-span">'
                                   + rejectList[i].taskUrl+'</span><span class="url-span">'+rejectList[i].id+
                                   '</span><span class="url-span">'
                                    + rejectList[i].workType + '</span>，'
                                    + workTypeName(workTypeListRejMes, rejectList[i].workType) + '</td></tr>'
                                   
                                //    '</span>，'+
                                //    workTypeName(workTypeListRejMes, rejectList[i].workType)+'</td></tr>'
            }
        }else {
            //$("#noRejectList").show()
            //$("#viewMoreReject").hide()
        }
        $("#rejectContent").append(rejectContent)
    }
    
    // var productId = $.getSessionStorage($("#uuid", top.document).val());
    // if (productId) {
    //     $("#addOrder").show()
    // } else {
    //     $("#addOrder").hide()
    // }
    $("#addOrder").show()

    $("#addOrder").click(function(){
        $("#frame").attr('src', 'business/order/orderEdit.html');
        var url = "business/order/orderEdit.html";
        window.parent.postMessage(url, '*');
    })
    
    
    
    var t_pageNum = 1;  // 当前页码
    var t_pageSize = 15; // 当前每页条数
    var t_pageCount = 0;//总页数
    
    var r_pageNum = 1;  // 当前页码
    var r_pageSize = 10; // 当前每页条数
    var r_pageCount = 0;//总页数
    // getData('queryTodoList', generateTodoList, t_pageNum, t_pageSize, 'todo', 'viewMoreTodo');//初始获取数据，加载数据事件
    // getData('queryRejectList', generateRejectList, r_pageNum , r_pageSize, 'reject', 'viewMoreReject');//初始获取数据，加载数据事件
    /*$('#viewMoreTodo').click(function() {
            if (t_pageNum < t_pageCount) {
                t_pageNum++;
                getData('queryTodoList', generateTodoList, t_pageNum, t_pageSize, 'todo', 'viewMoreTodo');
            }else if (t_pageNum == t_pageCount) {
                layer.msg(pageLanguageParamObj.noMore,{time: 2200});
                //$("#viewMoreTodo").hide();
                /!*t_pageNum++;
                getData('queryTodoList', generateTodoList, t_pageNum, t_pageSize, 'todo', 'viewMoreTodo');*!/
            }else{
                layer.msg(pageLanguageParamObj.noMore,{time: 2200});
            }
        });  */
    /*$('#viewMoreReject').click(function() {
        if (r_pageNum < r_pageCount) {
            r_pageNum++;
            getData('queryRejectList', generateRejectList, r_pageNum , r_pageSize, 'reject', 'viewMoreReject');
        }else if (r_pageNum == r_pageCount) {
            layer.msg(pageLanguageParamObj.noMore,{time: 2200});
            //$("#viewMoreReject").hide();
            /!*r_pageNum++;
            getData('queryRejectList', generateRejectList, r_pageNum , r_pageSize, 'reject', 'viewMoreReject');*!/
        }else {
            layer.msg(pageLanguageParamObj.noMore,{time: 2200});
        }
    });  */

    /*$('#rejectRefresh').click(function() {
            $("#rejectContent").empty();
            r_pageNum = 1;
            r_pageSize = 10;
            r_pageCount = 0;
            getData('queryRejectList', generateRejectList, r_pageNum , r_pageSize, 'reject', 'viewMoreReject');
    });  */
    /*$('#todoRefresh').click(function() {
            $("#todoContent").empty();
            t_pageNum = 1;
            t_pageSize = 15;
            t_pageCount = 0;
            getData('queryTodoList', generateTodoList, t_pageNum, t_pageSize, 'todo', 'viewMoreTodo');
    });  */
    
    
    function getData(apiName, generateFunc, pageNum, pageSize, countType, moreDivId) {
        var params = {
                "userIdMes": userInfo.userSubId,
                "offset": pageNum,
                "limit": pageSize
        }
        //var dataResp = AjaxHandler.ajaxGetAsync(globalConfig.serverUrl + api[apiName], params, callBackFunc)
        AjaxHandler.ajaxFuncNoLoadingMes(globalConfig.serverUrl + api[apiName], params, "GET", callBackFunc, true)

        function callBackFunc(dataResp) {
            var data = dataResp.data
            if (dataResp.busCode != "SUCCESS") {
                LayerHandler.errorMsg(dataResp.busMsg)
            }
            var list = data.list
            if (countType == 'todo') {
                t_pageCount = data.pageCount;
            } else if (countType == 'reject') {
                r_pageCount = data.pageCount;
            }

            /*if (pageNum == data.pageCount) {
                $("#"+moreDivId).hide();
            }*/
            generateFunc(list)

            $(".notDisplay").unbind('click').bind('click', function () {
                var id = $(this).parent().prev().children("span").eq(2).text()
                var params = {
                    "id": id
                }
                var resData = AjaxHandler.ajaxPostSync(globalConfig.serverUrl + api.updateDisplay, params)
                if (resData.isOk) {
                    $(this).parent().parent().hide()
                } else {
                    LayerHandler.error(data.busMsg)
                }
            })

            /*$(".isLook").unbind('click').bind('click', function () {
                var url = $(this).next().text()
                var id = $(this).parent().children("span").eq(2).text()
                var workType = $(this).parent().children("span").eq(3).text()
                var params = {
                    "id": id,
                    "workType": workType
                }
                var resData = AjaxHandler.ajaxPostSync(globalConfig.serverUrl + api.updateLook, params)
                if (resData.isOk) {
                    $(this).parent().parent().css('color', '#BFB8B8')
                } else {
                    LayerHandler.error(data.busMsg)
                }
                if(workType.charAt(0) != "I"){
                    window.location.href = url
                }
            })*/
        }
        
    }
})
