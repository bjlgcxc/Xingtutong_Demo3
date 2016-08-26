package com.springmvc.web;

import java.util.List;
import net.sf.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.springmvc.entity.DataLog;
import com.springmvc.service.DataLogService;

@Controller
@RequestMapping(value="/datalog")
public class DataLogController {
	
	@Autowired
	DataLogService dataLogService;
	
	
	/*
	 * 获取卫星数据接收日志
	 */
	@ResponseBody
	@RequestMapping(value="/getDataLog")
	public JSONArray getDataLog(){
		List<DataLog> dataLogList = dataLogService.findAllDataLog();
		return JSONArray.fromObject(dataLogList);
	}
	
	
	/*
	 * 保存卫星数据接收日志
	 */
	@ResponseBody
	@RequestMapping(value="/saveDataLog",method=RequestMethod.POST)
	public void saveDataLog(DataLog dataLog){
		dataLogService.saveDataLog(dataLog);
	}	
	
}
