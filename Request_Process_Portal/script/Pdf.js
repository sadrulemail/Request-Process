// Code By: Ashik Iqbal
// www.ashik.info

$(document).ready(function() {
    jQueryInit();
});

function pageLoad(sender, args) {
    if (args.get_isPartialLoad()) jQueryInit();
}

function jQueryInit() {
    $(document).ready(function() {

        // Prevent the backspace key from navigating back.
        $(document).unbind('keydown').bind('keydown', function(event) {
            var doPrevent = false;
            if (event.keyCode === 8) {
                var d = event.srcElement || event.target;
                if ((d.tagName.toUpperCase() === 'INPUT' && (
                    d.type.toUpperCase() === 'TEXT'
                    || d.type.toUpperCase() === 'PASSWORD')
                    ) || d.tagName.toUpperCase() === 'TEXTAREA') {
                    doPrevent = d.readOnly || d.disabled;
                }
                else {
                    doPrevent = true;
                }
            }
            if (doPrevent) {
                event.preventDefault();
            }
        });        
    });

    $('.ReadOnly').attr('readOnly', 'true');

    $('.AttachmentThumbBig').each(function() {
        var imgurl = $(this).attr('LoadImg');
        $(this).attr('src', imgurl);
        $(this).attr('onerror', 'this.src=\'Images/Error.jpg\'');
    });

    $('.AttachmentThumb,.AttachmentThumbSelected').each(function () {
        var imgurl = $(this).attr('LoadImg');
        $(this).attr('src', imgurl);
        $(this).attr('onerror', 'this.src=\'Images/Error.jpg\'');
    });
}