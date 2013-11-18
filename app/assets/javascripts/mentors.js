$(document).ready(function() {
    if ($('.pagination').length) {
        $(window).scroll(function() {
            var url;
            url = $('.pagination .next a').attr('href');
            if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 50) {
                $('.pagination').text('Loading more activities...');
                return $.getScript(url);
            }
        });
    }
    return $(window).scroll();
});