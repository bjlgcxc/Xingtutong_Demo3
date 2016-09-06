package com.springmvc.dao;

import java.math.BigInteger;
import java.util.Date;
import java.util.List;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Repository;
import com.springmvc.entity.EphemerisData;


@SuppressWarnings("unchecked")
@Repository
public class EphemerisDataDao {

	@Autowired
	HibernateTemplate hibernateTemplate;
	@Autowired
	SessionFactory sessionFactory;
	
	public List<EphemerisData> findAll(long page,long row){
		Session session = sessionFactory.openSession();
		SQLQuery query = session.createSQLQuery("select * from ephemerisdata order by id desc limit ?,?");
		query.setLong(0, page);
		query.setLong(1, row);
		query.addEntity(EphemerisData.class);
		List<EphemerisData> result = query.list();
		session.close();
		
		return result;
	}
	
	public long findCount(){
		Session session = sessionFactory.openSession();
		SQLQuery query = session.createSQLQuery("select count(*) from ephemerisdata");
		List<BigInteger> result = query.list();
		session.close();
		if(result.size()!=0)
			return result.get(0).longValue();
		else
			return 0;
	}
	
	public List<EphemerisData> findEphemerisData(Double ax, Double bx,Double ay,Double by,Date m){
		String hql = "from EphemerisData ed where ed.xx<? and ed.xx>? and ed.yy<? and ed.yy>? and ed.Epoch=?";
		Object[] args = new Object[]{ax,bx,ay,by,m};
		return (List<EphemerisData>) hibernateTemplate.find(hql,args);
	}
	
	public Date findMinTime(Date date){
		Session session = sessionFactory.openSession();
		SQLQuery query = session.createSQLQuery("select min(Epoch) from ephemerisdata where Epoch>?");
		query.setTimestamp(0, date);
		List<Date> result = query.list();
		session.close();
		if(result.size()!=0)
			return result.get(0);
		else
			return null;
	}
	
	public List<EphemerisData> findEphemerisByDate(Date date){
		String hql = "from EphemerisData ed where ed.Epoch=?";
		return (List<EphemerisData>) hibernateTemplate.find(hql,date);
	}
	
	public void simulateEphemerisReceive(int number){
		//1.response
		Session session = hibernateTemplate.getSessionFactory().openSession();
    	SQLQuery query = session.createSQLQuery("select * from ephemerisdata order by rand() limit ?");
    	query.addEntity(EphemerisData.class);
    	query.setParameter(0, number);
    	List<EphemerisData> dataList = query.list();
		session.close();
		
		EphemerisData copyData = new EphemerisData();
		Date date = new Date(System.currentTimeMillis());
		for(EphemerisData data:dataList){
			data.setID(null);
			data.setEpoch(date);
			BeanUtils.copyProperties(data,copyData);
	    	hibernateTemplate.save(copyData);
		}
	}
	
}
