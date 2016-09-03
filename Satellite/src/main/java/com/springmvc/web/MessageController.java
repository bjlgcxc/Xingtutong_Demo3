package com.springmvc.web;

import java.io.IOException;
import java.net.URLDecoder;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.springmvc.entity.Message;
import com.springmvc.service.MessageService;
import com.springmvc.utils.DateJsonValueProcessor;
import com.springmvc.utils.HttpUtils;
import com.springmvc.utils.MyWebSocketHandler;

@Controller
@RequestMapping(value="/message")
public class MessageController {
	
	public static final Log log = LogFactory.getLog(MessageController.class);
	public static String url = ""; 
	public static String ICID = "";
	
	@Autowired
	MessageService messageService;
	@Autowired
	MyWebSocketHandler websocket;
	
	
	/*
	 * 与指挥机的连接确认
	 */
	@ResponseBody
	@RequestMapping(value="/sayHello")
	public JSONObject sayHello(@RequestBody JSONObject jsonObj) throws IOException{
		url = jsonObj.getString("url");
		JSONObject json = new JSONObject();
		//send
		int res = HttpUtils.doPost(url + "/sayHello",json);
		if(res==1){
			json.put("ok",true);
		}
		else{
			json.put("ok", false);
		}
		
		log.info("get url for message sending");
		return json;
	}
	
	
	/*
	 * 获取指挥机的ICID
	 */
	@ResponseBody
	@RequestMapping(value="/saveICID")
	public JSONObject saveICID(@RequestBody JSONObject jsonObj) throws IOException{
		
		ICID = jsonObj.getString("ICID");
		
		JSONObject json = new JSONObject();
		json.put("ok", true);
		
		log.info("get ICID for message sending");
		return json;
	}
	
	
	/*
	 * 保存指挥机接收到的短消息
	 */
	@ResponseBody
	@RequestMapping(value="/saveMessage")
	@SuppressWarnings({ "deprecation", "unchecked" })
	public JSONObject saveMessage(@RequestBody JSONArray jsonArray) throws IOException{
		//save
		List<Message> messageList = JSONArray.toList(jsonArray, Message.class);
		for(Message message:messageList){
			message.setTo(ICID);
		}
		messageService.saveMessage(messageList);
		log.info("save message：" + messageList.get(0).getContent());
		//inform 
		websocket.sendMessage();
		//return
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("ok",true);
		jsonObj.put("errorMsg", "");
	
		return jsonObj;
	}
		
	
	/*
	 *  发送短消息
	 */
	@ResponseBody
	@RequestMapping(value="/sendMessage")
	public int sendMessage(Message message,HttpServletRequest request) throws IOException{
		
		message.setType(1);
		message.setFrom(ICID);
		message.setTime(System.currentTimeMillis());
		message.setContent(URLDecoder.decode(message.getContent(),"utf-8"));
		
		//send
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("targetID",message.getTo());
		jsonObj.put("message",message.getContent());
		int res = HttpUtils.doPost(url + "/sendMessage",jsonObj);
		//save
		if(res == 1){
			messageService.saveMessage(message);
			log.info("send message：" + message.getContent());
			return 1;
		}
		else{
			return 0;
		}
	}
	
	
	/*
	 *  获取所有的短消息(接收、发送)
	 */
	@ResponseBody
	@RequestMapping(value="/getAllMessage")
	public JSONArray getMessage(){
		System.out.println("get data for table2");
		List<Message> messageList = messageService.getAllMessage();
		return JSONArray.fromObject(messageList);
	}

	
	@ResponseBody
	@RequestMapping(value="/getPageMessage")
	public JSONObject getPageMessage(@RequestParam long rows,@RequestParam long page){
		Long total = 0L;
		JSONObject jsonObj = new JSONObject();
		total = messageService.findCount();
		System.out.println("total:"+total);
		jsonObj.put("total", total);
		
		JsonConfig config = new JsonConfig(); 
		config.registerJsonValueProcessor(Date.class, new DateJsonValueProcessor());  
		List<Message> data = messageService.findAll((page-1)*rows, rows);
		jsonObj.put("rows", JSONArray.fromObject(data,config));
		System.out.println(jsonObj);
		return jsonObj;
	}
	
	/*
	 *  获取最新几条短消息(接收、发送)
	 */
	@ResponseBody
	@RequestMapping(value="/getRecentMessage")
	public JSONArray getRecentMessage(@RequestParam int limit){
		List<Message> messageList = messageService.getRecentMessage(limit);
		return JSONArray.fromObject(messageList);
	}
	
}
