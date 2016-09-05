package com.springmvc.web;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.springmvc.entity.DataLog;
import com.springmvc.service.DataLogService;
import com.springmvc.utils.DateJsonValueProcessor;
import com.springmvc.utils.MyWebSocketHandler;

@Controller
@RequestMapping(value="/datalog")
public class DataLogController {
	
	@Autowired
	DataLogService dataLogService;
	@Autowired
	MyWebSocketHandler websocket;

	
	/*
	 * 获取卫星数据日志(分页)
	 */
	@ResponseBody
	@RequestMapping(value="/getDataLog",method = RequestMethod.GET)
	public JSONObject getDataLog(@RequestParam long rows,@RequestParam long page){
		Long total = 0L;
		JSONObject jsonObj = new JSONObject();
		total = dataLogService.findCount();
		jsonObj.put("total", total);
		System.out.println( rows + "," + page + "," + total);
		JsonConfig config = new JsonConfig(); 
		config.registerJsonValueProcessor(Date.class, new DateJsonValueProcessor());  
		List<DataLog> data = dataLogService.findPage((page-1)*rows, rows);
		System.out.println(data);
		jsonObj.put("rows", JSONArray.fromObject(data,config));
		return jsonObj;
	}
	
	
	/*
	 * 获取最新的卫星数据日志
	 */
	@ResponseBody
	@RequestMapping(value="/getRecentDataLog",method=RequestMethod.GET)
	public JSONArray getRecentDataLog(){
		List<DataLog> dataLogList = dataLogService.findDataLog(20);
		return JSONArray.fromObject(dataLogList);
	}
	
	
	/*
	 * 保存卫星数据接收日志
	 */
	@RequestMapping(value="/saveDataLog",method=RequestMethod.POST)
	public String saveDataLog(HttpServletRequest request,DataLog dataLog) throws IOException{
		dataLogService.saveDataLog(dataLog);
		//inform 
		websocket.sendMessage();
		
		//simulate
		String size = dataLog.getDataSize();
		if(size.length()==0)
			return null;
		
		int i = 0;
		while(size.charAt(i)>='0' && size.charAt(i)<='9'){
			i++;
		}
		int number = Integer.parseInt(size.substring(0, i));
		return "redirect:/Data/simulateReceive?number=" + number;
	}	
	
}
