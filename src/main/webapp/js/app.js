/**
 * 北京赛思美科技术有限公司
 */

$(function () {
    function androidInputBugFix() {
        // .container 设置了 overflow 属性, 导致 Android 手机下输入框获取焦点时, 输入法挡住输入框的 bug
        // 相关 issue: https://github.com/weui/weui/issues/15
        // 解决方法:
        // 0. .container 去掉 overflow 属性, 但此 demo 下会引发别的问题
        // 1. 参考 http://stackoverflow.com/questions/23757345/android-does-not-correctly-scroll-on-input-focus-if-not-body-element
        //    Android 手机下, input 或 textarea 元素聚焦时, 主动滚一把
        if (/Android/gi.test(navigator.userAgent)) {
            window.addEventListener('resize', function () {
                if (document.activeElement.tagName == 'INPUT' || document.activeElement.tagName == 'TEXTAREA') {
                    window.setTimeout(function () {
                        document.activeElement.scrollIntoViewIfNeeded();
                    }, 0);
                }
            })
        }
    }

    function init() {
        androidInputBugFix();
    }
    init();
});

function dbhelp(callback, args1) {
    if (window.db) {
        callback(window.db);
    } else {
        window.db = new org.dbcloud.mongodb.Collections({done: function (db) {
                callback(db);
            }});
    }
}

function apihelp(callback) {
    if (window.tjbapi) {
        callback(window.tjbapi);
    } else {
        window.tjbapi = new com.csmake.tjb.api({done: function (api) {
                callback(api);
            }});
    }
}

function smshelp(callback, args1) {
    if (window.sms) {
        callback(window.sms);
    } else {
        new com.csmake.sms({done: function (api) {
                window.sms = api;
                callback(api);
            }});
    }
}

function SendSMS(that) {
    var phone = $("input[name='phone']").val().trim();
    if (/\d{11}/.test(phone) && that.text() === "获取验证码") {
        window.counter = 60;
        window.timer = setInterval(function () {
            if (window.counter-- <= 0) {
                that.text("获取验证码");
                clearInterval(window.timer);
            } else {
                that.text(window.counter + "秒后重新获取");
            }
        }, 1000);
        smshelp(function (sms) {
            sms.sendVerifyCode({done: function (res) {
                    window.vcodeid = res.id;
                    console.log(res);
                    if (res.Code === "OK") {
                        if (res.vcode) {
                            weui.alert("模拟短信:"+res.vcode);
                        } else {
                            weui.alert("已发送到手机");
                        }
                    } else {
                        alert(res.Message || '操作失败!');
                    }
                }}, window.appcfg.support || "", phone, 4);
        });
    } else {
        weui.alert("请输入正确的手机号");
    }
}

var fieldOptions = {
    "id": "编号/职工号",
    "name": "姓名",
    "sex": "性别",
    "phone": "手机号",
    "cid": "身份证号",
    "email": "邮件地址",
    "department": "部门",
    "company": "单位",
    "native": "籍贯",
    "admin": "管理员级别",
    "group": "管辖范围(多个用逗号分隔)",
    "address": "居住地址",
    "note": "备注"
};

function uploadinner(table, tid) {
    try {
        var maps = {};
        var tips = "";
        $.each(table.find("select"), function (i, o) {
            o = $(o);
            var v = o.val().trim();
            if (v != '') {
                maps[v] = o.attr("key");
                if (tips.length > 0)
                    tips += ","
                tips += fieldOptions[v];
            }
        });
        console.log(maps);
        if (Object.keys(maps).length < 2) {
            alert("必须指定两个以上字段");
            return;
        } else
        {
            weui.confirm(tips + "字段将被批量更新？", function () {
                var rows = window[tid];
                var data = [];
                for (var i = 0; i < rows.length; i++) {
                    var doc = {};
                    var row = rows[i];
                    for (var k in maps) {
                        if (k === "group") {
                            doc[k] = (row[maps[k]] || '').toString().split(/[\s|,|，]+/g);
                        } else if (k === "admin") {
                            var admin = row[maps[k]] || '';
                            doc[k] = window.user.admin === "super" ? admin : (admin === "super" ? "admin" : admin);
                        } else {
                            doc[k] = (row[maps[k]] || '').toString().trim();
                        }
                    }
                    data.push(doc);
                }
                apihelp(function (api) {
                    api.updateUsers({done: function (count) {
                            weui.toast("更新" + count + "人信息");
                        }, fail: Fail}, window.appcfg.suffix, window.appcfg.id, data);
                });
                console.log(data);
            });
        }
    } catch (e) {
        weui.alert(e.message);
    }
}

function loaduserfile() {

    var optionHtml = "<option value='' selected></option>";
    for (var i in fieldOptions) {
        optionHtml += "<option  value='" + i + "'>" + fieldOptions[i] + "</option>";
    }
    var reader = new FileReader();
    //extend FileReader
    if (!FileReader.prototype.readAsBinaryString) {
        FileReader.prototype.readAsBinaryString = function (fileData) {
            var binary = "";
            var pt = this;
            var reader = new FileReader();
            reader.onload = function (e) {
                var bytes = new Uint8Array(reader.result);
                var length = bytes.byteLength;
                for (var i = 0; i < length; i++) {
                    binary += String.fromCharCode(bytes[i]);
                }
                load(binary);
            }
            reader.readAsArrayBuffer(fileData);
        }
    }
    reader.onload = function (ev) {
        load(ev.target.result);
    };
    function load(data) {
        try {
            workbook = XLSX.read(data, {
                type: 'binary'
            });

            var holder = $("#workbench");
            // 遍历每张表读取
            var now = new Date().getTime();
            var tabHeader = '<div class="row"><ul class="nav nav-tabs col-md-12"  >';
            var tabPage = '<div class="row"><div class="tab-content col-md-12">';
            function createTable(active, index, title, rows) {
                console.log(rows);
                var text = "";
                text += "<div role=\"tabpanel\" style=\"\" class=\"tab-pane " + (active ? "active" : "fade") + "\" id=\"tab-page" + index + "\">                                    ";
                text += "	<div class=\"wrapper\" style=\"text-align: center;margin: 10px; min-height:600px;\">";
                text += " 	<div class=\"box-body\" style='overflow:auto;'>";
                text += "			<h2>" + title + "</h2>";
                text += "			<table id=\"mytable" + index + "\" class=\"table table-bordered table-striped table-hover\" style=\"width:100%;\">";
                text += "				<thead>                        ";
                text += "					<tr>";
                //查找表头，列最多那行为表头
                var header = 0;
                var headrow = 0;
                //生成表头         
                text += "<th></th> ";
                header = rows[headrow];
                var maps = "</tr><tr><th style='font-size:14px;'>》</th>";
                for (var i in header) {
                    text += "<th style='font-size:14px;'>" + i + "</th> ";
                    maps += "<th style='font-size:14px;'><select key='" + i + "'></select></th> ";
                }
                text += maps + "</tr>";
                text += "</thead>";
                text += "<tbody>";
                var list = [];
                console.log(headrow, rows);
                for (var r = 0; r < rows.length; r++) {
                    text += "<tr style='font-size:14px;'>";
                    var row = rows[r];
                    text += "<td>" + (r) + "</td> ";
                    for (var i in header) {
                        text += "<td>" + (row[i] || '') + "</td> ";
                    }
                    text += "</tr>";
                    list.push(row);
                }
                window["mytable" + index] = list;
                text += "				</tbody>";
                text += "			</table>";
                text += "		</div><!-- /.box-body -->";
                text += "		<div class=\"box-footer\"  style='padding-bottom:100px;' >";
                text += "			<div class=\"col-md-5\"></div>";
                text += "			<div class=\"col-md-2 text-center\"><div style='width:100%; margin:100px auto; overflow:hidden;'><div style='width:100%;' onclick=\"uploadinner($(this).closest(\'.tab-pane\').find(\'table\'),'mytable" + index + "\')\" class=\"weui-btn weui-btn_mini weui-btn_primary\">上传</div></div></div> ";
                text += "			<div class=\"col-md-5\"></div>";
                text += "		</div>";
                text += "		<div class=\"box-footer\">";
                text += "			<div class=\"col-md-12\" id=\"error\"></div>";
                text += "			<div class=\"col-md-12\" id=\"redo\"></div>";
                text += "		</div>";
                text += "	</div><!-- ./wrapper -->";
                text += "</div>";
                return text;
            }
            var active = true;
            var tableIndex = 1;
            const sheet2JSONOpts = {
                /** Default value for null/undefined values */
                defval: ''//给defval赋值为空的字符串
            }
            for (var i in workbook.Sheets) {
                if (workbook.Sheets.hasOwnProperty(i)) {
                    var sheet = workbook.Sheets[i];
                    tabPage += createTable(active, tableIndex++, i, XLSX.utils.sheet_to_json(sheet, sheet2JSONOpts));
                    active = false;
                }
            }

            tabHeader += '</ul></div> ';
            tabPage += '</div></div>';
            holder.html(tabHeader + tabPage).css({"margin-bottom": "100px"});
            $.each(holder.find("table"), function (i, obj) {
                initPageTable($(obj));
            });
            function initPageTable(table) {
                table.css({
                    "min-width": "400px"
                });
                table.find("thead th").css({
                    "text-align": "center"
                });
                $.each(table.find("select"),
                        function (i, obj) {
                            $(obj).html(optionHtml).change(function () {
                                var tr = $(this).closest("tr");
                                tr.find("option").show();
                                var selects = tr.find("select");
                                for (var j = 0; j < selects.length; j++) {
                                    var v = selects.eq(j).val();
                                    if (v.length > 0) {
                                        tr.find("option[value='" + v + "']").hide();
                                    }
                                }
                            });
                        });
            }
        } catch (e) {
            alert(e.message);
        }
    }
    // 以二进制方式打开文件
    reader.readAsBinaryString(this.files[0]);
}
function deleteUser(holder, id) {
    weui.confirm("确定要删除" + holder.find(".weui-label").text() + "?", function () {
        dbhelp(function (db) {
            db.deleteOne({done: function (ret) {
                    if (ret.deletedCount > 0) {
                        setTimeout(function () {
                            weui.alert("删除成功");
                        }, 10);
                        holder.remove();
                    } else {
                        setTimeout(function () {
                            weui.alert("删除失败");
                        }, 10);
                    }
                }, fail: Fail}, "user" + appcfg.suffix, {_id: id});
        });
    });
}
function updateProfile(page, upsert) {
    var inputs = page.find(".page__bd input[type!='radio']");
    var admin = page.find(".page__bd input[name='admin']:checked").val();
    var doc = {};
    if (admin && upsert) {
        doc['admin'] = page.find(".page__bd input[name='admin']:checked").val();
    }
    for (var i = 0; i < inputs.length; i++) {
        var input = inputs.eq(i);
        var ck = input.attr("type") === "checkbox";
        var v = ck ? input.is(":checked") : input.val().trim();
        var id = input.attr("name");
        console.log(id, v);
        if (id && id.length > 0 && ((!ck && v.length > 0) || ck)) {
            doc[id] = v;
        }
    }
    delete doc['company'];
    if (window.appcfg.phoneVerify && (doc.phone || '').length != 11) {
        weui.alert("填写正确的手机号");
        return;
    }
    if ((doc.phone || '').length != 11 && (doc.name || '').length < 1) {
        weui.alert("请输入姓名");
        return;
    }

    function update() {
        console.log(doc);
        dbhelp(function (db) {
            doc.pid = appcfg.id;
            db.findOneAndUpdate({done: function (doc) {
                    console.log(doc);
                    if ((doc || {})._id) {
                        toast("已保存");
                        console.log(doc);
                        if (doc._id == window.user._id || !window.user._id) {
                            window.user = doc;
                            store.set("user-tjb", window.user);
                            location.href = "#";
                            setTimeout(function () {
                                window.location.reload();
                            }, 100);
                        }
                    } else {
                        weui.alert("人员信息不在系统中");
                    }
                }}, ("user" + appcfg.suffix), doc.phone ? {phone: doc.phone, "pid": window.appcfg.id} : doc, {"$set": doc}, {"returnNew": true, "upsert": upsert ? true : false});
        });
    }
    if (!upsert && window.appcfg.phoneVerify) {
        var vcode = $("input[name='vcode']").val();
        if (vcode.length != 4) {
            weui.alert("请输入验证码");
            return;
        }
        if (!window.vcodeid) {
            weui.alert("请重新获取验证码");
            return;
        }
        function send() {
            smshelp(function (api) {
                api.check({done: function (ret) {
                        if (ret) {
                            update();
                        } else {
                            weui.alert("验证码不正确");
                        }
                    }, fail: Fail}, window.vcodeid, vcode);
            });
        }
        dbhelp(function (db) {
            db.find({done: function (list) {
                    if (list.length < 1) {
                        alert("联系管理员增加你的手机号");
                        return;
                    }
                    send();
                }, fail: Fail}, "user" + appcfg.suffix, {phone: doc.phone}, {skip: 0, limit: 1});
        });
    } else {
        update();
    }
}

function toast(msg) {
    weui.toast(msg, {duration: 1000});
}

function Fail(e) {
    weui.alert(e.message);
}
