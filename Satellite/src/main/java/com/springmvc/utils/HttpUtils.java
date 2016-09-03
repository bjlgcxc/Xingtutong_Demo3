package com.springmvc.utils;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import net.sf.json.JSONObject;

public class HttpUtils {

	public static int doPost(String urlString, JSONObject josnObj) throws IOException {
		
		// 创建连接
		URL url = new URL(urlString);
		HttpURLConnection connection = (HttpURLConnection) url.openConnection();
		connection.setDoOutput(true);
		connection.setDoInput(true);
		connection.setRequestMethod("POST");
		connection.setUseCaches(false);
		connection.setInstanceFollowRedirects(true);
		connection.setRequestProperty("Content-Type","application/json; charset=UTF-8");  
		connection.connect();

		// POST请求
		DataOutputStream out = new DataOutputStream(connection.getOutputStream());
		out.write(josnObj.toString().getBytes("UTF-8"));
		out.flush();
		out.close();
		
		//读取响应
        BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
        String lines;
        StringBuffer sb = new StringBuffer("");
        while ((lines = reader.readLine()) != null) {
            lines = new String(lines.getBytes(), "utf-8");
            sb.append(lines);
        }
        String tmpString = sb.toString();
        String []tmp = tmpString.split(",");
        String []tmp1 = tmp[1].split(":");
        String []tmp2 = tmp1[1].split("\"");
        System.out.println(tmp2[1]);
        
        reader.close();
		
        //断开连接
		connection.disconnect();
		if(tmp2[1].isEmpty()){
			System.out.println("success");
        	return 1;
        }
		else {
			System.out.println("send faield");
			return 0;
		}
	}

}
