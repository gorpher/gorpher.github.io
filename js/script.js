(function ($, window) {

    var App = App || {
        init: function () {
            $('.js-toggle-search').on('click', function () {
                $('.js-search').toggleClass('is-visible');
                if ($('.js-search').attr('class').indexOf('is-visible') > 0) {
                    $('input.text-input').focus()
                }
            });

            $('.js-next a').on('click', function (e) {
                $(infinite_scroll.contentSelector).infinitescroll(infinite_scroll);

                var $body = $('body');

                $body.scrollTop($body.scrollTop() - 1);

                e.preventDefault();
            })

            $(window).keydown(function (event) {
                if (event.keyCode == 27) {
                    if ($('.js-search').attr('class').indexOf('is-visible') > 0) {
                        $('.js-search').removeClass('is-visible');
                    }
                }
            });

            $('.js-search .text-input').keydown(function (event) {
                if (event.keyCode == 13) {

                    // todo
                    // location.href = 'https://www.google.com/search?q=site:yumemor.com' + $(this).val();
                    return false;
                }
            })
        }
    };


    $(App.init);

    $(function () {

        var navToggle = $('#nav-toggle'),
            nav = $('nav'),
            navLinks = nav.find('a');

        navToggle.on('click', function () {
            navToggle.toggleClass('active');
            nav.toggleClass('open');
            return false;
        });
        navLinks.on('click', function () {
            navToggle.toggleClass('active');
            nav.toggleClass('open');
        });

        $(document).on('click', function () {
            if (nav.hasClass('open')) {
                navToggle.toggleClass('active');
                nav.toggleClass('open');
            }
        });

        $('.btn-slide').click(function () {
            $('#panel').slideToggle("slow");
            $(this).toggleClass("active");
            return false;
        });

        $(window).scroll(function () {
            var header = $('header');

            if ($(this).scrollTop() > 1) {
                header.addClass("scrolled");
                console.log('改变状态')
            } else {
                header.removeClass("scrolled");
                console.log('移除状态')
            }
            if (getScrollTop() + getClientHeight() == getScrollHeight()) {
                console.log('下拉刷新了')
                //此处发起AJAX请求
            }
        });

        $("#social-share").click(function () {
            $("#social").toggleClass("visible").slideToggle(200);
        });

        if ($('.welcome')[0]) {
            $('.author-info').hide();
            $('span.info-edit').click(function () {
                $('.author-info').toggle();
            });
        }
        $.ajaxSettings.async = false;
        var changeIMG = function () {
            $.getJSON("/js/images.json", function (data) {
                console.log(data)
                var length = data.length;
                var index = parseInt(Math.random() * length);
                var url = 'http://img.matosiki.site/' + data[index].url;
                $.ajax({
                    type: "GET",
                    url: url,
                    success: function () {
                        // console.log(url)
                        bannerNode.attr('style', 'background-image:url(' + url + ')');
                        // console.log("改变背景")
                    }, error: function () {
                        // console.log("改变背景失败");
                        bannerNode.attr('style', 'background-image:url(' + defualtImageURL + ')');
                    }
                });
            });
        }
        // console.log(site.data.images)
        var bannerNode = $('.top-image');
        var defualtImageURL = 'http://img.matosiki.site/image/banner/rand/1.jpg'
        if (bannerNode.data('enable')) {
            // bannerNode.attr('style', 'background-image:url(' + defualtImageURL + ')');
            changeIMG()
            var i = 1
            var fac = 100.0
            var fv = (20 / fac)
            var origin = true
            setInterval(() => {
                if (origin) {
                    i++
                    if (i >= fac - (fac * fv)) {
                        origin = false
                        changeIMG()
                    }
                } else {
                    i--
                    if (i <= 0) {
                        origin = true
                    }
                }
                var opacity = 1 - (i % fac / fac)
                bannerNode.css("opacity", opacity);
                // console.log(i, opacity, fv)
            }, 100);
        }
    })

}(jQuery, window));
//获取滚动条当前的位置
function getScrollTop() {
    var scrollTop = 0;
    if (document.documentElement && document.documentElement.scrollTop) {
        scrollTop = document.documentElement.scrollTop;
    } else if (document.body) {
        scrollTop = document.body.scrollTop;
    }
    return scrollTop;
}
//获取当前可视范围的高度  
function getClientHeight() {
    var clientHeight = 0;
    if (document.body.clientHeight && document.documentElement.clientHeight) {
        clientHeight = Math.min(document.body.clientHeight, document.documentElement.clientHeight);
    } else {
        clientHeight = Math.max(document.body.clientHeight, document.documentElement.clientHeight);
    }
    return clientHeight;
}
//获取文档完整的高度 
function getScrollHeight() {
    return Math.max(document.body.scrollHeight, document.documentElement.scrollHeight);
}