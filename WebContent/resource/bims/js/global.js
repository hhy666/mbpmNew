$(function() {
	//详情锚点跳转
	$('.top-fixed-nav .inner').on('click', 'a', function() {
		var target = $(this).data('target');
		if(!target) return false
		var y = $('.' + target).offset().top - 40;
		$('html,body').animate({
			scrollTop: y
		}, 600)
	});
	// 全选效果
	$("#chsAllHandle").click(function(e) {
		if(e.currentTarget.checked) {
			$(this).parents('table').find('input[type=checkbox]').each(function(index, item) {
				item.checked = true;
			});
		} else {
			$(this).parents('table').find('input[type=checkbox]').each(function(index, item) {
				item.checked = false;
			});
		}
		statChkNum($(this));
	});
	$("table input[type=checkbox]").click(function(event) {
		event.stopPropagation();
		statChkNum($(this));
		chkIsAll($(this));
	});
	$(".iptDiv .input-group input").focus(function() {
		$(this).parents(".input-group ").addClass('getFocus');
	});
	$(".iptDiv .input-group input").blur(function() {
		$(this).parents(".input-group ").removeClass('getFocus');
	});
	$(".input-group p.close").click(function() {
		$(this).siblings('input').val('');
	});
	$(".input-group p.tglPswd").click(function() {
		if($(this).siblings('input').attr('type') == 'password') {
			$(this).siblings('input').attr('type', 'text');
		} else {
			$(this).siblings('input').attr('type', 'password');
		}
	});

	// 关闭弹框
	$(".closeFixedBox").click(function() {
		$(this).parents('.bgll').fadeOut();
		$(this).parents('.fixedBoxDiv').fadeOut();
		bodyOverflowAuto();
	});
	// 关闭弹框
	$(".cancel").click(function() {
		$(this).parents('.bgll').fadeOut();
		$(this).parents('.fixedBoxDiv').fadeOut();
		bodyOverflowAuto();
	});

	//提交或者保存后的关闭弹窗
	$(".submit").click(function() {
		bodyOverflowAuto();
	})
	$("table").on("all.bs.table", function() {
		initButtonPermisson()
	})
});

function bodyOverflowHide() {
	$("body").css({
		height: '100%',
		overflow: "hidden"
	});

}

function bodyOverflowAuto() {
	$("body").css({
		height: 'auto',
		overflow: "auto"
	});

}

function showFixedBox(name) {
	document.getElementsByClassName(name)[0].style.display = 'block';
	bodyOverflowHide();
}
// 
function showFixedBoxById(id) {
	$("#" + id).css("display", "block");
	bodyOverflowHide();
}

function statChkNum(tagt) {
	var num = 0;
	tagt.parents('table').find('input[type=checkbox]:not(#chsAllHandle)').each(function(index, item) {
		if(item.checked) {
			num++;
		}
	});
	$("#statChkNum").text(num);
}

function chkIsAll(tagt) {
	var isAll = true;
	tagt.parents('table').find('input[type=checkbox]:not(#chsAllHandle)').each(function(index, item) {
		if(!item.checked) {
			isAll = false;
		}
	});
	if(isAll) {
		document.getElementById("chsAllHandle").checked = true;
	} else {
		document.getElementById("chsAllHandle").checked = false;
	}
}

function prepend(val) { //让div 居中显示
	var top = ($(window).height() - $("#" + val).height()) / 2;
	var left = ($(window).width() - $("#" + val).width()) / 2;
	var scrollTop = $(document).scrollTop();
	var scrollLeft = $(document).scrollLeft();
	$("#" + val).css({
		position: 'absolute',
		'top': top + scrollTop,
		left: left + scrollLeft
	}).show();
}

function divHide(value) { //隐藏DIV
	$("#" + value).hide();
}

function hideFixedBoxDiv(selected) { //隐藏弹框
	$(selected).parents('.fixedBoxDiv').hide();
	$(selected).parents('.bgll').hide();
	bodyOverflowAuto();
}

function fomrReset(fromId) {
	$("#" + fromId)[0].reset();
}

function getDate() {
	var myDate = new Date;
	var year = myDate.getFullYear(); //获取当前年
	var mon = myDate.getMonth() + 1; //获取当前月
	var date = myDate.getDate(); //获取当前日
	var h = myDate.getHours(); //获取当前小时数(0-23)
	var m = myDate.getMinutes(); //获取当前分钟数(0-59)
	var s = myDate.getSeconds(); //获取当前秒
	var week = myDate.getDay();
	var weeks = ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"];
	return year + "-" + mon + "-" + date + " " + h + ":" + m + ":" + s;

}

/**
 * 判断此对象是否是Object类型
 * @param {Object} obj  
 */
function isObject(obj) {
	return Object.prototype.toString.call(obj) === '[object Object]';
};
/**
 * 判断此类型是否是Array类型
 * @param {Array} arr 
 */
function isArray(arr) {
	return Object.prototype.toString.call(arr) === '[object Array]';
};
/**
 *  深度比较两个对象是否相同
 * @param {Object} oldData 
 * @param {Object} newData 
 */
function equalsObj(oldData, newData) {
	//       类型为基本类型时,如果相同,则返回true
	if(oldData === newData) return true;
	if(isObject(oldData) && isObject(newData) && Object.keys(oldData).length === Object.keys(newData).length) {
		//      类型为对象并且元素个数相同

		//      遍历所有对象中所有属性,判断元素是否相同
		for(var key in oldData) {
			if(oldData.hasOwnProperty(key)) {
				if(!equalsObj(oldData[key], newData[key]))
					//      对象中具有不相同属性 返回false
					return false;
			}
		}
	} else if(isArray(oldData) && isArray(oldData) && oldData.length === newData.length) {
		//      类型为数组并且数组长度相同

		for(var i = 0, length = oldData.length; i < length; i++) {
			if(!equalsObj(oldData[i], newData[i]))
				//      如果数组元素中具有不相同元素,返回false
				return false;
		}
	} else {
		//      其它类型,均返回false
		return false;
	}

	//      走到这里,说明数组或者对象中所有元素都相同,返回true
	return true;
};