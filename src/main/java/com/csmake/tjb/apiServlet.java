/**
 * Copyright (c) 2012-2020 CSMAKE, Technology Co., Ltd. 
 *
 * Generate by csmake.com for java Sun Feb 09 10:31:21 CST 2020
 */
package com.csmake.tjb;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.annotation.WebServlet;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.oreilly.servlet.multipart.FilePart;
import com.oreilly.servlet.multipart.FileRenamePolicy;
import com.oreilly.servlet.multipart.MultipartParser;
import com.oreilly.servlet.multipart.Part;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Enumeration;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.bson.Document;


/**
 * The apiServlet interface.
 *
 * <p>Note: Generate by csmake for java .</p>
 *
 * {@link com.csmake.tjb.api}
 * @author www.csmake.com
 */
@WebServlet(name = "com.csmake.tjb.api", urlPatterns = {"/com.csmake.tjb.api/*"}, loadOnStartup=1)
public class apiServlet extends HttpServlet{
    public apiServlet(){
        _maps = new java.util.HashMap<>();
        classLoader = new com.csmake.ClassLoader();
    }

    @Override
    public void init() {
        com.csmake.tjb.api proxy = null;
        _params = new java.util.HashMap<>();
        java.util.Enumeration<String> names = this.getInitParameterNames();
        while (names.hasMoreElements()) {
            String name = names.nextElement();
            _params.put(name, this.getInitParameter(name));
        }
        java.lang.reflect.Method m = null;
        if (com.csmake.tjb.api.class.isAnnotationPresent(javax.inject.Singleton.class))
        {
            try{
                m = com.csmake.tjb.api.class.getDeclaredMethod("Singleton");
                if (m != null)
                {
                    proxy = (com.csmake.tjb.api) m.invoke(null);
                }
            }
            catch (Exception ex)
            {
                ex.printStackTrace();
            }
        }
        if (proxy == null){
            proxy = new com.csmake.tjb.api();
        }
        _maps.put("com.csmake.tjb.api", new com.csmake.GuidObject(proxy));
        try{
            m = com.csmake.tjb.api.class.getDeclaredMethod("csmakeInit", _params.getClass());
            if (m != null){
                _params.remove("guid");
                _params.put("guid", "com.csmake.tjb.api");
                m.invoke(proxy, _params);
            }
        }
        catch (Exception ex)
        {
            ex.printStackTrace();
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
        try
        {
            String args = request.getParameter("call");
            String url = request.getRequestURI().replace(request.getContextPath(), "");
            System.out.print(url);
            if (args != null)
            {
                com.csmake.JSONCall call = JSON.parseObject(java.net.URLDecoder.decode(request.getParameter("call"), "UTF8"), com.csmake.JSONCall.class);
                handleRequest(call, request, response);
            }
            else if(url.contains("/file/"))
            {
                Document prop = new Document();
                Enumeration<String> keys = request.getParameterNames();
                while (keys.hasMoreElements())
                {
                    String key = keys.nextElement();
                    String value = request.getParameter(key);
                    if (value != null && !value.isEmpty())
                    {
                        prop.put(key, value.trim());
                    }
                }
                if (prop.isEmpty()||!prop.containsKey("id"))
                {
                    int i = url.lastIndexOf("/");
                    if (i > 1)
                    {
                        String id = java.net.URLDecoder.decode(url.substring(i + 1), "UTF8");
                        int dot = id.indexOf(".");
                        if (dot != -1)
                        {
                            id = id.substring(0, dot);
                        }
                        prop.append("id", id);
                    }
                }
                Document file = null;
                java.lang.reflect.Method m = com.csmake.tjb.api.class.getDeclaredMethod("csmakeGetFile", org.bson.Document.class);
                if (m != null)
                {
                    String field=(String)prop.remove("field");
                    if(field==null||field.isEmpty())
                    {
                        field="data";
                    }
                    String conv=(String)prop.remove("conv");
                    if(conv==null||conv.isEmpty())
                    {
                        conv="";
                    }
                    file = (Document) m.invoke(_maps.get("com.csmake.tjb.api").getObject(), prop);
                    if (file != null && file.containsKey(field))
                    {
                        String type = (String) file.get("contentType");
                        if (type == null)
                        {
                            type = "application/octet-stream";
                        }
                        response.setContentType(type);
                        Object raw=file.get(field);
                        byte[] data=new byte[0];
                        if(raw instanceof org.bson.types.Binary)
                        {
                            data = ((org.bson.types.Binary) raw).getData();
                        }
                        else if(raw instanceof String)
                        {
                            if(conv.contains("atob"))
                            {
                                data=java.util.Base64.getDecoder().decode((String)raw);
                            }
                            else
                            {
                                data=((String) raw).getBytes("utf-8");
                            }
                        }
                        long fileLength = data.length; // 记录文件大小
                        long pastLength = 0; // 记录已下载文件大小
                        long contentLength = 0; // 客户端请求的字节总量
                        String contentRange = "";
                        if (request.getHeader("Range") != null)
                        {
                            // 客户端请求的下载的文件块的开始字节
                            response.setStatus(javax.servlet.http.HttpServletResponse.SC_PARTIAL_CONTENT);
                            String rangeBytes = request.getHeader("Range").replaceAll("bytes=", "");// 记录客户端传来的形如“bytes=27000-”或者“bytes=27000-39000”的内容
                            String[] tmps = rangeBytes.split("-");
                            pastLength = Long.parseLong(tmps[0].trim());
                            if (tmps.length == 2)
                            {
                                String str = tmps[1].trim();
                                long toLength = str.length() > 0 ? Long.parseLong(str) : fileLength;
                                contentLength = toLength - pastLength+1;
                            }
                            else
                            {
                                contentLength = fileLength - pastLength;
                            }
                            contentRange = new StringBuffer("bytes ").append(Long.toString(pastLength)).append("-").append(Long.toString(pastLength+contentLength - 1)).append("/").append(Long.toString(fileLength)).toString();
                            response.setHeader("Accept-Ranges", "bytes");// 如果是第一次下,还没有断点续传,状态是默认的 200,无需显式设置;响应的格式是:HTTP/1.1 200 OK
                            response.setHeader("Content-Range", contentRange);
                        }
                        else
                        {
                            // 从开始进行下载
                            contentLength = fileLength; // 客户端要求全文下载
                        }
                        String filename = file.getString("filename");
                        if (filename != null && !filename.isEmpty())
                        {
                            response.setHeader("Content-disposition", "attachment; filename=" + java.net.URLEncoder.encode(filename, "UTF-8"));
                        }
                        response.addHeader("Content-Length", String.valueOf(contentLength));
                        try (OutputStream out = response.getOutputStream())
                        {
                            try
                            {
                                if (contentLength == fileLength)
                                {
                                    out.write(data);
                                }
                                else if (pastLength < data.length)
                                {
                                    out.write(data, (int) pastLength, (int) contentLength);
                                }
                            }
                            catch (Exception ex)
                            {
                                System.err.println(ex.getMessage());
                            }
                        }
                    }
                    else
                    {
                        response.setContentType("text/html;charset=UTF-8");
                    }
                }
            }
        }
        catch (Exception ex)
        {
            StringBuilder sb = new StringBuilder();
            sb.append("{error:500,message:\"").append(ex.toString()).append("\",value:''}");
            byte[] utf8 = sb.toString().getBytes("UTF-8");
            response.setContentLength(utf8.length);
            try (javax.servlet.ServletOutputStream out = response.getOutputStream())
            {
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
            String url = request.getRequestURI().replace(request.getContextPath(), "");
            System.out.print(url);
            int i = url.lastIndexOf("/");
            String cmd = "";
            if (i > 1)
            {
                cmd = java.net.URLDecoder.decode(url.substring(i + 1), "UTF8");
                int dot = cmd.indexOf(".");
                if (dot != -1)
                {
                    cmd = cmd.substring(0, dot);
                }
            }
            switch (cmd)
            {
                case "file":
                {
                    //file upload
                    try
                    {
                        java.lang.reflect.Method m = com.csmake.tjb.api.class.getDeclaredMethod("csmakeSaveFile", byte[].class, org.bson.Document.class);
                        if (m != null)
                        {
                            FileRenamePolicy rfrp = new DefaultFileRenamePolicy();
                            MultipartParser mp = new MultipartParser(request, 20 * 1024 * 1024, true, true, "UTF-8");
                            FilePart filePart = null;
                            Part part = null;
                            Document prop = new Document();
                            Enumeration<String> keys = request.getParameterNames();
                            while (keys.hasMoreElements())
                            {
                                String key = keys.nextElement();
                                String value = request.getParameter(key);
                                if (value != null && !value.isEmpty())
                                {
                                    prop.put(key, value.trim());
                                }
                            }
                            try (PrintWriter out = response.getWriter())
                            {
                                try
                                {
                                    while ((part = mp.readNextPart()) != null)
                                    {
                                        if (part.isParam())
                                        {
                                            prop.put(part.getName(), ((com.oreilly.servlet.multipart.ParamPart) part).getStringValue("UTF-8"));
                                        }
                                        else if (part.isFile())
                                        {
                                            // it's a file part
                                            filePart = (FilePart) part;
                                            filePart.setRenamePolicy(rfrp);
                                            String fileName = filePart.getFileName();
                                            if (!prop.containsKey("filename"))
                                            {
                                                prop.put("filename", fileName);
                                            }
                                            String ret = (String) m.invoke(com.csmake.tjb.api.Singleton(), org.apache.commons.io.IOUtils.toByteArray(filePart.getInputStream()), prop);
                                            out.println(ret);
                                            out.flush();
                                            break;
                                        }
                                    }
                                }
                                catch (Exception ex)
                                {
                                    out.println(String.format("{\"uploaded\":0,\"error\":{ \"message\":\"%s\"}}", ex.getMessage()));
                                    ex.printStackTrace();
                                }
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                    }
                    break;
                }
                default://json调用
                {
                    com.csmake.JSONCall call = JSON.parseObject(request.getInputStream(), com.csmake.JSONCall.class);
                    call.session=request.getSession();
                    handleRequest(call, request, response);
                    break;
                }
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

    protected void handleRequest(com.csmake.JSONCall context, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType(context.rType!=null? context.rType:"application/json;charset=UTF-8");
        com.csmake.JSONReturn ret = call(context);
        byte[] utf8 = ((context.vOnly&&ret.value instanceof String)? (String)ret.value : JSON.toJSONString(context.vOnly? ret.value: ret)).getBytes("UTF-8");
        response.setContentLength(utf8.length);
        try (javax.servlet.ServletOutputStream out = response.getOutputStream()) {
            out.write(utf8);
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
        com.csmake.tjb.api proxy = (com.csmake.tjb.api)(guidObject!=null?guidObject.getObject():null);
        try
        {
            switch (context.symbol){
                case "constructor" :{ 
                    Class<?> clazz = classLoader.getInstance().loadClass(context.guid);
                    boolean single = clazz != null && clazz.isAnnotationPresent(javax.inject.Singleton.class);
                    if (single) {
                        guidObject = (com.csmake.GuidObject) _maps.get("com.csmake.tjb.api");
                        if (guidObject != null) {
                            context.guid = "com.csmake.tjb.api";
                        }
                    }
                    if (guidObject == null && clazz != null) {
                        if (single) {
                            java.lang.reflect.Method m = clazz.getDeclaredMethod("Singleton");
                            if (m != null) {
                                proxy = (com.csmake.tjb.api) m.invoke(null);
                                context.guid = "com.csmake.tjb.api";
                            }
                        }
                        if (proxy == null) {
                            java.lang.reflect.Constructor con = clazz.getConstructor();
                            proxy = (com.csmake.tjb.api) con.newInstance();
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
                /** public methods */
                case "deleteUser" :{ 
                    String arg0 = (String)(context.args.get("0"));String arg1 = (String)(context.args.get("1"));String arg2 = (String)(context.args.get("2"));
                    retValue = proxy.deleteUser(arg0, arg1, arg2);
                    break;
                }
                case "fetchUsers" :{ 
                    String arg0 = (String)(context.args.get("0"));String arg1 = (String)(context.args.get("1"));java.util.ArrayList arg2 = (java.util.ArrayList)JSONObject.parseArray(((JSONArray)context.args.get("2")).toJSONString(), String.class);String arg3 = (String)(context.args.get("3"));String arg4 = (String)(context.args.get("4"));String arg5 = (String)(context.args.get("5"));
                    retValue = proxy.fetchUsers(arg0, arg1, arg2, arg3, arg4, arg5);
                    break;
                }
                case "getTemplate" :{ 
                    String arg0 = (String)(context.args.get("0"));String arg1 = (String)(context.args.get("1"));boolean arg2 = (boolean)(context.args.get("2"));
                    retValue = proxy.getTemplate(arg0, arg1, arg2);
                    break;
                }
                case "getUsers" :{ 
                    String arg0 = (String)(context.args.get("0"));String arg1 = (String)(context.args.get("1"));String arg2 = (String)(context.args.get("2"));String arg3 = (String)(context.args.get("3"));String arg4 = (String)(context.args.get("4"));
                    retValue = proxy.getUsers(arg0, arg1, arg2, arg3, arg4);
                    break;
                }
                case "getVirusMap" :{ 
                    retValue = proxy.getVirusMap();
                    break;
                }
                case "group" :{ 
                    String arg0 = (String)(context.args.get("0"));String arg1 = (String)(context.args.get("1"));org.bson.Document arg2 = JSON.parseObject(context.args.get("2").toString(), org.bson.Document.class);
                    retValue = proxy.group(arg0, arg1, arg2);
                    break;
                }
                case "htmlGet" :{ 
                    String arg0 = (String)(context.args.get("0"));
                    retValue = com.csmake.tjb.api.htmlGet(arg0);
                    break;
                }
                case "updateData" :{ 
                    String arg0 = (String)(context.args.get("0"));String arg1 = (String)(context.args.get("1"));String arg2 = (String)(context.args.get("2"));
                    retValue = proxy.updateData(arg0, arg1, arg2);
                    break;
                }
                case "updateDataVer20" :{ 
                    String arg0 = (String)(context.args.get("0"));String arg1 = (String)(context.args.get("1"));String arg2 = (String)(context.args.get("2"));
                    retValue = proxy.updateDataVer20(arg0, arg1, arg2);
                    break;
                }
                case "updateDataVer30" :{ 
                    String arg0 = (String)(context.args.get("0"));String arg1 = (String)(context.args.get("1"));String arg2 = (String)(context.args.get("2"));java.util.ArrayList arg3 = (java.util.ArrayList)JSONObject.parseArray(((JSONArray)context.args.get("3")).toJSONString(), String.class);
                    retValue = proxy.updateDataVer30(arg0, arg1, arg2, arg3);
                    break;
                }
                case "updateUsers" :{ 
                    String arg0 = (String)(context.args.get("0"));String arg1 = (String)(context.args.get("1"));java.util.ArrayList arg2 = (java.util.ArrayList)JSONObject.parseArray(((JSONArray)context.args.get("2")).toJSONString(), org.bson.Document.class);
                    retValue = proxy.updateUsers(arg0, arg1, arg2);
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
                    exception="com.csmake.tjb.api is null pointer.";
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
}//end of class api
