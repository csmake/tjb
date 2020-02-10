/**
 * Copyright (c) 2012-2019 CSMAKE, Inc. 
 *
 * Generate by csmake.com for java Mon Mar 04 16:03:11 CST 2019
 */
package org.dbcloud.mongodb;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.annotation.WebServlet;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * The CollectionsServlet interface.
 *
 * <p>Note: Generate by csmake for java .</p>
 *
 * {@link org.dbcloud.mongodb.Collections}
 * @author www.csmake.com
 */
@WebServlet(name = "org.dbcloud.mongodb.Collections", urlPatterns = {"/org.dbcloud.mongodb.Collections"})
public class CollectionsServlet extends HttpServlet{
    public CollectionsServlet(){
        _maps = new java.util.HashMap<>();
        classLoader = new com.csmake.ClassLoader();
    }

    @Override
    public void init() {
        _params = new java.util.HashMap<>();
        java.util.Enumeration<String> names = this.getInitParameterNames();
        while (names.hasMoreElements()) {
            String name = names.nextElement();
            _params.put(name, this.getInitParameter(name));
        }
        if (org.dbcloud.mongodb.Collections.class.isAnnotationPresent(javax.inject.Singleton.class))
        {
            org.dbcloud.mongodb.Collections proxy = null;
            try
            {
                java.lang.reflect.Method m = org.dbcloud.mongodb.Collections.class.getDeclaredMethod("Singleton");
                if (m != null)
                {
                    proxy = (org.dbcloud.mongodb.Collections) m.invoke(null);
                    _maps.put("org.dbcloud.mongodb.Collections", new com.csmake.GuidObject(proxy));
                    m = org.dbcloud.mongodb.Collections.class.getDeclaredMethod("csmakeInit", _params.getClass());
                    if (m != null)
                    {
                        _params.remove("guid");
                        _params.put("guid", "org.dbcloud.mongodb.Collections");
                        m.invoke(proxy, _params);
                    }
                }
            }
            catch (Exception ex)
            {
                ex.printStackTrace();
            }
        }
    }
    /**
    * Handles the HTTP <code>GET</code> method.
    *
    * @param request servlet request
    * @param response servlet response
    * @throws ServletException if a servlet-specific error occurs
    * @throws IOException if an I/O error occurs
    */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException
    {
        try{
             String args = request.getParameter("call");
            if (args != null) {
                com.csmake.JSONCall call = JSON.parseObject(java.net.URLDecoder.decode(request.getParameter("call"), "UTF8"), com.csmake.JSONCall.class);
                handleRequest(call, request, response);
            }
        } catch (Exception ex) {
            StringBuilder sb = new StringBuilder();
            sb.append("{error:500,message:\"").append(ex.toString()).append("\",value:''}");
            byte[] utf8 = sb.toString().getBytes("UTF-8");
            response.setContentLength(utf8.length);
            try (javax.servlet.ServletOutputStream out = response.getOutputStream()) {
                out.write(utf8);
            }
        }
    }

    /**
    * Handles the HTTP <code>POST</code> method.
    *
    * @param request servlet request
    * @param response servlet response
    * @throws ServletException if a servlet-specific error occurs
    * @throws IOException if an I/O error occurs
    */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try{
            com.csmake.JSONCall call = JSON.parseObject(request.getInputStream(), com.csmake.JSONCall.class);
            handleRequest(call, request, response);
        } catch (Exception ex) {
            StringBuilder sb = new StringBuilder();
            sb.append("{error:500,message:\"").append(ex.toString()).append("\",value:''}");
            byte[] utf8 = sb.toString().getBytes("UTF-8");
            response.setContentLength(utf8.length);
            try (javax.servlet.ServletOutputStream out = response.getOutputStream()) {
                out.write(utf8);
            }
        }
    }

    protected void handleRequest(com.csmake.JSONCall context, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType(context.rType!=null? context.rType:"application/json;charset=UTF-8");
        com.csmake.JSONReturn ret = call(context);
        byte[] utf8 = ((context.vOnly&&ret.value instanceof String)? (String)ret.value : JSON.toJSONString(context.vOnly? ret.value: ret)).getBytes("UTF-8");
        String ac = request.getHeader("Accept-Encoding");
        boolean zipFlag = ac != null && ac.toLowerCase().contains("gzip") && utf8.length > 999999;
        if (zipFlag) {
            response.addHeader("Content-Encoding", "gzip");
            try (java.util.zip.GZIPOutputStream gos = new java.util.zip.GZIPOutputStream(response.getOutputStream())) {
                gos.write(utf8);
                gos.flush();
            }
        } else {
            response.setContentLength(utf8.length);
            try (javax.servlet.ServletOutputStream out = response.getOutputStream()) {
                out.write(utf8);
            }
        }
    }

    private long sessionid= System.currentTimeMillis();

    protected String getSessionId(){
        return String.valueOf(sessionid++);
    }

    private com.csmake.JSONReturn call(com.csmake.JSONCall context)
    {
        int errorCode = 0;
        Object retValue = null;
        String exception = "";
        com.csmake.GuidObject guidObject = (com.csmake.GuidObject)_maps.get(context.guid);
        org.dbcloud.mongodb.Collections proxy = (org.dbcloud.mongodb.Collections)(guidObject!=null?guidObject.getObject():null);
        try
        {
            switch (context.symbol){
                case "constructor" :{ 
                    Class<?> clazz = classLoader.getInstance().loadClass(context.guid);
                    boolean single = clazz != null && clazz.isAnnotationPresent(javax.inject.Singleton.class);
                    if (single) {
                        guidObject = (com.csmake.GuidObject) _maps.get("org.dbcloud.mongodb.Collections");
                        if (guidObject != null) {
                            context.guid = "org.dbcloud.mongodb.Collections";
                        }
                    }
                    if (guidObject == null && clazz != null) {
                        if (single) {
                            java.lang.reflect.Method m = clazz.getDeclaredMethod("Singleton",java.lang.String.class, java.lang.String.class);
                            if (m != null) {
                                proxy = (org.dbcloud.mongodb.Collections) m.invoke(null,(String)(context.args.get("0")), (String)(context.args.get("1")));
                                context.guid = "org.dbcloud.mongodb.Collections";
                            }
                        }
                        if (proxy == null) {
                            java.lang.reflect.Constructor con = clazz.getConstructor(java.lang.String.class, java.lang.String.class);
                            proxy = (org.dbcloud.mongodb.Collections) con.newInstance((String)(context.args.get("0")), (String)(context.args.get("1")));
                            context.guid = getSessionId();
                        }
                        guidObject = new com.csmake.GuidObject(proxy);
                        try {
                            java.lang.reflect.Method m = clazz.getDeclaredMethod("csmakeInit", _params.getClass());
                            if (m != null) {
                                _params.remove("guid");
                                _params.put("guid", context.guid);
                                m.invoke(proxy, _params);
                            }
                        } catch (Exception ex) {
                        }
                        _maps.put(context.guid, guidObject);
                    }
                    retValue = guidObject == null ? "": context.guid;
                    break;
                }
                case "constructor2" :{ 
                    Class<?> clazz = classLoader.getInstance().loadClass(context.guid);
                    boolean single = clazz != null && clazz.isAnnotationPresent(javax.inject.Singleton.class);
                    if (single) {
                        guidObject = (com.csmake.GuidObject) _maps.get("org.dbcloud.mongodb.Collections");
                        if (guidObject != null) {
                            context.guid = "org.dbcloud.mongodb.Collections";
                        }
                    }
                    if (guidObject == null && clazz != null) {
                        if (single) {
                            java.lang.reflect.Method m = clazz.getDeclaredMethod("Singleton",java.lang.String.class, java.lang.String.class, java.lang.String.class, java.lang.String.class);
                            if (m != null) {
                                proxy = (org.dbcloud.mongodb.Collections) m.invoke(null,(String)(context.args.get("0")), (String)(context.args.get("1")), (String)(context.args.get("2")), (String)(context.args.get("3")));
                                context.guid = "org.dbcloud.mongodb.Collections";
                            }
                        }
                        if (proxy == null) {
                            java.lang.reflect.Constructor con = clazz.getConstructor(java.lang.String.class, java.lang.String.class, java.lang.String.class, java.lang.String.class);
                            proxy = (org.dbcloud.mongodb.Collections) con.newInstance((String)(context.args.get("0")), (String)(context.args.get("1")), (String)(context.args.get("2")), (String)(context.args.get("3")));
                            context.guid = getSessionId();
                        }
                        guidObject = new com.csmake.GuidObject(proxy);
                        try {
                            java.lang.reflect.Method m = clazz.getDeclaredMethod("csmakeInit", _params.getClass());
                            if (m != null) {
                                _params.remove("guid");
                                _params.put("guid", context.guid);
                                m.invoke(proxy, _params);
                            }
                        } catch (Exception ex) {
                        }
                        _maps.put(context.guid, guidObject);
                    }
                    retValue = guidObject == null ? "": context.guid;
                    break;
                }
                case "constructor3" :{ 
                    Class<?> clazz = classLoader.getInstance().loadClass(context.guid);
                    boolean single = clazz != null && clazz.isAnnotationPresent(javax.inject.Singleton.class);
                    if (single) {
                        guidObject = (com.csmake.GuidObject) _maps.get("org.dbcloud.mongodb.Collections");
                        if (guidObject != null) {
                            context.guid = "org.dbcloud.mongodb.Collections";
                        }
                    }
                    if (guidObject == null && clazz != null) {
                        if (single) {
                            java.lang.reflect.Method m = clazz.getDeclaredMethod("Singleton");
                            if (m != null) {
                                proxy = (org.dbcloud.mongodb.Collections) m.invoke(null);
                                context.guid = "org.dbcloud.mongodb.Collections";
                            }
                        }
                        if (proxy == null) {
                            java.lang.reflect.Constructor con = clazz.getConstructor();
                            proxy = (org.dbcloud.mongodb.Collections) con.newInstance();
                            context.guid = getSessionId();
                        }
                        guidObject = new com.csmake.GuidObject(proxy);
                        try {
                            java.lang.reflect.Method m = clazz.getDeclaredMethod("csmakeInit", _params.getClass());
                            if (m != null) {
                                _params.remove("guid");
                                _params.put("guid", context.guid);
                                m.invoke(proxy, _params);
                            }
                        } catch (Exception ex) {
                        }
                        _maps.put(context.guid, guidObject);
                    }
                    retValue = guidObject == null ? "": context.guid;
                    break;
                }
                case "constructor4" :{ 
                    Class<?> clazz = classLoader.getInstance().loadClass(context.guid);
                    boolean single = clazz != null && clazz.isAnnotationPresent(javax.inject.Singleton.class);
                    if (single) {
                        guidObject = (com.csmake.GuidObject) _maps.get("org.dbcloud.mongodb.Collections");
                        if (guidObject != null) {
                            context.guid = "org.dbcloud.mongodb.Collections";
                        }
                    }
                    if (guidObject == null && clazz != null) {
                        if (single) {
                            java.lang.reflect.Method m = clazz.getDeclaredMethod("Singleton",java.lang.String.class);
                            if (m != null) {
                                proxy = (org.dbcloud.mongodb.Collections) m.invoke(null,(String)(context.args.get("0")));
                                context.guid = "org.dbcloud.mongodb.Collections";
                            }
                        }
                        if (proxy == null) {
                            java.lang.reflect.Constructor con = clazz.getConstructor(java.lang.String.class);
                            proxy = (org.dbcloud.mongodb.Collections) con.newInstance((String)(context.args.get("0")));
                            context.guid = getSessionId();
                        }
                        guidObject = new com.csmake.GuidObject(proxy);
                        try {
                            java.lang.reflect.Method m = clazz.getDeclaredMethod("csmakeInit", _params.getClass());
                            if (m != null) {
                                _params.remove("guid");
                                _params.put("guid", context.guid);
                                m.invoke(proxy, _params);
                            }
                        } catch (Exception ex) {
                        }
                        _maps.put(context.guid, guidObject);
                    }
                    retValue = guidObject == null ? "": context.guid;
                    break;
                }
                case "constructor5" :{ 
                    Class<?> clazz = classLoader.getInstance().loadClass(context.guid);
                    boolean single = clazz != null && clazz.isAnnotationPresent(javax.inject.Singleton.class);
                    if (single) {
                        guidObject = (com.csmake.GuidObject) _maps.get("org.dbcloud.mongodb.Collections");
                        if (guidObject != null) {
                            context.guid = "org.dbcloud.mongodb.Collections";
                        }
                    }
                    if (guidObject == null && clazz != null) {
                        if (single) {
                            java.lang.reflect.Method m = clazz.getDeclaredMethod("Singleton",java.lang.String.class, java.lang.String.class, java.lang.String.class);
                            if (m != null) {
                                proxy = (org.dbcloud.mongodb.Collections) m.invoke(null,(String)(context.args.get("0")), (String)(context.args.get("1")), (String)(context.args.get("2")));
                                context.guid = "org.dbcloud.mongodb.Collections";
                            }
                        }
                        if (proxy == null) {
                            java.lang.reflect.Constructor con = clazz.getConstructor(java.lang.String.class, java.lang.String.class, java.lang.String.class);
                            proxy = (org.dbcloud.mongodb.Collections) con.newInstance((String)(context.args.get("0")), (String)(context.args.get("1")), (String)(context.args.get("2")));
                            context.guid = getSessionId();
                        }
                        guidObject = new com.csmake.GuidObject(proxy);
                        try {
                            java.lang.reflect.Method m = clazz.getDeclaredMethod("csmakeInit", _params.getClass());
                            if (m != null) {
                                _params.remove("guid");
                                _params.put("guid", context.guid);
                                m.invoke(proxy, _params);
                            }
                        } catch (Exception ex) {
                        }
                        _maps.put(context.guid, guidObject);
                    }
                    retValue = guidObject == null ? "": context.guid;
                    break;
                }
                /** public field */
                case "get_mongoClient" :{ 
                    retValue = proxy.mongoClient;
                    break;
                }
                case "set_mongoClient" :{ 
                    proxy.mongoClient = JSON.parseObject(context.args.get("0").toString(), com.mongodb.MongoClient.class);
                    break;
                }
                /** public methods */
                case "count" :{ 
                    String arg0 = (String)(context.args.get("0"));
                    org.bson.Document arg1 = JSON.parseObject(context.args.get("1").toString(), org.bson.Document.class);
                    org.bson.Document arg2 = JSON.parseObject(context.args.get("2").toString(), org.bson.Document.class);
                    retValue = proxy.count(arg0, arg1, arg2);
                    break;
                }
                case "count2" :{ 
                    String arg0 = (String)(context.args.get("0"));
                    org.bson.Document arg1 = JSON.parseObject(context.args.get("1").toString(), org.bson.Document.class);
                    retValue = proxy.count(arg0, arg1);
                    break;
                }
                case "count3" :{ 
                    String arg0 = (String)(context.args.get("0"));
                    retValue = proxy.count(arg0);
                    break;
                }
                case "find" :{ 
                    String arg0 = (String)(context.args.get("0"));
                    org.bson.Document arg1 = JSON.parseObject(context.args.get("1").toString(), org.bson.Document.class);
                    org.bson.Document arg2 = JSON.parseObject(context.args.get("2").toString(), org.bson.Document.class);
                    retValue = proxy.find(arg0, arg1, arg2);
                    break;
                }
                case "find2" :{ 
                    String arg0 = (String)(context.args.get("0"));
                    org.bson.Document arg1 = JSON.parseObject(context.args.get("1").toString(), org.bson.Document.class);
                    int arg2 = (int)(context.args.get("2"));
                    int arg3 = (int)(context.args.get("3"));
                    retValue = proxy.find(arg0, arg1, arg2, arg3);
                    break;
                }
                case "find3" :{ 
                    String arg0 = (String)(context.args.get("0"));
                    org.bson.Document arg1 = JSON.parseObject(context.args.get("1").toString(), org.bson.Document.class);
                    org.bson.Document arg2 = JSON.parseObject(context.args.get("2").toString(), org.bson.Document.class);
                    int arg3 = (int)(context.args.get("3"));
                    int arg4 = (int)(context.args.get("4"));
                    retValue = proxy.find(arg0, arg1, arg2, arg3, arg4);
                    break;
                }
                case "find4" :{ 
                    String arg0 = (String)(context.args.get("0"));
                    org.bson.Document arg1 = JSON.parseObject(context.args.get("1").toString(), org.bson.Document.class);
                    retValue = proxy.find(arg0, arg1);
                    break;
                }
                case "find5" :{ 
                    String arg0 = (String)(context.args.get("0"));
                    retValue = proxy.find(arg0);
                    break;
                }
                case "close" :{ 
                    proxy.close();
                    break;
                }
                case "findOneAndReplace" :{ 
                    String arg0 = (String)(context.args.get("0"));
                    org.bson.Document arg1 = JSON.parseObject(context.args.get("1").toString(), org.bson.Document.class);
                    org.bson.Document arg2 = JSON.parseObject(context.args.get("2").toString(), org.bson.Document.class);
                    org.bson.Document arg3 = JSON.parseObject(context.args.get("3").toString(), org.bson.Document.class);
                    retValue = proxy.findOneAndReplace(arg0, arg1, arg2, arg3);
                    break;
                }
                case "findOneAndReplace2" :{ 
                    String arg0 = (String)(context.args.get("0"));
                    org.bson.Document arg1 = JSON.parseObject(context.args.get("1").toString(), org.bson.Document.class);
                    org.bson.Document arg2 = JSON.parseObject(context.args.get("2").toString(), org.bson.Document.class);
                    retValue = proxy.findOneAndReplace(arg0, arg1, arg2);
                    break;
                }
                case "listIndexes" :{ 
                    String arg0 = (String)(context.args.get("0"));
                    retValue = proxy.listIndexes(arg0);
                    break;
                }
                case "replaceOne" :{ 
                    String arg0 = (String)(context.args.get("0"));
                    org.bson.Document arg1 = JSON.parseObject(context.args.get("1").toString(), org.bson.Document.class);
                    org.bson.Document arg2 = JSON.parseObject(context.args.get("2").toString(), org.bson.Document.class);
                    org.bson.Document arg3 = JSON.parseObject(context.args.get("3").toString(), org.bson.Document.class);
                    retValue = proxy.replaceOne(arg0, arg1, arg2, arg3);
                    break;
                }
                case "replaceOne2" :{ 
                    String arg0 = (String)(context.args.get("0"));
                    org.bson.Document arg1 = JSON.parseObject(context.args.get("1").toString(), org.bson.Document.class);
                    org.bson.Document arg2 = JSON.parseObject(context.args.get("2").toString(), org.bson.Document.class);
                    retValue = proxy.replaceOne(arg0, arg1, arg2);
                    break;
                }
                case "updateMany" :{ 
                    String arg0 = (String)(context.args.get("0"));
                    org.bson.Document arg1 = JSON.parseObject(context.args.get("1").toString(), org.bson.Document.class);
                    org.bson.Document arg2 = JSON.parseObject(context.args.get("2").toString(), org.bson.Document.class);
                    org.bson.Document arg3 = JSON.parseObject(context.args.get("3").toString(), org.bson.Document.class);
                    retValue = proxy.updateMany(arg0, arg1, arg2, arg3);
                    break;
                }
                case "updateMany2" :{ 
                    String arg0 = (String)(context.args.get("0"));
                    org.bson.Document arg1 = JSON.parseObject(context.args.get("1").toString(), org.bson.Document.class);
                    org.bson.Document arg2 = JSON.parseObject(context.args.get("2").toString(), org.bson.Document.class);
                    retValue = proxy.updateMany(arg0, arg1, arg2);
                    break;
                }
                case "dropIndexes" :{ 
                    String arg0 = (String)(context.args.get("0"));
                    proxy.dropIndexes(arg0);
                    break;
                }
                case "createIndex" :{ 
                    String arg0 = (String)(context.args.get("0"));
                    org.bson.Document arg1 = JSON.parseObject(context.args.get("1").toString(), org.bson.Document.class);
                    org.bson.Document arg2 = JSON.parseObject(context.args.get("2").toString(), org.bson.Document.class);
                    retValue = proxy.createIndex(arg0, arg1, arg2);
                    break;
                }
                case "createIndex2" :{ 
                    String arg0 = (String)(context.args.get("0"));
                    org.bson.Document arg1 = JSON.parseObject(context.args.get("1").toString(), org.bson.Document.class);
                    retValue = proxy.createIndex(arg0, arg1);
                    break;
                }
                case "dropIndex" :{ 
                    String arg0 = (String)(context.args.get("0"));
                    org.bson.Document arg1 = JSON.parseObject(context.args.get("1").toString(), org.bson.Document.class);
                    proxy.dropIndex(arg0, arg1);
                    break;
                }
                case "dropIndex2" :{ 
                    String arg0 = (String)(context.args.get("0"));
                    String arg1 = (String)(context.args.get("1"));
                    proxy.dropIndex(arg0, arg1);
                    break;
                }
                case "drop" :{ 
                    String arg0 = (String)(context.args.get("0"));
                    proxy.drop(arg0);
                    break;
                }
                case "deleteOne" :{ 
                    String arg0 = (String)(context.args.get("0"));
                    org.bson.Document arg1 = JSON.parseObject(context.args.get("1").toString(), org.bson.Document.class);
                    retValue = proxy.deleteOne(arg0, arg1);
                    break;
                }
                case "findOneAndDelete" :{ 
                    String arg0 = (String)(context.args.get("0"));
                    org.bson.Document arg1 = JSON.parseObject(context.args.get("1").toString(), org.bson.Document.class);
                    retValue = proxy.findOneAndDelete(arg0, arg1);
                    break;
                }
                case "findOneAndDelete2" :{ 
                    String arg0 = (String)(context.args.get("0"));
                    org.bson.Document arg1 = JSON.parseObject(context.args.get("1").toString(), org.bson.Document.class);
                    org.bson.Document arg2 = JSON.parseObject(context.args.get("2").toString(), org.bson.Document.class);
                    retValue = proxy.findOneAndDelete(arg0, arg1, arg2);
                    break;
                }
                case "findOneAndUpdate" :{ 
                    String arg0 = (String)(context.args.get("0"));
                    org.bson.Document arg1 = JSON.parseObject(context.args.get("1").toString(), org.bson.Document.class);
                    org.bson.Document arg2 = JSON.parseObject(context.args.get("2").toString(), org.bson.Document.class);
                    retValue = proxy.findOneAndUpdate(arg0, arg1, arg2);
                    break;
                }
                case "findOneAndUpdate2" :{ 
                    String arg0 = (String)(context.args.get("0"));
                    org.bson.Document arg1 = JSON.parseObject(context.args.get("1").toString(), org.bson.Document.class);
                    org.bson.Document arg2 = JSON.parseObject(context.args.get("2").toString(), org.bson.Document.class);
                    org.bson.Document arg3 = JSON.parseObject(context.args.get("3").toString(), org.bson.Document.class);
                    retValue = proxy.findOneAndUpdate(arg0, arg1, arg2, arg3);
                    break;
                }
                case "deleteMany" :{ 
                    String arg0 = (String)(context.args.get("0"));
                    org.bson.Document arg1 = JSON.parseObject(context.args.get("1").toString(), org.bson.Document.class);
                    retValue = proxy.deleteMany(arg0, arg1);
                    break;
                }
                case "updateOne" :{ 
                    String arg0 = (String)(context.args.get("0"));
                    org.bson.Document arg1 = JSON.parseObject(context.args.get("1").toString(), org.bson.Document.class);
                    org.bson.Document arg2 = JSON.parseObject(context.args.get("2").toString(), org.bson.Document.class);
                    org.bson.Document arg3 = JSON.parseObject(context.args.get("3").toString(), org.bson.Document.class);
                    retValue = proxy.updateOne(arg0, arg1, arg2, arg3);
                    break;
                }
                case "updateOne2" :{ 
                    String arg0 = (String)(context.args.get("0"));
                    org.bson.Document arg1 = JSON.parseObject(context.args.get("1").toString(), org.bson.Document.class);
                    org.bson.Document arg2 = JSON.parseObject(context.args.get("2").toString(), org.bson.Document.class);
                    retValue = proxy.updateOne(arg0, arg1, arg2);
                    break;
                }
                case "insertMany" :{ 
                    String arg0 = (String)(context.args.get("0"));
                    java.util.List arg1 = (java.util.ArrayList)JSONObject.parseArray(((JSONArray)context.args.get("1")).toJSONString(), org.bson.Document.class);
                    org.bson.Document arg2 = JSON.parseObject(context.args.get("2").toString(), org.bson.Document.class);
                    retValue = proxy.insertMany(arg0, arg1, arg2);
                    break;
                }
                case "insertMany2" :{ 
                    String arg0 = (String)(context.args.get("0"));
                    java.util.List arg1 = (java.util.ArrayList)JSONObject.parseArray(((JSONArray)context.args.get("1")).toJSONString(), org.bson.Document.class);
                    retValue = proxy.insertMany(arg0, arg1);
                    break;
                }
                case "insertOne" :{ 
                    String arg0 = (String)(context.args.get("0"));
                    org.bson.Document arg1 = JSON.parseObject(context.args.get("1").toString(), org.bson.Document.class);
                    retValue = proxy.insertOne(arg0, arg1);
                    break;
                }
                case "insertOne2" :{ 
                    String arg0 = (String)(context.args.get("0"));
                    org.bson.Document arg1 = JSON.parseObject(context.args.get("1").toString(), org.bson.Document.class);
                    org.bson.Document arg2 = JSON.parseObject(context.args.get("2").toString(), org.bson.Document.class);
                    retValue = proxy.insertOne(arg0, arg1, arg2);
                    break;
                }
                case "set_guid" :{
                    String guid = (String)(context.args.get("0"));
                    if(guidObject != null){
                        _maps.remove(context.guid);
                        _maps.put(guid, guidObject);
                    }
                    break;
                }
                default:{
                    break;
                }
            }
        }
        catch(Exception ex){
            if(ex instanceof com.csmake.InvokeException){
                com.csmake.InvokeException e = (com.csmake.InvokeException)ex;
                errorCode=e.error;
                exception=e.getMessage();
            }else{
                errorCode = 500;
                if(context.symbol.startsWith("constructor")){
                    exception = ex.toString();
                }
                else if(guidObject == null || proxy== null){
                    exception="org.dbcloud.mongodb.Collections is null pointer.";
                }else{
                    exception = ex.toString();
                }
            }
        }
        com.csmake.JSONReturn ret= new com.csmake.JSONReturn(errorCode, exception, retValue);
        ret.time=context.time;
        return ret;
    }
    private final com.csmake.ClassLoader classLoader;
    private java.util.HashMap<String, String > _params = null;
    private java.util.HashMap<String, com.csmake.GuidObject> _maps = null;
}//end of class Collections
