<%@page import="java.util.ArrayList"%>
<%@page import="org.bson.Document"%>
<%@page import="com.mongodb.BasicDBObject"%>
<%@page import="com.alibaba.fastjson.JSON"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN" class="nav-no-js">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
        <title>新冠肺炎疫情日报</title> 
        <link rel="shortcut icon" href="image/logo.ico"> 
        <link rel="stylesheet" href="//cdn.staticfile.org/weui/1.1.3/style/weui.min.css"> 
        <link rel="stylesheet" href="https://cdn.staticfile.org/font-awesome/4.7.0/css/font-awesome.css">    

        <script src="js/q.js"></script>   
        <script src="//cdn.staticfile.org/jquery/1.12.0/jquery.min.js"></script>
        <script src="//res.wx.qq.com/open/js/jweixin-1.3.0.js"></script>
        <script src="//res.wx.qq.com/open/libs/weuijs/1.1.4/weui.min.js"></script>   
        <script src="//cdn.staticfile.org/store2/2.10.0/store2.min.js"></script>
        <script src="//cdn.staticfile.org/moment.js/2.1.0/moment.min.js"></script> 
        <script src="//cdn.staticfile.org/moment.js/2.1.0/lang/zh-cn.min.js"></script>  
        <script src="js/org.dbcloud.mongodb.Collections.js"></script>                          
        <script src="./js/com.csmake.sms.js"></script>
        <style >
            .weui-bar__item_on i, .weui-bar__item_on .weui-tabbar__label{
                color:#01bec9;
            }
            .weui-tabbar__item i{
                font-size: 24px;
            } 
            .weui-tabbar__circle{
                display: inline-block;position: relative; top:-2px; font-size:14px;padding:5px; line-height: 32px; height:32px;width:32px; color: #999; border: 1px solid #fff; background:#eee; border-radius: 100px;text-align: center; align-content: center; 
            }
            .weui-bar__item_on .weui-tabbar__circle{
                color:#fff;
                background: #01bec9;
            }
            .weui-btn_primary {
                background-color: #01bec9;
            }
            .weui-cells_checkbox .weui-check:checked+.weui-icon-checked:before {
                content: '\EA06';
                color: #01bec9;
            }
            #tjb-content li{ 
                margin: 15px auto 10px auto ;
            }
            #tjb-content li i{ 
                margin: 5px 5% ;
                font-size: 26px;
                font-weight: 300;
            }
            .weui-cells__title{
                color: #01bec9;
            }
            .lesson{                
                color:#01bec9;width:100%; text-align: center;min-height: 60px;border-bottom: 1px solid #01bec9;border-top: 1px solid #01bec9;margin: 30px 0;background: #eee;
            }
            .overtime{
                background: rgba(0,0,0,0.1);
            }
            .toolbox{ 
                font-size: 12px;
            }
            .weui-tag{
                display: inline-block;
                padding: .15em .4em;
                min-width: 8px;
                border-radius: 18px;
                background-color: #eee;
                color: #777;
                line-height: 1.2;
                text-align: center;
                font-size: 10px;
                vertical-align: middle;
            }
            .red{
                color:#E64340;
                border-color: #E64340;
            }            
            .selected{
                color:white;
                background-color: #01bec9;
            }

            .subject_title{                 
            }

            a{color:#01bec9}

            .Virus_1-1-42_4-qH5u {
                color: #fff;
                position: relative;
                background-size: cover;
                padding: 0;
                height: 220px;
                margin-bottom: -.625rem;
                background-color: #01bec9;        
                background-image: url(//mms-res.cdn.bcebos.com/mms-res/voicefe/captain/mola/Virus/1.1.42/assets/bg-header.4b3059a.png);
            }
            .Virus_1-1-42_19YIBv {
                position: absolute;
                top: 20px;
                left: 0;
                width: 80%;
                height: 28px;
            }
            .Virus_1-1-42_2jitsm {
                position: absolute;
                top: 4px;
                left: 1rem;
                height: 20px;
                width: 100%; 
                background-size: 100% 100%;
            }
            .Virus_1-1-42_G4gAvs {
                position: absolute;
                top: 0;
                right: 17px;
                display: inline-block;
                min-width: 60px;
                height: 28px;
                padding: 0 10px;
                line-height: 28px;
                opacity: .76;
                background: #e5feff;
                border-radius: 51px;
                text-align: center;
                font-size: 14px;
                color: #104345;
            }
            .Virus_1-1-42_2WPS7j {
                display: inline-block;
                width: 10px;
                height: 10px;
                background-image: url(//mms-res.cdn.bcebos.com/mms-res/voicefe/captain/mola/Virus/1.1.42/assets/arrow-expand.62b1a23.svg);
                background-size: contain;
                background-repeat: no-repeat;
                margin-left: 5px;
            }
            .Virus_1-1-42_2SChD4 {
                font-weight: 400;
                font-size: .9375rem;
                height: .9375rem;
                line-height: .9375rem;
                margin-top: 76px;
                margin-left: 17px;
                padding: .375rem .75rem;
                display: inline-block;
                background: #0994a7;
                border-radius: .84375rem;
                font-weight: 700;
            }
            .Virus_1-1-42_1pqQwD {
                margin-top: 8px;
                padding-left: 17px;
                font-size: 1.5rem;
                height: 1.5rem;
                max-width: 100%;
                line-height: 1.5rem;
                white-space: nowrap;
                font-weight: 700;
            }
            .menu-button{
                color:#104345;margin: auto 5px;background-color: rgba(255,255,255,0.5); border-radius: 5px;padding: 5px; font-size: 12px;
            }
            .userlist{
                background:#0994a7;
                color:#fff;
                font-size:14px;
                padding: 5px;
            }
            .weui-badge-btn{
                display: inline-block;
                padding: .15em .4em;
                min-width: 8px;
                border-radius: 5px;
                background-color: #01bec9;
                color: #fff;
                line-height: 1.2;
                text-align: center;
                font-size: 12px;
                vertical-align: middle;
            } 
            .highlight:before{
                content: "必填";
                color: red;
                font-weight: 300;
                font-size: 12px;
                position: absolute;
                right:10px; 
            }
            .admin:before{
                content: "\f007";
                display: inline-block; 
                margin-right: 5px;
                font: normal normal normal 14px/1 FontAwesome;
                font-size: inherit;
                text-rendering: auto;
                -webkit-font-smoothing: antialiased;
            }            
            .super:before{
                content: "\f0c0";
                margin-right: 5px;
                display: inline-block; 
                font: normal normal normal 14px/1 FontAwesome;
                font-size: inherit;
                text-rendering: auto;
                -webkit-font-smoothing: antialiased;
            }
        </style> 
        <%
            Document appcfg = new Document("name", "统计帮");
            ArrayList<Document> list = org.dbcloud.mongodb.Collections.Singleton().find("company", new Document(), new Document("sort", new Document("createTime", -1)).append("projection", new Document("name", true)));
            if (list != null) {
                out.println("<script>");
                out.print("window.companys=");
                out.println(JSON.toJSONString(list));
                out.println(";</script>");
            }
        %>
    </head>
    <body ontouchstart>           
        <div class="weui-footer_fixed-bottom" style="z-index:100;bottom: 0px; border-bottom: 2px solid #f7f7fa;">  
            <div class="weui-tabbar"  id="tabbar"  >
                <a href="#home" class="weui-tabbar__item admin" >
                    <span style="display: inline-block;position: relative;">
                        <i class="fa fa-home"  ></i>
                        <span class="weui-badge" style="display: none; position: absolute;top: -2px;right: -13px;"></span>
                    </span>
                    <p class="weui-tabbar__label">主页</p>
                </a>        
                <a href="#amb" class="weui-tabbar__item admin" >
                    <i class="fa fa-slideshare"  ></i>
                    <p class="weui-tabbar__label">大使</p>
                </a>      
                <a href="#mgr" class="weui-tabbar__item admin" >
                    <i class="fa fa-dashboard"  ></i>
                    <p class="weui-tabbar__label">注册</p>
                </a> 
            </div> 
        </div> 
        <div class="container" id="container">          
            <div class="page">                    
                <header class="Virus_1-1-42_4-qH5u">
                    <div class="Virus_1-1-42_19YIBv">
                        <div class="Virus_1-1-42_2jitsm company" ><%out.print(appcfg.get("name"));%></div> 
                        <span class="Virus_1-1-42_G4gAvs today"  >企业版</span>
                    </div><h3 class="Virus_1-1-42_2SChD4">新型冠状病毒肺炎</h3>
                    <h1 class="Virus_1-1-42_1pqQwD"><span id="tjbtitle"></span></h1>
                    <div style="margin-top:10px; padding: 5px; font-size: 16px; color: #fff; background-color: rgb(200,200,200,0.3);">
                        <div style="display:inline;"><span class="date" style="margin-left:10px;" >今日</span></div> <div style='float:right;'>企业疫情日报系统</div>
                    </div>
                    <marquee style="font-size:1rem;width:100%;" id="ads">新冠肆虐，共渡时艰，及时汇报，以尽绵力，1000个免费注册账号，先到先得</marquee>
                </header>

                <div class="page__bd " style="margin-bottom:100px;" > 
                    <div class="weui-cells__tips" style="margin:50px auto; text-align: center;"><div class="weui-btn weui-btn_primary weui-btn_mini" onclick="tryCreate($(this).closest('.page'))">我要创建填报单位</div></div>
                </div>
                <div class="weui-footer page__ft" style="margin:100px 0;">
                    <p class="weui-footer__links">
                        <a href="javascript:void(0);" class="weui-footer__link"><span class='company'>清华软件创新创业联盟开发与支持</a> 
                    </p> 
                    <p class="weui-footer__links">
                        <a href="<% out.print(appcfg.getOrDefault("supporturl", "https://csmake.com"));%>" class="weui-footer__link" style="font-size: 12px;"><span class='support'><% out.print(appcfg.getOrDefault("support", "统计帮"));%></span>&nbsp;疫情日报企业版</a> 
                    </p>  
                </div>
            </div>                    
        </div>
    </div>   
    <script>

        function getQueryString(name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
            var r = window.location.search.substr(1).match(reg);
            if (r != null)
                return decodeURIComponent(r[2]);
            return "";
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
                                    weui.alert("模拟短信:" + res.vcode);
                                } else {
                                    weui.alert("已发送到手机");
                                }
                            } else {
                                weui.alert(res.Message || '操作失败!');
                            }
                        }}, getQueryString("support") || "赛思美科", phone, 4);
                });
            } else {
                weui.alert("请输入正确的手机号");
            }
        }
        function dbhelp(callback, args1) {
            if (window.db) {
                callback(window.db);
            } else {
                window.db = new org.dbcloud.mongodb.Collections({done: function (db) {
                        callback(db);
                    }});
            }
        }
        function checkphone(input, okdo) {
            var name = input.val().trim();
            if (name.length == 11) {
                dbhelp(function (db) {
                    db.find({done: function (list) {
                            if (list.length > 0) {
                                weui.alert("手机号已经使用:" + list[0].name);
                            } else {
                                if (typeof okdo === 'function')
                                    okdo(name);
                            }
                        }, fail: function (e) {
                            weui.alert(e.message);
                        }}, "company", {phone: name});
                });
            } else {
                weui.alert("手机号不正确");
            }
        }

        function checkcompany(input, okdo) {
            var name = input.val().trim();
            console.log(name);
            if (name.length >= 4) {
                dbhelp(function (db) {
                    db.find({done: function (list) {
                            if (list.length > 0) {
                                weui.alert("已经存在:" + list[0].name);
                            } else {
                                if (typeof okdo === 'function')
                                    okdo(name);
                            }
                        }, fail: function (e) {
                            weui.alert(e.message);
                        }}, "company", {name: {'$regex': name}});
                });
            } else {
                weui.alert("单位名称太短");
            }
        }
        function checkvcode(input, okdo) {
            var vcode = input.val().trim();
            if (!window.vcodeid) {
                weui.alert("请先获取验证码");
                return;
            }
            if (vcode.length != 4) {
                weui.alert("请输入4位验证码");
                return;
            }
            smshelp(function (api) {
                api.check({done: function (ret) {
                        if (ret) {
                            if (typeof okdo === 'function')
                                okdo(vcode);
                        } else {
                            weui.alert("验证码不正确");
                        }
                    }, fail: function (e) {
                        weui.alert(e.message);
                    }}, window.vcodeid, vcode);
            });
        }

        function tryCreate(last) {
            if (window.timer) {
                clearInterval(window.timer);
                window.timer = false;
            }
            last.remove();
            $("#create").show();
        }

        function createsubmit() {
            var support = getQueryString("support");
            var supporturl = getQueryString("supporturl");
            var supporttype = getQueryString("supporttype");
            if (support.length < 1) {
                support = "统计帮";
            }
            if (supporttype.length < 1) {
                supporttype = "技术支持";
            }
            if (supporturl.length < 1) {
                supporturl = "http://www.csmake.com";
            }
            var admin = $("input[name='admin']").val().trim();
            if (admin.length < 2) {
                weui.alert("管理员需要实名");
                return;
            }
            var max = parseInt($("input[name='max']").val().trim());
            checkphone($("input[name='phone']"), function (phone) {
                checkcompany($("input[name='name']"), function (name) {
                    checkvcode($("input[name='vcode']"), function (vcode) {
                        dbhelp(function (db) {
                            db.count({done: function (id) {
                                    var suffix = id.toString();
                                    var template = {"subjects": [{"subtitle": "湖北，武汉", "requried": true, "calc": true, "type": "radio", "title": "本人最近2周是否前往疫区", "items": [{"label": "前往疫区"}, {"label": "未前往疫区"}], "key": "L180775250"}, {"subtitle": "如实申报", "requried": true, "calc": true, "type": "checkbox", "title": "本人感染情况", "items": [{"label": "未感染"}, {"label": "感冒"}, {"label": "疑似"}, {"label": "确诊"}], "key": "L1856277198"}, {"subtitle": "湖北，武汉", "requried": true, "calc": true, "type": "radio", "title": "家属2周内是否前往疫区", "items": [{"label": "前往疫区"}, {"label": "未前往疫区"}], "key": "L992133760"}, {"subtitle": "如实申报", "requried": true, "calc": true, "type": "radio", "title": "家属感染情况", "items": [{"label": "未感染"}, {"label": "感冒"}, {"label": "疑似"}, {"label": "确诊"}], "key": "L1024892276"}, {"subtitle": "不确定时，请先填写，后面在修改", "requried": true, "calc": true, "type": "date", "title": "返程时间", "key": "L1127776693"}, {"subtitle": "身在何处，填写格式: 省.市.县", "requried": true, "calc": false, "type": "text", "title": "现在何处?", "key": "L2028852904"}, {"subtitle": "摄氏度", "requried": true, "calc": true, "type": "number", "title": "今日体温", "key": "L626609873"}, {"subtitle": "", "requried": false, "calc": false, "type": "text", "title": "其它情况说明", "key": "L951601271"}], "title": "疫情统计央企精简版"};
                                    var doc = {id: suffix, ver: "2.0", admin: admin, phone: phone, name: name, vcode: vcode, max: max, suffix: suffix, support: support, supporturl: supporturl, supporttype: supporttype, phoneVerify: true, usertable: "user" + suffix, diarytable: 'diary' + suffix, template: template, createTime: new Date().getTime()};
                                    console.log(doc);
                                    db.insertOne({done: function (_id) {
                                            if (_id) {
                                                var user = {"pid": suffix, "company": name, "department": $("input[name='department']").val(), "name": admin, "phone": phone, "admin": "super"};
                                                //创建超级用户
                                                db.findOneAndUpdate({done: function (user) {
                                                        if (user._id) {
                                                            weui.alert("恭喜你：" + name + "创建成功");
                                                            store.set("user-tjb", user);
                                                            window.location.href = doc.ver + ".jsp?state=" + id;
                                                        }
                                                    }, fail: function (e) {
                                                        weui.alert(e.message);
                                                    }}, "user" + suffix, {"name": admin, "phone": phone}, {"$set": user}, {upsert: true});
                                            } else {
                                                weui.alert("创建失败");
                                            }
                                        }, fail: function (e) {
                                            weui.alert(e.message);
                                        }}, "company", doc);
                                }, fail: function (e) {
                                    weui.alert(e.message);
                                }}, "company");
                        });
                    });
                });
            });
        }


        function ambsubmit() {
            var url = $("input[name='url']").val() || "http://www.csmake.com";
            var name = $("input[name='name']").val().trim();
            if (name.length < 2) {
                weui.alert("需要填写公司名称");
                return;
            }
            var admin = $("input[name='admin']").val().trim();
            if (admin.length < 2) {
                weui.alert("联系人需要实名");
                return;
            }
            var type = $("input[name='type']:checked").val() || "";
            var phone = $("input[name='phone']").val();
            checkvcode($("input[name='vcode']"), function (vcode) {
                dbhelp(function (db) {
                    var amb = {"name": admin, "phone": phone, "company": name, "url": url, "type": type, "SIEAT": $("input[name='SIEAT']").is(":checked")};
                    db.findOneAndUpdate({done: function (user) {
                            if (user._id) {
                                weui.alert("恭喜你成为云大使");
                                store.set("amb-tjb", user);
                                weui.alert("请将本页分享给你的朋友");
                                window.location.search = "support=" + encodeURIComponent(name) + "&supporturl=" + encodeURIComponent(url) + "&supporttype=" + encodeURIComponent(type);
                            }
                        }, fail: function (e) {
                            weui.alert(e.message);
                        }}, "amb", {"phone": phone}, {"$set": amb}, {upsert: true});
                });
            });
        }

        function dbhelp(callback) {
            if (window.db) {
                callback(window.db);
            } else {
                window.db = new org.dbcloud.mongodb.Collections({done: function (db) {
                        callback(db);
                    }});
            }
        }
        $(document).ready(function () {
            Q.reg('home', function (id) {
                var html = $('script#tpl_home').html();
                $(".container").find(".page__bd").html(html);
            });
            Q.reg('mgr', function (id) {
                var html = $('script#tpl_mgr').html();
                $(".container").find(".page__bd").html(html);
            });
            Q.reg('amb', function (id) {
                var html = $('script#tpl_amb').html();
                $(".container").find(".page__bd").html(html);
            });
            Q.reg('amb_reg', function (id) {
                var html = $('script#tpl_ambreg').html();
                $(".container").find(".page__bd").html(html);
            });


            /* 启动函数 */
            Q.init({
                key: '', /* url里#和url名之间的分割符号 默认为感叹号 */
                index: 'home', /* 首页地址 如果访问到不能访问页面也会跳回此页 */
                pop: function (L, arg) {/* 每次有url变更时都会触发pop回调 */
                    //console.log('pop 当前参数是:', arguments);
                }
            });

            $('#tabbar').on('click', ".weui-tabbar__item", function () {
                var that = $(this);
                that.addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            });

            $(".date").text(moment().format("LL"));
            store.set("login-entry", window.location.href);
            var amb = store.get("amb-tjb");
            if (amb) {
                var search = "support=" + encodeURIComponent(amb.company || "") + "&supporturl=" + encodeURIComponent(amb.url || "") + "&supporttype=" + encodeURIComponent(amb.type || "");
                if (location.search.indexOf(search) === -1) {
                    location.search = search;
                }
                $("#tpl_amb").html("<div style=\"text-align:center;\"><div class=\"Virus_1-1-42_2SChD4\" style=\"color:#fff; margin: 30px;padding: 10px; \">你已是云大师</div><p style='color:#777;text-align:center;margin:10px;'>转发本小程序给你朋友</p></div>");
            }
            if (window.companys && window.companys.length > 0) {
                var str = "";
                for (var i = parseInt(Math.random() * window.companys.length); i < window.companys.length; i++) {
                    str += window.companys[i].name + " ";
                }
                str += "... 正在使用本系统";
                $("marquee").text(str);
            }
        });
    </script>

    <script type="text/html" id="tpl_mgr">                    
        <div class="weui-form"> 
            <div class="weui-form__control-area">
                <div class="weui-cells__group weui-cells__group_form">
                    <div class="weui-cells weui-cells_form">                                
                        <div class="weui-cell weui-cell_active ">
                            <div class="weui-cell__hd"><label class="weui-label">填报单位</label></div>
                            <div class="weui-cell__bd">
                                <input autofocus="" class="weui-input" name='name' type="text" placeholder="请输入单位的官方全称" >
                            </div> 
                        </div>
                        <div class="weui-cell weui-cell_active">
                            <div class="weui-cell__hd"><label class="weui-label">申请用户数</label></div>
                            <div class="weui-cell__bd">
                                <input class="weui-input" type="number" name="max" pattern="[0-9]+" placeholder="请输入本系统使用人数" value="">
                            </div> 
                        </div>
                        <div class="weui-cell weui-cell_active">
                            <div class="weui-cell__hd"><label class="weui-label">管理员</label></div>
                            <div class="weui-cell__bd">
                                <input class="weui-input" type="text" name="admin" placeholder="请输入超级管理员实名" value="">
                            </div> 
                        </div>
                        <div class="weui-cell weui-cell_active">
                            <div class="weui-cell__hd"><label class="weui-label">所属部门</label></div>
                            <div class="weui-cell__bd">
                                <input class="weui-input" type="text" name="department" placeholder="请输入超级管理员部门全称" value="">
                            </div> 
                        </div>
                        <div class="weui-cell weui-cell_active">
                            <div class="weui-cell__hd"><label class="weui-label">手机号</label></div>
                            <div class="weui-cell__bd">
                                <input class="weui-input" type="number" name="phone" pattern="[0-9]{11,11}" onblur='checkphone($(this))'  placeholder="请输入超级管理员手机号" value="">
                            </div> 
                        </div>
                        <div class="weui-cell weui-cell_active weui-cell_vcode">
                            <div class="weui-cell__hd"><label class="weui-label">验证码</label></div>
                            <div class="weui-cell__bd">
                                <input autofocus="" class="weui-input" type="text" pattern="[0-9]*" name="vcode" placeholder="输入4位验证码" maxlength="4">
                            </div>
                            <div class="weui-cell__ft">
                                <button class="weui-btn weui-btn_default weui-vcode-btn" onclick="SendSMS($(this))" >获取验证码</button>                                
                            </div>
                        </div>
                    </div> 
                </div>
            </div>
            <div class="weui-form__tips-area">
                <label id="weuiAgree" for="weuiAgreeCheckbox" class="weui-agree">
                    <input id="weuiAgreeCheckbox" onchange="{
                                $(this).is(':checked') ? $('#createsubmit').removeClass('weui-btn_disabled') : $('#createsubmit').addClass('weui-btn_disabled')
                            }" type="checkbox" class="weui-agree__checkbox"><span class="weui-agree__text">阅读并同意<a href="javascript:void(0);">《相关条款》</a>
                    </span>
                </label>
            </div>
            <div class="weui-form__opr-area">
                <a class="weui-btn weui-btn_primary weui-btn_disabled" id='createsubmit' href="javascript:" style="margin:50px auto;" onclick="createsubmit()">创建账户</a>                
            </div>
            <div class="weui-cells__title" style="text-align:center;">每个账户的数据库表均独立</div>
        </div> 
    </script>


    <script type="text/html" id="tpl_ambreg">                    
        <div class="weui-form" style="padding:10px;">  
            <div class="weui-cells__group weui-cells__group_form">
                <div class="weui-cells weui-cells_form">                                
                    <div class="weui-cell weui-cell_active ">
                        <div class="weui-cell__hd"><label class="weui-label">单位名称</label></div>
                        <div class="weui-cell__bd">
                            <input autofocus="" class="weui-input" name='name' type="text" placeholder="请输入单位全称" >
                        </div> 
                    </div>                                                
                    <div class="weui-cell weui-cell_active ">
                        <div class="weui-cell__hd"><label class="weui-label">官方网站</label></div>
                        <div class="weui-cell__bd">
                            <input autofocus="" class="weui-input" name='url' type="url" placeholder="http://" >
                        </div> 
                    </div>  
                    <div class="weui-cell weui-cell_active ">
                        <div class="weui-cell__hd"><label class="weui-label">联系人</label></div>
                        <div class="weui-cell__bd">
                            <input autofocus="" class="weui-input" name='admin' type="text" placeholder="请输入联系人姓名" >
                        </div> 
                    </div>  
                    <div class="weui-cell weui-cell_active">
                        <div class="weui-cell__hd"><label class="weui-label">手机号</label></div>
                        <div class="weui-cell__bd">
                            <input class="weui-input" type="number" name="phone" pattern="[0-9]{11,11}"  placeholder="请输入联系手机号" value="">
                        </div> 
                    </div>
                    <div class="weui-cell weui-cell_active weui-cell_vcode">
                        <div class="weui-cell__hd"><label class="weui-label">验证码</label></div>
                        <div class="weui-cell__bd">
                            <input autofocus="" class="weui-input" type="text" pattern="[0-9]*" name="vcode" placeholder="输入4位验证码" maxlength="4">
                        </div>
                        <div class="weui-cell__ft">
                            <button class="weui-btn weui-btn_default weui-vcode-btn" onclick="SendSMS($(this))" >获取验证码</button>                                
                        </div>
                    </div> 
                    <div class="weui-loadmore weui-loadmore_line">
                        <span class="weui-loadmore__tips">页面上显示为</span>
                    </div>
                    <div class="weui-cells weui-cells_checkbox">
                        <label class="weui-cell weui-cell_active weui-check__label" for="admin0"><div class="weui-cell__hd"><input type="radio" name="type" class="weui-check" id="admin0" value="推荐使用"><i class="weui-icon-checked"></i></div><div class="weui-cell__bd"><p>推荐使用</p></div>
                        </label>
                        <label class="weui-cell weui-cell_active weui-check__label" for="admin1"><div class="weui-cell__hd"><input type="radio" name="type" class="weui-check" id="admin1" value="技术支持"><i class="weui-icon-checked"></i></div><div class="weui-cell__bd"><p>技术支持</p></div>
                        </label>
                    </div> 
                </div>
            </div>
            <div class="weui-form__tips-area">
                <label id="weuiAgree" for="weuiAgreeCheckbox" class="weui-agree">
                    <input id="weuiAgreeCheckbox" onchange="{
                                $(this).is(':checked') ? $('#ambsubmit').removeClass('weui-btn_disabled') : $('#ambsubmit').addClass('weui-btn_disabled')
                            }
                           " type="checkbox" class="weui-agree__checkbox"><span class="weui-agree__text"> 阅读并同意<a href="javascript:void(0);">《相关条款》</a>
                    </span>
                </label>
                <label id="weuiAgree" for="weuiAgreeCheckbox2" class="weui-agree">
                    <input id="weuiAgreeCheckbox2" name="SIEAT" onchange="" type="checkbox" class="weui-agree__checkbox">
                    <span>申请成为清华软件创新创业联盟成员</span>
                </label>
            </div>
            <div class="weui-form__opr-area" style="margin:50px auto;" >
                <a class="weui-btn weui-btn_primary weui-btn_disabled" id='ambsubmit' href="javascript:" onclick="ambsubmit()">成为云大使</a>                
            </div>
        </div> 
    </script>
    <script type="text/html" id="tpl_home">        
        <div class="weui-search-bar" id="searchBar">
            <form class="weui-search-bar__form" onsubmit="return doSearch();
                  " action="javascript:;"  >
                <div class="weui-search-bar__box">
                    <i class="weui-icon-search"></i>
                    <input type="search" class="weui-search-bar__input" id="searchInput" placeholder="搜索" required="">
                    <a href="javascript:" class="weui-icon-clear" id="searchClear"></a>
                </div>
                <label class="weui-search-bar__label" id="searchText" style="transform-origin: 0px 0px; opacity: 1; transform: scale(1, 1);">
                    <i class="weui-icon-search"></i>
                    <span>搜索企事业单位，政府机构名称</span>
                </label>
            </form>
            <a href="javascript:" class="weui-search-bar__cancel-btn" id="searchCancel">取消</a>
        </div>  
        <div id="searchResult" class="weui-cells" style="min-height:200px">
            <div style="margin:50px;text-align: center;color:#999; font-size: 1rem;">搜索所属单位进入填报系统</div>
        </div>

        <script type="text/javascript" class="searchbar js_show">
            function doSearch() {
                dbhelp(function (db) {
                    db.find({done: function (list) {
                            var html = "";
                            if (list) {
                                for (var i in list) {
                                    var u = list[i];
                                    html += '<a href="' + ((u.ver || "2.0") + ".jsp?state=" + u.id) + '" class="weui-cell weui-cell_access"><div class="weui-cell__hd"><i class="fa fa-qrcode" style="margin-right:5px;" onclick=\" event.stopPropagation();event.preventDefault();return false;\""></i></div><div class="weui-cell__bd">' + (u.name || '') + '</div><div class="weui-cell__ft"></div> </a>';
                                }
                            }
                            store.set("company-html", html);
                            $("#searchResult").html(html);
                        }, fail: function (e) {
                            weui.alert(e.message);
                        }}, "company", {name: {"$regex": $("#searchInput").val()}}, {projection: {name: true, id: true, ver: true}});
                });
                return false;
            }

            $(function () {
                var $searchBar = $('#searchBar'),
                        $searchResult = $('#searchResult'),
                        $searchText = $('#searchText'),
                        $searchInput = $('#searchInput'),
                        $searchClear = $('#searchClear'),
                        $searchCancel = $('#searchCancel');

                function hideSearchResult() {
                    $searchResult.hide();
                    $searchInput.val('');
                }
                function cancelSearch() {
                    hideSearchResult();
                    $searchBar.removeClass('weui-search-bar_focusing');
                    $searchText.show();
                }
                $searchText.on('click', function () {
                    $searchBar.addClass('weui-search-bar_focusing');
                    $searchInput.focus();
                });
                $searchInput
                        .on('blur', function () {
                            if (!this.value.length) {
                                cancelSearch();
                            } else {
                                doSearch();
                            }
                        })
                        .on('input', function () {
                            if (this.value.length) {
                                $searchResult.show();
                            } else {
                                $searchResult.hide();
                            }
                        })
                        ;
                $searchClear.on('click', function () {
                    hideSearchResult();
                    $searchInput.focus();
                });
                $searchCancel.on('click', function () {
                    cancelSearch();
                    $searchInput.blur();
                });

                var html = store.get("company-html");
                if (html) {
                    $searchResult.html(html);
                }
            });
        </script>                
    </script>

    <script type="text/html" id="tpl_amb">

        <div style="min-height:200px ;text-align: center;">
            <div>
                <a class="Virus_1-1-42_2SChD4" style="color:#fff; margin: 30px;padding: 10px;" href="#amb_reg">申请成为云大使，推荐本系统</a>
            </div>        
            <p style="font-weight:500;color:#01bec9;background-color: #efefef; width:100%;">责任与权利</p>
            <p style="text-align:left; font-size:12px;margin: 10px;">1. 你的名字/企业名称将显示在受推荐用户的页面上</p>
            <p style="text-align:left; font-size:12px;margin: 10px;">2. 你需要为客户进行必要的培训和讲解</p>   
            <p style="font-weight:500;color:#01bec9;background-color: #efefef; width:100%;">申请成为清华软件创新创业联盟成员</p>
            <p style="text-align:left; font-size:12px;margin: 10px;">1. 清华校友</p>
            <p style="text-align:left; font-size:12px;margin: 10px;">2. 所在企业高管或合伙人创始人</p>   
            <p style="text-align:left; font-size:12px;margin: 10px;">3. 添加微信 csmake_com 咨询</p>   
        </div>

        <script type="text/javascript" class="searchbar js_show">
            function doSearch() {
                dbhelp(function (db) {
                    db.find({done: function (list) {
                            var html = "";
                            if (list) {
                                for (var i in list) {
                                    var u = list[i];
                                    html += '<a href="' + ((u.ver || "2.0") + ".jsp?state=" + u.id) + '" class="weui-cell weui-cell_access"><div class="weui-cell__hd"><i class="fa fa-qrcode" style="margin-right:5px;" onclick=\" event.stopPropagation();event.preventDefault();return false;\""></i></div><div class="weui-cell__bd">' + (u.name || '') + '</div><div class="weui-cell__ft"></div> </a>';
                                }
                            }
                            store.set("company-html", html);
                            $("#searchResult").html(html);
                        }, fail: function (e) {
                            weui.alert(e.message);
                        }}, "company", {name: {"$regex": $("#searchInput").val()}}, {projection: {name: true, id: true, ver: true}});
                });
                return false;
            }

        </script>                
    </script>

</body>
</html>
