//package com.springmvc.web;
//
//import java.text.SimpleDateFormat;
//import java.util.Date;
//import java.util.List;
//import java.util.Random;
//import org.hibernate.SQLQuery;
//import org.hibernate.Session;
//import org.hibernate.SessionFactory;
//import org.springframework.beans.BeanUtils;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.orm.hibernate3.HibernateTemplate;
//import org.springframework.scheduling.annotation.Scheduled;
//import org.springframework.stereotype.Controller;
//import com.springmvc.entity.BeidouData;
//import com.springmvc.entity.DataLog;
//import com.springmvc.entity.EphemerisData;
//import com.springmvc.service.DataLogService;
//
//@Controller
//@SuppressWarnings("unchecked")
//public class SimulateController {
//	
//	@Autowired
//	DataLogService dataLogService;
//	@Autowired
//	HibernateTemplate hibernateTemplate;
//	@Autowired
//	SessionFactory sessionFactory;
//	
//    @Scheduled(cron="*/5 * * * * *") 
//    public void dataRequest(){
//    	Date date = new Date(System.currentTimeMillis());
//    	SimpleDateFormat formater = new SimpleDateFormat("yyyyMMdd");
//    	String reqCode = "10000" +  formater.format(date) + "15336";
//    	
//    	//1.request data
//    	request(reqCode);
//    	//2.save log
//    	DataLog dataLog = new DataLog();
//    	dataLog.setType(1);
//    	dataLog.setReqCode(reqCode);
//    	formater = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS"); 
//    	dataLog.setTime(formater.format(date));
//    	
//    	dataLogService.saveDataLog(dataLog);
//    }
//    
//    
//    public void request(String reqCode){
//    	response(reqCode);
//    }
//    
//    
//	public void response(String reqCode){
//		//1.response
//		Random random = new Random();
//		Session session = sessionFactory.openSession();
//    	SQLQuery query = session.createSQLQuery("select * from beidouData order by rand() limit ?");
//    	query.addEntity(BeidouData.class);
//    	query.setParameter(0, 2 + random.nextInt(4));
//    	List<BeidouData> dataList = query.list();
//		session.close();
//		
//		EphemerisData copyData = new EphemerisData();
//		Date date = new Date(System.currentTimeMillis());
//		for(BeidouData data:dataList){
//			data.setEpoch(date);
//			BeanUtils.copyProperties(data,copyData);
//	    	hibernateTemplate.save(copyData);
//		}
//    	  
//    	//2.save log
//    	DataLog dataLog = new DataLog();
//    	dataLog.setType(2);
//    	dataLog.setReqCode(reqCode);
//    	date = new Date(System.currentTimeMillis());
//    	SimpleDateFormat formater = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS"); 
//    	dataLog.setTime(formater.format(date));
//    	dataLog.setDataSize(20 * dataList.size() + "bytes");
//    	dataLogService.saveDataLog(dataLog);
//    }
//    
//}
