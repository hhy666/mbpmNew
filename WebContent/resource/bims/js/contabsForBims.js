/****bims 菜单操作处理函数 修改自 WebContent/form/admin/main/js/content.min.js *****/
function contabsFunF(l) {
    var k = 0;
    $(l).each(function () {
        k += $(this).outerWidth(true)
    });
    return k
}

function contabsFunG(n) {
    var o = contabsFunF($(n).prevAll()), q = contabsFunF($(n).nextAll());
    var l = contabsFunF($(".content-tabs").children().not(".J_menuTabs"));
    var k = $(".content-tabs").outerWidth(true) - l;
    var p = 0;
    if ($(".page-tabs-content").outerWidth() < k) {
        p = 0
    } else {
        if (q <= (k - $(n).outerWidth(true) - $(n).next().outerWidth(true))) {
            if ((k - $(n).next().outerWidth(true)) > q) {
                p = o;
                var m = n;
                while ((p - $(m).outerWidth()) > ($(".page-tabs-content").outerWidth() - k)) {
                    p -= $(m).prev().outerWidth();
                    m = $(m).prev()
                }
            }
        } else {
            if (o > (k - $(n).outerWidth(true) - $(n).prev().outerWidth(true))) {
                p = o - $(n).prev().outerWidth(true)
            }
        }
    }
    $(".page-tabs-content").animate({marginLeft: 0 - p + "px"}, "fast")
}

function contabsFunA() {
    var o = Math.abs(parseInt($(".page-tabs-content").css("margin-left")));
    var l = contabsFunF($(".content-tabs").children().not(".J_menuTabs"));
    var k = $(".content-tabs").outerWidth(true) - l;
    var p = 0;
    if ($(".page-tabs-content").width() < k) {
        return false
    } else {
        var m = $(".J_menuTab:first");
        var n = 0;
        while ((n + $(m).outerWidth(true)) <= o) {
            n += $(m).outerWidth(true);
            m = $(m).next()
        }
        n = 0;
        if (contabsFunF($(m).prevAll()) > k) {
            while ((n + $(m).outerWidth(true)) < (k) && m.length > 0) {
                n += $(m).outerWidth(true);
                m = $(m).prev()
            }
            p = contabsFunF($(m).prevAll())
        }
    }
    $(".page-tabs-content").animate({marginLeft: 0 - p + "px"}, "fast")
}

function contabsFunB() {
    var o = Math.abs(parseInt($(".page-tabs-content").css("margin-left")));
    var l = contabsFunF($(".content-tabs").children().not(".J_menuTabs"));
    var k = $(".content-tabs").outerWidth(true) - l;
    var p = 0;
    if ($(".page-tabs-content").width() < k) {
        return false
    } else {
        var m = $(".J_menuTab:first");
        var n = 0;
        while ((n + $(m).outerWidth(true)) <= o) {
            n += $(m).outerWidth(true);
            m = $(m).next()
        }
        n = 0;
        while ((n + $(m).outerWidth(true)) < (k) && m.length > 0) {
            n += $(m).outerWidth(true);
            m = $(m).next()
        }
        p = contabsFunF($(m).prevAll());
        if (p > 0) {
            $(".page-tabs-content").animate({marginLeft: 0 - p + "px"}, "fast")
        }
    }
}



function contabsFunC(dom) {
    const o = $(dom).attr('data-url');
    const m = $(dom).id;
    const l = $(dom).children('span').text();
    let k = true
    // var o = $(this).attr("href"), m = $(this).data("index"), l = $.trim($(this).text()), k = true;
    if (o == undefined || $.trim(o).length == 0) {
        return false
    }
    $(".J_menuTab").each(function () {
        if ($(dom).data("id") == o) {
            if (!$(dom).hasClass("active")) {
                $(dom).addClass("active").siblings(".J_menuTab").removeClass("active");
                contabsFunG(dom);
                $(".J_mainContent .J_iframe").each(function () {
                    if ($(dom).data("id") == o) {
                        $(dom).show().siblings(".J_iframe").hide();
                        return false
                    }
                })
            }
            k = false;
            return false
        }
    });
    if (k) {
        var p = '<a href="javascript:;" class="active J_menuTab" data-id="' + o + '">' + l + ' <i class="fa fa-times-circle"></i></a>';
        $(".J_menuTab").removeClass("active");
        var n = '<iframe class="J_iframe" name="iframe_' + m + '" width="100%" height="100%" src="' + o + '" frameborder="0" data-id="' + o + '" seamless></iframe>';
        $(".J_mainContent").find("iframe.J_iframe").hide().parents(".J_mainContent").append(n);
        $(".J_menuTabs .page-tabs-content").append(p);
        contabsFunG($(".J_menuTab.active"))
    }
    return false
}

// $(".J_menuItem").on("click", contabsFunC);
// $(".navList").on("click", "p", contabsFunC);

function contabsFunH() {
    var m = $(this).parents(".J_menuTab").data("id");
    var l = $(this).parents(".J_menuTab").width();
    if ($(this).parents(".J_menuTab").hasClass("active")) {
        if ($(this).parents(".J_menuTab").next(".J_menuTab").size()) {
            var k = $(this).parents(".J_menuTab").next(".J_menuTab:eq(0)").data("id");
            $(this).parents(".J_menuTab").next(".J_menuTab:eq(0)").addClass("active");
            $(".J_mainContent .J_iframe").each(function () {
                if ($(this).data("id") == k) {
                    $(this).show().siblings(".J_iframe").hide();
                    return false
                }
            });
            var n = parseInt($(".page-tabs-content").css("margin-left"));
            if (n < 0) {
                $(".page-tabs-content").animate({marginLeft: (n + l) + "px"}, "fast")
            }
            $(this).parents(".J_menuTab").remove();
            $(".J_mainContent .J_iframe").each(function () {
                if ($(this).data("id") == m) {
                    $(this).remove();
                    return false
                }
            })
        }
        if ($(this).parents(".J_menuTab").prev(".J_menuTab").size()) {
            var k = $(this).parents(".J_menuTab").prev(".J_menuTab:last").data("id");
            $(this).parents(".J_menuTab").prev(".J_menuTab:last").addClass("active");
            $(".J_mainContent .J_iframe").each(function () {
                if ($(this).data("id") == k) {
                    $(this).show().siblings(".J_iframe").hide();
                    return false
                }
            });
            $(this).parents(".J_menuTab").remove();
            $(".J_mainContent .J_iframe").each(function () {
                if ($(this).data("id") == m) {
                    $(this).remove();
                    return false
                }
            })
        }
    } else {
        $(this).parents(".J_menuTab").remove();
        $(".J_mainContent .J_iframe").each(function () {
            if ($(this).data("id") == m) {
                $(this).remove();
                return false
            }
        });
        contabsFunG($(".J_menuTab.active"))
    }
    return false
}


function contabsFunI() {
    $(".page-tabs-content").children("[data-id]").not(":first").not(".active").each(function () {
        $('.J_iframe[data-id="' + $(this).data("id") + '"]').remove();
        $(this).remove()
    });
    $(".page-tabs-content").css("margin-left", "0")
}


function contabsFunJ() {
    contabsFunG($(".J_menuTab.active"))
}


function contabsFunE() {
    if (!$(this).hasClass("active")) {
        var k = $(this).data("id");
        $(".J_mainContent .J_iframe").each(function () {
            if ($(this).data("id") == k) {
                $(this).show().siblings(".J_iframe").hide();
                return false
            }
        });
        $(this).addClass("active").siblings(".J_menuTab").removeClass("active");
        contabsFunG(this)
    }
}


function contabsFunD() {
    var l = $('.J_iframe[data-id="' + $(this).data("id") + '"]');
    var k = l.attr("src")
}
