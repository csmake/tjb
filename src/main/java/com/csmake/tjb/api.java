/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.csmake.tjb;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.serializer.SerializeConfig;
import com.csmake.InvokeException;
import com.csmake.SslUtils;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
import com.mongodb.client.AggregateIterable;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.model.UpdateOptions;
import com.mongodb.client.result.UpdateResult;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.bson.Document;
import org.dbcloud.mongodb.Collections;

/**
 *
 * @author zhouhu
 */
public class api {

    static api singleton;

    /**
     * 返回单个实例
     *
     * @return
     */
    public static api Singleton() {
        if (singleton == null) {
            singleton = new api();
        }
        return singleton;
    }
    long VirusMapCheckTime = 0;
    String VirusMapHtml = "";
    Collections db = new org.dbcloud.mongodb.Collections();

    /**
     * 发送http get请求
     *
     * @param getUrl
     * @return
     */
    static public String htmlGet(String getUrl) {
        StringBuilder sb = new StringBuilder();
        InputStreamReader isr = null;
        BufferedReader br = null;
        try {
            URL url = new URL(getUrl);
            if ("https".equalsIgnoreCase(url.getProtocol())) {
                SslUtils.ignoreSsl();
            }
            URLConnection urlConnection = url.openConnection();
            urlConnection.setConnectTimeout(3);
            urlConnection.setAllowUserInteraction(false);
            try (InputStream stream = url.openStream()) {
                isr = new InputStreamReader(stream);
                br = new BufferedReader(isr);
                String line;
                while ((line = br.readLine()) != null) {
                    sb.append(line);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
        }
        return sb.toString();
    }

    public String getVirusMap() {
        return "https://voice.baidu.com/act/newpneumonia/newpneumonia";
    }

    public Document updateData(String suffix, String id, String date) {
        Document doc = new Document();
        com.mongodb.client.MongoCollection<Document> diary = db.getCollection(String.format("diary%s", suffix));
        // match(相当于 WHERE 或者 HAVING )
        BasicDBObject query = new BasicDBObject();
        BasicDBObject[] array = {new BasicDBObject("pid", id), new BasicDBObject("date", date)};
        query.append("$and", array);
        BasicDBObject match = new BasicDBObject("$match", query);

        //group（相当于 GROUP BY）
        String[] keys = {"family", "goto", "sickness"};
        for (String key : keys) {
            BasicDBObject group = new BasicDBObject("$group", new BasicDBObject("_id", "$" + key).append("count", new BasicDBObject("$sum", 1)));
            List<BasicDBObject> queryList = new ArrayList<>();
            queryList.add(match);
            queryList.add(group);
            Document count = new Document();
            AggregateIterable<Document> cursors = diary.aggregate(queryList);
            try (MongoCursor<Document> ret = cursors.iterator()) {
                while (ret.hasNext()) {
                    Document document = ret.next();
                    String _id = document.getString("_id");
                    count.append(_id == null || _id.isEmpty() ? "未填写" : _id, document.get("count"));
                }
            }
            doc.append(key, count);
        }
        doc.append("total", db.count(String.format("user%s", suffix), new Document("pid", id)));
        doc.append("report", db.count(String.format("diary%s", suffix), new Document("pid", id).append("date", date)));
        doc = db.findOneAndUpdate("company", new Document("id", id), new Document("$set", new Document(date, doc)), new Document("returnNew", true));
        return doc;
    }

    public Document updateDataVer20(String suffix, String id, String date) throws InvokeException {
        ArrayList<Document> list = db.find("company", new Document("id", id), 0, 1);
        if (list.size() < 1) {
            throw new InvokeException(400, "公司信息不存在");
        }
        Document company = list.get(0);
        com.mongodb.client.MongoCollection<Document> diary = db.getCollection(String.format("diary%s", suffix));
        // match(相当于 WHERE 或者 HAVING )
        BasicDBObject query = new BasicDBObject();
        BasicDBObject[] array = {new BasicDBObject("pid", id), new BasicDBObject("date", date)};
        query.append("$and", array);
        BasicDBObject match = new BasicDBObject("$match", query);

        Document tpl = company.get("template", Document.class);
        if (tpl == null) {
            throw new InvokeException(400, "问卷模板不存在");
        }
        list = (ArrayList) JSON.parseArray(JSON.toJSONString(tpl.get("subjects")), Document.class);
        Document doc = new Document();
        ArrayList<Document> report = new ArrayList();
        for (int i = 0; i < list.size(); i++) {
            Document sbj = list.get(i);
            if (sbj.getBoolean("calc", true)) {
                String key = sbj.getString("key");
                if (key == null || key.isEmpty()) {
                    continue;
                }
                BasicDBObject group = new BasicDBObject("$group", new BasicDBObject("_id", "$" + key).append("count", new BasicDBObject("$sum", 1)));
                List<BasicDBObject> queryList = new ArrayList<>();
                queryList.add(match);
                if ("checkbox".equals(sbj.getOrDefault("type", ""))) {//数组形式存在
                    queryList.add(new BasicDBObject("$unwind", "$" + key));
                }
                queryList.add(group);
                Document count = new Document();
                JSONArray items = sbj.get("items", JSONArray.class);
                if (items != null) {//初始化所有可能的答案
                    items.forEach((it) -> {
                        count.put(((JSONObject) it).getString("label"), 0);
                    });
                }
                AggregateIterable<Document> cursors = diary.aggregate(queryList);
                try (MongoCursor<Document> ret = cursors.iterator()) {
                    while (ret.hasNext()) {
                        Document document = ret.next();
                        String myid = document.getString("_id");
                        if (myid == null || "".equals(myid)) {
                            myid = "未填报";
                        }
                        count.append(myid, document.get("count"));
                    }
                }
                report.add(new Document("key", key).append("title", sbj.get("title")).append("items", count));
            }
        }
        doc.append("total", db.count(String.format("user%s", suffix), new Document("pid", id)));
        doc.append("report", db.count(String.format("diary%s", suffix), new Document("pid", id).append("date", date)));
        doc.append("subjects", report);
        doc.append("date", date);

        doc = db.findOneAndUpdate("report" + suffix, new Document("pid", id).append("date", date), new Document("$set", doc), new Document("returnNew", true).append("upsert", true));
        return doc;
    }

    private ArrayList<Document> getTemplateGroup(String key, ArrayList<String> group) {
        if (group != null && group.size() > 0) {
            ArrayList<Document> or = new ArrayList();
            for (int i = 0; i < group.size(); i++) {
                String department = group.get(i);
                String[] strs = department.split("[-]+");
                StringBuilder sb = new StringBuilder();
                for (int j = 0; j < strs.length; j++) {
                    if (j > 0) {
                        sb.append("-");
                    }
                    sb.append(strs[j]);
                    or.add(new Document(key, sb.toString()));
                }
            }
            return or;
        }
        return new ArrayList();
    }

    private ArrayList<Document> getDiaryGroup(String key, ArrayList<String> group) {
        if (group != null && group.size() > 0) {
            ArrayList<Document> or = new ArrayList();
            for (int i = 0; i < group.size(); i++) {
                String department = group.get(i);
                or.add(new Document(key, new Document("$regex", String.format("^%s.*", department))));
            }
            return or;
        }
        return new ArrayList();
    }

    private BasicDBObject[] getDiaryGroup2(String key, ArrayList<String> group) {
        ArrayList<BasicDBObject> list = new ArrayList();
        if (group != null && group.size() > 0) {
            for (int i = 0; i < group.size(); i++) {
                String department = group.get(i);
                list.add(new BasicDBObject(key, new BasicDBObject("$regex", String.format("^%s.*", department))));
            }
        }
        return list.toArray(new BasicDBObject[0]);
    }

    public Document updateDataVer30(String suffix, String pid, String date, ArrayList<String> groupscope) throws InvokeException {
        Document tfilter = new Document("pid", pid);
        ArrayList<Document> or = getTemplateGroup("group", groupscope);
        if (or.size() > 0) {
            tfilter.append("$or", or);
        }
        ArrayList<Document> list = db.find("template", new Document(tfilter).append("private", true));
        for (int i = 0; i < list.size(); i++) {
            Document doc = list.get(i);
            String imp = doc.getString("import");
            if (imp != null && !imp.isEmpty()) {
                ArrayList<Document> ls = db.find("template", new Document("id", imp));
                if (ls.size() > 0) {
                    Document ok = ls.get(0);
                    ok.replace("_id", doc.get("_id"));
                    ok.replace("id", doc.get("id"));
                    list.set(i, ok);
                }
            }
        }
        Document tpl = new Document();
        for (int i = 0; i < list.size(); i++) {
            Document doc = list.get(i);
            ArrayList<Document> subjects = doc.get("subjects", ArrayList.class);
            for (int j = 0; j < subjects.size(); j++) {
                Document sbj = subjects.get(j);
                String key = sbj.getString("key");
                tpl.append(key, sbj);
            }
        }

        com.mongodb.client.MongoCollection<Document> diary = db.getCollection(String.format("diary%s", suffix));
        // match(相当于 WHERE 或者 HAVING )
        BasicDBObject query = new BasicDBObject();
        BasicDBObject[] array = {new BasicDBObject("pid", pid), new BasicDBObject("date", date)};
        query.append("$and", array);
        BasicDBObject[] darray = getDiaryGroup2("department", groupscope);
        if (darray.length > 0) {
            query.append("$or", darray);
        }
        BasicDBObject match = new BasicDBObject("$match", query);
        if (tpl == null || tpl.size() < 1) {
            throw new InvokeException(400, "问卷模板不存在");
        }
        Document doc = new Document();
        ArrayList<Document> report = new ArrayList();
        for (String s : tpl.keySet()) {
            Document sbj = (Document) tpl.get(s);
            if (sbj.getBoolean("calc", true)) {
                String key = sbj.getString("key");
                if (key == null || key.isEmpty()) {
                    continue;
                }
                BasicDBObject group = new BasicDBObject("$group", new BasicDBObject("_id", "$" + key).append("count", new BasicDBObject("$sum", 1)));
                List<BasicDBObject> queryList = new ArrayList<>();
                queryList.add(match);
                if ("checkbox".equals(sbj.getOrDefault("type", ""))) {//数组形式存在
                    queryList.add(new BasicDBObject("$unwind", "$" + key));
                }
                queryList.add(group);
                Document count = new Document();
                ArrayList<Document> items = (ArrayList<Document>) sbj.get("items");
                if (items != null) {//初始化所有可能的答案
                    items.forEach((it) -> {
                        count.put(((Document) it).getString("label"), 0);
                    });
                }
                AggregateIterable<Document> cursors = diary.aggregate(queryList);
                try (MongoCursor<Document> ret = cursors.iterator()) {
                    while (ret.hasNext()) {
                        Document document = ret.next();
                        String myid = document.getString("_id");
                        if (myid == null || "".equals(myid)) {
                            myid = "未填报";
                        }
                        count.append(myid, document.get("count"));
                    }
                }
                report.add(new Document("key", key).append("title", sbj.get("title")).append("items", count));
            }
        }
        ArrayList<Document> departs = getDiaryGroup("department", groupscope);
        if (departs.size() > 0) {
            doc.append("total", db.count(String.format("user%s", suffix), new Document("pid", pid).append("$or", departs)));
            doc.append("report", db.count(String.format("diary%s", suffix), new Document("pid", pid).append("date", date).append("$or", departs)));
        } else {
            doc.append("total", db.count(String.format("user%s", suffix), new Document("pid", pid)));
            doc.append("report", db.count(String.format("diary%s", suffix), new Document("pid", pid).append("date", date)));
        }
        doc.append("subjects", report);
        doc.append("date", date);

        doc = db.findOneAndUpdate("report" + suffix, new Document("pid", pid).append("date", date).append("group", groupscope), new Document("$set", doc), new Document("returnNew", true).append("upsert", true));
        return doc;
    }

    public ArrayList<String> group(String table, String key, Document filter) throws InvokeException {
        ArrayList<String> list = new ArrayList<String>();
        BasicDBObject match = new BasicDBObject("$match", filter);
        BasicDBObject group = new BasicDBObject("$group", new BasicDBObject("_id", "$" + key).append("count", new BasicDBObject("$sum", 1)));
        List<BasicDBObject> queryList = new ArrayList<>();
        queryList.add(match);
        queryList.add(group);
        AggregateIterable<Document> cursors = db.getCollection(table).aggregate(queryList);
        try (MongoCursor<Document> ret = cursors.iterator()) {
            while (ret.hasNext()) {
                Document document = ret.next();
                String myid = document.getString("_id");
                if (myid != null && !myid.isEmpty()) {
                    list.add(myid);
                }
            }
        }
        return list;
    }

    public int updateUsers(String suffix, String pid, ArrayList<Document> list) throws InvokeException {
        int count = 0;
        UpdateOptions opt = new UpdateOptions();
        opt.upsert(true);
        Document filter = new Document("pid", pid);
        com.mongodb.client.MongoCollection<Document> user = db.getCollection(String.format("user%s", suffix));
        for (int i = 0; i < list.size(); i++) {
            Document doc = list.get(i);
            ArrayList<Document> or = new ArrayList();
            String phone = doc.getOrDefault("phone", "").toString();
            String id = doc.getOrDefault("id", "").toString();
            String cid = doc.getOrDefault("cid", "").toString();
            String email = doc.getOrDefault("email", "").toString();
            String name = doc.getOrDefault("name", "").toString();
            String department = doc.getOrDefault("department", "").toString();
            if (phone.length() == 11) {
                or.add(new Document("phone", phone));
            }
            if (id.length() > 0) {
                or.add(new Document("id", id));
            }
            if (cid.length() > 0) {
                or.add(new Document("cid", cid));
            }
            if (email.length() > 0) {
                or.add(new Document("email", email));
            }
            if (or.size() > 0) {
                filter.append("$or", or);
            } else if (name.length() > 0 && department.length() > 0) {
                filter.append("name", name).append("department", department);
            } else {
                throw new InvokeException(400, String.format("缺少姓名和部门信息：%s", doc.toJson()));
            }
            UpdateResult ret = user.updateOne(filter, new Document("$set", doc), opt);
            count += ret.getMatchedCount();
            if (ret.getUpsertedId() != null) {
                count++;
            }
        }
        return count;
    }

    public int deleteUser(String suffix, String pid, String _id) {
        int count = 0;
        count += db.deleteOne(String.format("user%s", suffix), new Document("_id", _id)).getDeletedCount();
        return count;
    }

    public ArrayList<Document> fetchUsers(String suffix, String pid, ArrayList<String> department, String date, String key, String value) {
        /*
        try {
            SendTest.main(new String[0]);
        } catch (IOException ex) {
            Logger.getLogger(api.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InterruptedException ex) {
            Logger.getLogger(api.class.getName()).log(Level.SEVERE, null, ex);
        }*/

        Document projection = new Document("projection", new Document("phone", true).append("id", true).append("name", true).append("department", true).append("admin", true));
        Document filter = new Document("pid", pid);
        ArrayList<Document> or = getDiaryGroup("department", department);
        if (or.size() > 0) {
            filter.append("$or", or);
        }
        Document userFilter = new Document(filter);
        if (date != null && !date.isEmpty()) {
            filter.append("date", date);
        }
        ArrayList<String> ids = new ArrayList();
        projection.append("sort", new Document("name", 1));
        switch (key) {
            case "":
            case "all":
            case "所有": {
                return db.find(String.format("user%s", suffix), userFilter, projection);
            }
            case "未上报": {
                ArrayList<Document> users = db.find(String.format("diary%s", suffix), filter);
                for (int i = 0; i < users.size(); i++) {
                    ids.add(users.get(i).getString("name"));
                }
                userFilter.append("name", new Document("$nin", ids));
                return db.find(String.format("user%s", suffix), userFilter, projection);
            }
            default: {
                if ("未填报".equals(value)) {
                    filter.append(key, new Document("$exists", false));
                } else {
                    filter.append(key, value);
                }
                return db.find(String.format("diary%s", suffix), filter, projection);
            }
        }
    }

    public ArrayList<Document> getUsers(String suffix, String pid, String department, String date, String kind) {
        Document projection = new Document("projection", new Document("phone", true).append("name", true).append("department", true));
        Document filter = new Document("pid", pid);
        if (department != null && !department.isEmpty()) {
            filter.append("department", department);
        }
        Document userFilter = new Document(filter);
        filter.append("date", date);
        ArrayList<String> ids = new ArrayList();
        projection.append("sort", new Document("name", 1));
        switch (kind) {
            case "":
            case "所有": {
                return db.find(String.format("user%s", suffix), userFilter, projection);
            }
            case "未上报": {
                ArrayList<Document> users = db.find(String.format("diary%s", suffix), filter);
                for (int i = 0; i < users.size(); i++) {
                    ids.add(users.get(i).getString("name"));
                }
                userFilter.append("name", new Document("$nin", ids));
                return db.find(String.format("user%s", suffix), userFilter, projection);
            }
            case "疑似":
            case "确诊":
            case "感冒":
            case "未感染": {
                filter.append("sickness", kind);
                return db.find(String.format("diary%s", suffix), filter, projection);
            }
            case "前往疫区":
            case "未前往疫区": {
                filter.append("goto", kind);
                return db.find(String.format("diary%s", suffix), filter, projection);
            }
            case "家属疑似":
            case "家属确诊":
            case "家属未感染": {
                filter.append("family", kind.substring(2));
                return db.find(String.format("diary%s", suffix), filter, projection);
            }
        }
        return new ArrayList();
    }

    public ArrayList<Document> getTemplate(String pid, String department, boolean isprivate) {
        Document filter = new Document("pid", pid).append("private", isprivate);
        if (department != null && !department.isEmpty()) {
            String[] strs = department.split("[-]+");
            StringBuilder sb = new StringBuilder();
            ArrayList<Document> or = new ArrayList();
            for (int i = 0; i < strs.length; i++) {
                if (i > 0) {
                    sb.append("-");
                }
                sb.append(strs[i]);
                or.add(new Document("group", sb.toString()));
            }
            if (or.size() > 0) {
                filter.append("$or", or);
            }
        }
        ArrayList<Document> list = db.find("template", filter, new Document("sort", new Document("sn", 1)));
        for (int i = 0; i < list.size(); i++) {
            Document doc = list.get(i);
            String imp = doc.getString("import");
            if (imp != null && !imp.isEmpty()) {
                ArrayList<Document> ls = db.find("template", new Document("id", imp));
                if (ls.size() > 0) {
                    Document ok = ls.get(0);
                    ok.replace("_id", doc.get("_id"));
                    ok.replace("id", doc.get("id"));
                    list.set(i, ok);
                }
            }
        }
        return list;
    }
}
