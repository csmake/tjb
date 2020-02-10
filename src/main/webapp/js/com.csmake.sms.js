/**
 * Copyright (c) 2012-2020 CSMAKE, Technology Co., Ltd. 
 *
 * Generate by csmake.com for java Sun Feb 09 08:52:36 CST 2020
 */
var com;
(function(com){
    var csmake;
    (function(csmake){
        var sms=
        (function(sms){
            var _init = false; 
            var _delayList = []; 
            var _delayTimer = null;
            var _guid = '';
            var _paths=window.location.pathname.split("/"); _paths= window.location.pathname.replace(_paths[_paths.length-1],"");
            var _url =  window.location.protocol+'//'+window.location.host+(_paths)+'com.csmake.sms';
            function log(text){  if(window && typeof window.log === 'function'){window.log(text);} else if(typeof console !== 'undefined' && typeof console.log === 'function'){ console.log(text);}}
            function argsError(m,args){m='com.csmake.sms.'+m+' arguments is invalid:'+JSON.stringify(args); if (isasync(args) && typeof args[0].fail === 'function'){args[0].fail({message:m});}else{throw new SyntaxError(m); } }
            function isasync(args){  return (args.length >= 1 && args[0] && (typeof args[0].done === 'function'||typeof args[0].fail === 'function'||typeof args[0].always === 'function'));}
            function stringify(start, objs){
                var args = '{';
                for(var i=start; i < objs.length;i++){
                    if(i!==start)args+=',';
                    args+='\"'+(i-start)+'\":'+JSON.stringify(objs[i]);
                }
                args+='}';
                return args;
            };
            function _delayCall(){
                if (_init){
                    if (_delayTimer != null){
                        clearTimeout(_delayTimer);
                        _delayTimer = null;
                    }
                    while (_delayList.length > 0){
                        var f = _delayList.shift();
                        base.scall(f.symbol, f.args);
                    }
                }
                else if (_delayTimer == null){
                    _delayTimer = setInterval(function (){
                        _delayCall();
                    }
                    , 500);
                }
            };
            function isType(o, i) {
                return Object.prototype.toString.call(o) === _types[i];
            };
            function dumy(){}
            function defineProperty(_this, name, options) {
                _this[name] = function (v) {
                  var _$1=arguments;  var async = isasync(_$1);
                    return  async ? (_$1.length > 1 ? (options.set(_$1[0],_$1[1]), _$1[1]) : options.get(_$1[0])):(_$1.length > 0 ? (options.set(_$1[0]), _$1[0]) : options.get());
                };
            };
            var base =sms.prototype;
            base.scall = function (symbol, args) {
                var async = isasync(args);
                if (async && !_init && symbol.indexOf('constructor')===-1){
                  _delayList.push({ symbol:symbol, args:args });
                  _delayCall();
                  return;
                }
                function done(o){if(async&&typeof args[0].done === 'function'){args[0].done(o);}}
                function fail(o){if(async&&typeof args[0].fail === 'function'){args[0].fail(o);}else{throw o;}}
                function always(o){if(async&&typeof args[0].always === 'function'){args[0].always(o);}}
                var time=(new Date()).getTime();
                var conv =async ? args[0].conv || function (o) { return o; }:function (o) { return o; };
                var message = "{'time':"+time+",'guid':'" + _guid + "','symbol':'" + symbol + "','args':" + stringify(async?1:0, args) + "}";
                log('scall:' + symbol + '\nsend:' + message + '\n');
                var obj;
                $.ajax({
                    method: "POST",
                    dataType: "text",
                    url: _url,
                    cache: false,
                    async: async,
                    data: message
                }).done(function (ret) {
                    log(symbol + ' '+time+ ' recv:' + ret + '\n');
                    obj = JSON.parse(ret);
                    try {
                if (obj.error > 200) {
            		log(symbol + ' call error:' + obj.error + ' message:' + obj.message);
                    fail({'name': obj.error ,'message':obj.message});
                    return;
                }
                obj = obj.value;
                done(conv((obj && obj._v) ? obj._v : obj));
                    } catch (e) {
                fail(e);
                    }
                }).fail(function (jqXHR, textStatus) {
                    if (textStatus === "parsererror") {
                try {
                    var obj = JSON.parse(jqXHR.responseText);
                    if (obj.error > 200) {
            		log(symbol + ' call error:' + obj.error + ' message:' + obj.message);
                    fail({'name': obj.error ,'message':obj.message});
                        return;
                    }
                    obj = obj.value;
                    done(conv((obj && obj._v) ? obj._v : obj));
                } catch (e) {
                    fail(e);
                }
                    } else {
                fail({'name':500,'message': JSON.stringify(jqXHR)});
                    }
                }).always(always);
            return obj;
        };
        defineProperty(base, "guid", {
            get: function () {
                return _guid;
            },
            set: function (val) {
                _guid = val;
            }
        });
        /* public methods*/
        base.check = function (arg0, arg1){
            var fn = 'check';
            var _$1=arguments;var asyn=isasync(_$1)?1:0;
            if(_$1.length === (2+asyn) && isType(_$1[0+asyn],0)&& isType(_$1[1+asyn],0)){}
            else{argsError(fn,_$1);}
            if(asyn){
                base.scall(fn,_$1); 
            }else{
                return base.scall(fn, _$1);
            }
        };

        base.checked = function (arg0){
            var fn = 'checked';
            var _$1=arguments;var asyn=isasync(_$1)?1:0;
            if(_$1.length === (1+asyn) && isType(_$1[0+asyn],0)){}
            else{argsError(fn,_$1);}
            if(asyn){
                base.scall(fn,_$1); 
            }else{
                return base.scall(fn, _$1);
            }
        };

        base.HTTP_POST = function (arg0, arg1){
            var fn = 'HTTP_POST';
            var _$1=arguments;var asyn=isasync(_$1)?1:0;
            if(_$1.length === (2+asyn) && isType(_$1[0+asyn],0)&& isType(_$1[1+asyn],0)){}
            else{argsError(fn,_$1);}
            if(asyn){
                base.scall(fn,_$1); 
            }else{
                return base.scall(fn, _$1);
            }
        };

        base.sendVerifyCode = function (arg0, arg1){
            var fn = 'sendVerifyCode';
            var _$1=arguments;var asyn=isasync(_$1)?1:0;
            if(_$1.length === (2+asyn) && isType(_$1[0+asyn],0)&& isType(_$1[1+asyn],1)){}
            else if(_$1.length === (3+asyn) && isType(_$1[0+asyn],0)&& isType(_$1[1+asyn],0)&& isType(_$1[2+asyn],1)){fn += '2';}
            else{argsError(fn,_$1);}
            if(asyn){
                base.scall(fn,_$1); 
            }else{
                return base.scall(fn, _$1);
            }
        };

        base.sendVerifyCodeChinaALCO = function (arg0, arg1){
            var fn = 'sendVerifyCodeChinaALCO';
            var _$1=arguments;var asyn=isasync(_$1)?1:0;
            if(_$1.length === (2+asyn) && isType(_$1[0+asyn],0)&& isType(_$1[1+asyn],1)){}
            else{argsError(fn,_$1);}
            if(asyn){
                base.scall(fn,_$1); 
            }else{
                return base.scall(fn, _$1);
            }
        };

        base.sendVerifyCodeJJKJ = function (arg0, arg1){
            var fn = 'sendVerifyCodeJJKJ';
            var _$1=arguments;var asyn=isasync(_$1)?1:0;
            if(_$1.length === (2+asyn) && isType(_$1[0+asyn],0)&& isType(_$1[1+asyn],1)){}
            else{argsError(fn,_$1);}
            if(asyn){
                base.scall(fn,_$1); 
            }else{
                return base.scall(fn, _$1);
            }
        };

        function sms(){
            var fn = 'constructor';
            var _$1=arguments;var asyn=isasync(_$1)?1:0;
            if(_$1.length === (0+asyn)){}
            else{argsError(fn, _$1);}
                try{
                    var args=[];
                    var that=this;
                    if(asyn){
                        var cb=_$1[0];
                        if(typeof cb.done === 'function'){
                            var old=cb.done;
                            cb.done=function(id){that.guid(id);_init=true;old(that);}
                        }
                        else{
                            cb.done=function(id){that.guid(id);_init=true;}
                        }
                        args.push(cb);
                    }
                    for(var i=asyn; i< _$1.length; i++){
                        args.push(_$1[i]);
                    }
                    that.guid('com.csmake.sms');
                    var myid=sms.prototype.scall(fn,args);
                    if(!asyn){
                        _init=true;
                        if(myid){that.guid(myid);}
                    }
                }catch(e){
                    log(e.message);
                }
            return this;
        }
    var _types=['[object String]','[object Number]'];
    return sms;
})(sms = csmake.sms||(csmake.sms = {}));
csmake.sms = sms;
return csmake;
})(csmake = com.csmake||(com.csmake = {}));
com.csmake = csmake;
})(com || (com = {}));
