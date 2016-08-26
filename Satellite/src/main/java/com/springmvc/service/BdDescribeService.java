package com.springmvc.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.springmvc.dao.BdDescribeDao;
import com.springmvc.entity.BdDescribe;

@Service
public class BdDescribeService {
	
	@Autowired
	BdDescribeDao bdDescribeDao;
	
	public BdDescribe getBdDescribe(long id){
		return bdDescribeDao.get(id);
	}
	
}
