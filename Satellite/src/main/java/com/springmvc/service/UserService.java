package com.springmvc.service;

import com.springmvc.dao.LoginLogDao;
import com.springmvc.dao.UserDao;
import com.springmvc.entity.LoginLog;
import com.springmvc.entity.User;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserService {

	@Autowired
	UserDao userDao;
	@Autowired
	LoginLogDao loginLogDao;
	
	
	//user
    public void saveUserInfo(User user){
	    userDao.save(user);
	}
    public User findByUserName(String userName) {
        return userDao.findByUserName(userName);
    }
    public void updateUserInfo(User user){
    	userDao.update(user);
    }
    
    
    //loginLog
    public void saveLoginLog(User user) {
        LoginLog loginLog = new LoginLog();
        loginLog.setUser(user);
        loginLog.setIp(user.getLastIp());
        loginLog.setLoginTime(user.getLastVisit());
        loginLogDao.save(loginLog);
    }
    
}
