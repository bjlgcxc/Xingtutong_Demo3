package com.springmvc.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.springmvc.dao.DataLogDao;
import com.springmvc.entity.DataLog;

@Service
public class DataLogService {
	
	@Autowired
	DataLogDao dataLogDao;
	
	public void saveDataLog(DataLog dataLog){
		dataLogDao.save(dataLog);
	}
	
	public List<DataLog> findDataLog(int limit){
		return dataLogDao.find(limit);
	}
	
	public List<DataLog> findPage(long page,long row){
		return dataLogDao.findPage(page, row);
	}

	public long findCount(){
		return dataLogDao.findCount();
	}
}
