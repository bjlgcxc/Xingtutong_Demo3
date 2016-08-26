package com.springmvc.web;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URL;
import javax.servlet.http.HttpServletRequest;
import net.sf.json.JSONArray;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.springmvc.utils.CZMLSpider;

@Controller
@RequestMapping(value="/CZML")
public class CZMLController {
	
	public static final Log log = LogFactory.getLog(CZMLController.class);
	
	
	/*
	 * 调用外部接口获取czml格式的数据	
	 * http://www.orbitalpredictor.com/api/predict_orbit/
	 */
	@ResponseBody
    @RequestMapping(value="/getCzmlDataSource",method=RequestMethod.GET)
	public JSONArray getCzmlDataSource(HttpServletRequest request) throws IOException{
		
		String queryString = request.getQueryString();
		URL url = new URL("http://www.orbitalpredictor.com/api/predict_orbit/?" + queryString);
		
		//获取数据
		log.info("begin fetching data from " + url);
		String czmlData = CZMLSpider.getCZMLData(url);
		log.info("fetch data successfully");
		
		//缓存数据
		if(czmlData!=null){
			String webPath = request.getServletContext().getRealPath("/");
			PrintWriter pw = new PrintWriter(new FileWriter(new File(webPath + "/data/OrbitData.txt")),true);
			pw.write(czmlData.toCharArray());
			pw.close();
		}
		log.info("save orbit data to cache file");
		
		return JSONArray.fromObject(czmlData);
	}
	
}
