package com.springmvc.dao;

import java.math.BigInteger;
import java.util.List;

import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Repository;
import com.springmvc.entity.DataLog;

@Repository
@SuppressWarnings("unchecked")
public class DataLogDao {

	@Autowired
	HibernateTemplate hibernateTemplate;
	@Autowired
	SessionFactory sessionFactory;
	
	public void save(DataLog dataLog){
		hibernateTemplate.save(dataLog);
	}
	
	public List<DataLog> find(int limit){
		Session session = sessionFactory.openSession();
		SQLQuery query = session.createSQLQuery("select * from DataLog order by time desc limit ?");
		query.setLong(0, limit);
		query.addEntity(DataLog.class);
		List<DataLog> result = query.list();
		session.close();
		return result;
	}
	
	public long findCount(){
		Session session = sessionFactory.openSession();
		SQLQuery query = session.createSQLQuery("select count(*) from DataLog");
		List<BigInteger> result = query.list();
		session.close();
		if(result.size()!=0)
			return result.get(0).longValue();
		else
			return 0;
	}
	
	public List<DataLog> findPage(long page,long row){
		Session session = sessionFactory.openSession();
		SQLQuery query = session.createSQLQuery("select * from DataLog order by time desc limit ?,?");
		query.setLong(0, page);
		query.setLong(1, row);
		query.addEntity(DataLog.class);
		List<DataLog> result = query.list();
		session.close();
		return result;
	}
	
}
