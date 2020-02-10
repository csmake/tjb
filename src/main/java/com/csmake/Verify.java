/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.csmake;

import java.util.ArrayList;
import java.util.Date;

/**
 *
 * @author zhouh
 */
public class Verify {

    protected ArrayList<KeyValue> list = new ArrayList();

    protected class KeyValue {

        public KeyValue(long _id, String _code) {
            id = _id;
            code = _code;
            checked = false;
        }
        public long id;
        public boolean checked;
        public String code;
    }

    private void clean() {
        long expire = new Date().getTime() - (10 * 60 * 1000);
        while (list.size() > 0) {//删除过时的
            if (list.get(0).id < expire) {
                list.remove(0);
            } else {
                break;
            }
        }
    }

    protected long add(String code) {
        long id = new Date().getTime();
        clean();
        if (list.size() > 0 && list.get(list.size() - 1).id == id) {
            id++;
        }
        list.add(new KeyValue(id, code.toLowerCase()));
        return id;
    }

    public boolean check(String id, String code) {
        code = code.toLowerCase();
        long time = Long.valueOf(id);
        clean();
        for (int i = list.size() - 1; i >= 0; i--) {
            KeyValue kv = list.get(i);
            if (kv.id == time) {
                return kv.checked || (kv.checked = kv.code.compareTo(code) == 0);
            }
        }
        return false;
    }

    public boolean checked(String id) {
        long time = Long.valueOf(id);
        clean();
        for (int i = list.size() - 1; i >= 0; i--) {
            KeyValue kv = list.get(i);
            if (kv.id == time) {
                kv.checked = true;
                return kv.checked;
            }
        }
        return false;
    }

    public void csmakeInit(java.util.HashMap<String, String> args) {
    }
}
