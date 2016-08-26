package com.springmvc.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Repository;
import com.springmvc.entity.BdDescribe;

@Repository
public class BdDescribeDao {

	@Autowired
	HibernateTemplate hibernateTemplate;
	
	public BdDescribe get(long id){
		return hibernateTemplate.get(BdDescribe.class, id);
	} 
	
}
