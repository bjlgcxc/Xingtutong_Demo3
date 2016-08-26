package com.springmvc.web;

import java.io.IOException;
import java.net.URLDecoder;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.springmvc.entity.Message;
import com.springmvc.service.MessageService;
import com.springmvc.utils.HttpUtils;
import com.springmvc.utils.MyWebSocketHandler;

@Controller
@RequestMapping(value="/message")
public class MessageController {
	
	public static final Log log = LogFactory.getLog(MessageController.class);
	public static String url = "";   //指挥机发送消息的接口
	public static String ICID = "";  //指挥机ID
	
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
		try{
			int res = HttpUtils.doPost(url + "/sayHello",json);
			if(res==1){
				json.put("ok",true);
				json.put("errorMsg", "");
				log.info("get valid url for message sending");
			}
			else{
				json.put("ok", false);
				json.put("errorMsg",URLDecoder.decode("连接指挥机服务器失败","utf-8"));
			}
		}
		catch(Exception e){
			json.put("ok", false);
			json.put("errorMsg", URLDecoder.decode("连接指挥机服务器失败","utf-8"));
		}
		
		return json;
	}
	
	
	/*
	 * 指挥机连接断开
	 */
	@ResponseBody
	@RequestMapping(value="/disConnect")
	public void disConnect(){
		ICID = "";
		log.info("断开指挥机的连接");
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
		messageService.saveMessage(messageList);
		log.info("receive message from " + messageList.get(0).getFrom() + ",message：" + messageList.get(0).getContent());
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
	public JSONObject sendMessage(Message message,HttpServletRequest request) throws IOException{
		
		JSONObject msg = new JSONObject();
		
		if(ICID.equals("")){
			msg.put("ok", false);
			msg.put("errorMsg", "指挥机未连接");
		}
		else{
			message.setType(1);
			message.setFrom(ICID);
			message.setTime(System.currentTimeMillis());
			message.setContent(URLDecoder.decode(message.getContent(),"utf-8"));
			
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("targetID",message.getTo());
			jsonObj.put("message",message.getContent());	
			try{
				//send
				int res = HttpUtils.doPost(url + "/sendMessage",jsonObj);
				//save
				if(res == 1){
					messageService.saveMessage(message);
					msg.put("ok", true);
					log.info("send message to " + ICID + ",message：" + message.getContent());
				}
				else{
					msg.put("ok",false);
					msg.put("errorMsg", "指挥机连接超时");
				}
			}
			catch(Exception e){
				msg.put("ok",false);
				msg.put("errorMsg", "指挥机连接超时");
			}
		}
		
		return msg;
	}
	
	
	/*
	 *  获取所有的短消息(接收、发送)
	 */
	@ResponseBody
	@RequestMapping(value="/getAllMessage")
	public JSONArray getMessage(){
		List<Message> messageList = messageService.getAllMessage();
		return JSONArray.fromObject(messageList);
	}

}
