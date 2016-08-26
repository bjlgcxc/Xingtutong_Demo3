package com.springmvc.service;

import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.springmvc.dao.EphemerisDataDao;
import com.springmvc.entity.EphemerisData;

@Service
public class EphemerisDataService {
	
	@Autowired
	EphemerisDataDao ephemerisDataDao;
	
	public List<EphemerisData> findAll(long page,long row){
		return ephemerisDataDao.findAll(page, row);
	}

	public long findCount(){
		return ephemerisDataDao.findCount();
	}
	
	public List<EphemerisData> findEphemerisData(Double ax, Double bx,Double ay,Double by,Date m){
		return ephemerisDataDao.findEphemerisData(ax, bx, ay, by, m);
	}
	
	public Date findMinTime(Date date){
		return ephemerisDataDao.findMinTime(date);
	}
	
	public List<EphemerisData> findEphemerisByDate(Date date){
		return ephemerisDataDao.findEphemerisByDate(date);
	}
	
}
