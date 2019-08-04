

    // #contact-me
    $("#contact-me").fancybox({
        'easingIn': 'easeInBack',
        'easingOut': 'easeOutBack',
        'padding': 40,
        'overlayColor': "#111",
        'overlayOpacity': 0.7,
        'scrolling': 'no',
        'titleShow': false
    });

    /* Fancy Box */
    $(".fancy-box").fancybox({
        'overlayColor': "#111",
        'overlayOpacity': 0.7,
        'easingIn': 'easeInBack',
        'easingOut': 'easeOutBack'
    });

    $("a[rel=group1").fancybox({
        'overlayColor': "#111",
        'overlayOpacity': 0.7,
        'easingIn': 'easeInBack',
        'easingOut': 'easeOutBack',
        'transitionIn': 'none',
        'transitionOut': 'none',
        'titlePosition': 'over',
        'titleFormat': function(title, currentArray, currentIndex, currentOpts) {
            return '<span id="fancybox-title-over">Image ' + (currentIndex + 1) + ' / ' + currentArray.length + (title.length ? ' &nbsp; ' + title : '') + '</span>';
        }
    });

    $("a[rel=group2]").fancybox({
        'overlayColor': "#111",
        'overlayOpacity': 0.7,
        'easingIn': 'easeInBack',
        'easingOut': 'easeOutBack',
        'transitionIn': 'none',
        'transitionOut': 'none',
        'titlePosition': 'over',
        'titleFormat': function(title, currentArray, currentIndex, currentOpts) {
            return '<span id="fancybox-title-over">Image ' + (currentIndex + 1) + ' / ' + currentArray.length + (title.length ? ' &nbsp; ' + title : '') + '</span>';
        }
    });

    $("a[rel=group3]").fancybox({
        'overlayColor': "#111",
        'overlayOpacity': 0.7,
        'easingIn': 'easeInBack',
        'easingOut': 'easeOutBack',
        'transitionIn': 'none',
        'transitionOut': 'none',
        'titlePosition': 'over',
        'titleFormat': function(title, currentArray, currentIndex, currentOpts) {
            return '<span id="fancybox-title-over">Image ' + (currentIndex + 1) + ' / ' + currentArray.length + (title.length ? ' &nbsp; ' + title : '') + '</span>';
        }
    });

    $("a[rel=group4]").fancybox({
        'overlayColor': "#111",
        'overlayOpacity': 0.7,
        'easingIn': 'easeInBack',
        'easingOut': 'easeOutBack',
        'transitionIn': 'none',
        'transitionOut': 'none',
        'titlePosition': 'over',
        'titleFormat': function(title, currentArray, currentIndex, currentOpts) {
            return '<span id="fancybox-title-over">Image ' + (currentIndex + 1) + ' / ' + currentArray.length + (title.length ? ' &nbsp; ' + title : '') + '</span>';
        }
    });
    
    
    $('#middle-content ul.list>li:nth-child(even)').not('.arrow-up').css({'background': '#e6e6e6'});
    $('#middle-content ul.list>li:nth-child(odd)').not('.arrow-up').css({'background': '#f6f6f6'});
    $('#middle-content ul.list:last-child').css({'margin-bottom': '0'});