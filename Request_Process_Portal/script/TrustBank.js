// Code By: Ashik Iqbal
// www.ashik.info

$(document).ready(function() {
    jQueryInit();
});

//for Postback
function pageLoad(sender, args) {
    if (args.get_isPartialLoad()) jQueryInit();
}

function getReadableFileSizeString(fileSizeInBytes) {
    var i = -1;
    var byteUnits = [' KB', ' MB', ' GB', ' TB', 'PB', 'EB', 'ZB', 'YB'];
    do {
        fileSizeInBytes = fileSizeInBytes / 1024;
        i++;
    } while (fileSizeInBytes > 1024);
    return Math.max(fileSizeInBytes, 0.1).toFixed(2) + byteUnits[i];
}

function jQueryInit() {
    $(document).ready(function () {

        // Prevent the backspace key from navigating back.
        $(document).unbind('keydown').bind('keydown', function (event) {
            var doPrevent = false;
            if (event.keyCode === 8) {
                var d = event.srcElement || event.target;
                if ((d.tagName.toUpperCase() === 'INPUT' && (
                    d.type.toUpperCase() === 'TEXT'
                    || d.type.toUpperCase() === 'PASSWORD'
                    || d.type.toUpperCase() === 'NUMBER')
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

        $('#MenuDiv').show();

        //var clipboard = new Clipboard('.click-to-copy');


        //        var client = new ZeroClipboard($(".click-to-copy"), {
        //            moviePath: "ZeroClipboard.swf",
        //            debug: false
        //        });

        //        client.on("load", function (client) {
        //            //$('#flash-loaded').fadeIn();
        //            alert('Flash Loaded');

        //            client.on("aftercopy", function (client, args) {
        //                //client.setText("Set text copied.");
        //                //$('#click-to-copy').fadeIn();
        //                alert('Copied');
        //                //client.hide();
        //            });
        //        });

        if (!$('#ContentPlaceHolder2_PanelUpload').length)
            $('#uploadDialog').hide();

        $(".ajax__fileupload").bind("change", function () {
            setTimeout(function () {
                $('.ajax__fileupload_uploadbutton').trigger('click');
            }, 100);
        });
        $(".ajax__fileupload_dropzone").bind("drop", function () {
            setTimeout(function () {
                $('.ajax__fileupload_uploadbutton').trigger('click');
            }, 100);
        });

        $('.filesize').each(function () {
            $(this).text(getReadableFileSizeString($(this).text()));
        });

        $('.hide-blank-detailsview tr').each(function () {
            if ($(this).find('td').hasClass('donothide') == false)
                if ($(this).find('td:eq(1)').text().trim() == '')
                    $(this).hide();
        });



    });


//    $('.BEFTNSearchBox').autocomplete('BEFTN_Search.ashx', {
//        width: 300,
//        minChars: 1,
//        cacheLength: 10,
//        scrollHeight: 300,
//        delay: 400,
//        scroll: true,
//        formatItem: function(data, i, n, value) {
//            return "<table><tr><td valign='top' style='width:50px;'><img src='Banklogo/"
//                + value.split(",")[3] + ".jpg' width='50px' /></td><td><span style='font-size:11pt;font-weight:bold;'>"
//                + value.split(",")[0] + "</span><br />"
//                + value.split(",")[1] + "<br />"
//                + value.split(",")[2] + "<br />"
//                + value.split(",")[4] + ", "
//                + value.split(",")[5] + ""
//                + "</td></tr><table>";
//        },
//        formatResult: function(data, value) {
//            return value.split(",")[0];
//        }
//    });

//    $(".emp-add-control-all").autocomplete("Search_EMP_ALL.ashx", {
//            width: 300,
//            minChars: 1,
//            cacheLength: 10,
//            scrollHeight: 500,
//            delay: 400,
//            scroll: true,
//            formatItem: function(data, i, n, value) {
//                return "<table><tr><td valign='top'><img src='"
//                + value.split(",")[1] + "' width='60px' title='"
//                + value.split(",")[2] + "' /></td><td>"
//                + value.split(",")[0] + "</td></tr></table>";
//            },
//            formatResult: function(data, value) {
//                return value.split(",")[2];
//            }
//        });

    $('input:text[Watermark]').each(function() {
        $(this).watermark($(this).attr('Watermark'));
    });

    $('#ctl00_ContentPlaceHolder2_radioCurrency').buttonset();

    $("time.timeago").timeago();

    $('.Date').datepicker({
        changeMonth: true,
        changeYear: true,
        showButtonPanel: true,
        dateFormat: 'dd/mm/yy',
        showAnim:'show'
    }).watermark('dd/mm/yyyy');

    setTimeout(function () {
        $('.ms-drop').html('');

        $('select[multiple=multiple]').multipleSelect({
            placeholder: 'please select',
            filter: true,
            single: false
        });

        $('select[multiple!=multiple]').each(function () {
            if ($(this).find('option').length > 7 && !$(this).is(':disabled'))
                $(this).multipleSelect({
                    placeholder: 'please select',
                    filter: true,
                    single: true
                });
        });
        $('.ms-drop').hide();
    }, 100);
    
    //Datepicker Today Problem Resolve
    $.datepicker._gotoToday = function(id) {
        var target = $(id);
        var inst = this._getInst(target[0]);
        if (this._get(inst, 'gotoCurrent') && inst.currentDay) {
            inst.selectedDay = inst.currentDay;
            inst.drawMonth = inst.selectedMonth = inst.currentMonth;
            inst.drawYear = inst.selectedYear = inst.currentYear;
        }
        else {
            var date = new Date();
            inst.selectedDay = date.getDate();
            inst.drawMonth = inst.selectedMonth = date.getMonth();
            inst.drawYear = inst.selectedYear = date.getFullYear();
            this._setDateDatepicker(target, date);
            this._selectDate(id, this._getDateDatepicker(target));
        }
        this._notifyChange(inst);
        this._adjustDate(target);
        //this.removeClass('ui-priority-secondary');
    }
    //--------------------------------------------------------------
}