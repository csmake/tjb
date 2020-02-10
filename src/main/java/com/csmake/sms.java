package com.csmake;

import com.alibaba.fastjson.JSON;
import com.aliyuncs.CommonRequest;
import com.aliyuncs.CommonResponse;
import com.aliyuncs.DefaultAcsClient;
import com.aliyuncs.IAcsClient;
import com.aliyuncs.exceptions.ClientException;
import com.aliyuncs.exceptions.ServerException;
import com.aliyuncs.http.MethodType;
import com.aliyuncs.http.ProtocolType;
import com.aliyuncs.profile.DefaultProfile;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.Random;
import javax.inject.Singleton;
import org.bson.Document;

/*
pom.xml
<dependency>
  <groupId>com.aliyun</groupId>
  <artifactId>aliyun-java-sdk-core</artifactId>
  <version>4.0.3</version>
</dependency>
 */
@Singleton
public class sms extends Verify {

    private static char[] captchars = new char[]{'0', '1', '2', '3', '4', '5', '6', '7', '8', '9'};
    static sms singleton;

    /**
     * 返回单个实例
     *
     * @return
     */
    public static sms Singleton() {
        if (singleton == null) {
            singleton = new sms();
        }
        return singleton;
    }

    public Document sendVerifyCode(String supplier, String PhoneNumbers, int length) {
        switch (supplier) {
            case "中国建筑":
            case "中铝国际":
            case "工信部":
            case "北京公交":
            case "燕山石化":
            default:
                return sendVerifyCode(PhoneNumbers, length);
        }
    }

    public static String HTTP_POST(String URL, String Data) throws Exception {
        BufferedReader In = null;
        PrintWriter Out = null;
        HttpURLConnection HttpConn = null;
        try {
            java.net.URL url = new URL(URL);
            HttpConn = (HttpURLConnection) url.openConnection();
            HttpConn.setRequestMethod("POST");
            HttpConn.setDoInput(true);
            HttpConn.setDoOutput(true);

            Out = new PrintWriter(HttpConn.getOutputStream());
            Out.println(Data);
            Out.flush();

            if (HttpConn.getResponseCode() == HttpURLConnection.HTTP_OK) {
                StringBuffer content = new StringBuffer();
                String tempStr = "";
                In = new BufferedReader(new InputStreamReader(HttpConn.getInputStream()));
                while ((tempStr = In.readLine()) != null) {
                    content.append(tempStr);
                }
                In.close();
                return content.toString();
            } else {
                throw new Exception("HTTP_POST_ERROR_RETURN_STATUS：" + HttpConn.getResponseCode());
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            Out.close();
            HttpConn.disconnect();
        }
        return null;
    }

    public Document sendVerifyCode(String PhoneNumbers, int length) {
        /* 阿里云短信网关代码，替换相应的配置即可
        final String accessKeyId = "LTAIEIZiaB1EPk";
        final String accessKeySecret = "EDR3NxOtCS9FpZOHgmzSAl5hM56IH";
        DefaultProfile profile = DefaultProfile.getProfile("cn-hangzhou", accessKeyId, accessKeySecret);
        IAcsClient client = new DefaultAcsClient(profile);
        StringBuilder code = new StringBuilder();
        Random rand = new Random();
        while (length-- > 0) {
            code.append(captchars[rand.nextInt(captchars.length)]);
        }
        CommonRequest request = new CommonRequest();
        request.setProtocol(ProtocolType.HTTPS);
        request.setMethod(MethodType.POST);
        request.setDomain("dysmsapi.aliyuncs.com");
        request.setVersion("2017-05-25");
        request.setAction("SendSms");
        request.putQueryParameter("PhoneNumbers", PhoneNumbers);
        request.putQueryParameter("SignName", "赛思美科");
        request.putQueryParameter("TemplateCode", "SMS_161885451");
        request.putQueryParameter("TemplateParam", "{\"code\":\"" + code.toString() + "\"}");
        try {
            CommonResponse response = client.getCommonResponse(request);
            Document doc = JSON.parseObject(response.getData(), Document.class);
            if ("OK".equals(doc.get("Code"))) {
                long id = add(code.toString());
                doc.append("id", String.valueOf(id));
            }
            return doc;
        } catch (ServerException e) {
            e.printStackTrace();
        } catch (ClientException e) {
            e.printStackTrace();
        }
        return new Document("Message", "发送验证码失败，请联系管理员");
         */
        //下面是模拟操作
        StringBuilder code = new StringBuilder();
        Random rand = new Random();
        while (length-- > 0) {
            code.append(captchars[rand.nextInt(captchars.length)]);
        }
        Document doc = new Document("Code","OK");
        long id = add(code.toString());
        doc.append("id", String.valueOf(id));
        doc.append("vcode", code.toString());//正式版本不应该返回code
        return doc;
    }

}
