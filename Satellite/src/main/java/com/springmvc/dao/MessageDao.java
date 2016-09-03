package com.springmvc.dao;

import java.math.BigInteger;
import java.util.List;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Repository;

import com.springmvc.entity.Message;

@Repository
@SuppressWarnings("unchecked")
public class MessageDao {
	
	@Autowired
	HibernateTemplate hibernateTemplate;
	@Autowired
	SessionFactory sessionFactory;
	
	public void save(Message message){
		hibernateTemplate.save(message);
	}
	
	public List<Message> findAll(){
		return (List<Message>) hibernateTemplate.find(" from Message");
	}
	
	public List<Message> findSome(int limit){
		Session session = sessionFactory.openSession();
    	SQLQuery query = session.createSQLQuery("select * from t_message order by time desc limit ?");
    	query.addEntity(Message.class);
    	query.setParameter(0,limit);
    	List<Message> messageList = query.list();
		session.close();
		return messageList;
	}
	
	public List<Message> findAll(long page,long row){
		Session session = sessionFactory.openSession();
		SQLQuery query = session.createSQLQuery("select * from t_message order by time desc limit ?,?");
		query.setLong(0, page);
		query.setLong(1, row);
		query.addEntity(Message.class);
		List<Message> messageList = query.list();
		session.close();
		
		return messageList;
	}
	
	public long findCount(){
		Session session = sessionFactory.openSession();
		SQLQuery query = session.createSQLQuery("select count(*) from t_message");
		List<BigInteger> result = query.list();
		session.close();
		if(result.size()!=0)
			return result.get(0).longValue();
		else
			return 0;
	}
}
