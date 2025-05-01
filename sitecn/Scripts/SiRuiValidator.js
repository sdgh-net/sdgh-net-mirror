// 思睿公共js类库
if (!window.SiRui) window.SiRui = {}


// 表单验证
SiRui.FormValidator = {
    required: /.+/,
    username: /^[a-zA-Z]{1}([a-zA-Z0-9]|[._]){5,19}$/, //只能输入6-20个以字母开头、可带数字、“_”、“.”的字串
    password: /^(\w){6,20}$/, //只能输入6-20个字母、数字、下划线   
    email: /^\w+([-+.]\w+)*@\w+([-.]\\w+)*\.\w+([-.]\w+)*$/,
    phone: /^([0-9]{4}-[0-9]{8})|([0-9]{3}-[0-9]{8})|([0-9]{4}-[0-9]{7})$/,
    mobile: /^(13[0-9]|15[0-9]|18[0-9])(\d){8}$/,
    url: /^http:\/\/[A-Za-z0-9]+\.[A-Za-z0-9]+[\/=\?%\-&_~`@[\]\':+!]*([^<>\"\"])*$/,
    idcard: "this.isIdCard(value)",
    currency: /^\d+(\.\d+)?$/,
    number: /^\+?[0-9][0-9]{0,9}$/,
    zip: /^[1-9]\d{5}$/,
    qq: /^[1-9]\d{4,8}$/,
    integer: /^[-\+]?\d+$/,
    double: /^[-\+]?\d+(\.\d+)?$/,
    english: /^[A-Za-z]+$/,
    chinese: /^[\u0391-\uFFE5]+$/,
    unsafe: /^(([A-Z]*|[a-z]*|\d*|[-_\~!@#\$%\^&\*\.\(\)\[\]\{\}<>\?\\\/\'\"]*)|.{0,5})$|\s/,
    file: /^(.*)\.(rar|zip|doc|docx)$/, //文件
    picture: /^(.*)\.(jpg|bmp|gif|png)$/, //图片 |ico|pcx|jpeg|tif|raw|tga
    issafe: function (str) { return !this.unsafe.test(str); },
    safestring: "this.issafe(value)",
    limit: "this.isLimit(value.length,getAttribute('min'), getAttribute('max'))",
    limitb: "this.isLimit(this.lenB(value), getAttribute('min'), getAttribute('max'))",
    date: "this.isDate(value, getAttribute('format'))",
    datetime: "this.isDateTime(value)",
    repeat: "value == document.getElementsByName(getAttribute('to'))[0].value", //重复
    range: "getAttribute('min') < (value|0) && (value|0) < getAttribute('max')",
    compare: "this.isCompare(value,getAttribute('operator'),getAttribute('to'))", //比较
    match: "this.isMatch(value,getAttribute('operator'),getAttribute('to'))", //匹配
    custom: "this.exec(value, getAttribute('regexp'))", //自定义
    group: "this.mustChecked(getAttribute('validatorfor'), getAttribute('min'), getAttribute('max'))",

    ErrorItem: [],
    ErrorMessage: ["以下原因导致提交失败："],
    //ErrorMessage: ["Submit the cause of the failure:"],

    validate: function (objFormID, obj, mode) {
        var objForm;
        objForm = document.getElementById(objFormID);

        var objSpans = objForm.getElementsByTagName("span");    // SPAN对象集合

        var count = objSpans.length;
        this.ErrorMessage.length = 1;
        this.ErrorItem.length = 1;
        this.ErrorItem[0] = objSpans;
        // 传入单一验证对象时, 只验证传入的对象.
        if (obj) count = 1;
        for (var i = 0; i < count; i++) {

            var objSpan = obj;
            if (!objSpan) {
                objSpan = objSpans[i];
            }
            with (objSpan) {
                var validatorfor = getAttribute("validatorfor");

                if (validatorfor == null || validatorfor == "")
                    continue;
                //判断对象是否存在
                if (!document.getElementById(validatorfor) && !document.getElementsByName(validatorfor))
                    continue;

                //判断对象为readonly是不验证
                //if(document.getElementById(validatorfor).readOnly)
                //   continue;

                var validateType = getAttribute("validateType");
                var type = getAttribute("type");

                if (typeof (validateType) == "object" || typeof (this[validateType]) == "undefined")
                    continue;

                //if (formid) {
                //    if (validatorfor.search(new RegExp(formid + "_\\d+")) != 0)
                //        continue;
                //}
                this.clearState(objSpan);

                var value = "";
                if (validateType != "group") {
                    value = document.getElementById(validatorfor).value;

                }

                var required = getAttribute("required") || "false";
                if (required.toLowerCase() == "false" && value == "") {
                    continue;
                    value = value.replace(/^[　*]|[ *]/g, "");
                    value = value.replace(/[　*]|[ *]*$/, "");
                }

                if (validateType.toLowerCase() == "required" && required == "true") {
                    value = value.replace(/^[　*]|[ *]/g, "");
                    value = value.replace(/[　*]|[ *]*$/, ""); //替换全角空格为半角
                }
                validateType = validateType.toLowerCase();
                switch (validateType) {
                    case "idcard":
                    case "date":
                    case "datetime":
                    case "repeat":
                    case "range":
                    case "compare":
                    case "custom":
                    case "group":
                    case "limit":
                    case "limitb":
                    case "safestring":
                    case "match":
                        if (!eval(this[validateType])) {
                            this.addError(validatorfor, getAttribute("msg"));
                        }
                        break;
                    default:
                        if (!this[validateType].test(value)) {
                            this.addError(validatorfor, getAttribute("msg"));
                        }
                        else {
                            if (type == "select" && value == "0") {
                                this.addError(validatorfor, getAttribute("msg"));
                            }
                        }
                        break;
                }
            }
        }

        if (this.ErrorMessage.length > 1) {
            mode = mode || 1;
            if (mode == 1) {
                var message = this.ErrorMessage.join("\r\n");
                //whir.dialog.alert(message, null, "formalert", false);
                alert(message);
                if (this.ErrorItem.length > 1 && this.ErrorItem[1] != undefined) {
                    try {
                        this.ErrorItem[1].focus();
                    } catch (ex) { }
                }
            }

            return false;
        }

        return true;
    },

    isLimit: function (len, min, max) {
        min = min || 0;
        max = max || Number.MAX_VALUE;
        return min <= len && len <= max;
    },

    lenB: function (str) {
        return str.replace(/[^\x00-\xff]/g, "**").length;
    },

    clearState: function (elem) {
        with (elem) {
            if (style.color == "red")
                style.color = "";
            var lastNode = parentNode.childNodes[parentNode.childNodes.length - 1];
            if (lastNode.id == "__ErrorMessagePanel")
                parentNode.removeChild(lastNode);
        }
    },

    addError: function (obj, msg) {
        var item = $("#" + obj);
        if (item.length == 0) item = $("input[name=" + obj + "]");
        this.ErrorItem.push(item[0]);
        this.ErrorMessage[this.ErrorMessage.length] = this.ErrorMessage.length + ". " + msg;
    },

    exec: function (op, reg) {
        return new RegExp(reg, "g").test(op);
    },

    isCompare: function (op1, operator, op2) {
        operator = operator.toLowerCase();
        if (isNaN(op1) || isNaN(op2)) {
            return false;
        }

        op1 = parseFloat(op1);
        op2 = parseFloat(op2);
        switch (operator) {
            case "notequal": //NotEqual
                return (op1 != op2);
            case "greaterthan": //GreaterThan
                return (op1 > op2);
            case "greaterthanequal": //GreaterThanEqual
                return (op1 >= op2);
            case "lessthan": 	//LessThan
                return (op1 < op2);
            case "lessthanequal": //LessThanEqual
                return (op1 <= op2);
            default:
                return (op1 == op2);
        }
    },

    isMatch: function (op1, operator, op2) {
        operator = operator.toLowerCase();
        alert(op1); alert(op2);
        switch (operator) {
            case "notcontain": 		//不包含 
                return op1.indexOf(op2) == -1;
            case "beginwith": 		//匹配开头
                return op1.indexOf(op2) == 0;
            case "notbeginwith": 	//不匹配开头
                return op1.indexOf(op2) != 0;
            case "endwith": 			//匹配结尾
                return op1.lastIndexOf(op2) == (op1.length - op2.length);
            case "notendwith": 	//不匹配结尾
                return op1.lastIndexOf(op2) != (op1.length - op2.length);
            default: 					//contain 包含 
                return op1.indexOf(op2) != -1;
        }
    },

    mustChecked: function (name, min, max) {
        var arr = name.split(":");
        var groupName = arr[0];
        var groups = getItems(groupName);
        var hasChecked = 0;
        min = min || 1;
        max = max || groups.length;

        for (var i = groups.length - 1; i >= 0; i--)
            if (groups[i].checked) hasChecked++;

        return min <= hasChecked && hasChecked <= max;

        function getItems(groupName) {
            var items = new Array();
            var arr = document.getElementsByTagName("input");
            for (var i = 0; i < arr.length; i++) {
                if (arr[i].type == "checkbox" || arr[i].type == "radio") {
                    if (arr[i].name.indexOf(groupName) != -1) {
                        items.push(arr[i]);
                    }
                }
            }
            return items;
        }
    },

    isIdCard: function (number) {
        var date, Ai;
        var verify = "10x98765432";
        var Wi = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2];
        var area = ['', '', '', '', '', '', '', '', '', '', '', '北京', '天津', '河北', '山西', '内蒙古', '', '', '', '', '', '辽宁', '吉林', '黑龙江', '', '', '', '', '', '', '', '上海', '江苏', '浙江', '安微', '福建', '江西', '山东', '', '', '', '河南', '湖北', '湖南', '广东', '广西', '海南', '', '', '', '重庆', '四川', '贵州', '云南', '西藏', '', '', '', '', '', '', '陕西', '甘肃', '青海', '宁夏', '新疆', '', '', '', '', '', '台湾', '', '', '', '', '', '', '', '', '', '香港', '澳门', '', '', '', '', '', '', '', '', '国外'];
        var re = number.match(/^(\d{2})\d{4}(((\d{2})(\d{2})(\d{2})(\d{3}))|((\d{4})(\d{2})(\d{2})(\d{3}[x\d])))$/i);
        if (re == null) return false;
        if (re[1] >= area.length || area[re[1]] == "") return false;
        if (re[2].length == 12) {
            Ai = number.substr(0, 17);
            date = [re[9], re[10], re[11]].join("-");
        }
        else {
            Ai = number.substr(0, 6) + "19" + number.substr(6);
            date = ["19" + re[4], re[5], re[6]].join("-");
        }
        if (!this.isDate(date, "ymd")) return false;
        var sum = 0;
        for (var i = 0; i <= 16; i++) {
            sum += Ai.charAt(i) * Wi[i];
        }
        Ai += verify.charAt(sum % 11);
        return (number.length == 15 || number.length == 18 && number == Ai);
    },

    isDate: function (op, formatString) {
        formatString = formatString || "ymd";
        var m, year, month, day;

        switch (formatString) {
            case "ymd":
                m = op.match(new RegExp("^\\s*((\\d{4})|(\\d{2}))([-./])(\\d{1,2})\\4(\\d{1,2})\\s*$"));
                if (m == null)
                    return false;
                day = m[6];
                month = m[5];
                year = (m[2].length == 4) ? m[2] : GetFullYear(parseInt(m[3], 10));
                break;
            case "dmy":
                m = op.match(new RegExp("^\\s*(\\d{1,2})([-./])(\\d{1,2})\\2((\\d{4})|(\\d{2}))\\s*$"));
                if (m == null)
                    return false;
                day = m[1];
                month = m[3];
                year = (m[5].length == 4) ? m[5] : GetFullYear(parseInt(m[6], 10));
                break;
            default:
                break;
        }
        month--;
        var date = new Date(year, month, day);
        return (typeof (date) == "object" && year == date.getFullYear() && month == date.getMonth() && day == date.getDate());

        function GetFullYear(y) {
            return ((y < 30 ? "20" : "19") + y) | 0;
        }
    },

    isDateTime: function (op) {
        var m, year, month, day;

        m = op.match(/^(\d{0,4})-(\d{0,2})-(\d{0,2}) (\d{0,2}):(\d{0,2}):(\d{0,2})$/);
        if (m == null)
            return false;
        day = m[3];
        month = m[2];
        year = (m[1].length == 4) ? m[1] : GetFullYear(parseInt(m[2], 10));
        month--;
        var date = new Date(year, month, day);
        return (typeof (date) == "object" && year == date.getFullYear() && month == date.getMonth() && day == date.getDate());

        function GetFullYear(y) {
            return ((y < 30 ? "20" : "19") + y) | 0;
        }
    }
}

//表单提交
SiRui.FormSubmit = {
    /*
    异步表单提交方法
    formid：表单ID
    type：传参类型
    url：提交处理页面，默认（aspx/AjaxPost.aspx）
    formbtn：提交按钮ID，默认（formbtn）
    formloading：提交时显示加载的divID，默认（formloading）
    */
    AjaxSubmit: function (formid, type, url, formbtn, formloading) {
        //验证表单
        if (!SiRui.FormValidator.validate(formid)) {
            return false;
        }
        url = url || "aspx/AjaxPost.aspx";

        formbtn = formbtn || "formbtn";
        formloading = formloading || "formloading";

        $("#" + formid).ajaxSubmit({
            type: "Post",
            url: SitePath + url + "?act=" + type,
            beforeSend: function () {
                $("#" + formbtn).hide();
                $("#" + formloading).show();
            },
            success: function (o) {
                try {
                    var o = eval('(' + o + ')');
                    if (o.type == "0") {
                        alert(o.msg);
                        $("#" + formbtn).show();
                        $("#" + formloading).hide();
                        //刷新验证码
                        if ($("#imgcode")[0]) {
                            $("#imgcode").click();
                        }
                    }
                    else if (o.type == "1") { //刷新当前页
                        alert(o.msg);
                        window.location.href = document.URL;
                    }
                    else if (o.type == "2") { //跳转页
                        alert(o.msg);
                        window.location.href = o.val;
                    }
                } catch (e) {
                }
            },
            error: function () {
                alert("ajax error is happen");
                window.location.href = document.URL;
            }
        });
    },
    /*
    异步提交方法
    usernameid：用户名ID
    passwordid：密码ID
    codeid：验证码ID
    */
    AjaxLogin: function (usernameid, passwordid, codeid, returnurlid, url, formbtn, formloading) {
        //验证表单
        var username = $("#" + usernameid).val();
        var password = $("#" + passwordid).val();
        var code = $("#" + codeid).val();
        var returnurl = ""; //返回url

        if (returnurlid)
            returnurl = $("#" + returnurlid).val();

        if (username.length == 0) {
            alert("请输入用户名！");
            $("#" + usernameid).focus();
            return false;
        }
        if (password.length == 0) {
            alert("请输入密码！");
            $("#" + passwordid).focus();
            return false;
        }
        if (code.length == 0) {
            alert("请输入验证码！");
            $("#" + codeid).focus();
            return false;
        }

        url = url || "member/AjaxMember.aspx";
        formbtn = formbtn || "formbtn";
        formloading = formloading || "formloading";

        $.ajax({
            type: "Post",
            url: SitePath + url + "?act=login",
            data: "username=" + username + "&password=" + password + "&code=" + code + "&returnurl=" + returnurl,
            beforeSend: function () {
                $("#" + formbtn).hide();
                $("#" + formloading).show();
            },
            success: function (o) {
                try {
                    var o = eval('(' + o + ')');
                    if (o.type == "0") {
                        alert(o.msg);
                        $("#" + formbtn).show();
                        $("#" + formloading).hide();
                        //刷新验证码
                        if ($("#imgcode")[0]) {
                            $("#imgcode").click();
                        }
                    }
                    else if (o.type == "1") { //刷新当前页
                        alert(o.msg);
                        window.location.href = document.URL;
                    }
                    else if (o.type == "2") { //跳转页
                        alert(o.msg);
                        window.location.href = o.val;
                    }
                    else if (o.type == "3") { //不提示跳转页
                        window.location.href = o.val;
                    }
                } catch (e) {
                }
            },
            error: function () {
                alert("ajax error is happen");
                window.location.href = document.URL;
            }
        });
    } 
}
var upload_layer;
//文件上传
SiRui.UploadFile = {
    /*
    打开上传图片层
    usernameid：用户名ID
    */
    OpenUploadPop: function () {
        var htmlStr = "<div class=\"pop_upload\"><form enctype=\"multipart/form-data\" name=\"UploadForm\" id=\"UploadForm\"><p><input id=\"filename\" type=\"file\" size=\"45\" name=\"filename\" class=\"input\"></p><p>注：只能上传jpg、gif、png格式图片，文件的大小不超过300K，建议图片比例为：宽700px &times; 高406px。</p>";
        htmlStr += "<div class=\"btndiv\"><a href=\"javascript:;\" class=\"btn_upload\" onclick=\"SiRui.UploadFile.UploadPic('filename','UploadForm');\">上传</a></div></form></div>"
        upload_layer = $.layer({
            type: 1,
            title: '上传图片',
            offset: [($(window).height() - 160) / 2 + 'px', ''],
            border: [5, 0.5, '#666'],
            area: ['320px', '160px'],
            shadeClose: false,
            //shade: [0],
            page: { html: htmlStr }
        });
    },
    /*
    上传图片
    */
    UploadPic: function (objid,formid) {
        //alert(objid);
        var filepath = $("#" + objid).val();
        if (filepath == "") {
            alert("请选择上传的图片！");
            $("#" + objid).focus();
            return;
        }

        if (!SiRui.FormValidator.picture.test(filepath)) {
            alert("上传图片格式不正确，只能上传jpg、gif、png格式图片！");
            $("#" + objid).focus();
            return;
        }
        var url = SitePath + "member/AjaxUpload.aspx?act=pic"
        var loadi;
        $("#" + formid).ajaxSubmit({
            type: "Post",
            url: url,
            beforeSend: function () {
                loadi = layer.load('上传中，请稍候…');
            },
            success: function (o) {
                layer.close(loadi);
                try {
                    var o = eval('(' + o + ')');
                    if (o.type == "1") {
                        layer.close(upload_layer);
                        //layer.msg('上传成功', 2, -1);
                        //显示上传图片
                        addPic(o.val);
                    }
                    else if (o.type == "0") { //刷新当前页
                        layer.alert(o.msg);
                    }
                } catch (e) {
                    layer.alert('返回数据异常！');
                }
            },
            error: function () {
                layer.close(loadi);
                layer.alert('ajax error is happen');
                //alert("ajax error is happen");
                //window.location.href = document.URL;
            }
        });


    }
}
