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
        <link rel="stylesheet" href="css/main.css"> 
        <link rel="stylesheet" href="//cdn.staticfile.org/weui/1.1.3/style/weui.min.css"> 
        <link rel="stylesheet" href="https://cdn.staticfile.org/font-awesome/4.7.0/css/font-awesome.css">    
         
        <script src="//cdn.staticfile.org/jquery/1.12.0/jquery.min.js"></script>
        <script src="//res.wx.qq.com/open/js/jweixin-1.3.0.js"></script>
        <script src="//res.wx.qq.com/open/libs/weuijs/1.1.4/weui.min.js"></script>   
        <script src="//cdn.staticfile.org/store.js/1.3.20/store.js"></script>
        <script src="//cdn.staticfile.org/moment.js/2.1.0/moment.min.js"></script> 
        <script src="//cdn.staticfile.org/moment.js/2.1.0/lang/zh-cn.min.js"></script>  

        <script type="text/javascript" src="//cdn.staticfile.org/xlsx/0.15.5/shim.min.js"></script>
        <script type="text/javascript" src="//cdn.staticfile.org/xlsx/0.15.5/xlsx.full.min.js"></script>
        <script type="text/javascript" src="//cdn.staticfile.org/blob-polyfill/1.0.20150320/Blob.min.js"></script>
        <script type="text/javascript" src="//cdn.staticfile.org/FileSaver.js/1.3.8/FileSaver.min.js"></script>
        <script type="text/javascript" src="//cdn.staticfile.org/html2canvas/0.5.0-beta4/html2canvas.min.js"></script> 

        <style>
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
                width: 100%;
                height: 28px;
            }
            .Virus_1-1-42_2jitsm {
                position: absolute;
                top: 4px;
                left: 1rem;
                height: 20px;
                width: 70%; 
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
            .weui-cell input{
                border: 1px #01bec9 solid;
                height: 30px;
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
            String fid = request.getParameter("state");
            if (fid == null || fid == "") {
                fid = "0";
            }
            ArrayList<Document> list = org.dbcloud.mongodb.Collections.Singleton().find("company", new Document("id", fid), new Document("skip", 0).append("limit", 1));
            Document doc = list.size() > 0 ? list.get(0) : null;
            if (doc == null) {
                out.write("上报单位不存在或已关闭");
                return;
            }
            Document appcfg = doc;
            doc.remove("data");//删除具体的数据
            out.println("<script>");
            out.print("window.appcfg=");
            out.println(JSON.toJSONString(doc));
            out.println(";</script>");
        %>
        <script>
            var ua = navigator.userAgent.toLowerCase();
            if (ua.match(/MicroMessenger/i) == "micromessenger") {
                window.inWeChat = true;
                wx.miniProgram.getEnv((res) => {
                    window.inMiniProgram = (res.miniprogram);
                })
            } else {
                window.inWeChat = false;
            }
        </script>
    </head>
    <body ontouchstart style="overflow-x: hidden;margin: 0;">
        <div class="weui-toptips weui-toptips_warn js_tooltips">错误提示</div>     
        <div class="container" id="container">
        </div>    
        <div class="weui-footer_fixed-bottom" style="z-index:100;bottom: 0px; border-bottom: 2px solid #f7f7fa;">  
            <div class="weui-tabbar"  id="tabbar"  >
                <a href="#tjb" class="weui-tabbar__item admin" style="display:none" >
                    <span style="display: inline-block;position: relative;">
                        <i class="fa fa-area-chart"  ></i>
                        <span class="weui-badge" style="display: none; position: absolute;top: -2px;right: -13px;"></span>
                    </span>
                    <p class="weui-tabbar__label">汇总统计</p>
                </a>                 
                <a href="#china" class="weui-tabbar__item">
                    <span style="display: inline-block;position: relative;">
                        <i class="fa fa-globe"  ></i>
                        <span class="weui-badge" style="display: none; position: absolute;top: -2px;right: -13px;"></span>
                    </span>
                    <p class="weui-tabbar__label">全国疫情</p>
                </a> 
                <a href="#home" class="weui-tabbar__item weui-bar__item_on " style="text-align: center; align-content: center; margin: auto;display: inline-block;position: relative;"> 
                    <p class="weui-tabbar__circle" >填</p>
                </a>  
                <a href="#mgr" class="weui-tabbar__item admin" style="display:none" >
                    <i class="fa fa-dashboard"  ></i>
                    <p class="weui-tabbar__label">管理平台</p>
                </a>
                <a href="#me" class="weui-tabbar__item">
                    <i class="fa fa-user"  ></i>
                    <p class="weui-tabbar__label">我的信息</p>
                </a>
            </div> 
        </div> 

        <script type="text/html" id="tpl_users">      
            <div class="page">
                <div class="weui-search-bar" id="searchBar">
                    <form class="weui-search-bar__form" onsubmit="return doSearch();" action="javascript:;"  >
                        <div class="weui-search-bar__box">
                            <i class="weui-icon-search"></i>
                            <input type="search" class="weui-search-bar__input" id="searchInput" placeholder="搜索" required="">
                            <a href="javascript:" class="weui-icon-clear" id="searchClear"></a>
                        </div>
                        <label class="weui-search-bar__label" id="searchText" style="transform-origin: 0px 0px; opacity: 1; transform: scale(1, 1);">
                            <i class="weui-icon-search"></i>
                            <span>搜索姓名，手机号，部门</span>
                        </label>
                    </form>
                    <a href="javascript:" class="weui-search-bar__cancel-btn" id="searchCancel">取消</a>
                </div>  
                <div id="searchResult" class="weui-cells" style="min-height:200px;margin-bottom: 100px;">
                    <div style="margin:50px;text-align: center;color:#999; font-size: 1rem;">无数据</div> 
                </div>
            </div>
            <script type="text/javascript" >
                function searchinner(filter) {
                    apihelp(function (db) {
                        db.fetchUsers({done: function (list) {
                                var html = "";
                                list = list || [];
                                html += '<div class="weui-cell weui-cell_active">'
                                html += '<div class="weui-cell__bd usercount">管辖内的' + (list.length) + '名人员</div>';
                                html += '</div>';
                                if (list.length > 0) {
                                    list.sort(function (param1, param2) {
                                        return (param1.name || "").localeCompare(param2.name, "zh");
                                    });
                                    for (var i = 0; i < list.length; i++) {
                                        var u = list[i];
                                        html += '<div class="weui-cell weui-cell_active"><div class="weui-cell__hd"><a><label class="weui-label ' + (u.admin || '') + ' ">' + (u.name || '') + '</label></a></div><div class="weui-cell__bd"><a>' + (u.department || '') + '</a></div><div class="weui-cell__ft">' + ((u.phone || '').length !== 11 ? "" : '<a class="weui-badge-btn" href="tel:' + (u.phone || '') + '">电话</a><a class="weui-badge-btn" href="sms:' + (u.phone || '') + (IsiPhone() ? '&' : '?') + 'body=【' + (window.appcfg.name || window.appcfg.company || window.user.department) + '】' + (u.name) + '：打扰了，请您尽快完成' + (window.appcfg.template.title || '数据上报') + '。">短信</a>') + '<a href="javascript:;" style="margin:10px;color:red;" onclick="deleteUser20($(this).closest(\'.weui-cell\'),\'' + u._id + '\')" >x<a></div> </div>';
                                    }
                                }
                                store.set("users-html", html);
                                $("#searchResult").html(html);
                            }, fail: Fail}, appcfg.suffix, appcfg.id, window.user.admin === "supper" ? [] : (window.user.group || [window.user.department]), "", "", "");
                    });
                }
                function doSearch() {
                    var input = $("#searchInput").val();
                    var filter = {"$or": [{name: {"$regex": input}}, {phone: {"$regex": input}}, {department: {"$regex": input}}]};
                    searchinner(filter);
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

                    var html = store.get("users-html");
                    if (html) {
                        $searchResult.html(html);
                    }
                    searchinner({});
                });
            </script>                
        </script>

        <script type="text/html" id="tpl_home">
            <div class="page">                    
                <header class="Virus_1-1-42_4-qH5u">
                    <div class="Virus_1-1-42_19YIBv">
                        <div class="Virus_1-1-42_2jitsm company" ><%out.print(appcfg.get("name"));%></div> 
                        <span class="Virus_1-1-42_G4gAvs today"  >第二版</span>
                    </div><h3 class="Virus_1-1-42_2SChD4">新型冠状病毒肺炎</h3>
                    <h1 class="Virus_1-1-42_1pqQwD"><span id="tjbtitle"></span></h1>
                    <div style="margin-top:10px; padding: 5px; font-size: 16px; color: #fff; background-color: rgb(200,200,200,0.3);">
                        <div style="display:inline;"><span class="mydepartment" style="margin-left:10px;" >今日</span> <span class="myname" style='margin-left: 20px;'> </span></div> 
                    </div>
                    <marquee style="font-size:1rem;width:100%;" id="ads">新冠肆虐，共渡时艰，及时汇报，以尽绵力</marquee>
                </header>

                <div class="page__bd " style="margin-bottom:100px;" >
                    <div class="lesson" style=""> 
                        <div style="font-size:12px;margin: 5px;"><span id="diary">上报日期   时  分</span></div>
                    </div>
                    <div class="weui-form" id="template"> 

                    </div>    
                    <div class="weui-form__opr-area" style="padding:20px;" >
                        <div class="weui-cells__title" style="color:red">*每日可多次上报，以最后一次为准</div>
                        <a class="weui-btn weui-btn_primary" href="javascript:submit()">上报</a>
                    </div> 
                </div>
                <div class="weui-footer page__ft" style="margin:100px 0;">
                    <p class="weui-footer__links">
                        <a href="javascript:void(0);" class="weui-footer__link"><span class='company'><% out.print(appcfg.getOrDefault("company", "赛思美科")); %></span>&nbsp;数据所有© 2020年</a> 
                    </p> 
                    <p class="weui-footer__links">
                        <a href="<% out.print(appcfg.getOrDefault("supporturl", "https://csmake.com"));%>" class="weui-footer__link" style="font-size: 12px;"><span class='support'><% out.print(appcfg.getOrDefault("support", "赛思美科"));%></span>&nbsp;<% out.print(appcfg.getOrDefault("supporttype", "技术支持"));%></a> 
                    </p>  
                </div>
            </div> 
            <script>
                function submit() {
                    if (!window.user._id) {
                        toast("请先登录");
                        location.href = "#me";
                        return;
                    }
                    dbhelp(function (db) {
                        var now = new Date().getTime();
                        var diary = {time: now};
                        var subjects = $(".subject");
                        subjects.find(".subject_title").removeClass("red");
                        for (var i = 0; i < subjects.length; i++) {
                            var sbj = subjects.eq(i);
                            if (!sbj.is(":visible")) {
                                continue;
                            }
                            var key = sbj.attr("data-key");
                            var type = sbj.attr("data-type");
                            var requried = sbj.attr("requried") || '';
                            var value;
                            if (type === 'radio') {
                                value = sbj.find("input[name='" + key + "']:checked").val();
                            } else if (type === 'checkbox') {
                                value = [];
                                sbj.find("input[name='" + key + "']:checked").each(function (i, o) {
                                    value.push($(o).val());
                                });
                            } else {
                                value = sbj.find("input[name='" + key + "']").val();
                            }
                            if (requried === "true" && (!value || value.length < 1)) {
                                sbj.find(".subject_title").addClass("red");
                                weui.alert("尚未填写完整");
                                return;
                            }
                            if (value && value.length > 0) {
                                diary[key] = value;
                            }
                        }
                        {//暂存
                            var cache = store.get("input-cache") || {};
                            $.extend(cache, diary);
                            console.log(cache);
                            store.set("input-cache", cache);
                        }
                        var filter = {"date": moment(now).format("YYYYMMDD"), "phone": window.user.phone, pid: appcfg.id, "name": window.user.name || '', "company": window.user.company || '', "department": window.user.department || ''};
                        var table = appcfg.diarytable || ("diary" + appcfg.suffix);
                        db.findOneAndUpdate({done: function (doc) {
                                console.log(doc);
                                if (doc._id) {
                                    toast("上报成功");
                                    store.set("diary" + hashCode(appcfg.template.title), $.extend(filter, diary));
                                    $("#diary").html("最近一次提交<br>" + moment(diary.time).format("MM月DD日 HH:mm"));
                                } else {
                                    toast("上报失败");
                                }
                            }, fail: function (e) {
                                alert('上报失败:' + e.message);
                            }, always: function () {
                            }}, table, filter, {"$set": diary}, {"returnNew": true, "upsert": true});
                    });
                }
                if (window.user) {
                    $(".myname").text(window.user.name);
                    $(".company").text(appcfg.company || appcfg.name);
                }
            </script>
        </div>                         
    </script>

    <script type="text/html" id="tpl_tpl"> 
        <div class="page" >   

            <div class="weui-cells" >
                <div class="weui-cell weui-cell_active"><div class="weui-cell__hd"><a class="weui-btn weui-btn_mini weui-btn_primary" href="javascript:createTemplate()">新建</a></div><div class="weui-cell__bd">模板编辑器</div><div class="weui-cell__ft"><a class="weui-btn weui-btn_mini weui-btn_primary" href="#mgr">返回</a></div></div>                
                <a id="selectTemplate"  href="javascript:;" class="weui-btn weui-btn_primary">选择模板</a> 
            </div> 
            <div id='preview' style="margin-bottom: 50px;"></div>
            <div class="button-sp-area" >
                <a id="addSubject"  href="javascript:;" class="weui-btn weui-btn_primary">添加题目</a>
                <a id="saveSubject" href="javascript:;" class="weui-btn weui-btn_primary">保存为当前模板</a>
                <a id="publishSubject" href="javascript:;" class="weui-btn weui-btn_primary">发布为共享模板</a>
                <div  style="margin-bottom: 100px;"></div>
            </div> 
        </div>
        <script>
            function resetitemnum(holder) {
                holder.find(".itemnum").each(function (i, o) {
                    $(o).text((i + 1) + ".");
                });
            }
            function createTemplate() {
                var template = {title: "新建模板", subjects: [{"subtitle": "题注", "requried": true, "calc": true, "type": "radio", "title": "单选题目", "items": [{"label": "选项1"}, {"label": "选项2"}], "key": "L180775250"}]};
                loadTemplate(template);
            }
            function settoolbox(that) {
                var subject = that.closest(".subject");
                var type = that.attr("data-type");
                var html = '<div class="weui-cell__hd"><span class="weui-tag requried ' + (subject.attr("requried") === 'true' ? 'selected' : '') + '">必填项</span><span class="weui-tag calc ' + (subject.attr("data-calc") === 'true' ? 'selected' : '') + '">统计项</span></div>';
                html += "<div class='weui-cell__bd'>";
                if (type === 'radio' || type === 'checkbox' || type === 'button') {
                    var strs = [{label: '单选', type: 'radio'}, {label: '多选', type: 'checkbox'}, {label: '单选&输入', type: 'button'}];
                    for (var i = 0; i < strs.length; i++) {
                        html += '<span style="margin-right:1px;" data-type="' + (strs[i].type) + '" class=" weui-tag ' + (type === strs[i].type ? 'selected' : '') + '">' + strs[i].label + '</span>';
                    }
                    html += '<span style="margin-right:3px;color:#01bec9;float:right;" class="weui-tag add-item">+</span>';
                    subject.find(".weui-cells .weui-cell .weui-cell__hd").each(function (i, o) {
                        $(o).prepend("<i style='font-size:12px;color:#888;min-width:50px;height:20px;' contentEditable class='fa fa-link'>关联题号</i>");
                    });
                } else {
                    var strs = [{label: '文本', type: 'text'}, {label: '数字', type: 'number'}, {label: '日期', type: 'date'}, {label: '手机号', type: 'phone'}, {label: '邮件', type: 'email'}];
                    for (var i = 0; i < strs.length; i++) {
                        html += '<span style="margin-right:3px;" data-type="' + (strs[i].type) + '" class="weui-tag ' + (type === strs[i].type ? 'selected' : '') + '">' + strs[i].label + '</span>';
                    }
                }
                html += "</div>";
                html += ("<div class='weui-cell__ft'><span class='move-up weui-tag' style='font-size:12px;margin-left:5px;'>↑</span><span class='move-down weui-tag' style='font-size:12px;margin-left:5px;'>↓</span><span class='remove weui-tag' style='color:red;font-size:12px;margin-left:20px;'>x</span></div>");
                that.append(html).on("click", "span[data-type]", function () {
                    var div = $(this).closest('div');
                    var type = $(this).attr("data-type");
                    div.find(".weui-tag").removeClass('selected');
                    $(this).addClass('selected');
                    var input = div.closest(".subject").find("input");
                    input.attr("type", type);
                }).on("click", ".remove", function () {
                    var that = $(this).closest('.subject');
                    weui.confirm("确定删除该命题吗？", function () {
                        that.remove();
                        resetitemnum($(".page"));
                    });
                }).on("click", "span.move-up", function () {
                    var that = $(this).closest(".subject");
                    var prev = that.prev();
                    if (prev.hasClass("subject")) {
                        that.insertBefore(prev);
                        resetitemnum($(".page"));
                    }
                }).on("click", "span.move-down", function () {
                    var that = $(this).closest(".subject");
                    var next = that.next();
                    if (next.hasClass("subject")) {
                        that.insertAfter(next);
                        resetitemnum($(".page"));
                    }
                }).on("click", "span.requried", function () {
                    var sbj = $(this).closest(".subject");
                    $(this).toggleClass("selected");
                    var requried = $(this).hasClass("selected") ? "true" : "false";
                    sbj.attr("requried", requried);
                }).on("click", "span.calc", function () {
                    var sbj = $(this).closest(".subject");
                    $(this).toggleClass("selected");
                    sbj.attr("data-calc", $(this).hasClass("selected") ? "true" : "false");
                }).on("click", ".add-item", function () {
                    var html = "";
                    var id = new Date().getTime();
                    var owner = $(this).closest("[data-key]");
                    var key = owner.attr("data-key") || id;
                    var type = owner.attr("data-type") || "radio";
                    html += '<label class="weui-cell weui-cell_active weui-check__label" for="' + id + '">';
                    html += '<div class="weui-cell__hd">';
                    html += "<i style='font-size:12px;color:#888;min-width:50px;height:20px;' contentEditable class='fa fa-link'>关联题号</i>";
                    html += '<input type="' + type + '" name="' + key + '" class="weui-check" id="' + id + ' value="">';
                    html += '<i class="weui-icon-checked"></i>';
                    html += '</div>';
                    html += '<div class="weui-cell__bd">';
                    html += '<div style="font-size:14px;width:100%;" class="contentEditable" contentEditable >点击此处编辑选项...</div>';
                    html += '</div>';
                    html += '<div class="weui-cell__ft">';
                    html += '<span class=\"weui-tag\" onclick=\"$(this).closest(\'.weui-cell\').remove();\" style=\"color:#555;font-size:12px;margin-left:20px;\">x</span></div>';
                    html += '</div>';
                    html += '</label>';
                    owner.find(".weui-cells_checkbox").append(html);
                });
                subject.find(".highlight").removeClass("highlight");
                subject.find(".contentEditable").each(function (i, o) {
                    $(o).attr("contentEditable", true);
                });
                subject.find("input").each(function (i, o) {
                    $(o).attr("disabled", true);
                });
                subject.find(".weui-check__label .weui-cell__ft").each(function (i, o) {
                    $(o).html('<span class=\"weui-tag\" onclick=\"$(this).closest(\'.weui-cell\').remove();\" style=\"color:#555;font-size:12px;margin-left:20px;\">x</span></div>');
                });
                subject.find(".subject_subtitle .contentEditable").each(function (i, o) {
                    if (($(o).text() || '').length < 1) {
                        $(o).text("点击此处编辑题注...")
                    }
                });
                subject.on("blur", ".fa-link", function () {
                    var that = $(this).closest(".weui-cell__hd");
                    var text = $(this).text() || "";
                    if (text.length > 0) {
                        var links = text.split(/[\s|,|，]+/);
                        $(this).closest(".template").find(".subject").each(function (i, o) {
                            var sbj = $(o);
                            for (var j in links) {
                                if (links[j] == (i + 1)) {
                                    links[j] = sbj.attr("data-key");
                                    break;
                                }
                            }
                            that.attr("data-link", links.join(','));
                        });
                    } else {
                        $(this).text("关联题号");
                    }
                });
                subject.on("click", ".fa-link", function () {
                    if ($(this).text() === "关联题号") {
                        $(this).text("");
                    }
                });
                if (type === 'button') {
                    var items = subject.find("input[data-items]").attr("data-items") || "[]";
                    items = eval("(" + items + ")");
                    var html = "";
                    var id = new Date().getTime();
                    var key = subject.attr("data-key") || id;
                    for (var i in items) {
                        id++;
                        html += '<label class="weui-cell weui-cell_active weui-check__label" for="' + id + '">';
                        html += '<div class="weui-cell__hd" data-link="' + (items[i].link || '') + '">';
                        html += '<i style="font-size:12px;color:#888;min-width:50px;height:20px;" contentEditable class="fa fa-link">关联题号</i>';
                        html += '<input type="radio" name="' + key + '" class="weui-check" id="' + id + ' value="">';
                        html += '<i class="weui-icon-checked"></i>';
                        html += '</div>';
                        html += '<div class="weui-cell__bd">';
                        html += '<div style="font-size:14px;width:100%;" class="contentEditable" contentEditable >' + (items[i].label) + '</div>';
                        html += '</div>';
                        html += '<div class="weui-cell__ft">';
                        html += '<span class=\"weui-tag\" onclick=\"$(this).closest(\'.weui-cell\').remove();\" style=\"color:#555;font-size:12px;margin-left:20px;\">x</span></div>';
                        html += '</div>';
                        html += '</label>';
                    }
                    subject.find(".weui-cells").append(html).addClass("weui-cells_checkbox").find("input[data-items]").closest(".weui-cell").remove();
                }
                return that;
            }
            $("#addSubject").click(function () {
                var items = [{label: '单选', type: "radio"}, {label: '多选', type: "checkbox"}, {label: '单选&录入', type: 'button'}, {label: '文本', type: 'text'}, {label: '手机号', type: 'phone'}, {label: '数字', type: 'number'}, {label: '邮箱', type: 'email'}, {label: '日期', type: 'date'}];
                weui.picker(items, {
                    onConfirm: function (result) {
                        var type = result[0].type || "radio";
                        var key = new Date().getTime();
                        var requried = true;
                        var html = "";
                        html += '<div data-key="' + key + '" requried="' + (requried ? 'true' : 'false') + '\" data-type="' + type + '"  class="subject weui-cells weui-cells_form">';
                        html += '<div class="toolbox weui-cell"  data-type="' + type + '"></div>';
                        html += '<div class="subject_title weui-cells__title"><div class="itemnum" style="margin-right:10px;float:left;"></div><div class="contentEditable">点击此处编辑题目...</div></div>';
                        html += '<div class="subject_subtitle weui-cells__title"><div style="color:#555;font-size:12px;margin-left:20px;" class="contentEditable">点击此处编辑题注...</div></div>';
                        if (type === 'radio' || type === 'checkbox') {
                            html += '<div class="weui-cells weui-cells_checkbox">';
                            var items = [{label: "点击此处编辑选项..."}, {label: "点击此处编辑选项..."}, {label: "点击此处编辑选项..."}];
                            for (var i in items) {
                                var item = items[i];
                                var id = key + "_" + i;
                                var value = item.value || '';
                                html += '<label class="weui-cell weui-cell_active weui-check__label" for="' + id + '">';
                                html += '<div class="weui-cell__hd">';
                                html += '<input type="' + type + '" name="' + key + '" class="weui-check" id="' + id + '" ' + (item.answer ? 'checked' : '') + ' value="' + value + '">';
                                html += '<i class="weui-icon-checked"></i>';
                                html += '</div>';
                                html += '<div class="weui-cell__bd">';
                                html += '<div style="font-size:14px;width:100%;" class="contentEditable" >' + (item.label || '') + '</div>';
                                html += '</div>';
                                html += '<div class="weui-cell__ft"></div></label>';
                            }
                            html += '</div>';
                        } else if (type === 'button') {
                            html += '<div class="weui-cells"><div style="font-size:14px;" class="weui-cell weui-cell_active"><div class="weui-cell__bd"><input name="' + key + '" class="weui-input" data-items=\'' + JSON.stringify(items) + '\' data-title="选项" type="button" placeholder="在此输入..." ></div><div class="weui-cell__ft"><button onclick="$(this).closest(\'.weui-cell\').find(\'input\').attr(\'type\',\'text\');" class="weui-btn weui-btn_primary weui-btn_mini">录入</button></div></div></div>'
                        } else {
                            html += '<div class="weui-cells "><div style="font-size:14px;" class="weui-cell weui-cell_active"><input name="' + key + '" class="weui-input" ' + (requried ? "requried" : "") + ' data-title="选项" type="' + type + '" placeholder="在此输入..." ></div></div>'
                        }
                        html += '</div>';
                        var that = $(html);
                        settoolbox(that.find(".toolbox"));
                        var dlg = $(".template").append(that);
                        resetitemnum(dlg);
                    },
                    title: "选择类型"
                });
            });
            function publishTemplate(dlg) {
                var tpl = {title: dlg.find(".tpl_title").text(), subtitle: dlg.find(".tpl_subtitle").text(), subjects: []};
                dlg.find(".subject").each(function (i, _sbj) {
                    var sbj = $(_sbj);
                    var title = sbj.find(".subject_title .contentEditable").text();
                    var key = "L" + Math.abs(hashCode(title));
                    var subtitle = sbj.find(".subject_subtitle .contentEditable").text();
                    var requried = sbj.attr("requried") === "true";
                    var calc = sbj.attr("data-calc") === "true";
                    var type = sbj.attr("data-type");
                    if (subtitle.indexOf("点击此处编辑") !== -1) {
                        subtitle = "";
                    }
                    var doc = {"key": key, "type": type, "title": title, "subtitle": subtitle, "requried": requried, "calc": calc};
                    if (type === "radio" || type === "checkbox" || type === 'button') {
                        doc.items = [];
                        sbj.find(".weui-check__label .contentEditable").each(function (i, o) {
                            doc.items.push({label: $(o).text(), link: $(o).closest('.weui-cell').find('.weui-cell__hd').attr("data-link") || ""});
                        });
                    }
                    tpl.subjects.push(doc);
                });
                console.log(tpl);
                return tpl;
            }
            $("#saveSubject").click(function () {
                var btn = $(this);
                var btnHtml = btn.addClass("weui-btn_loading").html();
                btn.addClass("weui-btn_loading").html("<i class=\"weui-loading\"></i>上传中...");
                var tpl = publishTemplate($(".template"));
                appcfg.template = tpl;
                dbhelp(function (db) {
                    db.findOneAndUpdate({
                        done: function (doc) {
                            appcfg = doc;
                            console.log(doc);
                        }
                        , fail: function (e) {
                            weui.alert(e.message);
                        }, always: function () {
                            btn.removeClass("weui-btn_loading").html(btnHtml);
                        }}, "company", {_id: appcfg._id}, {"$set": {"template": tpl}}, {returnNew: true});
                });
            });

            $("#publishSubject").click(function () {
                var btn = $(this);
                var btnHtml = btn.addClass("weui-btn_loading").html();
                btn.addClass("weui-btn_loading").html("<i class=\"weui-loading\"></i>发布中...");
                var tpl = publishTemplate($(".template"));
                dbhelp(function (db) {
                    tpl.author = {name: window.user.name, company: window.user.company, id: window.user._id};
                    tpl.time = new Date().getTime();
                    db.findOneAndUpdate({
                        done: function (doc) {
                            console.log(doc);
                            weui.alert("发布成功,感谢你的贡献！");
                        }
                        , fail: function (e) {
                            weui.alert(e.message);
                        }, always: function () {
                            btn.removeClass("weui-btn_loading").html(btnHtml);
                        }}, "template", {id: "T" + Math.abs(hashCode(tpl.title)), uid: window.user._id}, {"$set": tpl}, {returnNew: true, upsert: true});
                });
            });
            $("#selectTemplate").click(function () {
                dbhelp(function (db) {
                    db.find({done: function (list) {
                            if (!list) {
                                weui.alert("无模板");
                                return;
                            }
                            var items = [];
                            for (var i in list) {
                                var o = list[i];
                                items.push({label: o.title + "-" + (o.author.company || o.author.name), value: o})
                            }
                            weui.picker(items, {
                                id: "selectTemplate",
                                onConfirm: function (result) {
                                    loadTemplate(result[0].value);
                                },
                                title: "选择模板"
                            });
                        }, fail: function (e) {
                            weui.alert(e.message);
                        }}, "template", {}, {skip: 0, limit: 100, sort: {time: -1}});
                });
            });
            function loadTemplate(template) {
                if (template) {
                    var page = $("#preview");
                    createPage(template, page);
                    page.find(".toolbox").each(function (i, obj) {
                        var that = $(obj);
                        settoolbox(that);
                    });
                    page.find(".contentEditable").attr("contentEditable", true);
                    page.on("click", "[contentEditable]", function () {
                        var text = $(this).text();
                        if (text.indexOf("点击此处编辑") !== -1) {
                            $(this).text("");
                        }
                    });
                    //更新关联题号
                    page.find("[data-link]").each(function (i, o) {
                        var link = ($(this).attr("data-link") || "").split(/[\s|,]+/g);
                        var str = [];
                        for (var l in link) {
                            str.push(page.find(".subject[data-key='" + (link[l] || "") + "']").find(".itemnum").text().replace(/[.|\s]+/g, ""));
                        }
                        str = str.join(",");
                        if (str.length > 0) {
                            $(o).find(".fa-link").text(str);
                        }
                    });
                }
            }
            loadTemplate(appcfg.template);
        </script>
    </script>
    <script type="text/html" id="tpl_tjb">
        <div class="page" id='tongji'>                            
            <header class="Virus_1-1-42_4-qH5u">
                <div class="Virus_1-1-42_19YIBv">
                    <div class="Virus_1-1-42_2jitsm company" ><%out.print(appcfg.get("name"));%></div> 
                    <span class="Virus_1-1-42_G4gAvs" onclick='updateDataVer20($(this))' >统计刷新</span>
                </div><h3 class="Virus_1-1-42_2SChD4">新型冠状病毒肺炎</h3>
                <h1 class="Virus_1-1-42_1pqQwD"><span id="tjbtitle"></span></h1>
                <div style="margin-top:10px; padding: 5px; font-size: 16px; color: #fff; text-align: center; background-color: rgb(200,200,200,0.3);">
                    <a style="float:left;color:#eee;" href="javascript:nextDateVer20(-1);" >《</a> <div style="display:inline;"><span data-key='date' style="margin-left:10px;" >今日</span></div><a style="color:#eee;float:right" href="javascript:nextDateVer20(1);" >》</a>
                </div>
                <div style='text-align:right;margin:10px;'><a class="menu-button" href="javascript:totalDown();" >下载汇总</a> <a class="menu-button" href="javascript:diaryDown();" >下载明细</a> </div>                
            </header>

            <div class=' page__bd'>
                <div style="margin: 100px auto; text-align: center;"><i class="weui-loading"></i></div>
            </div>  
            <div class="page__ft" style="margin-bottom: 300px;"><div style="height:1px;overflow: hidden;"><table id="mytable" style="width: 100%;max-height: 1px;opacity: 0.01;" ><thead></thead><tbody></tbody> <tfoot> </tfoot></table></div></div>

        </div>  

        <script>
            function updateDataVer20(that) {
                that.html('<i class="weui-loading"></i>刷新统计');
                var date = $("#tongji [data-key='date']").attr("date") || moment().format("YYYYMMDD");
                apihelp(function (api) {
                    api.updateDataVer20({done: function (doc) {
                            //console.log(doc);
                            drawResult($(".page__bd"), date, doc);
                        }, fail: Fail, always: function () {
                            that.html('刷新统计');
                        }}, window.appcfg.suffix || '', window.appcfg.id, date);
                });
            }

            function nextDateVer20(num) {
                var date = $("#tongji [data-key='date']").attr("date");
                date = moment(date, "YYYYMMDD").add(num, 'days').format("YYYYMMDD");
                createResult($(".page__bd"), date);
            }

            function diaryDown() {
                if (!IsPC()) {
                    weui.alert("请在PC上操作");
                    return;
                }
                var subjects = appcfg.template.subjects || [];
                var keys = [];
                var thead = "<tr><th>姓名</th><th>部门</th><th>手机</th>";
                for (var i = 0; i < subjects.length; i++) {
                    var sbj = subjects[i];
                    keys.push(sbj.key);
                    thead += "<th>" + (sbj.title || '') + "</th>";
                }
                thead += "<th>填写时间</th></tr>";
                window.tbkeys = keys;
                $("#mytable thead").html(thead);
                dbhelp(function (db) {
                    var date = $("#tongji [data-key='date']").attr("date") || moment().format("YYYYMMDD");
                    var filter = {date: date};
                    if (window.user.admin !== "super") {
                        if (window.user.group && window.user.group.length > 0) {
                            var or = [];
                            for (var i in window.user.group) {
                                if ((window.user.group[i] || "").trim().length > 0) {
                                    or.push({"department": {"$regex": "^" + window.user.group[i] + ".*"}});
                                }
                            }
                            filter["$or"] = or;
                        } else if ((window.user.department || "").length > 0) {
                            filter.department = window.user.department;
                        } else {
                            weui.alert("缺少部门或管辖范围");
                            return;
                        }
                    }
                    db.find({done: function (list) {
                            if (!list)
                                return;
                            var tbody = "";
                            var userkey = ["name", "department", "phone"];
                            for (var i in list) {
                                var doc = list[i];
                                tbody += "<tr>";
                                for (var k in userkey) {
                                    var key = userkey[k];
                                    tbody += "<td>" + (key === "phone" ? "\u200C" : "") + (doc[key] || '') + "</td>";
                                }
                                for (var k in window.tbkeys) {
                                    var key = window.tbkeys[k];
                                    var value = (doc[key] || '');
                                    tbody += "<td>" + (value.length === 18 ? "\u200C" : "") + value + "</td>";/*身份证号显示问题*/
                                }
                                var time = doc["time"];
                                tbody += "<td>" + (time ? moment(time).format("MM月DD日 HH:mm") : '') + "</td>";
                                tbody += "</tr>";
                            }
                            $("#mytable tbody").html(tbody);
                            var elt = document.getElementById('mytable');
                            var wb = XLSX.utils.table_to_book(elt, {sheet: date});
                            return XLSX.writeFile(wb, (appcfg.template.title + "_" + date + '.xlsx'));
                        }, fail: function (e) {
                            weui.alert(e.message);
                        }}, "diary" + appcfg.suffix, filter);
                });
            }
            /**
             * 在本地进行文件保存
             * @param  {String} data     要保存到本地的图片数据
             * @param  {String} filename 文件名
             */
            var saveFile = function (data, filename) {
                var save_link = document.createElementNS('http://www.w3.org/1999/xhtml', 'a');
                save_link.href = data;
                save_link.target = "_blank";
                save_link.download = filename;

                var event = document.createEvent('MouseEvents');
                event.initMouseEvent('click', true, false, window, 0, 0, 0, 0, 0, false, false, false, false, 0, null);
                save_link.dispatchEvent(event);
            };

            function totalDown() {
                if (!IsPC()) {
                    weui.alert("请在PC上操作");
                    return;
                }
                $("#container").css({height: "3000px", overflow: "visible"});
                $(".page").css("height", "");
                html2canvas(document.querySelector("#container"), {
                    onrendered: function (canvas) {
                        var pageData = canvas.toDataURL('image/jpeg', 1.0);
                        // console.log(pageData) 
                        saveFile(pageData.replace("image/jpeg", "image/octet-stream"), new Date().getTime() + ".jpeg");
                    }});
            }
        </script>
    </script>
    <script src="js/q.js"></script>   
    <script src="js/org.dbcloud.mongodb.Collections.js"></script>                          
    <script src="./js/com.csmake.sms.js"></script>
    <script src="./js/com.csmake.tjb.api.js"></script>   
    <script>
            function logout() {
                weui.alert("注销成功！");
                store.remove("user-tjb");
                store.remove("com-tjb");
                window.user = {};
                window.appcfg = {};
                var url = store.get("login-entry");
                store.remove("login-entry");
                $("input").val("");
                if (url) {
                    location.href = url ? url : 'tjb.jsp';
                } else {
                    location.reload();
                }
            }
            function updateInputLink(items, value) {
                setTimeout(function () {
                    var show = [];
                    var hide = [];
                    for (var i = 0; i < items.length; i++) {
                        var item = items[i];
                        var link = (item.link || "").split(/[,|\s]+/g);
                        var checked = (item.value || item.label) === value;
                        for (var l in link) {
                            var obj = $(".subject[data-key='" + link[l] + "']");
                            (checked) ? show.push(obj) : hide.push(obj);
                        }
                    }
                    for (var i in hide) {
                        hide[i].hide();
                    }
                    for (var i in show) {
                        show[i].show();
                    }
                }, 50);
            }

            function updateLink(that) {
                setTimeout(function () {
                    var show = [];
                    var hide = [];
                    that.each(function (i, o) {
                        var link = ($(o).attr("data-link") || "").split(/[,|\s]+/g);
                        var checked = $(o).find("input").is(":checked");
                        for (var l in link) {
                            var obj = $(".subject[data-key='" + link[l] + "']");
                            (checked) ? show.push(obj) : hide.push(obj);
                        }
                    });
                    for (var i in hide) {
                        hide[i].hide();
                    }
                    for (var i in show) {
                        show[i].show();
                    }
                }, 50);
            }

            function createPage(tpl, holder) {
                var subjects = tpl.subjects || [];
                var html = '<div class="template">';
                html += '<div style="text-align:center;" class="weui-cells__title tpl_title contentEditable">' + (tpl.title || '未命名模板') + '</div>';
                html += '<div style="text-align:center;" class="weui-cells__title tpl_subtitle contentEditable">' + (tpl.subtitle || '') + '</div>';
                for (var s = 0; s < subjects.length; s++) {
                    var subject = subjects[s];
                    var key = subject.key;
                    var calc = subject.calc;
                    var type = subject.type || 'radio';
                    var requried = subject.requried;
                    html += '<div data-calc="' + calc + '" data-key="' + key + '" ' + (requried ? 'requried="true"' : '') + ' data-type="' + type + '"  class="subject weui-cells weui-cells_form">';
                    html += '<div class="toolbox weui-cell" data-type="' + type + '"></div>';
                    html += '<div class="subject_title weui-cells__title" style="' + (requried ? 'font-weight:600;' : '') + '" ><div class="itemnum ' + (requried ? 'highlight' : '') + ' " style="margin-right:10px;float:left;">' + (s + 1) + ".</div><div class='contentEditable'>" + (subject.title || '') + '</div></div>';
                    html += '<div class="subject_subtitle weui-cells__title"><div style="color:#555;font-size:12px;margin-left:20px;" class="contentEditable">' + (subject.subtitle || '') + '</div></div>';
                    var items = subject.items || [];
                    if (type === 'radio' || type === 'checkbox') {
                        html += '<div class="weui-cells weui-cells_checkbox">';
                        for (var i in items) {
                            var item = items[i];
                            var id = key + "_" + i;
                            var value = item.value || item.label;
                            html += '<label class="weui-cell weui-cell_active weui-check__label" for="' + id + '">';
                            html += '<div class="weui-cell__hd" data-link="' + (item.link || '') + '">';
                            html += '<input type="' + type + '" name="' + key + '" class="weui-check" ' + (subject.requried ? "requried" : "") + ' id="' + id + '" ' + (item.answer ? 'checked' : '') + ' value="' + value + '">';
                            html += '<i class="weui-icon-checked"></i>';
                            html += '</div>';
                            html += '<div class="weui-cell__bd">';
                            html += '<div style="font-size:14px;width:100%;" class="contentEditable" >' + (item.label || '') + '</div>';
                            html += '</div>';
                            html += '<div class="weui-cell__ft"></div></label>';
                        }
                        html += '</div>';
                    } else if (type === 'button') {
                        html += '<div class="weui-cells"><div style="font-size:14px;" class="weui-cell weui-cell_active"><div class="weui-cell__bd"><input name="' + key + '" class="weui-input" ' + (subject.requried ? "requried" : "") + '  data-items=\'' + JSON.stringify(subject.items) + '\' data-title="' + (subject.title || '') + '" type="button" placeholder="在此输入..." ></div><div class="weui-cell__ft"></div></div></div>'
                    } else {
                        html += '<div class="weui-cells "><div style="font-size:14px;" class="weui-cell weui-cell_active"><input name="' + key + '" class="weui-input" ' + ((type === "date" && IsPC()) ? "readonly" : "") + (subject.requried ? "requried" : "") + ' data-title="' + (subject.title || '') + '" type="' + type + '" placeholder="在此输入..." ></div></div>'
                    }
                    html += '</div>';
                }
                html += '</div>';
                holder.html(html);
                holder.on("click", "input[type='button']", function () {
                    var that = $(this);
                    var items = that.attr("data-items");
                    items = eval('(' + items + ')');
                    items.push({label: "手动录入", manual: true});
                    if (items.length > 0) {
                        weui.picker(items, {
                            id: that.attr("name"),
                            onConfirm: function (result) {
                                if (result[0].manual) {
                                    that.attr("type", "text");
                                } else {
                                    var date = result[0].value || result[0].label;
                                    that.val(date);
                                }
                                updateInputLink(items, result[0].value || result[0].label);
                            },
                            title: $(this).attr('data-title')
                        });
                    }
                });
                holder.on("change", "input[type='radio']", function () {
                    updateLink($(this).closest(".weui-cells").find("[data-link]"));
                });
                holder.on("change", "input[type='checkbox']", function () {
                    updateLink($(this).closest(".weui-cells").find("[data-link]"));
                });
                if (IsPC()) {
                    holder.on("click", "input[type='date']", function () {
                        var that = $(this);
                        weui.datePicker({
                            id: that.attr("name"),
                            start: 1990,
                            end: new Date().getFullYear(),
                            onConfirm: function (result) {
                                var date = result[0].value + "-" + (result[1].value < 10 ? "0" + result[1].value : result[1].value) + "-" + (result[2].value < 10 ? "0" + result[2].value : result[2].value);
                                that.val(date);
                            },
                            title: $(this).attr('data-title')
                        });
                    });
                }
                return holder;
            }
            function drawResult(holder, date, data) {
                window.totalResult = data;
                var subjects = data.subjects;
                var html = '<div class="subject weui-cells"  ><div class="weui-cells__title" style="text-align:center;">完成情况</div><div class="weui-cells">';
                html += '<a class="weui-cell  weui-cell_access" data-key="所有"  data-value="" style="font-size:14px;" href="javascript:;"><div class="weui-cell__bd"><p>上报总人数</p></div>';
                html += '<div class="weui-cell__ft">' + (data.total) + '</div></a>';
                html += '<a class="weui-cell  weui-cell_access"  style="font-size:14px;" data-key="未上报"  data-value=""  href="javascript:;"> <div class="weui-cell__bd"> <p>未完成人数</p> </div>';
                html += '<div class="weui-cell__ft">' + (data.total - data.report) + '</div></a></div></div>';
                for (var i = 0; i < subjects.length; i++) {
                    var doc = subjects[i];
                    var key = doc.key;
                    html += '<div data-key="' + key + '" class="subject weui-cells ">';
                    html += '<div class="subject_title weui-cells__title">' + (i + 1) + ". " + (doc.title || '') + '</div>';
                    var items = doc.items || {};
                    for (var j in items) {
                        html += '<a style="font-size:14px;" href="javascript:;" class="weui-cell weui-cell_access" data-value="' + j + '"><div class="weui-cell__bd"><p>' + j + '</p></div><div class="weui-cell__ft">' + (items[j]) + '</div></a>'
                    }
                    html += '</div>';
                }
                holder.html(html);
                holder.find("[data-value]").each(function (i, o) {
                    $(o).click(function () {
                        var that = $(this);
                        var key = $(this).closest("[data-key]").attr("data-key");
                        var value = $(this).attr("data-value");
                        if (that.find(".weui-cell__ft").text() === '0') {
                            return;
                        }
                        that.siblings(".userlist").remove();
                        apihelp(function (api) {
                            var depart = (window.user.admin === 'super' ? [] : window.user.group || [window.user.department]);
                            api.fetchUsers({done: function (list) {
                                    if (list.length > 0) {
                                        list.sort(function (param1, param2) {
                                            return (param1.name || "").localeCompare(param2.name, "zh");
                                        });
                                        var html = "<div class='userlist'><p style='height:15px;'><span onclick=\"$(this).closest(\'.userlist\').remove();\" style='float:right; color:#eee;font-size:12px;margin:5px 15px;'>x</span></p>";
                                        html += "<p style=\"min-height:15px; width:100%;text-align:center;\"><span>" + (list.length || '0') + "人</span></p>";
                                        for (var i = 0; i < list.length; i++) {
                                            var u = list[i];
                                            html += '<div class="weui-cell weui-cell_active"><div class="weui-cell__hd"><label class="weui-label ' + (u.admin || '') + ' ">' + (u.name || '') + '</label></div><div class="weui-cell__bd"><span>' + (u.department || '') + '</span></div><div class="weui-cell__ft">' + ((u.phone || '').length !== 11 ? "" : '<a class="weui-badge-btn" href="tel:' + (u.phone || '') + '">电话</a><a class="weui-badge-btn" href="sms:' + (u.phone || '') + (IsiPhone() ? '&' : '?') + 'body=【' + (window.appcfg.name || window.appcfg.company || window.user.department) + '】' + (u.name) + '：打扰了，请您尽快完成' + (window.appcfg.template.title || '数据上报') + '。">短信</a>') + '</div> </div>';
                                        }
                                        html += "</div>";
                                        $(html).insertAfter(that);
                                    }
                                }, fail: function (e) {
                                    weui.alert(e.message);
                                }},
                                    window.appcfg.suffix,
                                    window.appcfg.id, depart, date, key, value);
                        });
                    });
                });
                $("#tongji [data-key='date']").text(moment(date, "YYYYMMDD").format('LL')).attr("date", date);
            }
            function createResult(holder, date) {
                dbhelp(function (db) {
                    db.find({done: function (list) {
                            if (list.length < 1) {
                                holder.html("<div style='margin:100px;text-align:center;'>无数据</div>");
                                return;
                            }
                            drawResult(holder, date, list[0]);
                        }, fail: function (e) {
                            weui.alert(e.message);
                        }}, "report" + appcfg.suffix, {pid: appcfg.id, date: date}, {skip: 0, limit: 1});
                });
                return holder;
            }
            function IsPC() {
                var userAgentInfo = navigator.userAgent;
                var Agents = ["Android", "iPhone",
                    "SymbianOS", "Windows Phone",
                    "iPad", "iPod"];
                var flag = true;
                for (var v = 0; v < Agents.length; v++) {
                    if (userAgentInfo.indexOf(Agents[v]) > 0) {
                        flag = false;
                        break;
                    }
                }
                return flag;
            }
            function done_upgrade(ver) {
                dbhelp(function (db) {
                    var settings = {"ver": ver};
                    if (!window.appcfg.template) {
                        settings["template"] = window.defaultTemplate;
                    }
                    db.findOneAndUpdate({done: function (doc) {
                            weui.alert("已经升级到" + ver);
                            window.appcfg = doc;
                        }, fail: function (e) {
                            weui.alert(e.message);
                        }, always: function () {
                        }}, "company", {id: window.appcfg.id}, {"$set": settings});
                });
            }
            function upgrade() {
                var items = [{label: "1.0"}, {label: "2.0"}];
                weui.picker(items, {
                    id: "done_upgrade",
                    onConfirm: function (result) {
                        done_upgrade(result[0].label);
                    },
                    title: "选择版本"
                });
            }
            ;
            function hashCode(str) {
                var hash = 0;
                if (!str || str.length === 0)
                    return hash;
                for (i = 0; i < str.length; i++) {
                    char = str.charCodeAt(i);
                    hash = ((hash << 5) - hash) + char;
                    hash = hash & hash; // Convert to 32bit integer
                }
                return hash;
            }

            function deleteUser20(holder, _id) {
                weui.confirm("确认删除吗?", function () {
                    apihelp(function (api) {
                        api.deleteUser({done: function (count) {
                                weui.alert("删除" + count + "人");
                                if (count > 0) {
                                    holder.remove();
                                }
                            }, fail: Fail}, window.appcfg.suffix, window.appcfg.id, _id);
                    });
                });
            }
            function pickDepartment(that, callback) {
                if (!that.attr("readonly"))
                    return;
                function show(list) {
                    list = list || [];
                    if (list.length > 0) {
                        list.sort(function (param1, param2) {
                            return (param1.name || "").localeCompare(param2.name, "zh");
                        });
                        var items = {};
                        for (var i in list) {
                            var g = list[i];
                            var fields = g.split(/[-|\/]/g);
                            var obj = items;
                            for (var j = 0; j < fields.length; j++) {
                                var f = fields[j];
                                obj[f] = obj[f] || {};
                                obj = obj[f];
                            }
                        }
                        function builder(list, items) {
                            for (var i in items) {
                                var item = {label: i};
                                if (Object.keys(items[i]).length > 0) {
                                    item.children = [];
                                    builder(item.children, items[i]);
                                    item.children.push({label: '/'});
                                    list.push(item);
                                } else {
                                    list.push(item);
                                }
                            }
                        }
                        var itemlist = [];
                        builder(itemlist, items);
                        if (that.attr("type") === "text") {
                            itemlist.push({label: "手动录入"});
                        }
                        console.log(itemlist);
                        weui.picker(itemlist, {
                            id: "grouplist",
                            onConfirm: function (result) {
                                if (result && result.length > 0) {
                                    var str = "";
                                    for (var j in result) {
                                        var v = result[j].label;
                                        if (v !== "/") {
                                            if (str.length > 0) {
                                                str += "-";
                                            }
                                            str += v;
                                        }
                                    }
                                    if (str !== "手动录入") {
                                        that.val(str);
                                    } else {
                                        that.removeAttr("readonly");
                                    }
                                    if (typeof callback === "function") {
                                        callback(str);
                                    }
                                }
                            },
                            title: "选择部门"
                        });
                    }
                }
                var bShow = false;
                var now = new Date().getTime();
                if (window.grouplist && window.grouplist.length > 0 && (now - (window.grouplist_refreshTime || 0)) < 60000) {
                    show(window.grouplist);
                    bShow = true;
                }
                apihelp(function (api) {
                    api.group({done: function (list) {
                            window.grouplist = list || [];
                            window.grouplist_refreshTime = now;
                            if (!bShow) {
                                show(window.grouplist);
                            }
                        }, fail: Fail}, "user" + window.appcfg.suffix, "department", {});
                });
            }
            $(function () {
                window.defaultTemplate = {"subjects": [{"subtitle": "如实申报", "requried": true, "calc": true, "type": "radio", "title": "本人最近2周是否前往疫区", "items": [{"label": "前往疫区"}, {"label": "未前往疫区"}], "key": "L180775250"}, {"subtitle": "如实申报", "requried": true, "calc": true, "type": "checkbox", "title": "本人感染情况", "items": [{"label": "未感染"}, {"label": "感冒"}, {"label": "疑似"}, {"label": "确诊"}], "key": "L1856277198"}, {"subtitle": "如实申报", "requried": true, "calc": true, "type": "radio", "title": "家属2周内是否前往疫区", "items": [{"label": "前往疫区"}, {"label": "未前往疫区"}], "key": "L992133760"}, {"subtitle": "如实申报", "requried": true, "calc": true, "type": "radio", "title": "家属感染情况", "items": [{"label": "未感染"}, {"label": "感冒"}, {"label": "疑似"}, {"label": "确诊"}], "key": "L1024892276"}, {"subtitle": "不确定时，请先填写，后面在修改", "requried": true, "calc": true, "type": "date", "title": "返程时间", "key": "L1127776693"}, {"subtitle": "企业内部编号", "requried": false, "calc": false, "type": "text", "title": "员工编号", "key": "L667376878"}, {"subtitle": "", "requried": true, "calc": true, "type": "radio", "title": "现在是否在京?", "items": [{"label": "是"}, {"label": "否"}], "key": "L1280028300"}, {"subtitle": "身在何处，填写格式: 省.市.县", "requried": true, "calc": false, "type": "text", "title": "现在何处?", "key": "L2028852904"}, {"subtitle": "主要交通工具 ，选项不够请输入", "requried": true, "calc": true, "type": 'button', "title": "返程交通工具", "items": [{"label": "飞机"}, {"label": "高铁"}, {"label": "火车"}, {"label": "汽车"}, {"label": "轮船"}, {"label": "自驾"}, {"label": "骑行"}, {"label": "步行"}, {"label": "无"}], "key": "L1283117535"}, {"subtitle": "疫情发生期间", "requried": true, "calc": true, "type": 'button', "title": "你家有几口人", "items": [{"label": "1"}, {"label": "2"}, {"label": "3"}, {"label": "4"}, {"label": "5"}, {"label": "6"}, {"label": "7"}, {"label": "8"}, {"label": "9"}, {"label": "10"}, {"label": "其它数字请手动录入"}], "key": "L1356988732"}, {"subtitle": "", "requried": false, "calc": false, "type": "text", "title": "身份证号", "key": "L1108619656"}, {"subtitle": "输入所在单位名称或子企业", "requried": false, "calc": false, "type": "text", "title": "单位全称", "key": "L655717920"}, {"subtitle": "身份证上的名称", "requried": false, "calc": false, "type": "text", "title": "姓名", "key": "L734362"}, {"subtitle": "咨询主管部门确定，不在选项中手动录入。", "requried": false, "calc": false, "type": 'button', "title": "人员类别", "items": [], "key": "L622166638"}, {"subtitle": "留校/留守/值班/在岗", "requried": true, "calc": true, "type": "radio", "title": "是否留守", "items": [{"label": "是"}, {"label": "否"}], "key": "L800959334"}, {"subtitle": "居 住/暂住地，具体地址到门牌号", "requried": false, "calc": false, "type": "text", "title": "现住所", "key": "L29115521"}, {"subtitle": "", "requried": true, "calc": true, "type": "radio", "title": "性 别", "items": [{"label": "男"}, {"label": "女"}], "key": "L784100"}, {"subtitle": "输入格式：省.市.县", "requried": false, "calc": false, "type": "text", "title": "籍贯", "key": "L1022594"}, {"subtitle": "常用手机号", "requried": false, "calc": false, "type": "text", "title": "手机号", "key": "L25022344"}, {"subtitle": "常用邮箱", "requried": false, "calc": false, "type": "email", "title": "邮箱", "key": "L1179843"}, {"subtitle": "格式 关系 姓名 手机号", "requried": false, "calc": false, "type": "phone", "title": "紧急联系人与手机", "key": "L1014328088"}, {"subtitle": "具体到省市", "requried": false, "calc": false, "type": "text", "title": "离京后都去了哪些地方", "key": "L1434182309"}, {"subtitle": "", "requried": false, "calc": false, "type": "date", "title": "离京时间", "key": "L948579023"}, {"subtitle": "不满一天按一天算，未到疫区的填写0", "requried": false, "calc": false, "type": "number", "title": "在疫区滞留天数", "key": "L367218041"}, {"subtitle": "摄氏度", "requried": true, "calc": true, "type": "number", "title": "今日体温", "key": "L626609873"}, {"subtitle": "", "requried": false, "calc": false, "type": "text", "title": "其它情况说明", "key": "L951601271"}], "title": "疫情统计通用模板"};
                if (!appcfg.template)
                {
                    appcfg.template = window.defaultTemplate;
                }
                window.user = store.get("user-tjb") || {};
                if (window.user.pid != window.appcfg.id) {//账号不对
                    window.user = {};
                }
                if (window.user.admin === "admin" || window.user.admin === "super") {
                    $(".admin").show();
                }
                $('#tabbar').on('click', ".weui-tabbar__item", function () {
                    var that = $(this);
                    that.addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
                });
                Q.reg('home', function () {
                    if (!window.user._id) {
                        toast("请先登录");
                        location.href = "#me";
                        return;
                    }
                    var html = $('script#tpl_home').html();
                    createPage(appcfg.template, $(".container").html(html).find(".page").css({opacity: 1}).find("#template"));
                    var diary = store.get("diary" + hashCode(appcfg.template.title)) || {};
                    if (diary.time) {
                        $("#diary").html("最近一次提交<br>" + moment(diary.time).format("MM月DD日 HH:mm"));
                    }
                    //预填写
                    var cache = store.get("input-cache") || {};
                    $(".page").find(".subject").each(function (i, o) {
                        var sbj = $(o);
                        var key = sbj.attr("data-key");
                        var value = cache[key];
                        if (value !== undefined) {
                            var type = sbj.attr("data-type");
                            switch (type) {
                                case "radio":
                                {
                                    sbj.find("input[value='" + value + "']").prop("checked", true);
                                    break;
                                }
                                case "checkbox":
                                {
                                    for (var j in value) {
                                        sbj.find("input[value='" + value[j] + "']").prop("checked", true);
                                    }
                                    break;
                                }
                                default:
                                {
                                    sbj.find("input[name='" + key + "']").val(value);
                                }
                            }
                        }
                        updateLink(sbj.find("[data-link]"));
                        var items = sbj.find("input[data-items]").attr("data-items") || "[]";
                        items = eval("(" + items + ")");
                        if (items && items.length > 0) {
                            updateInputLink(items);
                        }
                    });

                    $(".mydepartment").text(window.user.department || '');
                    $(".today").text(moment().format("LL"));
                    $("#tjbtitle").text(appcfg.template.title);
                })
                Q.reg('mgr', function () {
                    var html = "";
                    if (window.user.admin === "super" || window.user.admin === "admin") {
                        $(".page").fadeOut();
                        html += "<div class=\"page\">";
                        html += "<div class=\"page__bd \">";
                        html += "<div class=\"weui-btn-area\">";
                        html += "<a onclick=\"upgrade()\" style=\"display:none;\" class=\"weui-btn weui-btn_mini weui-btn_primary \" href=\"javascript:\" >一键升级</a>";
                        html += "<a class=\"weui-btn weui-btn_mini weui-btn_primary \" href=\"#template\" >编辑模板</a>";
                        html += "<a class=\"weui-btn weui-btn_mini weui-btn_primary\" href=\"#users\" >查看人员</a>";
                        if (window.user.admin === "super") {
                            html += "<a class=\"weui-btn weui-btn_mini weui-btn_primary uploaduser\" href=\"javascript:\" >批量上传</a>";
                        }
                        html += "</div>";
                        if (true) {
                            html += "<div class=\"weui-cells__title\">新增人员:手机号必填，其它项目可由上报者填写</div>";
                            html += '<div class="weui-cell weui-cell_active">';
                            html += '<div class="weui-cell__hd"><label class="weui-label">手机号</label></div>';
                            html += '<div class="weui-cell__bd">';
                            html += '<input class="weui-input" type="number" pattern="[0-9]*"  name="phone" placeholder="请输入手机号"  value="">';
                            html += '</div>';
                            html += '<div class="weui-cell__ft">';
                            html += '</div>';
                            html += ' </div>';
                        }
                        html += '<div class="weui-cell weui-cell_active">'
                        html += '<div class="weui-cell__hd"><label class="weui-label">姓名</label></div>';
                        html += '<div class="weui-cell__bd">';
                        html += '<input name="name" class="weui-input"  value="" placeholder="填写本人姓名">';
                        html += '</div>';
                        html += '</div>';
                        html += '<div class="weui-cell weui-cell_active">'
                        html += '<div class="weui-cell__hd"><label class="weui-label">单位</label></div>';
                        html += '<div class="weui-cell__bd">';
                        html += '<input name="company" class="weui-input" value="' + (window.user.company || appcfg.name || appcfg.company || '') + '"  placeholder="填写单位全称">';
                        html += '</div>';
                        html += '</div>';
                        html += '<div class="weui-cell weui-cell_active">'
                        html += '<div class="weui-cell__hd"><label class="weui-label">部门</label></div>';
                        html += '<div class="weui-cell__bd">';
                        html += '<input name="department" readonly type="text" value="' + (window.user.department || '') + '" class="weui-input" placeholder="填写部门/子公司全称">';
                        html += '</div>';
                        html += '</div>';
                        html += '<div class="weui-cells weui-cells_checkbox">';
                        html += '<label class="weui-cell weui-cell_active weui-check__label" for="admin0">';
                        html += '<div class="weui-cell__hd">';
                        html += '<input type="radio" name="admin" class="weui-check" id="admin0" value="user">';
                        html += '<i class="weui-icon-checked"></i>';
                        html += '</div>';
                        html += '<div class="weui-cell__bd">';
                        html += '<p>普通人员</p>';
                        html += '</div>';
                        html += '</label>';
                        html += '<label class="weui-cell weui-cell_active weui-check__label" for="admin1">';
                        html += '<div class="weui-cell__hd">';
                        html += '<input type="radio" name="admin" class="weui-check"  id="admin1" value="admin">';
                        html += '<i class="weui-icon-checked"></i>';
                        html += '</div>';
                        html += '<div class="weui-cell__bd">';
                        html += '<p>分级管理员</p>';
                        html += '</div>';
                        html += '</label>';
                        if (window.user.admin === "super") {
                            html += '<label class="weui-cell weui-cell_active weui-check__label" for="admin2">';
                            html += '<div class="weui-cell__hd">';
                            html += '<input type="radio" name="admin" class="weui-check" id="admin2" value="super">';
                            html += '<i class="weui-icon-checked"></i>';
                            html += '</div>';
                            html += '<div class="weui-cell__bd">';
                            html += '<p>超级管理员</p>';
                            html += '</div>';
                            html += '</label>';
                        }
                        html += '<div class="weui-cell weui-cell_active ">'
                        html += '<div class="weui-cell__hd"><label class="weui-label">管辖范围</label></div>';
                        html += '<div class="weui-cell__bd">';
                        html += '<input name="group" type="button" class="weui-input" readonly placeholder="选择管辖部门">';
                        html += '</div>';
                        html += '</div>';
                        html += "</div>";
                        html += '<div id="grouplist" class="weui-cells"></div>';
                        html += "</div>";

                        html += "<div class=\"page__ft\">";
                        html += "<div class=\"weui-btn-area\" style=\"margin-bottom:150px;\">";
                        html += "<button class=\"weui-btn weui-btn_primary\" href=\"javascript:\" type=\"submit\"  id=\'updateUsers\'>新增/更新</button>";
                        html += "</div>";
                    } else {
                        html += "<div style='padding:50px;text-align:center;'>无权限</div>";
                    }
                    var page = $(".container").html(html).find(".page").css({opacity: 1, height: window.screen.availHeight - 50 + 'px'});
                    page.fadeIn();
                    page.on("change", "input[name='xlsxfile']", loaduserfile);
                    page.on("click", ".uploaduser", function () {
                        var html = '<div class="weui-cell weui-cell_active">'
                        html += '<div class="weui-cell__bd">批量上传人员信息</div>';
                        html += '<div class="weui-cell__ft"><a class="weui-btn weui-btn_mini weui-btn_primary" onclick="location.reload();">返回</a></div>';
                        html += '</div>';
                        html += "<div class=\"weui-cells__title\">上传功能不能在微信内使用，请使用浏览器操作</div>";
                        html += "<div class=\"weui-cells__title\"><a href='user.xlsx' download='人员模板.xlsx' target='_blank'>下载人员表格模板</a></div>";
                        html += '<div class="weui-cell weui-cell_active">'
                        html += '<div class="weui-cell__hd"><label class="weui-label">上传名单</label></div>';
                        html += '<div class="weui-cell__bd">';
                        html += '<input name="xlsxfile" type="file" class="weui-btn weui-btn_mini weui-btn_primary" placeholder="填写部门/子公司全称">';
                        html += '</div>';
                        html += '</div>';
                        html += "<div style='margin-bottom:200px;' id='workbench'></div></div>";
                        html += "</div>";
                        $(".page").html(html);
                    });
                    page.on("click", "input[name='group']", function () {
                        var that = $(this);
                        pickDepartment(that, function (val) {
                            $("#grouplist").append('<div class="weui-cell" ><div class="weui-cell__bd">' + val + '</div><div class="weui-cell__ft"><span onclick="$(this).closest(\'.weui-cell\').remove();">x</span></div>');
                        });
                    });
                    page.on("click", "input[name='department']", function () {
                        var that = $(this);
                        pickDepartment(that);
                    });
                    page.on("blur", "input[name='department']", function () {
                        var text = $(this).val();
                        window.grouplist = window.grouplist || [];
                        if (text && text.length > 0) {
                            var find = false;
                            for (var i = 0; i < window.grouplist.length; i++) {
                                if (text === window.grouplist[i]) {
                                    find = true;
                                    break;
                                }
                            }
                            if (!find) {
                                window.grouplist.push(text);
                            }
                        }
                        window.grouplist.sort(function (param1, param2) {
                            return (param1.name || "").localeCompare(param2.name, "zh");
                        });
                        $(this).attr("readonly", true);
                    });
                    page.find("#updateUsers").click(function () {
                        var that = $(this);
                        var user = {};
                        var inputs = ["phone", "name", "company", "department"];
                        for (var i = 0; i < inputs.length; i++) {
                            var key = inputs[i];
                            var value = page.find("input[name='" + key + "']").val() || '';
                            if (value.length > 0) {
                                user[key] = value;
                            }
                        }
                        var admin = page.find("input[name='admin']:checked").val();
                        if (admin) {
                            user.admin = admin;
                        }
                        var group = [];
                        page.find("#grouplist .weui-cell__bd").each(function (i, o) {
                            group.push($(o).text());
                        });
                        if (group.length > 0) {
                            user.group = group;
                        } else if (user.admin == "admin" && user.department && user.department.length > 0) {
                            user.group = [user.department];
                        } else if (user.admin === "admin") {
                            weui.alert("请添加管辖范围");
                        }
                        apihelp(function (api) {
                            api.updateUsers({done: function () {
                                    weui.toast("已完成");
                                }, fail: Fail}, window.appcfg.suffix, window.appcfg.id, [user]);
                        });
                    });
                    apihelp(function (api) {
                        api.group({done: function (list) {
                                window.grouplist = list || [];
                                window.grouplist.sort(function (param1, param2) {
                                    return (param1.name || "").localeCompare(param2.name, "zh");
                                });
                            }, fail: Fail}, "user" + window.appcfg.suffix, "department", {});
                    });
                });
                Q.reg('me', function () {
                    $(".page").fadeOut();
                    var html = "";
                    html += "<div class=\"page\" style=\"padding-top:30px;\">";
                    html += "<div class=\"page__bd \">";
                    if (true) {
                        if (!window.user.phone) {
                            html += "<div style=\"text-align: center;color: red;font-size: 14px;\" >务必先联系管理员添加你的手机号</div>";
                        }
                        html += '<div class="weui-cell weui-cell_active">';
                        html += '<div class="weui-cell__hd"><label class="weui-label">手机号*</label></div>';
                        html += '<div class="weui-cell__bd">';
                        html += '<input class="weui-input" type="number" pattern="[0-9]*"  name="phone" placeholder="请输入手机号"  value="' + (window.user.phone || '') + '">';
                        html += '</div>';
                        html += '<div class="weui-cell__ft"></div>';
                        html += '</div>';
                    }
                    if (!appcfg.phoneVerify || window.user._id) {
                        html += '<div class="weui-cell weui-cell_active">'
                        html += '<div class="weui-cell__hd"><label class="weui-label">姓名</label></div>';
                        html += '<div class="weui-cell__bd">';
                        html += '<input name="name" class="weui-input" value="' + (window.user.name || '') + '" placeholder="填写本人姓名">';
                        html += '</div>';
                        html += '</div>';

                        html += '<div class="weui-cell weui-cell_active">'
                        html += '<div class="weui-cell__hd"><label class="weui-label">单位</label></div>';
                        html += '<div class="weui-cell__bd">';
                        html += '<input name="company" class="weui-input" value="' + (window.user.company || appcfg.name || appcfg.company || '') + '"  placeholder="填写单位全称">';
                        html += '</div>';
                        html += '</div>';

                        html += '<div class="weui-cell weui-cell_active">'
                        html += '<div class="weui-cell__hd"><label class="weui-label">部门</label></div>';
                        html += '<div class="weui-cell__bd">';
                        html += '<input name="department" type="text" readonly value="' + (window.user.department || appcfg.department || '') + '" class="weui-input" placeholder="填写部门/子公司全称">';
                        html += '</div>';
                        html += '</div>';
                    }
                    if (window.appcfg.phoneVerify && !window.user.phone) {
                        html += '<div class="weui-cell weui-cell_active weui-cell_vcode">';
                        html += '<div class="weui-cell__hd"><label class="weui-label">验证码</label></div>';
                        html += '<div class="weui-cell__bd">';
                        html += '<input autofocus="" class="weui-input" type="text" pattern="[0-9]*" name="vcode" placeholder="输入手机短信验证码" maxlength="4">';
                        html += '</div>';
                        html += '<div class="weui-cell__ft">';
                        html += '<button onclick="SendSMS($(this))" class="weui-btn weui-btn_default weui-vcode-btn">获取验证码</button>';
                        html += '</div>';
                        html += '</div>';
                    }
                    html += ' </div>';
                    html += "<div class=\"page__ft\">";
                    html += "<div class=\"weui-btn-area\" style=\"margin-bottom:150px;\">";
                    html += "<button class=\"weui-btn weui-btn_primary\" href=\"javascript:\" type=\"submit\"  onclick=\'" + (window.user._id ? "logout()" : "updateProfile($(this).closest(\".page\")," + (window.user._id ? true : false) + ")") + " \'>" + (window.user._id ? "注销" : "登录") + "</button>";
                    html += "</div>";
                    html += "</div>";
                    html += "</div>";
                    var page = $(".container").html(html).find(".page").css({opacity: 1, height: window.screen.availHeight - 50 + 'px'});
                    page.fadeIn();
                    page.find("input[name='department'][readonly]").click(function () {
                        var that = $(this);
                        pickDepartment(that);
                    });
                });
                Q.reg('china', function (id) { 
                        var pg = $(".page").html('<iframe src=" https://voice.baidu.com/act/newpneumonia/newpneumonia" seamless scrolling="auto" frameborder=0; style="margin:0;padding:0; width:100%;height: ' + (window.screen.availHeight - 50 + 'px') + '"></iframe>');                   
                });
                Q.reg('tjb', function (id) {
                    if (window.user.admin === "super" || window.user.admin === "admin") {
                        var html = $('script#tpl_tjb').html();
                        $(".container").html(html).find(".page").css({opacity: 1, height: window.screen.availHeight - 50 + 'px'});
                        var date = $("#tongji [data-key='date']").attr("date") || moment().format("YYYYMMDD");
                        createResult($(".page__bd"), date);
                        $(".container [data-key='company']").text(window.appcfg.name || window.appcfg.company);
                        $("#tjbtitle").text(appcfg.template.title);
                    } else {
                        $(".page").html('<div style="margin:100px auto; text-align:center;">没有权限</div>')
                    }
                });
                Q.reg('template', function (id) {
                    var html = $('script#tpl_tpl').html();
                    $(".container").html(html).find(".page").css({opacity: 1, height: window.screen.availHeight - 50 + 'px'});
                });
                Q.reg('users', function (id) {
                    var html = $('script#tpl_users').html();
                    $(".container").html(html).find(".page").css({opacity: 1, height: window.screen.availHeight - 50 + 'px'});
                });

                /* 启动函数 */
                Q.init({
                    key: '', /* url里#和url名之间的分割符号 默认为感叹号 */
                    index: window.user._id ? 'home' : 'me', /* 首页地址 如果访问到不能访问页面也会跳回此页 */
                    pop: function (L, arg) {/* 每次有url变更时都会触发pop回调 */
                        //console.log('pop 当前参数是:', arguments);
                    }
                });
                if (window.inMiniProgram) {//每小时刷新一次
                    var load = store.get(location.pathname);
                    var now = new Date().getTime();
                    if (load) {
                        if (load.time < now - 1000 * 3600) {
                            var search = location.search.indexOf("&reload") !== -1 ? location.search.replace("&reload", "") : location.search + "&reload";
                            store.set(location.pathname, {time: now, search: search});
                            location.search = search;
                        }
                    } else {
                        store.set(location.pathname, {time: now, search: location.search})
                    }
                    if (window.user._id)
                    {
                        dbhelp(function () {
                            var now = new Date().getTime();
                            db.findOneAndUpdate({done: function (doc) {
                                    if (doc) {
                                        store.set("com-tjb", doc);
                                        window.appcfg = doc;
                                    }
                                }, fail: Fail, always: function () {
                                    db.findOneAndUpdate({done: function (doc) {
                                            if (doc) {
                                                store.set("user-tjb", doc);
                                                window.user = doc;
                                            }
                                            console.log("应用已升级");
                                        }, fail: Fail}, "user" + appcfg.suffix, {_id: window.user._id}, {$set: {time: now}});
                                }}, "company", {_id: window.appcfg._id}, {$set: {time: now}});
                        });
                    }
                }
            });
            function IsiPhone() {
                return (!!navigator.userAgent.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/));
            }

    </script>        
    <script src="js/app.js?t=2.0"></script>    
</body>
</html>
