package com.springmvc.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Repository;
import com.springmvc.entity.DataLog;

@Repository
@SuppressWarnings("unchecked")
public class DataLogDao {

	@Autowired
	HibernateTemplate hibernateTemplate;
	
	public void save(DataLog dataLog){
		hibernateTemplate.save(dataLog);
	}
	
	public List<DataLog> find(int limit){
		String hql = " from DataLog d limit ?";
		return (List<DataLog>) hibernateTemplate.find(hql,new Object[]{limit});
	}
	
	public List<DataLog> findAll(){
		return (List<DataLog>) hibernateTemplate.find("from DataLog");
	}
	
}
