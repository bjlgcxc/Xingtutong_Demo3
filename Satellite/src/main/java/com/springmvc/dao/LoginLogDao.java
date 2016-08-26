package com.springmvc.dao;

import java.util.List;

import com.springmvc.entity.LoginLog;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class LoginLogDao{
	
	@Autowired
	HibernateTemplate hibernateTemplate;
	
	public void save(LoginLog loginLog){
		hibernateTemplate.save(loginLog);
	}
	
	@SuppressWarnings("unchecked")
	public LoginLog find(int userId){
		String hql = " from LoginLog l where l.user.userId=?";
		Object[] args = new Object[]{userId};
		List<LoginLog> result = (List<LoginLog>) hibernateTemplate.find(hql,args);
		if(result.size()!=0){
			return result.get(0);
		}
		else{
			return null;
		}
	}
	
}