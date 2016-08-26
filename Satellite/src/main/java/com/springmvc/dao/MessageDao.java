package com.springmvc.dao;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Repository;
import com.springmvc.entity.Message;

@Repository
@SuppressWarnings("unchecked")
public class MessageDao {
	
	@Autowired
	HibernateTemplate hibernateTemplate;
	
	public void save(Message message){
		hibernateTemplate.save(message);
	}
	
	public List<Message> findAll(){
		return (List<Message>) hibernateTemplate.find(" from Message");
	}
	
}
