package com.springmvc.web;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.springmvc.entity.BdDescribe;
import com.springmvc.entity.EphemerisData;
import com.springmvc.service.BdDescribeService;
import com.springmvc.service.EphemerisDataService;
import com.springmvc.utils.DateJsonValueProcessor;
import com.springmvc.utils.MyWebSocketHandler;

@Controller
@RequestMapping("/Data")
public class BdDataController {
	
	@Autowired
	BdDescribeService bdDescribeService;
	@Autowired
	EphemerisDataService ephemerisDataService;
	@Autowired
	MyWebSocketHandler websocket;
	
	
	/*
	 * 获取卫星描述信息
	 */
	@ResponseBody
	@RequestMapping(value="/Sel/{id}/getBdDescription",method=RequestMethod.GET)
	public String getSelDesciption(@PathVariable String id) throws ParseException{
		int n = 0;
		String item;
		String[] temp = id.split(",");
		String description = "999";
		Date mt = new Date();
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");

		Double ax = Double.valueOf(temp[0]);
		Double bx = Double.valueOf(temp[1]);
		Double ay = Double.valueOf(temp[2]);
		Double by = Double.valueOf(temp[3]);
		String[] a = { "0", "M1", "G1", "G2", "G3", "IGSO1", "G4", "IGSO2",
				"IGSO3", "IGSO4", "IGSO5", "G5", "M2", "M3", "M4", "M5", "G6",
				"IGSO6", "M6", "M7", "IGSO7", "M8" };
		
		item = temp[4];
		if (!item.equals("0000")) {
			mt = format.parse(item);
			List<EphemerisData> dataList = ephemerisDataService.findEphemerisData(ax, bx,ay, by, mt);
			if (dataList.size() != 0) {
				n = Integer.parseInt(dataList.get(0).getSatellitenumber());
				BdDescribe bdDescribe = bdDescribeService.getBdDescribe(n);
				description = bdDescribe.getDescription() + "," + a[n];
			}
		}

		return description;
	}

	
	/*
	 * 获取轨道信息
	 */
	@ResponseBody
	@RequestMapping(value = "/MaxTime/{id}/getMaxTime",method = RequestMethod.GET)
	public String getMaxtime(@PathVariable String id) throws ParseException{
		Date mt=new Date();
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");
		SimpleDateFormat xsf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		mt = format.parse("1998010100000000");
		if (!id.equals("0000")){
			mt = format.parse(id);
		}
		Date time = ephemerisDataService.findMinTime(mt);

		String rt="";
		Double rx=0D;
		Double ry=0D;
	    if (time==null){
	    	 mt=format.parse("1998010100000000");
	    	 time = ephemerisDataService.findMinTime(mt);
	    }
	    List<EphemerisData> dataList = ephemerisDataService.findEphemerisByDate(time);
	    if (dataList.size()==0){
	    	 mt=format.parse("1998010100000000");
	    	 time = ephemerisDataService.findMinTime(mt);
	    	 dataList = ephemerisDataService.findEphemerisByDate(time);
	    }
	     
        String s = format.format(time);
        String xs = "当前历元："+ xsf.format(time);
        String bw;
        String [] a = {"0","M1","G1","G2","G3","IGSO1","G4","IGSO2","IGSO3","IGSO4","IGSO5","G5","M2","M3","M4","M5","G6","IGSO6","M6","M7","IGSO7","M8"};
        int j;
        rt = s+","+xs+","+s+","+s+",";
      
        for (int i = 0; i < dataList.size(); i++) {
    	   rx = dataList.get(i).getXx();
    	   ry = dataList.get(i).getYy();
    	   bw = dataList.get(i).getBw();
    	   j = Integer.parseInt(dataList.get(i).getSatellitenumber());
    	   rt = rt + rx+","+ry+","+bw+","+a[j]+",";
        }
        return rt; 
	}

	
	/*
	 * 模拟轨道信息获取接收
	 */
	@RequestMapping(value = "/simulateReceive",method = RequestMethod.GET)
	public void simulateEphemerisReceive(HttpServletRequest request) throws IOException{
		int number = Integer.parseInt(request.getParameter("number"));
		ephemerisDataService.simulateEphemerisReceive(number);
		
		//inform 
		websocket.sendMessage();
	}
	

	/*
	 * 获取轨道信息列表
	 */
	@ResponseBody
	@RequestMapping(value="/EpList/getEphemerisList",method = RequestMethod.GET)
	public JSONObject getEphemerisList(@RequestParam long rows,@RequestParam long page){
		Long total = 0L;
		JSONObject jsonObj = new JSONObject();
		total = ephemerisDataService.findCount();
		jsonObj.put("total", total);
		
		JsonConfig config = new JsonConfig(); 
		config.registerJsonValueProcessor(Date.class, new DateJsonValueProcessor());  
		List<EphemerisData> data = ephemerisDataService.findAll((page-1)*rows, rows);
		jsonObj.put("rows", JSONArray.fromObject(data,config));
		return jsonObj;
	}

}
