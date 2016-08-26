package com.springmvc.dao;

import java.util.List;
import com.springmvc.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Repository;

@SuppressWarnings("unchecked")

@Repository
public class UserDao {
	
	@Autowired
	HibernateTemplate hibernateTemplate;

	
	public void save(User user){
		hibernateTemplate.save(user);
	}

	public User findByUserName(String userName){
		String hql = "from User u where u.userName=?";
		List<User> users = (List<User>) hibernateTemplate.find(hql,userName);
        if (users.size() == 0) {
            return null;
        }else{
            return users.get(0);
        }
    }
	
	public void update(User user){
		hibernateTemplate.update(user);
	}
	
}


