// Code By: Ashik Iqbal
// www.ashik.info

var editorSubject, editor, myLayout, myLayout1, ckeditorToolbar, LastMsg, EMPID, ONEDIT = false, CSS_FILTER = '', UnreadCount = 0;
ONEDIT = false;
ckeditorToolbar = [
	    ['Cut', 'Copy', 'Paste', 'PasteText', 'PasteFromWord', '-', 'Undo', 'Redo'],
        ['Find', 'Replace', '-', 'SelectAll'],
	    ['Bold', 'Italic', 'Underline', 'Strike', '-', 'RemoveFormat'], ['Subscript', 'Superscript'], ['Source'], ['Maximize'], '/',
	    ['NumberedList', 'BulletedList', '-', 'Outdent', 'Indent',
	    '-', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock'],
	    ['Link', 'Unlink'],
	    ['Table', 'HorizontalRule', 'Smiley'],
        ['Styles']]; 
 var ckeditorToolbar1 = [
	    ['Bold', 'Italic', 'Underline', 'Strike', '-', 'RemoveFormat'], ['Subscript', 'Superscript'],
	    ['Link', 'Unlink']];
ckeditorRemovePlugins = 'bidi,font,forms,flash,horizontalrule,iframe,scayt,wsc';

function htmlEscape(str) {
    //return str.text();
    return String(str)
        .replace(/&/g, '&amp;')
        .replace(/"/g, '&quot;')
        .replace(/'/g, '&#39;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/\\/g, '&#92;')
        ;
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

function showLoadingDialog(titleText) {
    $("#loading").dialog({
        modal: true,
        height: 210,
        width: 240,
        resizable: false,
        draggable: false,
        title: titleText,
        closeOnEscape: false,
        disabled: true
    });
    $(".ui-dialog-titlebar-close").hide();
}

function hideLoadingDialog() {
    $("#loading").dialog("close");
    $("#loading").dialog("destroy");
}

$(document).ready(function() {
    jQueryInit();
});

function pageLoad() {
    Sys.WebForms.PageRequestManager.getInstance().add_endRequest(jQueryInit);
}


function jQueryInit() {
    $(document).ready(function () {

        // Prevent the backspace key from navigating back.
        $(document).unbind('keydown').bind('keydown', function (event) {
            var doPrevent = false;
            if (event.keyCode === 8) {

                var d = event.srcElement || event.target;
                //alert();
                if ((d.tagName.toUpperCase() === 'INPUT' && (
                    d.type.toUpperCase() === 'TEXT'
                    || d.type.toUpperCase() === 'EMAIL'
                    || d.type.toUpperCase() === 'PASSWORD'
                    || d.type.toUpperCase() === 'NUMBER'
                    ))
                    || d.tagName.toUpperCase() === 'TEXTAREA'
                    || $(d).hasClass("editable")
                    ) {
                    doPrevent = d.readOnly
                    || d.disabled;
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

    
    

    //Refresh Challenge Key
    $('#ImgChallengeReload,#ImgChallenge').click(function () {
        $('#ImgChallenge').attr('src', 'Images/loading1.gif');
        $('#ctl00_ContentPlaceHolder2_txtCaptcha').val('').focus();
        setTimeout(function () {
            $('#ImgChallenge').attr('src', 'captcha.ashx?rand=' + Math.random());
        }, 100);
    });
    $('#ImgChallenge').attr('src', 'captcha.ashx?rand=' + Math.random());
    $('#ctl00_ContentPlaceHolder2_txtCaptcha').val('');    
        

    $('.div-preview a').each(function () {
        $(this).attr("target", "_blank");
        $(this).addClass('link');
    });

    $('input:text[placeholder]').each(function () {
        $(this).watermark($(this).attr('placeholder'));
    });


    $("time.timeago").timeago();
    //Disable All Combo
    $("select option[value='']").attr('disabled', true);

    $('.Date').datepicker({
        changeMonth: true,
        changeYear: true,
        showButtonPanel: true,
        dateFormat: 'dd/mm/yy',
        showAnim:'show'
    });

    $('.Date-DOB').datepicker({
        minDate: "-70Y",
        maxDate: "-18Y",
        changeMonth: true,
        changeYear: true,
        showButtonPanel: true,
        dateFormat: 'dd/mm/yy',
        showAnim: 'show'
    });

    $('.Date,.Date-DOB').watermark('dd/mm/yyyy');

    
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

    //Advanced (Request_iBanking.aspx
    $('.btn-option-advance').click(function () {
        $('.option-advance').removeClass('hidden');
    });

    $('#btnInfo-TransferLimit').click(function () {
        $(this).addClass('hidden');
        $('#lblInfo-TransferLimit').removeClass('hidden');
    });
    $('#lblInfo-TransferLimit').click(function () {
        $(this).addClass('hidden');
        $('#btnInfo-TransferLimit').removeClass('hidden');
    });

    $('#btnInfo-UtilityLimit').click(function () {
        $(this).addClass('hidden');
        $('#lblInfo-UtilityLimit').removeClass('hidden');
    });
    $('#lblInfo-UtilityLimit').click(function () {
        $(this).addClass('hidden');
        $('#btnInfo-UtilityLimit').removeClass('hidden');
    });

    $('#btnInfo-DailyTransactionLimit').click(function () {
        $(this).addClass('hidden');
        $('#lblInfo-DailyTransactionLimit').removeClass('hidden');
    });
    $('#lblInfo-DailyTransactionLimit').click(function () {
        $(this).addClass('hidden');
        $('#btnInfo-DailyTransactionLimit').removeClass('hidden');
    });

    $('#btnInfo-MonthlyTransactionLimit').click(function () {
        $(this).addClass('hidden');
        $('#lblInfo-MonthlyTransactionLimit').removeClass('hidden');
    });
    $('#lblInfo-MonthlyTransactionLimit').click(function () {
        $(this).addClass('hidden');
        $('#btnInfo-MonthlyTransactionLimit').removeClass('hidden');
    });

    $('#btnInfo-PerDayNoOfTransaction').click(function () {
        $(this).addClass('hidden');
        $('#lblInfo-PerDayNoOfTransaction').removeClass('hidden');
    });
    $('#lblInfo-PerDayNoOfTransaction').click(function () {
        $(this).addClass('hidden');
        $('#btnInfo-PerDayNoOfTransaction').removeClass('hidden');
    });

    $('#btnInfo-PerMonthNoOfTransaction').click(function () {
        $(this).addClass('hidden');
        $('#lblInfo-PerMonthNoOfTransaction').removeClass('hidden');
    });
    $('#lblInfo-PerMonthNoOfTransaction').click(function () {
        $(this).addClass('hidden');
        $('#btnInfo-PerMonthNoOfTransaction').removeClass('hidden');
    });

    //End Advanced (Request_iBanking.aspx
    


    $('#cmdPrint').click(function () {
        var options = { mode: 'popup', popClose: '', extraCss: 'CSS/StyleSheetPrint.css' };
        $Div_PrintArea = $('#print-div');
        $("input[type='text']", $Div_PrintArea).each(function () {
            this.setAttribute('value', $(this).val());
            $(this).replaceWith("<b>" + this.value + "</b>");
        });
        $('#print-div').printArea(options);
    });

    $('.cmd-Attachment-show').click(function () {
        $('.cmd-Attachment-show').hide();
        $('.div-Attachment-Add').show('Slow');        
    });
    $('.cmd-Attachment-hide').click(function () {
        $('.div-Attachment-Add').hide('Slow');
        $('.cmd-Attachment-show').show();
    });

    var telInput = $("#ctl00_ContentPlaceHolder2_DetailsView1_txtMobile"),
        errorMsg = $("#error-msg"),
        validMsg = $("#valid-msg");
        submitBtn = $('#ctl00_ContentPlaceHolder2_DetailsView1_cmdSaveInfo')

    telInput.intlTelInput({
        defaultStyling: "outside",
        preferredCountries: ["bd"],
        defaultCountry: "bd",
        autoHideDialCode: true,
        nationalMode: false,
        validationScript: "Script/isValidNumber.js"
    });


    // on blur: validate
    telInput.blur(function () {
        if ($.trim(telInput.val())) {
            if (telInput.intlTelInput("isValidNumber")) {
                validMsg.removeClass("hide");
                submitBtn.removeAttr('disabled');
            } else {
                telInput.addClass("error");
                errorMsg.removeClass("hide");
                validMsg.addClass("hide");
                submitBtn.attr('disabled', 'disabled');
            }
        }
    });

    // on keydown: reset
    telInput.keydown(function () {
        telInput.removeClass("error");
        errorMsg.addClass("hide");
        validMsg.addClass("hide");
    });

    // on change: reset
    telInput.change(function () {
        telInput.removeClass("error");
        errorMsg.addClass("hide");
        validMsg.addClass("hide");
    });

    //$('input[type=button]').addClass('btn btn-default btn-sm');
    $('input[type=button]').addClass('tbl-button');


    var browser = "unknown";
    var userAgent = navigator.userAgent.toLowerCase();
    if (userAgent.indexOf("opera") > -1)
        browser = "Opera";
    else if (userAgent.indexOf("konqueror") > -1)
        browser = "Konqueror";
    else if (userAgent.indexOf("firefox") > -1)
        browser = "Mozilla Firefox";
    else if (userAgent.indexOf("netscape") > -1)
        browser = "Netscape";
    else if (userAgent.indexOf("msie") > -1)
        browser = "Internet Explorer";
    else if (userAgent.indexOf("chrome") > -1)
        browser = "Google Chrome";
    else if (userAgent.indexOf("safari") > -1)
        browser = "Safari";

    //var ip = new java.net.InetAddress.getLocalHost();

    $('.BrowserInformation').html(browser + ' ' + $.browser.version);


}